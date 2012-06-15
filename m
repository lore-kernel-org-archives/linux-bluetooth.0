Return-Path: <cyrus@holtmann.org>
From: <Michal.Labedzki@tieto.com>
To: <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <lucas.demarchi@profusion.mobi>,
	<johan.hedberg@gmail.com>, <vani.patel@stericsson.com>,
	<joohi.rastogi@stericsson.com>
Date: Fri, 15 Jun 2012 16:19:08 +0300
Subject: RE: [PATCH 02/13] AVRCP: Use name "addressed" instead of "active"
Message-ID: <E50901D4F2CF69428D43141B7C85867929DD8AD289@EXMB03.eu.tieto.com>
References: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
	<1338998771-18683-2-git-send-email-michal.labedzki@tieto.com>
	<CABBYNZK7SE-fSxPdyORsLDWiUa2nOvAr2tH2aERkDqqs144PLQ@mail.gmail.com>
	<E50901D4F2CF69428D43141B7C85867929DD8AD281@EXMB03.eu.tieto.com>
	<CABBYNZK6LhfsAp511+uV0dsKXOxmu8_cOH2QQndLhYX+YoMZ3w@mail.gmail.com>
	<E50901D4F2CF69428D43141B7C85867929DD8AD284@EXMB03.eu.tieto.com>
	<CABBYNZ+4ds8qKv7z9nd-nx-QyhHCQZYm_wjzny8_vaqvE2ijTQ@mail.gmail.com>
	<E50901D4F2CF69428D43141B7C85867929DD8AD288@EXMB03.eu.tieto.com>,<CABBYNZLOVLRyKT=Txyi+O7VcqLjCPdy_X884YGEf+nzBBziQ6w@mail.gmail.com>
In-Reply-To: <CABBYNZLOVLRyKT=Txyi+O7VcqLjCPdy_X884YGEf+nzBBziQ6w@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello again Luiz,

> What is a main player? Where I can find one?

Main player? Your favourite player. Frequently used.
For example in my system may be usable four separated player.:
1. mplayer for music/video [main]
2. mplayer for radio
3. mplayer for cam
4. vlc for Internet video streaming

I expect all four players should be available all time via RemoteController.

>> If the player is not running it cannot be registered
>> since it cannot be connected to D-Bus an thus cannot receive any
>> messages, an using an agent to register itself is also a bad idea
>> since you would have to forward message which is considered a very bad
>> design.
>
> "Registration" and "Player" should be separated. So player can be registered by external tool, like bootscripts. Then starting player by dbus call.

> Do you really want that each player install a file saying it needs to
> be registered during the boot? And you call that a good design?
> Besides we cannot start the player like that, we are in the system bus
> the player needs to be activated on the session bus which we don't
> have access to.

Yes, it is good design. User experience Luiz. Boot time is only example. You can do that any time. On login or run player. 

Session bus? But how run obexd by dbus now? Cannot use session bus? (maybe through external component) 

> Offtopic: forwarding messages are not that bad. It is only an issue introduce by bad interface design, which are too poor to do something directly.

> You got to be kidding, any forward message adds another timeout
> handler, pending call handler, not to mention latency, tracking the
> sender, just about everything got more complicated. It is a bad
> design, so bad that motivates D-Bus on kernel to get rid of the D-Bus
> daemon forwarding messages.

No, no. You look wrong on that. What do you want to choose? System without feature or system with little overload but within feature? Costs vs Features.
AVRCP may not generate output like HID or A2DP/VDP. Also there is a cache on Controller side. 
Take it easy :)



> No, no, no. For available player you got separated event: AvailablePlayersChanged, and after that you should download list of the players again, so that is for detecting available players. On the other hand you got event AddressedPlayerChanged which is designed for detecting currently controlled player by local user.

> That doesn't mean we need to expose this to the user and in most of
> cases the user don't really switch the addressed player because it has
> only one anyway

This is your opinion. In my opinion this will be very usable. If you do not want that, please do not use that. But we cannot use that if we do not have that in BlueZ, right?
Think about you keyboard. If you use keyboard then you expect the same functionality on onscreen keyboard, right?

>> Specification 6.9:
>> "The player to which the AV/C Panel Subunit [2] shall route control commands is the
>> addressed player. This may be changed locally on the TG, or by the CT using the SetAddressedPlayer command."
>>
>> What? Do you not try to mix these functionalities? AddressedPlayer and BrowsedPlayer can be separated. Player decide of that. May implement OnlyBrowsableWhenAddressed or no.
>
> Why you want the player to decide that?
> It doesn't need to know about
> this details, specially if there is only one player in the system,
> which is what we should be focusing.

Do you mean feature "OnlyBrowsableWhenAddressed" in PlayerFeatureBitmask? Name of this field describing what player can very well.

Specification 5.9:
"The media player selection functionality allows a TG device to support a range of media
players with varying functionality." (so one mediaplayer has "browsing", other no, etc.)


>>  No. It is not bad. It is AVRCP 1.4 feature based on notification nature. Look to specification 6.9.2.2
>>  "On completion of the Addressed Player Changed notification the TG shall complete all
>>  player specific notifications with AV/C C-Type REJECTED with error code Addressed
> > Player Changed." - so controller will probably registering events again. This allow to update content of mediaplayer on controller.

> Yeah, that indeed is a very good design to reject everything, takes a
> few message and some time, and register everything again, another few
> messages, then in the meantime the user select another player, nobody
> need to be a genius to know this is racy and probably will cause quite
> a few IOP problems.

This base on external AV specification  from 1998 :)


> >What about indication which player are currently addressed? I think that one player may be indicated by icon, etc.
> You can indicate that by a method call e.g.
> org.bluez.MediaPlayer.SetProperty("Addressed", TRUE), so far I haven't
> seen any use for this but perhaps to update the audio routing it would
> be acceptable.

Is that not bad design? Only one player can be addressed, but what when you done?:
/player1 org.bluez.MediaPlayer.SetProperty("Addressed", TRUE)
/player2 org.bluez.MediaPlayer.SetProperty("Addressed", TRUE)

Expected be  two player to be Addressed (two separated object by ObjectPath)




>> So maybe good idea is partially merge? Are everything without media interface "AddressedPlayer" ok for you? (but within "Players" property)
>> Without whole new interface?
> I don't want the Player nor the AddressedPlayer, that being clear I do
> see some other changes might be okay, we definable need a dummy player
> until one is registered for 1.3 and 1.4 if AvailablePlayersChanged is
> not used.

Ok. I will prepare new patchset.



>> Summary
>> 1. Regarding to the playerList feature, we cannot unregister any player
> Yes we can, that is what AvailablePlayersChanged is for.

Yes, but I thinking about normal use case. I you want to change current player, you need two or more, so you cannot unregister player anytime.

Specification 6.9:
"Note that available means that a player can be accessed via
AVRCP with no user interaction locally on the TG. It does not imply that the media
player application must be currently running."


>> 2. AddressedPlayer can be changed on local device (not only remote controller)
> Only by the player itself, so it is being addressed and mark itself
> non-addressable/unregister/disconnect from D-Bus then the addressed
> player is changed.

Why player should have ability to mark itself as non-addressed? 

I see to way to set player as addressed:
1. User decision, by mediaplayer or external component like VirtualOnscreenRemoteController.
2. On playing state (this implies war if you start more then one player and push play... last one will be addressed, but some player may do sequence stoppend/playing on the trackchanged, so metadata may blinking...)


> 3. More than one player may be in playing state at time same time. Audio stream should be switched with addressed player ("routing").

The less the player know about Bluetooth the better, that is the point
of integrating with PulseAudio so that we don't need to invent our own
API, the same applies here to routing, we won't create any specific
policy for this in bluetoothd, the player may tag the stream to use
bluetooth but that is up to the player.

What about system without PulseAudio? And how ALSA will know that one stream is from player A, other one from player B and how it will make decision which should be routed to the RemoteController (Headset)
By the way, what can be an alternative for PulseAudio?



Regards / Pozdrawiam
-------------------------------------------------------------------------------------------------------------
Micha³ £abêdzki
ASCII: Michal Labedzki
e-mail: michal.labedzki@tieto.com
office communicator: michal.labedzki@tieto.com
location: Poland, Wroc³aw, Legnicka 55F
room: 315
phone: +48 717 740 340
---
Tieto Corporation / Tieto Poland
http://www.tieto.com / http://www.tieto.pl
---
Tieto Poland spó³ka z ograniczon± odpowiedzialno¶ci± z siedzib± w Szczecinie, ul. Malczewskiego 26. Zarejestrowana w S±dzie Rejonowym Szczecin-Centrum w Szczecinie, XIII Wydzia³ Gospodarczy Krajowego Rejestru S±dowego pod numerem 0000124858. NIP: 8542085557. REGON: 812023656. Kapita³ zak³adowy: 4 271500 PLN