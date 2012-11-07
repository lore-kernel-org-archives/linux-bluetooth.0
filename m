Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 7 Nov 2012 17:20:46 -0200
Message-ID: <CAMOw1v5q7eP2O4h6KtKNv0himHKA4pmg9STrxUczL_frYgECZA@mail.gmail.com>
Subject: DBus.Properties: help for remaining convertions
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey!

I stopped converting profiles to DBus.Properties due to some reasons
like 1) lack of time; 2) I don't use or can't test the conversion or
3) I'm seeing a lots of patches to that profile and my changes would
conflict.


Here is a list of missing profiles (except audio):
└ bluez ➤ git grep -l GetProperties | grep -e " | grep -v -e "^audio"
attrib/client.c
profiles/cups/main.c
profiles/network/connection.c
profiles/proximity/monitor.c
profiles/proximity/reporter.c
profiles/thermometer/thermometer.c


Most of them are trivial and mostly a manual conversion job. These
fall in categories (1) and (2) above. If no one interested in that
profiles does the conversion,  I'll try my best to convert them, but
I'd like they to at least check/ack the changes.

And the audio ones, in category (1) and (3) above:

└ bluez ➤ git grep -l GetProperties | grep -e " | grep -v -e "^audio"
audio/device.c
audio/gateway.c
audio/gstavdtpsink.c
audio/headset.c
audio/player.c
audio/sink.c
audio/source.c
audio/telephony-ofono.c
audio/transport.c


Luiz, do you plan to convert to DBus.Properties after you finish the
pending features you are doing? I think audio/transport.c is the only
one still requiring a feature in gdbus:  security check for the sender
as discussed previously.  I can add this when we are converting audio.


Anyone to step up and help to finish the conversions? The sooner these
are finished, the sooner other projects can adapt themselves to the
upcoming API.


Lucas De Marchi
