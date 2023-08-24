Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99702C6FA8F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 21:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbjHXV20 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 17:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbjHXV2W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 17:28:22 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947091BCC
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 14:28:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bcda0aaf47so15660001fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 14:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692912497; x=1693517297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUofa5g8hi+ll1eFktLU2mHnK4cnZ4jTFn0ws6pYCsM=;
        b=Wy5Cxz47wYqRWsa4pFZ2QdrL6cRs5mnpmRIGqivs3ac4dyfog5vVWP141Dlqxe4io8
         e/9IXrv78awYU2f90qLwgmPCWVLFSjQlDULCDpiPxqQABXzkm5EP0E5H0FJ0zLC+ghDW
         dU/qwS0M77rpQ/NLShaidEeND4cWukYZPYm2wFVpBKztL9cG750rU6FOTSXb1ZzW7jZr
         YTiJHcCINkLZm+DtSvGUrS9X1T8+RGfbGDq5r/X4xy+QOEDFvmmEVRM6+kSF4m3BgXv/
         VVkuPTRC5oCzI6HPgfj5ZgAEJTdlbSS5gXi5fOySCENb09Rz913dxUqJOZd8hU73bekm
         tt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692912497; x=1693517297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUofa5g8hi+ll1eFktLU2mHnK4cnZ4jTFn0ws6pYCsM=;
        b=hqkO/Mz8BpqQ2EIUDZvnCKKy+7jvx6AeQ9pvd9u5l19EfTRaKY0aR6Jw5mQtANViqS
         JfPsHk583QKxdYJEinamsyffg2wAXxVXQtMD/Dv/6edwaJiDtVutW9+rIuaNEfWYIxsB
         2ex8cmeB83lmT3AB1H+OXmVxUnTqdfE9CsMZ2oxfLlScpKs9tmpYtYQ2a3gfjU+Zuy/y
         Aupv2dPSkr5gS8kqaua5oeJhmHWnn0q9vQoYifnp6/aY7dXip09k5xxjIG8U1SYEfLGF
         4bGv931eMSlkprby13+dFKWmIDr0RhVzqR421g4gShQy4gsDoFic515tFFJ+wbbU60Z5
         f4zw==
X-Gm-Message-State: AOJu0YxA6+SAkUhRUAfdHj1wfcgJpJcj4bMPP2BxaiezSt6VV9AoQScc
        xm3Mu6VyvuBntkT4KEVESDq/gyZvqsJBUzpGVvNSdQR9
X-Google-Smtp-Source: AGHT+IGUMnNQq++uVtcCb8OBXyecCSILCPjGDiH4q9C25FzdE4Dk5YVivpwE0iigYXn73UEbAxeviRYbDz2ZAhUEE1o=
X-Received: by 2002:a05:651c:31b:b0:2bc:c655:6f8f with SMTP id
 a27-20020a05651c031b00b002bcc6556f8fmr4003266ljp.10.1692912496740; Thu, 24
 Aug 2023 14:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230824212153.11050-1-luiz.dentz@gmail.com>
In-Reply-To: <20230824212153.11050-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 24 Aug 2023 14:28:04 -0700
Message-ID: <CABBYNZ+OcMjUsnJiehvnnAn-fZv+Tyy=ei3qWefJr4A3prSzbg@mail.gmail.com>
Subject: Re: [BlueZ RFC] media-api: Make QoS a single property
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>,
        Claudia Draghicescu <claudia.rosu@nxp.com>,
        iulia-tanasescu <iulia.tanasescu@nxp.com>,
        Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Aug 24, 2023 at 2:21=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This moves QoS related propertis to a single dictionary.
> ---
>  doc/media-api.txt | 44 +++++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 23 deletions(-)
>
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index 3a0ec38e244d..9f2482e73ac1 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -816,42 +816,40 @@ Properties        object Device [readonly]
>                         Linked transport objects which the transport is
>                         associated with.
>
> -               byte CIG [ISO only, optional, experimental]
> +               dict QoS [ISO only, optional, experimental]
>
> -                       Indicates configured QoS CIG.
>                         Only present when QoS is configured.
>
> -               byte CIS [ISO only, optional, experimental]
> +                       Possible values for Unicast:
>
> -                       Indicates configured QoS CIS.
> -                       Only present when QoS is configured.
> +                       byte CIG
>
> -               uint32 Interval [ISO only, optional, experimental]
> +                               Indicates configured QoS CIG.
>
> -                       Indicates configured QoS interval.
> -                       Only present when QoS is configured.
> +                       byte CIS
>
> -               boolean Framing [ISO only, optional, experimental]
> +                               Only present when QoS is configured.
>
> -                       Indicates configured QoS framing.
> -                       Only present when QoS is configured.
> +                       uint32 Interval
>
> -               byte PHY [ISO only, optional, experimental]
> +                               Indicates configured QoS interval.
>
> -                       Indicates configured QoS PHY.
> -                       Only present when QoS is configured.
> +                       boolean Framing
>
> -               uint16 SDU [ISO only, optional, experimental]
> +                               Indicates configured QoS framing.
>
> -                       Indicates configured QoS SDU.
> -                       Only present when QoS is configured.
> +                       byte PHY
>
> -               byte Retransmissions [ISO only, optional, experimental]
> +                               Indicates configured QoS PHY.
>
> -                       Indicates configured QoS retransmissions.
> -                       Only present when QoS is configured.
> +                       uint16 SDU
>
> -               uint16 Latency [ISO only, optional, experimental]
> +                               Indicates configured QoS SDU.
>
> -                       Indicates configured QoS latency.
> -                       Only present when QoS is configured.
> +                       byte Retransmissions
> +
> +                               Indicates configured QoS retransmissions.
> +
> +                       uint16 Latency
> +
> +                               Indicates configured QoS latency.
> --
> 2.41.0

Let me know if you have anything against doing these changes, this
will break backward compatibility but since they are still marked as
experimental we can still do these changes.

--=20
Luiz Augusto von Dentz
