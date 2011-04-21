Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <padovan@profusion.mobi>
Date: Thu, 21 Apr 2011 12:53:28 +0300
Subject: RE: [PATCH v2 5/6] Bluetooth: Double check sec req for pre 2.1
 device
Message-ID: <99B09243E1A5DA4898CDD8B7001114481086306E56@EXMB04.eu.tieto.com>
References: <1303372461-11848-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1303372461-11848-5-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1303372461-11848-5-git-send-email-waldemar.rymarkiewicz@tieto.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan, 

>+static int rfcomm_accept_secure(struct hci_conn *conn, struct 
>+rfcomm_dlc *d) {
>+	BT_DBG("");
>+
>+	if (d->sec_level != BT_SECURITY_HIGH)
>+		return 1; /* Accept */
>+
>+	if (conn->key_type == HCI_LK_AUTH_COMBINATION ||
>+			(conn->key_type == HCI_LK_COMBINATION &&
>+			conn->pin_length == 16))
>+		return 1;
>+
>+	return 0; /* Reject */
>+}
>+

I don't know what's your approach to changing hciops behaviour, but I can guess we should not change it.
If it so, I would add

>+static int rfcomm_accept_secure(struct hci_conn *conn, struct 
>+rfcomm_dlc *d) {
>+	BT_DBG("");
>+
	/* Secure link is not supported in non mgmtops */
	if (!test_bit(HCI_MGMT, &hdev->flags))
		return 1;

>+	if (d->sec_level != BT_SECURITY_HIGH)
>+		return 1; /* Accept */
...

This way SECURITY_HIGH  for hciops will behave as it's now (pin code less then 16 digit will be accepted). 

Do you agree?

/Waldek