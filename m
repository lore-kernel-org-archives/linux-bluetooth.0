Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F02C33CA9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 01:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863982084D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 01:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOt/WGOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgANBfp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jan 2020 20:35:45 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40410 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgANBfp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jan 2020 20:35:45 -0500
Received: by mail-oi1-f194.google.com with SMTP id c77so10288809oib.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jan 2020 17:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Es2iIa5uM6z+FBYxdNBIIR3L6LPGY9nfZZ3Ee4fEYfs=;
        b=nOt/WGObnC4Br2dP+J+Se0J9rW2GPMCpwB+WAGjyktEruCZ7WmGMeRoI17agv8KPLp
         uFl+QMD/9hD6+gDXEgBOI25S4lCx36NyByU+lJ8TUD5lNeQfibE/YJ6yvfZ+FnVJOOPj
         OKe0lQ7bp4GBUkvY17YVz6aykB8v4S0jeVnbBnwchcZuai/KB8RvBFQ1tMaUMQpb352q
         mmkK96trS8rH9uBfAcsrmu5W4pDaXn5HXsY9QLJSWSWUs+XEo/JbHsw73tKUCtgxUmuE
         fxdlbb1J2isnWajQP4EaVuoQzJsX4TfQbvWGQ3jrohZkqazi5y9DQOnyiwIpYy+cLA+P
         4kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Es2iIa5uM6z+FBYxdNBIIR3L6LPGY9nfZZ3Ee4fEYfs=;
        b=XS1Je0iBOeRMgcfARG4yIIAz7lGgdN4acQ0RtkIY/dQxhWzO6QgBzBqqJ3MLxYXDJJ
         uXh4i4+PsBAx7/sNkeHFiCOT61W5yPmPF2FRXGuAWxTgm28BtHtM/dPRLh9C1meDjcDA
         yS+8gZaL78xxlvxOEusZscBNOhCMDeCSYMAKgRPZVeQ8GW9vDJI/6bnfPpzBtrNFTgwQ
         JYmHvrQSQIBn8pCwXvwI7mf6o1tvkt6+Z8hoGAIbVFnZFf7U1Xu2C3kGrMuW4Q5vZZ2Q
         +a3J9HlV/fLSIiYycGaNS4EvWxMBxNKcewK6rcHDGxpLGyz2g0IL46YAb9AMbqHKWw2U
         z2Kg==
X-Gm-Message-State: APjAAAUp2kXDlEFQyyTa5HNcYSMjOR5t4ZDEaWzm2ZbpZuoiOS2QzMNH
        BpQt1GmsEN+S0RrtlpKlS4cMmOUaQGlL2znsMyugC4x+
X-Google-Smtp-Source: APXvYqxisBAmsGjHyyQ/pvIfFBCvL4lmLT4nZdPDwT6HSFkZRO06g44KfzkcgMnfSvQEjBbgGlsIBWntQOTkNb4dhtw=
X-Received: by 2002:aca:481:: with SMTP id 123mr15307992oie.110.1578965744179;
 Mon, 13 Jan 2020 17:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20200112004226.GA432297@kotori.hexchain.org>
In-Reply-To: <20200112004226.GA432297@kotori.hexchain.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Jan 2020 17:35:32 -0800
Message-ID: <CABBYNZJRTTXsgrYCnS2rb=e5Ppg+GiCOx1iQ5X08R_sV-Ua4Rg@mail.gmail.com>
Subject: Re: [PATCH] avctp: Fix EINVAL on uinput creation
To:     i@hexchain.org
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Sat, Jan 11, 2020 at 4:49 PM Haochen Tong <i@hexchain.org> wrote:
>
> The struct uinput_dev variable is on stack, so clear its content to
> avoid accidentally writing garbage values to kernel. This fixes "Can't
> create uinput device: Invalid argument (22)" in some cases.
>
> Signed-off-by: Haochen Tong <i@hexchain.org>

Ive the remove the line above since we don't use it for userspace
patches, see HACKING.

> ---
>  profiles/audio/avctp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> index d3b5dfab9..f7a3de211 100644
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -1182,6 +1182,8 @@ static int uinput_create(struct btd_device *device, const char *name,
>                 }
>         }
>
> +       memset(&dev, 0, sizeof(struct uinput_dev));

Ive change the above like to use sizeof(dev)

>         if (name) {
>                 strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE);
>                 dev.name[UINPUT_MAX_NAME_SIZE - 1] = '\0';
>
> base-commit: b4270d79e19ee70ccab6c087a7b470dad8a8a8bf
> --
> 2.24.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
