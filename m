Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 27 Jul 2011 10:49:03 -0500
Message-ID: <CABUK1ahn-HxWWwaqO=eeYUvLoJcBRLeg1Z+sPikRTbg=zimYWQ@mail.gmail.com>
Subject: can adapters have a say in automatic setup procedure?
From: Pavan Savoy <pavan_savoy@sify.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan,

The patch mentioned below seem to power on the adapters for before
they are being actually used and the user-space bluetoothd exists.
I am not sure in what situations or what sort of adapters would
require such information to be available before-hand, even before the
adapter is intended to be used.


However, what I would really like is the adapters to have say in this.
I do-not want my bluetooth device to be accessed before the bluetooth
user-space exists, Because I would require to do a bunch of
initialization upon hdev->open of my interface, which I don't want to
go thru' just to provide information.

So please suggest on this....

commit ab81cbf99c881ca2b9a83682a8722fc84b2483d2
Author: Johan Hedberg <johan.hedberg@nokia.com>
Date:   Wed Dec 15 13:53:18 2010 +0200

    Bluetooth: Implement automatic setup procedure for local adapters

    This patch implements automatic initialization of basic information
    about newly registered Bluetooth adapters. E.g. the address and features
    are always needed so it makes sense for the kernel to automatically
    power on adapters and read this information. A new HCI_SETUP flag is
    added to track this state.
