Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<santoscadenas@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: Changes in HDP API
Date: Wed, 4 Aug 2010 19:53:40 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <1280908152-3743-1-git-send-email-santoscadenas@gmail.com> <201008041554.27451.santoscadenas@gmail.com> <AANLkTinO4=BjcNP5uyi_nX0axaBth7aUAhgOoFdPKrY2@mail.gmail.com>
In-Reply-To: <AANLkTinO4=BjcNP5uyi_nX0axaBth7aUAhgOoFdPKrY2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201008041953.40795.santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

El Wednesday 04 August 2010 18:45:50 Luiz Augusto von Dentz escribió:
> Hi,
> 
> On Wed, Aug 4, 2010 at 4:54 PM, José Antonio Santos Cadenas
> 
> <santoscadenas@gmail.com> wrote:
> >> This has 2 main advantages:
> >> 
> >> 1.  Anyone can request to connect not only applications which holds
> >> local endpoints
> > 
> > How can you guess the remote end point to connect to if you don't have a
> > local end point?
> 
> There is no endpoints involved in this case, bluetooth applet/agent
> has knowledge only of the device so bluetoothd will need to figure out
> all the matching endpoint and make sure local endpoint get notified
> about the available channels, so responding your question there is
> nothing to guess it all about matching the endpoints if there is no
> match it just fails after the discover as simple as that.

Sorry but I don't understand the answer. I think that the daemon needs to 
guess the remote end point to connect to when the user performs a connection 
of a data channel to a device (I mean the mdepid where the data channel will 
be connected). In HDP each data channel can be configured in a specific way 
(reliable or streaming) and is connected for an specific usage (that's the 
data type parameter in the SDP record) so you have to specify this during the 
connection of the channel.

An other thing to solve is the way that the data channel deletion is notified 
if there is no associated agent, I mean, if you just do a Connect without 
registering an agent first. This kind of events are supposed to be received by 
the agent. An other special issue of HDP, data channels can be open or closed 
but they are still active because reconnections are possible and this implies 
no disconnection for the application layer.

> 
> At least that is the idea around connect/disconnect in gnome-bluetooth
> and N900 bluetooth application does have a similar design.

I don't know how this is exactly working (I'll have a deeper look), but I 
guess that only one agent is allowed. I think that will be great to have 
multiple agents in HDP because more than one application can be using HDP at 
the same time. I don't know if with only one agent this can be solved.

Regards

Jose.
