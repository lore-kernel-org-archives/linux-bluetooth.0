Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <532F515A.3060809@gmail.com>
References: <532CAAB8.5020403@gmail.com>
	<532F33BB.8050000@gmail.com>
	<532F515A.3060809@gmail.com>
Date: Mon, 24 Mar 2014 08:24:38 +0100
Message-ID: <CALkxMhHjAhfZ4ade-o+ebtZMZB7o3m9YEzdecphsm1e2cB45bA@mail.gmail.com>
Subject: Re: Help on connecting a PS3 headset
From: Michal Labedzki <michal.labedzki@tieto.com>
To: Andrea <mariofutire@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Wireshark is able to open both files. More interesting is "blue.log".
It seems that you want to connect via HSP or HFP (only supported by
headset). In "blue.log" headset asks (SDP) your bluez about "Handsfree
Audio Gateway" or "Headset Audio Gateway", but bluez return empty
records, so they must be disabled.

-- 

Pozdrawiam / Best regards
-------------------------------------------------------------------------------------------------------------
Michał Łabędzki, Software Engineer
Tieto Corporation

Product Development Services

http://www.tieto.com / http://www.tieto.pl
---
ASCII: Michal Labedzki
location: Swobodna 1 Street, 50-088 Wrocław, Poland
room: 5.01 (desk next to 5.08)
---
Please note: The information contained in this message may be legally
privileged and confidential and protected from disclosure. If the
reader of this message is not the intended recipient, you are hereby
notified that any unauthorised use, distribution or copying of this
communication is strictly prohibited. If you have received this
communication in error, please notify us immediately by replying to
the message and deleting it from your computer. Thank You.
---
Please consider the environment before printing this e-mail.
---
Tieto Poland spółka z ograniczoną odpowiedzialnością z siedzibą w
Szczecinie, ul. Malczewskiego 26. Zarejestrowana w Sądzie Rejonowym
Szczecin-Centrum w Szczecinie, XIII Wydział Gospodarczy Krajowego
Rejestru Sądowego pod numerem 0000124858. NIP: 8542085557. REGON:
812023656. Kapitał zakładowy: 4 271500 PLN
