Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: btusb: set HCI_QUIRK_BROKEN_LOCAL_COMMANDS for
 0x0a5c:0x21f3
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170508110848.8639-1-graham.gower@gmail.com>
Date: Thu, 18 May 2017 13:58:33 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7A6EA8E7-D67A-4EC0-8309-113D15F5DC1C@holtmann.org>
References: <20170508110848.8639-1-graham.gower@gmail.com>
To: Graham Gower <graham.gower@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Graham,

> On May 8, 2017, at 13:08, Graham Gower <graham.gower@gmail.com> wrote:
> 
> Card labelled BCM943228HMB found in Lenovo X131e laptop.
> 
> $ usb-devices
> ...
> T:  Bus=02 Lev=02 Prnt=02 Port=04 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0a5c ProdID=21f3 Rev=01.12
> S:  Manufacturer=Broadcom Corp
> S:  Product=BCM20702A0
> S:  SerialNumber=B00594EAFD30
> C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
> I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> ...
> 
> $ hcidump &hciconfig hci0 up
> ...
> commands
> < HCI Command: Set Event Mask Page 2 (0x03|0x0063) plen 8
>    Mask: 0x0000000000000000
>> HCI Event: Command Complete (0x0e) plen 4
>    Set Event Mask Page 2 (0x03|0x0063) ncmd 1
>    status 0x01
>    Error: Unknown HCI Command

can also capture the HCI Read Version Information, HCI Local Features and HCI Local Commands traces with btmon. I would prefer that we include them here.

I want to check if this is the best fix or if we can do it in a more generic way.

Regards

Marcel

