Return-Path: <cyrus@holtmann.org>
From: Pavel Raiskup <praiskup@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: ovasik@redhat.com
Subject: [PATCH 4/8] Null dereference fix
Date: Tue, 30 Aug 2011 15:10:46 +0200
Message-Id: <1314709846-13378-1-git-send-email-praiskup@redhat.com>
In-Reply-To: <op.v0av49xmh52hc0@dhcp-25-209.brq.redhat.com>
References: <op.v0av49xmh52hc0@dhcp-25-209.brq.redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Variable ifindex dereferenced on line 242 before null check on
line 249.
---
 network/common.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/network/common.c b/network/common.c
index 6da9f0a..f8cd721 100644
--- a/network/common.c
+++ b/network/common.c
@@ -239,13 +239,15 @@ int bnep_if_down(const char *devname)
 
 int bnep_add_to_bridge(const char *devname, const char *bridge)
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
1.7.4.4

