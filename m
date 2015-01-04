Return-Path: <cyrus@holtmann.org>
Message-ID: <54A956DC.2050100@cschramm.eu>
Date: Sun, 04 Jan 2015 16:06:04 +0100
From: Christopher Schramm <blueman@cschramm.eu>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: blueman@ml.mate-desktop.org
Content-Type: text/plain; charset=utf-8
Subject: Services connected in BlueZ 5
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

I'm maintaining blueman, a DE-independent bluetooth manager. It was
orphaned for some time, keeping it with deprecated APIs, e.g. BlueZ and
NetworkManager. Together with a handful of awesome contributors we
revived the development and are bringing blueman back to most distributions.

We finally need to finish the migration to BlueZ 5 and I'm a little
stuck with the services. The original blueman code heavily relied on the
dbus Interfaces provided by BlueZ 4 for serial, network, input, and
audio services. Those parts are ported to abstract service classes now
which detect services based on UUIDs (here's the commit [1] for those
curious; note we're currently supporting both BlueZ 4 and 5 for one
major version (2.0) of blueman).

I know there are basically two ways to connect to services in BlueZ 5:
Device.Connect and Device.ConnectProfile.

I really like the idea of listing all services available and supported
and let the user connect to specific ones. The problem with this is I
did not find a way to detect if a given service is connected or not. So
I switched back to the generic Device.Connect method [2]. I think this
method and the Device.Connected property are pretty awkward, since not
all services are handled. E.g. from my experience a NAP service does not
get connected by Device.Connect, but if you connect the specific NAP
service Device.Connected gets set. Neither we as developers, nor the
users seem to have an indicator for which services are actually
connected and which are not.

I also experienced issues with Device.Connect for my test devices: If I
call it on one of my Android devices which provides some audio service I
get "No such file or directory". If I call it on a Logitech mouse I get
"Input/output error". I can only connect to them right after pairing
sometimes. These problems did not show up in BlueZ 4 and I think it was
much better when testing with Device.ConnectProfile.

So, is there any way to determine a specific service's connection state
in BlueZ 5? If not, ConnectProfile / DisconnectProfile seem pretty
useless, since one is left in the dark, so the only valid way would be
using Connect and hope all services desired by the user get connected
which is pretty unsatisfying. Can you confirm the awkward behavior of
Device.Connect and Device.Connected e.g. in conjunction with a network
service?

I appreciate any help and feedback. If you're curious, please take a
look at our BlueZ 5 ticket [3] and feel free to contribute.

Regards
Christopher Schramm

[1]
https://github.com/blueman-project/blueman/commit/ad8aaf5253546b697115d64ab06a1575ec9ac1e6
[2]
https://github.com/blueman-project/blueman/commit/e03f1ab3eac396df813a0161529a6c3823d5ccb4
[3]
https://github.com/blueman-project/blueman/issues/13#issuecomment-59015346
