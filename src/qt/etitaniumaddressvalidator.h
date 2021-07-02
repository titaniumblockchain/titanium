// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef ETITANIUM_QT_ETITANIUMADDRESSVALIDATOR_H
#define ETITANIUM_QT_ETITANIUMADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class eTitaniumAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit eTitaniumAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

/** eTitanium address widget validator, checks for a valid etitanium address.
 */
class eTitaniumAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit eTitaniumAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

#endif // ETITANIUM_QT_ETITANIUMADDRESSVALIDATOR_H
