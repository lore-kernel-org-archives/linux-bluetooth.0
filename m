Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/9] android/haltest: Fix compile error making function static
Date: Tue, 29 Oct 2013 12:21:51 +0200
Message-Id: <1383042118-21205-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383042118-21205-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382957047-31775-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1383042118-21205-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This fixes following error during compilation:
...
android/client/textconv.c:240: error: no previous declaration for ‘btuuid2str’
make[1]: *** [android/client/android_haltest-textconv.o] Error 1
...
---
 android/client/textconv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/client/textconv.c b/android/client/textconv.c
index a3e10ee..8f27948 100644
--- a/android/client/textconv.c
+++ b/android/client/textconv.c
@@ -234,7 +234,7 @@ char *bdaddr2str(const bt_bdaddr_t *bd_addr)
 	return bt_bdaddr_t2str(bd_addr, buf);
 }
 
-char *btuuid2str(const bt_uuid_t *uuid)
+static char *btuuid2str(const bt_uuid_t *uuid)
 {
 	static char buf[MAX_UUID_STR_LEN];
 
-- 
1.7.10.4

