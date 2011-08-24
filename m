Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Add valid range descriptor uuid
Date: Wed, 24 Aug 2011 10:37:45 +0200
Message-Id: <1314175065-18096-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 3b8c098..d962841 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -43,6 +43,7 @@
 #define GATT_SERVER_CHARAC_CFG_UUID	0x2903
 #define GATT_CHARAC_FMT_UUID		0x2904
 #define GATT_CHARAC_AGREG_FMT_UUID	0x2905
+#define GATT_CHARAC_VALID_RANGE_UUID	0x2906
 
 /* Attribute Protocol Opcodes */
 #define ATT_OP_ERROR			0x01
-- 
1.7.6

