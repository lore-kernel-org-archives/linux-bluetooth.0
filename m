Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH] Bluetooth: btusb: Add support for Qualcomm Atheros
 composite chip 3006
From: Marcel Holtmann <marcel@holtmann.org>
To: "Yao, Costa" <cqyao@qca.qualcomm.com>
Cc: "padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Fan, Hong" <hongfan@qca.qualcomm.com>,
	"Wu, Frank" <fanwu@qca.qualcomm.com>,
	"Chen, Jack" <skchen@qca.qualcomm.com>,
	"Chang, Robert" <rwchang@qca.qualcomm.com>,
	"Wang, Tom" <taowang@qca.qualcomm.com>,
	"Liu, Haijun" <haijun@qca.qualcomm.com>,
	"QCA.Mgr.Haijun.Liu-All" <QCA.Mgr.Haijun.Liu-All@qualcomm.com>
Date: Thu, 10 Nov 2011 15:53:48 +0900
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEE9E3D@nasanexd02b.na.qualcomm.com>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEE9C9B@nasanexd02b.na.qualcomm.com>
	 <1320824916.15441.328.camel@aeonflux>
	 <07BBB2AAB1A10A488A2AD166C7CB8B0DEE9DC0@nasanexd02b.na.qualcomm.com>
	 <1320849706.15441.336.camel@aeonflux>
	 <07BBB2AAB1A10A488A2AD166C7CB8B0DEE9E3D@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320908035.15441.373.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

> > > For your first comment,
> > > Yes, we can just add device with .driver_info in btusb_table, not in
> > blacklist_table.
> > >
> > > For your other comments,
> > > As the device has 4 USB interfaces and interface 2 is for Bluetooth function.
> > We need to bypass the IF state in btusb.c as follow:
> > >       if (intf->cur_altsetting->desc.bInterfaceNuber !=0)
> > >       return -ENODEV;
> > >
> > > So we use a composite_device_table matching mechanism and use forward
> > jump to bypass the bInterfaceNumber check.
> > > And other vendors also can add their composite device in the
> > composite_device_table to bypass the check.
> > 
> > And this can also be done via the .driver_info to select what interfaces to
> > expect. So please get rid of the composite table.
> > 
> > And post the content of /proc/bus/usb/devices so that I see how your enpoints
> > do look like.
> > 
> There is no /proc/bus/usb directory on my Ubuntu 11.04. And under directory /sys/bus/usb/devices/usb6/6-1, there are the device related files, such as 6-1:1.0 , 6-1:1.1, 6-1:1.2 and 6-1:1.3.

I prefer that output or the output of the usb-devices script from
usbutils package. It is a lot easier to read.

So I briefly looked through the descriptor table list. Seems like the
interface endpoints are using correct Bluetooth generic interface class
numbers. So we could just fix the enumeration logic to look for these.

The only real trick part is that btusb has to claim two interfaces. The
ACL + events one and the SCO one, but nothing is really stopping you
from using USB_DEVICE_AND_INTERFACE_INFO or USB_INTERFACE_INFO.

Maybe we should be doing that anyway since more and more devices are
kinda trying to squeeze more and more interface into a single device
descriptor. And then just look for the first interface and then try to
find the second interface.

T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=01 Dev#= 95 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=217f Rev=03.60
S:  Manufacturer=Broadcom Corp
S:  Product=Broadcom Bluetooth Device
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

This is my local Bluetooth adapter in my laptop for example. This works
fine since the device descriptor using the e0:01:01, but not all
Bluetooth adapters are doing this anymore.

So if we would instead match for the interface descriptor e0:01:01 and
once matched look for the second one to find the SCO interface we could
just have a more generic driver in the first place. It also pretty easy
from the endpoints (existence of the interrupt) if we have the main
interface or the SCO interface.

Care to send a patch for doing this change?

Regards

Marcel


