Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] bnep: Refactor bnep_if_up() returning -errno
Date: Fri, 17 Oct 2014 15:54:07 +0300
Message-Id: <1413550450-16577-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1413550450-16577-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1413550450-16577-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Some functions are using bnep_if_up() like bnep_server_add() referring
directly to errno which may be overwritten already.
---
 profiles/network/bnep.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index e17a130..3a6e3a4 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -195,7 +195,7 @@ static int bnep_connadd(int sk, uint16_t role, char *dev)
 static int bnep_if_up(const char *devname)
 {
 	struct ifreq ifr;
-	int sk, err;
+	int sk, err = 0;
 
 	sk = socket(AF_INET, SOCK_DGRAM, 0);
 
@@ -205,16 +205,15 @@ static int bnep_if_up(const char *devname)
 	ifr.ifr_flags |= IFF_UP;
 	ifr.ifr_flags |= IFF_MULTICAST;
 
-	err = ioctl(sk, SIOCSIFFLAGS, (void *) &ifr);
+	if (ioctl(sk, SIOCSIFFLAGS, (void *) &ifr) < 0) {
+		err = -errno;
+		error("bnep: Could not bring up %s: %s(%d)",
+				devname, strerror(-err), -err);
+	}
 
 	close(sk);
 
-	if (err < 0) {
-		error("bnep: Could not bring up %s", devname);
-		return err;
-	}
-
-	return 0;
+	return err;
 }
 
 static int bnep_if_down(const char *devname)
-- 
1.9.1

