Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Steven Walter <stevenrwalter@gmail.com>
Date: Wed, 3 Dec 2014 10:54:03 -0500
Message-ID: <CAK8d-aLtkB1RKm+HP92x45D7csVpPNHj--4SsOPG3aAcx9sj0Q@mail.gmail.com>
Subject: [PATCH BlueZ 0/5] src/gatt-dbus: use gatt-db
To: linux-bluetooth@vger.kernel.org
Cc: armansito@chromium.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series of patches updates gatt-dbus.c to use the new gatt-db
implementation.  It also modifies btgatt-server to publish the
GattManager1 D-Bus service.

-- 
-Steven Walter <stevenrwalter@gmail.com>
