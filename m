Return-Path: <SRS0=covd=3U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B980C33CB2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jan 2020 05:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2732082E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jan 2020 05:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpP6bbiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgAaFHl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Jan 2020 00:07:41 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46874 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgAaFHl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Jan 2020 00:07:41 -0500
Received: by mail-io1-f68.google.com with SMTP id t26so6730672ioi.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2020 21:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owFpUSGzMLt+ilIrhwEvul+H64pU1vs/nJcrZ/5Y6oc=;
        b=dpP6bbiFOmMWOcsM1lWQbPmH8B+/2WDWKxsnvZUwyYBEbVKeom9eT+ZZFUVa4jqzJ6
         WPKNC5pPBX45so2Qrp7lpbK/dyz5gJ/omjUN8Gi0khpEkoxr3CbZofocoy1UEKF9Hgd+
         hZOD/AR1m+GTWMPXtRx6MfKIXp3/FaCXFm5q0yyatsej4kTrhJdvL70669N6IWr1RxUz
         hINHg48XuXbPJxXkBw9EZz51CjAqRTzlBzRW/DR9CnnrJcg0HyRLMNgJfTZVxDA5bQt2
         0O4yPdyUxrZNtuMJsKpcx84cSV81SfU3b95rXRz5NIsxkv+7scn6ULcPUbYZNoxV1ZW0
         Ge4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owFpUSGzMLt+ilIrhwEvul+H64pU1vs/nJcrZ/5Y6oc=;
        b=GVt1uU1FXjC6Oxz4hOtQUnG8P3gcDGFk0ihvOAM9zONjKBJy+nFsKTkX4RIQnEsIHH
         3vG30KPDUUQqm0AwuYyJ8chl6hJQiUpMytGbOw3vWNZBhre8fvZrXLXeV1tysw0OlKX3
         XDeeLIH/XQBB+9+JjxhPMxe0sTmyduyB/SzZCLTcoUnx9i+jG0H9dZX/6y8qwxm/OIVS
         4ahfXK2DSmdjbcPUuGx/lozXIav5F8mRnW6TugrJcLIFK7ZiavOk0jA1AyqfTyjG6PdG
         zjn++XwaVFeFSW7Jv/S66LZxOXc1fF2rlblrP+RWcCOb2pCiWFbbTH6u5ZgXO5nEHxgx
         z+iw==
X-Gm-Message-State: APjAAAWgtwFS514xXyaOIePu+rCyWDpxuJUsZagBRWvgoUiCvgdH2oIy
        +QZaK+2sshkm9xPdP8TcwwJCj9nzDNrItFND799S2Kg9
X-Google-Smtp-Source: APXvYqw79kISxWP0KwKlqd+Z//DnWDkpBV8sziUwT6fWWcEE6kCaXzQ0wxxJjHTykXujo/sFZVjKUI9nDCqcC5hFmko=
X-Received: by 2002:a6b:dc09:: with SMTP id s9mr6756238ioc.185.1580447260239;
 Thu, 30 Jan 2020 21:07:40 -0800 (PST)
MIME-Version: 1.0
References: <CAMH2TCooGyxiZbhersOCFMHLpjSAqKFq2_XswXx3nt200L-qBQ@mail.gmail.com>
 <CABBYNZLW7qe8ie-FLYaka7wKTeKAmBQYf0DG0ZZqbOu2eEOxPA@mail.gmail.com>
 <CAOVXEJKb-BNz_Y2xFnEcsiGYgZMaTEYjqrspw1TgCdsFgYNESQ@mail.gmail.com> <CABBYNZJGvwZPvhJaeEYoq4Y2dz2pD6vMCyRPqcG0QUSarecifA@mail.gmail.com>
In-Reply-To: <CABBYNZJGvwZPvhJaeEYoq4Y2dz2pD6vMCyRPqcG0QUSarecifA@mail.gmail.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Fri, 31 Jan 2020 10:37:29 +0530
Message-ID: <CAOVXEJ+Vp=PYaMY+N7cvUuaMAi0SXekwuUpP6GPu1X7CHA=FBA@mail.gmail.com>
Subject: Re: L2CAP mtu preference set by user space clarification
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     chethan tn <chethantn@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz

Thanks for the suggestion.

On Fri, Jan 31, 2020 at 12:42 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sathish,
>
> On Mon, Jan 27, 2020 at 11:02 PM Sathish Narasimman
> <nsathish41@gmail.com> wrote:
> >
> > Hi Luiz,
> >
> > There are some headsets that configure the MTU to 850(3M PHY) and then
> > under some situation(noisy), it switches to 2M PHY packets for A2DP
> > playback.  The reason behind this is their receiver's capability for
> > better demodulation with QDPSK(2M PHY) when compared to 8DPSK(3M PHY).
> >
> > From Bluetooth specification, the remote device can request the
> > LMP_preferred_rate with the LMP command to switch to 2M. When Baseband
> > PHY is 2M,  the maximum possible packet type is 2DH5 which can hold
> > 679 bytes ( 672 bytes of L2CAP MTU excluding the baseband headers).
> >
> > When L2CAP MTU for an A2DP packet is larger than 672 bytes, it happens
> > to use 2 Baseband packets to deliver the L2CAP packet ie., like 1
> > 2DH5(679 bytes) and 1 2DH3(171 bytes) packet to deliver 850 bytes of
> > AVDTP Media. The is not efficient baseband utilization when the number
> > of baseband ACL buffers used 2 no.s or even less that may lead to the
> > delivery of one L2CAP packet that may take 4 slots more ( 2.5 ms
> > more).
> >
> > When the remote device ( headset) has less number of baseband ACL
> > buffers and Host(source) is aggressively delivering the audio data to
> > render, it shall end up in a condition where the remote device does
> > Flow OFF that shall make the Source device to wait until next FLOW ON
> > send from the headset device. This kind of situation shall end up
> > accumulating more buffers and FLOW ON/OFF become cyclic and leads to
> > an audio break.
> >
> > Is there a better solution to overcome this issue?
> >
> > We considered changing the HOST MTU to 672bytes to overcome this issue
> > that makes the remote headset device to use 2M. And found that the
> > test results are positive.
>
> But we only control the RX/input MTU not the TX/output MTU, so the
> headset is at fault here it should have reconfigured the MTU
> accordingly. For the RX/input there is a patch already adjusting the
> MTU automatically when the socket MTU is set to 0:
>
> commit 4b6e228e297b73451f3a4b12fb7d0b24d9d32e6f
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Thu Jan 2 15:00:57 2020 -0800
>
>     Bluetooth: Auto tune if input MTU is set to 0
>
>     This enables the code to set the input MTU using the underline link
>     packet types when set to 0, previously this would likely be rejected by
>     the remote peer since it would be bellow the minimal of 48 for BR/EDR
>     or 23 for LE, that way it shall be safe to use 0 without causing any
>     side effects.
>
>     This is convenient for the likes of A2DP transport, see:
>
>     https://habr.com/en/post/456182/
>
> Without the remote side updating the MTU the host has no idea of the
> changes to the packet type, also we would have to notify the upper
> layer of the change if that happens mid stream, this relation between
> packet type is not very clear to the L2CAP layer since it doesn't
> distinct what data the upper layer is sending so we cannot just do the
> MTU change locally and limit the output MTU based on the underline
> link, expect perhaps if we would be willing to do that when MTU is set
> to 0 in which we would artificially limit the packet length based on
> the supported packet types, but does the controller notifies this sort
> of change to the host at all?
>
> >
> > On Wed, Dec 18, 2019 at 5:49 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Chethan,
> > >
> > > On Mon, Dec 16, 2019 at 10:40 PM chethan tn <chethantn@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I would like to understand why the Source device L2CAP mtu is always
> > > > set to the remote device mtu during L2CAP connection?
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tree/net/bluetooth/l2cap_core.c#n3370
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tree/net/bluetooth/l2cap_core.c#n3474
> > > >
> > > >
> > > >
> > > > I tried to set the specific MTU for specific profile connection( For
> > > > Ex: A2DP connection - PSM  25) patch mentioned below, but the same is
> > > > not reflected because of the below code.
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tree/net/bluetooth/l2cap_core.c#n3474
> > >
> > > The answer is pretty simple, we don't control the remote/output MTU,
> > > so we cannot force the remote to use some arbitrary MTU if it doesn't
> > > agree with.
> > >
> > > > Here the patch to set the MTU from the use space bluez.
> > > >
> > > > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > > > index 58e1534a4..7d8a718c0 100644
> > > > --- a/profiles/audio/a2dp.c
> > > > +++ b/profiles/audio/a2dp.c
> > > > @@ -1573,6 +1573,7 @@ static bool a2dp_server_listen(struct a2dp_server *server)
> > > >                                 BT_IO_OPT_SOURCE_BDADDR,
> > > >                                 btd_adapter_get_address(server->adapter),
> > > >                                 BT_IO_OPT_PSM, AVDTP_PSM,
> > > > +                               BT_IO_OPT_OMTU, AVDTP_MTU,
> > > >                                 BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
> > > >                                 BT_IO_OPT_MASTER, true,
> > > >                                 BT_IO_OPT_INVALID);
> > > > diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> > > > index 51ead684a..786702cec 100644
> > > > --- a/profiles/audio/avdtp.c
> > > > +++ b/profiles/audio/avdtp.c
> > > > @@ -2394,6 +2394,7 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
> > > >                                 BT_IO_OPT_DEST_BDADDR,
> > > >                                 device_get_address(session->device),
> > > >                                 BT_IO_OPT_PSM, AVDTP_PSM,
> > > > +                               BT_IO_OPT_OMTU, AVDTP_MTU,
> > > >                                 BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
> > > >                                 BT_IO_OPT_INVALID);
> > > >         if (!io) {
> > > > diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
> > > > index 621a6e3cf..372b2579d 100644
> > > > --- a/profiles/audio/avdtp.h
> > > > +++ b/profiles/audio/avdtp.h
> > > >
> > > >
> > > >
> > > > Can you please suggest what is the best way to set the L2CAP mtu as
> > > > user defined.
> > > >
> > > >
> > > > Thanks
> > > >
> > > > Chethan
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> > Regards
> > Sathish N
>
>
>
> --
> Luiz Augusto von Dentz
