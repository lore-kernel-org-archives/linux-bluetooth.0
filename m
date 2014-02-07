Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] rctest: Fix memory leak
Date: Fri,  7 Feb 2014 19:28:45 -0300
Message-Id: <1391812125-19594-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1391812125-19594-1-git-send-email-andre.guedes@openbossa.org>
References: <1391812125-19594-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/rctest.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/rctest.c b/tools/rctest.c
index 77fa03c..9281392 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -466,8 +466,11 @@ static void save_mode(int sk)
 	while ((len = read(sk, b, data_size)) > 0) {
 		ret = write(save_fd, b, len);
 		if (ret < 0)
-			return;
+			goto done;
 	}
+
+done:
+	free(b);
 }
 
 static void recv_mode(int sk)
-- 
1.8.5.3

