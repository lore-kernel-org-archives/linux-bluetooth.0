Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 4 Nov 2013 15:25:41 +0100
Message-ID: <CALkxMhFHWv7kxfRKrN3kq8NVRgVyk0vNpiR8ryKTm8s2b_exKQ@mail.gmail.com>
Subject: Wireshark and new BlueZ BTSNOOP format
From: Michal Labedzki <michal.labedzki@tieto.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello there,

There is a need to add support for latest BTSNOOP format currently
used in BlueZ (5). I have two questions:

1. Is BlueZ btsnoop format official and stable? Or invented by BlueZ
team? (stable? safe?)
2. Is there any documentation describes this format?

In code I saw two new magic numbers:
2001                   Bluetooth monitor
2002                   Bluetooth simulator
Is Bluetooth simulator completed now?

For now Wireshark (>= 1.10, trunk is recommended) provide probably
full Bluetooth support, all protocols, colours, filtering,
reassembling. If you find a bug or need new feature please create a
bug at https://bugs.wireshark.org/bugzilla/buglist.cgi?resolution=---&query_format=advanced&list_id=11093

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
