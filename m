Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 1/3] Bluetooth: Use proper command structure in remove_uuid
Date: Fri, 25 Feb 2011 19:05:47 +0100
Message-ID: <1298657149-3091-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The structure used for command was wrong (probably copy-paste mistake).

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 982becd..4543ede 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -613,7 +613,7 @@ failed:
 static int remove_uuid(struct sock *sk, unsigned char *data, u16 len)
 {
 	struct list_head *p, *n;
-	struct mgmt_cp_add_uuid *cp;
+	struct mgmt_cp_remove_uuid *cp;
 	struct hci_dev *hdev;
 	u8 bt_uuid_any[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 	u16 dev_id;
-- 
1.7.0.4
on behalf of ST-Ericsson
