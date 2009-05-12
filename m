Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <bd5c312b0905120537g3cfad35bi14d993229eb18de5@mail.gmail.com>
References: <bd5c312b0905120537g3cfad35bi14d993229eb18de5@mail.gmail.com>
Date: Tue, 12 May 2009 14:42:38 +0200
Message-ID: <bd5c312b0905120542i72b52122re3b4c33380c7c566@mail.gmail.com>
Subject: Device is not discoverable while it is doing an inquiry
From: =?ISO-8859-1?Q?Jos=E9_Ignacio_Gisbert_Sanus?= <jogissa@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all, I have been searching for this problem but till now I have not
found any good solution.
I am using bluez-libs and bluez-utils 3.2, and I have an USB dongle
connected to my PC (Suse 11.0).
If I do not do anything, dongle is discoverable by any way, but while
it is doing an inquiry, it becomes invisible. After inquiry process it
becomes discoverable again.
I have set hciconfig piscan, and inside
/var/lib/bluetooth/XX:XX:XX:XX/config I have mode discoverable and
discovto 0, so I do not know if what I want is feasible or not :-S

I hope you can help me.

Best regards,
jogi
