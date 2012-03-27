Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Update management interface revision
Date: Tue, 27 Mar 2012 18:49:02 +0200
Message-Id: <1332866942-6632-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For each kernel release where commands or events are added to the
management interface, the revision field should be increment by one.

The increment should only happen once per kernel release and not
for every command/event that gets added. The revision value is for
informational purposes only, but this simple policy would make any
future debugging a lot simple.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 79b0ae2..5a56e0c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -38,7 +38,7 @@ bool enable_hs;
 bool enable_le;
 
 #define MGMT_VERSION	1
-#define MGMT_REVISION	0
+#define MGMT_REVISION	1
 
 static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_INDEX_LIST,
-- 
1.7.7.6

