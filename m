Return-Path: <jt@bougret.hpl.hp.com>
Date: Fri, 13 Aug 2004 15:34:12 -0700
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Steven Singer <steven.singer@csr.com>
Subject: Re: CSR firmware question...
Message-ID: <20040813223412.GA3158@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040813002514.GA21388@bougret.hpl.hp.com> <1092385877.28711.185.camel@pegasus> <20040813163736.GC22763@bougret.hpl.hp.com> <1092416234.28711.256.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1092416234.28711.256.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, Aug 13, 2004 at 06:57:14PM +0200, Marcel Holtmann wrote:
> Hi Jean,
> 
> > > The D-Link dongle DBT-120 (Rev B3) can be updated using the Apple
> > > firmware update file. After that it will be HCI 18.1 with default boot
> > > mode set to HID.
> > 
> > 	This is exactly what I did. I have a rev B3, and I used Apple
> > file.
> > 	What do you mean default boot set to HID ? I look similar to
> > what I'm seeing.
> 
> try running hid2hci :)

	Try, and it won't work, the device doesn't even have a control
pipe anymore. Dead.

> If this does not work, show us /proc/bus/usb/devices.

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0a12 ProdID=1000 Rev=12.41
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=(none)
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=1ms

	(That's with 2.4.X. Under 2.6.X, I can't make sense of the usb stuff).

> Regards
> 
> Marcel

	Have fun...

	Jean
