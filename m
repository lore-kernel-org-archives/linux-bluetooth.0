Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7942C388F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 09:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4394E20639
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 09:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgKKJ6T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 04:58:19 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:60937 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbgKKJ6R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 04:58:17 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.201.106])
        by mail.holtmann.org (Postfix) with ESMTPSA id 02830CECFC;
        Wed, 11 Nov 2020 11:05:24 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] Bluetooth: hci_ll: add a small delay for wl1271 enable
 bt_en
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201110101311.1657220-1-xiaolei.wang@windriver.com>
Date:   Wed, 11 Nov 2020 10:58:15 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D3303959-F350-45E1-89B3-BB6226D2C2B3@holtmann.org>
References: <20201110101311.1657220-1-xiaolei.wang@windriver.com>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Xiaolei,

> When using the wl1271 Bluetooth function of am335x, it is found that the
> Bluetooth module cannot respond in time after Bluetooth is enabled, and
> a small delay is needed to work normally, so whether to add a small
> mdelay.
> 
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
> drivers/bluetooth/hci_ll.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

