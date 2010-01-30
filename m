Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <f97b2b971001292040hf7537d2yeef91fecf4189c50@mail.gmail.com>
References: <f97b2b971001292013i3edd6bdajde0d9e39ed021fbd@mail.gmail.com>
	 <f97b2b971001292024u7ddf84b6gd063280efa6c1a4e@mail.gmail.com>
	 <f97b2b971001292040hf7537d2yeef91fecf4189c50@mail.gmail.com>
Date: Sat, 30 Jan 2010 12:54:24 +0800
Message-ID: <6aeb672b1001292054h39d1a692g9b29e5f9505dc6d2@mail.gmail.com>
Subject: Re: Kernel panic when dongle is disconnected during sco connection
From: Liang Bao <tim.bao@gmail.com>
To: Ahmed Ragab <elmasri.ahmed@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am not a maintainer of bluez package but just wondering if you have
a panic back-trace captured?

2010/1/30 Ahmed Ragab <elmasri.ahmed@gmail.com>:
> I Forgot to mention kernel version 2.6.26 however i have the latest
> bluez package
>
> Please confirm this bug, Linux kernel hangs when usb bluetooth dongle
> is disconnected
> During SCO connection stream (read, write).
> I don't think it's a problem of the dongle however i am using dongle
> trust bluetooth 2 USB Adapter 100m BT-2305p
> which has a Cambridge silicon radio chip set 2.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
