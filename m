Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711AEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Feb 2022 17:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240939AbiBURLv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Feb 2022 12:11:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237880AbiBURLt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Feb 2022 12:11:49 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06AC25EB7
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Feb 2022 09:11:25 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id b35so7972599ybi.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Feb 2022 09:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7oRdDUAVUQE6u609exPuoIKJy7t783D9EKKz2t6KAfk=;
        b=hAQsru4mAsSQrJzReYOHa8pnEw7CKpfrlpVV2dTwVgT40DRz3ee1RegBO0CsbudeNz
         1w7IhgHr3UrQEL0bW0VfzxKxvmVmfSfpOPovUDFPu9BUIhnagcByB/xXG+N8Mu20jdIl
         jzmy0i9Yi8dpES7DfVP3L9bbY4Z8FHV9H2alXzakv+xc2aLHnYW9mMMobHA17wAFuUaM
         VmA0fsHi5e31wegV71qTdcRXA1IExj87Xs5EGe0a3Odu4br82Bz+qQ+fLpF7Aycnsb0d
         NdxUmQSBfRPgprn73fuCYhd/bC1e7e/uYGKbZ6ew9B3l1BkDL/KNRmikjTcCXnG0bsYT
         zUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7oRdDUAVUQE6u609exPuoIKJy7t783D9EKKz2t6KAfk=;
        b=NY5tIDO+h/NoEpqjAF0YHNw93aJNAUKqZjbqumwDk4kdSPB4KbQpvuR26hJm5EMpF4
         L3GdLxrCUmYL06PDM0szLhjOPPfMHpQ2pG5r2pu+3XN+EZ6tXNiqkoN/N3SHlYIVFPZ0
         aqWqUxWASaetR9TFjmIazxTe1vpigXMYLp8gxofNDuKFTrVCISX4N76zogQSnhDptzR7
         BnlWg2DBsJ5iMvCwTa8iwNBN5u9SgyyyXYAm1BWdpUZAk5hJf1fuA1Jy30Iz+9K5knfF
         WUMR/okUW4gV7G0/QHoB1Xhmw4XEjrxLUNBjRGCMow2F6GxqggNDA88q+UWv1MKQk4J/
         IHwA==
X-Gm-Message-State: AOAM5317lW2qOFvuNxtRu7Q3lkT0rWLWlfNjdF1l1sZuDIdpYpO9A2eu
        grJUtuB7+OMGJUSFYyy/k8PNIGSPp8jaIw+vOmAnJkUC
X-Google-Smtp-Source: ABdhPJxTE6eQx6cRBZhxzZUNbrMYpkrHTFhSdBrYGYyK06X2hgwtbi6sjlDGotuY6Nyl0MsvKvtEQuA6wGqCD1sHNnA=
X-Received: by 2002:a25:19d7:0:b0:624:7b8b:1bd3 with SMTP id
 206-20020a2519d7000000b006247b8b1bd3mr7368938ybz.401.1645463484777; Mon, 21
 Feb 2022 09:11:24 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CAJCQCtTdiPNkV1_b478_LkG11TMOPEdDGHTjf5LfZJpwWrK+bg@mail.gmail.com>
 <CAJCQCtTNk25u6sm_Xqt8qzf7mM5kmOrnXyD6pT1GKJ5z5-Kqbw@mail.gmail.com>
 <CAJCQCtRYKbTQ16eUq2qODZ=dE=HB6pZpLNswdqMbiWw+DBE9KQ@mail.gmail.com>
 <CABBYNZKfy-ntFhbx0TStNwFiwxCF4sPVaHS4wDbef0shb=pawg@mail.gmail.com>
 <CAJCQCtRiTQ1BTEHugxhS-zmXFG4qi4WLxsRyZsG9-_Q0isM+7Q@mail.gmail.com>
 <CAJCQCtS35JeABLDBaNpfgxjq+ZJ9rZgwtRnSYLNm8tMwtdYGMw@mail.gmail.com>
 <CABBYNZKTSe83iP4tm36we4cpAbeGUbEw9frZD1wCM9yo1zry5w@mail.gmail.com>
 <CAJCQCtTpHQe2co3fLNs5csKQchmwH=3YwQOvFnuc2nhjRseVnw@mail.gmail.com> <9ad505e1-7b59-7ebf-378b-23a6c0e25802@googlemail.com>
In-Reply-To: <9ad505e1-7b59-7ebf-378b-23a6c0e25802@googlemail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Feb 2022 09:11:14 -0800
Message-ID: <CABBYNZ+9tUKgLyUWM5vkMW8vHxYsXv6DEaDWdHt8xTTs6puGQA@mail.gmail.com>
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

On Mon, Feb 21, 2022 at 5:22 AM Chris Clayton <chris2553@googlemail.com> wrote:
>
> Sorry folks, clicked Send instead of Save Draft in my earlier message.
>
> Anyway...
>
> On 18/02/2022 03:49, Chris Murphy wrote:
> > On Thu, Feb 17, 2022 at 5:15 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> >>
> >> Hi Chris,
> >>
> >> On Thu, Feb 17, 2022 at 3:36 PM Chris Murphy <lists@colorremedies.com> wrote:
> >>>
> >>> OK I started over, and for now keeping the reporting constrained to
> >>> the hardware I personally have on hand.
> >>>
> >>> Hardware:
> >>> Lenovo Thinkpad X1 Carbon Gen 7
> >>> Bus 001 Device 004: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
> >>> Jefferson Peak (JfP)
> >>> Sony 1000XM3 headset
> >>> bluez-5.63-3.fc36.x86_64
> >>>
> >>> kernel 5.17.0-rc4
> >>> * remove the paired headset with bluetoothctl
> >>> * reset the headset so it's not longer paired either
> >>> * put the headset in pairing mode
> >>> * GNOME Settings Bluetooth panel sees -> LE_WH-1000XM3, Not Setup
> >>> * click on Not Setup and nothing happens
> >>
> >> Well from the logs it doesn't seem the GNOME Setting is trying to do
> >> anything, have you tried bluetoothctl> connect <address>
> >
> > `bluetoothctl scan on`  does see the device
> > $ bluetoothctl pair 38:18:4C:24:2D:1D
> > Device 38:18:4C:24:2D:1D not available
> > $ bluetoothctl connect 38:18:4C:24:2D:1D
> > Device 38:18:4C:24:2D:1D not available
> >
> > $ journalctl -b -o short-monotonic --no-hostname | grep -i blue
> > https://drive.google.com/file/d/1x9EDvDx6XUowyRy2056n6uW-4PLx5KRb/view?usp=sharing
> >
> >
>
> I too am experiencing the problem that already-paired devices fail to connect to my laptop when running a 5.17 kernel.
>
> Extract from dmesg shows:
> [    3.825684] Bluetooth: hci0: Waiting for firmware download to complete
> [    3.825910] Bluetooth: hci0: Firmware loaded in 1551910 usecs
> [    3.825910] Bluetooth: hci0: unexpected event 0xff length: 5 > 0
> [    3.825936] Bluetooth: hci0: Waiting for device to boot
> [    3.839948] Bluetooth: hci0: unexpected event 0xff length: 7 > 0
> [    3.839973] Bluetooth: hci0: Device booted in 13715 usecs
> [    3.840205] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-19-0-4.ddc
> [    3.843002] Bluetooth: hci0: Applying Intel DDC parameters completed
> [    3.843926] Bluetooth: hci0: Firmware revision 0.4 build 125 week 46 2021
>
> Extract from lshw shows:
>                    description: Bluetooth wireless interface
>                    product: AX201 Bluetooth
>                    vendor: Intel Corp.
>                    physical id: e
>                    bus info: usb@1:e
>                    version: 0.02
>                    capabilities: bluetooth usb-2.01
>                    configuration: driver=btusb maxpower=100mA speed=12Mbit/s
>
> I don't know whether this will help, but I've found that the problem only occurs when boot from cold (i.e power on the
> laptop. If I then do a warm reboot, my bluetooh devices connect successfully. The significant difference may be that on
> a cold start, the firmware needs to loaded whereas on a warm reboot I see:
>
> [    2.000989] Bluetooth: hci0: Firmware already loaded
>
> Hope this helps. I am happy to test any fixes or provide additional diagnostics, but I'm not subscribed so please cc me.

What exactly doesn't work? Can't you power up the controller, etc?

-- 
Luiz Augusto von Dentz
