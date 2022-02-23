Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9549EC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Feb 2022 17:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiBWRvx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiBWRvt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 12:51:49 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E045FF7
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 09:51:17 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id bt13so49609854ybb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 09:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oyGzCCsTxL2ax+dMY7HY2XSRxb1v1nlhywd3ZeTuYRY=;
        b=PzqlxJ8d6dwYYPBSvF7v3H605oDOreXGgeJ97Xe+4wxDfLGVEMbhwic2tpXCz6aNIA
         /HMNG4u9XPz7y2cAzLFneXBxfuydYIeUVj3LDfe6z9PmfLhuvLU9shMjYg1ct7PHZlr7
         1y1bwgteBDLW8MxbH+L1vvF0VywYZJ24wTsSn9zTPyYwqmT6n2lNiyAJt8pau7y/GFd3
         s5xRmECa4lUAS2VvThqc3dwAzfyGCNvIA1qhfNt6xuxVAz5nGST1H4JWBJPxmnDuqluS
         Tw+IAfLhfW4q3rdOP9n4N7pfNa05bitG/FQtfCd9AQkyNkiNE2GBOZkLWQstZWtedHNG
         OR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyGzCCsTxL2ax+dMY7HY2XSRxb1v1nlhywd3ZeTuYRY=;
        b=ztXBhgJErVsYiqqlazUM4og6cpPxQhKCVHo65MAjCv8qFvxnVZEcmdWw9wivBpokHZ
         k1VxFtqiUQRtGbzxFv5NFNPK0Z3oCYD027JvqFe/oQ15jdbJGOQ+cndVZ0qWX4BoOYED
         vgxLIi0pnBAUN2jyzV2klzxnV7GeixDn4K5U1VeOMuXGz8ExdRUp71LvHrSmOYHSAnph
         bSB2we8ZKteSgnNbFwIQqoJxELMNjgwn7mT19qbCvn7Plm2BhWikbviiNKlM8rK1ypvD
         kZx/t6PVOkfhp+NGNxM6MIGM+gE1HLEHgA182s/DPDxyzlv0GUcEiH93XCf/xEF6f82y
         bGpw==
X-Gm-Message-State: AOAM530r9lb5HBJtKJxtl1hiT7wKLqBOl5Egbp6OVeCi1az6G4+oChQ/
        BfqzPGTnvMV5gg2PnUwkCGxxPpD4zhENCaeEt40=
X-Google-Smtp-Source: ABdhPJxPGJVLBwWN2U+6Wi+8A6kEhenVU7b7mhpgvWVEK+T7mm09BaqVERTnMs5og177qdRhtsWUgdGIxKlFRft7Zn4=
X-Received: by 2002:a25:19d7:0:b0:624:7b8b:1bd3 with SMTP id
 206-20020a2519d7000000b006247b8b1bd3mr698638ybz.401.1645638676753; Wed, 23
 Feb 2022 09:51:16 -0800 (PST)
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
 <aaeb4131-d177-d41e-617b-b0060cd83c92@googlemail.com> <CABBYNZLB+8UzhzttMrKbHW_+-A1EsY9iT5Y55VuOOEPuD4kAHQ@mail.gmail.com>
 <b1a4a920-dbba-58be-72b4-2c95b9b79283@googlemail.com> <82216882-463a-8976-e6bc-4a8919107a31@googlemail.com>
In-Reply-To: <82216882-463a-8976-e6bc-4a8919107a31@googlemail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 23 Feb 2022 09:51:05 -0800
Message-ID: <CABBYNZ+mO1gQgfwhemY9cqbi8vNLm_60A9c1vPYT2tH4rhgFww@mail.gmail.com>
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Feb 22, 2022 at 12:03 PM Chris Clayton <chris2553@googlemail.com> wrote:
>
> Hi Luiz.
>
> On 21/02/2022 22:33, Chris Clayton wrote:
> > Thanks Luiz.
> >
> > On 21/02/2022 21:27, Luiz Augusto von Dentz wrote:
> >> Hi Chris,
> >>
> >> On Mon, Feb 21, 2022 at 12:23 PM Chris Clayton <chris2553@googlemail.com> wrote:
> >>>
> >>> Hi Luiz,
> >>>
> >>> On 21/02/2022 17:11, Luiz Augusto von Dentz wrote:
> >>>> Hi Chris,
> >>>>
> >>>> On Mon, Feb 21, 2022 at 5:22 AM Chris Clayton <chris2553@googlemail.com> wrote:
> >>>>>
> >>>>> Sorry folks, clicked Send instead of Save Draft in my earlier message.
> >>>>>
> >>>>> Anyway...
> >>>>>
> >>>>> On 18/02/2022 03:49, Chris Murphy wrote:
> >>>>>> On Thu, Feb 17, 2022 at 5:15 PM Luiz Augusto von Dentz
> >>>>>> <luiz.dentz@gmail.com> wrote:
> >>>>>>>
> >>>>>>> Hi Chris,
> >>>>>>>
> >>>>>>> On Thu, Feb 17, 2022 at 3:36 PM Chris Murphy <lists@colorremedies.com> wrote:
> >>>>>>>>
> >>>>>>>> OK I started over, and for now keeping the reporting constrained to
> >>>>>>>> the hardware I personally have on hand.
> >>>>>>>>
> >>>>>>>> Hardware:
> >>>>>>>> Lenovo Thinkpad X1 Carbon Gen 7
> >>>>>>>> Bus 001 Device 004: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
> >>>>>>>> Jefferson Peak (JfP)
> >>>>>>>> Sony 1000XM3 headset
> >>>>>>>> bluez-5.63-3.fc36.x86_64
> >>>>>>>>
> >>>>>>>> kernel 5.17.0-rc4
> >>>>>>>> * remove the paired headset with bluetoothctl
> >>>>>>>> * reset the headset so it's not longer paired either
> >>>>>>>> * put the headset in pairing mode
> >>>>>>>> * GNOME Settings Bluetooth panel sees -> LE_WH-1000XM3, Not Setup
> >>>>>>>> * click on Not Setup and nothing happens
> >>>>>>>
> >>>>>>> Well from the logs it doesn't seem the GNOME Setting is trying to do
> >>>>>>> anything, have you tried bluetoothctl> connect <address>
> >>>>>>
> >>>>>> `bluetoothctl scan on`  does see the device
> >>>>>> $ bluetoothctl pair 38:18:4C:24:2D:1D
> >>>>>> Device 38:18:4C:24:2D:1D not available
> >>>>>> $ bluetoothctl connect 38:18:4C:24:2D:1D
> >>>>>> Device 38:18:4C:24:2D:1D not available
> >>>>>>
> >>>>>> $ journalctl -b -o short-monotonic --no-hostname | grep -i blue
> >>>>>> https://drive.google.com/file/d/1x9EDvDx6XUowyRy2056n6uW-4PLx5KRb/view?usp=sharing
> >>>>>>
> >>>>>>
> >>>>>
> >>>>> I too am experiencing the problem that already-paired devices fail to connect to my laptop when running a 5.17 kernel.
> >>>>>
> >>>>> Extract from dmesg shows:
> >>>>> [    3.825684] Bluetooth: hci0: Waiting for firmware download to complete
> >>>>> [    3.825910] Bluetooth: hci0: Firmware loaded in 1551910 usecs
> >>>>> [    3.825910] Bluetooth: hci0: unexpected event 0xff length: 5 > 0
> >>>>> [    3.825936] Bluetooth: hci0: Waiting for device to boot
> >>>>> [    3.839948] Bluetooth: hci0: unexpected event 0xff length: 7 > 0
> >>>>> [    3.839973] Bluetooth: hci0: Device booted in 13715 usecs
> >>>>> [    3.840205] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-19-0-4.ddc
> >>>>> [    3.843002] Bluetooth: hci0: Applying Intel DDC parameters completed
> >>>>> [    3.843926] Bluetooth: hci0: Firmware revision 0.4 build 125 week 46 2021
> >>>>>
> >>>>> Extract from lshw shows:
> >>>>>                    description: Bluetooth wireless interface
> >>>>>                    product: AX201 Bluetooth
> >>>>>                    vendor: Intel Corp.
> >>>>>                    physical id: e
> >>>>>                    bus info: usb@1:e
> >>>>>                    version: 0.02
> >>>>>                    capabilities: bluetooth usb-2.01
> >>>>>                    configuration: driver=btusb maxpower=100mA speed=12Mbit/s
> >>>>>
> >>>>> I don't know whether this will help, but I've found that the problem only occurs when boot from cold (i.e power on the
> >>>>> laptop. If I then do a warm reboot, my bluetooh devices connect successfully. The significant difference may be that on
> >>>>> a cold start, the firmware needs to loaded whereas on a warm reboot I see:
> >>>>>
> >>>>> [    2.000989] Bluetooth: hci0: Firmware already loaded
> >>>>>
> >>>>> Hope this helps. I am happy to test any fixes or provide additional diagnostics, but I'm not subscribed so please cc me.
> >>>>
> >>>> What exactly doesn't work? Can't you power up the controller, etc?
> >>>
> >>> I have two bluetooth audio devices. One is a set of headphones and the other is a speaker. Both are paired with my
> >>> laptop and, normally, both automatically connect to the laptop when I power them on. I've had the speaker for three
> >>> years or more is has worked fine with all kernels that I have used up to and including the latest stable series -
> >>> 5.16.10. The headphones were acquired a year or so ago and to date have worked with all kernels I have had installed
> >>> since then. Consequently, this problem is a 5,17 regression.
> >>>
> >>> After a cold (power-on) boot with a 5.17 kernel, they do no connect automatically when switched on. Furthermore, if I
> >>> use the blueman application to attempt to connect, that attempt fails. The only way that I have found to connect
> >>> successfully is to do a reboot, after which the devices can connect automatically when I switch them on.
> >>>
> >>> I'm sorry, I have no idea what you mean by "Can't you power up the controller, etc?"
> >>
> >> Use btmon to capture the trace when you attempt to connect, it also
> >> would be a good idea to use bluetoothctl when attempting to connect.
> >
> > It's getting late now, so I'll do a btmon trace tomorrow. From it's name, I assume bluetoothctl is part of the systemd
> > suite. I don't have systemd on the laptop but use sysvinit to start userspace including, of course, bluetoothd.
> >
>
> I've trying to get a btmon trace but the problem of devices failing to connect has become intermittent. I pulled the
> latest changes from Linus' tree this morning and built and installed the related kernel. When connection fails I see the
> header it always spits out, but nothing else. When connection succeeds, there is plenty of output.
>
> Tomorrow, I'll turn on debug in bluetoothd and see what the difference between a successful and a failed connection is.

We are starting to suspect this is not a new issue, it just become
easier to reproduce with newer kernels since the mgmt commands are now
handled by a different work/thread which probably takes longer to
respond hitting problems such as:

https://github.com/bluez/bluez/issues/275#issuecomment-1020608282

This has been fixed by:

https://github.com/bluez/bluez/commit/faad125c5505b941f06c54525616e192a6369208
https://github.com/bluez/bluez/commit/5f378404bff6bbfea3f20e36535c494efa5066a5

So the timer doesn't start until the request is sent. but obviously
older versions of userspace don't have that fix so they end up
cancelling the loading of LTKs, this would explain why reloading the
daemon would make it work again.

-- 
Luiz Augusto von Dentz
