Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Subject: [PATCHv2 obexd 1/2] Remove unnecessary return in add_slash func
Date: Wed, 27 Jul 2011 09:39:47 +0200
Message-Id: <1311752388-1391-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/vcard.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index b997fc4..2c13266 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -121,7 +121,6 @@ static void add_slash(char *dest, const char *src, int len_max, int len)
 		}
 	}
 	dest[j] = 0;
-	return;
 }
 
 static void get_escaped_fields(char **fields, ...)
-- 
1.7.0.4

