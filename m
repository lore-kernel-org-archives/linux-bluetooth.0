Return-Path: <cyrus@holtmann.org>
From: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
Subject: [PATCH 2/5] network: Add helper function to remove an interface from a bridge
Date: Tue, 21 Aug 2012 13:45:52 +0300
Message-Id: <1345545955-13144-3-git-send-email-tomasz.bursztyka@linux.intel.com>
In-Reply-To: <1345545955-13144-1-git-send-email-tomasz.bursztyka@linux.intel.com>
References: <1345545955-13144-1-git-send-email-tomasz.bursztyka@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/network/common.c |   29 +++++++++++++++++++++++++++++
 profiles/network/common.h |    1 +
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/profiles/network/common.c b/profiles/network/common.c
index a223685..da493c1 100644
--- a/profiles/network/common.c
+++ b/profiles/network/common.c
@@ -268,3 +268,32 @@ int bnep_add_to_bridge(const char *devname, const char *bridge)
 
 	return 0;
 }
+
+int bnep_del_from_bridge(const char *devname, const char *bridge)
+{
+	int ifindex = if_nametoindex(devname);
+	struct ifreq ifr;
+	int sk, err;
+
+	if (!devname || !bridge)
+		return -EINVAL;
+
+	sk = socket(AF_INET, SOCK_STREAM, 0);
+	if (sk < 0)
+		return -1;
+
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy(ifr.ifr_name, bridge, IFNAMSIZ - 1);
+	ifr.ifr_ifindex = ifindex;
+
+	err = ioctl(sk, SIOCBRDELIF, &ifr);
+
+	close(sk);
+
+	if (err < 0)
+		return err;
+
+	info("bridge %s: interface %s removed", bridge, devname);
+
+	return 0;
+}
diff --git a/profiles/network/common.h b/profiles/network/common.h
index cb1f08a..62f2f59 100644
--- a/profiles/network/common.h
+++ b/profiles/network/common.h
@@ -35,3 +35,4 @@ int bnep_connadd(int sk, uint16_t role, char *dev);
 int bnep_if_up(const char *devname);
 int bnep_if_down(const char *devname);
 int bnep_add_to_bridge(const char *devname, const char *bridge);
+int bnep_del_from_bridge(const char *devname, const char *bridge);
-- 
1.7.8.6

