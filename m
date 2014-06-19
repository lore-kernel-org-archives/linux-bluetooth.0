Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/9] hciconfig: Fix adding missing break
Date: Thu, 19 Jun 2014 16:55:35 +0300
Message-Id: <1403186136-30041-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 tools/hciconfig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 765d980..7018379 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -856,7 +856,8 @@ static char *get_minor_device_name(int major, int minor)
 		}
 		if (strlen(cls_str) > 0)
 			return cls_str;
-	}
+		}
+		break;
 	case 6:	/* imaging */
 		if (minor & 4)
 			return "Display";
-- 
1.8.3.2

