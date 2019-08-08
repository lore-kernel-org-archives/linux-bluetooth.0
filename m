Return-Path: <SRS0=RGGC=WE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D881BC433FF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Aug 2019 09:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8D62186A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Aug 2019 09:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ndVg0/EP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbfHHJL2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:11:28 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37483 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731076AbfHHJL2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Aug 2019 05:11:28 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so68147328qkl.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Aug 2019 02:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pv1q248coJhOyKZ7sznZtVOVWp+CTcYUhXBNfW3TJcA=;
        b=ndVg0/EPPCgdUb1UGYKBWxFWJEe0kxIjaPWhX5NGPkRioKbWgU8Rv4/LK0iOE8I8C6
         MJ1nJ8wM9E9MnqjyOHSThhBvJPU8HKVaJEPF68vXHaNYuVE6WacHheCRiqp6iFR3C999
         xgk4rGnyz27tt6XoKUcN4A4Vk/j1XEcoyTImA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pv1q248coJhOyKZ7sznZtVOVWp+CTcYUhXBNfW3TJcA=;
        b=qMB5kgYcOnYLk2d8Jd0mwEnyprXG61g4YWqMxAfSF5YKs4C3v47/Tdo+MO4kEdfd9Y
         Ys3tbjZe0uA4LuXg14UqRJSg5ToM0OWfDHJiFfui4Xqhjh71/6rAAMpGTXsaFsR+mKht
         jRNKbWCe2eI2ot0nLVdkwaLDa49FE5Ztcxuc7QOzfycipUVd46HDUTOd1jIWXcU7qGaS
         xBz/dW5/cI+tOJ/0ADatu78T1dio4LjtAaaPf3JdR22WrLVzctrvt+DjDLwCNjxWDVmr
         3McsibmNuZuykp/ET/0SWKmQ2WMR6kapHlVSQFgO7U7Tlfde0OT0QVKSFq8eeoagGBmc
         lQ/Q==
X-Gm-Message-State: APjAAAXtRxJXxLr8lmorLiwgzbjbYkkLACDE/YwWBXuqoaMswxxTRygk
        C6ssSK0xCMLhOa3KR4OjLaw17R6ADCE=
X-Google-Smtp-Source: APXvYqytXLc1uz0s34Ww0UUwbQ7cBSb9krP9aFkzHf2R0cdsuyavZ1uw37Q1hnZHtnmVOr3aT/ue0g==
X-Received: by 2002:ae9:e8d6:: with SMTP id a205mr7325394qkg.241.1565255486357;
        Thu, 08 Aug 2019 02:11:26 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id n184sm38091685qkc.114.2019.08.08.02.11.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 02:11:25 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d17so12440867qtj.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Aug 2019 02:11:25 -0700 (PDT)
X-Received: by 2002:ac8:768b:: with SMTP id g11mr12528132qtr.182.1565255484485;
 Thu, 08 Aug 2019 02:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190808085608.18010-1-bgodavar@codeaurora.org>
In-Reply-To: <20190808085608.18010-1-bgodavar@codeaurora.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Thu, 8 Aug 2019 17:11:13 +0800
X-Gmail-Original-Message-ID: <CALiNf2_ba1XEsHX1bgMrUtJih5DFTwFmWU+6mizN9DnDZx0FUw@mail.gmail.com>
Message-ID: <CALiNf2_ba1XEsHX1bgMrUtJih5DFTwFmWU+6mizN9DnDZx0FUw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btqca: Reset download type to default
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Rocky Liao <rjliao@codeaurora.org>,
        c_hbandi@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Tested-by: Claire Chang <tientzu@chromium.org>
Reviewed-by: Claire Chang <tientzu@chromium.org>

Thanks!


On Thu, Aug 8, 2019 at 4:56 PM Balakrishna Godavarthi
<bgodavar@codeaurora.org> wrote:
>
> This patch will reset the download flag to default value
> before retrieving the download mode type.
>
> Fixes: 32646db8cc28 ("Bluetooth: btqca: inject command complete event during fw download")
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> v2:
>   * add fix tag.
>
> ---
>  drivers/bluetooth/btqca.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 2221935fac7e..9fb247c10855 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -140,6 +140,7 @@ static void qca_tlv_check_data(struct rome_config *config,
>         BT_DBG("Length\t\t : %d bytes", length);
>
>         config->dnld_mode = ROME_SKIP_EVT_NONE;
> +       config->dnld_type = ROME_SKIP_EVT_NONE;
>
>         switch (config->type) {
>         case TLV_TYPE_PATCH:
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
