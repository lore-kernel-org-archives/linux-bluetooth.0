Return-Path: <cyrus@holtmann.org>
From: <Michal.Labedzki@tieto.com>
To: <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <lucas.demarchi@profusion.mobi>,
	<johan.hedberg@gmail.com>, <vani.patel@stericsson.com>,
	<joohi.rastogi@stericsson.com>
Date: Fri, 15 Jun 2012 10:47:16 +0300
Subject: RE: [PATCH 02/13] AVRCP: Use name "addressed" instead of "active"
Message-ID: <E50901D4F2CF69428D43141B7C85867929DD8AD288@EXMB03.eu.tieto.com>
References: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
	<1338998771-18683-2-git-send-email-michal.labedzki@tieto.com>
	<CABBYNZK7SE-fSxPdyORsLDWiUa2nOvAr2tH2aERkDqqs144PLQ@mail.gmail.com>
	<E50901D4F2CF69428D43141B7C85867929DD8AD281@EXMB03.eu.tieto.com>
	<CABBYNZK6LhfsAp511+uV0dsKXOxmu8_cOH2QQndLhYX+YoMZ3w@mail.gmail.com>
	<E50901D4F2CF69428D43141B7C85867929DD8AD284@EXMB03.eu.tieto.com>,<CABBYNZ+4ds8qKv7z9nd-nx-QyhHCQZYm_wjzny8_vaqvE2ijTQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+4ds8qKv7z9nd-nx-QyhHCQZYm_wjzny8_vaqvE2ijTQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Register at boot time? Are you serious you want players to be started
> during boot?

Not only system-stable players, like main player.

> If the player is not running it cannot be registered
> since it cannot be connected to D-Bus an thus cannot receive any
> messages, an using an agent to register itself is also a bad idea
> since you would have to forward message which is considered a very bad
> design.

"Registration" and "Player" should be separated. So player can be registered by external tool, like bootscripts. Then starting player by dbus call.

Offtopic: forwarding messages are not that bad. It is only an issue introduce by bad interface design, which are too poor to do something directly.

> AddressedPlayerChanged is a notification that the player is no longer
> available

No, no, no. For available player you got separated event: AvailablePlayersChanged, and after that you should download list of the players again, so that is for detecting available players. On the other hand you got event AddressedPlayerChanged which is designed for detecting currently controlled player by local user.

Specification 6.9:
"The player to which the AV/C Panel Subunit [2] shall route control commands is the
addressed player. This may be changed locally on the TG, or by the CT using the SetAddressedPlayer command."


> , and the browsed player reacts to addressed player

What? Do you not try to mix these functionalities? AddressedPlayer and BrowsedPlayer can be separated. Player decide of that. May implement OnlyBrowsableWhenAddressed or no.

>, btw once
> you change the addressed player the controller has to register
> everything again, it is a very bad design no matter how you look at
> it.

No. It is not bad. It is AVRCP 1.4 feature based on notification nature. Look to specification 6.9.2.2
"On completion of the Addressed Player Changed notification the TG shall complete all
player specific notifications with AV/C C-Type REJECTED with error code Addressed
Player Changed." - so controller will probably registering events again. This allow to update content of mediaplayer on controller.

> I disagree, exposing this will just bloat the UI and probably fragment
> the testing of this feature since each environment may implement this
> differently, not to mention with multiuser environment this simple
> doesn't work, we should really concentrate on having something that
> works reliable with one player active at time which is most likely
> what the user gonna be doing most of the time.

What about indication which player are currently addressed? I think that one player may be indicated by icon, etc.


> The player interfaces may have a disable/enable bluetooth button where
> it unregister/register itself, that way you can control what metadata
> will be displayed.
>
> Then don't unregister the player just let it mark itself as
> non-addressable, so the metadata policy is directly controlled by the
> player itself not an external tool.

This is already done by this patchset. Players are registrated and rarely unregistered.
Player may use any of BlueZ interface anytime, so can implementing that by
using property AddressedPlayer (but should not that automaticaly, only by "button")


> In a multiuser environment this doesn't work, we cannot list players
> from other users, so at this point this became completely invalid use
> case.

In patchset we can print player list by adapters. No any user/dbus sender relation.



> Im not cutting anything, all the use cases are covered, you just can't
> overwrite the addressed player with an external tool because we have
> no idea what user will be running that tool and if it has permission
> to change the addressed player, and that is by design to avoid having
> to write a lot of code to manage this when the great majority of users
> will just have one player active at time, thus making this useless.

Ther is no any code to managment, right? This patches only implements the possibility to implement
the managment tool. By player or external tool. Seems to user can disconnect device by BlueZ/Dbus
so changing addressed player can be done in the same way. Do I not miss something?


> Note, this is nothing we cannot add in future, but it is always better
> to start we something simple so there is less risk break API, we did
> this a couple of times and it is always hard to deprecate things.

So maybe good idea is partially merge? Are everything without media interface "AddressedPlayer" ok for you? (but within "Players" property)
Without whole new interface?


Summary
1. Regarding to the playerList feature, we cannot unregister any player
2. AddressedPlayer can be changed on local device (not only remote controller)
3. More than one player may be in playing state at time same time. Audio stream should be switched with addressed player ("routing").


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