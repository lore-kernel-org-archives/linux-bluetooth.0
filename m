Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/haltest: Zero initialize cmsg buffer
Date: Thu, 21 Nov 2013 16:23:31 +0200
Message-Id: <1385043811-21842-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385043811-21842-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385043811-21842-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/client/if-sock.c b/android/client/if-sock.c
index 2cd06e8..eef9a76 100644
--- a/android/client/if-sock.c
+++ b/android/client/if-sock.c
@@ -130,6 +130,7 @@ static void read_accepted(int fd)
 
 	memset(&msg, 0, sizeof(msg));
 	memset(&iv, 0, sizeof(iv));
+	memset(cmsgbuf, 0, sizeof(cmsgbuf));
 
 	iv.iov_base = &cs;
 	iv.iov_len = sizeof(cs);
-- 
1.8.3.2

