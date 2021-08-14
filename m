Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F74C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 07:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8969460E8D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 07:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbhHNHJ4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Aug 2021 03:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbhHNHJz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Aug 2021 03:09:55 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB05C06175F
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Aug 2021 00:09:27 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 1so1173104vkk.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Aug 2021 00:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7pkFAI9aHs1wZC/RanppuJG6BLvSfn98JNatH3XzcI=;
        b=liMRPvEjXS6ePuxRiJgWdXiq2nx1sGEboy3pkTfefNfT348sfd+9Lrmn8ap3O0SaY9
         dT4moQTEaGJ1oQOgqsZEQkN4SUsfve3WmnxGRorApytVpchHnTnfuinDA3dNyN1SjC4b
         Uh/s9SRFWg2bIuVHb8i8Aj/WvRik9n8fFFZNeR/jL1VcuyTeijWnlI2wfFVHlAjbPC7y
         d76mrljXTfc3okPnqC1J82IyGrfPe83HWT1+0Ghlmsf8EZkcCpHElYBTJdDXid4o4kmR
         iuxGAZ5ogAjHDIZXCyZeQXkSVMIQWay9d+VCGHYhQOIQUstOGdRr+nOoEiBGdwKtPhNx
         +/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7pkFAI9aHs1wZC/RanppuJG6BLvSfn98JNatH3XzcI=;
        b=tEVQU5082S00+H2vRvC83OWdMpbqtmsnSFkGxflAUvqM+2AaoVmCjdiXWgVsBxEsIE
         gOWxI4kBjMhvQ3+A3kMqcWREDjhmiczlv1+AZQdM8XvlSqOf5kpgnI281p/klPFefARz
         1T8rfWm7P6Tv00+kYXa6bpVNpsR+Bi4WDDx8d7grBPGD9aQCDA7P9PZpubM4Q9to3pCJ
         QkC+fIpoqBBYhR4uJqF1OK7Z6tv8cIvVWMiv9tTHqUxQ0tKJ41Tt+TaE2btUhaLpfz4k
         ibongxfu2bzJ1wIylQD0+4KLQdn1Mu3uA9FJhLoCCh9npllf6BfNYzbKluYANUb4O6Ve
         o+3g==
X-Gm-Message-State: AOAM5319SicJRsinW9B6oGH/VJhGqlHlOLI1IgfLdp5cnIWdAnilh2/w
        Xnf7w+QQVi028U5KeEDg4HG1DHxhVHePfjnA3kY=
X-Google-Smtp-Source: ABdhPJz8+1UZlg11KqKvHbkpONGBdp56kxUqfCEPc7vk6eZ1G4Yp87SHg5sKGBZCp4xCB/6zfhWP8OZgVAzWF/Wvcis=
X-Received: by 2002:a05:6122:91:: with SMTP id r17mr4369848vka.15.1628924966940;
 Sat, 14 Aug 2021 00:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <YB1pt8WXsHO2gP5A@core-precision>
In-Reply-To: <YB1pt8WXsHO2gP5A@core-precision>
From:   Igor Kovalenko <igor.v.kovalenko@gmail.com>
Date:   Sat, 14 Aug 2021 10:09:15 +0300
Message-ID: <CAA8-O=Uw+QO6fK1B1WSMdt_OAQJe-o5EfeWPFy2K29-XACwZjg@mail.gmail.com>
Subject: Re: Query on the patch series "define HCI packet size of USB Alts"
To:     Sanchayan <maitysanchayan@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Feb 5, 2021 at 6:52 PM Sanchayan <maitysanchayan@gmail.com> wrote:
>
> Hello,
>
> We currently have an opened merge request on adding mSBC support to PulseAudio.
> https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/merge_requests/254
>
> There currently seems to be an issue in getting the correct MTU. In the test
> setup it works with the ofono backend, except for the assumed MTU. For getting
> it to work, we had to use a MTU of 24. 48 does not work and renders silence.
> getsockopt(card->fd, SOL_SCO, SCO_OPTIONS ... returns 64 which is too large.
>
> The missing bits on the kernel side seems to be the below patch.
> https://lore.kernel.org/patchwork/patch/1303411/
>
> Second patch in the above series seem to have been applied but not the first.
>
> The first patch in the series above, when applied seems to fix getsockopt
> returning 24 bytes for the MTU. An additional correction on top of that
> below
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index fd0dcfa9a390..35f9c0743014 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1669,6 +1669,8 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
>                 err = __set_isoc_interface(hdev, new_alts);
>                 if (err < 0)
>                         return err;
> +
> +               hdev->sco_mtu = hci_packet_size_usb_alt[new_alts];
>         }
>
>         if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) {
>
>
> seems to make it work for all bluetooth usb devices.
>
> Has there been any further development or way to push this forward?
>
> - Sanchayan.

Gentle reminder, anything can be done to push this forward?

I believe we all use the same workaround discussed in patchwork
thread https://lore.kernel.org/patchwork/patch/1303411/ but first SCO
socket write either has to be delayed until first read succeeds, or first
SCO socket write size may be incorrect since payload size of HCI
packet is not propagated to socket MTU value.

With https://lore.kernel.org/patchwork/patch/1303411/ and the change
above to btusb_switch_alt_setting() first SCO socket write can be done
with correct size right away.

-- 
Kind regards,
Igor V. Kovalenko
