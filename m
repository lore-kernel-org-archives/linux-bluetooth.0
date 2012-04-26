Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [BlueZ 11/15] GATT: Add Report Reference Descriptor declaration
Date: Thu, 26 Apr 2012 16:45:41 -0300
Message-Id: <1335469545-1007-11-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1335469545-1007-1-git-send-email-jprvita@openbossa.org>
References: <1335469545-1007-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch adds the Report Reference Descriptor assigned number
declaration defined by the Bluetooth SIG.
---
 attrib/att.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 1e128a7..a74eb5a 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -44,6 +44,7 @@
 #define GATT_CHARAC_FMT_UUID		0x2904
 #define GATT_CHARAC_AGREG_FMT_UUID	0x2905
 #define GATT_CHARAC_VALID_RANGE_UUID	0x2906
+#define GATT_REPORT_REFERENCE		0x2908
 
 /* Attribute Protocol Opcodes */
 #define ATT_OP_ERROR			0x01
-- 
1.7.7.6

