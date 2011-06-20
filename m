Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 20 Jun 2011 09:35:08 -0300
Message-ID: <BANLkTimHLO1dJYeapKQdTdOTpzfVjKrhdA@mail.gmail.com>
Subject: [RFC] Attribute IO Driver
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

here is the first proposal of the attribute IO  driver to be "flamed".

git://git.infradead.org/users/cktakahasi/bluez.git attio

The "attio" branch contains a new "driver" concept for GATT/ATT based
profiles only. It is at the same "level" of the "device" driver.

* Design requirements:
1. Keep the link up after discover all primary service: avoid re-connections.
2. Easy to extend: we may need to inform profile based connection
requirements such as LSTO and intervals(latency).
3. GAttrib should be shared: if the device implements multiple profiles
4. Profiles(Plugins) NOT based on GATT/ATT should NOT include or have
GAttrib dependency
5. Transports: LE and BR/EDR

Why generic Attribute API is not enough?
Response: There are some profile specific needs: write operation used,
authorization, external data, enable/disable for qualification,
connection parameters. Proximity for example, the user should be able
to set the Threshold level(input for local path loss calculation).

This is the current driver definition:
struct btd_attio_driver {
        const char *name;
        const char **uuids; /* UUIDs of primary services */
        int (*probe) (struct btd_device *device, GSList *uuids);   /*
List of Primary Services: UUID and start/end handles */
        void (*remove) (struct btd_device *device);
        int (*connected) (struct btd_device *device, GAttrib *attrib);
        void (*disconnected) (struct btd_device *device);
};

* Open issues:
1. How to request re-connections. The current code shares the GAtrrib,
I am trying to avoid sharing the GAttrib reference creating a ATT
command queue. The idea is to inform the queue when the device is
probed, allowing offline operations and automatic connection request.
If there is at least one item in the queue the device will be added in
the "automatic" connection list. Using a command queue, it MAY be
possible to remove the "connected" and "disconnected" callbacks.
2. Move attio.c source to device.c?
3. should Generic API be a "built-in" ATT IO driver? (I moved to
plugins/attribute.c), it looks more clean to me. Same "level" of
Service/SDP plugin.
4. Passive scanning: it will be necessary to re-connect

Comments?

Regards,
Claudio.
