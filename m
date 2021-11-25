Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECB5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Nov 2021 21:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbhKYVGn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Nov 2021 16:06:43 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:59860 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237400AbhKYVEl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Nov 2021 16:04:41 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0E95ECECC6;
        Thu, 25 Nov 2021 22:01:25 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211125154314-mutt-send-email-mst@kernel.org>
Date:   Thu, 25 Nov 2021 22:01:25 +0100
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C8D84EA4-E9A8-44CC-918F-57640A05C81D@holtmann.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211125154314-mutt-send-email-mst@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Michael,

>>> Device removal is clearly out of virtio spec: it attempts to remove
>>> unused buffers from a VQ before invoking device reset. To fix, make
>>> open/close NOPs and do all cleanup/setup in probe/remove.
>> 
>> so the virtbt_{open,close} as NOP is not really what a driver is suppose
>> to be doing. These are transport enable/disable callbacks from the BT
>> Core towards the driver. It maps to a device being enabled/disabled by
>> something like bluetoothd for example. So if disabled, I expect that no
>> resources/queues are in use.
>> 
>> Maybe I misunderstand the virtio spec in that regard, but I would like
>> to keep this fundamental concept of a Bluetooth driver. It does work
>> with all other transports like USB, SDIO, UART etc.
>> 
>>> The cost here is a single skb wasted on an unused bt device - which
>>> seems modest.
>> 
>> There should be no buffer used if the device is powered off. We also don’t
>> have any USB URBs in-flight if the transport is not active.
>> 
>>> NB: with this fix in place driver still suffers from a race condition if
>>> an interrupt triggers while device is being reset. Work on a fix for
>>> that issue is in progress.
>> 
>> In the virtbt_close() callback we should deactivate all interrupts.
>> 
> 
> If you want to do that then device has to be reset on close,
> and fully reinitialized on open.
> Can you work on a patch like that?
> Given I don't have the device such a rework is probably more
> than I can undertake.

so you mean move virtio_find_vqs() into virtbt_open() and del_vqs() into
virtbt_close()?

Or is there are way to set up the queues without starting them?

However I am failing to understand your initial concern, we do reset()
before del_vqs() in virtbt_remove(). Should we be doing something different
in virtbt_close() other than virtqueue_detach_unused_buf(). Why would I
keep buffers attached if they are not used.

Regards

Marcel

