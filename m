Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <6b4e42d10609171754q7c7335f9pfab703d6b746236b@mail.gmail.com>
References: <6b4e42d10609171754q7c7335f9pfab703d6b746236b@mail.gmail.com>
Date: Mon, 18 Sep 2006 08:13:28 +0200
Message-Id: <1158560008.30486.12.camel@localhost>
Mime-Version: 1.0
Cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
        bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] bluetooth drivers : kmalloc to kzalloc conversion
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

Hi Om,

> Tested by compiling with $make allmodconfig; make
> 
> Signed off by Om Narasimhan <om.turyx@gmail.com>
> 
>  drivers/bluetooth/bfusb.c   |    2 +-
>  drivers/bluetooth/hci_usb.c |   11 +++++------
>  2 files changed, 6 insertions(+), 7 deletions(-)

the kzalloc is suppose to replace a kmalloc followed by a memset
operation. It is not the case for these changes and so these changes
make no sense.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
