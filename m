Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282B9C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 21:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF3092083B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 21:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6NRaUEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgKDVNv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 16:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgKDVNv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 16:13:51 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFDCC0613D3
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 13:13:51 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id i18so128108ots.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 13:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Du2JXkZDjjUO3w58gMtgZA9BL3as/j/kfsHWoUR1SQ4=;
        b=Q6NRaUEwnogctSkqhm5DeOyHPK2mactl4UvVTN3DaunNHSRuzWF4aF9T1X07dQjzSs
         MeJg+DVNfr5vJ2lgkFge/pRwhB5Q2AA5cb/e7518GWX28VZVIkVqj/AkaMckEN9L3B63
         tiu0GSAA/XB16WiWVKs6hHzOK2C7bJyzr0mMgeGtEZpQ2K8bBLMQ7tecES5Fn75YaOLg
         TAbDI12VgT5fal8v5vXzLXjMDDeg3FZkQM6Od1deiO2SRzTkpDNwDYPuymoSUBDsRzH3
         9yT2OlTNxIRlc9fS82NA8JgMsqc63In1Z55dKImVqkva7ZpXAVslQOpsuY/7QXYQIt++
         6O8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Du2JXkZDjjUO3w58gMtgZA9BL3as/j/kfsHWoUR1SQ4=;
        b=K5fSn7z9CRfif1U07ZO3iXXYEs5V3lytSp9bDbyQMAtv4KB2R6DjBFbWEWIBQsKt95
         K62JruyOOtSo/F2yZK2fAzwpO/P4BuEfHCDnPXfg1k0U6jzsjG8OEGEpvLKnoM0Q7+wo
         puSK0QRF6fJfBppHmMkhnJojn1CPJt+THhPFxwYAauZHJrqRm1Ajggq3OusZCTa7V3rX
         s1CP8K7i9FOGxEptbTyN1xC3pg1fDC51A/9Z5XNOJfpZeVyIsYBktmQTk9lMVCysDDB9
         u+Ic+t5Qi3DTXKbFq123NiuIpM06O+FRwMcTXjTWATdyXeF/f3otPWmygN9qUV0pl2sa
         J4yg==
X-Gm-Message-State: AOAM533kFg2d/neR5MmQyUEKkjhvV3EwKRDuCgLEFMhjkhiEahC7lw5B
        7rrhOh1tcCJ+aVO6PBRchb0H72jLtVuu5H9PTIA=
X-Google-Smtp-Source: ABdhPJxWZCq3pmSvc9NynZQ6nB8AxHQCXxPMqhO2d4w93tb2E2L7EiuTkjz/GenAyKrkQ2GS1ip4Btd3FxMJmf75qAg=
X-Received: by 2002:a05:6830:400d:: with SMTP id h13mr20857831ots.371.1604524430314;
 Wed, 04 Nov 2020 13:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20201104133318.Bluez.v1.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
In-Reply-To: <20201104133318.Bluez.v1.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 4 Nov 2020 13:13:39 -0800
Message-ID: <CABBYNZKRhGcqtd1eUhE2AbF98RNnDkEfTHcg8p38JSB=ENXy1Q@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 1/3] policy: add checks before connecting
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Tue, Nov 3, 2020 at 9:35 PM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> When policy_connect() is called, there might be a case where the
> device is not ready, or even the adapter is down. Add some checks
> by calling btd_device_connect_services() instead of directly calling
> btd_service_connect().

But we could perform these checks in btd_service_connect or you also
intended to use the pending list? Im a little hesitant with such a
change though because there could be a pending connect already causing
it to fail instead of just connecting in parallel.

> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> ---
>
>  plugins/policy.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/plugins/policy.c b/plugins/policy.c
> index ba9e1be020..42b15cb65f 100644
> --- a/plugins/policy.c
> +++ b/plugins/policy.c
> @@ -106,6 +106,7 @@ static void policy_connect(struct policy_data *data,
>  {
>         struct btd_profile *profile = btd_service_get_profile(service);
>         struct reconnect_data *reconnect;
> +       GSList *l = NULL;
>
>         reconnect = reconnect_find(btd_service_get_device(service));
>         if (reconnect && reconnect->active)
> @@ -113,7 +114,9 @@ static void policy_connect(struct policy_data *data,
>
>         DBG("%s profile %s", device_get_path(data->dev), profile->name);
>
> -       btd_service_connect(service);
> +       l = g_slist_prepend(l, service);
> +       btd_device_connect_services(data->dev, l);
> +       g_slist_free(l);
>  }
>
>  static void policy_disconnect(struct policy_data *data,
> --
> 2.29.1.341.ge80a0c044ae-goog
>


-- 
Luiz Augusto von Dentz
