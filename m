Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E50901D4F2CF69428D43141B7C85867929DD8AD284@EXMB03.eu.tieto.com>
References: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
	<1338998771-18683-2-git-send-email-michal.labedzki@tieto.com>
	<CABBYNZK7SE-fSxPdyORsLDWiUa2nOvAr2tH2aERkDqqs144PLQ@mail.gmail.com>
	<E50901D4F2CF69428D43141B7C85867929DD8AD281@EXMB03.eu.tieto.com>
	<CABBYNZK6LhfsAp511+uV0dsKXOxmu8_cOH2QQndLhYX+YoMZ3w@mail.gmail.com>
	<E50901D4F2CF69428D43141B7C85867929DD8AD284@EXMB03.eu.tieto.com>
Date: Thu, 14 Jun 2012 13:47:11 +0300
Message-ID: <CABBYNZ+4ds8qKv7z9nd-nx-QyhHCQZYm_wjzny8_vaqvE2ijTQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] AVRCP: Use name "addressed" instead of "active"
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal.Labedzki@tieto.com
Cc: linux-bluetooth@vger.kernel.org, lucas.demarchi@profusion.mobi,
	johan.hedberg@gmail.com, vani.patel@stericsson.com,
	joohi.rastogi@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Thu, Jun 14, 2012 at 12:42 PM,  <Michal.Labedzki@tieto.com> wrote:
> Hi Luiz,
>
>> This is already possible by using PulseAudio, you can select the
>> output per application, it is really a non-issue.
>
> Do not forget about "mplayer".
>
>
>> Why not allow user to playing audio stream from few players? User may want that.
>> If not then it should stopped players one by one. This is not bad, because it must
>> push "play" on all player early.
>
>> It can already do that, what is your point here, the addressed is
>> plain english, addressed _by_ the controller. Besides the user cannot
>> know all the player it has in the system, because the players may
>> belong to different users.
>
> Wrong. User may not know all the players in system, because every player should registering at "boot time".
> So you have a list of available player. Then all player supported AVRCP 1.3/1.4 will be accessible for remote controller or local controller.
> According to the specification player may be not currently running (specification 6.9). Like Android,
> music player is registered, but it starting only on PLAY (other) button. Of course this case is not implemented in those patches.

Register at boot time? Are you serious you want players to be started
during boot? If the player is not running it cannot be registered
since it cannot be connected to D-Bus an thus cannot receive any
messages, an using an agent to register itself is also a bad idea
since you would have to forward message which is considered a very bad
design.

> Addressed_by_controller is not truth, because you have event designed to be registered by remote controller - AddressedPlayerChanged.
> This mean that you can change addressedplayer on local device and this event inform remote controller about this change.
> Look that browsing feature  does not have corresponding event. (SetAddressedPlayer & AddressedPlayerChanged vs SetBrowsedPlayer)

AddressedPlayerChanged is a notification that the player is no longer
available, and the browsed player reacts to addressed player, btw once
you change the addressed player the controller has to register
everything again, it is a very bad design no matter how you look at
it.

>
>> In this case you are trying to duplicate the same UI the controller
>> could have to control the addressed player locally, lets not
>> over-engineer things the same way the AVRCP did, the controller will
>> be able to address different players and the user has the ability to
>> close/stop the addressed player to start another one, that cover
>> pretty much everything in on the market.
>
> Do you mean that local device should be a poor and have limited functionality than remote controller?
> This is not good idea. Everything what is possible on remote controller should be possible on local device too (in this case this is not the problem)

I disagree, exposing this will just bloat the UI and probably fragment
the testing of this feature since each environment may implement this
differently, not to mention with multiuser environment this simple
doesn't work, we should really concentrate on having something that
works reliable with one player active at time which is most likely
what the user gonna be doing most of the time.

> In my opinion changing addressed player locally is necessary.
>
> Case 1: Let think about you run 2 player. Music player and radio player. You listen the music over headset.
>            But your headset is  AVRCP 1.4 without AddressedPlayer feature (like MW600). Then you use local device (for example phone) to change player to radio.

The player interfaces may have a disable/enable bluetooth button where
it unregister/register itself, that way you can control what metadata
will be displayed.

> Case 2: You have headset with AVRCP 1.4 . So you should still support for case 1, but you should not remove player from the player list, because you will
>            broken functionality on remote controller - incomplete player list. Done by "GetFolderItems" on MediaPlayerList scopes
>            implies that you need registered more player at the same time, you should not unregistered anymore.

Then don't unregister the player just let it mark itself as
non-addressable, so the metadata policy is directly controlled by the
player itself not an external tool.

> Case 3: Start thinking about onscreen metadata reader (like KDE plasmoid, notification, etc.). User should be able to choose used mediaplayer for using  metadata from the player list. API from this patchset allow to check every player (the list is available), also can chech which player is currently addressed (very user experience, because you should expect the same metadata on screen and on remote controller)

In a multiuser environment this doesn't work, we cannot list players
from other users, so at this point this became completely invalid use
case.

> Case 4: ...this API allow to testing this feature. How do you want to check AddressedPlayerChanged without major changed in environment (unregistered player is not the case, changing play status too, because you will send unwanted frames to testing tool)
>

If the player unregister, leaves the bus or mark itself as non-addressable

> Try think about full support of AVRCP 1.4. Without cut some functionality.

Im not cutting anything, all the use cases are covered, you just can't
overwrite the addressed player with an external tool because we have
no idea what user will be running that tool and if it has permission
to change the addressed player, and that is by design to avoid having
to write a lot of code to manage this when the great majority of users
will just have one player active at time, thus making this useless.

Note, this is nothing we cannot add in future, but it is always better
to start we something simple so there is less risk break API, we did
this a couple of times and it is always hard to deprecate things.

-- 
Luiz Augusto von Dentz
