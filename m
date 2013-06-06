Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Jun 2013 16:59:59 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC v0 4/5] adapter: add RequestDiscoverable() and
 ReleaseDiscoverable()
Message-ID: <20130606155959.GA9652@joana>
References: <1370528339-7921-1-git-send-email-gustavo@padovan.org>
 <1370528339-7921-4-git-send-email-gustavo@padovan.org>
 <CABBYNZLxeRNBL4KBjs624pVSvDv76pbV4u+Y8K6VuNnHD8ApVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZLxeRNBL4KBjs624pVSvDv76pbV4u+Y8K6VuNnHD8ApVg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2013-06-06 22:50:32 +0700]:

> Hi Gustavo,
> 
> On Thu, Jun 6, 2013 at 9:18 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
> > From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> >
> > With those two methods BlueZ is now aware of client lifetime and can set
> > Discoverable back to False if all clients exit or call
> > ReleaseDiscoverable()
> > ---
> 
> This probably should be handled int the component controlling the
> powered state like we used to have with RequestSession or we can have
> an agent to the power/policy manager asking if it is ok to power on
> the adapter.

Not sure if it makes sense to put this in the component that handles power
state (you mean ConnMan here, for example?). How an agent for this can help
us. The problem I'm trying to solve here is, do not let the Discoverable True
for infinite time if the who is using crashes.

	Gustavo
