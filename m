Return-Path: <cyrus@holtmann.org>
Date: Sat, 23 May 2009 14:40:30 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluez-gnome: remove unused
	gtk_status_icon_new/g_object_unref
Message-ID: <20090523124030.GA14304@esaurito.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
with the patch below I am able to fix
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=529026
I'm not sure if creating a new empty status icon is of any use e.g. in GNOME
systray.

---
 applet/notify.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/applet/notify.c b/applet/notify.c
index 02a912a..7daac1a 100644
--- a/applet/notify.c
+++ b/applet/notify.c
@@ -92,9 +92,6 @@ GtkStatusIcon *init_notification(void)
 {
 	notify_init("bluetooth-manager");
 
-	statusicon = gtk_status_icon_new();
-	g_object_unref(statusicon);
-
 	statusicon = gtk_status_icon_new_from_icon_name("bluetooth");
 
 	//gtk_status_icon_set_tooltip(statusicon, _("Bluetooth Manager"));
-- 
1.6.3.1


filippo
--
Filippo Giunchedi - http://esaurito.net - 0x6B79D401

Man was made at the end of the week's work when God was tired.
-- Mark Twain
