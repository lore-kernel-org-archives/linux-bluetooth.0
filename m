Return-Path: <SRS0=mBsK=AM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3681C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 00:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97CD720771
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 00:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHzISLRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgGAAa5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jun 2020 20:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgGAAa4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jun 2020 20:30:56 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951BBC061755
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2020 17:30:56 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 5so18070877oty.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2020 17:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TKvRpCUpNSBLmtj5feOgRrmzFRKa8EAlVS6hQKObv4M=;
        b=bHzISLRKT4OYeZhPc6OnMqA+UWkxB36SABdA/LC8cuqm12qArfpT5gJkUIXgAsPpYb
         yDGUzev8s6ZKHCHFKg5+JMzxlBYWdIHPijJ0JguK+3xfloey68fpXwsVMfgz8wpac2T4
         8LH8T3vcrBRzpqYjX0GKGJwAv7ZFjxqf4Lzyvjyst/g4Pk3tZkS3F+qwZHK3tnZfrxPz
         Mp29NRIEQQMXg5cZVk/uAVugCWsIAbokckCBmFCGnco+AAxgWWJsApAw+2PbwG4YNumo
         lrR3cH62B7l2FBqhLssjvs4T+J51GJIS3uBW1ejj8/LRbOM91RIfF50mk8pwBWc+XUa8
         2brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TKvRpCUpNSBLmtj5feOgRrmzFRKa8EAlVS6hQKObv4M=;
        b=AhATb1Skn7cHf0pSlA/msK4SLa7p6KdL6j0QTYkyKGSA/Y++Agn7l2KWg8bAQc+7yI
         dzLZofOwC/OTthdTGvUTWOmbz0vzYyExGEGvx0mFEfxi6RXfwAZztaLMRCAv7Z+8S3ro
         Z2b7Fs2yEUU4di5veXihlxzMlKlO/yhGhAbDLnY+OA56ENsB6D8eGeuNTxfNBY/F5qet
         5RhGDYOXQsRTTbXNAimLejXRYXDPSzADOigwh6yIHgVz8jjHl6I2wY2LHaGNGwac4N96
         tCXGyYrBnwsBTEVPczcpYPEcQQbAB977fN2Ck1YyafjV2oHFKdBoxp6eRE3HKJAOoiNn
         wcMw==
X-Gm-Message-State: AOAM530sBZRI8G93/Lew9ZnAEyEOjqD7JB08i9OTwd9feoif+d4b78vA
        7ltXk0kX7lv/50gfC69glrQivHXq0AEU0Ns3EvQ=
X-Google-Smtp-Source: ABdhPJzXGyrvuCp2/PaRSpOgZONhKBVeUnysoowGwKlLl1hl/dwVhm3BOXBcleWOLIooG0qXaIO45c/idbsKTmX4J8U=
X-Received: by 2002:a9d:6c09:: with SMTP id f9mr3176510otq.362.1593563455855;
 Tue, 30 Jun 2020 17:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200630154855.Bluez.v1.1.I63c3ddd54189c2ad9ca9aba2c08e0925d7f0aee3@changeid>
In-Reply-To: <20200630154855.Bluez.v1.1.I63c3ddd54189c2ad9ca9aba2c08e0925d7f0aee3@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 Jun 2020 17:30:44 -0700
Message-ID: <CABBYNZ+xTsRKFHZrjuxCbxR=tWYmGr79SaLsKEbscuCt3zobPw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] device - If HFP is supported, ignore HSP
To:     Yu Liu <yudiliu@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Hsin-Yu Chao <hychao@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yu Liu,

On Tue, Jun 30, 2020 at 3:55 PM Yu Liu <yudiliu@google.com> wrote:
>
> From: Hsin-Yu Chao <hychao@google.com>
>
> For a BT headset that supports both HSP and HFP, BlueZ creates
> service instances for these two profiles and connects them.
> It's uncertain that which of HSP and HFP eventually get connected
> and being used for SCO audio. And we start observing some problem
> because of this uncertainty:
>
> - For headset that supports WBS, we need HFP connect for codec
> negotiation. If HSP connects but not HFP, WBS cannot be used.

We should probably have a way to detect when one or the other is
connected and then don't attempt to connect again since they would
likely conflict when it comes to connecting SCO, that said is your
system setting AutoConnect for both HSP and HFP?

> - For WH-1000XM3, if BlueZ ever initiated HFP connection but failed,
> headset won't have working SCO audio even HSP is connected.

Hmm I guess this will need to treated separately, not sure if we can
exclude HSP to be connected once HFP fails, but then again I think the
system should not have them both set to be Auto Connected, HSP most
likely should only be set as as a fallback if HFP is not supported.

> Fix this at when device probes services, if HFP is in the uuid list,
> don't bother create one for HSP.
>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> ---
>
> Changes in v1:
> - Initial change
>
>  src/device.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 7b0eb256e..4036bfd81 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4370,6 +4370,11 @@ static struct btd_service *probe_service(struct btd_device *device,
>         if (!device_match_profile(device, profile, uuids))
>                 return NULL;
>
> +       /* If device supports HFP, don't bother create service for HSP. */
> +       if (g_slist_find_custom(uuids, HFP_HS_UUID, bt_uuid_strcmp) &&
> +               bt_uuid_strcmp(profile->remote_uuid, HSP_HS_UUID) == 0)
> +               return NULL;
> +
>         l = find_service_with_profile(device->services, profile);
>         if (l)
>                 return l->data;
> --
> 2.27.0.212.ge8ba1cc988-goog
>


-- 
Luiz Augusto von Dentz
