Return-Path: <SRS0=jYet=TH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2F5C004C9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 May 2019 10:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F595205ED
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 May 2019 10:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzompNVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfEGKRW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 May 2019 06:17:22 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34731 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfEGKRW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 May 2019 06:17:22 -0400
Received: by mail-oi1-f195.google.com with SMTP id v10so11965283oib.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2019 03:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Dau7XohLMLX+LulS7JrVS2VMnPvmwcGS3vJ78I1m1mM=;
        b=nzompNVY0TDMGRQJzIwxZdNbey1HGCyd3gEtK1JrChPB2ZG5B0+RXxfmItMFVp69kt
         uQxFLNE7exr6Pm3sEFxj3jFiHZgSPr17qeCvEMv+V9p9yXo2YOjTTMWrECfqaRlVVRkz
         0UeAOgDiLpXPjrTivAmRpTVog8skVszKHuyjDlLBl0rtxFan2uxMecJoju+6172PZ7no
         cdmYrOMdQk5uZmtjH/cm1htcAfDNgonHrDHyWyrZaCs8o4nupDnnyksay47aAPns83HA
         qXd6f0aRDX0/yt+O4/LkBN6adzDBJkpGOp4SGorVx7U149OGzHufJrI+7UOAcC9OI4yE
         wXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Dau7XohLMLX+LulS7JrVS2VMnPvmwcGS3vJ78I1m1mM=;
        b=Fvc+4tCveAb4Nl/I+CtKEOMUjQ69qG/gZxge+iG+yWDM39kpYFXA2+AZts1UNbxwH0
         0p/rSrCoDdERWw7+tI0wms2Mj8ANNm4gQddJ7mKVzoSmXXwXvjiMhrwr4wPRZfTqK3eW
         +p3/oq92XapXqPtezaOCh6pmqqIxEXbmth346oV6/cqLr8v6sXTJ2c0kMPCcQq8OePv2
         L5qE+PadiosZTMoVV5YXu5rwm+woxD1w5kjAmZex1QPsTq8GsbvVdqOS/tijnEO/4YJT
         by+SdIFxRRKLuphFek8XSOhGTTET7QSKNpTQ3KzCMGr4KB/1h9ymJcmM1Og9+nMlxG8/
         uqNw==
X-Gm-Message-State: APjAAAUb0R/Fta8Rlbg6XMpIeI3WRsH2Hy42AVFq1FRDzBhk97x2L6A1
        f0t9vBiz92DXecJTDO4RmsC+c7Vgi0KJpeHg7wWFkNWF/LA=
X-Google-Smtp-Source: APXvYqwn6fw3/lrs9JX6xcaz0sT2PdOUeab+Q65kyo6ZkPDrmrvERyl6n8AbTAtEK6RPxR7o/So+F18nVt/wwYaaNkE=
X-Received: by 2002:aca:5749:: with SMTP id l70mr1957718oib.110.1557224240793;
 Tue, 07 May 2019 03:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190506124310.19151-1-luiz.dentz@gmail.com>
In-Reply-To: <20190506124310.19151-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 May 2019 13:17:08 +0300
Message-ID: <CABBYNZKMkjZ3UyuHuyP-VhV4FfTd-fW1Z4+Z5t1NLHrG8P5kDQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] a2dp: Fix crash when endpoint respond with an error
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, May 6, 2019 at 3:43 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If endpoint respond with an error the callback will be called with size
> set to -1 not 0.
> ---
>  profiles/audio/a2dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index d0676b577..74ada3bbe 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -2418,7 +2418,7 @@ static void select_cb(struct a2dp_setup *setup, void *ret, int size)
>         struct avdtp_media_codec_capability *codec;
>         int err;
>
> -       if (size) {
> +       if (size >= 0) {
>                 caps_add_codec(&setup->caps, setup->sep->codec, ret, size);
>                 goto done;
>         }
> --
> 2.20.1

Applied.

-- 
Luiz Augusto von Dentz
