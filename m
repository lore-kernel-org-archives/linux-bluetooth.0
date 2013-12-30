Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] tools/bluetooth-player: Formatting commands
Date: Mon, 30 Dec 2013 15:31:32 +0100
Message-Id: <1388413892-10018-1-git-send-email-sebastianx.chlad@intel.com>
In-Reply-To: <1388153434-8459-1-git-send-email-sebastianx.chlad@intel.com>
References: <1388153434-8459-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Formatting commands passed to bluetooth player.
Whitespace character trimmed.
---
 tools/bluetooth-player.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index 622d391..2afdd17 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -1080,6 +1080,7 @@ static void rl_handler(char *input)
 	if (!strlen(input))
 		goto done;
 
+	g_strstrip(input);
 	add_history(input);
 
 	argv = g_strsplit(input, " ", -1);
-- 
1.7.9.5

