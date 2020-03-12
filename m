Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FCFC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 23:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02C5206B1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 23:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJk5DZ8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgCLXaA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 19:30:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37085 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgCLXaA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 19:30:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12so2947234otp.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 16:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WGWnlBzJ1++4eE6BpPyY5NxIR90Kk+UTouezIUddjNk=;
        b=lJk5DZ8/MTKBy6N1iLReKSkGyBWtS6ym2ptoS9+3IWu3WcDo3OCdwJIGo0LxoTCuRL
         5BpcpZOlRlBzZ6SNwX0AJTIly8pHXNr1bpiskSshUXGZHwCgXxVs8jAvt1lVUfSB4+DX
         c4NCWX1EdSoa3T8beMcPCfPMRHOZ4wYASIXFbp0/gUeP2yyL4s7gLTRXuYSqTwzmyXkj
         1ljTtx0v7wt3ksT9o/NNiKqJ4qUntDYdYm7YABBE6sVXWJuNDwOyF32Cz1IUxv7Feh5P
         S9b7tPEKSdQCgQAEPlMqp03lK2qF2WO7jm51kdnNvcCf5w+TUYjMk5TeB6oFLA5VNk6y
         dVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WGWnlBzJ1++4eE6BpPyY5NxIR90Kk+UTouezIUddjNk=;
        b=pFDagt5DfufFmh3czuwoc3dI7PxlPrqzl0XpvHDdl3ppeURKCZ7DPOs51i3KnASEGE
         gs0e0cfk1T0z2iBhsiky72G/ruDo2qr+PAXNCN1uTcveHpGxn8VxvCEIRP4dbVFq5wCq
         lQYhmdk9Zo6Oai8q59FHBXjlscebCNlMykIVdh3FXs0grF04/L9rCRBEDws2AlKZp7aL
         ZzfIP9AatCosequ3GSUmlLwOinoxw5DVysks+OdgGbVNQIs25TtNpAaLJVTHyE5BWwP2
         BL5gIw0pXiYdIq95STGp1c3iyUwEP+rcb2AMN28CCZS4IMd83yxXtgQmB6Uj+MCmY+CR
         DMeQ==
X-Gm-Message-State: ANhLgQ3FcIy8qro1MAfsuoi5t349i4Fb0NQkcx/ZYe0sTTQ+ryVHa7n6
        KGVyFiiUHNXM+zPUdky8wWvkUO3A5+dXbDW3LBE3Ri97
X-Google-Smtp-Source: ADFU+vt2jhvizbJ6vqmQTytgOCXlhHemMWmIc7LGpXIntv5MKZvxu9vd/wnY/1nPHrB82Lp6pMM5PNBbv8+eW2KPMaE=
X-Received: by 2002:a9d:3f4b:: with SMTP id m69mr7949038otc.146.1584055797828;
 Thu, 12 Mar 2020 16:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200312073045.26416-1-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <20200312073045.26416-1-lukasz.rymanowski@codecoup.pl>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 12 Mar 2020 16:29:46 -0700
Message-ID: <CABBYNZLdsqBGUUxyv_TSggqEKvzYT-gFEK_abAii4q3BfdadHg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor: Fix for incorrect len in L2CAP Enhanced Reconfigure
To:     =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi =C5=81ukasz,

On Thu, Mar 12, 2020 at 12:32 AM =C5=81ukasz Rymanowski
<lukasz.rymanowski@codecoup.pl> wrote:
>
> ---
>  monitor/l2cap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/monitor/l2cap.c b/monitor/l2cap.c
> index 9409604c3..41c766863 100644
> --- a/monitor/l2cap.c
> +++ b/monitor/l2cap.c
> @@ -1408,7 +1408,7 @@ static void sig_ecred_conn_rsp(const struct l2cap_f=
rame *frame)
>         const struct bt_l2cap_pdu_ecred_conn_rsp *pdu =3D frame->data;
>         uint16_t dcid;
>
> -       l2cap_frame_pull((void *)frame, frame, sizeof(pdu));
> +       l2cap_frame_pull((void *)frame, frame, sizeof(*pdu));
>
>         print_field("MTU: %u", le16_to_cpu(pdu->mtu));
>         print_field("MPS: %u", le16_to_cpu(pdu->mps));
> @@ -1426,7 +1426,7 @@ static void sig_ecred_reconf_req(const struct l2cap=
_frame *frame)
>         const struct bt_l2cap_pdu_ecred_reconf_req *pdu =3D frame->data;
>         uint16_t scid;
>
> -       l2cap_frame_pull((void *)frame, frame, sizeof(pdu));
> +       l2cap_frame_pull((void *)frame, frame, sizeof(*pdu));
>
>         print_field("MTU: %u", le16_to_cpu(pdu->mtu));
>         print_field("MPS: %u", le16_to_cpu(pdu->mps));
> --
> 2.20.1

Applied, thanks.

--=20
Luiz Augusto von Dentz
