Return-Path: <SRS0=/O/j=EP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839C3C388F7
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 12:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2565E20659
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 12:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgKIMhS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 07:37:18 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48833 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIMhS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 07:37:18 -0500
Received: from marcel-macbook.fritz.box (p4fefcf0f.dip0.t-ipconnect.de [79.239.207.15])
        by mail.holtmann.org (Postfix) with ESMTPSA id E70A0CECC5;
        Mon,  9 Nov 2020 13:44:25 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] Bluetooth: btrtl: Refine the ic_id_table for clearer and
 more regular
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201104120414.12772-1-max.chou@realtek.com>
Date:   Mon, 9 Nov 2020 13:37:16 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com, kidman@realtek.com
Content-Transfer-Encoding: 7bit
Message-Id: <38F15EDD-B923-474D-AFED-46B29C7BD744@holtmann.org>
References: <20201104120414.12772-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Max,

> Enhance the ic_id_table that it's able to maintain regularly.
> To judge which chip should be initialized by LMP subversion, HCI revision,
> HCI version and HCI bus which were given in the ic_id_table.
> Also, refine the incorrect LMP subversion of ROM for RTL8723D and
> RTL8723A.
> 
> Suggested-by: Alex Lu <alex_lu@realsil.com.cn>
> Signed-off-by: Max Chou <max.chou@realtek.com>
> ---
> drivers/bluetooth/btrtl.c | 65 ++++++++++++---------------------------
> 1 file changed, 19 insertions(+), 46 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

