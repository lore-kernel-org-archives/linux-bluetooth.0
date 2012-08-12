Return-Path: <cyrus@holtmann.org>
Message-ID: <1344785716.1780.7.camel@aeonflux>
Subject: Re: [PATCH] add support bluetooth usb 0489:e046 Foxconn / Hon Hai
From: Marcel Holtmann <marcel@holtmann.org>
To: aborigines <7aborigines7@gmail.com>
Cc: padovan@profusion.mobi, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Sun, 12 Aug 2012 08:35:16 -0700
In-Reply-To: <1344757304-11555-1-git-send-email-7aborigines7@gmail.com>
References: <1344757304-11555-1-git-send-email-7aborigines7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> $ usb-deveices
> T: Bus=01 Lev=02 Prnt=02 Port=02 Cnt=03 Dev#= 5 Spd=12 MxCh= 0
> D: Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P: Vendor=0489 ProdID=e046 Rev=01.12
> S: Manufacturer=Broadcom Corp
> S: Product=BCM20702A0
> S: SerialNumber=C01885F67F9E
> C: #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
> I: If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I: If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
> I: If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I: If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> 
> $ lsusb
> Bus 001 Device 005: ID 0489:e046 Foxconn / Hon Hai

you need a Signed-off-by here.

Regards

Marcel


