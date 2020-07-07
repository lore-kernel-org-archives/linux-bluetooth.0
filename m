Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DDAC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 20:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5432158C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 20:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dqJod+UN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgGGURf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgGGURf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 16:17:35 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D4EC061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 13:17:34 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id n4so2519076uae.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DAZkdSMy6rGL4HXgiQRy1c3I5dw1ddM0iPQtXxoHahE=;
        b=dqJod+UNQhVJ3Fx+S7PWIqRHnDCKbaQ3tsgfsN0vogU2uMBuaiscmPV9zaT6PwrCeU
         qAXZNqC2zqZjiEgG3civZzp5luib28FwVxrq9EMC1Q0GwO0z2D9bc+LZdQX4BCHsijqf
         chOiIsZI9WS6vOG6cDudlMjyRPUVh2SNZY8fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DAZkdSMy6rGL4HXgiQRy1c3I5dw1ddM0iPQtXxoHahE=;
        b=CoavVwS1V9HlqqFe3dkbQ67JP+wwikz0inR/hQTmrqkMbJwDBbljgzyIZcpvwIoyNX
         /fOpThyPfxODbesLQlRsrw1O7vp1u9/hbvgKAkAFIXXUCZ9yL9f58w8ZIZkLIzVsPXGU
         hCu2FnmJ/h3zLB4T1w+LT9jHhHf3Nr0k3XUcGawa7/ursg4+Ncix+NZ1BZ8D7Ddmcjgq
         inbSez4qrB2yg9BcTMlHVfvfyYbW+g3odEuqIQwovOcF/Uyhd83cRTYnzonZUdPDXvBH
         MzQ5mowSlxYWzjMYoaq4+Cc0BiR9xhwzbvljIAdL16I4giusp6RhcPEKJTAcyyiEzEaN
         CKaw==
X-Gm-Message-State: AOAM5325cSNpsdIQG3xx7OsAEXs9wlkuvX1eAonv8ZF54Bwljr9qTpOv
        nUFs5IinkLeP51Zh8/q6ttidqu+6NOuyOLmDF4mvvsjO
X-Google-Smtp-Source: ABdhPJwbwz2VtnczVTp0LUD8is096j7n/ZGvI9tGRI23EcsBchrW9jDRiV0Y8Xx3s0wkx1eyOgJKP2OV+eAf3+FK+3k=
X-Received: by 2002:ab0:1167:: with SMTP id g39mr21484290uac.60.1594153054128;
 Tue, 07 Jul 2020 13:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200706202518.1153647-1-abhishekpandit@chromium.org> <CABBYNZLDBFxa4ojp5HK9YbPjm+fB=qznKzp95hHPA-dN8-UsQA@mail.gmail.com>
In-Reply-To: <CABBYNZLDBFxa4ojp5HK9YbPjm+fB=qznKzp95hHPA-dN8-UsQA@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 7 Jul 2020 13:17:23 -0700
Message-ID: <CANFp7mWMsWTYeTYs1wTCZgynfi_ELMnNEpFnp9v-gmVhSc1jFg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v7 0/6] device: Allow devices to be marked as wake capable
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Luiz.

On Tue, Jul 7, 2020 at 10:50 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Abhishek,
>
> On Mon, Jul 6, 2020 at 1:25 PM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> >
> > Hi Luiz,
> >
> > This change accompanies a change in the kernel to allow marking devices
> > as wakeable so they can wake the system from suspend. Currently, only
> > HID devices support this and will be configured to allow this setting to
> > be changed via the WakeAllowed property.
> >
> > Accompanying kernel change: https://patchwork.kernel.org/patch/11609999/
> >
> > In order to set this flag, Bluez must call Set Device Flags with the
> > Remote Wakeup bit set. This change was tested with the accompanying
> > kernel changes on v5.4 with both manual tests and automated tests.
> >
> > Here's the tests that I ran manually:
> >   - Pair new HID device and confirm it has Wake Allowed to True
> >   (default). Verify device can be woken from suspend with device.
> >   - Restart bluetoothd, confirm Device Flags Changed event after Add
> >   Device has no Remote Wakeup flag and Set Device Flags is called
> >   afterwards to restore it. Verify wake from suspend still works.
> >   - Disable Wake allowed via dbus and confirm wake from suspend no
> >   longer works.
> >   - Restart bluetoothd and confirm Wake Allowed is still false. Verify
> >   wake from suspend does not work.
> >
> > Thanks
> > Abhishek
> >
> > Changes in v7:
> > * Fix more build issues reported by bluez.test.bot
> >
> > Changes in v6:
> > * Fix up some build issues reported by bluez.test.bot
> > * Save pending property id and emit success only after set flags returns
> > * Ignore multiple calls to set_wake_allowed to the same value
> > * Emit property error busy if same value is already sent to mgmt
> > * Fix up build issues reported by bluez.test.bot
> >
> > Changes in v5:
> > - Use device_flags mgmt op
> > * Decode device flags
> > * Refactor to use set_wake_flags and respond to device flags changed
> > * Add wake_override so we can keep track of user/profile configuration
> >   vs what is currently active
> > * Only call device_set_wake_support
> >
> > Changes in v4:
> > * Renamed wake_capable to wake_allowed
> > * Removed set_wake_capable mgmt op and updated add_device to accept
> >   flags to set whether a device is wakeable
> > * Refactored adapter_whitelist_add and adapter_auto_connect_add to call
> >   adapter_add_device
> > * Renamed WakeCapable to WakeAllowed
> > * Renamed WakeCapable to WakeAllowed
> > * Renamed device_set_profile_wake_support to just
> > device_set_wake_support
> >
> > Changes in v3:
> > * Added profile_wake_support and made wake_capable dependent on it
> > * Added documentation for WakeCapable
> > * Mark HID device to support wake from suspend
> >
> > Changes in v2:
> > * Added dbus api "WakeCapable" to set value
> > * Update device_set_wake_capable to be called by
> >   adapter_set_wake_capable_complete so we can emit property changed
> > * Newly added to show whether device is wake capable
> > * Removed automatically setting wake capable for HID devices
> >
> > Abhishek Pandit-Subedi (6):
> >   mgmt: Add mgmt op and events for device flags
> >   monitor: Decode device flags mgmt ops and event
> >   device: Support marking a device with wake allowed
> >   client: Display wake allowed property with info
> >   doc/device-api: Add WakeAllowed
> >   input: Make HID devices support wake
> >
> >  client/main.c           |   1 +
> >  doc/device-api.txt      |   5 +
> >  lib/mgmt.h              |  33 +++++++
> >  monitor/packet.c        |  70 ++++++++++++++
> >  profiles/input/device.c |   1 +
> >  profiles/input/hog.c    |   1 +
> >  src/adapter.c           |  93 ++++++++++++++++++
> >  src/adapter.h           |   3 +-
> >  src/device.c            | 210 ++++++++++++++++++++++++++++++++++++++++
> >  src/device.h            |  10 ++
> >  10 files changed, 426 insertions(+), 1 deletion(-)
> >
> > --
> > 2.27.0.212.ge8ba1cc988-goog
>
> Applied, thanks.
>
> --
> Luiz Augusto von Dentz
