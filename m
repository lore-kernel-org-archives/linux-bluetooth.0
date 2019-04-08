Return-Path: <SRS0=Ssic=SK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD45C10F13
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Apr 2019 15:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF642148E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Apr 2019 15:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1+TwGkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfDHP6S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:58:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40828 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfDHP6R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Apr 2019 11:58:17 -0400
Received: by mail-ot1-f66.google.com with SMTP id t8so12583884otp.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2019 08:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=G4OpFgXRbXGvNfgNaKvxayTaVaffF7rzc1xxl+khSAw=;
        b=n1+TwGkOTxRgfWQFWxRuAR8Rkwag4rlNioJo2pr9tBeGSuDIzj05mCjP4BGU4UR54J
         INdV1IQvDAzNrVgz13g+ctl3gQVhDFk++xCl/POc9z7Y851N3Gl0pqLhLhjWzmWJ/UAf
         QVnuoPAbj5TzXdCvZpf42FOPWuxoJFk7iqIeDRP1L0MeFnt1dTYWtzwH9dszrhdGB7sc
         66HvWlmg8q08Zq9e4gB1eVSHy7bWv7IcaSfAGOSyKvkRc7wAWMEB0y3GgcinYJ5eAUR7
         zqYgmvzwqRttkPKQAsElSZr3nRwKyeyRZ1RQ5QKJVrUXzSMdom8+IqXfsReruspmD7C+
         5HAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=G4OpFgXRbXGvNfgNaKvxayTaVaffF7rzc1xxl+khSAw=;
        b=Q30DUf6hM0ajBFbyJLIVDYsaWIq4KD7qP/m3rDYiDiEVOMZtslhSqYwxr9HkHQsbKt
         Wx/XPsgP8V8q4FRPfQUVaPNKbeiNtwBZkxFYe64tUG2c4OdQlnK6Qr47uJxOQ5bhcaoH
         cg2xOCU6xgaQxAu3yt6PlacNmxjR0dpcaOSMFC+WMkRPcY+0Ux433WLBmKWr2iHiXMbP
         c1Ui7fQJgf92A05ZqhjYFo/uJSe2mdMywD1JACGdPeTxsSjJoCfw1zelbXuKkExYXoCu
         52MbkCgfNL3xI1neOhelBIENCNiiVgpUH9hrzheh66x2ACIYpECh68rRP4AnDhBrYaZo
         8F8w==
X-Gm-Message-State: APjAAAUe5isQxz/PFu07xNN1gpe+96fuijdH6EE6hIQuKlY4dbq0K7xj
        vUD3gs7BB8WmxD7yFSGuQ7908m+B5A7qMV9VzgcH3RvO
X-Google-Smtp-Source: APXvYqzlhHgGPFia7RlOaDTb7Q5oJexj5F3atwVwzyImz6jjmT6Q+0fepieHL24GOg/NxIPMAxgtUsCY0KwQCZJVDGI=
X-Received: by 2002:aca:4a0a:: with SMTP id x10mr16080163oia.82.1554739096450;
 Mon, 08 Apr 2019 08:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190408094331.11683-1-luiz.dentz@gmail.com>
In-Reply-To: <20190408094331.11683-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Apr 2019 18:58:04 +0300
Message-ID: <CABBYNZJ8jmoSLFjLyximQCiu7iXk=V-Dq-+GFdqLxhyyV=rZXw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] a2dp: Fix UUID of remote Sinks
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Apr 8, 2019 at 12:43 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Sinks were being reported as Sources.
> ---
>  profiles/audio/a2dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 4001ea0ea..8f141739c 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -1686,7 +1686,7 @@ static gboolean get_uuid(const GDBusPropertyTable *property,
>                 uuid = A2DP_SOURCE_UUID;
>                 break;
>         case AVDTP_SEP_TYPE_SINK:
> -               uuid = A2DP_SOURCE_UUID;
> +               uuid = A2DP_SINK_UUID;
>                 break;
>         default:
>                 uuid = "";
> --
> 2.20.1

Applied.

-- 
Luiz Augusto von Dentz
