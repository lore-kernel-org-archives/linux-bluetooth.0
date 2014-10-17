Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] bnep: Fix incorrect errno use and avoid double printing
Date: Fri, 17 Oct 2014 15:54:08 +0300
Message-Id: <1413550450-16577-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1413550450-16577-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1413550450-16577-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes bnep_if_up() usage since it already prints error message and
returns errno.
---
 profiles/network/bnep.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 3a6e3a4..b8d2985 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -319,7 +319,6 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 		goto failed;
 
 	if (bnep_if_up(session->iface)) {
-		error("bnep: could not up %s", session->iface);
 		bnep_conndel(&session->dst_addr);
 		goto failed;
 	}
@@ -569,13 +568,7 @@ int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
 		return -errno;
 	}
 
-	if (bnep_if_up(iface) < 0) {
-		error("bnep: Can't up the interface %s: %s(%d)",
-						iface, strerror(errno), errno);
-		return -errno;
-	}
-
-	return 0;
+	return bnep_if_up(iface);
 }
 
 void bnep_server_delete(char *bridge, char *iface, const bdaddr_t *addr)
-- 
1.9.1

