Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Definition for hcidump to decode Ext Window Size
Date: Mon, 22 Aug 2011 11:51:43 +0300
Message-Id: <1314003103-31042-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 lib/l2cap.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/l2cap.h b/lib/l2cap.h
index 55fe88b..a40cb6c 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -175,6 +175,7 @@ typedef struct {
 #define L2CAP_CONF_RFC		0x04
 #define L2CAP_CONF_FCS		0x05
 #define L2CAP_CONF_EFS		0x06
+#define L2CAP_CONF_EWS		0x07
 
 #define L2CAP_CONF_MAX_SIZE	22
 
-- 
1.7.4.1

