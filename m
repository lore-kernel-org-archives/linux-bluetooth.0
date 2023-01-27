Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49F1C38142
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Jan 2023 20:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjA0UMO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Jan 2023 15:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjA0UMB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Jan 2023 15:12:01 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BC17EC5
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 12:11:47 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o20so9893954lfk.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 12:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lMMZ9rolSe9Ajlv1m2tj/H8KqF6hTQtzGPU1trMHjk4=;
        b=RKtqK6ttvSIXAZ9GybpM993JWWXv4J/9c5uLG5w58H0vEec3LI7JXfeQlsRrjjLovr
         ehMhAk4MNDAcT+4nGG0A9GYIaMTzV2J4S3jKtDNYplorVlAsJxnmn1HT34QXScKSCKH/
         ICW0FW+3pWVGEWSuJqViiifLvTVZXUtlKKZBz96xnfdCEgd3QC7Zefj70ZTm+7QOLoTo
         OpUNrZXvdxmPPSSSpbyEH86wSLYjQqhQ7hmYpSk9UkR799tCAiLLJyfFHXrnJXNdMaqK
         8lukeqXfJZtQR06ZCkbX2vrXC2/Ou4rty3+b3WrK1pjPSImyGXtZqIdT+vQkjDt/jHv6
         TRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMMZ9rolSe9Ajlv1m2tj/H8KqF6hTQtzGPU1trMHjk4=;
        b=cMGXZenxw9/ThZ4SLSXcyNL1B0ZnKrfeWgBliZHSW+xcpVZvCaZckXJKLcRsOTcn1w
         zs01lzP3GkCAAtEmtUih9AeGncnObFRA4bnMPoOosNiezILIrB4Nce+m3H+eKLDUODjK
         uPjjyQvT8mwCB/UFVDL16C6Sv0hlge0AfNwiCfKcKAkZ0U1mqK9a++dTS8tjnNPqD231
         PUbRn4aPxxb9WrrTSSeIyGcn5wGSwybtuevH2tEYzhHFS8l9F9pAk2C1MX0YAioBkOTz
         hrNVZ7yq4jV8tN7ns037XLhvdrWLvmb2ms7HfUBdQPN4jXBPPIkWuxG4OaE3umigiOsB
         yzGg==
X-Gm-Message-State: AFqh2kqtOODkSnFN9YYLaolqGdcrbuur9KB/rCAEmT0xTv785Hc0lY5d
        30+2Yvl1ZVRZ9wmEQes4rXShEllTXHKHCb3lBJr4+2xS
X-Google-Smtp-Source: AMrXdXvy8xodaLPD4VxZmYj/WnVC5q68ql/25WoOHx7n7aDWXpTXQr4XvnO4YEON+7YlvjiO+BucR9ekMim33/3w7Sg=
X-Received: by 2002:ac2:4c0c:0:b0:4cb:22ab:ce08 with SMTP id
 t12-20020ac24c0c000000b004cb22abce08mr1942898lfq.251.1674850305934; Fri, 27
 Jan 2023 12:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20230127113504.134109-1-marcin.kraglak@telink-semi.com>
In-Reply-To: <20230127113504.134109-1-marcin.kraglak@telink-semi.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 27 Jan 2023 12:11:33 -0800
Message-ID: <CABBYNZ+AeLnokfsrTp3=vsC7j6E4Uei_U=1Ex6LhYzU_-PDzMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] shared/util: Add CAS, HAS, TMAS and PBAS UUIDs
To:     Marcin Kraglak <marcin.kraglak@telink-semi.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcin,

On Fri, Jan 27, 2023 at 3:42 AM Marcin Kraglak
<marcin.kraglak@telink-semi.com> wrote:
>
> Add UUIDs for: Common Audio service, Hearing Aid service,
> TMAS service and Public Broadcast Announcement service.
> ---
>  src/shared/util.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/util.c b/src/shared/util.c
> index 69abfba31..1ff9c56fc 100644
> --- a/src/shared/util.c
> +++ b/src/shared/util.c
> @@ -447,7 +447,11 @@ static const struct {
>         { 0x1850, "Published Audio Capabilities"                },
>         { 0x1851, "Basic Audio Announcement"                    },
>         { 0x1852, "Broadcast Audio Announcement"                },
> -       /* 0x1853 to 0x27ff undefined */
> +       { 0x1853, "Common Audio"                                },
> +       { 0x1854, "Hearing Aid"                                 },
> +       { 0x1855, "TMAS"                                        },

We don't use the abbreviation here, so it should be Telephony and Media Audio

> +       { 0x1856, "Public Broadcast Announcement"               },
> +       /* 0x1857 to 0x27ff undefined */
>         { 0x2800, "Primary Service"                             },
>         { 0x2801, "Secondary Service"                           },
>         { 0x2802, "Include"                                     },
> @@ -681,6 +685,7 @@ static const struct {
>         { 0x2b29, "Client Supported Features"                   },
>         { 0x2b2A, "Database Hash"                               },
>         { 0x2b3a, "Server Supported Features"                   },
> +       { 0x2b51, "TMAP Role"                                   },

Ditto.

>         { 0x2b77, "Audio Input State"                           },
>         { 0x2b78, "Gain Settings Attribute"                     },
>         { 0x2b79, "Audio Input Type"                            },
> @@ -751,6 +756,9 @@ static const struct {
>         { 0x2bcc, "Source Audio Locations"                      },
>         { 0x2bcd, "Available Audio Contexts"                    },
>         { 0x2bce, "Supported Audio Contexts"                    },
> +       { 0x2bda, "Hearing Aid Features"                        },
> +       { 0x2bdb, "Hearing Aid Preset Control Point"            },
> +       { 0x2bdc, "Active Preset Index"                         },
>         /* vendor defined */
>         { 0xfeff, "GN Netcom"                                   },
>         { 0xfefe, "GN ReSound A/S"                              },
> --
> 2.39.0
>


-- 
Luiz Augusto von Dentz
