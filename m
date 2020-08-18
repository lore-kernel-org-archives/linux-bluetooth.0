Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66E1C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 04:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8233F2075B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 04:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtGUn4tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgHREpx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 00:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgHREpw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 00:45:52 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417E5C061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 21:45:52 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id a65so15258824otc.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 21:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XOupO0daY6AS+cMid2so2wy3R4YCt4ZXxoUOUqL0Rg=;
        b=UtGUn4tpC5n/0BRR6Xa0SGwlIKYlLg7AuAhAQ6g1e7DadDJm4TGof+VwRdpfK7P8Mj
         1Y9JX5eioKHvSXldFwhM4FOKDY73VSaytM2MtBn5w+dYbDT1OrrmCoeOtsONTrPlOIjp
         GGbgvg0H9Y0tDAgHG1R0AFey5BRKZ7DhE+bO0SbggLMz5u1VEqXzcyOy+4hk39GCmtVk
         lvhEmro0G4JvCIpGJ+RDmpxwe3lMSc07tmK9jV9PafOGBy6k3boS821OkunN/U6GrM80
         b1eweDqbfJ9KDZWH0XFmupUnHrSlcXPmEKZGRHpzmjEib37HRfAgw+1pcS2XHO2ECY70
         Zgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XOupO0daY6AS+cMid2so2wy3R4YCt4ZXxoUOUqL0Rg=;
        b=s0IRw/ZWepEhr11KjHOpw16GEyAu9OZRw+5iUAezkEgbruKdCLzrqbKyRd1SaaDQnD
         pYFUaBZwuqGFBpR+9NmysVAIn9ZYMIa9N088NcKbQkAtXlACq5EdkNMfLWSCRQz9MeDA
         ImG5Jii5EEHn7m/Px97Cg8bdsbFdr/Ib4VfvtQfN5J3f2H0NozHeB6/3ooW/6LfUGdNv
         vC9DWTuf4AUmbIHTrBxpg5PTxO3pwZq2OCJ4wU67CulgvCkxEmLkSBp9g24+uNfkEmx4
         8e97+mdN4VFFObPBYnB68h3RrSf7tJFDeG99eFoxB+3cm9rgOIE1AupztKx2Q5KUdD18
         pTTw==
X-Gm-Message-State: AOAM530v5NEdZutVBUq/L1QkcI5WGTmDPktulFkmo0BO9KEWb476rzyp
        uWQhGU8mY371a4Zx+iReHHybnArEd1xKHJd7id4=
X-Google-Smtp-Source: ABdhPJw1yAsZTd1wDGFGYey7m3Ljfdq6gOyuuxIE/pdPCMoTFUpS4QCpNNNtu7/25UhGMgAzkd9VhD+zN1UMroO+MEQ=
X-Received: by 2002:a9d:429:: with SMTP id 38mr12986376otc.88.1597725951605;
 Mon, 17 Aug 2020 21:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZ+-zF9qLrYdBSWjdWd3qfOJOk-VzNVfTG5eSLYPZ76ahw@mail.gmail.com>
 <20200818012424.8174-1-515672508@qq.com>
In-Reply-To: <20200818012424.8174-1-515672508@qq.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 17 Aug 2020 21:45:41 -0700
Message-ID: <CABBYNZ+oX0XzfoqwcO45Die+5PeQofU=ZBeab+fiFm89Wj7Lxg@mail.gmail.com>
Subject: Re: [PATCH] scr:Set property mode failed,memory leak
To:     chengbo <515672508@qq.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chengbo,

On Mon, Aug 17, 2020 at 6:24 PM chengbo <515672508@qq.com> wrote:
>
> This patch will fix a memory leak,when set property mode,
> it will creat a request,if failed,the data's memory do not free
> ---
>  src/adapter.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 5e896a9f0..3d07921a7 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2917,9 +2917,10 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
>         data->id = id;
>
>         if (mgmt_send(adapter->mgmt, opcode, adapter->dev_id, len, param,
> -                       property_set_mode_complete, data, g_free) > 0)
> +                       property_set_mode_complete, data, g_free) > 0) {
> +               g_free(data);
>                 return;
> -
> +       }
>
> In the original code,if mgmt_send fails then 0 is returned,then this function return directly,do not free data.
> Therefore, you need to free data before executing return.

Nope, if (0 > 0) will evaluate to false so it will continue and the
code below will be executed, the if branch is testing for success case
not the opposite and that is why there is no goto failed either.

>
>         g_free(data);
>
>  failed:
> --
> 2.20.1
>
>
>


-- 
Luiz Augusto von Dentz
