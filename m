Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/avdtp: Retry send on EAGAIN as well
Date: Fri, 24 Jan 2014 16:56:42 +0200
Message-Id: <1390575403-30860-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1390575403-30860-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390575403-30860-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index 5da1206..1055bc1 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -444,7 +444,7 @@ static gboolean try_send(int sk, void *data, size_t len)
 
 	do {
 		err = send(sk, data, len, 0);
-	} while (err < 0 && errno == EINTR);
+	} while (err < 0 && (errno == EINTR || errno == EAGAIN));
 
 	if (err < 0) {
 		error("send: %s (%d)", strerror(errno), errno);
-- 
1.8.3.2

