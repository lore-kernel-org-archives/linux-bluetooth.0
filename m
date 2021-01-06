Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A7EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 19:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F9823125
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 19:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbhAFTGG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jan 2021 14:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbhAFTGG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jan 2021 14:06:06 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74C5C061575
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jan 2021 11:05:25 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id s19so1001132oos.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Jan 2021 11:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P4DKvJGFEQ1hqyU+GKgsU1Prw0/8glwg6MDsxnHB6kU=;
        b=R67V3ltlI9SyFkWSmrtdHOrc43bJDomsyMBv+yzI9N0C5vMrRqztldFZtvbnYLCA6G
         N0rv04c/K5pOly/9VzsmuS1iLxtW3K7Tyl8Zwab8DOPMBcf61fphKBQtVyVRcpUT0Az5
         AevD08SVzr+viP/TCtSSw9MmJz8wwXk6PCrlhSRa25nceuuCCQEEPjfE6c0mU2FFya1M
         dS7NVmRQEcNGuxld4X4Wdvqjg25s9gDim2SVBv/JO4bvHYRwwi7HEQ2s9KBllxKG9VaG
         RTams1TpGPNgnIMaFnmVmRE5/h2Rvv00L9+/NELOAv3kiWiQOYCqDjnRWkxnAJGHXZhV
         ajkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P4DKvJGFEQ1hqyU+GKgsU1Prw0/8glwg6MDsxnHB6kU=;
        b=KQYdcAllyNeaPKtF9tvBVshrNUmX//H3gx0x8LIaSGWjkpeUxqXedIAT1UDGMTvZ4R
         a4m7kSZwN2DymKB7H2n9rpjYgDFBy+vHJOB5/3VXZtcbscVpcAck51xpgurbj22L6+xH
         M8FtlROf2kJwTuAztmI0/ks1fnyjJ++OoTLly/wztARPVEbwyTJZ484YCW5nDNXJoKcw
         hAz09VEVLpR+dEoMBsoZN0xWHtWDpScKrZfp9g7oK27u++IpL2aDkBHE/Op1RSMHU73d
         r6iKHPuGM00hDWpXC96Y9fGiWlc/on+aSNPxWUM8zRPMZ53CsAxW3BX2tKvFbY3sbG+x
         o3pQ==
X-Gm-Message-State: AOAM531NRW6U6fYl6rgjAkBTnn0osiXYq+drtSU6LBRijEcPHul3meZV
        nODJAuqPVPGC5XftxLzmFPvnC0L7aLm5kFkR4tY=
X-Google-Smtp-Source: ABdhPJwmkhpeX1547IWx1p3buxgztW44Ni5w+rxgrJeVY8FO1XUNLr5kdhz3+1LpjYE5RbGw1lA09PDj3toiovyA/Ks=
X-Received: by 2002:a4a:896e:: with SMTP id g43mr3820708ooi.24.1609959924515;
 Wed, 06 Jan 2021 11:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20210106172647.Bluez.v1.1.If4056891c866780eba7b210887c6db468b8b55e9@changeid>
 <CABBYNZK6fZ=rFqbhZeKC2ftoBdwrpZAeR_Pp2-4CYLB8hXzLDg@mail.gmail.com>
In-Reply-To: <CABBYNZK6fZ=rFqbhZeKC2ftoBdwrpZAeR_Pp2-4CYLB8hXzLDg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 6 Jan 2021 11:05:13 -0800
Message-ID: <CABBYNZKH+iUPyU6QRjkoe6-R7cAFptmooSvOqO1f=jds=1VJSg@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] adapter: Remove temporary devices before power off
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Wed, Jan 6, 2021 at 10:24 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Wed, Jan 6, 2021 at 1:27 AM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > If adapter is powered off when a currently connected device is
> > being removed, there is a possibility that we haven't finish waiting
> > for the disconnection but the adapter is already powered down.
> >
> > When this happens, the kernel would fail to clean the device's
> > information, for example the pairing information. This causes
> > disagreement between the user space and the kernel about whether the
> > device is already paired, because the device is successfully removed
> > from the user space's perspective.
> >
> > This patch enforces the removal of such devices before allowing the
> > adapter to power off.
> > ---
> >
> >  src/adapter.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index ec6a6a64c5..92d1cb2232 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -517,6 +517,7 @@ static void adapter_stop(struct btd_adapter *adapter);
> >  static void trigger_passive_scanning(struct btd_adapter *adapter);
> >  static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
> >                                                         uint8_t mode);
> > +static void remove_temporary_devices(struct btd_adapter *adapter);
>
> I would have the function above declared just before the first user
> that way we don't have to use a forward declaration like above.
>
> >  static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
> >  {
> > @@ -622,6 +623,8 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
> >         switch (mode) {
> >         case MGMT_OP_SET_POWERED:
> >                 setting = MGMT_SETTING_POWERED;
> > +               if (!mode)
> > +                       remove_temporary_devices(adapter);
> >                 break;
> >         case MGMT_OP_SET_CONNECTABLE:
> >                 setting = MGMT_SETTING_CONNECTABLE;
> > @@ -2888,8 +2891,10 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
> >                 param = &mode;
> >                 len = sizeof(mode);
> >
> > -               if (!mode)
> > +               if (!mode) {
> >                         clear_discoverable(adapter);
> > +                       remove_temporary_devices(adapter);
> > +               }
> >
> >                 break;
> >         case MGMT_SETTING_DISCOVERABLE:
> > @@ -5304,6 +5309,19 @@ static void remove_discovery_list(struct btd_adapter *adapter)
> >         adapter->discovery_list = NULL;
> >  }
> >
> > +static void remove_temporary_devices(struct btd_adapter *adapter)
> > +{
> > +       GSList *l, *next;
> > +
> > +       for (l = adapter->devices; l; l = next) {
> > +               struct btd_device *dev = l->data;
> > +
> > +               next = g_slist_next(l);
> > +               if (device_is_temporary(dev))
> > +                       btd_adapter_remove_device(adapter, dev);
> > +       }
> > +}
> > +
> >  static void adapter_free(gpointer user_data)
> >  {
> >         struct btd_adapter *adapter = user_data;
> > --
> > 2.29.2.729.g45daf8777d-goog
> >
>
>
> --
> Luiz Augusto von Dentz

Applied, thanks. I went ahead and did the changes myself.

-- 
Luiz Augusto von Dentz
