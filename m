Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 22 Jul 2015 17:20:55 -0600
Message-ID: <CAASrBQ=8icxs8ZyW56CXObZH7DFuPf0XDGz=uQPXB1SsQsuimw@mail.gmail.com>
Subject: bluetoothctl list-attributes command
From: Mark Rages <markrages@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am trying to interact with a low-energy device using bluetoothctl:

$ bluetoothctl
[NEW] Controller 00:02:72:C8:B1:AD qountdown-0 [default]
[NEW] Device F1:4A:78:BD:9C:9F DfuTarg
[bluetooth]# connect F1:4A:78:BD:9C:9F
Attempting to connect to F1:4A:78:BD:9C:9F
[CHG] Device F1:4A:78:BD:9C:9F Connected: yes
Connection successful
[DfuTarg]# info
Device F1:4A:78:BD:9C:9F
    Name: DfuTarg
    Alias: DfuTarg
    Paired: no
    Trusted: no
    Blocked: no
    Connected: yes
    LegacyPairing: no
    UUID: Vendor specific           (00001530-1212-efde-1523-785feabcd123)
    UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
    UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
    RSSI: -57
[DfuTarg]# list-attributes
(hangs forever)

Is list-attributes meant to do something here?

Alternately, can anyone supply an example of select-attribute that
would allow me to interact with an attribute on this device?  I was
hoping the output of "list-attributes" would be the clue I need.
-- 
Regards,
Mark
markrages@gmail
