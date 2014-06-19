Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/9] bnep: Fix redundant check
Date: Thu, 19 Jun 2014 16:55:33 +0300
Message-Id: <1403186136-30041-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/network/bnep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 87304c5..136709d 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -556,7 +556,7 @@ static int bnep_del_from_bridge(const char *devname, const char *bridge)
 int bnep_server_add(int sk, uint16_t dst, char *bridge, char *iface,
 						const bdaddr_t *addr)
 {
-	if (!bridge || !bridge || !iface || !addr)
+	if (!bridge || !iface || !addr)
 		return -EINVAL;
 
 	if (bnep_connadd(sk, dst, iface) < 0) {
-- 
1.8.3.2

