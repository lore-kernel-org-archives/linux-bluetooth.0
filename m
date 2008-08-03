Return-Path: <cyrus@holtmann.org>
Date: Sun, 3 Aug 2008 16:39:59 -0700 (PDT)
From: Chris Rankin <rankincj@yahoo.com>
Reply-To: rankincj@yahoo.com
Subject: Cannot pair A2DP speakers with Belkin Bluetooth adapter
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-ID: <792645.64581.qm@web52903.mail.re2.yahoo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

[No, I am *not* having any device conflict with the pegasus driver.]

Hi,

I have a Belkin bluetooth adapter model F8T012xx1, IDs 0x050d:0x0121

http://catalog.belkin.com/IWCatProductPage.process?Product_Id=273100

and I cannot pair it with a set of bluetooth A2DP speakers. These same speakers work fine with my laptop, which has an internal bluetooth device 0x0a5c:0x2110. But whenever I try to pair the Belkin device using the commands

$ hcitool cc <bdaddr>
$ hcitool auth <bdaddr>

then the connection drops after only a few seconds and the pairing fails. To date, I have only been able to pair this adapter with my Nokia mobile phone, after which I have been able to browse the phone's filesystem successfully.

The adapter's device descriptor is:

T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  8 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=050d ProdID=0121 Rev= 4.13
S:  Manufacturer=Broadcom Corp
S:  Product=BELKIN BLUETOOTH USB ADAPTER CL. 1
S:  SerialNumber=000A3A7DFF80
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:* If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

Can anyone suggest anything to try in order to keep the BT connection up, please? I have already tried adding the flags HCI_RESET | HCI_WRONG_SCO_MTU without any effect.

Thanks for any help here,
Cheers,
Chris



      __________________________________________________________
Not happy with your email address?.
Get the one you really want - millions of new email addresses available now at Yahoo! http://uk.docs.yahoo.com/ymail/new.html
