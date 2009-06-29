Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add udev rules to start bluetooth on-demand
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1246098460.12994.128.camel@localhost.localdomain>
References: <1245591547.26486.7101.camel@localhost.localdomain>
	 <1245592251.15367.64.camel@violet>
	 <1245593152.26486.7156.camel@localhost.localdomain>
	 <1245593413.15367.65.camel@violet>
	 <1245843329.26486.16565.camel@localhost.localdomain>
	 <1245861818.15367.145.camel@violet>
	 <1245861900.26486.17200.camel@localhost.localdomain>
	 <1245862000.15367.146.camel@violet>
	 <1245862376.26486.17217.camel@localhost.localdomain>
	 <1246098460.12994.128.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-6/CoEGLhyysojLW8dJhx"
Date: Mon, 29 Jun 2009 16:03:00 +0100
Message-Id: <1246287780.2856.3236.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-6/CoEGLhyysojLW8dJhx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2009-06-27 at 12:27 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > > > > > > > > As discussed in previous mails.
> > > > > > > > > 
> > > > > > > > > please name it bluetooth.rules. The daemon is also called bluetoothd and
> > > > > > > > > not bluezd.
> > > > > > > > > 
> > > > > > > > > Also you need to have the EXTRA_DIST part in it since _DATA doesn't get
> > > > > > > > > added to the distribution automatically. For all this changes, you have
> > > > > > > > > to check with make distcheck.
> > > > > > > > 
> > > > > > > > Fixed version attached
> > > > > > > 
> > > > > > > we might need to put this into ifndef INITSCRIPTS since it makes no
> > > > > > > sense to install the init script and the udev rule at the same time.
> > > > > > 
> > > > > > Revised patch attached
> > > > > 
> > > > > +
> > > > > +if INISCRIPTS
> > > > > +else
> > > > > +rules_DATA += bluetooth.rules
> > > > >  endif
> > > > 
> > > > ifndef isn't an automake construct.
> > > > 
> > > 
> > > then if !INITSCRIPTS should do it. However I was more asking about the
> > > spelling mistake. You forgot a T ;)
> > 
> > Well, that's embarrassing...
> 
> are you sending a new patch :)

Thought you'd fix the typo, and commit.

Patch attached.

--=-6/CoEGLhyysojLW8dJhx
Content-Disposition: attachment; filename="0001-Add-udev-rules-to-start-bluetooth-on-demand.patch"
Content-Type: text/x-patch; name="0001-Add-udev-rules-to-start-bluetooth-on-demand.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 9602419da57953b91e4fcb7a6e3770744154dbef Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Mon, 29 Jun 2009 15:54:46 +0100
Subject: [PATCH] Add udev rules to start bluetooth on-demand

Those rules call bluetoothd --udev when a new dongle is inserted.
---
 scripts/Makefile.am |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/scripts/Makefile.am b/scripts/Makefile.am
index 494a9c2..d97b309 100644
--- a/scripts/Makefile.am
+++ b/scripts/Makefile.am
@@ -11,6 +11,10 @@ endif
 if PCMCIARULES
 rules_DATA += bluetooth-serial.rules
 endif
+
+if INITSCRIPTS
+else
+rules_DATA += bluetooth.rules
 endif
 
 if PCMCIARULES
@@ -19,8 +23,13 @@ udevdir = $(libexecdir)/udev
 udev_SCRIPTS = bluetooth_serial
 endif
 
+if INITSCRIPTS
+else
+rules_DATA += bluetooth.rules
+endif
+
 EXTRA_DIST = bluetooth.init bluetooth.default bluetooth-hid2hci.rules \
-				bluetooth-serial.rules bluetooth_serial
+				bluetooth-serial.rules bluetooth_serial bluetooth.rules
 
 MAINTAINERCLEANFILES = Makefile.in
 
-- 
1.6.2.2


--=-6/CoEGLhyysojLW8dJhx--
