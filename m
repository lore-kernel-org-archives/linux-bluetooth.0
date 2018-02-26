Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH] Bluetooth: Fix data type of appearence
Date: Mon, 26 Feb 2018 12:11:07 +0530
Message-Id: <1519627267-20496-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It should be __le16 instead of __u16 since its part of
mgmt API.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 include/net/bluetooth/mgmt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 72a456b..e7303ee 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -600,7 +600,7 @@ struct mgmt_rp_read_ext_info {
 
 #define MGMT_OP_SET_APPEARANCE		0x0043
 struct mgmt_cp_set_appearance {
-	__u16	appearance;
+	__le16	appearance;
 } __packed;
 #define MGMT_SET_APPEARANCE_SIZE	2
 
-- 
2.7.4

