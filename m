Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Don't forget to check for LE_LINK
Date: Wed,  8 Jun 2011 19:10:24 -0300
Message-Id: <1307571024-22442-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1307571024-22442-2-git-send-email-padovan@profusion.mobi>
References: <1307571024-22442-1-git-send-email-padovan@profusion.mobi>
 <1307571024-22442-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Otherwise the wrong error can be returned.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 28d4cf7..a31dc0d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4122,7 +4122,7 @@ static int l2cap_disconn_ind(struct hci_conn *hcon)
 
 	BT_DBG("hcon %p", hcon);
 
-	if (hcon->type != ACL_LINK || !conn)
+	if ((hcon->type != ACL_LINK && hcon->type != LE_LINK) || !conn)
 		return 0x13;
 
 	return conn->disc_reason;
-- 
1.7.5.1

