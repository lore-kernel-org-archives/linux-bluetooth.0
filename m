Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] bnep: Fix bnep_add_to_bridge() errno usage
Date: Fri, 17 Oct 2014 15:54:10 +0300
Message-Id: <1413550450-16577-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1413550450-16577-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1413550450-16577-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Avoid errno be overwritten and make code consistent.
---
 profiles/network/bnep.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 18051c3..c40ed69 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -491,7 +491,7 @@ static int bnep_add_to_bridge(const char *devname, const char *bridge)
 {
 	int ifindex;
 	struct ifreq ifr;
-	int sk, err;
+	int sk, err = 0;
 
 	if (!devname || !bridge)
 		return -EINVAL;
@@ -506,16 +506,16 @@ static int bnep_add_to_bridge(const char *devname, const char *bridge)
 	strncpy(ifr.ifr_name, bridge, IFNAMSIZ - 1);
 	ifr.ifr_ifindex = ifindex;
 
-	err = ioctl(sk, SIOCBRADDIF, &ifr);
+	if (ioctl(sk, SIOCBRADDIF, &ifr) < 0) {
+		err = -errno;
+		error("bnep: Can't add %s to the bridge %s: %s(%d)",
+					devname, bridge, strerror(-err), -err);
+	} else
+		info("bridge %s: interface %s added", bridge, devname);
 
 	close(sk);
 
-	if (err < 0)
-		return err;
-
-	info("bridge %s: interface %s added", bridge, devname);
-
-	return 0;
+	return err;
 }
 
 static int bnep_del_from_bridge(const char *devname, const char *bridge)
@@ -561,11 +561,10 @@ int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
 	if (err < 0)
 		return err;
 
-	if (bnep_add_to_bridge(iface, bridge) < 0) {
-		error("bnep: Can't add %s to the bridge %s: %s(%d)",
-					iface, bridge, strerror(errno), errno);
+	err = bnep_add_to_bridge(iface, bridge);
+	if (err < 0) {
 		bnep_conndel(addr);
-		return -errno;
+		return err;
 	}
 
 	return bnep_if_up(iface);
-- 
1.9.1

