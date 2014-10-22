Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/3] bnep: Return errno instead of -1 and print error
Date: Wed, 22 Oct 2014 16:34:30 +0300
Message-Id: <1413984870-24023-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1413984870-24023-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <CAMv5Gbck+=b9kY-s+gd3shJsLUDAEZib5dKGM09ZBWkP==ufFw@mail.gmail.com>
 <1413984870-24023-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make code consistent with the rest returning -errno and printing error
message.
---
 profiles/network/bnep.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index d8883d6..09d4b65 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -520,7 +520,7 @@ static int bnep_del_from_bridge(const char *devname, const char *bridge)
 {
 	int ifindex;
 	struct ifreq ifr;
-	int sk, err;
+	int sk, err = 0;
 
 	if (!devname || !bridge)
 		return -EINVAL;
@@ -535,16 +535,16 @@ static int bnep_del_from_bridge(const char *devname, const char *bridge)
 	strncpy(ifr.ifr_name, bridge, IFNAMSIZ - 1);
 	ifr.ifr_ifindex = ifindex;
 
-	err = ioctl(sk, SIOCBRDELIF, &ifr);
+	if (ioctl(sk, SIOCBRDELIF, &ifr) < 0) {
+		err = -errno;
+		error("bnep: Can't delete %s from the bridge %s: %s(%d)",
+					devname, bridge, strerror(-err), -err);
+	} else
+		info("bridge %s: interface %s removed", bridge, devname);
 
 	close(sk);
 
-	if (err < 0)
-		return err;
-
-	info("bridge %s: interface %s removed", bridge, devname);
-
-	return 0;
+	return err;
 }
 
 int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
-- 
1.9.1

