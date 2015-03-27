Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] android/avrcp-lib: Fix memory leak
Date: Fri, 27 Mar 2015 13:55:33 +0100
Message-Id: <1427460934-20283-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Memory allocated by parse_elements() was never freed.

63 bytes in 6 blocks are definitely lost in loss record 198 of 318
   at 0x4A0645D: malloc (in /usr/lib64/valgrind/
      vgpreload_memcheck-amd64-linux.so)
   by 0x36A7E4EE6E: g_malloc (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x36A7E667B7: g_strndup (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x423BBE: parse_attribute_list.isra.5 (avrcp-lib.c:2445)
   by 0x423CBF: get_element_attributes_rsp (avrcp-lib.c:2474)
   by 0x420B94: session_cb (avctp.c:743)
   by 0x36A7E492A5: g_main_context_dispatch (in /usr/lib64/
      libglib-2.0.so.0.3800.2)
   by 0x36A7E49627: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
   by 0x36A7E49A39: g_main_loop_run (in /usr/lib64/
      libglib-2.0.so.0.3800.2)
   by 0x40AC45: main (main.c:661)
---
 android/avrcp-lib.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 23dea62..eba99ab 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -2457,6 +2457,12 @@ fail:
 	return -EPROTO;
 }
 
+static void free_attribute_list(uint8_t number, char **text)
+{
+	while(number--)
+		g_free(text[number]);
+}
+
 static int parse_elements(struct avrcp_header *pdu, uint8_t *number,
 						uint32_t *attrs, char **text)
 {
@@ -2531,6 +2537,9 @@ done:
 	player->cfm->get_element_attributes(session, err, number, attrs, text,
 							player->user_data);
 
+	if (err == 0)
+		free_attribute_list(number, text);
+
 	return FALSE;
 }
 
@@ -2855,6 +2864,9 @@ done:
 	player->cfm->get_item_attributes(session, err, number, attrs, text,
 							player->user_data);
 
+	if (err == 0)
+		free_attribute_list(number, text);
+
 	return FALSE;
 }
 
-- 
1.9.3

