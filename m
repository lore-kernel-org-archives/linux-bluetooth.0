Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B567C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 10:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiBPKVz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:21:55 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiBPKVy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 05:21:54 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A15B220C1;
        Wed, 16 Feb 2022 02:21:39 -0800 (PST)
Received: from smtpclient.apple (p4fefcd07.dip0.t-ipconnect.de [79.239.205.7])
        by mail.holtmann.org (Postfix) with ESMTPSA id EA1E0CED94;
        Wed, 16 Feb 2022 11:21:36 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: 4 missing check bugs
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAA-qYXiUFi5atN8tGRdORbiGqWnbdquuAeKuwdpWSVFVO2FveA@mail.gmail.com>
Date:   Wed, 16 Feb 2022 11:21:36 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        shenwenbosmile@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <DC479C7C-8962-45D3-A036-F5F57CB8865D@holtmann.org>
References: <CAA-qYXiUFi5atN8tGRdORbiGqWnbdquuAeKuwdpWSVFVO2FveA@mail.gmail.com>
To:     Jinmeng Zhou <jjjinmeng.zhou@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jinmeng,

> Hi, our tool finds several missing check bugs on
> Linux kernel v4.18.5 using static analysis.
> We are looking forward to having more experts' eyes on this. Thank you!
> 
> Before calling sk_alloc() with SOCK_RAW type,
> there should be a permission check, ns_capable(ns,CAP_NET_RAW).
> For example,

says who? The appropriate checks are actually present, just not at sock_create. Some are at sock_bind.

Regards

Marcel

