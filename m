Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201009021020.50162.sander@outrightsolutions.nl>
References: <201009011603.02153.sander@outrightsolutions.nl>
	<20100901185729.GB30041@jh-x301>
	<201009021020.50162.sander@outrightsolutions.nl>
Date: Thu, 2 Sep 2010 15:56:10 +0300
Message-ID: <AANLkTin8XEU2TQLSWYnP2SBrwXVe3Oj3YqX1nUBcfCn5@mail.gmail.com>
Subject: Re: AVRCP future
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sander van Grieken <sander@outrightsolutions.nl>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Sep 2, 2010 at 11:20 AM, Sander van Grieken
<sander@outrightsolutions.nl> wrote:
> I'm not in favor of having (multiple) storage plugins. Simply because a storage backend is
> not a player. This distinction is important. MeeGo/tracker is a semantic index, so in
> theory you could browse the media through it, but the player might have 'smart' playlist,
> or is only able to play media of a certain kind. Also the current playlist is a player-
> only thing (and is also a browsable item). So I think browsing should go _through_ the
> player.
>
> I was more thinking of exposing a dbus interface that allows a player (or any TG) to
> register itself as a TG, then acting on signals/sending events/responses.

That could be done, actually this is a similar idea as we are planning
to have[1] for replacing our audio ipc, but for things like progress
we would really need to cache it since most device Ive seem keep
polling this. Another possibility is to use MPRIS and PulseAudio
together, but the spec of MPRIS need some work right now the player
assume some name with a prefix e.g: org.freedesktop.MPRIS which is not
that nice, perhaps making MPRIS a separate daemon would make more
sense.

This means that for freedesktop we have:

    BlueZ <-> PulseAudio <-> MPRIS

For the rest:

    BlueZ <-> Player/whatever

If that is done in PulseAudio we could probably associate the metadata
directly with the stream using MPRIS, if it is up to the player then
we don't care they can set this information directly via some D-Bus
API that is yet to be defined, which wouldn't require player to
implement MPRIS spec. Joao Paulo has something already so I guess we
can start from there[2].

[1] http://gitorious.org/~vudentz/bluez/vudentzs-clone/commits/endpoint
[2] http://git.profusion.mobi/cgit.cgi/jprvita/bluez/log/?h=avrcp_metadata

-- 
Luiz Augusto von Dentz
Computer Engineer
