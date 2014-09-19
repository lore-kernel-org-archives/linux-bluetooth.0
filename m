Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 11/13] health: Use proper type for tid
Date: Fri, 19 Sep 2014 16:10:14 +0200
Message-Id: <1411135816-18966-12-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
References: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

tid holds glib source id and should be of guint type.

This fix following compilation error with musl:
  CC       profiles/health/bluetoothd-hdp.o
profiles/health/hdp.c:84:2: error: unknown type name 'uint'
  uint   tid;  /* echo timeout */
  ^

 Please enter the commit message for your changes. Lines starting
---
 profiles/health/hdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index d09bdd4..8ffcd91 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -81,7 +81,7 @@ struct hdp_tmp_dc_data {
 struct hdp_echo_data {
 	gboolean		echo_done;	/* Is a echo was already done */
 	gpointer		buf;		/* echo packet sent */
-	uint			tid;		/* echo timeout */
+	guint			tid;		/* echo timeout */
 };
 
 static struct hdp_channel *hdp_channel_ref(struct hdp_channel *chan)
-- 
1.9.3

