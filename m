Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201008031112.11556.santoscadenas@gmail.com>
References: <1280130927-4137-1-git-send-email-santoscadenas@gmail.com>
	<201008030930.45330.santoscadenas@gmail.com>
	<AANLkTi=iNPgNJaUpUK2v=whbWs_nzCpwq5TUbbDKk-7H@mail.gmail.com>
	<201008031112.11556.santoscadenas@gmail.com>
Date: Tue, 3 Aug 2010 14:42:15 +0300
Message-ID: <AANLkTin9WnU0v2NqS5cAjRxyhipJCBYX0=KWponiCk14@mail.gmail.com>
Subject: Re: [PATCH] Notify to device drivers when the SDP records change
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Jos=E9_Antonio_Santos_Cadenas?=
	<santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Aug 3, 2010 at 12:12 PM, José Antonio Santos Cadenas
<santoscadenas@gmail.com> wrote:
> The different with a2dp is that the application will decide the end point to
> connect to, because there can be more than one matching the source. This end
> point is represented by a path that is passed to the HealthAgent when is
> discovered. If the remote record changes it is possible that new end points
> are available so the application needs something to discover the available end
> points. That is why I think that we need something like this.

I guess we already suggest you guys to take a look in the
MediaEndpoint interface, which can be found here:

http://gitorious.org/~vudentz/bluez/vudentzs-clone/commit/2af3d2821f0aaafae12be10522c82dea6a701688.patch

It doesn't expose the remote endpoints it basically do the best
matching, if the application requesting the connection has local
endpoint they have priority, and then the 'agent' or in case of audio
the endpoint will be notified with the remote endpoint capabilities.

Also while looking the health API it seems you guys missed a very
important point, HealthAgent only knows about the remote services
since there is no signal for announcing a new HealthApplication nor
the application knows the about HealthService, so the only way make
this to work is that the HealthApplication and HealthAgent leaves in
the same process but this defeats the point of having them separated.
So either we have the applications and services being announced to
everyone and then anyone can do the matching or we don't announce them
at all and make bluetoothd do the matching itself, I guess the latter
is better so we don't have to split the logic in many place (with
potential code duplication + bugs).

Another important thing is that dbus introspection does not have any
way to notify changes, so it really need to be signal to notify
applications about new services.

-- 
Luiz Augusto von Dentz
Computer Engineer
