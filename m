Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DCDC43333
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jan 2021 11:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0E9223E8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jan 2021 11:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbhATKxQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jan 2021 05:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731352AbhATJan (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jan 2021 04:30:43 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625BFC061575
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jan 2021 01:30:02 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id q1so45556016ion.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jan 2021 01:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXnCQaFoN6zYNhlDyZj1ad3fJtl0cQMsuDiNvJ/vr7o=;
        b=CfaWD5R5FjMdE5mn+dfDRn0c0nkeNHtywsXF+o+Egmn8wq1BJNpu1WEx+mJh4P0FB0
         v+7APh3CzKz4nsD3cjUeoguWuVpYqI4V6GXnnQohpnu1X+X32AaAyuIy4P64sXwJ4ipI
         4i0XVzlHV7hiXBvQhqxolZ5McnkJeKEKcxTkt3PAIdpiNagLUcb8gzvXkUPhdUGWfn8x
         JI95OKxwNSgjKn4Zcjfji0Kh7IcKGk9y8YGCMwQSugHaUpthDo0demevS1cBqwLR5o1z
         yG4wAK9FRwuVjx80jZrrTTE00VmZQTkI/EPg1iz8otbEyvTtTi4qNyfMzuIZta71iese
         N+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXnCQaFoN6zYNhlDyZj1ad3fJtl0cQMsuDiNvJ/vr7o=;
        b=SiqH+SsDHtxZJxlDFX5+FbvqGVmS5ESzWz2Gk3sTVF7vxQk/w6Kowf0rKGou+IC5Cp
         +6hH0zTPE5L8Ii+F7MvxBkIbEx+XDYB5Qmhl711HXNurcwL222WsIh77cHf8O1UaoSKg
         bfzoipX/TBvhmNiHN319OrhxMxhh/vm/2m0+1bf7DkqCCO86LxhKrBNDnBy0OlJ7VjJx
         UWSSyWAVlq9jtPNBo3D9NVsOuXGobChVsyqKVen5GPvgHvY7gAI1cv78bvAtljLirrkw
         jJj7xstW5XJ/r5LyWejXzPEDW+SQdBoUiNdh9VLYFs1L9Ady+7xQTq62VEpeGLTXZwAu
         46aA==
X-Gm-Message-State: AOAM533sPzGhddz388XLwgpO5E8HWuumIJ15RxgQ1NRv4unE5SJrWkCy
        5857cwsC60Mqp92kk84me/DpuD3cuNNdPe1GQW0=
X-Google-Smtp-Source: ABdhPJwWSY3wvo7pVIWPPslY71VOEeHBhaH2gLJZLaxNXuJXRfCFoN0ZcHCOO2IdxDzy/Vk9qM4OcOB7jHXQHDphyDY=
X-Received: by 2002:a5d:9041:: with SMTP id v1mr6140724ioq.155.1611135001698;
 Wed, 20 Jan 2021 01:30:01 -0800 (PST)
MIME-Version: 1.0
References: <20210108211513.5180-1-luiz.dentz@gmail.com> <20210108211513.5180-4-luiz.dentz@gmail.com>
In-Reply-To: <20210108211513.5180-4-luiz.dentz@gmail.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Wed, 20 Jan 2021 14:59:50 +0530
Message-ID: <CAOVXEJL6VTmiPRymnHepGgcMtDeNvouav049wLdQHg0ogWrjWg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/4] gatt: Fix assuming service changed has been subscribed
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz

On Sat, Jan 9, 2021 at 2:48 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Unfortunately assuming service changed has been subscribed may cause
> indication to time out in some peripherals (Logitech M720 Triathlon, Mx
> Anywhere 2, Lenovo Mice N700, RAPOO BleMouse and Microsoft Designer
> Mouse) even though the expect actually mandates that the client responds
> with confirmation these peripherals just ignores it completely which
> leads them to be disconnected whenever bluetoothd is restarted or the
> system reboots.
> ---
>  src/device.c        | 11 ++---------
>  src/gatt-database.c |  2 +-
>  2 files changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/src/device.c b/src/device.c
> index fe885aa64..af13badfc 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -5831,18 +5831,11 @@ void device_load_svc_chng_ccc(struct btd_device *device, uint16_t *ccc_le,
>         key_file = g_key_file_new();
>         g_key_file_load_from_file(key_file, filename, 0, NULL);
>
> -       /*
> -        * If there is no "ServiceChanged" section we may be loading data from
> -        * old version which did not persist Service Changed CCC values. Let's
> -        * check if we are bonded and assume indications were enabled by peer
> -        * in such case - it should have done this anyway.
> -        */
>         if (!g_key_file_has_group(key_file, "ServiceChanged")) {
>                 if (ccc_le)
> -                       *ccc_le = device->le_state.bonded ? 0x0002 : 0x0000;
> +                       *ccc_le = 0x0000;
>                 if (ccc_bredr)
> -                       *ccc_bredr = device->bredr_state.bonded ?
> -                                                       0x0002 : 0x0000;
> +                       *ccc_bredr = 0x0000;
>                 g_key_file_free(key_file);
>                 return;
>         }
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index b7d2bea1d..d99604826 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -333,7 +333,7 @@ static void att_disconnected(int err, void *user_data)
>                 handle = gatt_db_attribute_get_handle(state->db->svc_chngd_ccc);
>
>                 ccc = find_ccc_state(state, handle);
> -               if (ccc)
> +               if (ccc && ccc->value)
>                         device_store_svc_chng_ccc(device, state->bdaddr_type,
>                                                                 ccc->value);
>
> --
> 2.26.2
>

Was this patch is merged?

Regards
Sathish N
