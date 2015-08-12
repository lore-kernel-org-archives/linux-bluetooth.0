Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/7] tools/l2test: Fix resource leaks
Date: Wed, 12 Aug 2015 18:07:13 +0300
Message-Id: <1439392033-11822-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1439392033-11822-1-git-send-email-luiz.dentz@gmail.com>
References: <1439392033-11822-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/l2test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/l2test.c b/tools/l2test.c
index 386823f..d4e3ae6 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -592,6 +592,7 @@ static void do_listen(void (*handler)(int sk))
 
 	if (socktype == SOCK_DGRAM) {
 		handler(sk);
+		close(sk);
 		return;
 	}
 
-- 
2.4.3

