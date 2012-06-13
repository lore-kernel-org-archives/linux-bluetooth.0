Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E50901D4F2CF69428D43141B7C85867929DD8AD281@EXMB03.eu.tieto.com>
References: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
	<1338998771-18683-2-git-send-email-michal.labedzki@tieto.com>
	<CABBYNZK7SE-fSxPdyORsLDWiUa2nOvAr2tH2aERkDqqs144PLQ@mail.gmail.com>
	<E50901D4F2CF69428D43141B7C85867929DD8AD281@EXMB03.eu.tieto.com>
Date: Wed, 13 Jun 2012 22:03:50 +0300
Message-ID: <CABBYNZK6LhfsAp511+uV0dsKXOxmu8_cOH2QQndLhYX+YoMZ3w@mail.gmail.com>
Subject: Re: [PATCH 02/13] AVRCP: Use name "addressed" instead of "active"
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal.Labedzki@tieto.com
Cc: linux-bluetooth@vger.kernel.org, lucas.demarchi@profusion.mobi,
	johan.hedberg@gmail.com, vani.patel@stericsson.com,
	joohi.rastogi@stericsson.com
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Wed, Jun 13, 2012 at 6:18 PM,  <Michal.Labedzki@tieto.com> wrote:
> Hi Luiz,
>
> # Dummy player
> Whenever a device presents itself as the device which supports AVRCP (at least)
> one player should be provided. Current AVRCP 1.3 implementation does not provide
> any AVRCP player but - at the same time - registers SDP record assuming AVRCP
> service is working however it is not the case; if you do not register a player the
> AVRCP service will not work.
>
> For the above reason we shall introduce the Default Player (specification 6.9)
> which is sort of Dummy Player doing nothing but presents as a player.
> Providing the Dummy Player is meant to avoid the situation in which service
> registers itself without an available player; without such Dummy Player the AVRCP
> service returns some errors which cause major issues with some market devices -
> AVRCP stops working due to unexpected REJECT response (one of the device where such
> behaviour could be observed: MW600).

This is a completely different issue, yes we might have to emulate a
player until one is register to avoid this dumb behavior by the
headset.

> # AddressedPlayer changed locally
> Specification says (6.10.2.1):
> "The Play Status field can be used by the CT to learn which players are currently
> playing without having to switch the Addressed Player between all players to
> explicitly request each player’s status separately (Note that on some TGs,
> switching the Addressed Player might result in stopping a player’s audio stream)"
>
> According to above more than one player can play music at the same time and an
> audio stream should be switched on changing the addressed player but should NOT
> result in stopping the media player. To my understanding this should be done by
> "struct audio_device" in each player).
>
> So an user may run 10 players. Then on all players play is pushed (locally).
> But AVRCP controls only one player. I guess if for example when player #5 is playing,
> then should keep playing whenever it is addressed or not.
>
> For the above reasons the AVRCP 1.4 implementation should allow changing the
> AddressedPlayer locally (by an user).
> This indicates that the MediaPlayer will not implement the way to automatically
> set itself as addressed. Only an user should have the possibility to change
> the addressed player.
> (To my understanding section 26.10 in the spec indicates mentioned above
> interpretation).
>
>
> I am adding some side notes to be little bit more elaborate in here:
> 1. An user works on a PC, but listen to the music using BT headset with AVRCP.
> 2. The user does something (whatever... write SDP code in LibreOffice)
>   while the mediaplayer is in background.
> 3. Music ends... and the user starts the second media player (Instance #2 or separated player).
> 4. Somebody interrupts the user asking about anything. The user presses headset button to
>   stop the player...
>
> In this case user is working on a PC, so changing addressed player locally on PC,
> but at the same time using remote controller for basic operation like volume,
> play/stop. Wired headsets usually do not used PC for controlling those
> actions. So naturally user want to changing addressed player locally.
> Remote controller must be sync with PC.
>
> According to point 3. user should change addressed player in some way.
> It can be external component or maybe something in player, but think about
> audio services like radio, TV. Each one all time playing, but should not be
> controlled by remote controller. Which player should be used as addressed?
> I think one player should was chosen by user. All other player should be treat as
> "local player", so should be usable on local device. I think about use case where
> one user use headset to listen the music from TG and there is second user which
> watching video on TG too using internal screen/speaker. (so local device, maybe PC,
> maybe smartphone in "Media Center" role)

This is already possible by using PulseAudio, you can select the
output per application, it is really a non-issue.

> Why not allow user to playing audio stream from few players? User may want that.
> If not then it should stopped players one by one. This is not bad, because it must
> push "play" on all player early.

It can already do that, what is your point here, the addressed is
plain english, addressed _by_ the controller. Besides the user cannot
know all the player it has in the system, because the players may
belong to different users.

In this case you are trying to duplicate the same UI the controller
could have to control the addressed player locally, lets not
over-engineer things the same way the AVRCP did, the controller will
be able to address different players and the user has the ability to
close/stop the addressed player to start another one, that cover
pretty much everything in on the market.

>
>
> Next thing:
>
> ----------------------------------
> Players are separated per adapter (and partially per "DBus sender")
>
> Adapter #1
>
> mp1
> mp2
> mp3
> mp4
>
>
> Adapter #2
>
> mp5
> mp6
> mp7
>

The media interface is per-adapter already...

> ----------------------------------
> There is a lot of players and a lot of audio outputs (sound card 1,
> sound card 2...) and finally a lot of users...
>
> Adapter #1
>
> mp1: playing for remote controller (BT)
> mp2: stopped
> mp3: playing for local user XXX1 (PC/phone...)
> mp4: paused
>
> Adapter #2
>
> mp5: playing for remote user XXX2 (client-server)
> mp6: playing for another remote controller (BT)
> mp7: stopped
>
>
> ----------------------------------
>
> Summary:
>
> 1. Remote controller should be treated as part of the system, like a keyboard,
> so no less permission to "break environment" (for example: pick up player control someone
> local user)

If the player register itself to be controlled they it can be
addressed otherwise it doesn't, that is the permission.

> 2. Then a local user should do everything what remote controller can do, so changing
> addressed player in external application like "Virtual TV Remote Controller".

It can already, we just don't allow to overwrite the addressed player,
it is like a universal remote control where the tv don't overwrite its
configuration to tell it should control the dvd player.

> 3. More than one mediaplayer may be playing at the same time, maybe different
> output, maybe not (use case: user wants to mix audio streams: voice and music).
> I am against limiting user options. Limiting by adding option seems to be OK
> (like "Simple Pairing Mode"). So one could extend current implementation by limiting
> "playing players" to only one player by additional switch in audio.conf.
>
> My view on AVRCP (1.4) is as follow: AVRCP 1.4 is only the interface between
> MediaPlayer applications and controllers, so nothing special to implement
> (think about callback for "GetFolderItems", it should be a pipe). And mediaplayer presents
> "audio services", like radio, TV which are stream based,
> so mediaplayer may be all time in playing state.

This is all possible, the only thing that is not possible is changing
the addressed player, this would just complicate things more than
necessary, also one important thing that you forgot is that the only
use for changing the addressed is to the controller to be able to send
the commands to a different player, but the point is to use the
Bluetooth (wireless) why do you thing that going back to the PC/Phone
interface to change the addressed player would be that useful?


-- 
Luiz Augusto von Dentz
