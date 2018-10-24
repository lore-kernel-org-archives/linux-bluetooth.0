Return-Path: <SRS0=W/a7=NE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA909C004D3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Oct 2018 08:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB412081B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Oct 2018 08:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6bRIvKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB412081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeJXRMv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:12:51 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:35754 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJXRMv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Oct 2018 13:12:51 -0400
Received: by mail-oi1-f169.google.com with SMTP id 22-v6so3434829oiz.2;
        Wed, 24 Oct 2018 01:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9hDAxNHDUZxDu7NLZYPeQG5y7kYC4OJPpfpq15ytuVQ=;
        b=K6bRIvKShrcPk7V3Xugw1qI2zRNmJuo+M2y1rxlUhWzRUkE6wCMd2eF3pUAFw4BNfC
         EEiYN0fCokJ4fO387v4i42HZx1GgLjRDsMg+3rVnYh8BU8wIoGJDpWVhomTQ2gypI1vw
         gcVpLDDaSORS3l/H4DgRq3bFCVJ+nvMUqd5LQ75CliSTDDPCED1Yo6wH7wyxCWeBA+Im
         3Smqq7pjdYLcMh8H0tU4JtDGGxEO1yoJiCNXy9ZJFuW+qjJg988dJWEVkF+ReJCvRQNq
         nTx4snUDWkvlngVmW2suRrsXJEprxFhwzxHitIzJVG7KibidbNL/g5BGh0nHSB36jcTb
         MpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hDAxNHDUZxDu7NLZYPeQG5y7kYC4OJPpfpq15ytuVQ=;
        b=LXe5oA5kZadDGR04k6llLfE2OGwNWPaww97rYy7yBEFworZtO1whK3fu5tnWsQFNCF
         SzprZDDQ2bp8gZpzNUeFkvqA1l+ZrbBFdJjtGrbc9FqZ7YaJnyYVhaO1XEFflGZMpkEu
         udCleNZPM/ufQ0PBiPrc9eR+f/L49a5mNgQsC2i+A4S8kNqMyC7OSKoMAvByUK861WRO
         tj90rMODZrks6p/cZof2Jbar/FbTFp7NBHUAs9c9JoLXAwS9l50XwXgM4T23RKP6l2LY
         nKai9ei6/4U4OfAVlREgUjvDWBPJO6zVfCRJk/flOexggwxbwaRQ3e3ce+BcXNgSXAQf
         gdVQ==
X-Gm-Message-State: AGRZ1gKK+S9FyCVvsHGWJZE7s+fYyO2BgF703h+NPpzUxgFcI1qIGGZ5
        88JQcaxhB7ryqy8VkLLKej/AMjdeK5oEh0+9G9r7Xej/
X-Google-Smtp-Source: AJdET5dHsLBv8RwpcTFEKHyC1UWS2AseRqu6R23UOJERWFkXMSNDcWXsohkirqdySXeXXzKnti872WBqevW9D51snfw=
X-Received: by 2002:aca:c30d:: with SMTP id t13-v6mr843257oif.251.1540370739007;
 Wed, 24 Oct 2018 01:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <6ec9eec6-a1fa-7046-8b35-9f014424d4eb@bakke.com>
In-Reply-To: <6ec9eec6-a1fa-7046-8b35-9f014424d4eb@bakke.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 24 Oct 2018 11:45:27 +0300
Message-ID: <CABBYNZKmPxhy4szxFDEBFwPReuse3AHR3ofXfM7+69ygd1S-ng@mail.gmail.com>
Subject: Re: bluez/input/HID keyboard bugs
To:     dag@bakke.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Wed, Oct 24, 2018 at 12:17 AM Dag Bakke <dag@bakke.com> wrote:
>
> Got myself a bluetooth keyboard. Got issues. More so than
> I expected in 2018.
>
> Googling for these issues reveal that they are all problems
> seen before, but I am unable to find someone coming up with an actual
> explanation or fix for either of them. Nor have I found a public
> bugtracker for the userspace side of bluez.
>
>
>
>
> 1. If I press/release CapsLock on the (paired, connected) BT keyboard,
> evbug immediately reports a neverending stream of input. No further
> input from the BT kbd is possible.
>
> tcpdump -i bluetooth0 reports exactly two L2CAP packets in this
> scenario.
>
> If I first press/release CapsLock on a connected USB keyboard, the
> BT keyboard becomes unresponsive. No further input from
> BT is possible.
>
> This is 100% reproducible in my environment.
>
> Making a kernel keymap where CapsLock decodes as VoidSymbol appears
> to work around this problem in the console. A similar workaround for
> X11 also "works", until it suddenly doesn't.
>
> I *really* have no clue if this belongs in linux-bluetooth,
> linux-input or both.

This sounds like something for linux-input as it is probably related to HID.

>
>
> 2. When powering the BT keyboard after having (re)started bluetoothd,
> I get the following in the log:
>
> Oct 23 20:23:07 ds81 bluetoothd[7904]: No agent available for request type 0
> Oct 23 20:23:07 ds81 bluetoothd[7904]: device_request_pin: Operation not permitted
>

Weird, if your device wouldn't be paired and trusted it wouldn't even
connect so I wonder if the keyboard is trying to repair or something,
btmon logs would probably help us identify what is happening here.

> Now, this keyboard was previously paired and trusted. The link key is present etc.
> But it does not connect properly the first time.
> Disconnecting/reconnecting the kbd yeilds:
>
> Oct 23 20:23:43 ds81 kernel: hid-generic 0005:0A5C:8502.001B: unknown main item tag 0x0
> Oct 23 20:23:43 ds81 kernel: input: Convertible 2 TKL Keyboard as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3.2/1-1.3.2:1.0/bluetooth/hci0/hci0:256/0005:0A5C:8502.001B/input/input74
> Oct 23 20:23:43 ds81 kernel: evbug: Connected device: input74 (Convertible 2 TKL Keyboard at f8:16:54:64:c6:1a)
> Oct 23 20:23:43 ds81 kernel: input: Convertible 2 TKL Consumer Control as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3.2/1-1.3.2:1.0/bluetooth/hci0/hci0:256/0005:0A5C:8502.001B/input/input75
> Oct 23 20:23:43 ds81 kernel: evbug: Connected device: input75 (Convertible 2 TKL Consumer Control at f8:16:54:64:c6:1a)
> Oct 23 20:23:43 ds81 kernel: input: Convertible 2 TKL System Control as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3.2/1-1.3.2:1.0/bluetooth/hci0/hci0:256/0005:0A5C:8502.001B/input/input76
> Oct 23 20:23:43 ds81 kernel: evbug: Connected device: input76 (Convertible 2 TKL System Control at f8:16:54:64:c6:1a)
> Oct 23 20:23:43 ds81 kernel: hid-generic 0005:0A5C:8502.001B: input: BLUETOOTH HID v1.1b Keyboard [Convertible 2 TKL] on f8:16:54:64:c6:1a
> Oct 23 20:23:43 ds81 bluetoothd[7904]: No agent available for request type 0
> Oct 23 20:23:43 ds81 bluetoothd[7904]: device_request_pin: Operation not permitted
>
>
> Despite the last two lines in the log, input is now accepted. So it *is*
> possible to make use of a BT keyboard without an agent running all the time.
>
> Can bluetoothd be made to permit a connection at the first attempt as well?

I guess it is permitting to connect it just don't allow to repair
since in case of had no agent the adapter would not even be pairable,
though perhaps you are setting it discoverable all the time which is
only recommended when you are going to setup a new device. Again btmon
logs would probably help us identify what is really happening.

>
>
>
> 3. Whenever my BT keyboard goes to sleep or disconnects for any
> reason, bluetoothd starts spinning at 100% CPU. And remains doing
> so until the keyboard reconnects or bluetoothd is restarted. This is
> also 100% reproducible. Makes for noisy fans and unnecessary battery
> consumption.
>
> Running bluetoothd -n -d appears to indicate that we're spinning in:
>
> profiles/input/device.c:input_device_enter_reconnect_mode()
> path=/org/bluez/hci0/dev_00_18_00_3D_8B_E9 reconnect_mode=device

Hmm, that sounds like a bug.

> Running a debug build of bluetoothd through gdb was unsuccessful.
> A bit clueless with gdb, sorry.
>
> A previous posting to linux-bluetooth about this particular issue
> received no interest. Please let me know what I can do to change this.
>
>
>
>
> Happy to provide more details.
> email works, and I am also in #bluez for the time being.
>
>
> Thank you,
>
> Dag B
>
>
>
> Environment:
> PC with kernel 4.19.0-gentoo and bluez 5.50.
> (USB and BT kbd connected at the same time.
> If this is a known problem, does it have to be?)
>
> BT hardware:
> Intel 7260 NGW M.2 wifi/bt combo
> Filco Convertible 2 TKL keyboard
>
> relevant kernel config options:
> CONFIG_BT=y
> CONFIG_BT_BREDR=y
> CONFIG_BT_RFCOMM=y
> CONFIG_BT_RFCOMM_TTY=y
> CONFIG_BT_BNEP=y
> CONFIG_BT_BNEP_MC_FILTER=y
> CONFIG_BT_BNEP_PROTO_FILTER=y
> CONFIG_BT_HIDP=y
> CONFIG_BT_HS=y
> CONFIG_BT_LE=y
> CONFIG_BT_INTEL=y
> CONFIG_BT_BCM=y
> CONFIG_BT_RTL=y
> CONFIG_BT_HCIBTUSB=y
> CONFIG_BT_HCIBTUSB_BCM=y
> CONFIG_BT_HCIBTUSB_RTL=y
> CONFIG_HID=y
> CONFIG_HID_BATTERY_STRENGTH=y
> CONFIG_HID_GENERIC=y
> CONFIG_HID_LOGITECH=y
> CONFIG_HID_LOGITECH_HIDPP=y
> CONFIG_USB_HID=y
> CONFIG_HID_PID=y
> CONFIG_USB_HIDDEV=y
>
> info from bluetoothd:
> Controller F8:16:54:64:C6:1A (public)
>         Name: BlueZ 5.50
>         Alias: BlueZ 5.50
>         Class: 0x00000104
>         Powered: yes
>         Discoverable: no
>         Pairable: yes
>         UUID: Generic Attribute Profile
> (00001801-0000-1000-8000-00805f9b34fb)
>         UUID: A/V Remote Control
> (0000110e-0000-1000-8000-00805f9b34fb)
>         UUID: PnP Information
> (00001200-0000-1000-8000-00805f9b34fb)
>         UUID: A/V Remote Control Target
> (0000110c-0000-1000-8000-00805f9b34fb)
>         UUID: Generic Access Profile
> (00001800-0000-1000-8000-00805f9b34fb)
>         Modalias: usb:v1D6Bp0246d0532
>         Discovering: no
>
> Device 00:18:00:3D:8B:E9 (public)
>         Name: Convertible 2 TKL
>         Alias: Convertible 2 TKL
>         Class: 0x00000540
>         Icon: input-keyboard
>         Paired: yes
>         Trusted: yes
>         Blocked: no
>         Connected: yes
>         LegacyPairing: no
>         UUID: Human Interface Device...
> (00001124-0000-1000-8000-00805f9b34fb)
>         UUID: PnP Information
> (00001200-0000-1000-8000-00805f9b34fb)
>         Modalias: usb:v0A5Cp8502d011B
>
>


-- 
Luiz Augusto von Dentz
