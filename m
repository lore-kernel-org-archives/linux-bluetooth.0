Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] bnep: Add extra debug information for bnep_up
Date: Fri, 10 Oct 2014 10:18:45 +0300
Message-Id: <1412925525-28420-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1448347.mpMmb7OWnU@uw000953>
References: <1448347.mpMmb7OWnU@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adding extra debug information helps to investigate failing cases
Return meaningful error code.
---
 profiles/network/bnep.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 136709d..070c22e 100644
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
+		error("Could not bring up %s: %s(%d)", devname, strerror(-err),
+									-err);
+	}
 
 	close(sk);
 
-	if (err < 0) {
-		error("Could not bring up %s", devname);
-		return err;
-	}
-
-	return 0;
+	return err;
 }
 
 static int bnep_if_down(const char *devname)
-- 
1.9.1

