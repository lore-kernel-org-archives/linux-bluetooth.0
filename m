Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBCBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 23:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiAUXTH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 18:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiAUXTG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 18:19:06 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC4DC06173B;
        Fri, 21 Jan 2022 15:19:05 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id c10so31873029ybb.2;
        Fri, 21 Jan 2022 15:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i0MqnfhvrrNm0+DYJzeNHyL5ZK776WS/fCf9Zqaayfw=;
        b=nU7E61IZBKXP96lCGxO6PmZrwPoC2JZkXyLL2SgvNyuTmGDiI1QUw9WWOk+22eX3uG
         1vCSnfu1VniADxUqPO3/+vLo+CRHPYsMKuP4KmuGZXZE5e/Nyewnq3iTd7zcTtmO24R5
         Eh6hbxS7M0TGdLlIW5kXyo6HglzxiPtzTh9UNHNZ6RDzdfoiVYhKR52bgTClosZ31/Mp
         Od+QPf6zFfnhqdG/HJbzGoqli8NGukzWqAfRZlpE5bXfoLzEwGnsB+BHV4ADxn6nOzj1
         ME/y372+JgNM9Ygem0LwaalWyWDxeYIaZ2tQp6VJSrKiQT5CR1eLindcPYIw4Vclu6Nj
         2o2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i0MqnfhvrrNm0+DYJzeNHyL5ZK776WS/fCf9Zqaayfw=;
        b=wGWcU+pBoU/bFKAeloJhs/T4DAu+jGCIZ9ik7JxrTpkmct10ZPUkNqv2XLAI6Klamg
         6bK/Wh3yM2YhRJA5a6ra1uuXIAYHJ9zpfxM3kugavQE/i/tYe+BJQWQI+8syI1Z90Wpx
         JmVdCPMWUp0LBSSPP5X+6k+U7EGaik+eX/6nTt2ZcZ0QRZWuPVMNjqVeGtly9of/GLL9
         o8i8GlDVqdMG6lw3XKhEjKeBHvnMgPf/unSTy7FuvTOATNVXHP4xCZ8VEma/vEMVEUOu
         FLgGLQoEUFctmL1iuUUfmW3kFoUyPOmTfkD1zlo3fA2TDg6bVZ0/9aL+tkldkhGdy56I
         lEjw==
X-Gm-Message-State: AOAM5307eSNDW2Jb8E97Js+HZO7VspESvKH/dHx7fOSPjwcrrJ5WQM4l
        u92Zf9vsNZ0hQ4BKKptI1vHeMPJFGia2G22xewWob/SiNeBwsA==
X-Google-Smtp-Source: ABdhPJyqLvjVlApKxi9xKBBgMwGawPDx6GPTfXn5raCKFLqp6r2kVHzgw17Auj37v+knGAdx+2fW5Jg4CHWX23q5woQ=
X-Received: by 2002:a25:b683:: with SMTP id s3mr9277279ybj.293.1642807144997;
 Fri, 21 Jan 2022 15:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20220111072319.GH11243@kili> <5202DA51-7BA4-41F1-BECA-858B894EC4F0@holtmann.org>
In-Reply-To: <5202DA51-7BA4-41F1-BECA-858B894EC4F0@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Jan 2022 15:18:54 -0800
Message-ID: <CABBYNZLM2kxT5pet9ZMGowLCLgwhJW5JQCMj8kydH5pA_ddXtA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: unlock on error in hci_inquiry_result_with_rssi_evt()
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Jan 21, 2022 at 2:53 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Dan,
>
> > Add unlocks to two error paths in hci_inquiry_result_with_rssi_evt().
> >
> > Fixes: fee645033e2c ("Bluetooth: hci_event: Use skb_pull_data when proc=
essing inquiry results")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > net/bluetooth/hci_event.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
>
> patch doesn=E2=80=99t apply cleanly, please rebase against bluetooth-next=
 tree.
>
> Regards
>
> Marcel

Ive already applied this one:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3Dc07ba878ca199a6089cdb323bf526adbeeb4201f

Might have forgotten to reply here.

--=20
Luiz Augusto von Dentz
