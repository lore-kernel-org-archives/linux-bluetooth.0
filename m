Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A8AC54FD0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 16:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81FF520857
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 16:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrOFDVU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgDWQn2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729407AbgDWQn1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 12:43:27 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A3FC09B041
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 09:43:27 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id z17so7201978oto.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8yLL8F6UvbO4kW3Dtum/gVvuBPJnA+pFdutrhLE1Ro=;
        b=rrOFDVU8psYnysgtkjKlLzc0lVDsMXl3M2OCYEZBz+obZP+uGUhm+4ZBLVpuX2E3IB
         9lzCBdHYJDW/1G0N0D3NXzAXyafAzpRPBcSo3pMZ4cwTwKFHIlRXUskzPVYjDvtet3RT
         7GGX3wa4MGBFIDn4TK24ZxXrV0wTkoEcJrjCU3Xk8UH8wcZuqbl/xNrbjVylmbSLvnEM
         eT22LGGAn6IUbeikL/3Rk+qxi/rkKOEcYxB1JDVQC2f1J8fENHMVvkfzwgg9zpMafUPs
         I89OjHxShOJl7Msnm3o5DZQgR4FBJBkmJKwjRPwDs8cRtS8o+DgIsSUIJh8/dW3Vb5by
         mKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8yLL8F6UvbO4kW3Dtum/gVvuBPJnA+pFdutrhLE1Ro=;
        b=Xdsgo7WOsJn0Bv3/Bjy40DqzAJL0FbaBc6EmHuyRZztjbJ/B88Q2Wav8ZAphatCQ+N
         g9uAEILBZjMspKBH7KchLVtAgYXbfXyFpt89xgrhj2ICDQcnAosnmFUBtra3SFXKR4wn
         cv09qmruyLkT/w3kCgF0wF3zAAK+4D36As3WvAxci45Fq4lIR/HQu1tAMo5NWdw29jI0
         Sc6+ebXAnlOl/bXdmk42BKKbX7jB48vHNC4kfTjcD1PD7xjOdmZv36wimRvAQhlK1Yl/
         FNQMExqHt5M/XUO12rjnJ/LxXV6YxBeK+NnRz2xlFtmyl6wp6apK9ZTSUvnuD6xrccE2
         K+Qg==
X-Gm-Message-State: AGi0PuZ3ain/WLsILsNdtkkP/eCkgoId9lNqG2cexNvsJ+5AoaKdB/qP
        qWIEpbAHLUoYSydgWgC7XBxxtfg02Eauybf5WAjAeppc
X-Google-Smtp-Source: APiQypKPnmCtgIWecyRQkZJ4HCeolGpWBAuxDtR8Te38lxa2YsQ5y1nW1oQ0/B+O6v5b5BX/rf33nIhVNSShooojjnE=
X-Received: by 2002:a9d:4699:: with SMTP id z25mr4222395ote.11.1587660206688;
 Thu, 23 Apr 2020 09:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <010201715012e482-bca51111-db3c-4101-9bd4-208b69a0ff03-000000@eu-west-1.amazonses.com>
 <01020171a3203016-7d1d5c39-46ee-4ba9-8ff3-a6928a329d2a-000000@eu-west-1.amazonses.com>
 <CABBYNZJ2tn6Riz7uouxD0qa1M-dT7GbtUSkD-dbn1nj1B372iQ@mail.gmail.com> <01020171a6b79a42-76ec69a9-7293-441a-911e-e48f8baf418b-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020171a6b79a42-76ec69a9-7293-441a-911e-e48f8baf418b-000000@eu-west-1.amazonses.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 23 Apr 2020 09:43:15 -0700
Message-ID: <CABBYNZLfkWSpJHw82jct05buyuPVC_0jb1ykncRQZEk35vkTyw@mail.gmail.com>
Subject: Re: Setup Synchronous Connection fails when switching Sony WH-H900N
 headset to HSP
To:     James Belchamber <james@belchamber.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi James,

On Thu, Apr 23, 2020 at 4:06 AM James Belchamber <james@belchamber.com> wrote:
>
> Only difference in the btmon output is the handle (256 instead of 67)
> - otherwise it all looks the same and it connects first time.
>
> What logs are useful? I have the Chromebook in developer mode and so I
> can capture whatever you want (hopefully!)

Then I think this is because PulseAudio is using HSP not HFP, the
headset might be expecting a call to exist, or something similar on
HSP, in order to accept the SCO connection so the state machine is not
ready, have a look if Chrome OS is sending any AT command before
trying to connect SCO, or just past the btmon logs in some
pastebing/gist.github.com so we can analyze what is going on.

> On Wed, 22 Apr 2020 at 23:32, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi James,
> >
> > On Wed, Apr 22, 2020 at 11:27 AM James Belchamber <james@belchamber.com> wrote:
> > >
> > > Just bumping this for visibility, still an issue with the latest kernel.
> > >
> > > Happy to test anything thrown my way.
> > >
> > > On Mon, 6 Apr 2020 at 16:19, James Belchamber <james@belchamber.com> wrote:
> > > >
> > > > When using my Sony WH-H900N headphones and switching from A2DP to
> > > > HSP/HFP the following error appears in journalctl:
> > > >
> > > > (  60.063|   0.000) D: [pulseaudio] module-bluez5-device.c: Acquiring
> > > > transport /org/bluez/hci0/dev_04_5D_4B_E9_C9_90/fd34
> > > > (  60.063|   0.000) I: [pulseaudio] backend-native.c: doing connect
> > > > (  60.174|   0.111) E: [pulseaudio] backend-native.c: connect():
> > > > Function not implemented
> > > >
> > > > And using btmon I can see the HCI command comes back with a failure
> > > > (full log attached):
> > > >
> > > > < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
> > > >         Handle: 67
> > > >         Transmit bandwidth: 8000
> > > >         Receive bandwidth: 8000
> > > >         Max latency: 10
> > > >         Setting: 0x0060
> > > >           Input Coding: Linear
> > > >           Input Data Format: 2's complement
> > > >           Input Sample Size: 16-bit
> > > >           # of bits padding at MSB: 0
> > > >           Air Coding Format: CVSD
> > > >         Retransmission effort: Optimize for power consumption (0x01)
> > > >         Packet type: 0x0380
> > > >           3-EV3 may not be used
> > > >           2-EV5 may not be used
> > > >           3-EV5 may not be used
> > > > > HCI Event: Command Status (0x0f) plen 4
> > > >       Setup Synchronous Connection (0x01|0x0028) ncmd 1
> > > >         Status: Success (0x00)
> > > > > HCI Event: Max Slots Change (0x1b) plen 3
> > > >         Handle: 67
> > > >         Max slots: 1
> > > > > HCI Event: Synchronous Connect Complete (0x2c) plen 17
> > > >         Status: Unspecified Error (0x1f)
> > > >         Handle: 67
> > > >         Address: 04:5D:4B:E9:C9:90 (Sony Corporation)
> > > >         Link type: eSCO (0x02)
> > > >         Transmission interval: 0x00
> > > >         Retransmission window: 0x00
> > > >         RX packet length: 0
> > > >         TX packet length: 0
> > > >         Air mode: u-law log (0x00)
> > > >
> > > > This works on ChromeOS, which also uses a (modified) BlueZ stack -
> > > > though I can't work out why :)
> >
> > It doesn't look like it is a host problem and Ive never seem this
> > error before, have you tried with the same controller on Chrome OS? It
> > may be worth trying to capture the logs in Chrome OS so we can compare
> > if there is something different in the command parameters, but it
> > could as well be that Chrome uses HFP instead of HSP as PulseAudio
> > does and the headset is sensitive to that.
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
