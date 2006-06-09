Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <564d96fb0606090629i6b431352pedf0e125d8d399d4@mail.gmail.com>
References: <564d96fb0606090629i6b431352pedf0e125d8d399d4@mail.gmail.com>
Date: Fri, 09 Jun 2006 22:12:48 +0200
Message-Id: <1149883968.3985.4.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bug in hci_devba
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

Hi Rafael,

> running the program:
> ----------------------------------------------
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/hci.h>
> #include <bluetooth/hci_lib.h>
> 
> int main() {
>         bdaddr_t bdaddr;
>         hci_devba(0, &bdaddr);
>         return 0;
> }
> -----------------------------------------------
> 
> in valgrind produces this warning:
> -------------------------------------------------------------------------------------
> ==7618== Conditional jump or move depends on uninitialised value(s)
> ==7618==    at 0x4B25757: hci_devba (in /usr/lib/libbluetooth.so.1.0.25)
> ==7618==    by 0x40058D: main (in /home/rafael/temp/temp)
> -------------------------------------------------------------------------------------
> 
> The attached patch fixes this.

applied. Thanks.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
