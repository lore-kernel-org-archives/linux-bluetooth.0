Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9832EC6FD19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 19:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCMTmj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 15:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCMTmh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 15:42:37 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DA67FD77;
        Mon, 13 Mar 2023 12:42:36 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1763e201bb4so14977633fac.1;
        Mon, 13 Mar 2023 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678736555;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cReS7UeRVzisQnmuqlt0zhzds2h4+MiCa5V5+WGY//k=;
        b=nF+fLI99IPygWFlaeCMM/NgZk4QyTYVbPCu/2a5KY7GX9waLZoBN87FyWGo3bkxuCR
         n6TK3k8bnwAsjmAnwpLBKneaYwEtGL0+L8hrdPES2zmgLycedqiKGsEsuWVpnXJXZfzB
         qSlyBLj/uY1pFVFkDCW1pwJ7Cbs3cDhIAVYN2cKmSSsImAqvCfkKVIw6jHIYK/mrcHp1
         AuqqqKvotrPljTkANGoFKAqhoyofYvpzpWR1pO3XqmP7rwqDjH/sHcKi/INfkpsIjhSD
         0rPR2H6kRPcNzjad7Iu8pCgl1VQaf6O2jdW0pcnIqrn8SzMMaXF9EEk32mpcezleqU7l
         68Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678736555;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cReS7UeRVzisQnmuqlt0zhzds2h4+MiCa5V5+WGY//k=;
        b=YxmPuAixO9eiQNRae8UnHhG6axFrRzHvVzOGo9nOhX0ZhJmeesj7a624lxKv8eZUrn
         XeZVxpIHHE4h8+xFXQzPTvb/tLSKoVhH7oIB3o8pTD705YJX1QZ+6R6rZ/7S6lBFkTb0
         xKkct2reL3rjRrkIiMOBtmIB3Jyqm/UCZYMaBzuzq0Dd5dQdxc43erjModBiflpVGrxI
         4r8rQJ3foBiTjQUJ4bCIAA3MicgT2daWzjlu029/Q7Fofd+tO35xZ+LEPYNzYFFjVlzN
         2uDwB8VL+FZOFakX/bYLrEwg8B33fssZLnoz3+GVGlkei3El5LFBZPp1IJSsrX3zIGaP
         VXmg==
X-Gm-Message-State: AO0yUKWwx/vDsnh10UqZsgyVsNgMSTwLVXtyhT0HlGKT0CaZvh9hGsPf
        4CPPfhJo2JUcxFKxkLaihNM=
X-Google-Smtp-Source: AK7set/kI7lS+zhtZ/eOkQBps9A2LiikyGKGA6ii9XidVlgwJ14z0ZW0pS1xze4OWrmvqRyt5rOC1w==
X-Received: by 2002:a05:6870:1686:b0:172:289a:dd1a with SMTP id j6-20020a056870168600b00172289add1amr22385511oae.47.1678736555168;
        Mon, 13 Mar 2023 12:42:35 -0700 (PDT)
Received: from neuromancer. (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id t3-20020a056870048300b001730afaeb63sm337519oam.19.2023.03.13.12.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 12:42:34 -0700 (PDT)
Message-ID: <640f7caa.050a0220.7e478.2265@mx.google.com>
X-Google-Original-Message-ID: <ZA92Jvai0l4vUG+s@neuromancer.>
Date:   Mon, 13 Mar 2023 14:14:46 -0500
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 2/3 V4] Bluetooth: hci_h5: btrtl: Add support for
 RTL8821CS
References: <20230228152205.133582-1-macroalpha82@gmail.com>
 <20230228152205.133582-3-macroalpha82@gmail.com>
 <CADcbR4+Onb6RM7grPrqRL8Rth0mbFXykRmPq8R1QxYRGaHQHtA@mail.gmail.com>
 <CADcbR4L6b9D1FJx9u1jFvZ6jhixNs3_Ky+Mu0rHwtXZ6ATO-Eg@mail.gmail.com>
 <CA+E=qVdjvYn2qPCP+9EaS=90DT_uEVSk0z04tU3DL0X8NumUAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+E=qVdjvYn2qPCP+9EaS=90DT_uEVSk0z04tU3DL0X8NumUAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Mar 13, 2023 at 11:36:21AM -0700, Vasily Khoruzhick wrote:
> On Mon, Mar 13, 2023 at 11:12 AM Chris Morgan <macroalpha82@gmail.com> wrote:
> >
> > I found the fix, simply put changing the compatible from
> > realtek,rtl8822cs-bt to realtek,rtl8732bs-bt fixes it (because it sets
> > the "H5_INFO_WAKEUP_DISABLE" flag). Is it too late for a V5, or should
> > I submit this as a fix to the devicetree and devicetree documentation?
> 
> But is it actually compatible with rtl8723bs-bt though? I think you
> may need to add an entry for 8821cs to rtl_bluetooth_of_match in
> hci_h5.c

The compatible string would be an exact copy of what is present for
rtl8723bs-bt. Previously I was advised by the devicetree team to just
use a fallback string rather than add a duplicate entry to the driver,
so that's what I did. The driver itself can detect the difference
between the 8821cs and 8723bs and load the appropriate firmware.

Technically the rtl8822cs-bt also works as long as you only want to
"test" the driver and not use it. It's the power management stuff
that causes it to fail roughly 9 out of every 10 times you try to
use it for more than simple pairing (I tested 3 different controllers
with the new compatible string for a total of 7 tests and it works
consistently now).

If you're okay with the compatible string change, I'll update it and
resubmit this as a V5. It shouldn't require a change to the driver,
only the binding.

Thank you.

> 
> > Thank you.
> >
> > On Fri, Mar 10, 2023 at 10:25 AM Chris Morgan <macroalpha82@gmail.com> wrote:
> > >
> > > I shudder to bring this up now, but I'm encountering a new bug and
> > > might have to withdraw this.
> > >
> > > I'm receiving errors in dmesg of the following, and I can't seem to
> > > figure out the root cause:
> > > Bluetooth: hci0: Out-of-order packet arrived
> > >
> > > Any thoughts on what might cause it?
> > > Thank you.
> > >
> > > On Tue, Feb 28, 2023 at 9:22 AM Chris Morgan <macroalpha82@gmail.com> wrote:
> > > >
> > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > >
> > > > RTL8821CS is a WiFi + Bluetooth combo chip from Realtek that provides
> > > > WiFi A/B/G/N/AC over an SDIO interface and Bluetooth 4.2 over a UART
> > > > interface.
> > > >
> > > > Note that the firmware this was tested with was firmware version
> > > > 0x75b8f098.
> > > >
> > > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > > ---
> > > >  drivers/bluetooth/btrtl.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> > > > index 69c3fe649ca7..72947d319fa6 100644
> > > > --- a/drivers/bluetooth/btrtl.c
> > > > +++ b/drivers/bluetooth/btrtl.c
> > > > @@ -128,6 +128,14 @@ static const struct id_table ic_id_table[] = {
> > > >           .fw_name  = "rtl_bt/rtl8821c_fw.bin",
> > > >           .cfg_name = "rtl_bt/rtl8821c_config" },
> > > >
> > > > +       /* 8821CS */
> > > > +       { IC_INFO(RTL_ROM_LMP_8821A, 0xc, 0x8, HCI_UART),
> > > > +         .config_needed = true,
> > > > +         .has_rom_version = true,
> > > > +         .has_msft_ext = true,
> > > > +         .fw_name  = "rtl_bt/rtl8821cs_fw.bin",
> > > > +         .cfg_name = "rtl_bt/rtl8821cs_config" },
> > > > +
> > > >         /* 8761A */
> > > >         { IC_INFO(RTL_ROM_LMP_8761A, 0xa, 0x6, HCI_USB),
> > > >           .config_needed = false,
> > > > --
> > > > 2.34.1
> > > >
