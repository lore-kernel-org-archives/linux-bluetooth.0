Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] bnep: trivial: code cleanup
Date: Wed, 22 Oct 2014 14:10:50 +0300
Message-Id: <1413976251-32402-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1413976251-32402-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1413976251-32402-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/network/bnep.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 1024919..4cf38d9 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -133,7 +133,6 @@ const char *bnep_name(uint16_t id)
 int bnep_init(void)
 {
 	ctl = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_BNEP);
-
 	if (ctl < 0) {
 		int err = -errno;
 
@@ -141,7 +140,7 @@ int bnep_init(void)
 			warn("kernel lacks bnep-protocol support");
 		else
 			error("bnep: Failed to open control socket: %s (%d)",
-						strerror(-err), -err);
+							strerror(-err), -err);
 
 		return err;
 	}
@@ -165,7 +164,7 @@ static int bnep_conndel(const bdaddr_t *dst)
 	if (ioctl(ctl, BNEPCONNDEL, &req) < 0) {
 		int err = -errno;
 		error("bnep: Failed to kill connection: %s (%d)",
-						strerror(-err), -err);
+							strerror(-err), -err);
 		return err;
 	}
 	return 0;
@@ -184,7 +183,7 @@ static int bnep_connadd(int sk, uint16_t role, char *dev)
 	if (ioctl(ctl, BNEPCONNADD, &req) < 0) {
 		int err = -errno;
 		error("bnep: Failed to add device %s: %s(%d)",
-				dev, strerror(-err), -err);
+						dev, strerror(-err), -err);
 		return err;
 	}
 
@@ -208,7 +207,7 @@ static int bnep_if_up(const char *devname)
 	if (ioctl(sk, SIOCSIFFLAGS, (void *) &ifr) < 0) {
 		err = -errno;
 		error("bnep: Could not bring up %s: %s(%d)",
-				devname, strerror(-err), -err);
+						devname, strerror(-err), -err);
 	}
 
 	close(sk);
-- 
1.9.1

