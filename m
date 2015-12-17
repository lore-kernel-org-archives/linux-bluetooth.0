Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 17 Dec 2015 12:55:25 +0000
Message-ID: <CAOS+5GFM6trQP9o+YrsnZVoy2-KEvYxWRNr074OoXQAsTDd8fQ@mail.gmail.com>
Subject: Multiple dongles...how to prioritise
From: Another Sillyname <anothersname@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Firstly can I apologise if this is meant purely as a developer list,
the bluez website directs end users to this list as the place for
help.

I have a PC with an inbuilt Intel AC7260 combo wifi/BT card.  This
card will NOT support the HID profile and appears as hci0.

I want to use my BT keyboard and mouse on a multi boot machine and
have spent the last few days getting this working across different OS
boots.

However now adding a DBT-120 dongle flashed to HID firmware works fine
once linux loads and I logon.....however I cannot enter the password
to the logon screen unless I remote to the box and hciconfig hci1 up,
I realise I could script this but would rather the DBT-120 was hci0 so
it would happen by default.

Is there a way to 'force' dongles to load in a specific order?

Thanks in advance

Tony
