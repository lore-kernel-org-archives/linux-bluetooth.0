Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 1/4] att: Add Find Info Response Format constants
Date: Mon, 20 Aug 2012 14:32:19 -0300
Message-Id: <1345483942-27973-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345483942-27973-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345483942-27973-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds constants declarations for Find Information Response
Format field. The format means that information data constains a list
of 1 or more handles with their 16-bit or 128-bit Bluetooth UUIDs
---
 attrib/att.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 9384be5..a563255 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -96,6 +96,10 @@
 #define ATT_CANCEL_ALL_PREP_WRITES              0x00
 #define ATT_WRITE_ALL_PREP_WRITES               0x01
 
+/* Find Information Response Formats */
+#define ATT_FIND_INFO_RESP_FMT_16BIT		0x01
+#define ATT_FIND_INFO_RESP_FMT_128BIT		0x02
+
 struct att_data_list {
 	uint16_t num;
 	uint16_t len;
-- 
1.7.8.6

