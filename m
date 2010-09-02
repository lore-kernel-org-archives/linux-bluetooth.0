Return-Path: <cyrus@holtmann.org>
From: Sander van Grieken <sander@outrightsolutions.nl>
To: linux-bluetooth@vger.kernel.org
Subject: Re: AVRCP future
Date: Thu, 2 Sep 2010 23:18:04 +0200
References: <201009011603.02153.sander@outrightsolutions.nl> <201009021020.50162.sander@outrightsolutions.nl> <AANLkTin8XEU2TQLSWYnP2SBrwXVe3Oj3YqX1nUBcfCn5@mail.gmail.com>
In-Reply-To: <AANLkTin8XEU2TQLSWYnP2SBrwXVe3Oj3YqX1nUBcfCn5@mail.gmail.com>
MIME-Version: 1.0
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201009022318.04177.sander@outrightsolutions.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 02 September 2010 14:56:10 you wrote:
> On Thu, Sep 2, 2010 at 11:20 AM, Sander van Grieken
> > I was more thinking of exposing a dbus interface that allows a player (or any TG) to
> > register itself as a TG, then acting on signals/sending events/responses.
> 
> That could be done, actually this is a similar idea as we are planning
> to have[1] for replacing our audio ipc, but for things like progress
> we would really need to cache it since most device Ive seem keep
> polling this.
> Another possibility is to use MPRIS and PulseAudio
> together, but the spec of MPRIS need some work right now the player
> assume some name with a prefix e.g: org.freedesktop.MPRIS which is not
> that nice, perhaps making MPRIS a separate daemon would make more
> sense.
> 
> This means that for freedesktop we have:
> 
>     BlueZ <-> PulseAudio <-> MPRIS
> 
> For the rest:
> 
>     BlueZ <-> Player/whatever
> 
> If that is done in PulseAudio we could probably associate the metadata
> directly with the stream using MPRIS, if it is up to the player then
> we don't care they can set this information directly via some D-Bus
> API that is yet to be defined, which wouldn't require player to
> implement MPRIS spec. Joao Paulo has something already so I guess we
> can start from there[2].
> 
> [1] http://gitorious.org/~vudentz/bluez/vudentzs-clone/commits/endpoint
> [2] http://git.profusion.mobi/cgit.cgi/jprvita/bluez/log/?h=avrcp_metadata

Thanks Luiz,

I'm aware of João's work. In fact I've already merged his work into my branch, he exposed 
much of the AVRCP controls.

I see the benefit of MPRIS+PulseAudio for AVRCP 1.3, but for 1.4 MPRIS is just too 
limited. Also, it's only for audio players [1], while AVRCP also specifies (TV) menu 
controls and such, so it exceeds the scope of MPRIS.

Your git looks interesting! Added to remotes :)

grtz,
Sander


[1] http://xmms2.org/wiki/Media_Player_Interfaces#Overview
