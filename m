Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Better D-BUS path tracking
Message-ID: <20051102183915.GA13523@localhost.localdomain>
References: <20051102153212.GA11188@localhost.localdomain> <1130948271.5442.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Pd0ReVV5GZGQvF3a"
In-Reply-To: <1130948271.5442.12.camel@localhost.localdomain>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 2 Nov 2005 20:40:09 +0200


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcel,

> > This patch introduces a new path_id field to the hci_dbus_data struct as
> > well as renames the id field to dev_id. This allows more accurate path
> > identification in the callback functions. It also removes the need to do
> > hard-to-follow string manipulations to find out the child path component.
> 
> the patch is in the CVS now.

The patch contained by mistake also the authenticate patch I sent earlier.
After applying it the code calls twice dbus_message_new_method_return. Sorry
about that. Here's a patch to fix it.

Johan

--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="memleak-fix.patch"

Index: dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.43
diff -u -r1.43 dbus.c
--- dbus.c	2 Nov 2005 15:44:05 -0000	1.43
+++ dbus.c	2 Nov 2005 18:35:32 -0000
@@ -1705,8 +1705,6 @@
 
 	reply = dbus_message_new_method_return(msg);
 
-	reply = dbus_message_new_method_return(msg);
-
 failed:
 	if (dd >= 0)
 		close(dd);

--Pd0ReVV5GZGQvF3a--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
