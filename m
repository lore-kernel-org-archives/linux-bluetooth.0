Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <457E1F1C.8090606@xmission.com>
Date: Mon, 11 Dec 2006 20:16:44 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45799129.7070406@xmission.com>
	<1165754285.22251.12.camel@aeonflux.holtmann.net>
In-Reply-To: <1165754285.22251.12.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] rswitch in manpage
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel

> And again, the link mode is only a policy for the the time when the
> connection will be created. It says nothing about handling role
> switching for the life time of a connection.

This is good information. Making the distinction in the manpage between
establishing and established connections will make it more clear. Does
this look ok?

diff -u -r1.8 hcid.conf.5
--- hcid.conf.5 14 Nov 2006 18:22:37 -0000      1.8
+++ hcid.conf.5 12 Dec 2006 03:02:41 -0000
@@ -182,13 +182,15 @@

 \fInone\fP means no specific policy. \fIaccept\fP means always accept
 incoming connections. \fImaster\fP means become master on incoming
-connections and deny role switch on outgoing connections.
+connections and deny role switch on outgoing connections during
+connection establishment.

 .TP
 \fBlp\fP  none|rswitch,hold,sniff,park

 \fInone\fP means no specific policy. \fIrswitch\fP means allow role
-switch. \fIhold\fP means allow hold mode. \fIsniff\fP means allow
+switch on established connections. \fIhold\fP means allow hold mode.
+\fIsniff\fP means allow
 sniff mode. \fIpark\fP means allow park mode. Several options can be
 combined.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
