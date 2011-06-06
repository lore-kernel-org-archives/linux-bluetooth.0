Return-Path: <cyrus@holtmann.org>
Subject: Re: AW: Re: Support for 0489:e031 Foxconn / Hon Hai
From: Marcel Holtmann <marcel@holtmann.org>
To: thilo@cestona.ro
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 06 Jun 2011 10:36:52 +0200
In-Reply-To: <51aa1a9.d945d30cb26cb71f81aa2e9217bb7f3a@1oca1host.de>
References: <51aa1a9.d945d30cb26cb71f81aa2e9217bb7f3a@1oca1host.de>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1307349413.2589.4.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thilo,

> > what about the usb-devices.sh script output or /proc/bus/usb/devices
> > content for this adatper.
> 
> The output for the bluetooth device from /usr/bin/usb-devices (on Ubuntu 11.04) is the following:
> 
> T:  Bus=02 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#=  5 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0489 ProdID=e031 Rev=01.12
> S:  Manufacturer=Broadcom Corp
> S:  Product=BCM20702A0
> S:  SerialNumber=EC55F9EADE09
> C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

so Broadcom is being stupid here and using vendor specific descriptors
instead of just following the proper USB descriptors for Bluetooth. You
need to add the VID and PID to btusb.c device list.

Regards

Marcel


