Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <padovan@profusion.mobi>, <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Date: Mon, 2 May 2011 11:19:46 +0300
Subject: RE: [PATCH] Bluetooth: Double check sec req for pre 2.1 device
Message-ID: <99B09243E1A5DA4898CDD8B70011144816F29AF3CC@EXMB04.eu.tieto.com>
References: <1304323758-9668-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1304323758-9668-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 

>+int hci_conn_accept_secure(struct hci_conn *conn, __u8 sec_level) {
>+	BT_DBG("conn %p", conn);
>+
>+	if (sec_level != BT_SECURITY_HIGH)
>+		return 1; /* Accept if non-secure is required */
>+
>+	if (conn->key_type == HCI_LK_AUTH_COMBINATION ||
>+			(conn->key_type == HCI_LK_COMBINATION &&
>+			conn->pin_length == 16))

Checking againt conn->sec_level is tricky. This function is called indirectly by hci_auth_complete_evt which first sets sec_level to pending_sec_level even for pre-2.1 units. Thus, this always will return true while re-authentication of pre-2.1 devices because sec_level is already updated with the pending one. 

I've tried to check, in hci_auth_complete_evt, if we deal with pre-2.1 dev and if a link key already exists and then set sec_level, but the link key in this point always exists.  

Any suggestions how to solve this?  A new flag in conn->pre21_reauth?


Thanks,
Waldek