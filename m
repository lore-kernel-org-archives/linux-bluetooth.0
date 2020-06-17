Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCDAC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 12:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C383C20786
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 12:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+rI35qJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFQMuv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQMuu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 08:50:50 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4EBC06174E
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 05:50:50 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c11so1207906lfh.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWWSxu84QgwG87fUszInV+LIVHh8hkqFZ6P3p/1B6ag=;
        b=X+rI35qJ8/hZk9RRIh2L7GiMzOqK5oFRMQuD/l9i+EysQFoSf9D/yeXm7yxCZi3wJH
         BasssiMIbVl7H6YLtczbBgM/mv1VKhGIWUd8+om8R89hw4BEtlcZmCKlH0+2vYiR+eLA
         3d3aVf6BqpMqKyPhWFwG06upQ5tWA7VIPJjeQ4TzKHCGZE8V86xN5frLzoU9kpeNSXGF
         vwFT5cnLzKi61vTLt1WpN0quvs9ei5ikdw6ycBod65qvKfEHGcHZHTZVFgq/fOS/C6sR
         2gVEoBmfFVDT7kvBH957ohrrMxrn8LCl9uzrxWpTuzcuGgpyXdhI4/KQrJqOQOafnAj0
         3nuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWWSxu84QgwG87fUszInV+LIVHh8hkqFZ6P3p/1B6ag=;
        b=ievKg2F2S33rgVx6+OxI8cgfsOu+0THCPU4K9ER6HwXrVQnmvaeziXJZb1AjpIHifw
         4QvtGLqXw/B7P+Sq+S0ribS2QZkGE9ioRi7LE5P24YBPbnlKH3nGOhgdXeNPbe8tTAQH
         GgzkcYrEAdzQH6AA7qKccwKCOpYBIhZT3K/C9z3X1SwJnn35mDCBuHCrH/AuoclijVCU
         CtxvP0LImNFEtzKTa55Vw7XRAvnpxKNzVq3Es44KJrAMl0m1p8M4bvkY7xHMr81i5eyb
         S19AYYygq18ymaVZPr8ZMhuUNAcnulVgWN/sNs02X379YojYPjPo+bDeNLoulTn3CCCe
         854g==
X-Gm-Message-State: AOAM533Dgkph/2bgZaWjiCmeNc67BfLy+/LO0rkc4IIWt/Pyv4Xv1SFK
        9SK1U4kuyuWruXRF7KR59SlwvFwzYS1WpVIcVM08rw==
X-Google-Smtp-Source: ABdhPJwVb8VSqIsrq2tnRb8/iDvUJEMlbVhDuNtEB47tzPFPoqxX22Zj6SEkaY80B8yC29Yrc2znU6uvyi90+bMh7cQ=
X-Received: by 2002:a05:6512:3190:: with SMTP id i16mr4471126lfe.158.1592398248395;
 Wed, 17 Jun 2020 05:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592390407.git.marcel@holtmann.org> <dd2310913558d6c63e193ea111ef2681e5911837.1592390407.git.marcel@holtmann.org>
In-Reply-To: <dd2310913558d6c63e193ea111ef2681e5911837.1592390407.git.marcel@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 17 Jun 2020 08:50:36 -0400
Message-ID: <CALWDO_Vz2LiAW338=bo+kj0z+tLeA4vf3an-hdYwdVrSAOkDVA@mail.gmail.com>
Subject: Re: [PATCH 14/14] Bluetooth: mgmt: Use command complete on success
 for set system config
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,


On Wed, Jun 17, 2020 at 6:43 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> The command status reply is only for failure. When completing set system
> config command, the reply has to be command complete.
>
Reviewed-by: Alain Michaud <alainm@chromium.org>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt_config.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
> index 8e7ad2a51dbb..8d01a8ff85e9 100644
> --- a/net/bluetooth/mgmt_config.c
> +++ b/net/bluetooth/mgmt_config.c
> @@ -247,9 +247,8 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
>                 buffer += exp_len;
>         }
>
> -       return mgmt_cmd_status(sk, hdev->id,
> -                              MGMT_OP_SET_DEF_SYSTEM_CONFIG,
> -                              MGMT_STATUS_SUCCESS);
> +       return mgmt_cmd_complete(sk, hdev->id,
> +                                MGMT_OP_SET_DEF_SYSTEM_CONFIG, 0, NULL, 0);
>  }
>
>  int read_def_runtime_config(struct sock *sk, struct hci_dev *hdev, void *data,
> --
> 2.26.2
>

Thanks,
Alain
