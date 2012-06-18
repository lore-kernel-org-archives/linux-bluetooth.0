Return-Path: <cyrus@holtmann.org>
From: <Michal.Labedzki@tieto.com>
To: <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Date: Mon, 18 Jun 2012 13:30:57 +0300
Subject: RE: [PATCH 04/13] AVRCP: Keep AVRCP version of connected device in
 server
Message-ID: <E50901D4F2CF69428D43141B7C85867929DD8AD28C@EXMB03.eu.tieto.com>
References: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
	<1338998771-18683-4-git-send-email-michal.labedzki@tieto.com>,<CABBYNZ+Jd9WNftEsrxj93oLgPt8GNAd2eFdoQVWj3g0favoiTA@mail.gmail.com>
In-Reply-To: <CABBYNZ+Jd9WNftEsrxj93oLgPt8GNAd2eFdoQVWj3g0favoiTA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> The idea is fine, but this is not the server version, it is the
> version used in the connection so it probably need to be stored in
> avrcp_player. If there remote doesn't support AVRCP 1.3 or latter we
> don't need to assign a player.

Ok. This is "remote_version" - remote controller version of AVRCP.Therefore on (new) connection this version will be updated.
avrcp_player is not good place for that, because connection is only one, so version is the same for all players, but players may be for example 67.
So maybe only fix the name will be ok. What do you think?


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