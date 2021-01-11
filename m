Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB21C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jan 2021 21:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F5B22CB8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jan 2021 21:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbhAKVzx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jan 2021 16:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730911AbhAKVzw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jan 2021 16:55:52 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDA9C061786
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jan 2021 13:55:12 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 15so183214oix.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jan 2021 13:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jmimKH491OqCYabPoOdsfIhHHPuiNU+BuuQZMEl7wxo=;
        b=DXDPONwSZd6CyNOnQGRZgXGsBNbMrq/gdW6u9nuJUJapd+i8F30hTg2j4FBnFddv33
         b/1ljd7JNcUjl/uDpdZseDXp3W/mXB86eDKBFOEOzvxvnu9pQWAX8SdybS8mzMvxn/63
         fgOa5MxcB+PUjcBY33qq6+70sxjiXSZBNi5eRVTRC+eRz7J/EHuogRvMxI7g1nD+Wrk4
         yf1JgZNnvutyz2uIIRRI0pb4WKWCog788NUXffjqHj3EHknoGsKMGV4+y9miTke7l/0v
         8SnJCByBloYFyXZ0cBzrcEumLvPPxU45tGUsJXK2OV5cOM4Ga4IKxhed1BOYgcDz8N60
         erWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jmimKH491OqCYabPoOdsfIhHHPuiNU+BuuQZMEl7wxo=;
        b=a8Btyg9AfE9BGrhzCxC5eecjhEJeGEt24Hrhd2lAaeYBm2AZSq9m1wxibldtFAKGZ0
         lbAmZkVFf9l3fk9jXR035ijB2E/EGdCi8IgnN6cXKtejJGwjU3ikwvj4qhuYpUW65z4O
         imwUpboJRNEcmHWPEX3PbyH1LVpMwVXioI8jFtSYoTCooUIN3mg68ESPn6/hll3UOsIP
         7Hfc0IJJPIu1ggxV2PiIycJ+aQ/6+bHGGPyw+yXM7p4G7/0COIZt/a8FIQC5krktwBMk
         82oi9OM3SuWyEbpw7T/0Xim92IvWnbAMPM+g7HyXGj6TiPE3bHzzi8g2RhXd3ipRcP7I
         3VIg==
X-Gm-Message-State: AOAM530koqM1GG7oWMyCESMMrjc+3D0EST4eWcYGL3d2QgzfbaPOYP9K
        tvIYsoAbX3xgsGYXIlw+CsGyGyqNpfEtLN8sgvU=
X-Google-Smtp-Source: ABdhPJxuxeiq3YrT1X84tvx54jkVjPv2G7UUMp7Uq+YqQbwuWczG7UJYpn2fboRdJbv4tfWUkHVfaQ9FicFoQfFk8vw=
X-Received: by 2002:aca:f456:: with SMTP id s83mr533144oih.58.1610402111905;
 Mon, 11 Jan 2021 13:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20201222124651.101063-1-marcel@holtmann.org> <CANFp7mV8RpF8gkrEbyA8ZOP1YH5CH0xkJeyPcaetROsqHiZWWg@mail.gmail.com>
In-Reply-To: <CANFp7mV8RpF8gkrEbyA8ZOP1YH5CH0xkJeyPcaetROsqHiZWWg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 11 Jan 2021 13:55:00 -0800
Message-ID: <CABBYNZJ7ednKQfBG+Ky+39+d2qO3YvXGn7TTvm-3SZ-uSNcsfA@mail.gmail.com>
Subject: Re: [PATCH] doc/mgmt-api.txt: Introduce Set Runtime Firmware command
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Mon, Jan 11, 2021 at 11:38 AM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Hi Marcel,
>
> I don't think this solves the original problem we were talking about:
> the driver should replace the runtime firmware on reload if it doesn't
> match what's on disk.
>
> Some background for the mailing list:
> - On a ChromeOS laptop, we discovered that the Bluetooth controller
> wasn't being fully powered down in some reboots. As a result, a new
> firmware wasn't being applied after an update.
> - The kernel driver was checking if the bluetooth controller had
> loaded some firmware already. If it was in bootloader mode, it would
> download new firmware. If it was not, it would skip downloading new
> firmware.
>
> The useful part of this mgmt command is to force the driver to reset
> to bootloader (Action = 0 in Set Runtime Firmware). However, without
> being able to compare the firmware version loaded on the controller,
> there's no clear signal for when this should be called. Loading the
> firmware through mgmt may be useful for debugging but you could also
> just replace the firmware on disk and "reset to bootloader" to achieve
> the same effect. I would actually expect unloading and reloading the
> module should do that.
>
> Also, moving the firmware loading from the driver to the userspace
> seems odd to me. Since the comparison is between the controller
> firmware and disk firmware, there's not much extra that the userspace
> knows that the kernel does not.

My last suggestion was just to have a MGMT command suggesting the
kernel to load the firmware from a different location, this could be
useful for testing purpose so one can set for example an old/beta
firmware to compare for regressions or test new features that
otherwise would not be available. That said perhaps we don't actually
need a new MGMT command for doing this and just by replacing the
current file would trigger a reload but that may get tricky when if
the location does get unmonted/remounted etc.

>
> ----
>
> Coming back to the original problem of when to reload runtime
> firmware, here are the conditions under which we do and don't want a
> reload.
>
> Do want a reload:
> - Reboot
> - Module is unloaded and reloaded
>
> Don't want a reload:
> - Transport disconnection (i.e. usb disconnect; some laptops will
> power down USB during suspend to save additional power but BT will
> stay powered up)

Well if the device disappears from the host I'm not really sure how
you will be able to detect that the firmware was retained, that said
when the adapter is power up again it should be possible to query it
what firmware it is currently running and then compare with the one
from file before attempting to load it, this should also work
regardless of the underlying transport/bus so it would work regardless
of the driver in use.

> - Power toggle (bluetooth power off -> power on)
> - HCI reset
>
> Letting the kernel driver maintain some sort of table of previously
> configured devices might be a better option. We can put that table in
> the module's static memory space so that it doesn't get cleared on
> device disconnects. These should be useful for internally connected
> Bluetooth (which may not always power cycle between resets) and for
> which you may want to force reloads around reboot or module reload.
> Externally connected Bluetooth will power cycle once disconnected
> anyway so this is moot for them.

It is probably simpler to just query the controller what firmware it
has before uploading a new one otherwise this gets very platform
specific, besides I don't think we would be able to tell if the USB is
connected internally or not.

> Thanks,
> Abhishek
>
> On Tue, Dec 22, 2020 at 4:47 AM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > ---
> >  doc/mgmt-api.txt | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 1736ef009e75..47686ae32629 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -2187,6 +2187,7 @@ Read Controller Configuration Information Command
> >
> >                 0       External configuration
> >                 1       Bluetooth public address configuration
> > +               2       Runtime firmware configuration
> >
> >         It is valid to call this command on controllers that do not
> >         require any configuration. It is possible that a fully configured
> > @@ -3132,6 +3133,10 @@ Read Controller Capabilities Command
> >                 0x02            Max Encryption Key Size (BR/EDR)
> >                 0x03            Max Encryption Key Size (LE)
> >                 0x04            Supported Tx Power (LE)
> > +               0x05            Complete firmware name
> > +               0x06            Shortened firmware name
> > +               0x07            Firmware info string
> > +               0x08            Hardware info string
> >
> >         Flags (data type 0x01)
> >
> > @@ -3155,6 +3160,23 @@ Read Controller Capabilities Command
> >                 field is not available, it indicates that the LE Read
> >                 Transmit Power HCI command was not available.
> >
> > +       Firmware name (date types 0x05 and 0x06)
> > +
> > +               Only one of these will be present if the device is loading
> > +               some sort of runtime firmware. Only in the firwmare name
> > +               happens to exceed the 255 charaters, the shortened type
> > +               shall be used.
> > +
> > +               This value represents the driver chosen default firmware
> > +               for a controller. In case it is changed via Set Runtime
> > +               Firmware command that change will not be reflected here.
> > +
> > +       Firmware and hardware info (data types 0x07 and 0x08)
> > +
> > +               When provided by the hardware and the driver, these fields
> > +               will contain string of the firmware or the hardware for
> > +               debug or indentification purposes.
> > +
> >         This command generates a Command Complete event on success or
> >         a Command Status event on failure.
> >
> > @@ -3852,6 +3874,70 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
> >                                 Invalid Parameters
> >
> >
> > +Set Runtime Firmware Command
> > +============================
> > +
> > +       Command Code:           0x0057
> > +       Controller Index:       <controller id>
> > +       Command Parameters:     Action (1 Octet)
> > +                               Firmware_Length (2 Octets)
> > +                               Firmware (0-65535 Octets)
> > +       Return Parameters:      Missing_Options (4 Octets)
> > +
> > +       This command allows configuration of runtime firmware or patch
> > +       download setting. Since a vendor specific procedure is required,
> > +       this command might not be supported by all controllers.
> > +
> > +       Possible values for the Action parameter:
> > +               0       Reset to default driver firmware
> > +               1       Reset to current or configure new firmware
> > +
> > +       When resetting to the default firmware, Firmware_Length shall be
> > +       set to 0. The system will go back to the original firmware selected
> > +       by the driver. When resetting to current firmware, Firmware_Length
> > +       shall also be set to 0. If there has been never specified a new
> > +       firmware, then a reset to default or current is not different.
> > +
> > +       Loading a new firmware can be triggered with the Action 1 and a
> > +       Firmware specified. The Firmware is a string that would also be
> > +       used in request_firmware() and has to be NUL terminated. The
> > +       Firmware_Length field shall include the string length plus the
> > +       additional NUL byte.
> > +
> > +       In the case a driver has no default driver firmware, then an
> > +       Action 0 will fully reset the device into an unconfigured state.
> > +
> > +       When the support for runtime firwmare configuration is indicated
> > +       in the supported options mask, then this command can be used to
> > +       set the runtime firmware.
> > +
> > +       It is only possible to configure the runtime firmware when the
> > +       controller is powered off.
> > +
> > +       For an unconfigured controller and when Missing_Options returns
> > +       an empty mask, this means that a Index Added event for the now
> > +       fully configured controller can be expected.
> > +
> > +       For a fully configured controller, the current controller index
> > +       will become invalid and an Unconfigured Index Removed event will
> > +       be sent. Once the firmware has been successfully loaded an Index
> > +       Added event will be sent. There is no guarantee that the controller
> > +       index stays the same.
> > +
> > +       All previous configured parameters and settings are lost when
> > +       this command succeeds. The controller has to be treated as new
> > +       one. Use this command for a fully configured controller only when
> > +       you really know what you are doing.
> > +
> > +       This command generates a Command Complete event on success or a
> > +       Command Status event on failure.
> > +
> > +       Possible errors:        Rejected
> > +                               Not Supported
> > +                               Invalid Parameters
> > +                               Invalid Index
> > +
> > +
> >  Command Complete Event
> >  ======================
> >
> > --
> > 2.29.2
> >



-- 
Luiz Augusto von Dentz
