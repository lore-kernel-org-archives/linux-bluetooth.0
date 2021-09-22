Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3E6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 14:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A81611CA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 14:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbhIVOUt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 10:20:49 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34768 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhIVOUt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 10:20:49 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3D63FCED35;
        Wed, 22 Sep 2021 16:19:18 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v6 1/4] Bluetooth: hci_sock: Add support for
 BT_{SND,RCV}BUF
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJhaJGvbuvydtdBa7mHK7kM1Rt+KxKQ9PyNGPM4thwFuA@mail.gmail.com>
Date:   Wed, 22 Sep 2021 16:19:17 +0200
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <53BDC874-DDC8-4700-BB26-2BAF21403D73@holtmann.org>
References: <20210916201049.114392-1-luiz.dentz@gmail.com>
 <1F53E938-77D3-4520-B119-11F81C991D44@holtmann.org>
 <CABBYNZJhaJGvbuvydtdBa7mHK7kM1Rt+KxKQ9PyNGPM4thwFuA@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>> This adds support for BT_{SND,RCV}BUF so userspace can set MTU based on
>>> the channel usage.
>>> 
>>> Fixes: https://github.com/bluez/bluez/issues/201
>>> 
>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> ---
>>> net/bluetooth/hci_sock.c | 102 ++++++++++++++++++++++++++++++++++-----
>>> 1 file changed, 91 insertions(+), 11 deletions(-)
>> 
>> so I applied patches 1, 3 and 4 to bluetooth-next tree.
>> 
>> The patch 2 needs a more details review when I have time since I remember there were cases where the SKB copy was really needed.
> 
> Is that something not covered by CI testing? Note we still have a copy
> done internally with create_monitor_ctrl_command.

there are cases where the SKB handed down is in hdev->send() and that one is owned by the driver to make whatever modifications to headroom it pleases. So if the stack needs to send it out via other sockets, it needs a copy.

We can optimize here, but need to be careful.

Regards

Marcel

