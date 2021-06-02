Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF604C4708F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Jun 2021 19:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 933D8610E5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Jun 2021 19:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFBTyB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Jun 2021 15:54:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48557 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhFBTyA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Jun 2021 15:54:00 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 00641CED09;
        Wed,  2 Jun 2021 22:00:13 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2] Bluetooth: MGTM: Fix slab-out-of-bounds in
 tlv_data_is_valid
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210528184502.171731-1-luiz.dentz@gmail.com>
Date:   Wed, 2 Jun 2021 21:52:16 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <10093E2D-8238-448E-8E90-5B2851B85BCB@holtmann.org>
References: <20210528184502.171731-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This fixes parsing of LTV entries when the length is 0.
> 
> Found with:
> 
> tools/mgmt-tester -s "Add Advertising - Success (ScRsp only)"
> 
> Add Advertising - Success (ScRsp only) - run
>  Sending Add Advertising (0x003e)
>  Test condition added, total 1
> [   11.004577] ==================================================================
> [   11.005292] BUG: KASAN: slab-out-of-bounds in tlv_data_is_valid+0x87/0xe0
> [   11.005984] Read of size 1 at addr ffff888002c695b0 by task mgmt-tester/87
> [   11.006711]
> [   11.007176]
> [   11.007429] Allocated by task 87:
> [   11.008151]
> [   11.008438] The buggy address belongs to the object at ffff888002c69580
> [   11.008438]  which belongs to the cache kmalloc-64 of size 64
> [   11.010526] The buggy address is located 48 bytes inside of
> [   11.010526]  64-byte region [ffff888002c69580, ffff888002c695c0)
> [   11.012423] The buggy address belongs to the page:
> [   11.013291]
> [   11.013544] Memory state around the buggy address:
> [   11.014359]  ffff888002c69480: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [   11.015453]  ffff888002c69500: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [   11.016232] >ffff888002c69580: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
> [   11.017010]                                      ^
> [   11.017547]  ffff888002c69600: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
> [   11.018296]  ffff888002c69680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> [   11.019116] ==================================================================
> 
> Fixes: 2bb36870e8cb2 ("Bluetooth: Unify advertising instance flags check")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/mgmt.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

