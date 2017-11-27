Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Ayke van Laethem <ayke@aykevl.nl>
Date: Mon, 27 Nov 2017 21:13:37 +0100
Message-ID: <CAHZoaj57_9QKDmuzjcS35tgHnTSYYNagAOKcAMdxueesVnocuA@mail.gmail.com>
Subject: WriteValue succeeds without error when the connection breaks
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I have an application (acting as BLE central device) which connects to
a peripheral. The application does a write (using WriteValue) which
causes a reset in the peripheral, thus breaking the connection.
Strangely, the WriteValue command returns without exception, even
though it takes a few seconds until it hits a timeout. A second
WriteValue will return an error ("Not connected").

The sequence:

(connection is set up)
central: sends a message to the peripheral (WriteValue)
peripheral: receives message
peripheral: resets, starts to advertise again
central: waits a few seconds for a response which it never gets
central: timeout, WriteValue returns without error

I would expect it to generate some sort of error, something like "lost
connection".
A workaround is checking whether the device is still connected after a
WriteValue command, which I've implemented in [1].

I have tested this on BlueZ 5.43 (Debian). I have checked all commits
to src/gatt-client.c but could not find any commit that could fix this
issue, so I believe it is still present. If necessary, I can try
compiling the latest release from source but haven't done this before.

What I'm testing is a BLE NUS console [2] running on a
Bluetooth-enabled laptop which communicates with a Nordic chip running
MicroPython [3]. Pressing Ctrl-D in the console will cause the device
to reset, and the WriteValue is never acknowledged by the Nordic chip.
The result (without workaround) is that the connection appears to
still exist while it is actually broken, until the next char is sent
(which returns a "not connected" error).

I can provide logs (how?) and minimal sample code if needed.

[1]: https://github.com/aykevl/pynus/blob/master/tealblue.py#L224
[2]: https://github.com/aykevl/pynus/blob/master/pynus.py
[3]: https://github.com/tralamazza/micropython

Ayke van Laethem
