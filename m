Return-Path: <cyrus@holtmann.org>
Subject: RE: Modem emulator and DUN server side for oFono and BlueZ
From: suraj <suraj@atheros.com>
To: "Zhang, Zhenhua" <zhenhua.zhang@intel.com>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"ofono@ofono.org" <ofono@ofono.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <33AB447FBD802F4E932063B962385B351F6F2256@shsmsx501.ccr.corp.intel.com>
References: <33AB447FBD802F4E932063B962385B351D9FE1FA@shsmsx501.ccr.corp.intel.com>
	 <20100430080319.GA11712@vigoh>
	 <33AB447FBD802F4E932063B962385B351E6578C9@shsmsx501.ccr.corp.intel.com>
	 <1278405050.4538.5.camel@atheros013-desktop>
	 <33AB447FBD802F4E932063B962385B351F6F2256@shsmsx501.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 6 Jul 2010 15:07:37 +0530
Message-ID: <1278409057.4538.10.camel@atheros013-desktop>
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zhenhua,

On Tue, 2010-07-06 at 15:00 +0530, Zhang, Zhenhua wrote:
> Hi Suraj,
> 
> suraj wrote:
> > Hi Zhenhua,
> > 
> > 
> > On Wed, 2010-05-05 at 06:27 +0530, Zhang, Zhenhua wrote:
> >> Hi Padovan,
> >> 
> >> Gustavo F. Padovan wrote:
> >>> Hi Zhenhua,
> >>> 
> >>> * Zhang, Zhenhua <zhenhua.zhang@intel.com> [2010-04-27 15:53:54
> >>> +0800]: 
> >>> 
> >>>> Hi,
> >>>> 
> >>>> I am now working on modem emulator and one usage is for DUN
> >>> server role. Since Padovan is working on client role, it's
> >>> good to share my rough thinking for server side
> >>> implementation. Here are the simple steps I have:
> >>>> 
> >>>> 1. Create an oFono emulator atom in oFono. It's the emulator
> >>> manager that could create DUN, HFP AG or SPP type emulators.
> >>> It exposes dbus methods like CreateEmulator, DestroyEmulator,
> >>> GetProperty, etc.
> >>>> 
> >>>> 2. DUN agent server in BlueZ watch oFono and call
> >>> CreateEmulator and pass the file descriptor to oFono. This
> >>> server could further implement HFP AG and SPP connection.
> >>> 
> >>> 
> >>> Shouldn't the emulator register itself on the BlueZ agent server?
> >> 
> >> It's fine to register the emulator like HFP client. In this
> > way, we might able to share the agent with DUN server as well. Thanks.
> >> 
> >>> 
> >>> --
> >>> Gustavo F. Padovan
> >>> http://padovan.org
> >>> _______________________________________________
> >>> ofono mailing list
> >>> ofono@ofono.org
> >>> http://lists.ofono.org/listinfo/ofono
> >> 
> >> 
> >> 
> >> Regards,
> >> Zhenhua
> >> 
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe
> >> linux-bluetooth" in the body of a message to
> >> majordomo@vger.kernel.org 
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > Do you have DUNP server emulator implemented?
> > I was thinking about implementing the same. But would like to use your
> > implementation if you have already done it.
> > 
> > Regards
> > Suraj
> 
> Yes, I am working DUN server part now. (I assume 'DUNP' you mentioned is 'DUN', dialing up networking). I am trying to submit patches to upstream now. Hope it could be ready asap so you can try it if interested. Thanks.
> 
> Regards,
> Zhenhua
> 

Thank you. You are right, I meant DUN server.
I will use your patches when it is ready.

Regards
Suraj



