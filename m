Return-Path: <cyrus@holtmann.org>
Message-ID: <525571E2.50409@redhat.com>
Date: Wed, 09 Oct 2013 17:10:26 +0200
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Possible problem with btusb suspend resume handling
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

While reviewing all users of usb_anchor-s (because of some
usb_anchor fixes I've been writing), I noticed that btusb normally
puts to be transmitted urbs on an anchor called tx_anchor and then
submits them, unless suspended, then they are put on an anchor called
deferred without being submitted.

On resume any urbs on the deferred anchor get removed from the deferred
anchor, and submitted to the device.

But unlike other drivers which similar constructs, btusb does not
move put them on the tx_anchor when submitting then from the resume
handler.

So after a resume with deferred transmits, there will be tx urbs in
flight which are not anchored on the tx_anchor. I believe this is
a bug, but I don't know the code well enough to be sure.

Regards,

Hans
