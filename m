Return-Path: <cyrus@holtmann.org>
Message-ID: <4F0AA1EA.4060500@gmx.de>
Date: Mon, 09 Jan 2012 09:14:34 +0100
From: Harvey <harv@gmx.de>
Reply-To: harv@gmx.de
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Kernel 3.2 and Broacom BCM20702A0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I was eagerly awaiting kernel 3.2 as it has support for the usb 
bluetooth builtin adapter in my new laptop, a Fuijitsu Lifebook E751.

To my disappaointment it doesn't seem to work right.

Output of usb-devices:

T:  Bus=02 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e031 Rev=01.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM20702A0
S:  SerialNumber=3859F9CD2AEE
C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Seems to be another vendor specific ID for the same adapter...

For a quick test I did load the btusb module manually and did a
'echo "0489 e031" >> /sys/bus/usb/drivers/btusb/new_id'

'hcitool dev' then shows my BT adapter's MAC. It seems to work but it 
does not find any other devices.

Under windows XP in a virtual machine all is working well.

Harvey
