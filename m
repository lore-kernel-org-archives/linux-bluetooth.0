Return-Path: <SRS0=Hm6j=RK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D1FC43381
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Mar 2019 20:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85A82064A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Mar 2019 20:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OoTThACC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfCGUm0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:42:26 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37118 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfCGUm0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Mar 2019 15:42:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id s22so12351401pfh.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Mar 2019 12:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GDG8Xott1X36zkyKyY0ls+WD8rtU8WOAEx5fvkvCMBw=;
        b=OoTThACCx97IcoTSG9sIWtVn5OIYaB+o0w4Fg/A9E+V0mjlt8FnFmhFDyT3kLtA0Ju
         pMY0mataz+LHQnXuAUUAPFyyBRJJtvo99IWaCt+wCHJ1kUR2BV3liXk6Dv4+GF/fpqRk
         dIJJuLkFcO2wsK2GqPnfEXFSXr6s055xLz7q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GDG8Xott1X36zkyKyY0ls+WD8rtU8WOAEx5fvkvCMBw=;
        b=bwxQ3jq5cB/ucJYnWOWOItOf3tz+jityhaXglmVFGUgx1txgRPLAEVfXlm1GaF4VWg
         ZdLrJ7foo4u8yy6W4eZa87JbcnrjjcWbtQHWTRgdfhgIx0O+5gwRfxVp+vcVMBgq3ZZS
         VypEyrIPHMPSykf7sLqmNSISv5MI7yM8JTrgVi7w2VfCN/sTcJTyA+BOSFznVH9k2Rl4
         RREh7a+uYGTh8Bh6cH0SM1r62s5K2YDNZUhj1oL4gZpkTCVaYczVARr3ti+/WjSNk33K
         UqiNkVcQRezKTx6c99tnYUQ12WzsGQ3VockIr+EkPztIdb8J/fBoyNR4rGOXSoNlw/0j
         z7zw==
X-Gm-Message-State: APjAAAU2RO/leShRwWdI2nLWaQOHLoezUUkRp7H1PQsnnzEop8lxXAcc
        kV/i3JN6uL8QEtGZc3bxOWqp9Q==
X-Google-Smtp-Source: APXvYqwp0lCoNw+CvRCphDYMNsIg9Yx60F85NEsB76jEWxkEYYeUzPi1h5RY2nZ6aqrmK/kbIM/jOA==
X-Received: by 2002:a62:4414:: with SMTP id r20mr14736383pfa.37.1551991345300;
        Thu, 07 Mar 2019 12:42:25 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id n4sm14675702pfh.8.2019.03.07.12.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 12:42:24 -0800 (PST)
Date:   Thu, 7 Mar 2019 12:42:24 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        rjliao@codeaurora.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Enable the ldisc for ROME for x86
 platforms.
Message-ID: <20190307204224.GD138592@google.com>
References: <20190307101722.25871-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307101722.25871-1-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Balakrishna,

On Thu, Mar 07, 2019 at 03:47:22PM +0530, Balakrishna Godavarthi wrote:
> When using btattach to setup Rome over ldisc we observed a crash
> in qca_setup as it will try to access the serdev which is not
> available in the ldisc proto. This patch will fix the crash by
> support both the ldisc and serdev way in the qca hci_uart driver.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>

Oh, I wasn't aware of the instantiation through ldisc and was actually
considering to *remove* some of the seemingly unnecessary serdev
checks.

> ---
>  drivers/bluetooth/hci_qca.c | 47 ++++++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 237aea34b69f..0a5c98d46864 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -963,7 +963,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>  {
>  	struct hci_uart *hu = hci_get_drvdata(hdev);
>  	struct qca_data *qca = hu->priv;
> -	struct qca_serdev *qcadev;
> +	struct qca_serdev *qcadev = NULL;

In many cases the only field that is accessed is qcadev->btsoc_type. I
think something like 'qca_get_soc_type(struct hci_dev *hdev / struct
hci_uart *hu)' would make things more readable.

IMO the whole 'qcadev' vs 'qca(_data)' is confusing anyway, in this
sense even better if we can make most of the 'qcadev' references
disappear.

Thanks

Matthias
