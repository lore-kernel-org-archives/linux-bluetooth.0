Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/6] attrib: Fix minor whitespace issue
Date: Tue, 27 May 2014 12:15:29 +0200
Message-Id: <1401185734-23672-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Replace spaces with tabs.
---
 attrib/att.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 068ddf8..c92cd5d 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -86,8 +86,8 @@
 #define ATT_PSM					31
 
 /* Flags for Execute Write Request Operation */
-#define ATT_CANCEL_ALL_PREP_WRITES              0x00
-#define ATT_WRITE_ALL_PREP_WRITES               0x01
+#define ATT_CANCEL_ALL_PREP_WRITES		0x00
+#define ATT_WRITE_ALL_PREP_WRITES		0x01
 
 /* Find Information Response Formats */
 #define ATT_FIND_INFO_RESP_FMT_16BIT		0x01
-- 
1.9.3

