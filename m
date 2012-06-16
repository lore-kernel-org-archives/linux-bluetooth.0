Return-Path: <cyrus@holtmann.org>
Message-ID: <1339889576.20079.8.camel@sirocco.config>
Subject: [PATCH 3/3] fakehid: Use the same constant as declared
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Sun, 17 Jun 2012 01:32:56 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ps3remote_keymap[] uses 0xff as the max value, so should we.
---
 input/fakehid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/input/fakehid.c b/input/fakehid.c
index a125356..a758413 100644
--- a/input/fakehid.c
+++ b/input/fakehid.c
@@ -335,7 +335,7 @@ static int ps3remote_setup_uinput(struct fake_input *fake,
 	}
 
 	/* enabling keys */
-	for (i = 0; i < 256; i++)
+	for (i = 0; i < 0xff; i++)
 		if (ps3remote_keymap[i] != KEY_RESERVED)
 			if (ioctl(fake->uinput, UI_SET_KEYBIT,
 						ps3remote_keymap[i]) < 0) {
-- 
1.7.10


