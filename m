Return-Path: <cyrus@holtmann.org>
From: <Michal.Labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
Date: Fri, 28 Sep 2012 16:07:44 +0300
Subject: Wireshark
Message-ID: <E50901D4F2CF69428D43141B7C8586792CFACCF505@EXMB03.eu.tieto.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello All,

I am trying to add full Bluetooth support to a Wireshark. Wireshark can be
used as replacement for "hcidump" or other GUI applications for displaying
Bluetooth frames/packets.

Currently Wireshark support:
1. Sniffing via Bluetooth dongle
2. Protocols/Profiles:
    HCI (without BLE)
    L2CAP
    SDP (little broken)
    RFCOMM 1.1
    OBEX (so all OBEX profiles can be treat as supported)
    AMP
    HID 1.0
    SAP 1.1
    BNEP 1.0
    AVCTP 1.4
    AVRCP 1.5

At this moment I am working on: (finishing)
1. ATT
2. HCRP
3. MCAP
4. AVDTP/A2DP/VDP

So I need a lot of Bluetooth logs to test them. Could you send me all your
logs? Profile or protocol there is not important [SAP? OK!], but only
BT SNOOP format is requires, of course PCAP too. Please share your logs, to my e-mail or wherever you want,.
I guess logs may be useful for other BlueZ developer too (so... logs database?)

I will be very happy if somebody send me AVDTP/A2DP/VDP logs where used all
known codecs (mean MPEG12_AUDIO//MPEG24_AAC/ATRAC/ H263/MPEG4)


Try Wireshark :)

PS. "tshark  -r hcidump.log" is similar to "hcidump"


Regards / Pozdrawiam
-------------------------------------------------------------------------------------------------------------
Micha³ £abêdzki
ASCII: Michal Labedzki
e-mail: michal.labedzki@tieto.com

---
Tieto Corporation / Tieto Poland
http://www.tieto.com / http://www.tieto.pl
---
Tieto Poland spó³ka z ograniczon± odpowiedzialno¶ci± z siedzib± w Szczecinie, ul. Malczewskiego 26. Zarejestrowana w S±dzie Rejonowym Szczecin-Centrum w Szczecinie, XIII Wydzia³ Gospodarczy Krajowego Rejestru S±dowego pod numerem 0000124858. NIP: 8542085557. REGON: 812023656. Kapita³ zak³adowy: 4 271500 PLN