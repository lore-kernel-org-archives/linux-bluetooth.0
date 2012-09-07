Return-Path: <cyrus@holtmann.org>
Message-ID: <1347015682.2219.5.camel@sirocco.hadess.net>
Subject: [PATCH 3/3] fakehid: Use the same constant as declared
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 07 Sep 2012 12:01:22 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


ps3remote_keymap[] uses 0xff as the max value, so should we.
---
 profiles/input/fakehid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/input/fakehid.c b/profiles/input/fakehid.c
index b12c526..e665869 100644
--- a/profiles/input/fakehid.c
+++ b/profiles/input/fakehid.c
@@ -328,7 +328,7 @@ static int ps3remote_setup_uinput(struct fake_input *fake,
 	}
 
 	/* enabling keys */
-	for (i = 0; i < 256; i++)
+	for (i = 0; i < 0xff; i++)
 		if (ps3remote_keymap[i] != KEY_RESERVED)
 			if (ioctl(fake->uinput, UI_SET_KEYBIT,
 						ps3remote_keymap[i]) < 0) {
-- 
1.7.12


