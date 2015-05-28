Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 28 May 2015 13:44:47 -0700
Message-ID: <CAD0=r8wfL1TYghMk2wHYrZFZ9D=sz49_1fNPVsPvgqOUVdbuCQ@mail.gmail.com>
Subject: [RFC] Add new method to DBus API: DiscoverServiceByUUID
From: Jakub Pawlowski <jpawlowski@google.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently, calling org.bluez.Device1.Connect() on a new, never
connected before device, would cause automatic discovery of all
services.

This is bad in some cases, because discovering all available services
might take a long time. Additionally some devices, i.e. iPhone have
built-in 0.5s delay between each "Find Information Response" packet,
which make discovery even longer.


I would like to propose following change:

1. Calling org.bluez.Device1.Connect() would work just like now,
except no "Find Information Request" would be issued (that means no
call to "device_browse_gatt").

2. Add two new methods: org.bluez.Device1.DiscoverServices(), and
org.bluez.Device1.DiscoverServiceByUUID(uuid). First one would just
call device_browse_gatt and make "Find Information Request" , the
second one would issue "Find By Type Value Request" to find just one
service.
