Return-Path: <cyrus@holtmann.org>
Subject: Re: PATCHES: Device discovery of the "bluetooth" CUPS backend does
 not work
From: Bastien Nocera <hadess@hadess.net>
To: Till Kamppeter <till.kamppeter@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Tim Waugh <twaugh@redhat.com>
In-Reply-To: <4A816300.7050906@gmail.com>
References: <4A8080DC.2010204@gmail.com>
	 <1249986829.2022.17.camel@localhost.localdomain>
	 <4A8153D9.4020008@gmail.com>
	 <1249990438.2022.23.camel@localhost.localdomain>
	 <4A816300.7050906@gmail.com>
Content-Type: multipart/mixed; boundary="=-tQIF5QIQ9CTlhVYXw3cI"
Date: Tue, 11 Aug 2009 14:12:56 +0100
Message-Id: <1249996376.2022.25.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-tQIF5QIQ9CTlhVYXw3cI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2009-08-11 at 14:24 +0200, Till Kamppeter wrote:
<snip>
> Could you put them in? Then I do not need to download the git only to 
> format two simple one-point-only-changed patches. Thanks.

Patches attached.

> >> Do you have a bug/feature request tracking system?
> > 
> > There isn't one.
> 
> As vluez seems to be a part of the kernel project, does the kernel even 
> not have a bug tracking system?

BlueZ's kernel bits probably use the kernel bug tracker. For the
user-space bits, send mails here[1].

Cheers

[1]: Note that I've been barking up that tree for a while...

--=-tQIF5QIQ9CTlhVYXw3cI
Content-Disposition: attachment; filename="0001-Allow-lp-CUPS-to-talk-to-bluetoothd.patch"
Content-Type: text/x-patch; name="0001-Allow-lp-CUPS-to-talk-to-bluetoothd.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From b2d24735492e6a71f3441720940ac55c33fa0838 Mon Sep 17 00:00:00 2001
From: Till Kamppeter <till.kamppeter@gmail.com>
Date: Tue, 11 Aug 2009 14:04:05 +0100
Subject: [PATCH 1/2] Allow lp (CUPS) to talk to bluetoothd

CUPS runs its backend helpers as the "lp" user, so we should
allow CUPS to talk to bluetoothd to enumerate printers.
---
 src/bluetooth.conf |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index c047623..315009c 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -17,6 +17,12 @@
     <allow send_destination="org.bluez"/>
   </policy>
 
+  <!-- allow users of lp group (printing subsystem) to 
+       communicate with bluetoothd -->
+  <policy group="lp">
+    <allow send_destination="org.bluez"/>
+  </policy>
+
   <policy context="default">
     <deny send_destination="org.bluez"/>
   </policy>
-- 
1.6.2.5


--=-tQIF5QIQ9CTlhVYXw3cI
Content-Disposition: attachment; filename="0002-Mark-Bluetooth-printers-as-being-local.patch"
Content-Type: text/x-patch; name="0002-Mark-Bluetooth-printers-as-being-local.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From d96004d65132a7934308ded8010c5f819013157a Mon Sep 17 00:00:00 2001
From: Till Kamppeter <till.kamppeter@gmail.com>
Date: Tue, 11 Aug 2009 14:06:59 +0100
Subject: [PATCH 2/2] Mark Bluetooth printers as being local

For discovery purposes. Also add a better label for the printer,
and append "(Bluetooth") to the "unique" name.
---
 cups/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cups/main.c b/cups/main.c
index ba9864f..bb15c9c 100644
--- a/cups/main.c
+++ b/cups/main.c
@@ -226,7 +226,7 @@ static void print_printer_details(const char *name, const char *bdaddr, const ch
 		 bdaddr[9], bdaddr[10],
 		 bdaddr[12], bdaddr[13],
 		 bdaddr[15], bdaddr[16]);
-	printf("network %s \"Unknown\" \"%s (Bluetooth)\"", uri, escaped);
+	printf("direct %s \"%s\" \"%s (Bluetooth)\"", uri, escaped, escaped);
 	if (id != NULL)
 		printf(" \"%s\"\n", id);
 	else
-- 
1.6.2.5


--=-tQIF5QIQ9CTlhVYXw3cI--

