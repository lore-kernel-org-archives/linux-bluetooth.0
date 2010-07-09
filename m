Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Adding support for bluetooth controller shipped with
 iMac i5
From: Marcel Holtmann <marcel@holtmann.org>
To: "Cyril Lacoux (Yack)" <clacoux@ifeelgood.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <201007090834.42674.clacoux@ifeelgood.org>
References: <201006161443.50587.clacoux@ifeelgood.org>
	 <201006162028.59280.clacoux@ifeelgood.org>
	 <1278623133.10421.69.camel@localhost.localdomain>
	 <201007090834.42674.clacoux@ifeelgood.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Jul 2010 04:59:42 -0300
Message-ID: <1278662383.10421.92.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Cyril,

> > please create a proper commit message and include the usb-devices output
> > in that message.
> 
> I don't understand, patch and usb-devices output were attached to my previous 
> mail. Do you want me to re-send the patch in a separate mail using the git 
> output as body ?

when you do git commit to create your fix, then please include all the
details from the USB output I asked for.

Then use git format-patch -1 to create the patch and git send-email to
submit it to the mailing list.

> > Also the HID part in the source code comment makes no sense. Why are you
> > using that one. Copy&paste from the previous one?
> 
> Controller has HID capabilities, keyboard and mouse were working (usb-hid) in 
> restricted mode until I managed to get the controller working with btusb 
> driver. That's why I copied and paste the previous one.

But the usb-devices output for this interface doesn't show HID endpoints
and thus your comment in btusb.c is wrong.

T:  Bus=01 Lev=03 Prnt=03 Port=00 Cnt=01 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=05ac ProdID=8215 Rev=01.82
S:  Manufacturer=Apple Inc.
S:  Product=Bluetooth USB Host Controller
S:  SerialNumber=7C6D62936607
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

The problem you are going to fix is the Cls=ff(vend.) on line two. And
that has nothing to do with HID. That this device might have an HID
proxy as well is irrelevant.

I stated this before in some other emails about this hardware, Apple
must have been smoking something funny. Previously they got this right
and used Cls=e0(wlcon) properly.

Regards

Marcel


