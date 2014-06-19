Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/9] hcitool: Fix adding missing break
Date: Thu, 19 Jun 2014 16:55:34 +0300
Message-Id: <1403186136-30041-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 tools/hcitool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index ffaf953..661c96f 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -363,7 +363,8 @@ static char *get_minor_device_name(int major, int minor)
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

