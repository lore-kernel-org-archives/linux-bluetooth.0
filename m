Return-Path: <cyrus@holtmann.org>
Subject: Patch to improve cupsdir detection
From: Pacho Ramos <pachoramos@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-D6UFNmDtYOHgbxLPxXDM"
Date: Tue, 07 Sep 2010 12:18:43 +0200
Message-ID: <1283854723.24491.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-D6UFNmDtYOHgbxLPxXDM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello

Since really a lot of time we are shipping in Gentoo attached patch to
adapt cupsdir to our cups installations (that uses /usr/libexec/cups
instead of /usr/lib) :
diff --git a/Makefile.tools b/Makefile.tools
index d9a2425..a382e05 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -122,7 +122,7 @@ EXTRA_DIST += tools/dfubabel.1 tools/avctrl.8
 
 
 if CUPS
-cupsdir = $(libdir)/cups/backend
+cupsdir = `cups-config --serverbin`/backend
 
 cups_PROGRAMS = cups/bluetooth

I send this to inform you about it and, if possible, get it
upstreamed :-)

Thanks a lot


--=-D6UFNmDtYOHgbxLPxXDM
Content-Disposition: attachment; filename="cups-location.patch"
Content-Type: text/x-patch; name="cups-location.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/Makefile.tools b/Makefile.tools
index d9a2425..a382e05 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -122,7 +122,7 @@ EXTRA_DIST += tools/dfubabel.1 tools/avctrl.8
 
 
 if CUPS
-cupsdir = $(libdir)/cups/backend
+cupsdir = `cups-config --serverbin`/backend
 
 cups_PROGRAMS = cups/bluetooth
 

--=-D6UFNmDtYOHgbxLPxXDM--

