Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E50901D4F2CF69428D43141B7C85867929DD8AD288@EXMB03.eu.tieto.com>
References: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
	<1338998771-18683-2-git-send-email-michal.labedzki@tieto.com>
	<CABBYNZK7SE-fSxPdyORsLDWiUa2nOvAr2tH2aERkDqqs144PLQ@mail.gmail.com>
	<E50901D4F2CF69428D43141B7C85867929DD8AD281@EXMB03.eu.tieto.com>
	<CABBYNZK6LhfsAp511+uV0dsKXOxmu8_cOH2QQndLhYX+YoMZ3w@mail.gmail.com>
	<E50901D4F2CF69428D43141B7C85867929DD8AD284@EXMB03.eu.tieto.com>
	<CABBYNZ+4ds8qKv7z9nd-nx-QyhHCQZYm_wjzny8_vaqvE2ijTQ@mail.gmail.com>
	<E50901D4F2CF69428D43141B7C85867929DD8AD288@EXMB03.eu.tieto.com>
Date: Fri, 15 Jun 2012 12:43:43 +0300
Message-ID: <CABBYNZLOVLRyKT=Txyi+O7VcqLjCPdy_X884YGEf+nzBBziQ6w@mail.gmail.com>
Subject: Re: [PATCH 02/13] AVRCP: Use name "addressed" instead of "active"
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal.Labedzki@tieto.com
Cc: linux-bluetooth@vger.kernel.org, lucas.demarchi@profusion.mobi,
	johan.hedberg@gmail.com, vani.patel@stericsson.com,
	joohi.rastogi@stericsson.com
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Fri, Jun 15, 2012 at 10:47 AM,  <Michal.Labedzki@tieto.com> wrote:
> Hi Luiz,
>
>> Register at boot time? Are you serious you want players to be started
>> during boot?
>
> Not only system-stable players, like main player.

What is a main player? Where I can find one?

>> If the player is not running it cannot be registered
>> since it cannot be connected to D-Bus an thus cannot receive any
>> messages, an using an agent to register itself is also a bad idea
>> since you would have to forward message which is considered a very bad
>> design.
>
> "Registration" and "Player" should be separated. So player can be registered by external tool, like bootscripts. Then starting player by dbus call.

Do you really want that each player install a file saying it needs to
be registered during the boot? And you call that a good design?
Besides we cannot start the player like that, we are in the system bus
the player needs to be activated on the session bus which we don't
have access to.

> Offtopic: forwarding messages are not that bad. It is only an issue introduce by bad interface design, which are too poor to do something directly.

You got to be kidding, any forward message adds another timeout
handler, pending call handler, not to mention latency, tracking the
sender, just about everything got more complicated. It is a bad
design, so bad that motivates D-Bus on kernel to get rid of the D-Bus
daemon forwarding messages.

>> AddressedPlayerChanged is a notification that the player is no longer
>> available
>
> No, no, no. For available player you got separated event: AvailablePlayersChanged, and after that you should download list of the players again, so that is for detecting available players. On the other hand you got event AddressedPlayerChanged which is designed for detecting currently controlled player by local user.

That doesn't mean we need to expose this to the user and in most of
cases the user don't really switch the addressed player because it has
only one anyway.

> Specification 6.9:
> "The player to which the AV/C Panel Subunit [2] shall route control commands is the
> addressed player. This may be changed locally on the TG, or by the CT using the SetAddressedPlayer command."
>
>
>> , and the browsed player reacts to addressed player
>
> What? Do you not try to mix these functionalities? AddressedPlayer and BrowsedPlayer can be separated. Player decide of that. May implement OnlyBrowsableWhenAddressed or no.

Why you want the player to decide that? It doesn't need to know about
this details, specially if there is only one player in the system,
which is what we should be focusing.

>>, btw once
>> you change the addressed player the controller has to register
>> everything again, it is a very bad design no matter how you look at
>> it.
>
> No. It is not bad. It is AVRCP 1.4 feature based on notification nature. Look to specification 6.9.2.2
> "On completion of the Addressed Player Changed notification the TG shall complete all
> player specific notifications with AV/C C-Type REJECTED with error code Addressed
> Player Changed." - so controller will probably registering events again. This allow to update content of mediaplayer on controller.

Yeah, that indeed is a very good design to reject everything, takes a
few message and some time, and register everything again, another few
messages, then in the meantime the user select another player, nobody
need to be a genius to know this is racy and probably will cause quite
a few IOP problems.

>> I disagree, exposing this will just bloat the UI and probably fragment
>> the testing of this feature since each environment may implement this
>> differently, not to mention with multiuser environment this simple
>> doesn't work, we should really concentrate on having something that
>> works reliable with one player active at time which is most likely
>> what the user gonna be doing most of the time.
>
> What about indication which player are currently addressed? I think that one player may be indicated by icon, etc.

You can indicate that by a method call e.g.
org.bluez.MediaPlayer.SetProperty("Addressed", TRUE), so far I haven't
seen any use for this but perhaps to update the audio routing it would
be acceptable.

>
>> The player interfaces may have a disable/enable bluetooth button where
>> it unregister/register itself, that way you can control what metadata
>> will be displayed.
>>
>> Then don't unregister the player just let it mark itself as
>> non-addressable, so the metadata policy is directly controlled by the
>> player itself not an external tool.
>
> This is already done by this patchset. Players are registrated and rarely unregistered.
> Player may use any of BlueZ interface anytime, so can implementing that by
> using property AddressedPlayer (but should not that automaticaly, only by "button")
>
>
>> In a multiuser environment this doesn't work, we cannot list players
>> from other users, so at this point this became completely invalid use
>> case.
>
> In patchset we can print player list by adapters. No any user/dbus sender relation.
>

Exactly, but this is the problem, it should be able to list the
players only for the same user, otherwise one can use this to gain
some access to other user players and change the addressed.

>
>> Im not cutting anything, all the use cases are covered, you just can't
>> overwrite the addressed player with an external tool because we have
>> no idea what user will be running that tool and if it has permission
>> to change the addressed player, and that is by design to avoid having
>> to write a lot of code to manage this when the great majority of users
>> will just have one player active at time, thus making this useless.
>
> Ther is no any code to managment, right? This patches only implements the possibility to implement
> the managment tool. By player or external tool. Seems to user can disconnect device by BlueZ/Dbus
> so changing addressed player can be done in the same way. Do I not miss something?

Which is only necessary if we implement all things you are suggesting,
right? And the worst part is that you don't even have an example of
such external tool, and nobody else seems to care either.

>
>> Note, this is nothing we cannot add in future, but it is always better
>> to start we something simple so there is less risk break API, we did
>> this a couple of times and it is always hard to deprecate things.
>
> So maybe good idea is partially merge? Are everything without media interface "AddressedPlayer" ok for you? (but within "Players" property)
> Without whole new interface?

I don't want the Player nor the AddressedPlayer, that being clear I do
see some other changes might be okay, we definable need a dummy player
until one is registered for 1.3 and 1.4 if AvailablePlayersChanged is
not used.

> Summary
> 1. Regarding to the playerList feature, we cannot unregister any player

Yes we can, that is what AvailablePlayersChanged is for.

> 2. AddressedPlayer can be changed on local device (not only remote controller)

Only by the player itself, so it is being addressed and mark itself
non-addressable/unregister/disconnect from D-Bus then the addressed
player is changed.

> 3. More than one player may be in playing state at time same time. Audio stream should be switched with addressed player ("routing").

The less the player know about Bluetooth the better, that is the point
of integrating with PulseAudio so that we don't need to invent our own
API, the same applies here to routing, we won't create any specific
policy for this in bluetoothd, the player may tag the stream to use
bluetooth but that is up to the player.

-- 
Luiz Augusto von Dentz
