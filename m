Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Fix PS3 BD remote "pairing"
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-LhpKj1B8c5Bybz9MVUJT"
Date: Fri, 10 Oct 2008 01:14:36 +0100
Message-Id: <1223597676.22125.0.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-LhpKj1B8c5Bybz9MVUJT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The PS3 BD remote doesn't really want to be paired, CreateDevice on
it will be enough to get the it connected and working.

Cheers

--=-LhpKj1B8c5Bybz9MVUJT
Content-Disposition: attachment; filename="0001-Fix-PS3-BD-remote-pairing.patch"
Content-Type: text/x-patch; name="0001-Fix-PS3-BD-remote-pairing.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From dd1c0184849b12bbda466a2f6bef3d5ff9a1b825 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 10 Oct 2008 01:12:18 +0100
Subject: [PATCH] Fix PS3 BD remote "pairing"

The PS3 BD remote doesn't really want to be paired, CreateDevice on
it will be enough to get the it connected and working.
---
 wizard/main.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/wizard/main.c b/wizard/main.c
index cf731e7..ef61f90 100644
--- a/wizard/main.c
+++ b/wizard/main.c
@@ -208,6 +208,10 @@ static void prepare_callback(GtkWidget *assistant,
 		if (target_type == BLUETOOTH_TYPE_MOUSE)
 			path = NULL;
 
+		/* PS3 BD Remote */
+		if (g_str_equal(target_name, "BD Remote Control") == TRUE)
+			path = NULL;
+
 		bluetooth_client_create_device(client, target_address,
 					path, create_callback, assistant);
 	}
-- 
1.6.0.1


--=-LhpKj1B8c5Bybz9MVUJT--

