Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
In-Reply-To: <200709121104.43419.toralf.foerster@gmx.de>
References: <200709121104.43419.toralf.foerster@gmx.de>
Date: Wed, 12 Sep 2007 18:23:32 +0200
Message-Id: <1189614213.12789.59.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] build #314 failed for 2.6.23-rc6-g577107e
	in	linux/net/bluetooth/hci_sock.c
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

Hi Toralf,

> the build with the attached .config failed, make ends with:
> ...
>   CC      net/bluetooth/hci_conn.o
>   CC      net/bluetooth/hci_event.o
>   CC      net/bluetooth/hci_sock.o
> net/bluetooth/hci_sock.c: In function 'hci_sock_cmsg':
> net/bluetooth/hci_sock.c:352: error: storage size of 'ctv' isn't known
> net/bluetooth/hci_sock.c:352: warning: unused variable 'ctv'
> make[2]: *** [net/bluetooth/hci_sock.o] Error 1
> make[1]: *** [net/bluetooth] Error 2
> make: *** [net] Error 2

patch for that is floating around the kernel mailing list. It is
COMPAT_CONFIG issue and fully my fault.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
