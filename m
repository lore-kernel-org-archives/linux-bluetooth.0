Return-Path: <SRS0=4il6=YE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1285C47404
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 17:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2201206A1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 17:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUhDK6jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfJKRtI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Oct 2019 13:49:08 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:37496 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfJKRtH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Oct 2019 13:49:07 -0400
Received: by mail-wr1-f47.google.com with SMTP id p14so12855405wro.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2019 10:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3cZShGbUhCfOR65S4+0WFqH2mZNUGXJ14IJmNJQ15Ug=;
        b=eUhDK6jrGDWy8EHVB6Ipjl6BPb8YhP6ScA2bpEOqg4Tw8WCTxREf6eNetkVVwgFm+x
         9nQnBN5oH3hrv7FRC+mAOf+QIXVj8qUQxFYEQnfopNtQCB0R6GZ9Q8vmpz/L7QXbEQpU
         A4ij+4uv7JzJFg8U7Y+aTfc9qm7jSlnUZlhEm3ihMcMT9iOnEYwIdD3wAfD/ELeU9YdZ
         LwBOX46o6RBKWZEp8zkiqlI01LVYeUUQZQHfciIHGqefo7kC/xFZFppSKkZVaoQ7EYJd
         Cx7uhFsBGsbEWkilnZ8LnOLSA3WkjZ7BNGz9NhMxvWnPeC333zf+JJOxWGugHybjBirc
         7nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3cZShGbUhCfOR65S4+0WFqH2mZNUGXJ14IJmNJQ15Ug=;
        b=ikCAYG8Ez82vXxkQqz8GQRI6d2w47lN+c88yWZZ5p4J0WW1NzZ6pf8RsBbuK/1elHt
         G+28Bgm5+rM5LDFXtYLLG8YW0utQ+9QDF8DTicG2/G6K2z/u3HE1OceR1G03fJ9JKGKd
         XlwzATOeSVQ+Oukki5CS+E5oMeW3gQS1H0bqnP7qesaRkjqG+wDqIOBHcQX4U34MUuQo
         IY4xQWcVJpZM6SSH+KtYU/eXrioBo250r0CNf3+1TDcI3Qcxz4STl9smw6Yo0IJcasRc
         k7WVYCTG3MWW0yLLvg0T/RuKld/gheJGhQOXGjWGRR0Nqh0arUJS6HbWEvdwRk39fiQb
         iGiA==
X-Gm-Message-State: APjAAAVHuZ2z/8Jw6ejK1wRtOSViKF14EsuGuWBmIOLObgV+do9/tUIH
        kf3xkwsk7MqFehlJyDrmir9g0HZmqT0ixLBd0s6OV++m
X-Google-Smtp-Source: APXvYqxEm+hQzvaJVwDCGjErzcXksNIy35sk9j8v2jsUbUgeFzqXLxSoPkDlkYW/LQfC4szSFUKVmje35uP6f0RNQHU=
X-Received: by 2002:adf:9bc7:: with SMTP id e7mr15151490wrc.203.1570816144948;
 Fri, 11 Oct 2019 10:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ0=ZJ2rjxM0WmA72J5VCcUZ01q7dH+jxJi7btGzayZWHe7S1Q@mail.gmail.com>
 <CABBYNZ+DYrzhx3Riqt2SFV4ZoL5VHfOnVPH0ScHMRz=+XoBg6Q@mail.gmail.com>
 <CAJ0=ZJ1pD4dHZe98eZnZ6R-ZBazGip_mrPVV_XjFgThXM0Ebmg@mail.gmail.com>
 <CABBYNZLZFpq_aKpmWFG3mG9oEP7Ly4=5WbJHK3mqGsQgH8Da2g@mail.gmail.com>
 <CABBYNZ+GhHtnDi-FCu0N2xoEc_0eTtPMsW+N+GMM6S7buy1-Xw@mail.gmail.com>
 <CAJ0=ZJ17vp_N-P2df6xzVON5yTr0U1v5jk7LTYfrgCpcu6kfBg@mail.gmail.com> <CABBYNZ+3hobO1HkoKru0Z_NXgyPz-6BDqpWr6vEDktAOku8qVA@mail.gmail.com>
In-Reply-To: <CABBYNZ+3hobO1HkoKru0Z_NXgyPz-6BDqpWr6vEDktAOku8qVA@mail.gmail.com>
From:   yayfortrees <yayfortrees@gmail.com>
Date:   Fri, 11 Oct 2019 11:48:54 -0600
Message-ID: <CAJ0=ZJ0XsqEUuD=Std8676EtgspOZ8yD9TiFUM4gQRAui_WeCw@mail.gmail.com>
Subject: Re: Bluez stopped connecting A2DP sink
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

The patch works, I get the a2dp sink consistently through re-connects now.

I am still seeing the a2dp-sink profile error in the logs, but other
than that everything seems to be fine.

bluetoothd[16493]: src/device.c:device_profile_connected() Headset
Voice gateway Success (0)
bluetoothd[16493]: plugins/policy.c:policy_connect()
/org/bluez/hci0/dev_34_DF_2A_0D_F8_C2 profile a2dp-sink
bluetoothd[16493]: profiles/audio/a2dp.c:a2dp_sink_connect() path
/org/bluez/hci0/dev_34_DF_2A_0D_F8_C2
bluetoothd[16493]: a2dp-sink profile connect failed for
34:DF:2A:0D:F8:C2: Device or resource busy
bluetoothd[16493]: plugins/policy.c:service_cb() Added Headset Voice
gateway reconnect 0

Thanks!

On Fri, Oct 11, 2019 at 6:59 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Thu, Oct 10, 2019 at 11:13 PM yayfortrees <yayfortrees@gmail.com> wrote:
> >
> > Hello,
> >
> > I've attached debug logs for 5.50 nopatch and 5.50 with the patch.
> >
> > To me it looked like it may be a timing issue - trying to connect the
> > a2dp sink too early. As an experiment I put a sleep(1) at the top of
> > the hs_cb function from your patch and the a2dp sink was connected.
> > With the sleep I still get the "Device or resource busy" error early
> > on, but it does reconnect the a2dp sink later in the connection and
> > things work. It's not consistent though, maybe 1 of 5 attempts would
> > fail to connect the a2dp profile.
>
> Try with the following patch.
>
> > I included that debug log as well.
> >
> > Hope this helps, thanks!
> >
> > On Thu, Oct 10, 2019 at 2:10 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Oct 9, 2019 at 10:51 AM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Wed, Oct 9, 2019 at 1:56 AM yayfortrees <yayfortrees@gmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > I've attached btmon traces for 5.50 and 5.51. Thanks for taking a look!
> > > > >
> > > > > Let me know if you need anything else.
> > > >
> > > > Must likely the following error has something to do with it:
> > > >
> > > > = bluetoothd: a2dp-sink profile connect failed for 34:DF:2A:0D:F8:C2:
> > > > Device or resource busy
> > > >
> > > > I will check why this could be happening.
> > >
> > > I tried this one and couldn't reproduce with the headsets I have,
> > > could you please run bluetooth -dn and attach the logs here?
> > >
> > > > > On Tue, Oct 8, 2019 at 4:24 AM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Mon, Oct 7, 2019 at 10:34 PM yayfortrees <yayfortrees@gmail.com> wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > I recently upgraded bluez to 5.51 from 5.50 and my headphones stopped
> > > > > > > using the A2DP sink during autoconnect. The headphones instead go to
> > > > > > > HSP/HFP mode and the A2DP sink is disabled in pavucontrol/pactl. The
> > > > > > > A2DP sink will only work when the device is initially paired.
> > > > > > >
> > > > > > > This had worked flawlessly for years. I was able to track down the
> > > > > > > regression to this patch:
> > > > > > > https://www.spinics.net/lists/linux-bluetooth/msg76180.html ([PATCH
> > > > > > > BlueZ] policy: Add logic to connect a Sink). If I apply the patch to
> > > > > > > 5.50, my headphones no longer connect to the A2DP sink, if I remove it
> > > > > > > the problem goes away.
> > > > > > >
> > > > > > > Not sure what else I should include to help track this down. The
> > > > > > > headphones I'm using are Beats Wireless (Solo Bluetooth).
> > > > > > >
> > > > > > > The only relevant log entry I see with the patch applied is:
> > > > > > > a2dp-sink profile connect failed for 34:DF:2A:0D:F8:C2: Device or resource busy
> > > > > >
> > > > > > Can you collect the HCI traces of the problem using btmon? I didn't
> > > > > > expect that to cause any problems, it should in theory solve them but
> > > > > > lets see.
> > > > > >
> > > > > > > Let me know if any other information is needed.
> > > > > > > Thanks.
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Luiz Augusto von Dentz
> > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
