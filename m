Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81EFC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 18:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjCOScY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 14:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCOScW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 14:32:22 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D028B8F53A
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 11:32:16 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id 89so6516813uao.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678905135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKhUAmHOEanNqoxa8DwVH8mGkWsm17ddlQ4pTLKkNNA=;
        b=ECKBj6fKINoZEcUHmhvITRahQArZUmwQOu55ZP3xV34wKHWHX2QuiHuCdIaklrgTW3
         nRx/KnuES5s4SV01Ei9gtTO9NRDa7zb4hI7rQpTJ8N2ZSvqgHXT4cvS7kM4ejCAxb05Z
         eX6EShl6BTu4wp8SmxecPd+jPk4KYRWNruK/8wchOQDCmC5993HkJ/jJF9SaQbcMGtQe
         UnZZhrOqoe4+EQqA//du/roQyW8mNoC6yGlfzQ+aSyRtj1aeXsuPvnaWRc4WppuvQ5DT
         EKDoiXXIkKDfEKtLPKZnKl40e7+PLyKit3QxGbF0LRPlJ5h5MHrCh4g8bF+IfOy73g29
         GF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678905135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKhUAmHOEanNqoxa8DwVH8mGkWsm17ddlQ4pTLKkNNA=;
        b=IXV+ZA/pHliDlHT3TnBDf+bF3IpYs0uR9SrHKSgpVmMt1zkxFh+Ur9yGP8eo+60Zu9
         wyt8krkbwm3bB/NCJmlK+d/LggqzR1N/dwszDLuo3ScYxuwnjbs+Z1Tnub+vo8jKKX8+
         M7NAGQCSgppRozvCy583iocedqDG8w6XzzqmsboiEX7JgE+aaCXbLkuoyOrHe4ekRGlJ
         8k4R1m/Ls0YBZyHR1Dasp2TYzUVsHngc4Vfdp2wQUHeiPVx+CxPb08h9/tBJcDF8Uidm
         n8kOB8jp1d/nWTpH0XP926T4/qUdE965HkWH1fo4ba1uKJiBHTLEFI+ewj03IAm/yCx4
         0trQ==
X-Gm-Message-State: AO0yUKWKboVEm2+Iah/EBMiZy4mIEqVcrbqFArt4tjSUA0y/571ChhKP
        zjAyiFdu/0PC46ePh7v1ZkDUAJQRgIer4wsa0h7G0ye7xZk=
X-Google-Smtp-Source: AK7set9yWYipuh2osY81xfMZijo1vEUuBvwvlGCUWEkdN70qgHh4fx71uVaGy/ZXgx3BHmnoclfXFTaInTBBfOAu1J0=
X-Received: by 2002:a1f:4a81:0:b0:410:4a2c:1e9a with SMTP id
 x123-20020a1f4a81000000b004104a2c1e9amr23880156vka.1.1678905135638; Wed, 15
 Mar 2023 11:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <e856ad3174024bb61113217cb889005a0bf0ad1c.1678902782.git.pav@iki.fi>
 <d33ba431a0b89d8dc80b0da984316d9936be54f4.1678902782.git.pav@iki.fi>
In-Reply-To: <d33ba431a0b89d8dc80b0da984316d9936be54f4.1678902782.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 15 Mar 2023 11:32:02 -0700
Message-ID: <CABBYNZKDfGozd=Ud1_GSN821t2=dqtNYTiQ5Z89TfNQ2aF9N3Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] doc: update ISO Transport properties to match implementation
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

HI Pauli,

On Wed, Mar 15, 2023 at 10:54=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Document the transport QoS properties. Fix documentation of Delay, it's
> microseconds for ISO.
> ---
>  doc/media-api.txt | 44 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index 281f72c1e..eac7f081c 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -773,12 +773,17 @@ Properties        object Device [readonly]
>                                 "pending": streaming but not acquired
>                                 "active": streaming and acquired
>
> -               uint16 Delay [readwrite]
> +               uint16 Delay [A2DP only, readwrite, optional]
>
> -                       Optional. Transport delay in 1/10 of millisecond,=
 this
> +                       For A2DP: transport delay in 1/10 of millisecond.=
 This
>                         property is only writeable when the transport was
>                         acquired by the sender.
>
> +               uint32 Delay [ISO only, optional]
> +
> +                       For ISO, presentation delay in microseconds.
> +                       Note the value type is different for ISO and A2DP=
.
> +

I don't think D-Bus introspection allows polymorphism of properties,
so either we just use uint16 and limit the maximum delay to 65K or we
have say it is in milliseconds given that in most cases the presets
have the Presentation Delay as a round number.

>                 uint16 Volume [readwrite]
>
>                         Optional. Indicates volume level of the transport=
,
> @@ -804,3 +809,38 @@ Properties object Device [readonly]
>
>                         Linked transport objects which the transport is
>                         associated with.
> +
> +               byte CIG [ISO only, optional, experimental]
> +
> +                       Indicates configured QoS CIG.
> +                       Only present when QoS is configured.
> +
> +               byte CIS [ISO only, optional, experimental]
> +
> +                       Indicates configured QoS CIS.
> +                       Only present when QoS is configured.
> +
> +               byte Interval [ISO only, optional, experimental]
> +
> +                       Indicates configured QoS interval.
> +                       Only present when QoS is configured.

This should be uint32

> +               byte Framing [ISO only, optional, experimental]
> +
> +                       Indicates configured QoS framing.
> +                       Only present when QoS is configured.
> +
> +               byte PHY [ISO only, optional, experimental]
> +
> +                       Indicates configured QoS PHY.
> +                       Only present when QoS is configured.
> +
> +               uint32 Retransmissions [ISO only, optional, experimental]
> +
> +                       Indicates configured QoS retransmissions.
> +                       Only present when QoS is configured.

And this should be byte

> +               uint32 Latency [ISO only, optional, experimental]
> +
> +                       Indicates configured QoS latency.
> +                       Only present when QoS is configured.

uint16

> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
