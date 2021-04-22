Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BB0C433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Apr 2021 14:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8725F61424
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Apr 2021 14:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbhDVOXx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Apr 2021 10:23:53 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38410 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbhDVOXw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Apr 2021 10:23:52 -0400
Received: from marcel-macbook.holtmann.net (p5b3d2b30.dip0.t-ipconnect.de [91.61.43.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 01A01CECE8;
        Thu, 22 Apr 2021 16:31:03 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: Archived raspi compatibility patchset
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJN4t2F37rrmb2TfdeyYdpv8q4K02SXXNEgY_Y9tONWKQ@mail.gmail.com>
Date:   Thu, 22 Apr 2021 16:23:16 +0200
Cc:     Dave Jones <dave.jones@canonical.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <470E5FAA-76C6-452E-A669-BA38B16205D8@holtmann.org>
References: <20210421202408.itigrlc2cltwu4sv@gonzo.waveform.org.uk>
 <CABBYNZJN4t2F37rrmb2TfdeyYdpv8q4K02SXXNEgY_Y9tONWKQ@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>> I've just noticed the patchset [1] I submitted a while back for
>> compatibility with the bt modules on Raspberry Pi boards was archived,
>> and was wondering if I'd missed some procedure to follow in getting it
>> reviewed? My apologies if I've jumped the gun on something!
>> 
>> I'm happy to either rebase and re-submit (though looking at the current
>> master I think they'd probably apply cleanly still), or unarchive them
>> on patchwork (if that's an acceptable alternative)?
>> 
>> [1]:
>> https://patchwork.kernel.org/project/bluetooth/cover/20201218190609.107898-1-dave.jones@canonical.com/
> 
> My bad I probably forgot to reply, hciattach was deprecated in favor
> of btattach so please port the changes to btattach whenever possible
> and re-submit them.

and actually non of these should be needed since we have serdev support for RPi.

Regards

Marcel

