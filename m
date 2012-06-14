Return-Path: <cyrus@holtmann.org>
From: <Michal.Labedzki@tieto.com>
To: <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <lucas.demarchi@profusion.mobi>,
	<johan.hedberg@gmail.com>, <vani.patel@stericsson.com>,
	<joohi.rastogi@stericsson.com>
Date: Thu, 14 Jun 2012 12:42:54 +0300
Subject: RE: [PATCH 02/13] AVRCP: Use name "addressed" instead of "active"
Message-ID: <E50901D4F2CF69428D43141B7C85867929DD8AD284@EXMB03.eu.tieto.com>
References: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
	<1338998771-18683-2-git-send-email-michal.labedzki@tieto.com>
	<CABBYNZK7SE-fSxPdyORsLDWiUa2nOvAr2tH2aERkDqqs144PLQ@mail.gmail.com>
	<E50901D4F2CF69428D43141B7C85867929DD8AD281@EXMB03.eu.tieto.com>,<CABBYNZK6LhfsAp511+uV0dsKXOxmu8_cOH2QQndLhYX+YoMZ3w@mail.gmail.com>
In-Reply-To: <CABBYNZK6LhfsAp511+uV0dsKXOxmu8_cOH2QQndLhYX+YoMZ3w@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This is already possible by using PulseAudio, you can select the
> output per application, it is really a non-issue.

Do not forget about "mplayer".


> Why not allow user to playing audio stream from few players? User may want that.
> If not then it should stopped players one by one. This is not bad, because it must
> push "play" on all player early.

> It can already do that, what is your point here, the addressed is
> plain english, addressed _by_ the controller. Besides the user cannot
> know all the player it has in the system, because the players may
> belong to different users.

Wrong. User may not know all the players in system, because every player should registering at "boot time". 
So you have a list of available player. Then all player supported AVRCP 1.3/1.4 will be accessible for remote controller or local controller.
According to the specification player may be not currently running (specification 6.9). Like Android, 
music player is registered, but it starting only on PLAY (other) button. Of course this case is not implemented in those patches.

Addressed_by_controller is not truth, because you have event designed to be registered by remote controller - AddressedPlayerChanged.
This mean that you can change addressedplayer on local device and this event inform remote controller about this change.
Look that browsing feature  does not have corresponding event. (SetAddressedPlayer & AddressedPlayerChanged vs SetBrowsedPlayer)


> In this case you are trying to duplicate the same UI the controller
> could have to control the addressed player locally, lets not
> over-engineer things the same way the AVRCP did, the controller will
> be able to address different players and the user has the ability to
> close/stop the addressed player to start another one, that cover
> pretty much everything in on the market.

Do you mean that local device should be a poor and have limited functionality than remote controller?
This is not good idea. Everything what is possible on remote controller should be possible on local device too (in this case this is not the problem)



>> My view on AVRCP (1.4) is as follow: AVRCP 1.4 is only the interface between
>> MediaPlayer applications and controllers, so nothing special to implement
>> (think about callback for "GetFolderItems", it should be a pipe). And mediaplayer presents
>> "audio services", like radio, TV which are stream based,
>> so mediaplayer may be all time in playing state.
>
> This is all possible, the only thing that is not possible is changing
> the addressed player, this would just complicate things more than
> necessary, also one important thing that you forgot is that the only
> use for changing the addressed is to the controller to be able to send
> the commands to a different player, but the point is to use the
> Bluetooth (wireless) why do you thing that going back to the PC/Phone
> interface to change the addressed player would be that useful?
> --
> Luiz Augusto von Dentz

In my opinion changing addressed player locally is necessary. 

Case 1: Let think about you run 2 player. Music player and radio player. You listen the music over headset.
            But your headset is  AVRCP 1.4 without AddressedPlayer feature (like MW600). Then you use local device (for example phone) to change player to radio.

Case 2: You have headset with AVRCP 1.4 . So you should still support for case 1, but you should not remove player from the player list, because you will 
            broken functionality on remote controller - incomplete player list. Done by "GetFolderItems" on MediaPlayerList scopes 
            implies that you need registered more player at the same time, you should not unregistered anymore.

Case 3: Start thinking about onscreen metadata reader (like KDE plasmoid, notification, etc.). User should be able to choose used mediaplayer for using  metadata from the player list. API from this patchset allow to check every player (the list is available), also can chech which player is currently addressed (very user experience, because you should expect the same metadata on screen and on remote controller)  

Case 4: ...this API allow to testing this feature. How do you want to check AddressedPlayerChanged without major changed in environment (unregistered player is not the case, changing play status too, because you will send unwanted frames to testing tool)


Try think about full support of AVRCP 1.4. Without cut some functionality.

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
________________________________________
