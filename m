Return-Path: <SRS0=vBm7=XV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F5CC432C2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 06:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A770B206E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 06:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392961AbfIZGeW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Sep 2019 02:34:22 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52717 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388934AbfIZGeW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Sep 2019 02:34:22 -0400
Received: from marcel-macpro.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id C2589CECD9;
        Thu, 26 Sep 2019 08:43:13 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Bluetooth: btrtl: Fix an issue for the incorrect error
 return code.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190918085641.5374-1-max.chou@realtek.com>
Date:   Thu, 26 Sep 2019 08:34:20 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn
Content-Transfer-Encoding: 7bit
Message-Id: <A2E1B181-85A1-48B5-94B5-9B3722D66584@holtmann.org>
References: <20190918085641.5374-1-max.chou@realtek.com>
To:     max.chou@realtek.com
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Max,

> It does not need the '-' for PTR_ERR(skb) because PTR_ERR(skb) will
> return the negative value during errors.
> 
> Signed-off-by: Max Chou <max.chou@realtek.com>
> ---
> drivers/bluetooth/btrtl.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

