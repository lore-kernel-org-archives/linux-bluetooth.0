Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] help!! how re-compile bluetooth module ?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <I7DHVT$D2922A36BDAB2F92C5ECCB522F102031@libero.it>
References: <I7DHVT$D2922A36BDAB2F92C5ECCB522F102031@libero.it>
Content-Type: text/plain
Message-Id: <1100779078.7164.62.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 18 Nov 2004 12:57:58 +0100

Hi,

> i am using BlueZ 2.7 and i am in need to make some
> little changes to kernel module "bluetooth".

what changes?

> I suppose this module is compiled from the set
> of file stored in /linux/net/bluetooth, which 
> containsa the following:
> 
> af_bluetooth.c
> bnep
>  cmtp
> hci_conn.c
>  hci_core.c
>  hci_event.c
>  hci_sysfs.c
> hidp
> Kconfig
>  l2cap.c
> 54 lib.c
> Makefile
>  rfcomm
>  sco.c
> 
> can someone tell me one compile a new module ?

May you wanna check out some of the Linux kernel HOWTOs.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
