Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/15] AVRCP: Fix crash while listing available settings in TG role
Date: Mon, 10 Jun 2013 13:36:59 +0300
Message-Id: <1370860630-30359-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
References: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Invalid read of size 1
   at 0x41AFD0: attrval_to_val (avrcp.c:492)
   by 0x41B0E1: avrcp_handle_list_player_attributes (avrcp.c:931)
   by 0x41D606: handle_vendordep_pdu (avrcp.c:1620)
   by 0x4185F8: session_cb (avctp.c:985)
   by 0x3F31A47A54: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x3F31A47D87: ??? (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x3F31A48181: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
   by 0x40A2E5: main (main.c:595)
 Address 0x0 is not stack'd, malloc'd or (recently) free'd
---
 profiles/audio/avrcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 491bb92..092639f 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -471,6 +471,9 @@ static int attrval_to_val(uint8_t attr, const char *value)
 {
 	int ret;
 
+	if (value == NULL)
+		return -EINVAL;
+
 	switch (attr) {
 	case AVRCP_ATTRIBUTE_EQUALIZER:
 		if (!strcmp(value, "off"))
-- 
1.8.1.4

