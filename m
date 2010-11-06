Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/6] Bluetooth: Fix not returning proper error in SCO
Date: Sat,  6 Nov 2010 17:44:51 -0400
Message-Id: <1289079891-4795-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1289079891-4795-5-git-send-email-padovan@profusion.mobi>
References: <1289079891-4795-1-git-send-email-padovan@profusion.mobi>
 <1289079891-4795-2-git-send-email-padovan@profusion.mobi>
 <1289079891-4795-3-git-send-email-padovan@profusion.mobi>
 <1289079891-4795-4-git-send-email-padovan@profusion.mobi>
 <1289079891-4795-5-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Return 0 in that situation could lead to errors in the caller.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/sco.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 3d5f009..dc25faa 100644
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

