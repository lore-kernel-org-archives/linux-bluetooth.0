Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA140C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Feb 2023 01:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjBGBKg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Feb 2023 20:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjBGBKf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Feb 2023 20:10:35 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C71333444
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Feb 2023 17:10:33 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id o5so1900991ljp.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Feb 2023 17:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=muc9uTjTDSVAOqnuZqHfoitLXerQp/KIyRguS3Ueeis=;
        b=Qdmvxpz8nWVsR9gLrZXYMOBSwVZzEVwFMZalHIauQLGBkzxz1ev0IFyF8+O3SnjSJG
         o3whOsRjrhWsTHxIXgnvIG4L6ALDpKJ1lAtE45wpmQ+9Ru7bpm1VF5m4Gprd4ffJBYGS
         TnA26wVT0moDrjcvDfJi/GbD1Y1CUSVamahV2onIOLdcIACSLFaepvc4ekjxCjzMi2Sd
         fzYorFWg3n6q0OdMYr3mlNXenrssYnI/DqpTwrZtclMNr9SkggSj3ohOdXo7gaPpVzRl
         baGg6Tk9P5JtMFmguS4AEsfBDeqE+NpdL93ezPmf/n1h4vNcWGDPY+LPNTN0DKPNWgE6
         1qEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=muc9uTjTDSVAOqnuZqHfoitLXerQp/KIyRguS3Ueeis=;
        b=mAjJzpjG+F4nbj62WgEmFC3eHYMu5Fg6Cd6dzoKQ2ODjIVyxzYMkiRBbTcZnQb69Ox
         NNoJvMmMvgFqUqFOXNS+UpnmYyQNqu3eqCZX8+JqTN3FQF0xHxUJIqGc/VcB4fiNamE3
         AZy6TPR1sEwF9qEcT1jUIona3LhiuK4WouS21UktEPBRvwLxsySB3iBP8AueVzH/Ti/r
         wqsL3prtk5RA4kazTkHciEZ3v8Ypujpjay701yexnDBGIfo782h/xTqXq2Q4+tF9GfeG
         ZgGy6J/C/XaMU5123ctneJ3/wFb/vGZQvIndipje2L1HFCEgDg54VeeQ/hwGEbjNC07T
         DSUg==
X-Gm-Message-State: AO0yUKV2Rmel0j48msKw5fjwAvfL2ko0KFMoR2Uet1nVCmBvrzyl/a8Y
        yn8dzaD9Cn2Lt+sLJU0oL6uXA2qkzlSut+AylpY=
X-Google-Smtp-Source: AK7set+BkKaXDeuuUd34ze2Ka/3s3lwEW6KQ6cDUL0U4c/kYQLlVC5XNn0h2UmrucDTZb3fDNUD+ImBEX5k06ojdIrM=
X-Received: by 2002:a05:651c:2325:b0:290:6ee9:f774 with SMTP id
 bi37-20020a05651c232500b002906ee9f774mr154183ljb.43.1675732231517; Mon, 06
 Feb 2023 17:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20230127205205.20235-1-pav@iki.fi> <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
 <32554e8adb382a7e5051f09cd06ca4e0dfe1f86b.1675103676.git.pav@iki.fi>
In-Reply-To: <32554e8adb382a7e5051f09cd06ca4e0dfe1f86b.1675103676.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 Feb 2023 17:10:20 -0800
Message-ID: <CABBYNZK-YM5LJbYzcFq161C5UCuXQxzbf2gFaWF2Qd7yFbP_7A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/8] adapter: add functions indicating adapter CIS capability
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, Jan 30, 2023 at 10:58 AM Pauli Virtanen <pav@iki.fi> wrote:
>
> ---
>  src/adapter.c | 16 ++++++++++++++++
>  src/adapter.h |  3 +++
>  2 files changed, 19 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index aadad4016..4f06bce53 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -9033,6 +9033,22 @@ bool btd_adapter_ssp_enabled(struct btd_adapter *adapter)
>         return false;
>  }
>
> +bool btd_adapter_cis_central_capable(struct btd_adapter *adapter)
> +{
> +       if (adapter->current_settings & MGMT_SETTING_CIS_CENTRAL)
> +               return true;
> +
> +       return false;
> +}
> +
> +bool btd_adapter_cis_peripheral_capable(struct btd_adapter *adapter)
> +{
> +       if (adapter->current_settings & MGMT_SETTING_CIS_PERIPHERAL)
> +               return true;
> +
> +       return false;
> +}
> +
>  void btd_adapter_set_oob_handler(struct btd_adapter *adapter,
>                                                 struct oob_handler *handler)
>  {
> diff --git a/src/adapter.h b/src/adapter.h
> index 78eb069ae..3fcee30bc 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -226,6 +226,9 @@ void btd_adapter_gatt_server_stop(struct btd_adapter *adapter);
>
>  bool btd_adapter_ssp_enabled(struct btd_adapter *adapter);
>
> +bool btd_adapter_cis_central_capable(struct btd_adapter *adapter);
> +bool btd_adapter_cis_peripheral_capable(struct btd_adapter *adapter);

Lets just have btd_adapter_capable(struct btd_adapter *adapter, int
flags) to make it simple to check multiple flags if needed.

>  int adapter_connect_list_add(struct btd_adapter *adapter,
>                                         struct btd_device *device);
>  void adapter_connect_list_remove(struct btd_adapter *adapter,
> --
> 2.39.1
>


-- 
Luiz Augusto von Dentz
