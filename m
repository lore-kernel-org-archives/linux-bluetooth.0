Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 12 Nov 2014 20:27:04 -0800
Message-ID: <CAHrH25TMxuHY3hqQQFWe+=5ghzc5rrEG2ED5sa410ddiJ-YuDA@mail.gmail.com>
Subject: Handling EBUSY for LE connections.
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Jakub Pawlowski <jpawlowski@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

We have a use case in which multiple LE connection attempts are made
in rapid succession to a device that frequently rotates its private
address. The connect call frequently fails with
"org.bluez.Error.Failed: Device or resource is busy (16)". I tracked
this down to a line in net/bluetooth/hci_conn.c:hci_connect_le that
has the following comment before returning -EBUSY:

    /* Since the controller supports only one LE connection attempt at a
     * a time, we return -EBUSY if there is any connection attempt running.
     */

This is all fine and good, however the org.bluez.Error.Failed error
name is too generic for an application to determine how to recover
from this case and it would be nice if there was a way for an
application to know that it should perhaps try connecting again later,
especially without having to parse the error message string to make
sense of things while there can be a clear error name.

So, would it make sense for bluetoothd to return
org.bluez.Error.InProgress or even org.bluez.Error.Busy here? Another
potential solution I had in mind was to have bluetoothd actually queue
LE connection attempts if one is already pending, or perhaps
automatically schedule a retry if kernel returns EBUSY.

What do you think is the best solution here?

Thanks,
Arman
