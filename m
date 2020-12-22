Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97098C433E9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 19:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B0A224D2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 19:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgLVTRl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 14:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgLVTRl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 14:17:41 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1017C061793
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 11:17:00 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id q25so15828889oij.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 11:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJDSinIuXqAJVYNPHxOWiLPp46QfJfsymAOsptXr52s=;
        b=NgHXZRqLzFKd0keVPS0tYzuBj3o0Kg3S7TiuvyO+RSsv4ToPUCcPfiVv6QRfgY/nCf
         kdzJJkWHRNmlNFQTDUEGk+EzL0NCiwNCDhdq1Mc5lhrYSeBw77MdO0rQ8V72Oj+evWdh
         FgNwb0SkJUzeiS/9klSx3Y9E0ZHhljUM6NA5dOBF9Algg1TOAxlnowkBqEhn1vFvAj1i
         0MZVhASUWme41SvrWNz4PiFjrXR9U/WyyuA16wG56pAc7OmkQX2QD54xEDIGUbN7u04B
         QsCb0KRuWWEsiZvGcA/tIKFBFdmmzdQ/IrqsZXHwtuXxNNzcrTUQ4OofEyo+LKvweS66
         4OoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJDSinIuXqAJVYNPHxOWiLPp46QfJfsymAOsptXr52s=;
        b=FBqJ8LBDwIowA/O/kpSIX19NVwFtjtJ9xCUkAHaTuhT8CAH9gALz2j/0QEbjtBPIZQ
         ngH2HiVFj20RJeKau0P1ueu2NumfJ/wPSjfEEggV3ggsugnS2tUZyXEJLy0T2eKfGxAm
         /Ve3C5GqMOc4CrLTLdInKXMUyvRNUI/DMD2YDryo5xLIeNaJJ3L5kSPABVEwkG9lmFGx
         Ytp0uSOjyWhrZjGLi/fMe6b3mCxZsIOioYkfpbconxhZitKJAp0M8AjjNxNB650HYm6C
         wVbVmSpS0qLozk3WmedeI1UP9Xl7o3nUmHRL1H/UQ88980mPGIhFw0hxU6lIx4MlN3/L
         YydA==
X-Gm-Message-State: AOAM5329H7Ys5U68LlUB5oaIs162ma0AFbfEcTsJs86Ev/eB7jyi9qQN
        6E7sj3vSMX7SAPUr9ovc1yuDXFB1ZZP/DxaN4gOyhWZ4
X-Google-Smtp-Source: ABdhPJxZFE2fzDPkuLuJps4LyJ4L90VeqJeBDDMQ0P5bpvCtsVF7OBoQnL7ukFTJgAcFqaLDTb2HalT7TU7v1w7r4gk=
X-Received: by 2002:aca:efc6:: with SMTP id n189mr15375892oih.161.1608664619950;
 Tue, 22 Dec 2020 11:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20201222124651.101063-1-marcel@holtmann.org>
In-Reply-To: <20201222124651.101063-1-marcel@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 22 Dec 2020 11:16:48 -0800
Message-ID: <CABBYNZJcUJKTgzrv0Tw+8M41SsAZohAYrYYDbhEr5BuGgKahiQ@mail.gmail.com>
Subject: Re: [PATCH] doc/mgmt-api.txt: Introduce Set Runtime Firmware command
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Dec 22, 2020 at 4:49 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> ---
>  doc/mgmt-api.txt | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 1736ef009e75..47686ae32629 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2187,6 +2187,7 @@ Read Controller Configuration Information Command
>
>                 0       External configuration
>                 1       Bluetooth public address configuration
> +               2       Runtime firmware configuration
>
>         It is valid to call this command on controllers that do not
>         require any configuration. It is possible that a fully configured
> @@ -3132,6 +3133,10 @@ Read Controller Capabilities Command
>                 0x02            Max Encryption Key Size (BR/EDR)
>                 0x03            Max Encryption Key Size (LE)
>                 0x04            Supported Tx Power (LE)
> +               0x05            Complete firmware name
> +               0x06            Shortened firmware name
> +               0x07            Firmware info string
> +               0x08            Hardware info string
>
>         Flags (data type 0x01)
>
> @@ -3155,6 +3160,23 @@ Read Controller Capabilities Command
>                 field is not available, it indicates that the LE Read
>                 Transmit Power HCI command was not available.
>
> +       Firmware name (date types 0x05 and 0x06)
> +
> +               Only one of these will be present if the device is loading
> +               some sort of runtime firmware. Only in the firwmare name
> +               happens to exceed the 255 charaters, the shortened type
> +               shall be used.
> +
> +               This value represents the driver chosen default firmware
> +               for a controller. In case it is changed via Set Runtime
> +               Firmware command that change will not be reflected here.
> +
> +       Firmware and hardware info (data types 0x07 and 0x08)
> +
> +               When provided by the hardware and the driver, these fields
> +               will contain string of the firmware or the hardware for
> +               debug or indentification purposes.
> +
>         This command generates a Command Complete event on success or
>         a Command Status event on failure.
>
> @@ -3852,6 +3874,70 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
>                                 Invalid Parameters
>
>
> +Set Runtime Firmware Command
> +============================
> +
> +       Command Code:           0x0057
> +       Controller Index:       <controller id>
> +       Command Parameters:     Action (1 Octet)
> +                               Firmware_Length (2 Octets)
> +                               Firmware (0-65535 Octets)

My only concern with this command is that it seems to limit the
firmware size to 64K which perhaps is too small going forward in time
I suspect we might need 128K or even 256K if we want to be safe, so
perhaps it would be a better alternative to just have a different
location given which perhaps is even easier to parse given that by
default the drivers already load the firmware as a file so much of the
logic about uploading the firmware remains the same with the only
difference being the location. Btw, if we do change this to be file
based I guess it could be updated in the Firmware name which would
probably be great for the likes of bluetoothd so it can identify if an
alternative firmware has been loaded and skip loading it again, though
perhaps you intended the info to be used to match the loaded firmware
the problem with that is then the likes o bluetoothd will need to be
able to parse the firmware files to be able to tell if the info
matches.

> +       Return Parameters:      Missing_Options (4 Octets)
> +
> +       This command allows configuration of runtime firmware or patch
> +       download setting. Since a vendor specific procedure is required,
> +       this command might not be supported by all controllers.
> +
> +       Possible values for the Action parameter:
> +               0       Reset to default driver firmware
> +               1       Reset to current or configure new firmware
> +
> +       When resetting to the default firmware, Firmware_Length shall be
> +       set to 0. The system will go back to the original firmware selected
> +       by the driver. When resetting to current firmware, Firmware_Length
> +       shall also be set to 0. If there has been never specified a new
> +       firmware, then a reset to default or current is not different.
> +
> +       Loading a new firmware can be triggered with the Action 1 and a
> +       Firmware specified. The Firmware is a string that would also be
> +       used in request_firmware() and has to be NUL terminated. The
> +       Firmware_Length field shall include the string length plus the
> +       additional NUL byte.
> +
> +       In the case a driver has no default driver firmware, then an
> +       Action 0 will fully reset the device into an unconfigured state.
> +
> +       When the support for runtime firwmare configuration is indicated
> +       in the supported options mask, then this command can be used to
> +       set the runtime firmware.
> +
> +       It is only possible to configure the runtime firmware when the
> +       controller is powered off.
> +
> +       For an unconfigured controller and when Missing_Options returns
> +       an empty mask, this means that a Index Added event for the now
> +       fully configured controller can be expected.
> +
> +       For a fully configured controller, the current controller index
> +       will become invalid and an Unconfigured Index Removed event will
> +       be sent. Once the firmware has been successfully loaded an Index
> +       Added event will be sent. There is no guarantee that the controller
> +       index stays the same.
> +
> +       All previous configured parameters and settings are lost when
> +       this command succeeds. The controller has to be treated as new
> +       one. Use this command for a fully configured controller only when
> +       you really know what you are doing.
> +
> +       This command generates a Command Complete event on success or a
> +       Command Status event on failure.
> +
> +       Possible errors:        Rejected
> +                               Not Supported
> +                               Invalid Parameters
> +                               Invalid Index
> +
> +
>  Command Complete Event
>  ======================
>
> --
> 2.29.2
>


-- 
Luiz Augusto von Dentz
