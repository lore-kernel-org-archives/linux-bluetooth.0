Return-Path: <SRS0=Cqm8=VG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6DDC606B0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 08:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9C4216C4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 08:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9c5u3Bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfGIIO6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jul 2019 04:14:58 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39888 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfGIIO6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jul 2019 04:14:58 -0400
Received: by mail-ot1-f67.google.com with SMTP id r21so3602930otq.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2019 01:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=wpfaYU6q4Bsifaevl9UmNMpkttdjJmGrCRDldM7uAEg=;
        b=X9c5u3BiZjs5kht+F/wiFtAMnjQvs0LdVDwgHdabIAo00vsQwcpi9efkvhNc0sJvpA
         rWySVBFaGoerSOiu12Ywi07PvRGTfrBn8dlz3QUPAO5Yat9RZEJhrtyfztqFHcISPSy0
         390+HBmG4htMU1bZVpPUTXZZZlD/bC0prSKMeRbhn7cDQWaWSiYuNFD6wHuIRR/Zv76L
         RZUSO0Ohql0Sd5OYHVgdtiy+D4gEwlx4hecj1qzKWMX2tcPbDJq50F2HsXtxHnrDupxg
         oZsnPJqTVqwbUZ4GfdKkHRz1+D1uSsFggwVkixgROLAd/XenIa8jsm/YsAEcxm5HDTsI
         plOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wpfaYU6q4Bsifaevl9UmNMpkttdjJmGrCRDldM7uAEg=;
        b=HugnTaQIsXQCZWLiTHJFHqxz6/vYOwc2uJk8LhZATutJRraGNcylytbFxJHjyB6IaP
         L0dP7mKoukUUth7X3SSG6sYtJUnxLnRibMixmVoaa6OcrLBvBBD9dGoZ2XH9L+DskuE+
         KyvpKLwMhe/FvI63UQ0q1/8p7J3fYrRjLI8jFdWT5ii2xFoZHC8Kon7j5bz+9gkOzRuu
         kNwSXGb9ujBRoTuSKcvQSRTYuZ7hzkainVghlLPzybc5XZEBcGgaQHVZGJGrczaBleZ2
         y8fjujx2ykdHpzBcabrm0aYuVSsD60YN59xUVeoggc45HMRmITr9uEI8HZgs5dWBUOK8
         8mQw==
X-Gm-Message-State: APjAAAU8e3rOxAPPiStYYAICsEXFpZEicjZcAJKlg3gTy4Vqbk/IAh6X
        Ry6lmI1LtHjcXrMBJ5SR4iyFESCDOMAgcQ0+nINwUd7V
X-Google-Smtp-Source: APXvYqytMGjE+S3uoMkWR2FTfMny9Df9USV4XVWet/Q13HwXNyWnDnufe2UFpGAhf0NaMZCtbFzA+L212rCimV1v6To=
X-Received: by 2002:a05:6830:199:: with SMTP id q25mr4896154ota.79.1562660096907;
 Tue, 09 Jul 2019 01:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190703154219.6988-1-luiz.dentz@gmail.com>
In-Reply-To: <20190703154219.6988-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 9 Jul 2019 11:14:45 +0300
Message-ID: <CABBYNZJCSeXJoU6QqwDKgvWYOs+K+7A5oFxO4BT4sr-N3FmEyA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] att: Return error in case Exchange MTU is used
 over BR/EDR link
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jul 3, 2019 at 6:42 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> In case of BR/EDR the L2CAP MTU negotion is used instead:
>
>   BLUETOOTH CORE SPECIFICATION Version 5.1 | Vol 3, Part G page 2370
>   4.3.1 Exchange MTU
>
>   This sub-procedure shall not be used on a BR/EDR physical link since
>   the MTU size is negotiated using L2CAP channel configuration
>   procedures.
> ---
>  src/shared/att.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 04577eddd..0ea6d55bd 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -836,6 +836,22 @@ static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
>                 if (!opcode_match(notify->opcode, opcode))
>                         continue;
>
> +               /* BLUETOOTH CORE SPECIFICATION Version 5.1 | Vol 3, Part G
> +                * page 2370
> +                *
> +                * 4.3.1 Exchange MTU
> +                *
> +                * This sub-procedure shall not be used on a BR/EDR physical
> +                * link since the MTU size is negotiated using L2CAP channel
> +                * configuration procedures.
> +                */
> +               if (bt_att_get_link_type(att) == BT_ATT_LINK_BREDR) {
> +                       switch (opcode) {
> +                       case BT_ATT_OP_MTU_REQ:
> +                               goto not_supported;
> +                       }
> +               }
> +
>                 found = true;
>
>                 if (notify->callback)
> @@ -847,6 +863,7 @@ static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
>                         break;
>         }
>
> +not_supported:
>         /*
>          * If this was not a command and no handler was registered for it,
>          * respond with "Not Supported"
> --
> 2.21.0

Applied.


-- 
Luiz Augusto von Dentz
