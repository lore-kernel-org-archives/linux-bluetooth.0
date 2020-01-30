Return-Path: <SRS0=xtvM=3T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF802C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 19:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A78B20708
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 19:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY0K9Z/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgA3TMz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:12:55 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45265 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA3TMz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jan 2020 14:12:55 -0500
Received: by mail-oi1-f194.google.com with SMTP id v19so4698066oic.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2020 11:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XOCylnx+cdn4ThF675MPYCr6UKkra/uRDidHN+CNNng=;
        b=HY0K9Z/XadUDUrz0vQJBaPVug6sxuioNYo/9QKTD8f+6Axhsi7qLHyHPl8i46Qo29q
         c7n9L9ZH6ANSs2GQOxmFmXbd5n3oKah0pna/TUycjvpyCKDYX/4BAm6W821D29r0s0C6
         0zSmW1eymYhQGrV2sR3H+5tVgD+rb0BXxMXYzcDC32EnbxxShCUvBy2V888E59ygxXxz
         aFNuib/trffQJA1kojjAl7agwk+DWj4hklF8reye1ET+QqGKq4hptdYR7GZgfR78C6A8
         jsCF5wpyOVKJLz6iKjy3HMY4YoRHsxFAQEc0onlLgQQMVvkOy3xObc3YZton4+qrd0bi
         BNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XOCylnx+cdn4ThF675MPYCr6UKkra/uRDidHN+CNNng=;
        b=Ou5gFaA5/LddlaUiaIRTpzgdFxf9fyQj3yxI/VA/zLt1GzTQB+dleddcVVSy2KVvS4
         utzBXX+UtolPLXu1iOkm8fKK171eo9KWjJCskQHed3Ha+TCZeFYcngZx+UxOebw1F3vj
         E+bhnCfqil0zQ+0Jbf71ius8L5esLkgTZ2tULBsAgOkfZV2nHXIyengbr0iU1wy0+Q7+
         FQCiiYzJTj/mToojpGOMLS3AwsZPp0uOzfKZS/EnTZ+2Xxs5VNsfiKyu16xM7eWUN+ri
         fcL3a6Pk9boVRbKOvMtOKX1+Mi3ZVH2KKHGIkK8pNQJhUQu2IyaUscQVtRahIZ+1Db2u
         232w==
X-Gm-Message-State: APjAAAV+grkNMhKYFj+OU7GiwxpfF0oV7/czSsfkZZTb9cHipP2mZxy9
        EN62aoDAlPjg4f3H3ZbPhO+8lgJs1br6ABqlXzM=
X-Google-Smtp-Source: APXvYqwq1u8xFtJRno2fuYHCa3NGCNpnccR5xFDmfD0dtR2RHyg8VwwkGlAup1390GgDIliX6JWTBhq/+T97Gma3hU0=
X-Received: by 2002:aca:ab51:: with SMTP id u78mr3955219oie.21.1580411574098;
 Thu, 30 Jan 2020 11:12:54 -0800 (PST)
MIME-Version: 1.0
References: <CAMH2TCooGyxiZbhersOCFMHLpjSAqKFq2_XswXx3nt200L-qBQ@mail.gmail.com>
 <CABBYNZLW7qe8ie-FLYaka7wKTeKAmBQYf0DG0ZZqbOu2eEOxPA@mail.gmail.com> <CAOVXEJKb-BNz_Y2xFnEcsiGYgZMaTEYjqrspw1TgCdsFgYNESQ@mail.gmail.com>
In-Reply-To: <CAOVXEJKb-BNz_Y2xFnEcsiGYgZMaTEYjqrspw1TgCdsFgYNESQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 30 Jan 2020 11:12:40 -0800
Message-ID: <CABBYNZJGvwZPvhJaeEYoq4Y2dz2pD6vMCyRPqcG0QUSarecifA@mail.gmail.com>
Subject: Re: L2CAP mtu preference set by user space clarification
To:     Sathish Narasimman <nsathish41@gmail.com>
Cc:     chethan tn <chethantn@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Mon, Jan 27, 2020 at 11:02 PM Sathish Narasimman
<nsathish41@gmail.com> wrote:
>
> Hi Luiz,
>
> There are some headsets that configure the MTU to 850(3M PHY) and then
> under some situation(noisy), it switches to 2M PHY packets for A2DP
> playback.  The reason behind this is their receiver's capability for
> better demodulation with QDPSK(2M PHY) when compared to 8DPSK(3M PHY).
>
> From Bluetooth specification, the remote device can request the
> LMP_preferred_rate with the LMP command to switch to 2M. When Baseband
> PHY is 2M,  the maximum possible packet type is 2DH5 which can hold
> 679 bytes ( 672 bytes of L2CAP MTU excluding the baseband headers).
>
> When L2CAP MTU for an A2DP packet is larger than 672 bytes, it happens
> to use 2 Baseband packets to deliver the L2CAP packet ie., like 1
> 2DH5(679 bytes) and 1 2DH3(171 bytes) packet to deliver 850 bytes of
> AVDTP Media. The is not efficient baseband utilization when the number
> of baseband ACL buffers used 2 no.s or even less that may lead to the
> delivery of one L2CAP packet that may take 4 slots more ( 2.5 ms
> more).
>
> When the remote device ( headset) has less number of baseband ACL
> buffers and Host(source) is aggressively delivering the audio data to
> render, it shall end up in a condition where the remote device does
> Flow OFF that shall make the Source device to wait until next FLOW ON
> send from the headset device. This kind of situation shall end up
> accumulating more buffers and FLOW ON/OFF become cyclic and leads to
> an audio break.
>
> Is there a better solution to overcome this issue?
>
> We considered changing the HOST MTU to 672bytes to overcome this issue
> that makes the remote headset device to use 2M. And found that the
> test results are positive.

But we only control the RX/input MTU not the TX/output MTU, so the
headset is at fault here it should have reconfigured the MTU
accordingly. For the RX/input there is a patch already adjusting the
MTU automatically when the socket MTU is set to 0:

commit 4b6e228e297b73451f3a4b12fb7d0b24d9d32e6f
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Thu Jan 2 15:00:57 2020 -0800

    Bluetooth: Auto tune if input MTU is set to 0

    This enables the code to set the input MTU using the underline link
    packet types when set to 0, previously this would likely be rejected by
    the remote peer since it would be bellow the minimal of 48 for BR/EDR
    or 23 for LE, that way it shall be safe to use 0 without causing any
    side effects.

    This is convenient for the likes of A2DP transport, see:

    https://habr.com/en/post/456182/

Without the remote side updating the MTU the host has no idea of the
changes to the packet type, also we would have to notify the upper
layer of the change if that happens mid stream, this relation between
packet type is not very clear to the L2CAP layer since it doesn't
distinct what data the upper layer is sending so we cannot just do the
MTU change locally and limit the output MTU based on the underline
link, expect perhaps if we would be willing to do that when MTU is set
to 0 in which we would artificially limit the packet length based on
the supported packet types, but does the controller notifies this sort
of change to the host at all?

>
> On Wed, Dec 18, 2019 at 5:49 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Chethan,
> >
> > On Mon, Dec 16, 2019 at 10:40 PM chethan tn <chethantn@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I would like to understand why the Source device L2CAP mtu is always
> > > set to the remote device mtu during L2CAP connection?
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tree/net/bluetooth/l2cap_core.c#n3370
> > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tree/net/bluetooth/l2cap_core.c#n3474
> > >
> > >
> > >
> > > I tried to set the specific MTU for specific profile connection( For
> > > Ex: A2DP connection - PSM  25) patch mentioned below, but the same is
> > > not reflected because of the below code.
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tree/net/bluetooth/l2cap_core.c#n3474
> >
> > The answer is pretty simple, we don't control the remote/output MTU,
> > so we cannot force the remote to use some arbitrary MTU if it doesn't
> > agree with.
> >
> > > Here the patch to set the MTU from the use space bluez.
> > >
> > > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > > index 58e1534a4..7d8a718c0 100644
> > > --- a/profiles/audio/a2dp.c
> > > +++ b/profiles/audio/a2dp.c
> > > @@ -1573,6 +1573,7 @@ static bool a2dp_server_listen(struct a2dp_server *server)
> > >                                 BT_IO_OPT_SOURCE_BDADDR,
> > >                                 btd_adapter_get_address(server->adapter),
> > >                                 BT_IO_OPT_PSM, AVDTP_PSM,
> > > +                               BT_IO_OPT_OMTU, AVDTP_MTU,
> > >                                 BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
> > >                                 BT_IO_OPT_MASTER, true,
> > >                                 BT_IO_OPT_INVALID);
> > > diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> > > index 51ead684a..786702cec 100644
> > > --- a/profiles/audio/avdtp.c
> > > +++ b/profiles/audio/avdtp.c
> > > @@ -2394,6 +2394,7 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
> > >                                 BT_IO_OPT_DEST_BDADDR,
> > >                                 device_get_address(session->device),
> > >                                 BT_IO_OPT_PSM, AVDTP_PSM,
> > > +                               BT_IO_OPT_OMTU, AVDTP_MTU,
> > >                                 BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
> > >                                 BT_IO_OPT_INVALID);
> > >         if (!io) {
> > > diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
> > > index 621a6e3cf..372b2579d 100644
> > > --- a/profiles/audio/avdtp.h
> > > +++ b/profiles/audio/avdtp.h
> > >
> > >
> > >
> > > Can you please suggest what is the best way to set the L2CAP mtu as
> > > user defined.
> > >
> > >
> > > Thanks
> > >
> > > Chethan
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Regards
> Sathish N



-- 
Luiz Augusto von Dentz
