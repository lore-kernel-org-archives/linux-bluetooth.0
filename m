Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300803272005y18b9d62di19605c60a212a467@mail.gmail.com>
Date: Thu, 27 Mar 2008 21:05:24 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <A0B79457-4255-49EB-BDA5-A3D2B903B75C@holtmann.org>
MIME-Version: 1.0
References: <8f5c4ad0803250501x51e5cac8m7c21a6e41460c644@mail.gmail.com>
	<d89ddf300803250516j6cf27fdbjf0740759b823435a@mail.gmail.com>
	<8f5c4ad0803250600q4b36a962w27e57fc3210ebd09@mail.gmail.com>
	<d89ddf300803250739ga372a9fy6d1aa4eff033be0e@mail.gmail.com>
	<6F34AFC6-0E93-4CDD-BDFB-376BD964FCFB@holtmann.org>
	<d89ddf300803262043qba89bb8r1a24ce91b04b5e45@mail.gmail.com>
	<A0B79457-4255-49EB-BDA5-A3D2B903B75C@holtmann.org>
Subject: Re: [Bluez-users] ACL connection handle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel

As a straw man for the sco routing, would the socket option look
anything like this? I'm assuming that the driver would report a socket
connect failure if you specify a route that the driver can't do.

--- sco.h.orig	2007-12-24 10:01:18.000000000 -0700
+++ sco.h	2008-03-27 20:57:44.000000000 -0600
@@ -45,8 +45,12 @@

 /* set/get sockopt defines */
 #define SCO_OPTIONS	0x01
+#define SCO_ANYROUTE	0x00
+#define SCO_HCIROUTE	0x01
+#define SCO_PCMROUTE	0x02
 struct sco_options {
 	uint16_t	mtu;
+	uint8_t		route;
 };

 #define SCO_CONNINFO	0x02

-- 
Brad

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
