Return-Path: <SRS0=a08L=MJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F91C43382
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 10:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6172159D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 10:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6172159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeI0REw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:04:52 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36038 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeI0REw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Sep 2018 13:04:52 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id DFAA8CF16A;
        Thu, 27 Sep 2018 12:54:27 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] ath3k: add more information to error message
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180907233603.GF3379@giustizia.org>
Date:   Thu, 27 Sep 2018 12:47:11 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5CF8F067-C9A1-4028-847A-0B25DB00F61A@holtmann.org>
References: <20180907233603.GF3379@giustizia.org>
To:     Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> When there is an error in either ath3k_load_firmware() or
> ath3k_load_fwfile(), the inlined function ath3k_log_failed_loading() is
> called receiving the error returned and both the block size requested to
> load and the size actually loaded. These values are printed in an error
> message using the macro BT_ERR.
> 
> This patch creates a new function which does the same but also receives
> the "count" variable, in order to show more information when a failing
> firmware loading happens. The calls to the older function were changed
> to the new one.
> 
> This event is being monitored in a laptop with an adapter which
> identifies itself as 0cf3:0036, where sometimes there are errors in the
> firmware loading process.
> 
> Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
> ---
> drivers/bluetooth/ath3k.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 3a8c47efea55..ebc312cb4412 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -209,6 +209,14 @@ static inline void ath3k_log_failed_loading(int err, int len, int size)
> 			err, len, size);
> }
> 
> +static inline void ath3k_log_failed_loading_2(int err, int len, int size,
> +						int count)
> +{
> +	BT_ERR("%s err = %d, len = %d, size = %d, count = %d",
> +			"Error in firmware loading",
> +			err, len, size, count);
> +}
> +

just change the the original ath3k_log_failed_loading to include the count parameter.

Regards

Marcel

