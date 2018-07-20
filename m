Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <c26a02c4df73953ae486cf207036980f8263d3ae.camel@hadess.net>
Subject: Fixing potential unwanted pairings
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 20 Jul 2018 13:23:26 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

We recently ran into a problem with bluez' Discoverable property, and
its interaction with DiscoverableTimeout:
https://bugzilla.redhat.com/show_bug.cgi?id=1602985

Either through misuse of the API, or a bug in the daemon[1], we might
have ended up with "Discoverable" being turned on[2], and no agent
being running. We expect the GNOME Bluetooth Settings to turn on
Discoverable (thus Pairable) and register an agent when the panel is
opened, and unregister the agent and switch off Discoverable when the
panel is gone.

When no agent is registered and the adapter is Discoverable, the
kernel's policy will make bluetoothd behave like an agent with the "No
Input No Output" IO capability. Some devices will then be able to pair
with the computer running bluetoothd without any confirmation necessary
on the computer side, with an unauthenticated key.

This means that a combination of a hard-to-use API for Discoverable[3],
and the kernel's default policy, will allow devices such as iPhones to
pair without any interaction on the computer/BlueZ side.

This is obviously unwanted in a desktop/laptop use cases.

I talked to Johan about all this, and we came up with a few different
ways to fix this problem:
- Never enable pairable or discoverable mode over mgmt if there's no
agent registered, and immediately disable pairable/discoverable mode if
an agent exits or unregisters itself. This could be a config policy,
making it easy to return errors if that policy was turned on and a
client tried to set it.
or:
- Disable pairable/discoverable by default, add an API for the agent,
or a D-Bus client to be tracked to know the lifetime of the
Pairable/Discoverable on state. This would be an additional API to
either the agent, or the adapter.

I prefer the first one, it makes it easy to avoid Discoverable/Pairable
being turned on without an agent, still allows bluetoothctl to be used
easily, and is easy to disable if the target device is embedded and
doesn't have a UI to show an agent itself.

I'm happy to work on this feature if developers can agree on a course
of action, and on what the API/config should be.

Cheers

[1]: As the D-Bus API here behaves in ways that isn't how D-Bus APIs
usually work, and this behaviour isn't documented, I firmly believe
it's a bluetoothd bug.

[2]: Pairable is turned on by default, and gnome-bluetooth doesn't
touch this setting at all. Its value should only matter if Discoverable
is turned on as well, as far as I understand.

[3]: To explain a bit more about the Discoverable API being hard to
use, it's currently not possible to make sure there are no window with
no agent being available (Settings panel crashed for example) and
Discoverable being off. Using a very short timeout would still leave
that timeout's worth of a window without an agent, and requires setting
Discoverable again, which might confuse remote devices, using 0 means a
crash leaves the adapter Discoverable without an agent.
