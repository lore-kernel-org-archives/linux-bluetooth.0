Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<santoscadenas@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: Changes in HDP API
Date: Wed, 4 Aug 2010 15:54:27 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <1280908152-3743-1-git-send-email-santoscadenas@gmail.com> <AANLkTima=oJ4mPMkfPCNPjsqhxX0drGBDURXBMaLrJ1C@mail.gmail.com>
In-Reply-To: <AANLkTima=oJ4mPMkfPCNPjsqhxX0drGBDURXBMaLrJ1C@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201008041554.27451.santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

El Wednesday 04 August 2010 15:09:49 Luiz Augusto von Dentz escribió:
> Hi,
> 
> On Wed, Aug 4, 2010 at 10:49 AM, Jose Antonio Santos Cadenas
> 
> <santoscadenas@gmail.com> wrote:
> > This patch makes some changes in the HDP API based in the conversation
> > that I had yesterday with Luiz and Elvis.
> > 
> > I still have a doubt about the notification of devices in the agent. Luiz
> > commented that with this API the Agent and the Application could not be
> > in different processes, is this a problem?
> > 
> > An other open issue is: if we notify when a device is discovered and
> > suitable for connect with an application and when a devices is removed
> > (or becomes not suitable for connect). I think that we already need
> > something like the patch that we start discussing yesterday, something
> > that can be called by the user in order to force a new service discovery
> > and notifies the driver that will notify the agent. Of course we can
> > avoid this not notifying the suitable devices and just letting to try
> > the connection against all the devices (if there is no matching service
> > it will fail). What do you think?
> > 
> > Regards.
> 
> Lets say you want the pairing agent to connect right after pairing or
> directly via applet, these applications has zero knowledge of what
> endpoints the devices has, that why I suggest something simpler, so we
> might only need e.g. HealthDevice which the applet can say, please
> connect to this device so it calls e.g. HealthDevice.Connect(), this
> basically will start a discovery of the health endpoints on
> bluetoothd, then it matches with local endpoints (HealthApplication),
> create the channels which are informed to the HealthAgent which can
> then acquire the file descriptor.

I like this approach more than the previous one. But I still have one 
question. I write it further down.

> 
> This has 2 main advantages:
> 
> 1.  Anyone can request to connect not only applications which holds
> local endpoints

How can you guess the remote end point to connect to if you don't have a local 
end point?

> 2.  There is no need to fetch the services, discovery will take place
> every time the application attempt to connect.

I agree with this one. Less discovery implies less traffic and less battery 
consumption and bandwidth.

Regards.


