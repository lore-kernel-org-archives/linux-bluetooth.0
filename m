Return-Path: <cyrus@holtmann.org>
From: Vishal Agarwal <vishal.agarwal@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <naresh.gupta@stericsson.com>,
	Vishal Agarwal <vishal.agarwal@stericsson.com>
Subject: [PATCH] Bluetooth: Link Keys should be stored if MITM is not required
Date: Tue, 3 Apr 2012 14:49:54 +0530
Message-ID: <1333444794-27148-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If MITM protection is not required then except for Debug Keys, all
link keys should be persistent. And they should be stored for future
use.

Change-Id: Id438d424b999e9a30f29193d02ac266bee5f672b
Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
---
 net/bluetooth/hci_core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c5ee97c..bcb68dd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1246,6 +1246,10 @@ static int hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
 	if (conn->remote_auth == 0x02 || conn->remote_auth == 0x03)
 		return 1;
 
+	/* If MITM is not required then store the Link Key */
+	if (!(conn->auth_type & 0x01))
+		return 1;
+
 	/* If none of the above criteria match, then don't store the key
 	 * persistently */
 	return 0;
-- 
1.7.0.4

