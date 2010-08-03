Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<santoscadenas@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH] Notify to device drivers when the SDP records change
Date: Tue, 3 Aug 2010 14:43:16 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <1280130927-4137-1-git-send-email-santoscadenas@gmail.com> <201008031112.11556.santoscadenas@gmail.com> <AANLkTin9WnU0v2NqS5cAjRxyhipJCBYX0=KWponiCk14@mail.gmail.com>
In-Reply-To: <AANLkTin9WnU0v2NqS5cAjRxyhipJCBYX0=KWponiCk14@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201008031443.16245.santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El Tuesday 03 August 2010 13:42:15 Luiz Augusto von Dentz escribió:
> Hi,
> 
> On Tue, Aug 3, 2010 at 12:12 PM, José Antonio Santos Cadenas
> 
> <santoscadenas@gmail.com> wrote:
> > The different with a2dp is that the application will decide the end point
> > to connect to, because there can be more than one matching the source.
> > This end point is represented by a path that is passed to the
> > HealthAgent when is discovered. If the remote record changes it is
> > possible that new end points are available so the application needs
> > something to discover the available end points. That is why I think that
> > we need something like this.
> 
> I guess we already suggest you guys to take a look in the
> MediaEndpoint interface, which can be found here:
> 
> http://gitorious.org/~vudentz/bluez/vudentzs-clone/commit/2af3d2821f0aaafae
> 12be10522c82dea6a701688.patch
> 
> It doesn't expose the remote endpoints it basically do the best
> matching, if the application requesting the connection has local
> endpoint they have priority, and then the 'agent' or in case of audio
> the endpoint will be notified with the remote endpoint capabilities.
> 
> Also while looking the health API it seems you guys missed a very
> important point, HealthAgent only knows about the remote services
> since there is no signal for announcing a new HealthApplication nor
> the application knows the about HealthService, so the only way make
> this to work is that the HealthApplication and HealthAgent leaves in
> the same process but this defeats the point of having them separated.

Yes, this only works in the same process. It is a way for receiving callbacks 
from the daemon.

> So either we have the applications and services being announced to
> everyone and then anyone can do the matching or we don't announce them
> at all and make bluetoothd do the matching itself, I guess the latter
> is better so we don't have to split the logic in many place (with
> potential code duplication + bugs).

At this point, I have the same opinion, Services can be notified using 
signals. But Marcel thought that it will be better and will let the 
programmers make less mistakes if only the services related to the application 
are notified, that is why this information is send through the agent instead 
of sending signals. Of course this can be changed if we think that is better.

> 
> Another important thing is that dbus introspection does not have any
> way to notify changes, so it really need to be signal to notify
> applications about new services.
