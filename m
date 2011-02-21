Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH 1/2] Bluetooth: Fix LE conn creation
Date: Mon, 21 Feb 2011 15:09:23 -0300
Message-Id: <4d62aa6e.47f3d80a.5ea1.ffffd98d@mx.google.com>
In-Reply-To: <y>
References: <y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This patch prevents a crash when remote host tries to create a LE
link which already exists. i.e.: call l2test twice passing the
same parameters.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/hci_conn.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a050a69..d401775 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -429,8 +429,9 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 
 	if (type == LE_LINK) {
 		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
-		if (!le)
-			le = hci_conn_add(hdev, LE_LINK, dst);
+		if (le)
+			return NULL;
+		le = hci_conn_add(hdev, LE_LINK, dst);
 		if (!le)
 			return NULL;
 		if (le->state == BT_OPEN)
-- 
1.7.1

