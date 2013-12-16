Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] avdtp: Remove unneeded local variable
Date: Mon, 16 Dec 2013 10:57:39 +0200
Message-Id: <1387184262-21439-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1387184262-21439-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387184262-21439-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/audio/avdtp.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index f866b39..e12ad9d 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -773,10 +773,9 @@ static int get_send_buffer_size(int sk)
 	socklen_t optlen = sizeof(size);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_SNDBUF, &size, &optlen) < 0) {
-		int err = -errno;
-		error("getsockopt(SO_SNDBUF) failed: %s (%d)", strerror(-err),
-									-err);
-		return err;
+		error("getsockopt(SO_SNDBUF) failed: %s (%d)", strerror(errno),
+									errno);
+		return -errno;
 	}
 
 	/*
@@ -792,10 +791,9 @@ static int set_send_buffer_size(int sk, int size)
 	socklen_t optlen = sizeof(size);
 
 	if (setsockopt(sk, SOL_SOCKET, SO_SNDBUF, &size, optlen) < 0) {
-		int err = -errno;
-		error("setsockopt(SO_SNDBUF) failed: %s (%d)", strerror(-err),
-									-err);
-		return err;
+		error("setsockopt(SO_SNDBUF) failed: %s (%d)", strerror(errno),
+									errno);
+		return -errno;
 	}
 
 	return 0;
-- 
1.8.3.2

