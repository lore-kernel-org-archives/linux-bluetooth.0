Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 2/2] Add decoding AMP Assoc data in write_remote_amp_assoc
Date: Thu, 19 Jul 2012 12:08:25 +0300
Message-Id: <1342688905-31924-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1342688905-31924-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1342688905-31924-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use amp_assoc_dump in write_remote_amp_assoc HCI command
---
 parser/hci.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/parser/hci.c b/parser/hci.c
index 5b837e9..6ff30e3 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -1657,6 +1657,17 @@ static inline void le_set_scan_enable_dump(int level, struct frame *frm)
 		(cp->filter_dup == 0x00 ? "disabled" : "enabled"));
 }
 
+static inline void write_remote_amp_assoc_cmd_dump(int level, struct frame *frm)
+{
+	write_remote_amp_assoc_cp *cp = frm->ptr;
+
+	p_indent(level, frm);
+	printf("handle 0x%2.2x len_so_far %d remaining_len %d\n", cp->handle,
+				cp->length_so_far, cp->remaining_length);
+
+	amp_assoc_dump(level + 1, cp->fragment, frm->len - 5);
+}
+
 static inline void command_dump(int level, struct frame *frm)
 {
 	hci_command_hdr *hdr = frm->ptr;
@@ -1934,6 +1945,9 @@ static inline void command_dump(int level, struct frame *frm)
 		case OCF_READ_CLOCK:
 			request_clock_dump(level + 1, frm);
 			return;
+		case OCF_WRITE_REMOTE_AMP_ASSOC:
+			write_remote_amp_assoc_cmd_dump(level + 1, frm);
+			return;
 		}
 		break;
 
-- 
1.7.9.5

