Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, d.kasatkin@samsung.com,
	bharat.panda@samsung.com, cpgs@samsung.com
Subject: Re: [PATCH ] android/socket: Add PBAP supported features bits
Date: Wed, 10 Dec 2014 09:44:38 +0100
Message-ID: <8443413.JxGkLjFy8i@leonov>
In-Reply-To: <000a01d013b6$a4fd1750$eef745f0$@samsung.com>
References: <1418129488-12353-1-git-send-email-gowtham.ab@samsung.com> <157571858.6JfrHtjm1y@leonov> <000a01d013b6$a4fd1750$eef745f0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Tuesday 09 of December 2014 19:16:58 Gowtham Anandha Babu wrote:
> Hi Szymon,
> 
> > -----Original Message-----
> > From: Szymon Janc [mailto:szymon.janc@tieto.com]
> > Sent: Tuesday, December 09, 2014 6:54 PM
> > To: Gowtham Anandha Babu
> > Cc: linux-bluetooth@vger.kernel.org; d.kasatkin@samsung.com;
> > bharat.panda@samsung.com; cpgs@samsung.com
> > Subject: Re: [PATCH ] android/socket: Add PBAP supported features bits
> > 
> > Hi Gowtham,
> > 
> > On Tuesday 09 of December 2014 18:21:27 Gowtham Anandha Babu wrote:
> > > Add PBAP supported features in sdp record.
> > 
> > Isn't that a 1.2 feature? (AOSP supports only 1.1).
> 
> Yes, this one is 1.2 feature. Then, I have to wait till 1.2 release.
> Btw, Right now in android,
> Server (PBAP-PSE and MAP-MAS) records are getting added.
> What happened to client(PBAP-PCE and MAP-MNS) records?
> Will it be added only after implementing them?
> Am I right?

I'm not sure if we really need PBAP client SDP record. Since there is no 
listening socket we wouldn't know when/if we should add it.

For MAP-MNS, that depends on what application implementing MAP client would 
support. Since AOSP doesn't provide such application and HAL and java API 
indicates no support for it I'd leave it until this gets clarified.

-- 
BR
Szymon Janc
