Return-Path: <cyrus@holtmann.org>
Date: Sat, 28 Feb 2009 22:03:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bnep networking with bluez-4
Message-ID: <20090228200342.GA19865@jh-x301>
References: <200902282011.48655.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200902282011.48655.alon.barlev@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Feb 28, 2009, Alon Bar-Lev wrote:
> I am sorry I post here, but there is no user mailing list specified at
> [1] while both links at [2] refer to this list. I will appreciate if
> you forward me to the right place.

Nope, as far as I understand this list is intended for both developer
and user issues.

> I try to figure out how to create bnep interface. It looks like one
> should have vast knowledge in dbus

If you're a developer, then yes. If you're a user the interface has already
failed at the point where it requires you to know what "bnep" is :)

As a user, you should ultimately be using some *user* interface (either
graphical or command line) which hides any complexities of the D-Bus
interface. The big fault from the BlueZ project's side is that it hasn't
provided proper command-line user tools for its D-Bus interface. I think
one of the reasons for this is that the existing tools like hcitool and
hciconfig along with the python scripts that come with the source have
been regarded as "good enough".

In the long run we're planing on doing a tool to replace exiting ones
like sdptool, hcitool and hciconfig. However, all that exists of that at
the moment is an empty client directory in the source tree and the
progress of it is simply dependent on developer free time and
motivation.

> and/or python in order to achieve this goal.

Why especially python? There's a plethora of different language bindings
available for D-Bus. You can find a list of them here:
http://www.freedesktop.org/wiki/Software/DBusBindings

> All the examples I found in the wiki [3] are for version 3.

That's right. Almost none of the info in the wiki has been updated since
3.x times. The most reliable 4.x API information are the doc/*-api.txt
files that come with bluez. Again, fixing of this depends completely on
peoples free time and motivation. In the long run the plan is to have
most documentation generated directly from the source tree. GTK-Doc
support is already there so all that's missing now is the content ;)

> Does anyone has a sample without python dependency (shell script) that
> can create bnep interface on both ends for hidden (explicit mac) devices?

I'm not aware of any D-Bus binding for shell languages (like bash).
There's the generic dbus-send command line tool provided by D-Bus but it
won't get you very far with the more complex interfaces. Just out of
curiosity, what kind of system are you using that doesn't have python
available? Some embedded device perhaps? (in which case the border
between a user and developer starts to get quite blurred).

> Alternatively, can anyone please tell me what is the uuid parameter
> for org.bluez::org.bluez.Network::Connect?

That's the Bluetooth UUID of the service you want to use. However the
interface will also accept "friendly" strings such as "nap" and "panu".
Admittedly doc/network-api.txt should be updated to list all of these
possibilities. It's much terse right now.

> Anyway... I think the requirement for people to use dbus is truly
> unusable...

I'll assume you mean "user" when you say "people". You're right of
course. The D-Bus interface was never intended for users. It was created
for developers to build user interfaces and while GUI's are out of scope
for the BlueZ project at least a command-line tool should be available
for users not wanting or being able to deal with GUI's.

> Providing simple solutions/scripts for common tasks is required.

Agreed. Right now for many tasks you can use the legacy command line
tools and even the old daemons like pand if you wish. For the D-Bus
interface there are the python scripts within the source tree and in the
long run we should hopefully have a proper command line user tool for
the D-Bus interface.

Johan
