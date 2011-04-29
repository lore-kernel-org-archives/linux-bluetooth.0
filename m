Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <johan.hedberg@gmail.com>
CC: <padovan@profusion.mobi>, <linux-bluetooth@vger.kernel.org>
Date: Fri, 29 Apr 2011 11:10:57 +0300
Subject: RE: [PATCH v3 5/7] Bluetooth: Double check sec req for pre 2.1
 device
Message-ID: <99B09243E1A5DA4898CDD8B70011144816F29AEE89@EXMB04.eu.tieto.com>
References: <1303985279-3944-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1303985279-3944-6-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110428181117.GA11610@jh-x301>
In-Reply-To: <20110428181117.GA11610@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan, 

>> +static int rfcomm_accept_secure(struct hci_conn *conn, struct 
>> +rfcomm_dlc *d) {
>> +	BT_DBG("");
>> +
>> +	if (d->sec_level != BT_SECURITY_HIGH)
>> +		return 1; /* Accept */
>> +
>> +	if (conn->key_type == HCI_LK_AUTH_COMBINATION ||
>> +			(conn->key_type == HCI_LK_COMBINATION &&
>> +			conn->pin_length == 16))
>> +		return 1;
>> +
>> +	return 0; /* Reject */
>> +}
>
>If conn->key_type and conn->pin_length are like you want them 
>to be in the second if-statement, shouldn't conn->sec_level 
>already be BT_SECURITY_HIGH?

Yes, but if  service requires BT_SECURITY_MEDIUM we should accept it as well. Thus, we need this first check.

>And if that's the case I guess 
>you don't need a separate function at all: just check for 
>conn->sec_level.

However, we could do like this

if (d->sec_level != BT_SECURITY_HIGH)
	return 1; /* Accept */

If (conn->sec_level == BT_SECURITY_HIGH)
	return 1; /* Accept */

return 0; /* Reject */

... and then perhaps we don't need a new function here.


> Btw, what purpose does d->sec_level serve 
>when we already have conn->sec_level?

d->sec_level is required sec level for the service and conn->sec_level is the level that's already on the link.

/Waldek