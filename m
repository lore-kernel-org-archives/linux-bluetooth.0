Return-Path: <SRS0=uVZl=3N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FC1C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jan 2020 18:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57252071E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jan 2020 18:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391750AbgAXS6f convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:58:35 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47996 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391725AbgAXS6e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jan 2020 13:58:34 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id CFDB2CED12;
        Fri, 24 Jan 2020 20:07:51 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] Bluetooth: btrtl: Use kvmalloc for FW allocations
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200124171535.32919-1-maxtram95@gmail.com>
Date:   Fri, 24 Jan 2020 19:58:31 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@endlessm.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <F2A93F01-19A3-4ADA-BC2A-674DB8C75AF6@holtmann.org>
References: <20200124171535.32919-1-maxtram95@gmail.com>
To:     Maxim Mikityanskiy <maxtram95@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Maxim,

> Currently, kmemdup is applied to the firmware data, and it invokes
> kmalloc under the hood. The firmware size and patch_length are big (more
> than PAGE_SIZE), and on some low-end systems (like ASUS E202SA) kmalloc
> may fail to allocate a contiguous chunk under high memory usage and
> fragmentation:
> 
> Bluetooth: hci0: RTL: examining hci_ver=06 hci_rev=000a lmp_ver=06 lmp_subver=8821
> Bluetooth: hci0: RTL: rom_version status=0 version=1
> Bluetooth: hci0: RTL: loading rtl_bt/rtl8821a_fw.bin
> kworker/u9:2: page allocation failure: order:4, mode:0x40cc0(GFP_KERNEL|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0
> <stack trace follows>
> 
> As firmware load happens on each resume, Bluetooth will stop working
> after several iterations, when the kernel fails to allocate an order-4
> page.
> 
> This patch replaces kmemdup with kvmalloc+memcpy. It's not required to
> have a contiguous chunk here, because it's not mapped to the device
> directly.
> 
> Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> ---
> drivers/bluetooth/btrtl.c | 20 +++++++++++---------
> 1 file changed, 11 insertions(+), 9 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

