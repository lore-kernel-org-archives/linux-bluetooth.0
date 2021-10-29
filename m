Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AA2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 08:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA3C61151
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 08:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhJ2ILD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Oct 2021 04:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbhJ2ILD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Oct 2021 04:11:03 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B41C061714
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Oct 2021 01:08:35 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id d204so22276276ybb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Oct 2021 01:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+Le6B97XTarP+zpQalZY09j7ckTrgrQqCOfMYv/ZEc=;
        b=DjKZY9D+OQRTBixFRj8IBTQc8b6gxJFd7rLgtm4WKbLiDaFCoiUfEbSALVPMEMKUPu
         NSe8gzWxHV+Aie2MukOGYwtX0WeN2x8MpTZV++WsYxjzbdTwC6+HRTYWIBcsd5R2S+pC
         Xq5nkVd+ic+9t0MQ0HWLryGQG8dWTWTNFAb7G02PAKGnLOoVG46Z3T531ns3DJr1axS9
         T7dmloJ6pygkJjidHXGnp2IB4i9Jm24EoyBEzXLN2Qov0YG+FVmMg96MY7kxUaVh97Wj
         LrALToH1vebbjm6EM5fBaLX+R0reOQb/qNg0PQ/PGTqN2jSJDB5ME8ahwDuQitV8BfY8
         bmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+Le6B97XTarP+zpQalZY09j7ckTrgrQqCOfMYv/ZEc=;
        b=pHMb/ktmO5tCMJVGUdD2GbQZ5YQ+paTgmiH0nCfMGB/ytIjQ/OpEuyG0j/MxBlZNgA
         dv9+wVyKSBKFu/MALn75HvtJrzu+heMuoQ4qoVBiVbZQffPHe5GeMJubNHXqJXYEfDFx
         x4PmH4JKdMi/we79YweivIOHKSfgJ9L5aVTiipUEK8Ql45rRZD9TB3bZOfQ/e84KpT+F
         mtymK0cs34SfFvGMli4ZSAiLZQU3Jttu6lbB/khukMfzAKk6XNRE3tyqWfKZzcyYtqYh
         1z+cHXXDPgI7hGFOnmY9eCG8iLEIZnA5OudsBOMskzV06RaL5H7WJ8+kNgl8gdwjnQ5z
         GOJg==
X-Gm-Message-State: AOAM531K3uivn4r6tU69DAMj6i8jlqAyZTaR1HRvnK2lJXvhAWS1uJ2s
        i5EILmXZZHjzWKlshS5+D5nRhKkuxx6wAUHPqyvGjg==
X-Google-Smtp-Source: ABdhPJwFrM6PBPue6H1nJLQA2Et1dk4Al61AI6BdQ9f7QepIWKlUxAqSmdG3cD7H8DwNC6aPk3YoJmBjCwZw0Dd+k/U=
X-Received: by 2002:a25:3817:: with SMTP id f23mr9775126yba.436.1635494914148;
 Fri, 29 Oct 2021 01:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211021230356.v6.1.I139e71adfd3f00b88fe9edb63d013f9cd3e24506@changeid>
 <20211021230356.v6.3.I257ac5cfaf955d15670479efc311bbab702397f4@changeid> <AB7796C2-6543-43CD-8FA3-DAF57AB68767@holtmann.org>
In-Reply-To: <AB7796C2-6543-43CD-8FA3-DAF57AB68767@holtmann.org>
From:   Joseph Hwang <josephsih@google.com>
Date:   Fri, 29 Oct 2021 16:08:23 +0800
Message-ID: <CAHFy41_y8LS81gTHNidMdrD9tpeXf0YyvHaTKZJU+jmjuFgYXQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] Bluetooth: btusb: enable Mediatek to support AOSP extension
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        pali@kernel.org, chromeos-bluetooth-upstreaming@chromium.org,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWFyay1ZVyBDaGVuICjpmbPmj5rmlocp?= 
        <Mark-YW.Chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+Mark-YW.Chen@mediatek.com

Some of Mediatek's controllers/firmwares do NOT support AOSP extensions.

Please refer to this Gerrit patch review link for chrome os
(https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3054233/8/drivers/bluetooth/btusb.c)
which was reviewed by Mark-YW Chen, Mediatek's engineer.

As an example, MediaTek MT7615E does not support the AOSP extensions.

That was why I used a new BTUSB_QUALITY_REPORT flag in the changes v4
and earlier ones.

Please let me know how you would like to proceed with this patch.

Thanks!
Joseph


On Mon, Oct 25, 2021 at 9:26 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Joseph,
>
> > This patch enables Mediatek to support the AOSP extension.
> >
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> >
> > ---
> >
> > (no changes since v5)
> >
> > Changes in v5:
> > - Let the vendor command in aosp_do_open() to determine what
> >  capabilities are supported.
> >
> > Changes in v4:
> > - Call hci_set_aosp_capable in the driver.
> > - This patch is added in this Series-changes 4.
> >
> > drivers/bluetooth/btusb.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 87b71740fad8..00311ebd7823 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -3876,6 +3876,8 @@ static int btusb_probe(struct usb_interface *intf,
> >               hdev->set_bdaddr = btusb_set_bdaddr_mtk;
> >               set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> >               data->recv_acl = btusb_recv_acl_mtk;
> > +
> > +             hci_set_aosp_capable(hdev);
>
> can we get an ACK from Mediatek people that all their firmwares support the AOSP extensions.
>
> Regards
>
> Marcel
>


-- 

Joseph Shyh-In Hwang
Email: josephsih@google.com
