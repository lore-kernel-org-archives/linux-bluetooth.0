Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bnep: Fix using uninitialized variable
Date: Fri, 29 May 2015 11:14:30 +0300
Message-Id: <1432887270-17632-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/network/bnep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 59599e4..8748d68 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -606,8 +606,8 @@ static int bnep_server_add_legacy(int sk, uint16_t dst, char *bridge,
 					char *iface, const bdaddr_t *addr,
 					uint8_t *setup_data, int len)
 {
+	uint16_t rsp = BNEP_SUCCESS;
 	int err, n;
-	uint16_t rsp;
 
 	n = read(sk, setup_data, len);
 	if (n != len) {
-- 
2.1.4

