Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Szymon Janc' <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, d.kasatkin@samsung.com,
	bharat.panda@samsung.com, cpgs@samsung.com
References: <1418129488-12353-1-git-send-email-gowtham.ab@samsung.com>
 <157571858.6JfrHtjm1y@leonov> <000a01d013b6$a4fd1750$eef745f0$@samsung.com>
 <8443413.JxGkLjFy8i@leonov>
In-reply-to: <8443413.JxGkLjFy8i@leonov>
Subject: RE: [PATCH ] android/socket: Add PBAP supported features bits
Date: Wed, 10 Dec 2014 14:21:51 +0530
Message-id: <000c01d01456$91972890$b4c579b0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Szymon Janc
> Sent: Wednesday, December 10, 2014 2:15 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; d.kasatkin@samsung.com;
> bharat.panda@samsung.com; cpgs@samsung.com
> Subject: Re: [PATCH ] android/socket: Add PBAP supported features bits
> 
> Hi Gowtham,
> 
> On Tuesday 09 of December 2014 19:16:58 Gowtham Anandha Babu wrote:
> > Hi Szymon,
> >
> > > -----Original Message-----
> > > From: Szymon Janc [mailto:szymon.janc@tieto.com]
> > > Sent: Tuesday, December 09, 2014 6:54 PM
> > > To: Gowtham Anandha Babu
> > > Cc: linux-bluetooth@vger.kernel.org; d.kasatkin@samsung.com;
> > > bharat.panda@samsung.com; cpgs@samsung.com
> > > Subject: Re: [PATCH ] android/socket: Add PBAP supported features
> > > bits
> > >
> > > Hi Gowtham,
> > >
> > > On Tuesday 09 of December 2014 18:21:27 Gowtham Anandha Babu
> wrote:
> > > > Add PBAP supported features in sdp record.
> > >
> > > Isn't that a 1.2 feature? (AOSP supports only 1.1).
> >
> > Yes, this one is 1.2 feature. Then, I have to wait till 1.2 release.
> > Btw, Right now in android,
> > Server (PBAP-PSE and MAP-MAS) records are getting added.
> > What happened to client(PBAP-PCE and MAP-MNS) records?
> > Will it be added only after implementing them?
> > Am I right?
> 
> I'm not sure if we really need PBAP client SDP record. Since there is no
> listening socket we wouldn't know when/if we should add it.
> 
> For MAP-MNS, that depends on what application implementing MAP client
> would support. Since AOSP doesn't provide such application and HAL and
> java API indicates no support for it I'd leave it until this gets
clarified.
> 

I am new to Android and exploring it, anyway thanks for your information.

> --
> BR
> Szymon Janc
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html


Regards,
Gowtham Anandha Babu

