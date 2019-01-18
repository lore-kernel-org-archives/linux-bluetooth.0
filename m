Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7ACC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 10:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D6B204EC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 10:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfARK4G convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:56:06 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:52959 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfARK4G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 05:56:06 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id D9295CEE14;
        Fri, 18 Jan 2019 12:03:50 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: Fix flow bugs in H5 so the protocol doesn't
 stall
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAO1O6sf8G8VPJLoctB4mNC842NUE4FA0KKi8Hb-cVQq+rfuTag@mail.gmail.com>
Date:   Fri, 18 Jan 2019 11:56:04 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <091E1C5C-18A8-4100-BD41-F930957B09DD@holtmann.org>
References: <1527256763-13474-1-git-send-email-emil.lenngren@gmail.com>
 <A73D99C8-7E66-49CF-8B85-E8879308A5F8@holtmann.org>
 <CAO1O6sf8G8VPJLoctB4mNC842NUE4FA0KKi8Hb-cVQq+rfuTag@mail.gmail.com>
To:     Emil Lenngren <emil.lenngren@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Emil,

>>> 1. If more than tx_win packets are enqueued, so that the unack queue
>>> gets full, then when packets are later acked, uart tx is not woken up,
>>> meaning that the flow will be stalled unless uart tx is not later
>>> woken up for some other reason (e.g. packet is received so an ack
>>> needs to be sent).
>>> 
>>> 2. If remote peer sends tx_win packets to us and our ack(s) are
>>> incorrectly received by the remote device, it will first resend the
>>> tx_win packets and wait for their ack before it can send the next
>>> packets. However, we only send ack if a NEW packet (not a resent packet)
>>> is arrived. Therefore, we will never send ack and the remote device
>>> will keep resend the packets (and wait for the acks) forever, until
>>> we send a new tx packet.
>> 
>> do you have interest in working on the bt3wire.c driver that is a pure serdev driver and make it fully H:5 compliant. I think it would be good to move away from hci_h5.c since it is too much entangled with the line discipline.
> 
> I can take a look at it but can't promise anything. I found the email
> from 2018-03-18. Is that the latest version? Are there any known
> issues with it expect that it misses important features?
> 
> Anyway, the current hci_h5.c driver should still be fixed since it's
> still in use and probably will for some time...
> Yeah the protocol gets pretty complicated in practice and there are
> quite many "edge" cases that can be a bit tricky to cover. I'm not
> sure if a few comments spread out at different places would make
> someone follow the code. I would rather see them as a compliment to a
> bigger description at the top of the file or so, discussing various
> flows and cases. What do you think?

we can fix it in hci_h5.c since it will help current users. Please send patches separated out and I take a look.

Regards

Marcel

