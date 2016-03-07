Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Sven Harmstorf <sven.harmstorf@numberfour.eu>
Content-Type: text/plain; charset=utf-8
Subject: BlueZ 5.37 experimental D-Bus GattCharacteristic1.WriteValue results in BT_ATT_ERROR_UNLIKELY
Message-Id: <B1E75638-E1BA-4E30-88CE-9E6FBC6BCE1F@numberfour.eu>
Date: Mon, 7 Mar 2016 18:50:12 +0100
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am running BlueZ 5.37 on Linux kernel 4.1.6 with an Atheros AR3012 adapter configured to advertise a service using the experimental D-Bus GATT API on a Freescale i.MX6 Quad (ARMv7l).

The advertising is working fine (verified this via Nordic’s Android App 'nRF Master Control Panel‘).
Connecting and discovering services/characteristics is also working without any issues.

One of the characteristics has the property "flags" set to ["write-without-response“, "notify“].
Centrals should write their data quickly without the need to wait for a response (accepting the potential data loss) and get value changes only via notification. Explicit read is not supported.

When a central sends multiple writes of 1-20 bytes in a row, only the first write succeeds. Any following writes fail in src/shared/gatt-server.c:786. As a result of this, only a few writes happen to be sent as a signal on the D-Bus.

As an experiment I replaced the lines 786-789 with these:

    if (server->pending_write_op) {
        op = server->pending_write_op;
    }
    else {
        op = new0(struct async_write_op, 1);
        op->server = server;
        op->opcode = opcode;
        server->pending_write_op = op;
    }

My intention is to make use of the pending writes queue, used in gatt-db.c::gatt_db_attribute_write().

Running the bluetoothd with the modified code as described above, all writes result in signals on the D-Bus.

Due to my very limited knowledge of the BlueZ code, I kindly ask you to explain the reason behind current gatt-server::write_cb() behavior in this case.

Note:
- The same GATT service configuration works fine using Apple CoreBluetooth (no matter if iOS or OS X), therefore I assume a misusage on my side of the BlueZ D-Bus API.
- Running a guest VM on a host Intel Core i7 does not show any issues. Using a ARMv7 machine (Freescale i.MX6 Quad) result in BT_ATT_ERROR_UNLIKELY as described.

Thank you in advance!

Best regards,
Sven