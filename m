Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/3] client: Add handler for SIGUSR2
Date: Mon,  7 May 2012 17:00:53 -0700
Message-Id: <1336435253-19081-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1336435253-19081-1-git-send-email-luiz.dentz@gmail.com>
References: <1336435253-19081-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This signal enables debug for obed so just do the same for obex-client
---
 client/main.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/client/main.c b/client/main.c
index 6423f32..3eabfda 100644
--- a/client/main.c
+++ b/client/main.c
@@ -69,6 +69,9 @@ static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
 
 		__terminated = 1;
 		break;
+	case SIGUSR2:
+		__obex_log_enable_debug();
+		break;
 	case SIGPIPE:
 		/* ignore */
 		break;
@@ -87,6 +90,7 @@ static guint setup_signalfd(void)
 	sigemptyset(&mask);
 	sigaddset(&mask, SIGINT);
 	sigaddset(&mask, SIGTERM);
+	sigaddset(&mask, SIGUSR2);
 	sigaddset(&mask, SIGPIPE);
 
 	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
-- 
1.7.7.6

