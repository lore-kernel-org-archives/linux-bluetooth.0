Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] bnep: Add error print and return errno instead of -1
Date: Wed, 22 Oct 2014 14:10:49 +0300
Message-Id: <1413976251-32402-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/network/bnep.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 927367c..1024919 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -219,7 +219,7 @@ static int bnep_if_up(const char *devname)
 static int bnep_if_down(const char *devname)
 {
 	struct ifreq ifr;
-	int sk, err;
+	int sk, err = 0;
 
 	sk = socket(AF_INET, SOCK_DGRAM, 0);
 
@@ -229,16 +229,15 @@ static int bnep_if_down(const char *devname)
 	ifr.ifr_flags &= ~IFF_UP;
 
 	/* Bring down the interface */
-	err = ioctl(sk, SIOCSIFFLAGS, (void *) &ifr);
+	if (ioctl(sk, SIOCSIFFLAGS, (void *) &ifr) < 0) {
+		err = -errno;
+		error("bnep: Could not bring down %s: %s(%d)",
+				devname, strerror(-err), -err);
+	}
 
 	close(sk);
 
-	if (err < 0) {
-		error("bnep: Could not bring down %s", devname);
-		return err;
-	}
-
-	return 0;
+	return err;
 }
 
 static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
-- 
1.9.1

