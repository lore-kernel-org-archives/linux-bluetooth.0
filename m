Return-Path: <SRS0+fc520b731e911315f002+261+infradead.org+dwmw2@pentafluge-113652.srs.infradead.org>
Subject: Re: [Bluez-devel] DBT-120 and Apple firmware update
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Laurent Bigonville <l.bigonville@easynet.be>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1082808706.4828.9.camel@pegasus>
References: <471106B9-95E5-11D8-A962-00306543FC98@easynet.be>
	 <1082808706.4828.9.camel@pegasus>
Content-Type: text/plain
Message-Id: <1084271810.11301.28.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Tue, 11 May 2004 11:36:50 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Sat, 2004-04-24 at 14:11 +0200, Marcel Holtmann wrote:
> Hi Laurent,
> 
> > Apple has released a firmware update which add headset support under 
> > macosx... But this update make my device incompatible with the drivers 
> > under linux. Is it any change that it will work again?
> 
> you will need the hid2hci utility from CVS.

Under what circumstances would we want to leave it in HID mode? Only
when we have _only_ HID devices and we don't want to use them
transparently instead of trying to use the Linux support for
Bluetooth-HID devices?

When we get BTHID fixed in the kernel, does it make sense to let the
kernel convert these devices to HCI mode automatically?

-- 
dwmw2
