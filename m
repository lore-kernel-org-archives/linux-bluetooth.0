Return-Path: <cyrus@holtmann.org>
Subject: Fix building bluez-gnome in a custom prefix
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-T8f1DKFZb4xZo445r5Lk"
Date: Wed, 24 Sep 2008 14:03:43 -0700
Message-Id: <1222290223.10497.183.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-T8f1DKFZb4xZo445r5Lk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-T8f1DKFZb4xZo445r5Lk
Content-Disposition: attachment; filename="0001-Fix-building-in-a-custom-prefix.patch"
Content-Type: text/x-patch; name="0001-Fix-building-in-a-custom-prefix.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 987348e19a9b2cab05666165d85b19d8eb06f0c3 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 24 Sep 2008 11:34:02 -0700
Subject: [PATCH] Fix building in a custom prefix

We need to pass ACLOCAL_FLAGS to aclocal, otherwise it'll be ignored
Patch from Michael Monreal <michael.monreal@gmx.net>
---
 bootstrap |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bootstrap b/bootstrap
index eeb7635..5def899 100755
--- a/bootstrap
+++ b/bootstrap
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-aclocal && \
+aclocal $ACLOCAL_FLAGS && \
     autoheader && \
 	intltoolize --automake --copy --force &&
 	    automake --add-missing --copy && \
-- 
1.6.0.1


--=-T8f1DKFZb4xZo445r5Lk--

