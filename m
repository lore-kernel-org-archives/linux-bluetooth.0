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
Date: Wed, 09 Nov 2011 23:41:40 +0900
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEE9DC0@nasanexd02b.na.qualcomm.com>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEE9C9B@nasanexd02b.na.qualcomm.com>
	 <1320824916.15441.328.camel@aeonflux>
	 <07BBB2AAB1A10A488A2AD166C7CB8B0DEE9DC0@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320849706.15441.336.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

please do not top post on this mailing list. Otherwise I am just
ignoring your emails from the next time.

> For your first comment, 
> Yes, we can just add device with .driver_info in btusb_table, not in blacklist_table.
> 
> For your other comments,
> As the device has 4 USB interfaces and interface 2 is for Bluetooth function. We need to bypass the IF state in btusb.c as follow:
>       if (intf->cur_altsetting->desc.bInterfaceNuber !=0)
>       return -ENODEV;
>    
> So we use a composite_device_table matching mechanism and use forward jump to bypass the bInterfaceNumber check.
> And other vendors also can add their composite device in the composite_device_table to bypass the check.

And this can also be done via the .driver_info to select what interfaces
to expect. So please get rid of the composite table.

And post the content of /proc/bus/usb/devices so that I see how your
enpoints do look like.

Regards

Marcel


