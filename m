Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH SBC 2/2] sbc: Add sbc_reinit_a2dp to sbc.sym
Date: Thu, 23 Jan 2014 14:20:24 +0200
Message-Id: <1390479624-5858-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1390479624-5858-1-git-send-email-luiz.dentz@gmail.com>
References: <1390479624-5858-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 sbc/sbc.sym | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sbc/sbc.sym b/sbc/sbc.sym
index 0c23a05..0642a0b 100644
--- a/sbc/sbc.sym
+++ b/sbc/sbc.sym
@@ -22,4 +22,5 @@ global:
 SBC_1.2 {
 global:
 	sbc_init_a2dp;
+	sbc_reinit_a2dp;
 } SBC_1.1;
-- 
1.8.4.2

