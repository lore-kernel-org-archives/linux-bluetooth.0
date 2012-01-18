Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 18 Jan 2012 13:50:16 -0800
Message-ID: <CA+bD78jG+f2kaq66YTdJnOhBGE-=gfeoHYPpmpe6OxZUyBZv7Q@mail.gmail.com>
Subject: RFA: Implementing HID spec recommendation for Keyboard PINs
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth HID profile recommends (4.1, p24) that rather than
prompting the user for a PIN on the host, which then needs to be
entered into the connecting keyboard, instead the host simply generate
the PIN and display it to the user instead. Part of this will be
implemented as a plugin, but since UI is involved, the Agent is
involved as well. As far as I can tell, there are two options:

 1) re-use the existing DisplayPasskey(object device, uint32 passkey) method

    Disadvantages:
    - this isn't a Passkey but a PIN, which means it would have to be
converted to a numeric before display. So the plugin would have to
generate a numeric, stuff it into a 0-padded 6-digit string for return
as the PIN but then we'd have to convert back to a numeric again for
sending to the agent.

    - the agent would not know that this isn't a Bluetooth 2.1 device,
but a 2.0 device following the HID recommendation - agents might want
to format the display differently, e.g. knowing that it will never get
keypress notification for these devices

 2) add a new DisplayPinCode(object device, string pin) method

    Disadvantages:
    - this adds a new method existing agents would have to implement,
but only in the cases where the plugin was enabled so hopefully the
distribution is at least aware of it - otherwise the important step of
what PIN to type would be lost

    - slightly larger code change.


My preference is for #2, but I wanted to request advice before proceeding.

Scott
--
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?
