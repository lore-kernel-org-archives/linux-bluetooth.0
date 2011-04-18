Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <Waldemar.Rymarkiewicz@tieto.com>,
	<linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>
Date: Mon, 18 Apr 2011 16:19:58 +0300
Subject: RE: [PATCH 3/3] Bluetooth: Ignore key unauthenticated for high
 security
Message-ID: <99B09243E1A5DA4898CDD8B70011144810862583BB@EXMB04.eu.tieto.com>
References: <1302865617-32704-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1302865617-32704-4-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1302865617-32704-4-git-send-email-waldemar.rymarkiewicz@tieto.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 

>Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
>---
> net/bluetooth/hci_event.c |   21 +++++++++++++++++----
> 1 files changed, 17 insertions(+), 4 deletions(-)
>
>diff --git a/net/bluetooth/hci_event.c 
>b/net/bluetooth/hci_event.c index 5c5e614..337da2b 100644
>--- a/net/bluetooth/hci_event.c
>+++ b/net/bluetooth/hci_event.c
>@@ -2044,11 +2044,24 @@ static inline void 
>hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff
> 	}
> 
> 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
>+	if (conn) {
>+		if (key->type == HCI_LK_UNAUTH_COMBINATION &&
>+				conn->auth_type != 0xff &&
>+				(conn->auth_type & 0x01)) {
>+			BT_DBG("%s ignoring unauthenticated 
>key", hdev->name);
>+			goto not_found;
>+		}
> 
>-	if (key->type == HCI_LK_UNAUTH_COMBINATION && conn &&
>-			conn->auth_type != 0xff && 
>(conn->auth_type & 0x01)) {
>-		BT_DBG("%s ignoring unauthenticated key", hdev->name);
>-		goto not_found;
>+		if (key->type == HCI_LK_COMBINATION &&
>+					conn->sec_level == 
>BT_SECURITY_HIGH &&
>+					conn->pin_length < 16) {


That's wrong. I should check it against stored key->pin_len  and  conn->pending_sec_level. 
We are in the middle of authentication so we don't have conn->sec_level set properly yet. The same apply for conn->pin_length.

if (key->type == HCI_LK_COMBINATION && key->pin_len < 16 &&
	conn->pending_sec_level == BT_SECURITY_HIGH) {
			goto not_found;
		}

/Waldek