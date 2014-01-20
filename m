Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH SBC 2/2] sbc: Add sbc_init_a2dp to sbc.sym
Date: Mon, 20 Jan 2014 11:31:43 +0200
Message-Id: <1390210303-22692-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1390210303-22692-1-git-send-email-luiz.dentz@gmail.com>
References: <1390210303-22692-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 sbc/sbc.sym | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sbc/sbc.sym b/sbc/sbc.sym
index 3a0c6bf..0c23a05 100644
--- a/sbc/sbc.sym
+++ b/sbc/sbc.sym
@@ -19,3 +19,7 @@ SBC_1.1 {
 global:
 	sbc_init_msbc;
 } SBC_1.0;
+SBC_1.2 {
+global:
+	sbc_init_a2dp;
+} SBC_1.1;
-- 
1.8.4.2

