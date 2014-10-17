Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] bnep: Fix incorrect ioctl() check
Date: Fri, 17 Oct 2014 15:54:09 +0300
Message-Id: <1413550450-16577-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1413550450-16577-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1413550450-16577-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/network/bnep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index b8d2985..18051c3 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -162,7 +162,7 @@ static int bnep_conndel(const bdaddr_t *dst)
 	memset(&req, 0, sizeof(req));
 	baswap((bdaddr_t *)&req.dst, dst);
 	req.flags = 0;
-	if (ioctl(ctl, BNEPCONNDEL, &req)) {
+	if (ioctl(ctl, BNEPCONNDEL, &req) < 0) {
 		int err = -errno;
 		error("bnep: Failed to kill connection: %s (%d)",
 						strerror(-err), -err);
-- 
1.9.1

