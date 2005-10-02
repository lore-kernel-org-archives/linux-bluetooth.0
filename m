Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] hci_usb: add entry for FMWBA-101
	Bluetooth usb-dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050930184121.GA20072@l-t.ee>
References: <20050928152415.GA11240@l-t.ee>
	 <1127922285.5321.20.camel@localhost.localdomain>
	 <20050928191714.GA17254@l-t.ee>
	 <1127982561.5123.8.camel@localhost.localdomain>
	 <20050930184121.GA20072@l-t.ee>
Content-Type: text/plain
Message-Id: <1128280010.5155.1.camel@blade>
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
Date: Sun, 02 Oct 2005 21:06:50 +0200

Hi Marko,

> > > > > This patch adds ID's for Fujitsu-Siemens FMWBA-101 Bluetooth
> > > > > USB Adapter.
> > > > > 
> > > > > /proc/bus/usb/devices:
> > > > > T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  7 Spd=12  MxCh= 0
> > > > > D:  Ver= 1.10 Cls=0e(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> > > > > P:  Vendor=0bf8 ProdID=1003 Rev= 3.36
> > > > > S:  Manufacturer=ALPS
> > > > > S:  Product=BT USB
> > > > 
> > > > this is not needed, because the USB class is enough.
> > > 
> > > But it is not, the device won't be detected without this patch.
> > 
> > it must work without the patch. Otherwise there is something else broken
> > on your side. Try the latest 2.6.14-rc2 kernel.
> 
> Now I tried with 2.6.14-rc2.  On another machine, as I cant
> reboot the first one at will.  Same result - without the patch
> hciconfig shows nothing.

then your hotplug is broken. Fix it or send me the dongle, because none
of these dongles need to be listed.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
