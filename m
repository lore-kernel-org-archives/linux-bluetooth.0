Return-Path: <SRS0=+lf3=PF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391B3C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 19:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078EA20869
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 19:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbeL1TQ0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:16:26 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:51314 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbeL1TQ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Dec 2018 14:16:26 -0500
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Dec 2018 14:16:26 EST
Received: from ydin.reaktio.net (reaktio.net [85.76.255.15])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 393A7200AC;
        Fri, 28 Dec 2018 21:11:03 +0200 (EET)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
        id 2823436C0F6; Fri, 28 Dec 2018 21:11:03 +0200 (EET)
Date:   Fri, 28 Dec 2018 21:11:02 +0200
From:   Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez: dbus method call for switching endpoint
Message-ID: <20181228191102.GA31975@reaktio.net>
References: <20180711082352.oo6srapfnol5nkxq@pali>
 <CABBYNZJuGT5_zhg-BkAc4XjtVu5His92cHTujrin=SMOVbaodQ@mail.gmail.com>
 <20180711144501.ovdxc2expa4bg6sc@pali>
 <20181215202910.j24amjshrvjqprll@pali>
 <CABBYNZLK4tyL8nvWbXxr6VctyEyJkMdwNiWMy4gUge9h9Vb4SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLK4tyL8nvWbXxr6VctyEyJkMdwNiWMy4gUge9h9Vb4SQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, Dec 18, 2018 at 01:02:39PM -0300, Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Sat, Dec 15, 2018 at 5:29 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> >
> > On Wednesday 11 July 2018 16:45:01 Pali Rohár wrote:
> > > On Wednesday 11 July 2018 16:27:07 Luiz Augusto von Dentz wrote:
> > > > One way to solve all of these is that we would expose the remote
> > > > endpoints using MediaEndpoint1
> > >
> > > So client application (like pulseadio) would see list of remote
> > > endpoints (one for each codec) and choose one for connection?
> > >
> > > Looks like this should solve this problem.
> >
> > Are there any progress on such API in bluez?
> >
> > On pulseaudio mailing list other people proposed patches for other A2DP
> > codecs and basically bluez API for choosing A2DP codec is still missing
> > part...
> 
> Im currenlty on vacation but will try to find time for that, that said
> that shouldn't stop us to include support for other codecs, the last
> set seems to have some sort of priority for ordering the registration
> of the codecs.
> 

Let us know when you have something to see/try!
I'm happy to do testing of the patches. 

People are currently eager to get support for multiple BT audio codecs working and merged upstream :)


Thanks,

-- Pasi

