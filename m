Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DD7C35280
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 22:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0445720725
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 22:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3Q0uPmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgEGWIA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 18:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgEGWIA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 18:08:00 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B88C05BD43
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2020 15:07:59 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id x16so1704536oop.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2020 15:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNwiAm93nnSW1f6GtAEPc89fS7/opLHiiKUT30sRhCg=;
        b=C3Q0uPmx707kb5OgcOhPJykkfWXzSroWEt74e5isa8Cur8RRWsb7F/U5ZtfOt1qS6i
         Z5TD+9xfyDLorhN0Nn2A2cBjIGglOv1V0JjIlAzfgaFX9rRAE3kO0yubZBau+o6lJ0g6
         h5VSOQ7y7+ONjgsmpKLKt/fd1WXVoNMUOoOiuO7NK1S+yhITuLqaXBDngWiliYOzoUhk
         9Z0mgIraGuUebUwKuscPIMZUO4ieqm3J6YuG5zxTCMSg3pX42KL0wlKbSX6Wv2d9F326
         29SbcaqpTUQR+7ZUNqtkAb/jBM8n/L5vEd0Z48cXYcCPYNkILJ5skAa3n/B2sp3wgMDd
         IajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNwiAm93nnSW1f6GtAEPc89fS7/opLHiiKUT30sRhCg=;
        b=rDiWrfCy+a6Au+phkfjwPpV/mDUUYG2r2cYkLKRO8ZLarAnUU1Turm1HYXKje5+hUr
         lZPj7GhWdoFq8Kriv2RVnehfi3DSp9Ubm0Hqvye5Bgq2wFOpdiUp7oU+39ngVIq7Tl20
         9Lg0r2Z5hmx9c87vXxPI03D8XzrCg4ANA8O4u2nL5aI2FUQxYoaI8tWpGXLu13U7xM+2
         Cf4CGKjWZ6nQaH5aJsB/jBKS3sH7uZytCaT8iT0VlQVRX3v4U0dx+zFMZKPgKmc4NAkS
         fucXU3mhgGTzqtaTcq9Npoh0qdex+EAT3AH/KTmoxznBsaTHQw8dX3CGuR3pulMnePzU
         ww5A==
X-Gm-Message-State: AGi0Pua7xmBC1Ic39d3xrTz+NKaWuMGqWF7rpdn6Gs2niBn/Di/ZuOXs
        U7WY7v5GqeoVGGfwmDgI9HtcwoeQSWIKQTcF6TeYxGqzTmE=
X-Google-Smtp-Source: APiQypJRSZynBq8O2eU0/nW1XApn+FvVw2mFPLSCIXb+SbbkOusvOYb8ASxPIwtRLd23NqJ076swp0ierUxNVKgU1Vs=
X-Received: by 2002:a4a:3445:: with SMTP id n5mr13448174oof.91.1588889278841;
 Thu, 07 May 2020 15:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200507141055.Bluez.1.Ie4c027829af0f3ca2ba0e532706584a554a69d38@changeid>
In-Reply-To: <20200507141055.Bluez.1.Ie4c027829af0f3ca2ba0e532706584a554a69d38@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 7 May 2020 15:07:45 -0700
Message-ID: <CABBYNZ+DJqfK8OoDJmp+OuJ7y4ML+31jdWNRzsEb7O6CDv3dsg@mail.gmail.com>
Subject: Re: [Bluez PATCH] shared/gatt-db: Check for null pointers
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Thu, May 7, 2020 at 2:11 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Make sure the attribute, service and service attributes are not null
> before accessing them.


For this type of problem I would recommend using valgrind to
backtrace, since this is not very readable we might not want to add it
to the git history, that said the actual problem seem to be related to
using gatt_db_attribute_get_service_data while the service is being
removed, in that case I guess it is fine to set the service to NULL
before removing it to indicate the it is in the process of being
removed, we could perhaps introduce a unit test for this type of error
so we can detect regressions with the likes of make check and CI when
that starts to use it.

> The problem was seen with the following stack trace:
>
>  0  bluetoothd!gatt_db_attribute_get_service_data [gatt-db.c : 1648 + 0x0]
>     rax = 0x0000000000000000   rdx = 0x00007ffce8cf70ec
>     rcx = 0x0000000000000000   rbx = 0x0000000000000000
>     rsi = 0x00007ffce8cf70ee   rdi = 0x00005a56611f05c0
>     rbp = 0x00007ffce8cf70d0   rsp = 0x00007ffce8cf70b0
>      r8 = 0x0000000000000000    r9 = 0x0000000000000050
>     r10 = 0x0000000000000073   r11 = 0x0000000000000246
>     r12 = 0x00005a56611cea10   r13 = 0x00005a56611efd90
>     r14 = 0x0000000000000000   r15 = 0x00005a565f3eed8d
>     rip = 0x00005a565f48147e
>     Found by: given as instruction pointer in context
>  1  bluetoothd!discovery_op_complete [gatt-client.c : 386 + 0x14]
>     rbx = 0x00005a56611e9d30   rbp = 0x00007ffce8cf7120
>     rsp = 0x00007ffce8cf70e0   r12 = 0x00005a56611cea10
>     r13 = 0x00005a56611efd90   r14 = 0x00007ffce8cf70ec
>     r15 = 0x00005a565f3eed8d   rip = 0x00005a565f47a6bc
>     Found by: call frame info
>  2  bluetoothd!discover_chrcs_cb [gatt-client.c : 1000 + 0xf]
>     rbx = 0x0000000000000000   rbp = 0x00007ffce8cf71d0
>     rsp = 0x00007ffce8cf7130   r12 = 0x000000000000000a
>     r13 = 0x00005a56611de920   r14 = 0x00005a56611cea10
>     r15 = 0x00007ffce8cf7188   rip = 0x00005a565f47b18a
>     Found by: call frame info
>  3  bluetoothd!discovery_op_complete [gatt-helpers.c : 628 + 0xc]
>     rbx = 0x00005a56611f0430   rbp = 0x00007ffce8cf71f0
>     rsp = 0x00007ffce8cf71e0   r12 = 0x00005a56611ea5a0
>     r13 = 0x00005a56611cd430   r14 = 0x00005a56611f0430
>     r15 = 0x00005a566119bc01   rip = 0x00005a565f47d60e
>     Found by: call frame info
>  4  bluetoothd!discover_chrcs_cb [gatt-helpers.c : 1250 + 0xe]
>     rbx = 0x00005a56611bf0f1   rbp = 0x00007ffce8cf7240
>     rsp = 0x00007ffce8cf7200   r12 = 0x00005a56611ea5a0
>     r13 = 0x00005a56611cd430   r14 = 0x00005a56611f0430
>     r15 = 0x00005a566119bc01   rip = 0x00005a565f47cc7a
>     Found by: call frame info
>
> ---
>
>  src/shared/gatt-db.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index b44f7b5e9..2432bdfd4 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -513,6 +513,7 @@ bool gatt_db_remove_service(struct gatt_db *db,
>                 return false;
>
>         service = attrib->service;
> +       attrib->service = NULL;
>
>         queue_remove(db->services, service);
>
> @@ -1605,7 +1606,7 @@ bool gatt_db_attribute_get_service_data(const struct gatt_db_attribute *attrib,
>         struct gatt_db_service *service;
>         struct gatt_db_attribute *decl;
>
> -       if (!attrib)
> +       if (!(attrib && attrib->service && attrib->service->attributes))
>                 return false;
>
>         service = attrib->service;
> --
> 2.26.2.645.ge9eca65c58-goog
>


-- 
Luiz Augusto von Dentz
