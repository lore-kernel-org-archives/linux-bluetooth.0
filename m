Return-Path: <cyrus@holtmann.org>
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: bnep networking with bluez-4
Date: Sat, 28 Feb 2009 20:11:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200902282011.48655.alon.barlev@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hello,

I am sorry I post here, but there is no user mailing list specified at [1] while
both links at [2] refer to this list. I will appreciate if you forward me to the
right place.

I try to figure out how to create bnep interface. It looks like one should have
vast knowledge in dbus and/or python in order to achieve this goal.

All the examples I found in the wiki [3] are for version 3.

Does anyone has a sample without python dependency (shell script) that
can create bnep interface on both ends for hidden (explicit mac) devices?

Alternatively, can anyone please tell me what is the uuid parameter
for org.bluez::org.bluez.Network::Connect?

The only place I see this is in org.bluez::org.bluez.Device::CreateNode,
but it specify that this is persistence object, and I don't want to use
persistence object. Or maybe dbus persistence is not stored between
bus initialization.

Anyway... I think the requirement for people to use dbus is truly
unusable... Providing simple solutions/scripts for common tasks
is required.

Thank you ,
Alon Bar-Lev.

[1] http://www.bluez.org/development/lists/
[2] http://www.bluez.org/contact/
[3] http://wiki.bluez.org/
