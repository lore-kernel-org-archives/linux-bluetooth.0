Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH hcidump] hci: Fix EIR data parsing
Date: Sun, 29 Jul 2012 00:20:13 +0200
Message-Id: <1343514013-8942-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Data passed to ext_inquiry_data_dump are expected to start with length
octet which was consumed by get_u8.
---
 parser/hci.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/parser/hci.c b/parser/hci.c
index 742a1b5..adcdaf7 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -831,16 +831,19 @@ static inline void ext_inquiry_response_dump(int level, struct frame *frm)
 {
 	void *ptr = frm->ptr;
 	uint32_t len = frm->len;
+	uint8_t *data_ptr;
 	uint8_t length;
 
+	data_ptr = frm->ptr;
 	length = get_u8(frm);
 
 	while (length > 0) {
-		ext_inquiry_data_dump(level, frm, frm->ptr);
+		ext_inquiry_data_dump(level, frm, data_ptr);
 
 		frm->ptr += length;
 		frm->len -= length;
 
+		data_ptr = frm->ptr;
 		length = get_u8(frm);
 	}
 
-- 
1.7.10

