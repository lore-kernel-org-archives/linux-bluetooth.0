Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: George Karabin <gjkhwl@gmail.com>
Date: Wed, 1 Aug 2018 15:01:42 -0400
Message-ID: <CACEz+owZW84BSguv+RfQgkBZhDd8x2huc4Drx2tYOLiPzB5iVg@mail.gmail.com>
Subject: Calling DBUS ConnectProfile to a non-discoverable but pageable device
 with an invalid link key
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello!

I would like to use the BlueZ 5.x DBUS API to establish a profile
connection to a device that is not discoverable, but is pageable, for
which I do not have a current link key. I don't think that this can be
done using only the DBUS API today. If you call ConnectProfile after
the connection drops the connection will be rejected. If you call
RemoveDevice on the Adapter to remove the device and its stale pairing
information, then you no longer have a device object to call
ConnectProfile on.

I can work around this issue by calling RemoveDevice to remove the old
pairing, then using the btmgmt API to establish a pairing to the
non-discoverable device prior to calling ConnectProfile on it. I'd
prefer not to do that if I can avoid it. Instead, I'd rather find a
DBUS solution from bluetoothd.

>From an API point of view, it would seem natural to make the "Paired"
property on a device object readwrite, so that you can remove its
pairing without also removing the device object associated with the
device. I'm sure there are other approaches that would make sense as
well - I don't yet have a handle on the internal data structures and
states that might be impacted by changing that assumption.

I would be willing to try to implement the patch if it didn't sound
like a terrible idea, or if there were a simpler approach. I'd be
happier still if someone could suggest an approach that already works
(using DBUS API only) but I don't think I'll be that lucky.

Thanks!

- Josh Karabin

----

If you are wondering if there's a real use case behind this request, I
apologize for the length of the use case that I'm about to describe,
but I hope that you'll bear with me.

A user of a master headless (no GUI) computer originally started an
operation to find a slave with discovery and established a connection
to the slave with ConnectProfile. After a time that connection was
terminated, and the device goes into a non-discoverable, pageable
mode, optimized for reconnection to the master which already has a
link key. The user put the master down, and gave the slave to someone
else.

The slave was put into a discoverable mode by the new user, who then
used another master headless computer to connect to the slave, which
deleted the link key from the first master. After a time the second
master dropped its connection, and the device stays in a
non-discoverable, pageable state, optimized for reconnection from the
second headless computer.

Later, another user picks up the first master would like to connect,
but it cannot do so with its current link key. If I call the DBUS
RemoveDevice API, I can delete the link key but then I no longer have
a Device object to call ConnectProfile on. I have not found a DBUS API
to remove the link key without also removing the slave device. Since
the slave device is not discoverable at this point in time, the first
master cannot re-establish a connection.

Usability testing proved that this was a problem. Users had a hard
time remembering to put the slave device into a discoverable mode at
this point. If they did, what often happened is that a third headless
computer some distance away discovered the device and connected to it.
The solution (for our non-BlueZ/DBUS master computers) has been to
allow the master computers to connect to a profile directly to the
known device address from a previous session, bypassing inquiry and
going straight to paging.

The slave devices are in the field, and management doesn't want to
change their firmware to change their behavior as part of the process
of selling replacement computers running BlueZ. I'll probably
implement the workaround unless I can find a clean DBUS-only approach.

If you made it this far, thanks again!
