Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <735FD32E-BD15-4CE1-8D9C-44B8EC56DF7A@holtmann.org>
References: <CAD0=r8yozB8eMdJOuffUeQZVFVf5xEXnP5tCt+k3m0e9wzMxiA@mail.gmail.com>
	<735FD32E-BD15-4CE1-8D9C-44B8EC56DF7A@holtmann.org>
Date: Tue, 16 Sep 2014 21:52:16 -0700
Message-ID: <CAHrH25Q6XqsLjGyfoXwimrap9=kKHOQn-G=k4Fz6HXmEPJ7EtQ@mail.gmail.com>
Subject: Re: [RFC] need for new scan api for bluetooth low energy.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Scott James Remnant <keybuk@google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> have you looked at the the Add Device management command with the 0x00 Action. That will just send out Device Found events for devices in range and uses passive scanning.
>
> In addition if you are paired with a device and actually want to connect to it, you can use Action 0x02 to allow for background connection. This is currently in use for LE HID devices.
>

This still only sends one Device Found event though right? In Jakub's
case, a mgmt event is desired to let the userspace know every time a
new advertisement packet is received, with the updated RSSI and
TxPower and so on.

I think this ties in with some of the previous conversations on the
list about adding a device scan API that is geared towards
applications (rather than OS UI). That is, not only a mgmt API that
enables these kinds of use cases but also (probably) a high-level API
exposed from bluetoothd that allows applications to scan for devices
filtered by service UUIDs, contents of the manufacturer data field,
and so on.

As for the Add Device command, does bluetoothd currently use this somehow?

Thanks,
Arman
