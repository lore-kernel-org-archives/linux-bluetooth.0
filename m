Return-Path: <cyrus@holtmann.org>
Message-ID: <04f801c8cd18$505d2550$0132a8c0@Raymondpc>
From: "skyflame" <skyflame@21cn.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <564535.96437.qm@web57901.mail.re3.yahoo.com>
	<049e01c8ccf1$013a4600$0132a8c0@Raymondpc>
Date: Fri, 13 Jun 2008 13:42:46 +0800
MIME-Version: 1.0
Subject: [Bluez-devel] bccmd pslist and psread get nothing ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi

    When I try bccmd pslist and psread on my csr bt chip , I get nothing 
output ? why is that ?

~ # bccmd psget -s 0x0 0x01ab
Map SCO over PCM: 0x0002 (2)
~ #
~ # bccmd pslist
~ #
~ # bccmd psread
~ #

Raymond 


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
