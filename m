Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] hciemu: Fix gcc 4.7 compilation error
Date: Wed, 16 May 2012 13:07:09 +0300
Message-Id: <1337162829-12536-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes the following compilation error with gcc 4.7:

  CC     test/hciemu.o
test/hciemu.c: In function 'getbdaddrbyname':
test/hciemu.c:1115:3: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
---
I'm sending this to the list since I'm not completely sure what the code
is supposed to do or if this is the right fix or not.

 test/hciemu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/hciemu.c b/test/hciemu.c
index 260e29a..4c62223 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -1109,10 +1109,11 @@ static int getbdaddrbyname(char *str, bdaddr_t *ba)
 	if (n == 0) {
 		/* loopback port */
 		in_addr_t addr = INADDR_LOOPBACK;
+		uint16_t be16 = htons(atoi(str));
 		bdaddr_t b;
 
 		memcpy(&b, &addr, 4);
-		*(uint16_t *) (&b.b[4]) = htons(atoi(str));
+		memcpy(&b.b[4], &be16, sizeof(be16));
 		baswap(ba, &b);
 
 		return 0;
-- 
1.7.10

