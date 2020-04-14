Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA59C2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 23:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A672076C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 23:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586905222;
	bh=uiUJzrzgdt5YHngiROPE2ZTJnSefzm2oy99nLegeYOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SMijHnMM8UG5fERsPYqjjOdot3Oc/PibIyQ4SEd4+XtK+C6PuScAO6trXGxguYJYJ
	 xhsF7a+tbP0yBS86D01YvcsMzseiPajlwB1AnLGwotuF+vOSJKqYunvuhuCGbIb41n
	 UCuhdE1LcqsIgCQ7YT1sL7mry0Mc/jap1WvGa78I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634334AbgDNXAV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Apr 2020 19:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634321AbgDNXAS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Apr 2020 19:00:18 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79DA12051A;
        Tue, 14 Apr 2020 23:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586905217;
        bh=uiUJzrzgdt5YHngiROPE2ZTJnSefzm2oy99nLegeYOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LyL8FOq33Wz/g73qjt5s/81XskYFCZ0PVMCqH1us0xRtla6gSiVFH9z8YFxQ0qfB4
         xvJf++tzwPETzd/wnAm9dfIMTvYUrKMvARSExjsugD73H1R7TiGRIVeB16NIwh9r4/
         E++f4mMtct1guCHiNJwOm8dgxpnzz893f0GNoPRQ=
Received: by pali.im (Postfix)
        id 7EB267DE; Wed, 15 Apr 2020 01:00:15 +0200 (CEST)
Date:   Wed, 15 Apr 2020 01:00:15 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] tools/hcidump: Decode FastStream, aptX Low Latency, aptX
 HD and LDAC
Message-ID: <20200414230015.5ndqz5k5kx5vakj4@pali>
References: <20190130120631.usx67zjk4kmbhcla@pali>
 <CABBYNZJ5z_-8KiotL=9fkvq-gLPoqU1LJpaOBv1z4QfZiA3zaA@mail.gmail.com>
 <20190201124353.GK32745@reaktio.net>
 <20190206114300.rxw3ptq7hzathzqe@pali>
 <20190224131907.GV32745@reaktio.net>
 <20190305122630.gwnaz3y7ckzqfjfq@pali>
 <20190410082924.exo2oihzd7w2oz3e@pali>
 <20190607130739.j25oqqj624anmcqr@pali>
 <20191014110746.n3pmoigtf3ewbmrq@pali>
 <20200209130532.4evozfyutikzwn4a@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200209130532.4evozfyutikzwn4a@pali>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sunday 09 February 2020 14:05:32 Pali Rohár wrote:
> On Monday 14 October 2019 13:07:46 Pali Rohár wrote:
> > On Friday 07 June 2019 15:07:39 Pali Rohár wrote:
> > > On Wednesday 10 April 2019 10:29:24 Pali Rohár wrote:
> > > > On Tuesday 05 March 2019 13:26:30 Pali Rohár wrote:
> > > > > On Sunday 24 February 2019 15:19:07 Pasi Kärkkäinen wrote:
> > > > > > On Wed, Feb 06, 2019 at 12:43:00PM +0100, Pali Rohár wrote:
> > > > > > > On Friday 01 February 2019 14:43:53 Pasi Kärkkäinen wrote:
> > > > > > > > Hi,
> > > > > > > > 
> > > > > > > > On Wed, Jan 30, 2019 at 02:24:11PM +0200, Luiz Augusto von Dentz wrote:
> > > > > > > > > Hi Pali, Pasi,
> > > > > > > > > On Wed, Jan 30, 2019 at 2:09 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wednesday 30 January 2019 10:15:17 Pasi Kärkkäinen wrote:
> > > > > > > > > > > On Wed, Jan 23, 2019 at 06:54:48PM +0100, Pali Rohár wrote:
> > > > > > > > > > > > On Wednesday 23 January 2019 18:46:18 Marcel Holtmann wrote:
> > > > > > > > > > > > > Hi Pali,
> > > > > > > > > > > > >
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > tools/parser/avdtp.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > > > > > > > > > > > > > 1 file changed, 55 insertions(+), 3 deletions(-)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
> > > > > > > > > > > > > > index 18569c895..a21410f5a 100644
> > > > > > > > > > > > > > --- a/tools/parser/avdtp.c
> > > > > > > > > > > > > > +++ b/tools/parser/avdtp.c
> > > > > > > > > > > > > > @@ -155,6 +155,12 @@ static char *vndcodec2str(uint32_t vendor, uint16_t vndcodec)
> > > > > > > > > > > > > > {
> > > > > > > > > > > > > >         if (vendor == 0x0000004f && vndcodec == 0x0001)
> > > > > > > > > > > > > >                 return "aptX";
> > > > > > > > > > > > > > +       else if (vendor == 0x0000000a && vndcodec == 0x0001)
> > > > > > > > > > > > > > +               return "FastStream";
> > > > > > > > > > > > > > +       else if (vendor == 0x0000000a && vndcodec == 0x0002)
> > > > > > > > > > > > > > +               return "aptX Low Latency";
> > > > > > > > > > > > > > +       else if (vendor == 0x000000d7 && vndcodec == 0x0024)
> > > > > > > > > > > > > > +               return "aptX HD";
> > > > > > > > > > > > > >         else if (vendor == 0x0000012d && vndcodec == 0x00aa)
> > > > > > > > > > > > > >                 return "LDAC";
> > > > > > > > > > > > > >         return "Unknown???;
> > > > > > > > > > > > >
> > > > > > > > > > > > > lets keep the focus on btmon support since nobody should be using hcidump anymore.
> > > > > > > > > > > >
> > > > > > > > > > > > In btmon I already implemented it and patches are now merged. I just
> > > > > > > > > > > > found another place where this capability parsing is implemented and
> > > > > > > > > > > > based on fact that users still use hcidump I quickly looked at it and
> > > > > > > > > > > > implemented this parsing.
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > I agree, hcidump still comes up on many places (guides, blogs, mailinglist posts, etc),
> > > > > > > > > > > so it makes sense to add these patches to hcidump aswell. Especially when the patch is quite small.
> > > > > > > > > >
> > > > > > > > > > Exactly, people still use hcidump...
> > > > > > > > > 
> > > > > > > > > Well it is a deprecated tool which we might remove starting on BlueZ
> > > > > > > > > 6.x which we would like to do in the very next release, if that
> > > > > > > > > doesn't happen than perhaps Id take these patches in for a very last
> > > > > > > > > BlueZ 5.x release.
> > > > > > > > > 
> > > > > > > > > @Marcel: Or you have a better plan? We could do one last 5.x and then
> > > > > > > > > start working on removing the deprecated tools/etc.
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > +1 for doing one last 5.x release before deprecating and removing tools etc!
> > > > > > > 
> > > > > > > Ok, what is the plan? If hcidump is not going to be deleted in upcoming
> > > > > > > release, can you take this patch?
> > > > > > >
> > > > > > 
> > > > > > How about applying this patch now, considering it's small, and has value for anyone using hcidump.
> > > > > > hcidump then gets removed later whenever the removal of deprecated features/tools starts.
> > > > > 
> > > > > So... what are plans for next release?
> > > > 
> > > > Marcel, Luiz, can you comment next steps? It is waiting there for your
> > > > info here for more than 2 months.
> > > 
> > > PING!
> > 
> > Just a gentle reminder for this thread and patch.
> > 
> 
> Ping, another reminder.

Ping, could you please give us information what is the state of this
tool and a linked patch?
