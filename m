Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <66980755-B25D-4EE6-A443-5A60AD75351D@holtmann.org>
References: <CALkxMhFHWv7kxfRKrN3kq8NVRgVyk0vNpiR8ryKTm8s2b_exKQ@mail.gmail.com>
	<AF259BFC-2022-4280-9F98-D4679A280A84@holtmann.org>
	<CALkxMhHvbgaS4cxbrrQFGk59W9LoR-R47D-iTDBkrw3TG7sofA@mail.gmail.com>
	<66980755-B25D-4EE6-A443-5A60AD75351D@holtmann.org>
Date: Thu, 16 Jan 2014 08:00:59 +0100
Message-ID: <CALkxMhECbmeiHHaekdpfQtoZBM+w-BTmYkvnSSFT1SPF-jbKYA@mail.gmail.com>
Subject: Re: Wireshark and new BlueZ BTSNOOP format
From: Michal Labedzki <michal.labedzki@tieto.com>
To: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Cc: Szymon Janc <szymon.janc@tieto.com>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I want to announce that Wireshark from SVN revision 54699 support new
"Bluetooth monitor" BTSNOOP file format. This means that you are able
to open file created by btmon in Wireshark. Support for capturing by
libpcap is already requested to libpcap/tcpdump team (formally,
implementation is done)

By the way: there is also support for Ubertooth for Low Energy Link
Layer, but via USB (usbmon) interface (and ubertooth host tool, for
example: "ubertooth btle -f").


Pozdrawiam / Best regards
---------------------------------------------------------------------------=
----------------------------------
Micha=C5=82 =C5=81ab=C4=99dzki, Software Engineer
Tieto Corporation

Product Development Services

http://www.tieto.com / http://www.tieto.pl
---
ASCII: Michal Labedzki
location: Swobodna 1 Street, 50-088 Wroc=C5=82aw, Poland
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
Tieto Poland sp=C3=B3=C5=82ka z ograniczon=C4=85 odpowiedzialno=C5=9Bci=C4=
=85 z siedzib=C4=85 w
Szczecinie, ul. Malczewskiego 26. Zarejestrowana w S=C4=85dzie Rejonowym
Szczecin-Centrum w Szczecinie, XIII Wydzia=C5=82 Gospodarczy Krajowego
Rejestru S=C4=85dowego pod numerem 0000124858. NIP: 8542085557. REGON:
812023656. Kapita=C5=82 zak=C5=82adowy: 4 271500 PLN
