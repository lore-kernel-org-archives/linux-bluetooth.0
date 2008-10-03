Return-Path: <cyrus@holtmann.org>
Subject: Re: Keeping ACL link around after DBUS CreateBonding()
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
In-Reply-To: <35c90d960810021747j56d5bc2ie62c10ade0026694@mail.gmail.com>
References: <35c90d960810021747j56d5bc2ie62c10ade0026694@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 03 Oct 2008 08:36:02 +0200
Message-Id: <1223015762.11272.30.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> I have memories of one of you talking about a custom change to bluez
> to not immediately drop the ACL link once DBUS CreateBonding() has
> finished (so that SDP can then be done on that link).
> 
> Do you know the patch to do this? I am currently experimenting with
> changing the timer expiry in hci_conn_put() for disc_timer. Maybe
> there's a nicer way.

do you have a trace in BTSnoop format for me. We are using L2CAP raw
sockets for bonding and thus the default 2 seconds disconnect timeout
applies. Enough time to get SDP started on the same link. If the remote
side however decides to disconnect us, we are out of luck.

Regards

Marcel


