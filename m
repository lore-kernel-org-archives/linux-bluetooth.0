Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200707051135.23459.wundram@beenic.net>
References: <200707041719.20662.wundram@beenic.net>
	<200707051108.32230.wundram@beenic.net>
	<Pine.LNX.4.63.0707051114450.25165@redbean.intranet.gw-instruments.de>
	<200707051135.23459.wundram@beenic.net>
Date: Fri, 06 Jul 2007 08:09:25 +0200
Message-Id: <1183702165.6351.121.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Using BlueZ in commercial applications
	-	Once	again.
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

Hi Heiko,

> > This is not fully true. You need soem glue layer which needs to be GPL or
> > LGPL. Check http://www.tomtom.com/page.php?Page=gpl for examples.
> >
> > And I think you agree that the Tom Tom Navigation systems are commercial
> > products.
> 
> Totally true, and that's why I asked about the D-BUS interface because that is 
> (supposedly, as it's LGPL-licensed) a glue layer which would work for my case 
> (without me having to implement the glue code).

the D-Bus IPC is a public API with no restrictions. You only have to
obey with the license of the bindings. However make sure that you don't
link -lbluetooth into your application. If you do then it becomes GPL.
And just as a side note. The OpenOBEX library can become GPL, too. So
you better should involve a lawyer at some point.

> But generally, this means that in case the available glue layers don't fit my 
> need, I will have to write a glue layer between my commercial application and 
> BlueZ, which not only costs resources and time but also makes the application 
> more complex (and error-prone, because of blown code size and the need for 
> IPC, as wrapping BlueZ in another library would defeat the purpose of the 
> GPL-circumventing glue code), which is generally not acceptable for the 
> small- to medium-scale fully integrated solution we're currently working on.

The D-Bus API works perfectly fine for Nokia and Access. It will also
work for OpenMoko. The decisions behind its design are driven by the
applications need.

> Anyway, I respect the licensing decision on the BlueZ developers part fully, 
> which is not what I'm trying to debate about. But, as I said, as long as 
> there is no fully functional glue code which works out of the box with 
> commercial applications - the socket-API being one form of such glue code 
> (but because that requires a GPL'd header to actually function, think of 
> AF_BLUETOOTH defined only in bluetooth/bluetooth.h, it's out of the 
> question) - BlueZ is simply unusable for our current needs, and I guess quite 
> a lot of other commercial Bluetooth developers would feel the same.

To be quite honest. That is not my problem. I am not making any money
with selling a Bluetooth solution. However it seems that the current
solution is enough for the Nokia N800 and other commercial systems and
so I don't see your problem. If you wanna simply have a cheap solution
that is developed by someone else and that you can use in potential
products to make money with, you might wanna re-think your business
model.

Let me make this bluntly clear. The BlueZ project moves with the needs
of its users, but users that don't contribute have no say whatsoever. I
simply don't care. So if you want changes or additions, then start
working on them and play with the open source rules and be active in the
community.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
