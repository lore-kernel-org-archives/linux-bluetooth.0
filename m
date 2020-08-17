Return-Path: <SRS0=KHjC=B3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B41C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 17:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3389F2063A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 17:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYGPQtyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbgHQRcy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388922AbgHQRcl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 13:32:41 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46638C061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 10:32:41 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id p137so3566832oop.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Au+CnITgKpC/NCaHV/yv88z60E1XlmNrYn2umiIwfw=;
        b=SYGPQtytDrBzuRFBSmJvq9BPH5gLbOh07+JmX9QyyiCiwKkdlb3GnXSK8EG1L6ePHX
         WJBNkEhLPQfSs8YcsICwRxbHAsN/P7YlpvkdnSryhH2jTOIMn5VJAN/M6fpXMCMYN5UH
         8enI0Opi/DtDy2mEpob+Rh7ieiikyF23Y0kTx1lRRIR4JtITrtrN9+TVQHg266sEIG/C
         V/ogmJnnu4muJw/qeabAKTTd1oNQtbe3Lfe0WnjtYOvyqksI/DK7Cf47GyGPV6DzD2x8
         NuDlJyvDzOwY6QZwb4CPnzIRPXxJmqA9P43AaFq5jis8eShEFpq1jCZbIiHlg0XSk1MJ
         ZKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Au+CnITgKpC/NCaHV/yv88z60E1XlmNrYn2umiIwfw=;
        b=Ilujk0BQp9gY/vRWUme1/pHZ4c78zmB2Tel1tdoZKRUADO7T7EaZiGApUBDgXI4YBM
         FSdW++Sb4d39iSGTLqZu13FZiOcS9U78UjcUS0z7RGIv0PBUiQ/+eaZrKEa3R4APNnQ8
         RitFfFEZR20acZ5qatNkQcffXJ4A4QCGtiQpxaZUP3vDvHHQliujDVw/PErYr3Sp+WE7
         P9IEmtv8rNtn1D0THZVL9+pmTtnriofWYqakDiRIzp10okjqeqK1jLJvRVZLfPIRrdFA
         LE8fnz3d5DO3ZsxYwoXWWbexgb6fFEQDyOM8TEOsCDkhrvAPUsdwH4lT2gAwbutBM5FF
         abNw==
X-Gm-Message-State: AOAM531BkCE7JWBlV+oIW/ApCWZ8VFtZfRlPwLjTRbtRFRp0eU6h/6sP
        BfU68AVO2AVWAMVvMDaqSkLiy9Xhz4/4Rv6ZeEM=
X-Google-Smtp-Source: ABdhPJzrkM9uCCcUaHtJhpKh1QfQhMW3YW/U3IHJnEECrIJjhc0DKrGrAtkB0IPYmxPk6qfSYu/mtmSSXac0RQpcZf4=
X-Received: by 2002:a4a:e88c:: with SMTP id g12mr11738106ooe.49.1597685559392;
 Mon, 17 Aug 2020 10:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200817024234.13758-1-515672508@qq.com>
In-Reply-To: <20200817024234.13758-1-515672508@qq.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 17 Aug 2020 10:32:29 -0700
Message-ID: <CABBYNZ+-zF9qLrYdBSWjdWd3qfOJOk-VzNVfTG5eSLYPZ76ahw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] scr:Set property mode failed,memory leak
To:     chengbo <515672508@qq.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chengbo,

On Sun, Aug 16, 2020 at 7:57 PM chengbo <515672508@qq.com> wrote:
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

This is actually the other way around, if it fails then 0 is returned
and g_free is called, so this would cause a double free as g_free
would be called on destroy.

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
