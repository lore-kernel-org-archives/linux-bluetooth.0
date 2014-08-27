Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com
Subject: Query Regarding new Gatt server attribute database
Date: Wed, 27 Aug 2014 20:52:50 +0530
Message-id: <015d01cfc20a$c9160a00$5b421e00$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

We are working on Gatt server implementation, for Tizen framework with BlueZ
5.20 as base.

We have few query on adding new service info to gatt attrib server database,
so that remote gatt client can discover the same.

On Calling "RegisterService" method to org.bluez.GattManager1, after getting
proper data from GattService1, GattCharacteristic1 and GattDescriptor1
interface,
It calls, btd_gatt_add_service(),btd_gatt_add_char() and btd_gatt_add_desc
respectively and updates the local_attribute_db. 
Which should be read and updated, when remote gatt client connects and
starts primary services discovery, but this does not happen, instead it
reads from attrib server db in attrib-server.c.

How can the local_attribute_db in gatt.c, be attached to ATT IO channel, as
it has been done for attrib-server db in src/attrib-server.c?

Thanks
Best Regards,
Bharat

