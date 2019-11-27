Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF30C432C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 15:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5627D20665
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 15:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0sgBcfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfK0Puy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:50:54 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40045 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0Puy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 10:50:54 -0500
Received: by mail-ot1-f66.google.com with SMTP id m15so19519297otq.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2019 07:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kirhZUL19zah9X219nc8Fqlt19vTtnBHeGEvutnpeQE=;
        b=c0sgBcfi/S4dSW80LuFux94D2ftakLtcCGUGCbH9vFVxhwCrZBmlT5rqVcYICy+fX9
         /DPmf/8s9wHJehZpI7/K2o+zeYZn4cQbYrm9B45yUsUUv5TqY81P2QdHxvmp3fe2xiz2
         34PAMjRFeJkHT+MWumqvLxFAF9rTegpXfHohl97fxGCRR6/e0BlpzSoItR1U6ZyHT03d
         jgdtHpCsOq07ZGxKGuhJgp1+NO7EE6QZf1rG5wqrOj3svA1nnOUXfNo2I+zHmNxzFDPZ
         vbw7peFAw2/BapCzxWfIjTqVCRLE1ghhK5buGzcSUxhk3k/OPR7in4WmAD3eBocRmcnC
         0JLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kirhZUL19zah9X219nc8Fqlt19vTtnBHeGEvutnpeQE=;
        b=XJ2g9r84Nkxq/WFXwh9nUBaNLMXuevXzEwMMKTwmY1gwYPiFEg7lzxwMajT6ffr2Cx
         d1bPsS41yVl9NVRY85IhistLt+cOoacyvOiF9XgrGb9hlyztqJrSkwtkLQxsJmuQt8cV
         JMRMx/5+fEM4I0kZ7ThUS0+DPQffc2z5O3ObZUCfN3GYls0yaZZa0hiSFdl3UMhsfNjQ
         nYQplaJ6ac8ribfmsmzWo7s/2xnv2yX8PWiN0ytGUaXqvt8IZRYsijY+m7s9/wGXGtNB
         3xZGyg6T5nHpLiiyGAAXqiOG1n8VePEX6EKYcq3o+1mYzaBEajC4GIC7yU5ljMa2Nn6M
         CNlQ==
X-Gm-Message-State: APjAAAUUN5//TjZbbtvfrOQYOnoAV0/VygmDBLxZvs42qVhFTnzipvn/
        l6RHfUWCWrE6I+CbbvsCKyhYuZNW5h9eB1wEVlHXRU4PAk0=
X-Google-Smtp-Source: APXvYqw6AlzQxX+SuIpr49/tA8UrNNuw9qSrvdAKN7DkZ9jeEPdk8cKgPPjSleuuvy2TG6Ivuw+4uU80xA1p9EBBSpU=
X-Received: by 2002:a9d:7642:: with SMTP id o2mr3803350otl.177.1574869853205;
 Wed, 27 Nov 2019 07:50:53 -0800 (PST)
MIME-Version: 1.0
References: <20191126212753.18455-1-pali.rohar@gmail.com>
In-Reply-To: <20191126212753.18455-1-pali.rohar@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 27 Nov 2019 17:50:40 +0200
Message-ID: <CABBYNZ+X1xThm9rrcj7ny9f9r0sVs-fTR2JroQdRgZTRWLcN6g@mail.gmail.com>
Subject: Re: [PATCH] avctp: Set more descriptive name for uinput device
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Tue, Nov 26, 2019 at 11:31 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> ---
>  profiles/audio/avctp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> index 70a3e40b2..ae53587ad 100644
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -1181,8 +1181,7 @@ static int uinput_create(char *name)
>         }
>
>         memset(&dev, 0, sizeof(dev));
> -       if (name)
> -               strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - 1);
> +       snprintf(dev.name, sizeof(dev.name), "Bluetooth Audio/Video Remot=
e Control%s%s", name ? " " : "", name ? name : "");
>
>         dev.id.bustype =3D BUS_BLUETOOTH;
>         dev.id.vendor  =3D 0x0000;
> --
> 2.11.0

It is already setting a bustype to BUS_BLUETOOTH why do you need to
make it more specific, btw it needs to be limited to
UINPUT_MAX_NAME_SIZE. Id say if we want to make it declare the
connection type that probably something that needs to be encoded in
the bus itself, like BUS_BLUETOOTH_AVCTP, BUS_BLUETOOTH_HOG, etc.

--=20
Luiz Augusto von Dentz
