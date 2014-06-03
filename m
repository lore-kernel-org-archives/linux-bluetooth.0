Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 4/4] tools/btmgmt: Trival whitespace fix
Date: Tue, 3 Jun 2014 12:13:36 +0200
Message-ID: <1401790416-30962-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401790416-30962-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401790416-30962-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btmgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 22fc547..8f5a981 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -2443,7 +2443,7 @@ static struct {
 	{ "hs",		cmd_hs,		"Toggle HS support"		},
 	{ "le",		cmd_le,		"Toggle LE support"		},
 	{ "advertising",cmd_advertising,"Toggle LE advertising",	},
-	{ "bredr",      cmd_bredr,      "Toggle BR/EDR support",	},
+	{ "bredr",	cmd_bredr,	"Toggle BR/EDR support",	},
 	{ "privacy",	cmd_privacy,	"Toggle privacy support"	},
 	{ "class",	cmd_class,	"Set device major/minor class"	},
 	{ "disconnect", cmd_disconnect, "Disconnect device"		},
-- 
1.9.3

