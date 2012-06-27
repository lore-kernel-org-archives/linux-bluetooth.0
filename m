Return-Path: <cyrus@holtmann.org>
From: <Michal.Labedzki@tieto.com>
To: <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <lucas.demarchi@profusion.mob>,
	<johan.hedberg@gmail.com>
Date: Wed, 27 Jun 2012 17:25:34 +0300
Subject: RE: [PATCH v2 01/14] AVRCP: Update constants
Message-ID: <E50901D4F2CF69428D43141B7C85867929E12C7163@EXMB03.eu.tieto.com>
References: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>,<CABBYNZ+QhVLY+Yr6qH92HO0k0SYGtWiGaEfmAnuou_05g7XqDQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+QhVLY+Yr6qH92HO0k0SYGtWiGaEfmAnuou_05g7XqDQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


> Haven't I nak the changes to enum before? What have you changed in v2?
>
>--
> Luiz Augusto von Dentz

No. According to Lucas I removed unused constants.
What wrong with enum? Look into sap.h, vhci.h, reporter.h, parser.h, cups.h and... avrcp.c ("enum battery_status" is here)

I have idea to make enum new convention in BlueZ. See sap.h - it looks very clearly for me. Pros for used enum is that enum can be thread as group of constants, mostly constants defined in specification. But "magic constants" should stay define - mostly defined by developer. 
Disadvantage for "define" is that as you can see in BlueZ AVRCP - you must use additional comment to describe group of constants.

Luiz, why "nak"? Could you present your point of view?

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
