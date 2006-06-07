Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <60689.80.203.47.235.1149714015.squirrel@webmail.uio.no>
References: <60689.80.203.47.235.1149714015.squirrel@webmail.uio.no>
Date: Wed, 07 Jun 2006 23:11:50 +0200
Message-Id: <1149714710.22472.64.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Connections
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

Hi Markus,

> I have created a bluetooth service and registeret it. Doing sdptool browse
> local shows me my service. So the registering should have gone fine. But I
> wonder how i listen for connections to that service? How do I receive
> connections made to my service from other bluetooth devices in my C
> program. Any code examples on this?

the bluez-utils source code is full with examples (check rctest.c).

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
