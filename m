Return-Path: <cyrus@holtmann.org>
Message-ID: <1351091446.1785.65.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Add support for Atheros [04ca:3004]
From: Marcel Holtmann <marcel@holtmann.org>
To: Dwaine Garden VE3GIF <dwainegarden@rogers.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 24 Oct 2012 08:10:46 -0700
In-Reply-To: <1351054633.13513.YahooMailNeo@web125402.mail.ne1.yahoo.com>
References: <1351054633.13513.YahooMailNeo@web125402.mail.ne1.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dwaine,

> Add another vendor specific ID for Atheros AR3012 device.
> This chip is wrapped by Lite-On Technology Corp.
> 
> output of usb-devices:T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=01 Dev#=  3 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=04ca ProdID=3004 Rev= 0.02
> S:  Manufacturer=Atheros Communications
> S:  Product=Bluetooth USB Host Controller
> S:  SerialNumber=Alaska Day 2006

I really want to see the endpoints here as well. So do not cut of the
details of this device.

Regards

Marcel


