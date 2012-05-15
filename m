Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 May 2012 20:14:04 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] monitor: add device filter support
Message-ID: <20120515231404.GB1414@joana>
References: <1336753132-8282-1-git-send-email-gustavo@padovan.org>
 <1336753132-8282-2-git-send-email-gustavo@padovan.org>
 <1336964326.5970.238.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336964326.5970.238.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2012-05-13 19:58:46 -0700]:

> Hi Gustavo,
> 
> > -i hciX option will show only data from the specified device
> > ---
> >  monitor/main.c   |   12 ++++++++++--
> >  monitor/packet.c |   10 +++++++++-
> >  monitor/packet.h |    2 +-
> >  3 files changed, 20 insertions(+), 4 deletions(-)
> 
> so what is this option actually good for? I think it is the wrong
> approach for dealing with this.

I only want to see the output for one device. We one my test use case is two
devices in the machine communicating with each other.

> 
> We better have some generic filtering mechanism, then trying to just
> duplicate options from hcidump into btmon.
> 
> btmon is different in the fact that it is actually able to record all
> packets from all devices. You also do not wanna filter based on index
> number. You wanna filter based on BD_ADDR and BR/EDR vs AMP.

Filter based on BD_ADDR would work too, but is more painful to the user
however.

	Gustavo
