Return-Path: <cyrus@holtmann.org>
Message-ID: <1359170626.16748.4.camel@aeonflux>
Subject: Re: What is involved in supporting SCO packets in HCI_RAW mode?
From: Marcel Holtmann <marcel@holtmann.org>
To: Eponymous - <the.epon@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 26 Jan 2013 04:23:46 +0100
In-Reply-To: <CAJ+AEyM4aZY80+Eo7g5=z+3t2fZB+n0rW6a02p8G2CJZ9JvAQQ@mail.gmail.com>
References: <CAJ+AEyM4aZY80+Eo7g5=z+3t2fZB+n0rW6a02p8G2CJZ9JvAQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> After the patch was added to btusb.c to allow ACL packets to be
> sent/received in HCI_RAW mode I was wondering what would be involved
> in allowing raw SCO packets to be sent/received?
> 
> This would be a useful feature for someone like me who works with
> Bluetooth firmware at this level on a daily basis.
> 
> However, I can understand there may be some limitations.
> 
> Is this something that can be realistically done?

I do not see a way to do this properly. The main problem here is the USB
transport. It requires special settings and active URBs.

Once you switch it to HCI_RAW mode, the Bluetooth host stack does no
command/event tracking and with that no connection tracking anymore.
This means it can not inform the driver about any changes. And for USB
it is required to change its alternate setting based on the number of
connections and start ISOC URBs. Having ISOC URBs submitted all the time
is not feasible either since that consumes way too much power.

For other transports like UART, the SCO packets in HCI_RAW mode should
still work.

Regards

Marcel


