Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] bnep: Calculate ifindex after NULL check
Date: Fri,  7 Feb 2014 14:11:18 +0200
Message-Id: <1391775078-25010-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1391775078-25010-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391775078-25010-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/network/bnep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 1aa0783..ece979f 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -523,13 +523,15 @@ static int bnep_add_to_bridge(const char *devname, const char *bridge)
 
 static int bnep_del_from_bridge(const char *devname, const char *bridge)
 {
-	int ifindex = if_nametoindex(devname);
+	int ifindex;
 	struct ifreq ifr;
 	int sk, err;
 
 	if (!devname || !bridge)
 		return -EINVAL;
 
+	ifindex = if_nametoindex(devname);
+
 	sk = socket(AF_INET, SOCK_STREAM, 0);
 	if (sk < 0)
 		return -1;
-- 
1.8.3.2

