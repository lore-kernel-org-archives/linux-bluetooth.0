Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3095FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 07:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029C52087E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 07:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbhADHBC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jan 2021 02:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbhADHBC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jan 2021 02:01:02 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D3DC061574
        for <linux-bluetooth@vger.kernel.org>; Sun,  3 Jan 2021 23:00:21 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s75so31167644oih.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 03 Jan 2021 23:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEeTa/tdTuj74rAp0JUEZzKZpJ8GXzxWZznq1l+7qTo=;
        b=MGo/84otoGIWGPyjGTuNl30Oh2y1eq3jcuq6s07t68UR25p57bhM3l5lXn8akTXaWn
         Z4uVg7JdxkVsbOCfmqX8Dtay5sK9bhR7/aHEREpuYumtcEtZRREfVSPdxIdklM54L/ZY
         dv1Ek01vuENobrB86T5VEXAfc2kS/WnVLh97pYb01ODA6NgJpyZ1+2w1hgnfnjTHySco
         YcOPwpAwVFFnqMH9ac9oSirGSsQKwoNcfWyyw2SKSWLxY8xY3cPDxFHGqvb5+wlKY++o
         sUMr4IYKX3cKCPj3fdHHpkFiQ0aneSOfZ8/O5rzsDu4RmFyaLqtLNyARu9ybKKZ6BQCL
         HHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEeTa/tdTuj74rAp0JUEZzKZpJ8GXzxWZznq1l+7qTo=;
        b=Cqmh50AZrAFuV+tWStj+T0xLb3KCSTPT7CG15GTrecRjaNc0cyfj1RQA/wS4v6jPmc
         lfPYtmdtO9oHPk8UyZ0SDNpTuXBawgvezgQQ0e/yFYRl6GdL+8yaW8vSVdii5BIk4OQd
         QsQHvAMmNNqiTs3H0rb5ZuYt8VYSg/UrEWb6LeZz7ksafp7JYEE78S3RKXY7C9ukyw8r
         o3B6/VERTNLsc5/Q39jMgeYWof390goZZNDSdrI3GGlWDbvfUTWUPc9McdK8zQx2ztRp
         3XDowWd8EpPwRxl34pfXFGCGyTFh0Q6bSAgl5wtN7jL4Nf0zAfbXjVpJ00tM7i20Dhii
         pkag==
X-Gm-Message-State: AOAM532CLZNFPHW5BgRIBiOhvviJuiQSzwMSjpc1hRDpdL3mN8YpJiIc
        kDUnHhxeyPdmni7I/zNvPHVe4LnvIBeQUoVlFks=
X-Google-Smtp-Source: ABdhPJyYXjc23xx0JKoLgKw9Bku+acUF88J6gD3XM6cNenazu6psi/BlylkO19PndK04luU7O+dJwvHHsgZ47RDMZuU=
X-Received: by 2002:aca:1917:: with SMTP id l23mr16941567oii.64.1609743621235;
 Sun, 03 Jan 2021 23:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20201228193351.Bluez.v3.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
 <20201228193351.Bluez.v3.4.I43884adadc00a5095dd03d2261a71dc2ba80d986@changeid>
In-Reply-To: <20201228193351.Bluez.v3.4.I43884adadc00a5095dd03d2261a71dc2ba80d986@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 3 Jan 2021 23:00:10 -0800
Message-ID: <CABBYNZJdy2iL8gezxd6gOwkSUtxTr3VQvrVehU7ec1GV3twxXw@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 4/4] shared/mgmt: Fix memory leak in mgmt_tlv_list
To:     Howard Chung <howardchung@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Mon, Dec 28, 2020 at 3:34 AM Howard Chung <howardchung@google.com> wrote:
>
> This patch freed the mgmt_tlv properly in mgmt_tlv_list_free.
>
> Reviewed-by: apusaka@chromium.org
> Reviewed-by: mcchou@chromium.org
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Fix incompatible pointer type error of mgmt_tlv_free
>
>  src/shared/mgmt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
> index dc8107846668..0d0c957709d7 100644
> --- a/src/shared/mgmt.c
> +++ b/src/shared/mgmt.c
> @@ -588,14 +588,15 @@ static struct mgmt_tlv *mgmt_tlv_new(uint16_t type, uint8_t length,
>         return entry;
>  }
>
> -static void mgmt_tlv_free(struct mgmt_tlv *entry)
> +static void mgmt_tlv_free(void *data)
>  {
> +       struct mgmt_tlv *entry = data;
>         free(entry);
>  }
>
>  void mgmt_tlv_list_free(struct mgmt_tlv_list *tlv_list)
>  {
> -       queue_destroy(tlv_list->tlv_queue, NULL);
> +       queue_destroy(tlv_list->tlv_queue, mgmt_tlv_free);

It might be better to just pass free directly instead of mgmt_tlv_free
since all it does currently is call free anyway.

>         free(tlv_list);
>  }
>
> --
> 2.29.2.729.g45daf8777d-goog
>


-- 
Luiz Augusto von Dentz
