Return-Path: <cyrus@holtmann.org>
Message-ID: <1337133263.5970.256.camel@aeonflux>
Subject: Re: [PATCH 2/4] monitor: add device filter support
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 15 May 2012 18:54:23 -0700
In-Reply-To: <20120515231404.GB1414@joana>
References: <1336753132-8282-1-git-send-email-gustavo@padovan.org>
	 <1336753132-8282-2-git-send-email-gustavo@padovan.org>
	 <1336964326.5970.238.camel@aeonflux> <20120515231404.GB1414@joana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > > -i hciX option will show only data from the specified device
> > > ---
> > >  monitor/main.c   |   12 ++++++++++--
> > >  monitor/packet.c |   10 +++++++++-
> > >  monitor/packet.h |    2 +-
> > >  3 files changed, 20 insertions(+), 4 deletions(-)
> > 
> > so what is this option actually good for? I think it is the wrong
> > approach for dealing with this.
> 
> I only want to see the output for one device. We one my test use case is two
> devices in the machine communicating with each other.

so btmon is designed to really get everything at once. Including
adapters coming and going. More important it can tell if at one point an
adapter was hci0 and next time it becomes hci1.

Keep in mind that btmon is suppose to be run even with no adapters
attached. So you can start it before doing anything. Filtering on index
numbers becomes kinda funky then since you do not yet know the index of
an adapter. You are just wildly guessing.

> > We better have some generic filtering mechanism, then trying to just
> > duplicate options from hcidump into btmon.
> > 
> > btmon is different in the fact that it is actually able to record all
> > packets from all devices. You also do not wanna filter based on index
> > number. You wanna filter based on BD_ADDR and BR/EDR vs AMP.
> 
> Filter based on BD_ADDR would work too, but is more painful to the user
> however.

I actually think having some sort of -f <filter> file where you can
store BD_ADDR and potentially other filter options makes way more sense.

Keep in mind that even for BD_ADDR filtering, you need to first inspect
a few HCI packets on a newly added controller. Since a new controller
has no BD_ADDR until Read_BD_Addr command has successfully. Only already
added controllers have the BD_ADDR read.

Regards

Marcel


