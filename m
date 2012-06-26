Return-Path: <cyrus@holtmann.org>
From: <Michal.Labedzki@tieto.com>
To: <lucas.demarchi@profusion.mobi>, <wu.zheng@intel.com>
CC: <linux-bluetooth@vger.kernel.org>
Date: Tue, 26 Jun 2012 10:07:29 +0300
Subject: RE: using simple-player for testing avrcp
Message-ID: <E50901D4F2CF69428D43141B7C85867929E12C715F@EXMB03.eu.tieto.com>
References: <2CF57A644018A745B8FE029C7223E16E0FD7924A@SHSMSX102.ccr.corp.intel.com>,<CAMOw1v61pPwKq+3AG9wZpEYrBHxqtM4ZB2sWiFJnyKigd1W=rA@mail.gmail.com>
In-Reply-To: <CAMOw1v61pPwKq+3AG9wZpEYrBHxqtM4ZB2sWiFJnyKigd1W=rA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 

> Call "Connect" on Control interface (you need to enable it in your
> /etc/bluetooth/audio.conf file)

"Control" interface seems to be enabled by default (for a long time). Depending on BlueZ version 
"Media" interface are enabled (latest) or not, so to be sure I recommend to enable both in audio.conf.

Does your remote controller not try to connect to AVRCP on device with BlueZ? 
Some remote controller can autoconnect AVRCP by triggering A2DP.

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

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
