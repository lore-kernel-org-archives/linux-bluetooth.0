Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add udev rules to start bluetooth on-demand
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1245593413.15367.65.camel@violet>
References: <1245591547.26486.7101.camel@localhost.localdomain>
	 <1245592251.15367.64.camel@violet>
	 <1245593152.26486.7156.camel@localhost.localdomain>
	 <1245593413.15367.65.camel@violet>
Content-Type: multipart/mixed; boundary="=-e5OFUCYqgcKZO6fD65DS"
Date: Wed, 24 Jun 2009 12:35:29 +0100
Message-Id: <1245843329.26486.16565.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-e5OFUCYqgcKZO6fD65DS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2009-06-21 at 16:10 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > > As discussed in previous mails.
> > > 
> > > please name it bluetooth.rules. The daemon is also called bluetoothd and
> > > not bluezd.
> > > 
> > > Also you need to have the EXTRA_DIST part in it since _DATA doesn't get
> > > added to the distribution automatically. For all this changes, you have
> > > to check with make distcheck.
> > 
> > Fixed version attached
> 
> we might need to put this into ifndef INITSCRIPTS since it makes no
> sense to install the init script and the udev rule at the same time.

Revised patch attached

--=-e5OFUCYqgcKZO6fD65DS
Content-Disposition: attachment; filename="0001-Add-udev-rules-to-start-bluetooth-on-demand.patch"
Content-Type: text/x-patch; name="0001-Add-udev-rules-to-start-bluetooth-on-demand.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 0024e48166073f05ae233113eee2119ccd2e3f71 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sun, 21 Jun 2009 14:37:32 +0100
Subject: [PATCH] Add udev rules to start bluetooth on-demand

Those rules call bluetoothd --udev when a new dongle is inserted.
---
 scripts/Makefile.am     |    6 +++++-
 scripts/bluetooth.rules |    5 +++++
 2 files changed, 10 insertions(+), 1 deletions(-)
 create mode 100644 scripts/bluetooth.rules

diff --git a/scripts/Makefile.am b/scripts/Makefile.am
index 494a9c2..e5683b2 100644
--- a/scripts/Makefile.am
+++ b/scripts/Makefile.am
@@ -11,6 +11,10 @@ endif
 if PCMCIARULES
 rules_DATA += bluetooth-serial.rules
 endif
+
+if INISCRIPTS
+else
+rules_DATA += bluetooth.rules
 endif
 
 if PCMCIARULES
@@ -20,7 +24,7 @@ udev_SCRIPTS = bluetooth_serial
 endif
 
 EXTRA_DIST = bluetooth.init bluetooth.default bluetooth-hid2hci.rules \
-				bluetooth-serial.rules bluetooth_serial
+				bluetooth-serial.rules bluetooth_serial bluetooth.rules
 
 MAINTAINERCLEANFILES = Makefile.in
 
diff --git a/scripts/bluetooth.rules b/scripts/bluetooth.rules
new file mode 100644
index 0000000..f3034b5
--- /dev/null
+++ b/scripts/bluetooth.rules
@@ -0,0 +1,5 @@
+# Run helper every time a Bluetooth device appears
+# On remove actions, bluetoothd should go away by itself
+
+ACTION=="add", SUBSYSTEM=="bluetooth",		RUN+="/usr/sbin/bluetoothd --udev"
+
-- 
1.6.2.2


--=-e5OFUCYqgcKZO6fD65DS--
