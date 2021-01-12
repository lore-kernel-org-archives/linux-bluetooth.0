Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DE2C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jan 2021 18:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E61A2311D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jan 2021 18:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406018AbhALSD6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Jan 2021 13:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbhALSD6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Jan 2021 13:03:58 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DF6C061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jan 2021 10:03:18 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id d23so825279vkf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jan 2021 10:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIuM/aW18ukesoPdvBX3WKWUE3e+NVDnP4pkef7heLs=;
        b=ShM3SehQ2/PPI6mV890mZIpICKH3QfNWS1OWCeSvj5DpmAlsr8QtxGG6OLOwDSm1IP
         dXj0Y1ZiWa1WtRbNyVmGKA+pKJbLn7/G932ONv7syAFPrs0K9k1yMyasKdpvS4xClaO6
         2xGh2yvLbdIlD8R0VvKd3xbrVIG0lgB9KU4tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIuM/aW18ukesoPdvBX3WKWUE3e+NVDnP4pkef7heLs=;
        b=cclbbtYielG0IRpeW7Shcg9ix7qXfIiPW6yOXRyuHMsGA9jX4eemOJjl1KKpaZ9mvz
         td2j19DyTMkYOBlV+7DcNtgGETyaegMhm0fQEmYPdLPHj9ltEwrwE59duhtMMfePRFq3
         gtnmOTZ5fZ5qSoatXuDcBk9wGhxIr1eclhzNgLwdL+FNPMIwePr3AaOHQwWt3iLLmwMg
         r7yN6HYro3qoXJQYxNPFg2m2bheuuxMJZ29sHFMAfDe3CnioRBtO8BsJ0RF/5saicq7P
         mKLu2VLWrD8NA3NB7QoLs0djY+9aXUojQ8rXUMbXupQfm7TEfy9P0lrODk7etg+O1Jlx
         c3lg==
X-Gm-Message-State: AOAM532J/QQYt4D82Oy+p6eKNSHSSiGQll5JkbkItJoZ6NoSj/6c1g18
        xXEj61YXcwqhGDj9qQszmhvHnzKXfXkp6atgzfdewA==
X-Google-Smtp-Source: ABdhPJzMXqE2hHhskx0KvaNeuyuUFyCBya72PD6JMpdeT9sMupTKj1d6FU4LMN3Sfy1933iDCODaDJdxqwJoh5cNqUo=
X-Received: by 2002:a1f:1bcc:: with SMTP id b195mr199634vkb.5.1610474597274;
 Tue, 12 Jan 2021 10:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20201222124651.101063-1-marcel@holtmann.org> <CANFp7mV8RpF8gkrEbyA8ZOP1YH5CH0xkJeyPcaetROsqHiZWWg@mail.gmail.com>
 <CABBYNZJ7ednKQfBG+Ky+39+d2qO3YvXGn7TTvm-3SZ-uSNcsfA@mail.gmail.com>
In-Reply-To: <CABBYNZJ7ednKQfBG+Ky+39+d2qO3YvXGn7TTvm-3SZ-uSNcsfA@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 12 Jan 2021 10:03:05 -0800
Message-ID: <CANFp7mVYx3oBLnq=oj2gODcK6Wm_bq8Ykv2MD6DnqvS4gdOu9Q@mail.gmail.com>
Subject: Re: [PATCH] doc/mgmt-api.txt: Introduce Set Runtime Firmware command
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Mon, Jan 11, 2021 at 1:55 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Abhishek,
>
> On Mon, Jan 11, 2021 at 11:38 AM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> > Hi Marcel,
> >
> > I don't think this solves the original problem we were talking about:
> > the driver should replace the runtime firmware on reload if it doesn't
> > match what's on disk.
> >
> > Some background for the mailing list:
> > - On a ChromeOS laptop, we discovered that the Bluetooth controller
> > wasn't being fully powered down in some reboots. As a result, a new
> > firmware wasn't being applied after an update.
> > - The kernel driver was checking if the bluetooth controller had
> > loaded some firmware already. If it was in bootloader mode, it would
> > download new firmware. If it was not, it would skip downloading new
> > firmware.
> >
> > The useful part of this mgmt command is to force the driver to reset
> > to bootloader (Action = 0 in Set Runtime Firmware). However, without
> > being able to compare the firmware version loaded on the controller,
> > there's no clear signal for when this should be called. Loading the
> > firmware through mgmt may be useful for debugging but you could also
> > just replace the firmware on disk and "reset to bootloader" to achieve
> > the same effect. I would actually expect unloading and reloading the
> > module should do that.
> >
> > Also, moving the firmware loading from the driver to the userspace
> > seems odd to me. Since the comparison is between the controller
> > firmware and disk firmware, there's not much extra that the userspace
> > knows that the kernel does not.
>
> My last suggestion was just to have a MGMT command suggesting the
> kernel to load the firmware from a different location, this could be
> useful for testing purpose so one can set for example an old/beta
> firmware to compare for regressions or test new features that
> otherwise would not be available. That said perhaps we don't actually
> need a new MGMT command for doing this and just by replacing the
> current file would trigger a reload but that may get tricky when if
> the location does get unmonted/remounted etc.
>
> >
> > ----
> >
> > Coming back to the original problem of when to reload runtime
> > firmware, here are the conditions under which we do and don't want a
> > reload.
> >
> > Do want a reload:
> > - Reboot
> > - Module is unloaded and reloaded
> >
> > Don't want a reload:
> > - Transport disconnection (i.e. usb disconnect; some laptops will
> > power down USB during suspend to save additional power but BT will
> > stay powered up)
>
> Well if the device disappears from the host I'm not really sure how
> you will be able to detect that the firmware was retained, that said
> when the adapter is power up again it should be possible to query it
> what firmware it is currently running and then compare with the one
> from file before attempting to load it, this should also work
> regardless of the underlying transport/bus so it would work regardless
> of the driver in use.

Generally the device drivers detect whether it's in bootloader mode or
runtime firmware is uploaded. With the runtime firmware, it can also
query what version is running. However, there's currently no way to
read the version on disk because the firmware version isn't stored at
some known location in the firmware blob. That's the crux of the
problem here.


>
> > - Power toggle (bluetooth power off -> power on)
> > - HCI reset
> >
> > Letting the kernel driver maintain some sort of table of previously
> > configured devices might be a better option. We can put that table in
> > the module's static memory space so that it doesn't get cleared on
> > device disconnects. These should be useful for internally connected
> > Bluetooth (which may not always power cycle between resets) and for
> > which you may want to force reloads around reboot or module reload.
> > Externally connected Bluetooth will power cycle once disconnected
> > anyway so this is moot for them.
>
> It is probably simpler to just query the controller what firmware it
> has before uploading a new one otherwise this gets very platform
> specific, besides I don't think we would be able to tell if the USB is
> connected internally or not.

The nice thing about this solution is that it doesn't matter for
externally connected BT (since they will reset to bootloader mode
anyway).

Let's walk through an example: bus 1-6 for internal BT and bus 3-2 for
external BT

- System powers on with both connected. Bus 1-6 loads runtime firmware
and updates module FW table. Bus 3-2 loads runtime firmware and
updates module FW table.
- Unplug external BT. Power down USB to cause 1-6 to disconnect.
- Plug in external BT. External BT is in bootloader mode so it doesn't
check the module FW table. It loads runtime firmware and updates the
module FW table (adding 3-2).
- Power up USB to cause internal BT to connect. Internal BT is not in
bootloader mode (because only USB was powered down). It checks the
module FW table, sees that FW was loaded on the current module load
and doesn't attempt to upload it again.
- Unload module, reload module.
- Internal BT loads, finds that it is in runtime firmware, checks FW
module table, sees it hasn't loaded FW and so forces the BT to
bootloader mode to reload new FW
- External BT loads, finds that it is in runtime firmware (no unplug),
checks FW module table, sees it hasn't loaded FW and so forces the
external BT to bootloader mode to reload new FW

As long as the module is up, it will not reload the FW for BT if it
was originally loaded by the currently running module. Reloading the
module is equivalent to reloading the FW on the BT controllers.

I think this would be the desirable behavior in all cases
(development, reboot forcing new firmware to load, etc).

>
> > Thanks,
> > Abhishek
> >
> > On Tue, Dec 22, 2020 at 4:47 AM Marcel Holtmann <marcel@holtmann.org> wrote:
> > >
> > > ---
> > >  doc/mgmt-api.txt | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 86 insertions(+)
> > >
> > > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > > index 1736ef009e75..47686ae32629 100644
> > > --- a/doc/mgmt-api.txt
> > > +++ b/doc/mgmt-api.txt
> > > @@ -2187,6 +2187,7 @@ Read Controller Configuration Information Command
> > >
> > >                 0       External configuration
> > >                 1       Bluetooth public address configuration
> > > +               2       Runtime firmware configuration
> > >
> > >         It is valid to call this command on controllers that do not
> > >         require any configuration. It is possible that a fully configured
> > > @@ -3132,6 +3133,10 @@ Read Controller Capabilities Command
> > >                 0x02            Max Encryption Key Size (BR/EDR)
> > >                 0x03            Max Encryption Key Size (LE)
> > >                 0x04            Supported Tx Power (LE)
> > > +               0x05            Complete firmware name
> > > +               0x06            Shortened firmware name
> > > +               0x07            Firmware info string
> > > +               0x08            Hardware info string
> > >
> > >         Flags (data type 0x01)
> > >
> > > @@ -3155,6 +3160,23 @@ Read Controller Capabilities Command
> > >                 field is not available, it indicates that the LE Read
> > >                 Transmit Power HCI command was not available.
> > >
> > > +       Firmware name (date types 0x05 and 0x06)
> > > +
> > > +               Only one of these will be present if the device is loading
> > > +               some sort of runtime firmware. Only in the firwmare name
> > > +               happens to exceed the 255 charaters, the shortened type
> > > +               shall be used.
> > > +
> > > +               This value represents the driver chosen default firmware
> > > +               for a controller. In case it is changed via Set Runtime
> > > +               Firmware command that change will not be reflected here.
> > > +
> > > +       Firmware and hardware info (data types 0x07 and 0x08)
> > > +
> > > +               When provided by the hardware and the driver, these fields
> > > +               will contain string of the firmware or the hardware for
> > > +               debug or indentification purposes.
> > > +
> > >         This command generates a Command Complete event on success or
> > >         a Command Status event on failure.
> > >
> > > @@ -3852,6 +3874,70 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
> > >                                 Invalid Parameters
> > >
> > >
> > > +Set Runtime Firmware Command
> > > +============================
> > > +
> > > +       Command Code:           0x0057
> > > +       Controller Index:       <controller id>
> > > +       Command Parameters:     Action (1 Octet)
> > > +                               Firmware_Length (2 Octets)
> > > +                               Firmware (0-65535 Octets)
> > > +       Return Parameters:      Missing_Options (4 Octets)
> > > +
> > > +       This command allows configuration of runtime firmware or patch
> > > +       download setting. Since a vendor specific procedure is required,
> > > +       this command might not be supported by all controllers.
> > > +
> > > +       Possible values for the Action parameter:
> > > +               0       Reset to default driver firmware
> > > +               1       Reset to current or configure new firmware
> > > +
> > > +       When resetting to the default firmware, Firmware_Length shall be
> > > +       set to 0. The system will go back to the original firmware selected
> > > +       by the driver. When resetting to current firmware, Firmware_Length
> > > +       shall also be set to 0. If there has been never specified a new
> > > +       firmware, then a reset to default or current is not different.
> > > +
> > > +       Loading a new firmware can be triggered with the Action 1 and a
> > > +       Firmware specified. The Firmware is a string that would also be
> > > +       used in request_firmware() and has to be NUL terminated. The
> > > +       Firmware_Length field shall include the string length plus the
> > > +       additional NUL byte.
> > > +
> > > +       In the case a driver has no default driver firmware, then an
> > > +       Action 0 will fully reset the device into an unconfigured state.
> > > +
> > > +       When the support for runtime firwmare configuration is indicated
> > > +       in the supported options mask, then this command can be used to
> > > +       set the runtime firmware.
> > > +
> > > +       It is only possible to configure the runtime firmware when the
> > > +       controller is powered off.
> > > +
> > > +       For an unconfigured controller and when Missing_Options returns
> > > +       an empty mask, this means that a Index Added event for the now
> > > +       fully configured controller can be expected.
> > > +
> > > +       For a fully configured controller, the current controller index
> > > +       will become invalid and an Unconfigured Index Removed event will
> > > +       be sent. Once the firmware has been successfully loaded an Index
> > > +       Added event will be sent. There is no guarantee that the controller
> > > +       index stays the same.
> > > +
> > > +       All previous configured parameters and settings are lost when
> > > +       this command succeeds. The controller has to be treated as new
> > > +       one. Use this command for a fully configured controller only when
> > > +       you really know what you are doing.
> > > +
> > > +       This command generates a Command Complete event on success or a
> > > +       Command Status event on failure.
> > > +
> > > +       Possible errors:        Rejected
> > > +                               Not Supported
> > > +                               Invalid Parameters
> > > +                               Invalid Index
> > > +
> > > +
> > >  Command Complete Event
> > >  ======================
> > >
> > > --
> > > 2.29.2
> > >
>
>
>
> --
> Luiz Augusto von Dentz
