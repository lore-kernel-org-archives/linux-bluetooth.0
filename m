Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: Handling EBUSY for LE connections.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25TMxuHY3hqQQFWe+=5ghzc5rrEG2ED5sa410ddiJ-YuDA@mail.gmail.com>
Date: Thu, 13 Nov 2014 13:41:36 +0900
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Jakub Pawlowski <jpawlowski@google.com>
Message-Id: <50181A20-3313-48C7-924B-05C67B975139@holtmann.org>
References: <CAHrH25TMxuHY3hqQQFWe+=5ghzc5rrEG2ED5sa410ddiJ-YuDA@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> We have a use case in which multiple LE connection attempts are made
> in rapid succession to a device that frequently rotates its private
> address. The connect call frequently fails with
> "org.bluez.Error.Failed: Device or resource is busy (16)". I tracked
> this down to a line in net/bluetooth/hci_conn.c:hci_connect_le that
> has the following comment before returning -EBUSY:
> 
>    /* Since the controller supports only one LE connection attempt at a
>     * a time, we return -EBUSY if there is any connection attempt running.
>     */
> 
> This is all fine and good, however the org.bluez.Error.Failed error
> name is too generic for an application to determine how to recover
> from this case and it would be nice if there was a way for an
> application to know that it should perhaps try connecting again later,
> especially without having to parse the error message string to make
> sense of things while there can be a clear error name.
> 
> So, would it make sense for bluetoothd to return
> org.bluez.Error.InProgress or even org.bluez.Error.Busy here? Another
> potential solution I had in mind was to have bluetoothd actually queue
> LE connection attempts if one is already pending, or perhaps
> automatically schedule a retry if kernel returns EBUSY.
> 
> What do you think is the best solution here?

we should fix that directly in the kernel. Back in the days we had a similar issue with BR/EDR and some more "dumb" controllers. We queued the connection attempt in the kernel and issued it whenever the controller was free again.

One other thing that we should be doing for "direct" LE connection attempts is to run them through the LE passive background scanning. That way we have the same connection logic handling the background scanning and the connection attempts.

Mainly I am thinking that if we have a L2CAP connect() request, we just add it to the LE passive background scanning. The only difference would be that these can actually time out. Otherwise it should be exactly the same.

Regards

Marcel

