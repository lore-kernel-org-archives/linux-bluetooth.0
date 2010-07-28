Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 15/16] Add version and supported procedures values
Date: Wed, 28 Jul 2010 10:07:32 +0200
Message-Id: <1280304453-9328-3-git-send-email-sancane@gmail.com>
In-Reply-To: <1280304453-9328-2-git-send-email-sancane@gmail.com>
References: <1280304232-2939-6-git-send-email-santoscadenas@gmail.com>
 <1280304453-9328-1-git-send-email-sancane@gmail.com>
 <1280304453-9328-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/health/mcap.h b/health/mcap.h
index 1c72080..bb05969 100644
--- a/health/mcap.h
+++ b/health/mcap.h
@@ -31,6 +31,11 @@
 extern "C" {
 #endif
 
+#define MCAP_VERSION	0x0100	/* current version 01.00 */
+
+/* bytes to get MCAP Supported Procedures */
+#define MCAP_SUP_PROC	0x06
+
 /* maximum transmission unit for channels */
 #define MCAP_CC_MTU	48
 #define MCAP_DC_MTU	L2CAP_DEFAULT_MTU
-- 
1.6.3.3

