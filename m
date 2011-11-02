Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/8] Removed unused fields of obex_server
Date: Wed,  2 Nov 2011 15:09:49 +0200
Message-Id: <1320239395-29819-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1320239395-29819-1-git-send-email-luiz.dentz@gmail.com>
References: <1320239395-29819-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/server.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/src/server.h b/src/server.h
index 73ada3d..f82ad2b 100644
--- a/src/server.h
+++ b/src/server.h
@@ -30,8 +30,6 @@ struct obex_server {
 	gboolean symlinks;
 	char *capability;
 	gboolean secure;
-	GIOChannel *io;
-	unsigned int watch;
 	GSList *drivers;
 };
 
-- 
1.7.6.4

