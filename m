Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1509473455.2869.26.camel@hadess.net>
Subject: Mouse setup and autopair
From: Bastien Nocera <hadess@hadess.net>
To: Scott James Remnant <keybuk@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 31 Oct 2017 19:10:55 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Scott,

Hopefully this email address still works, and you can answer some
questions about this, or somebody else on the list will be able to
help.

When it comes to pairing mice, and other pointing devices, we have a
few different cases:
- Bluetooth (non-LE) mice shouldn't require pairing, they're put in
connectable mode with a button, and simply connected to. When started,
they'll usually reconnect to the last device that connected to them.
- Apple and Microsoft (non-LE) mice did require pairing with the 0000
passkey (that's implemented in the autopair plugin)
- Bluetooth LE mice require pairing, and usually use the 0000 passkey

Is this all correct?

My question now would be how to implement this in bluez and gnome-
bluetooth, and whether LegacyPairing also comes into account.

Should we try to always pair and simply connect to it if that fails,
for mice specifically?

Anything else I might be missing?

Cheers
