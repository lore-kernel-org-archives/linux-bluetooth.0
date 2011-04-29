Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <padovan@profusion.mobi>
CC: <johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>
Date: Fri, 29 Apr 2011 11:23:50 +0300
Subject: RE: [PATCH v3 5/7] Bluetooth: Double check sec req for pre 2.1
 device
Message-ID: <99B09243E1A5DA4898CDD8B70011144816F29AEE9E@EXMB04.eu.tieto.com>
References: <1303985279-3944-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1303985279-3944-6-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110428180939.GA2302@joana>
In-Reply-To: <20110428180939.GA2302@joana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo, 

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
>I don't like the idea of mix HCI and RFCOMM code, I prefer 
>that you create an hci_accept_secure(conn, d->sec_level) instead.

We could do like this

static int hci_accept_secure(hci_conn *conn, u8 required_sec_level)
{
	if (required_sec_level != BT_SECURITY_HIGH)
		return 1; /* Accept */

	if (conn->sec_level == BT_SECURITY_HIGH)
		return 1;

	return 0;
}


Waldek