Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGd9gwjaECWWRE+Ux4XenbUO9L-QSsjnP6wLHEvH5q3sasWWkg@mail.gmail.com>
References: <CAGd9gwjaECWWRE+Ux4XenbUO9L-QSsjnP6wLHEvH5q3sasWWkg@mail.gmail.com>
From: Alex Deymo <deymo@chromium.org>
Date: Fri, 3 May 2013 18:14:53 -0700
Message-ID: <CAGd9gwj=79xKJ0Mdb1eb+a5MDGtG1a3BcC8utfDad1ZLzhfd5A@mail.gmail.com>
Subject: Fwd: Short names on Extended Inquiry Result
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi again!

I'm having a problem while comparing the BlueZ 5 and BlueZ 4 behavior
regarding the name/alias of a device during scanning.

On BlueZ 4 (at least on 4.99), there was a two steps discovery
process. During the first 10 seconds, the adapter will look for new
devices, and during the second 30 seconds, it will ask each device for
further information.

I have here devices like the Monster ClarityHD speakers, or the
Creative WP-350 headsets. Those devices announce a short name with the
Inquiry Result. btmon reveals a "HCI Event: Extended Inquiry Result"
for each one with a short name of 9 chars, respectively "Monster C"
and "Creative " (with a space at the end).

BlueZ 4 will show this name during the first 10 seconds as the name of
the device, but when the adapter goes to the second step, it will
issue a "HCI Command: Remote Name Request" and get the full name, like
"Creative WP-350 Headset" and update the property on the device, still
during discovery.

In the other hand, BlueZ 5 will not issue a "Remote Name Request"
until you attempt a pairing. This is not the best user experience
since no matter how long you leave your scan session on, you will
never get the right name of the device, until you attempt a connection
or a pairing with it.

Even worse, if you had connected to the device before (and you have
the long name in the bluez cache for example), if you scan for new
devices and this device shows up in that scan, bluez will change the
name to the short version.

I'm thinking about sending a Remote Name Request to the new devices
between the "> HCI Event: Inquiry Complete" and the "< HCI Command:
Inquiry". What do you think about this approach? Do you have a better
idea to solve this?

Thanks,
Alex.
