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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07531C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 05:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA31D2083E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 05:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMf0fe8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgA3FTp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jan 2020 00:19:45 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:43563 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgA3FTo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jan 2020 00:19:44 -0500
Received: by mail-il1-f196.google.com with SMTP id o13so1991509ilg.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2020 21:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vCPHJREq4iRGuiNz9Pn0NktTpek3dx8mHhpUo4kMVmk=;
        b=KMf0fe8v5mPOrgIZFMpumqnHK1hDiNLm7EeMLChuB4NnWkMZ0Inge41LgFBgHbD0Xi
         G8IlZZ38BVAOmW/awdy097sTmjGIIknI+upJLIMvNMIHcIU4VYevuY+oT6m3HZFSMUFX
         d26zWXqscokCD48NmMlknJ9LMtCf5SO3oY12u/HQUmxsQnoKXlNHvfzDGf0ymrwuyc5S
         Bm6ouFl5ECNOfcM2uZbmHfNhGUvAI8KY/1aKQZO86zTib+lxBU53C+gv31aVFtZTy92+
         0npDghJZ+Ne7VNa3X9yK2GaNuSxlN/cOIZioUiJu5yWK+ryZtwdrR6HWhIsJ8QkrklrN
         Zkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCPHJREq4iRGuiNz9Pn0NktTpek3dx8mHhpUo4kMVmk=;
        b=cT75Kb9tSAABPxjJjsJZcH7B8MErVTNAiwzNK3zijhU3skxT0RU72Sd2kf7k07x89V
         3S6WdQPBB/DyHQULM5J5kkpZUVddaG8BATdDG2sjnPiVGqkN8orFqVEidHzYunpqd8zH
         D1LxDeAG3+FF1rzMCQNxtKpISPY+4qOeG4LdSLTR3nxqjA4JSxbfQoTWjqfNAEpo13wO
         UAoxDA/1dE2nLixYEl07XtUghHn3NqtsKaRVDt/21ucHuTMJgiReJcV0PuOAxLKZCEyQ
         PH+l8xSl8nzKJpEZhLzZo/j48iXCYeem03BuRHfrGZvJ6XrNIqJshVGSeZXl2ZbFN8MD
         1bAw==
X-Gm-Message-State: APjAAAWNnJzbkl/p5+C9fPH9cJVqy6Z/W1N8usLlE829UvBk/PicKT1a
        n9dXK8mmxzSGe93MNzDYSZExV6FMAhKbJfhbMDc=
X-Google-Smtp-Source: APXvYqwva6jxTWrsbaZTM+0PHLtCRMZYnperZ7dvZWR+J3DtJpfpIXyVZSGrKHdbpXM2udIUmpOGI1m+Yji1NOGBTLQ=
X-Received: by 2002:a05:6e02:c0c:: with SMTP id d12mr2684667ile.185.1580361583756;
 Wed, 29 Jan 2020 21:19:43 -0800 (PST)
MIME-Version: 1.0
References: <CAMH2TCooGyxiZbhersOCFMHLpjSAqKFq2_XswXx3nt200L-qBQ@mail.gmail.com>
 <CABBYNZLW7qe8ie-FLYaka7wKTeKAmBQYf0DG0ZZqbOu2eEOxPA@mail.gmail.com> <CAOVXEJKb-BNz_Y2xFnEcsiGYgZMaTEYjqrspw1TgCdsFgYNESQ@mail.gmail.com>
In-Reply-To: <CAOVXEJKb-BNz_Y2xFnEcsiGYgZMaTEYjqrspw1TgCdsFgYNESQ@mail.gmail.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Thu, 30 Jan 2020 10:49:32 +0530
Message-ID: <CAOVXEJJR7YE5fFm1b2YrZ53pPz-=0soAHmeiKQBsYnV47orvgg@mail.gmail.com>
Subject: Re: L2CAP mtu preference set by user space clarification
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     chethan tn <chethantn@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Sathish Narasimman <sathish.narasimman@intel.com>,
        Sathish N <nsathish41@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Requesting your feedback/suggestion to the below case.

On Tue, Jan 28, 2020 at 12:31 PM Sathish Narasimman
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
>
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
