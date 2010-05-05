Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Elvis =?iso-8859-1?q?Pf=FCtzenreuter?= <epx@signove.com>
Subject: Re: [PATCH] Health Device Profile API
Date: Wed, 5 May 2010 13:14:41 +0200
Cc: "Santiago Carot-Nemesio" <scarot@libresoft.es>,
	linux-bluetooth@vger.kernel.org
References: <1272928958-8073-1-git-send-email-epx@signove.com> <1272959405.2182.117.camel@mosquito> <F76BD3E9-A0AF-434E-AE1A-17E7ED692113@signove.com>
In-Reply-To: <F76BD3E9-A0AF-434E-AE1A-17E7ED692113@signove.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005051314.42005.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

El Wednesday 05 May 2010 02:19:37 Elvis Pfützenreuter escribió:
> > 
> > We have provided an abstraction based in HDP sessions becasue there may
> > exist different HDP sessions running in the same host. Your API doesn't
> > seem to take in count that possibility.
> 
> Note that our adapter.RegisterRole() is bound to a client process. You can have any number of processes, each one calling adapter.RegisterRole() and publishing its own HDP profile. When a process exits, the respective profile is killed.

This is a good idea.  Sessions live while the process that creates them 
is conencted to the bus. We have included in the 0.2 version of the api
that we just sent. Please, feel free to comment.

> 
> Our adapter.RegisterRole() has two limitations that you noted.
> 
> First: only one HDP profile per client application. We feel that this is not bad.
> 
> Second: we don't provide an option NOT to publish an HDP profile. This may be a bug indeed (sinks are not required to publish HDP records, as you kindly noted yesterday via IRC;i in our API we intended to force every every HDP service provider to publish a SDP record.

We proposed a mixed API with dictionaries that in just one petition is completly configured
(you were rigth, our API could be a little bit complicated in this aspect) but that allows 
sessions without a SDP register.

> 
> > Above callbacks reflect same ideas that we have, but we propose a
> > session oriented agent (we call HdpAgent in the e-mail) that
> > applications should provide when they connect to a HdpSession. Once
> > applications are connected to a session, HDP will notify them using that
> > d-bus object.
> 
> As said above, there is an (implicit) session per client.

We are not sure if this could be a limitation in the future, may be
good to talk about this before fixing an API. There could be process thad 
needs more than one session. (i.e., a manager than wants to be perceived
by the agents as different sessions). Please, note that HDP specification
does not limit the number of session per peer nor process, so we shouldn't
close the API to this possibility so can limit the application's functionality
using HDP in Linux.

> 
> > You can't rely in remote HDP record for Source devices (it is not
> > mandatory for them to registry it).  we dont understand why you need to
> > provide a local mdep for the connection of the data channel, only the
> > remote mdep is required for do that.
> 
> Point.
> 
> > Reconnections may be transparent for applications, we believe that HDP
> > knows when a data channels is re-connected. (see our API for more
> > details)
> 
> See other email about FD, reconnection semantics. I feel we must either expose both reconnections and FDs for the application, or neither one.
> 
> >> +		array{MDLs}: array of open data channels. Mandatory
> >> +			MDLs attributes are:
> >> +			uint16 MDLId: Data channel identification
> >> +			string path: HealthData object path
> > 
> > I think that above method is not necessary because an HdpAgent always is
> > notified when a new data channel is created or destroyed, but we are
> > open to discuss.
> 
> As an occasional application writer, I'd like to have this list at hand :) Indeed the application can integrate every connection/disconnection and know the current state, but...

Sounds good to be in the API. We added it in the proposal.

Regards.

