Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Cho, Yu-Chen" <acho@suse.com>
To: linux-bluetooth@vger.kernel.org
Cc: acho@suse.com
Subject: [PATCH BlueZ] tool/hcidump: Fix memory leak with malformed packet
Date: Fri, 16 Mar 2018 18:43:34 +0800
Message-Id: <20180316104334.16550-1-acho@suse.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Supported Commands is a 64 octet bit field.
Do not allow to read more then the size.
---
 tools/parser/csr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/parser/csr.c b/tools/parser/csr.c
index a0a4eb5fe..d14830821 100644
--- a/tools/parser/csr.c
+++ b/tools/parser/csr.c
@@ -145,6 +145,11 @@ static inline void commands_dump(int level, char *str, struct frame *frm)
 	unsigned char commands[64];
 	unsigned int i;
 
+	if (frm->len > 64) {
+		perror("Read Error");
+		exit(0);
+	}
+
 	memcpy(commands, frm->ptr, frm->len);
 
 	p_indent(level, frm);
-- 
2.16.2

