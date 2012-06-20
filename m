Return-Path: <cyrus@holtmann.org>
From: <Michal.Labedzki@tieto.com>
To: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>
Date: Wed, 20 Jun 2012 14:08:08 +0300
Subject: RE: [PATCH hcidump 1/2 v2] AVRCP: Add parsing for
 SetAddressedPlayer PDU
Message-ID: <E50901D4F2CF69428D43141B7C85867929DD8AD291@EXMB03.eu.tieto.com>
References: <1340106030-30782-1-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1340106030-30782-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Ack, but I think that you should indicate that PDU with incorrect parameter length is malformed too - add printf on the end of parsed PDU.

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
