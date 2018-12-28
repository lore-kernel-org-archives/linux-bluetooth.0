Return-Path: <SRS0=+lf3=PF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B76FC43444
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 20:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE1B2148E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 20:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kVioIQcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbeL1UZY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Dec 2018 15:25:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34163 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387992AbeL1UZX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Dec 2018 15:25:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id j10so10456154pga.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Dec 2018 12:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wyGQY6Le7A84DqOos4Q8wHdbM4IltgYGr4EVT2t3KYw=;
        b=kVioIQcmqyUuv+aXvDr4CubClJv64cCdpF59MC+du18V7/yB0aPPqD8nVJa7XNzRjv
         9Wf0QuorxDRTpFHbrdZJ99LRjKHOY8OaOoDnsWG6rSp9/kAPZl88CjAUXvKB/R9K8Zot
         J+fw8m41f1BHJk905vCJiiMf70njjI9USUAEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wyGQY6Le7A84DqOos4Q8wHdbM4IltgYGr4EVT2t3KYw=;
        b=BnZO8nHZ1Bbg4PIgyMqMj/SmSUrdTBVvm3KjAtU+noCzVsBKuI7hsCBzIkW/6dnOOv
         1cbZwu6LNlzPCEY/LapEHk/XMTBqQ7Sz0iY/xL00trO/nW9QPd6VpLsIQekXPhZP3OND
         VZpy31SXH/mbW/X43sxF2V3lR2xpUv1mOSCiiUnUK6/p08hyc9TkJgKa/DN3hFsdsH3F
         a8/AEbpq1Pi+aWJd4CsjBH0PeAJhkvHrQwOvhPPVVs4D8APiElXd7MpI9VXSsh3qXZps
         +R4fP1axAPCnIiu4CsecEAUoJ+Or0F+JZhX/R3Ev7JU3l+VQVYcxgir4DtzAXJWXm9jY
         z5ng==
X-Gm-Message-State: AJcUukcCKONVs+cnoXmAzHMe0I/2XIFnodI3yTeo2UJSSqi5lGaBIs2P
        c6Svl3AT56uHbQDeZ54NlF3BWA==
X-Google-Smtp-Source: ALg8bN7UOBl81/FosTTVYKkklg9K6acQDfxZ1qq4JYeqqv0obFxrK9GaO8TZ12F/55Dv22tYMhvcdA==
X-Received: by 2002:a63:dc54:: with SMTP id f20mr27877596pgj.410.1546028721657;
        Fri, 28 Dec 2018 12:25:21 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f6sm60453390pfg.188.2018.12.28.12.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 12:25:20 -0800 (PST)
Date:   Fri, 28 Dec 2018 12:25:20 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 3/4] Bluetooth: hci_qca: Disable IBS state machine and
 flush Tx buffer
Message-ID: <20181228202520.GO261387@google.com>
References: <20181228114819.17479-1-bgodavar@codeaurora.org>
 <20181228114819.17479-4-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181228114819.17479-4-bgodavar@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Dec 28, 2018 at 05:18:18PM +0530, Balakrishna Godavarthi wrote:
> During hci down we observed IBS sleep commands are queued in the Tx
> buffer and hci_uart_write_work is sending data to the chip which is
> not required as the chip is powered off. This patch will disable IBS
> and flush the Tx buffer before we turn off the chip.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index b79ef901ab8b..9d5e41f159c7 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1274,6 +1274,14 @@ static const struct qca_vreg_data qca_soc_data = {
>  
>  static void qca_power_shutdown(struct hci_uart *hu)
>  {
> +	struct qca_data *qca = hu->priv;
> +
> +	/* From this point we go into power off state. But serial port is
> +	 * still open, stop queueing the IBS data and flush all the buffered
> +	 * data in skb's.
> +	 */
> +	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);

With that you ensure that no IBS wakeup command is sent for the power
pulse, however there could still be a wakeup work in the workqueue
(added before clearing the above bit). If you want to make sure no
IBS wakeup command is pending I think you need to add:

if (work_pending(&qca->ws_awake_device))
	cancel_work_sync(&qca->ws_awake_device);

it's not exactly the case you intend to address with this patch, but a
related (probably less frequent) scenario.
