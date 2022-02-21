Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA44C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Feb 2022 21:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiBUV1u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Feb 2022 16:27:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiBUV1t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Feb 2022 16:27:49 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D2CE26
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Feb 2022 13:27:25 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2d68d519a33so151374457b3.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Feb 2022 13:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=en06VWQMIBzgYO1j3+NeHVnv4oyBoDvjZcZZrOFc7kk=;
        b=FIFLY8NmOz8ozaxh4W4BXtaPFMq04RpA161tDa7rjOZSu1ZTs3/vazOiqYUYuTKveM
         7CquXAbs7CzDBoLlV61ahRiMavhQ3ca/HgUp/ApYuIRJpCLFBsW1E3QXLjfIAVkrOILi
         4VQM32v8gOCGhENFDVsrhVxHoTqCGGeALQgFzTeadfIvtU05en5QK6VYCGI+tCvydM/j
         dWE8ixJZOqygHb5rBfDfn6Zxc2/Z8mLwllUz1nKhAoyvP9dMLbmXKQuG24s1rmylTr+E
         H7n8JQd4ecJboiT0/xtTwYjkZnPzu65hvyFU+xEewSPh52SzvVoGeg2oMublSPEOkkSm
         avIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=en06VWQMIBzgYO1j3+NeHVnv4oyBoDvjZcZZrOFc7kk=;
        b=pgRtn7Xc9k3GbjunVzCuknwdsKwBzBQaClMvuklKa7nHHYTlP/vSU1pa226CG+udKa
         T3NUcdNLFcnrt5sH37gHb8O/t7QnDexDs0YTSGQPE+0Uyu4DYbu+xbRigNZ8g4M8Kj23
         kGD9tG3UeKu++Op1spwE3LbOAzQhHA7rNTIq9jDLPz21R+Yp8f75tGZuiZ8+SH/dfOIj
         ZsMJNcCMqP2h4nd0anRCIMpSNRXfiCsiF2iIIyVciGTIxl4osO5GOvMm8by2h4FlfBvp
         DypmZlFHb3/TXVxOVMakCMEk6xE8cKd61hGyDo/OC7CHOaXOY8gmG6HtWjSseipONHgl
         nZ1w==
X-Gm-Message-State: AOAM531DcV/l0QTIe4o1kyaqU5qGvobslLbRIyNJ4fCTUG0KnVnL6yMt
        hidUG5iIZO9CC2W3+eUODOJ2khmIqGxfKjnq2JeVA5vZ
X-Google-Smtp-Source: ABdhPJxF63L+Yk5I7u97BpBDcV3ioik3QEB44ebYOgM8moGOL93uwmMBMMEsIQ8FafgAKWr/qH0/SOmaIAMLKrVjfkU=
X-Received: by 2002:a81:8983:0:b0:2d6:44b1:4ccb with SMTP id
 z125-20020a818983000000b002d644b14ccbmr21579600ywf.358.1645478844839; Mon, 21
 Feb 2022 13:27:24 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CAJCQCtTdiPNkV1_b478_LkG11TMOPEdDGHTjf5LfZJpwWrK+bg@mail.gmail.com>
 <CAJCQCtTNk25u6sm_Xqt8qzf7mM5kmOrnXyD6pT1GKJ5z5-Kqbw@mail.gmail.com>
 <CAJCQCtRYKbTQ16eUq2qODZ=dE=HB6pZpLNswdqMbiWw+DBE9KQ@mail.gmail.com>
 <CABBYNZKfy-ntFhbx0TStNwFiwxCF4sPVaHS4wDbef0shb=pawg@mail.gmail.com>
 <CAJCQCtRiTQ1BTEHugxhS-zmXFG4qi4WLxsRyZsG9-_Q0isM+7Q@mail.gmail.com>
 <CAJCQCtS35JeABLDBaNpfgxjq+ZJ9rZgwtRnSYLNm8tMwtdYGMw@mail.gmail.com>
 <CABBYNZKTSe83iP4tm36we4cpAbeGUbEw9frZD1wCM9yo1zry5w@mail.gmail.com>
 <CAJCQCtTpHQe2co3fLNs5csKQchmwH=3YwQOvFnuc2nhjRseVnw@mail.gmail.com>
 <9ad505e1-7b59-7ebf-378b-23a6c0e25802@googlemail.com> <CABBYNZ+9tUKgLyUWM5vkMW8vHxYsXv6DEaDWdHt8xTTs6puGQA@mail.gmail.com>
 <aaeb4131-d177-d41e-617b-b0060cd83c92@googlemail.com>
In-Reply-To: <aaeb4131-d177-d41e-617b-b0060cd83c92@googlemail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Feb 2022 13:27:13 -0800
Message-ID: <CABBYNZLB+8UzhzttMrKbHW_+-A1EsY9iT5Y55VuOOEPuD4kAHQ@mail.gmail.com>
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chris,

On Mon, Feb 21, 2022 at 12:23 PM Chris Clayton <chris2553@googlemail.com> wrote:
>
> Hi Luiz,
>
> On 21/02/2022 17:11, Luiz Augusto von Dentz wrote:
> > Hi Chris,
> >
> > On Mon, Feb 21, 2022 at 5:22 AM Chris Clayton <chris2553@googlemail.com> wrote:
> >>
> >> Sorry folks, clicked Send instead of Save Draft in my earlier message.
> >>
> >> Anyway...
> >>
> >> On 18/02/2022 03:49, Chris Murphy wrote:
> >>> On Thu, Feb 17, 2022 at 5:15 PM Luiz Augusto von Dentz
> >>> <luiz.dentz@gmail.com> wrote:
> >>>>
> >>>> Hi Chris,
> >>>>
> >>>> On Thu, Feb 17, 2022 at 3:36 PM Chris Murphy <lists@colorremedies.com> wrote:
> >>>>>
> >>>>> OK I started over, and for now keeping the reporting constrained to
> >>>>> the hardware I personally have on hand.
> >>>>>
> >>>>> Hardware:
> >>>>> Lenovo Thinkpad X1 Carbon Gen 7
> >>>>> Bus 001 Device 004: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
> >>>>> Jefferson Peak (JfP)
> >>>>> Sony 1000XM3 headset
> >>>>> bluez-5.63-3.fc36.x86_64
> >>>>>
> >>>>> kernel 5.17.0-rc4
> >>>>> * remove the paired headset with bluetoothctl
> >>>>> * reset the headset so it's not longer paired either
> >>>>> * put the headset in pairing mode
> >>>>> * GNOME Settings Bluetooth panel sees -> LE_WH-1000XM3, Not Setup
> >>>>> * click on Not Setup and nothing happens
> >>>>
> >>>> Well from the logs it doesn't seem the GNOME Setting is trying to do
> >>>> anything, have you tried bluetoothctl> connect <address>
> >>>
> >>> `bluetoothctl scan on`  does see the device
> >>> $ bluetoothctl pair 38:18:4C:24:2D:1D
> >>> Device 38:18:4C:24:2D:1D not available
> >>> $ bluetoothctl connect 38:18:4C:24:2D:1D
> >>> Device 38:18:4C:24:2D:1D not available
> >>>
> >>> $ journalctl -b -o short-monotonic --no-hostname | grep -i blue
> >>> https://drive.google.com/file/d/1x9EDvDx6XUowyRy2056n6uW-4PLx5KRb/view?usp=sharing
> >>>
> >>>
> >>
> >> I too am experiencing the problem that already-paired devices fail to connect to my laptop when running a 5.17 kernel.
> >>
> >> Extract from dmesg shows:
> >> [    3.825684] Bluetooth: hci0: Waiting for firmware download to complete
> >> [    3.825910] Bluetooth: hci0: Firmware loaded in 1551910 usecs
> >> [    3.825910] Bluetooth: hci0: unexpected event 0xff length: 5 > 0
> >> [    3.825936] Bluetooth: hci0: Waiting for device to boot
> >> [    3.839948] Bluetooth: hci0: unexpected event 0xff length: 7 > 0
> >> [    3.839973] Bluetooth: hci0: Device booted in 13715 usecs
> >> [    3.840205] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-19-0-4.ddc
> >> [    3.843002] Bluetooth: hci0: Applying Intel DDC parameters completed
> >> [    3.843926] Bluetooth: hci0: Firmware revision 0.4 build 125 week 46 2021
> >>
> >> Extract from lshw shows:
> >>                    description: Bluetooth wireless interface
> >>                    product: AX201 Bluetooth
> >>                    vendor: Intel Corp.
> >>                    physical id: e
> >>                    bus info: usb@1:e
> >>                    version: 0.02
> >>                    capabilities: bluetooth usb-2.01
> >>                    configuration: driver=btusb maxpower=100mA speed=12Mbit/s
> >>
> >> I don't know whether this will help, but I've found that the problem only occurs when boot from cold (i.e power on the
> >> laptop. If I then do a warm reboot, my bluetooh devices connect successfully. The significant difference may be that on
> >> a cold start, the firmware needs to loaded whereas on a warm reboot I see:
> >>
> >> [    2.000989] Bluetooth: hci0: Firmware already loaded
> >>
> >> Hope this helps. I am happy to test any fixes or provide additional diagnostics, but I'm not subscribed so please cc me.
> >
> > What exactly doesn't work? Can't you power up the controller, etc?
>
> I have two bluetooth audio devices. One is a set of headphones and the other is a speaker. Both are paired with my
> laptop and, normally, both automatically connect to the laptop when I power them on. I've had the speaker for three
> years or more is has worked fine with all kernels that I have used up to and including the latest stable series -
> 5.16.10. The headphones were acquired a year or so ago and to date have worked with all kernels I have had installed
> since then. Consequently, this problem is a 5,17 regression.
>
> After a cold (power-on) boot with a 5.17 kernel, they do no connect automatically when switched on. Furthermore, if I
> use the blueman application to attempt to connect, that attempt fails. The only way that I have found to connect
> successfully is to do a reboot, after which the devices can connect automatically when I switch them on.
>
> I'm sorry, I have no idea what you mean by "Can't you power up the controller, etc?"

Use btmon to capture the trace when you attempt to connect, it also
would be a good idea to use bluetoothctl when attempting to connect.

-- 
Luiz Augusto von Dentz
