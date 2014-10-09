Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bnep: Add extra debug information for bnep_up
Date: Thu,  9 Oct 2014 13:17:43 +0300
Message-Id: <1412849863-6691-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adding extra debug information helps to investigate failing cases
---
 profiles/network/bnep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 136709d..a6b8728 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -210,7 +210,8 @@ static int bnep_if_up(const char *devname)
 	close(sk);
 
 	if (err < 0) {
-		error("Could not bring up %s", devname);
+		error("Could not bring up %s: %s(%d)", devname, strerror(errno),
+									errno);
 		return err;
 	}
 
-- 
1.9.1

