Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 3 Apr 2014 14:48:49 -0700
Message-ID: <CAHZ1yCmu26xibOaeGUP3HGhp7cvC0eXuviJBRq2VDD0fE6U6SQ@mail.gmail.com>
Subject: BUG: org.bluez.Device1.Connect() makes a BR/EDR connection to an
 LE-only Device on initial pairing
From: Scott James Remnant <keybuk@google.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The D-Bus API sequence for pairing a BR/EDR device is

  org.bluez.Device1.Pair()
  org.bluez.Device1.Connect()

The connect call is necessary after pairing successfully completes to
connect profiles, since a completed pairing does not do that
implicitly.

When this same sequence is used for an LE device, the Connect() call
fails with a Page Timeout. This is because of:

  a9f523e core: Split LE and BR/EDR states for devices

For LE devices there is only one "profile" connection to be made, ATT,
which is already established as part of the call to Pair() in order to
perform primary service discovery. And unlike the BR/EDR case, where
the ACL connection is dropped after a few seconds, the ATT connection
is then made available to other plugins (such as HoG).

Of course, the UI doesn't know this, the D-Bus API doesn't reveal that
this is really an LE device, so the UI makes the Connect() call to the
already connected device. Because of that CL, this then attempts to
bring up the BR/EDR bearer - and thus results in the Connect() call
failing because the device doesn't have one.

Scott
-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
