Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <6297d67c0606270505v511be476t247bcfc16d451833@mail.gmail.com>
References: <6297d67c0606270505v511be476t247bcfc16d451833@mail.gmail.com>
Date: Tue, 27 Jun 2006 14:18:15 +0200
Message-Id: <1151410695.25011.25.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Cross Compiling openobex
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

Hi Mayank,

> I am able to cross compile openobex-1.0.1 and openobex-apps-1.0.0 for
> ARM.
> But when I try to compile the application ussp-push, I get the
> following errors:
>  
> arm-linux-gcc -I/usr/local/include -I/usr/include/glib-1.2
> -I/usr/lib/glib/include -c obex_main.c -o obex_main.o
> arm-linux-gcc -I/usr/local/include -I/usr/include/glib-1.2
> -I/usr/lib/glib/include -c obex_socket.c -o obex_socket.o 
> arm-linux-gcc obex_main.o obex_socket.o -L/usr/lib -lglib
> -L/usr/local/lib /usr/local/arm/2.95.3/arm-linux/lib/libopenobex.a -o
> ussp-push
> /usr/lib/libglib.so: could not read symbols: Invalid operation
> collect2: ld returned 1 exit status 
>  
>  
> Does this mean that I have to compile glib also for ARM?

use openobex-1.3 all other versions are outdated. And you might need to
change ussp-push to not compile with GLib.

Regards

Marcel



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
