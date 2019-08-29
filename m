Return-Path: <SRS0=q5Cw=WZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED05C3A59F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 13:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDEB2189D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 13:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfH2NGR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:06:17 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:50002 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfH2NGP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Aug 2019 09:06:15 -0400
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2019 09:06:12 EDT
Received: from ydin.reaktio.net (reaktio.net [85.76.255.15])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id E9045B001C;
        Thu, 29 Aug 2019 15:57:34 +0300 (EEST)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
        id E622D36C0F6; Thu, 29 Aug 2019 15:57:34 +0300 (EEST)
Date:   Thu, 29 Aug 2019 15:57:34 +0300
From:   Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
Message-ID: <20190829125734.GH2840@reaktio.net>
References: <20190712151329.11333-1-luiz.dentz@gmail.com>
 <CABBYNZLDFAJgkfAFWOOAAqqiX8mpi3KgirBkpwpnBFJ3TxPqyg@mail.gmail.com>
 <20190718100024.ii2igadxb2lmmitm@pali>
 <20190721155522.3vqt7vsprhpxflqf@pali>
 <CABBYNZK6cuz9n4Hu9uRCbQvn9uFEYkn9=mY8J5Fqu0u-D3B1EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZK6cuz9n4Hu9uRCbQvn9uFEYkn9=mY8J5Fqu0u-D3B1EA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Sat, Aug 10, 2019 at 09:54:52AM +0300, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Sun, Jul 21, 2019 at 6:55 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> >
> > On Thursday 18 July 2019 12:00:24 Pali Rohár wrote:
> > > On Saturday 13 July 2019 17:52:46 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > >
> > > > On Fri, Jul 12, 2019 at 6:13 PM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > >
> > > > > This uses application ObjectManager to discover the MediaEndpoint and
> > > > > MediaPlayer object of an application and deprecates the use of
> > > > > RegisterEndpoint and RegisterPlayer.
> > > > > ---
> > > > >  doc/media-api.txt | 20 ++++++++++++++++++++
> > > > >  1 file changed, 20 insertions(+)
> > > > >
> > > > > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > > > > index bca8c9563..07f7ac3e0 100644
> > > > > --- a/doc/media-api.txt
> > > > > +++ b/doc/media-api.txt
> > > > > @@ -66,7 +66,27 @@ Methods              void RegisterEndpoint(object endpoint, dict properties)
> > > > >
> > > > >                         Unregister sender media player.
> > > > >
> > > > > +               void RegisterApplication(object root, dict options)
> > > > >
> > > > > +                       Register endpoints an player objects within root
> > > > > +                       object which must implement ObjectManager.
> > > > > +
> > > > > +                       The application object path together with the D-Bus
> > > > > +                       system bus connection ID define the identification of
> > > > > +                       the application.
> > > > > +
> > > > > +                       Possible errors: org.bluez.Error.InvalidArguments
> > > > > +                                        org.bluez.Error.AlreadyExists
> > > > > +
> > > > > +               void UnregisterApplication(object application)
> > > > > +
> > > > > +                       This unregisters the services that has been
> > > > > +                       previously registered. The object path parameter
> > > > > +                       must match the same value that has been used
> > > > > +                       on registration.
> > > > > +
> > > > > +                       Possible errors: org.bluez.Error.InvalidArguments
> > > > > +                                        org.bluez.Error.DoesNotExist
> > > > >  Media Control hierarchy
> > > > >  =======================
> > > > >
> > > > > --
> > > > > 2.21.0
> > > >
> > > > Can you try this set?
> > >
> > > Hello, I will try it later in next week. To test it would mean to
> > > rewrite pulseaudio bluetooth modules to use this new API, so it would
> > > take me longer time.
> >
> > Hi! I looked at it. But I do not know how to implement
> > GetManagedObjects() method via libdbus properly. Any idea?
> 
> I went ahead and applied this set, you can find some examples of how
> to implement ObjectManager interface in gdbus but I guess what you
> really need to do is make PA aware of the objects being exposed since
> it does make it simpler to to enumerate objects by the clients.
> 

Pali: How does it look with porting the PA patches to use the new interfaces?


Thanks,

-- Pasi

