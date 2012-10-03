Return-Path: <cyrus@holtmann.org>
From: <Michal.Labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <andrei.emeltchenko.news@gmail.com>
Date: Wed, 3 Oct 2012 10:17:51 +0300
Subject: RE: Wireshark
Message-ID: <E50901D4F2CF69428D43141B7C8586792CFACCF507@EXMB03.eu.tieto.com>
References: <E50901D4F2CF69428D43141B7C8586792CFACCF505@EXMB03.eu.tieto.com>,<20120928135747.GD8184@aemeltch-MOBL1>
In-Reply-To: <20120928135747.GD8184@aemeltch-MOBL1>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

> HCI also does not have full support for AMP HCI commands. I can send that
> log.

All logs are welcome. Andrei, please send it.

> but it can't do any kind of
> high-level decoding (e.g. profiles). It'd be interesting to know if it
> could be easily supported in wireshark since right now there doesn't
> seem to be a viable way of porting decoders from hcidump to btmon due to
> their very different ways of handling buffers etc.

Johan, I guess Wireshark support decoding what do you need (expect ongoing tasks). If you have another idea how do decoding, please share it. Power of Wireshark is:
1. Decoding all fields in protocols (+ user friendly describes and visualization bit/byte position in the frame)
2. Colors per protocol/profile to improve readability;
3. Possibility to display specified field as column (like Protocol, Length, Info; for example I display btl2cap.cid, btrfcomm.channel) [by the way, I have configured Wireshark to display column "Time" as "Absolute date and time" and additional "Delta" as "Delta time" - nice combination to working on timings]
4. Filtering logs, in Filter field you can but "btavrcp" and you see only AVRCP; or something like "btbnep.bnep_type == 0x01 || bthci_evt" - so you can display only HCI Events and BNEP packet where BNEP Type is equal 0x01.
5. (Menu) Statistics -> IO Graph, then "Y Axis -> Unit -> Bytes per Tick" and using filters - you can analyse throughput (for example: OPP, A2DP)
6. pcap file format can contain "Comments" - so everyone can share some useful additional information (per frame)


Example logs:
https://bugs.wireshark.org/bugzilla/attachment.cgi?id=9186
https://bugs.wireshark.org/bugzilla/attachment.cgi?id=9187
https://bugs.wireshark.org/bugzilla/attachment.cgi?id=9139
https://bugs.wireshark.org/bugzilla/attachment.cgi?id=9111
https://bugs.wireshark.org/bugzilla/attachment.cgi?id=9112
https://bugs.wireshark.org/bugzilla/attachment.cgi?id=9023
https://bugs.wireshark.org/bugzilla/attachment.cgi?id=9024
https://bugs.wireshark.org/bugzilla/attachment.cgi?id=9025
https://bugs.wireshark.org/bugzilla/attachment.cgi?id=7686

You can obtain Wireshark from SVN or GIT:
    svn co http://anonsvn.wireshark.org/wireshark/trunk/ wireshark
    git clone http://code.wireshark.org/git/wireshark    (I use only this one, but please note sometimes this way may not working...)

Installation:
not required: ./autogen.sh && ./configure && make -j 16 && ./wireshark

Regards / Pozdrawiam
-------------------------------------------------------------------------------------------------------------
Micha³ £abêdzki
ASCII: Michal Labedzki
e-mail: michal.labedzki@tieto.com
location: Poland, Wroc³aw, Legnicka 55F
---
Tieto Corporation / Tieto Poland
http://www.tieto.com / http://www.tieto.pl
---
Tieto Poland spó³ka z ograniczon± odpowiedzialno¶ci± z siedzib± w Szczecinie, ul. Malczewskiego 26. Zarejestrowana w S±dzie Rejonowym Szczecin-Centrum w Szczecinie, XIII Wydzia³ Gospodarczy Krajowego Rejestru S±dowego pod numerem 0000124858. NIP: 8542085557. REGON: 812023656. Kapita³ zak³adowy: 4 271500 PLN

