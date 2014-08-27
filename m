Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/7] gobex: Fix warning if g_obex_resume is called when disconnected
Date: Wed, 27 Aug 2014 19:04:46 +0300
Message-Id: <1409155490-25653-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1409155490-25653-1-git-send-email-luiz.dentz@gmail.com>
References: <1409155490-25653-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 gobex/gobex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 16a4aae..e7b081f 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -514,7 +514,7 @@ static void enable_tx(GObex *obex)
 	if (obex->suspended)
 		return;
 
-	if (obex->write_source > 0)
+	if (!obex->io || obex->write_source > 0)
 		return;
 
 	cond = G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-- 
1.9.3

