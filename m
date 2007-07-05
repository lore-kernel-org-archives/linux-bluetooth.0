Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200707041719.20662.wundram@beenic.net>
References: <200707041719.20662.wundram@beenic.net>
Date: Thu, 05 Jul 2007 10:04:31 +0200
Message-Id: <1183622671.6351.73.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Using BlueZ in commercial applications -
	Once	again.
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

> I'm currently developing a (C++) Bluetooth (server) application under Linux, 
> and recently noticed that the BlueZ library (-lbluetooth) is licensed under 
> the GPL, at least according from the bluez-libs sources which I was scanning 
> for documentation (and according to quite a few mails on this list from 
> others asking, but which never seem to gather enough interest to 
> actually "deserve" a longer and more detailed reply than "yes, it is").

there is no long reply needed. The library is GPL and this means every
application using it has to be GPL, too. Period. No exception.

> Anyway, as my application links against -lbluetooth for SDP service 
> registration (and also has source files include bluetooth/bluetooth.h and 
> others for the AF_*- and similar constants to open and manage server sockets 
> offered by the kernel modules), I don't see a big chance of keeping BlueZ as 
> my bluetooth stack, though, as the SDP service registration architecture 
> isn't offered through the D-BUS interface yet (at least not according to the 
> documentation, if I understood that properly), and neither is server socket 
> creation. Is this true?

You can register SDP record via D-Bus.

> Finally: is anyone feeling qualified and interested enough to properly explain 
> to what extent BlueZ can and/or cannot be used in commercial (bluetooth 
> server, in my case an implementation of the server-side of the OBEX File 
> Transfer Profile) applications? I'm thinking of the fact that the constants 
> that define Bluetooth sockets (in bluetooth/*) are specific to BlueZ and are 
> GPL-marked by the file headers, but the kernel headers that define other 
> Linux-specific constants have all been stripped of a license completely, 
> which might, but not necessarily must mean something, as if I include a 
> header file I don't link code, but only data.

All BlueZ files are GPL. There is no exception and no difference between
kernel headers and library headers. The whole kernel is covered by GPL
and if a GPL note is missing in some files, doesn't mean that they are
not GPL.

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
