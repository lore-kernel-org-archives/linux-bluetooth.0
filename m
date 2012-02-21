Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix parameter list for setting local name
Date: Tue, 21 Feb 2012 08:14:26 +0100
Message-Id: <1329808466-30669-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The parameter list for setting the local name via management interface
was missing the short name parameter.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 1dbadbe..ac59cdd 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -135,6 +135,7 @@ struct mgmt_cp_set_dev_class {
 #define MGMT_OP_SET_LOCAL_NAME		0x000F
 struct mgmt_cp_set_local_name {
 	__u8 name[MGMT_MAX_NAME_LENGTH];
+	__u8 short_name[MGMT_MAX_SHORT_NAME_LENGTH];
 } __packed;
 
 #define MGMT_OP_ADD_UUID		0x0010
-- 
1.7.7.6

