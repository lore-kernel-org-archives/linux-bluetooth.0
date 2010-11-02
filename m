Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Fix not returning proper error in SCO
Date: Tue,  2 Nov 2010 15:03:17 +0000
Message-Id: <1288710198-6108-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1288710198-6108-5-git-send-email-padovan@profusion.mobi>
References: <1288710198-6108-1-git-send-email-padovan@profusion.mobi>
 <1288710198-6108-2-git-send-email-padovan@profusion.mobi>
 <1288710198-6108-3-git-send-email-padovan@profusion.mobi>
 <1288710198-6108-4-git-send-email-padovan@profusion.mobi>
 <1288710198-6108-5-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Return 0 in that situation could lead to errors in the caller.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/sco.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 85b5498..f031b62 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -880,7 +880,7 @@ static int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 type)
 	int lm = 0;
 
 	if (type != SCO_LINK && type != ESCO_LINK)
-		return 0;
+		return -EINVAL;
 
 	BT_DBG("hdev %s, bdaddr %s", hdev->name, batostr(bdaddr));
 
@@ -906,7 +906,7 @@ static int sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 	BT_DBG("hcon %p bdaddr %s status %d", hcon, batostr(&hcon->dst), status);
 
 	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
-		return 0;
+		return -EINVAL;
 
 	if (!status) {
 		struct sco_conn *conn;
@@ -925,7 +925,7 @@ static int sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
 	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
-		return 0;
+		return -EINVAL;
 
 	sco_conn_del(hcon, bt_err(reason));
 
-- 
1.7.3.1

