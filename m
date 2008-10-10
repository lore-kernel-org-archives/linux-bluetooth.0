Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Add OUI check for the PS3 BD remote
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-tah9PguLab2tMEz++dWP"
Date: Fri, 10 Oct 2008 16:32:19 +0100
Message-Id: <1223652739.22125.3.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-tah9PguLab2tMEz++dWP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-tah9PguLab2tMEz++dWP
Content-Disposition: attachment; filename="0001-Add-OUI-check-for-the-PS3-BD-remote.patch"
Content-Type: text/x-patch; name="0001-Add-OUI-check-for-the-PS3-BD-remote.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 0318981c54a3396a0672b8fd2a48d4014d9aa59e Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 10 Oct 2008 16:31:03 +0100
Subject: [PATCH] Add OUI check for the PS3 BD remote

As per Marcel's request
---
 wizard/main.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/wizard/main.c b/wizard/main.c
index 860c3b1..83f2491 100644
--- a/wizard/main.c
+++ b/wizard/main.c
@@ -209,7 +209,8 @@ static void prepare_callback(GtkWidget *assistant,
 			path = NULL;
 
 		/* Sony PlayStation 3 Remote Control */
-		if (g_str_equal(target_name, "BD Remote Control") == TRUE)
+		if (g_str_has_prefix(target_address, "00:19:C1:") != FALSE &&
+				g_str_equal(target_name, "BD Remote Control") == TRUE)
 			path = NULL;
 
 		bluetooth_client_create_device(client, target_address,
-- 
1.6.0.1


--=-tah9PguLab2tMEz++dWP--

