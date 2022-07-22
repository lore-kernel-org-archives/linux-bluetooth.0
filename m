Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A9AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 17:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiGVR7v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 13:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiGVR7u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 13:59:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AC45B071
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 10:59:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bp15so9845363ejb.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fZJdpPztTTADq7IALobyoafTWbKHD8Wm/RY3Y465v+c=;
        b=mGr+06EWo+rJOIDf2PYwWfOKJh6azmYPJMH6rKun5MclwLx2xzGNzFm54w5TJjZeLO
         CCKDX6RP4l2b8swrmG77z4PgXjuwgzx8+7USTaKQhPNnLBt2taS+WwcWig2l6kPM05Rk
         +T1DkIzikusDSM2wgFT0dJ6x4XtAE2RQ2jnGB6k/SkFzcefRjJAAD383xASO3XrveYjH
         NGGYgERJktN6kPP9UW8CFUFtaPntlbDJfDTMfYPWf3arkRulGzaZgyy22ny7xgLmXNl6
         /+p/3uBkTMsIO79tWTj17dYinvHw4UufDmV8AvN9vnjymBA/M50bASpJGL/LkU5h3L9F
         32rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fZJdpPztTTADq7IALobyoafTWbKHD8Wm/RY3Y465v+c=;
        b=S0Y0CdHdnJ0Tg/apibbjA09KZCQl0r6SCrBgVGnlbEt3IgHeZ8+IYegRzPnCvTpu3i
         TWTt1+QwQzCfdU51yy2/t56Um2xYcy3mdjRLtap5QrtIj9mcYNbm4OwCorCgtQ7XdSN/
         fOVs2NvRC09OWoPUezewd25SaFbs8EoaKPR3/lTI5qR+H98818kUvTTMjvjZ3cM1TTCk
         ELasws2xhFjO6zauHZwj1tMp+X/oXMJJFKWDTcshP3D5FpTL2b+ecpIcaVi2oBdXeh8G
         i4PDHWxjHCTFZ8FOE4KPycxA4xpY177J1RI/tZoIZmfPm+OKaGRy4i3g7fCfV89ZeNok
         Dmyw==
X-Gm-Message-State: AJIora9N4XIcajnC16fexmACB+GrtOpHEqABMWqVDPp7BPNyFy/FtoL6
        yB2/xgtjfYNxbuxF8sUo2EjRZO4TCFfuuu4wg7sG8JDW9WM=
X-Google-Smtp-Source: AGRyM1vQ2fneC/lOKETdfTS7Z7JUAqwqRgeBmT1/6mhLCZ/ojiRT+NujB4lc0oCZHDTCS+yiryTBKR7LJpJFX8SKSvo=
X-Received: by 2002:a17:907:7617:b0:72b:49fe:fdf7 with SMTP id
 jx23-20020a170907761700b0072b49fefdf7mr836680ejc.25.1658512787906; Fri, 22
 Jul 2022 10:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220614145253.132230-1-soenke.huster@eknoes.de> <67219c6e-7eef-ee5c-693c-215a4d4c1b3e@eknoes.de>
In-Reply-To: <67219c6e-7eef-ee5c-693c-215a4d4c1b3e@eknoes.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 22 Jul 2022 10:59:35 -0700
Message-ID: <CABBYNZ+x1eph+bzSB2SU1qNe4M8K-rtinSrOrq4=fTW+U9uEyg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: virtio_bt: Use skb_put to set length
To:     =?UTF-8?Q?S=C3=B6nke_Huster?= <soenke.huster@eknoes.de>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi S=C3=B6nke,

On Fri, Jul 22, 2022 at 4:59 AM S=C3=B6nke Huster <soenke.huster@eknoes.de>=
 wrote:
>
> On 14.06.22 16:52, Soenke Huster wrote:
> > By using skb_put we ensure that skb->tail is set
> > correctly. Currently, skb->tail is always zero, which
> > leads to errors, such as the following page fault in
> > rfcomm_recv_frame:
> >
> >     BUG: unable to handle page fault for address: ffffed1021de29ff
> >     #PF: supervisor read access in kernel mode
> >     #PF: error_code(0x0000) - not-present page
> >     RIP: 0010:rfcomm_run+0x831/0x4040 (net/bluetooth/rfcomm/core.c:1751=
)
> >
> > Signed-off-by: Soenke Huster <soenke.huster@eknoes.de>
> > ---
> >  drivers/bluetooth/virtio_bt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_b=
t.c
> > index 67c21263f9e0..fd281d439505 100644
> > --- a/drivers/bluetooth/virtio_bt.c
> > +++ b/drivers/bluetooth/virtio_bt.c
> > @@ -219,7 +219,7 @@ static void virtbt_rx_work(struct work_struct *work=
)
> >       if (!skb)
> >               return;
> >
> > -     skb->len =3D len;
> > +     skb_put(skb, len);
> >       virtbt_rx_handle(vbt, skb);
> >
> >       if (virtbt_add_inbuf(vbt) < 0)
>
> Are there any issues with it, or is there another reason why it is not me=
rged yet?

It appears it was removed from PW due to 30 days inactivity, when that
happens you should resend the patch since it needs to be retested by
CI.

--=20
Luiz Augusto von Dentz
