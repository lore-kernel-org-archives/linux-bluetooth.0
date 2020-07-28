Return-Path: <SRS0=dFGF=BH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CC4C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 18:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610BB20672
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 18:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeIATN/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbgG1SDr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jul 2020 14:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbgG1SDq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jul 2020 14:03:46 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E628C061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 11:03:46 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id v13so1651587oiv.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dv3Q/pRdkfZQAIG5khmRSqIaEoGwwBiiMrsb7/J0js4=;
        b=XeIATN/iLIc/qj7tkzIxlpfFkjtij9WDXMlB2dtCqqe38hVV8r0kjNVCVgatec6OUG
         I3STQ94HnuFK8AF5a+Th9pTZ7mi1ndUolhON+3LpzYPC3uUwxDg6M6bgOoMa/ZSI3Ghs
         bKjTH6aIqqtF/OkhQp/3wwmFV2HLhlMTphOp2CUuntHunUN21yjOFTrHPF5cL4gMImsR
         pEhl9NkoD8wPxHGoB1Vjd3HlCqMvVe3JcR7BPKALmrMyJvnSMvuJZl9xJqBvvKkzxaHa
         //1nSxHwCfUvce649mRm1vnd5Cepksp9C4sqrrLf3kAhdvSsNuyFh6qHrZyXMLyKjnwN
         GHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dv3Q/pRdkfZQAIG5khmRSqIaEoGwwBiiMrsb7/J0js4=;
        b=cOnn5NxCArF09H9JmVpFVX8IPQM4qFqErYqQffnaKbQR5Ns2uwHNBFWI/TBPsvJ0Eu
         HaqfzV1cFVMHEanzgsYs7nsd5kEBs89wYqLAJyOFOqp081n1Lt5nz43q4OhHzlu7YkTm
         nzyBCGg2xpANOgwZCK8u0OHM7sezfONEKGGLCB1Ym2wTFzK70T8c1W0nfkI93ZFdFmnX
         rfQsUxW47epL8FKdreVI1b1kWubiM16TQVog59M3UL/wUQyr7imP+3FLPab1eF1A+Uku
         RwSDVj15uEq6RH1uRce6B5IIczPEsMZ0pIuopGwGJ47jqPrIUBTSKXjrkzM9kT7DvNWL
         XKOA==
X-Gm-Message-State: AOAM5333IhzbuHkDQ+sG6ApMF4dv/hmsggYuK3n/vxIoqFosWCnQLLyh
        e3IZcDagCIoSlbC4rVfUKCWqI3SIdr38nIvoNiA=
X-Google-Smtp-Source: ABdhPJwpGkAxIF9u5LUtT0+EBcB0ZZlrJEnNDZLI4eWWNeb4xPKldIpI+xwq2MgnLdBduDPuRlWe4a6BDOrqpFSpdVE=
X-Received: by 2002:aca:2819:: with SMTP id 25mr4304488oix.48.1595959425884;
 Tue, 28 Jul 2020 11:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200717020332.Bluez.v3.1.I1322f6745fa50365c1c88de3e2c50c9c5962c094@changeid>
 <CALWDO_UsrzyLFkmxcnE59zaZPjP8ByN3sSOLDse6LwwpTA=ZsQ@mail.gmail.com>
In-Reply-To: <CALWDO_UsrzyLFkmxcnE59zaZPjP8ByN3sSOLDse6LwwpTA=ZsQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 28 Jul 2020 11:03:36 -0700
Message-ID: <CABBYNZK5aqhLXttAz6qie3LN5SnzmwuLFt8VtzQURjC+5UNXaQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 1/2] device: add device_remove_bonding function
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Archie Pusaka <apusaka@google.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Jul 28, 2020 at 6:19 AM Alain Michaud <alainmichaud@google.com> wrote:
>
> Friendly ping to maintainers on this one.
>
> Thanks,
> Alain
>
> On Thu, Jul 16, 2020 at 2:04 PM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > This patch splits the "bonding removal" function in device.c,
> > because we need to remove bonding information when receiving
> > "virtual cable unplug" in HID profile.
> >
> > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Call device_set_temporary on device_remove_bonding
> >
> > Changes in v2: None
> >
> >  src/device.c | 28 ++++++++++++++++++----------
> >  src/device.h |  1 +
> >  2 files changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/src/device.c b/src/device.c
> > index 226216235..b23ecb7fd 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -4356,6 +4356,20 @@ static void delete_folder_tree(const char *dirname)
> >         rmdir(dirname);
> >  }
> >
> > +void device_remove_bonding(struct btd_device *device, uint8_t bdaddr_type)
> > +{
> > +       if (bdaddr_type == BDADDR_BREDR)
> > +               device->bredr_state.bonded = false;
> > +       else
> > +               device->le_state.bonded = false;
> > +
> > +       if (!device->bredr_state.bonded && !device->le_state.bonded)
> > +               btd_device_set_temporary(device, true);
> > +
> > +       btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
> > +                                                       bdaddr_type);
> > +}
> > +
> >  static void device_remove_stored(struct btd_device *device)
> >  {
> >         char device_addr[18];
> > @@ -4364,17 +4378,11 @@ static void device_remove_stored(struct btd_device *device)
> >         char *data;
> >         gsize length = 0;
> >
> > -       if (device->bredr_state.bonded) {
> > -               device->bredr_state.bonded = false;
> > -               btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
> > -                                                               BDADDR_BREDR);
> > -       }
> > +       if (device->bredr_state.bonded)
> > +               device_remove_bonding(device, BDADDR_BREDR);
> >
> > -       if (device->le_state.bonded) {
> > -               device->le_state.bonded = false;
> > -               btd_adapter_remove_bonding(device->adapter, &device->bdaddr,
> > -                                                       device->bdaddr_type);
> > -       }
> > +       if (device->le_state.bonded)
> > +               device_remove_bonding(device, device->bdaddr_type);
> >
> >         device->bredr_state.paired = false;
> >         device->le_state.paired = false;
> > diff --git a/src/device.h b/src/device.h
> > index cb8d884e8..956fec1ae 100644
> > --- a/src/device.h
> > +++ b/src/device.h
> > @@ -50,6 +50,7 @@ uint16_t btd_device_get_vendor(struct btd_device *device);
> >  uint16_t btd_device_get_vendor_src(struct btd_device *device);
> >  uint16_t btd_device_get_product(struct btd_device *device);
> >  uint16_t btd_device_get_version(struct btd_device *device);
> > +void device_remove_bonding(struct btd_device *device, uint8_t bdaddr_type);
> >  void device_remove(struct btd_device *device, gboolean remove_stored);
> >  int device_address_cmp(gconstpointer a, gconstpointer b);
> >  int device_bdaddr_cmp(gconstpointer a, gconstpointer b);
> > --
> > 2.27.0.389.gc38d7665816-goog
> >

Applied, thanks.

-- 
Luiz Augusto von Dentz
