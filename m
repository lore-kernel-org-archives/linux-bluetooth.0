Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@nokia.com, padovan@profusion.mobi,
	Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 1/3] Fixed def of ATT_UUID per BT Assigned Numbers
Date: Wed, 16 Feb 2011 13:17:59 -0800
Message-Id: <1297891081-27976-2-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1297891081-27976-1-git-send-email-bgix@codeaurora.org>
References: <1297891081-27976-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sdp.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/sdp.h b/lib/sdp.h
index 16b59fc..e901b2a 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -55,6 +55,7 @@ extern "C" {
 #define TCS_BIN_UUID	0x0005
 #define TCS_AT_UUID	0x0006
 #define OBEX_UUID	0x0008
+#define ATT_UUID	0x0007
 #define IP_UUID		0x0009
 #define FTP_UUID	0x000a
 #define HTTP_UUID	0x000c
@@ -72,7 +73,6 @@ extern "C" {
 #define MCAP_CTRL_UUID	0x001e
 #define MCAP_DATA_UUID	0x001f
 #define L2CAP_UUID	0x0100
-#define ATT_UUID	0x1801
 
 /*
  * Service class identifiers of standard services and service groups
-- 
1.7.1

--
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
