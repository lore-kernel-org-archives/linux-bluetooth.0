Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add MGMT_OP_SET_SCAN_PARAMS to supported commands list
Date: Fri, 11 Oct 2013 14:44:58 -0700
Message-Id: <1381527898-10784-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When adding support for MGMT_OP_SET_SCAN_PARAMS command the addition
to the supported commands list has been forgotten. This is needed
for userspace to detect if the command is supported or not.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index aa59490..338878c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -78,6 +78,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_ADVERTISING,
 	MGMT_OP_SET_BREDR,
 	MGMT_OP_SET_STATIC_ADDRESS,
+	MGMT_OP_SET_SCAN_PARAMS,
 };
 
 static const u16 mgmt_events[] = {
-- 
1.8.3.1

