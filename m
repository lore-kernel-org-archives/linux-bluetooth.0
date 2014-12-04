Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] shared/crypto: Fix resource leak
Date: Thu,  4 Dec 2014 10:50:55 +0200
Message-Id: <1417683055-24584-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fix leaking fd on exit
---
 src/shared/crypto.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index 12ca9a7..7f77674 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -594,6 +594,8 @@ static bool aes_cmac(struct bt_crypto *crypto, uint8_t key[16], uint8_t *msg,
 
 	swap_buf(out, res, 16);
 
+	close(fd);
+
 	return true;
 }
 
-- 
1.9.1

