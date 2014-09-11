Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
References: <015d01cfc20a$c9160a00$5b421e00$@samsung.com>
In-reply-to: <015d01cfc20a$c9160a00$5b421e00$@samsung.com>
Subject: RE: Query Regarding new Gatt server attribute database
Date: Thu, 11 Sep 2014 11:34:57 +0530
Message-id: <024801cfcd86$58382520$08a86f60$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All, 

Adding one more query to the same.

As there is no update to attrib server db, from gatt-dbus.c, can we reuse
the APIs here to add service, char and desc values to attrib server db?

>From Gatt Application, if it changes its char/descriptor values, how blueZ
will get to know the same, as there is no propertiesChanged watch set in
bluez?

Is there any plan to update, gatt-dbus.c, or all the functionalities are
moving to src/shared/ ??

It will be helpful, if anyone can clear above doubts :)

Thanks
Best Regards,
Bharat 
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Bharat Bhusan Panda
> Sent: Wednesday, August 27, 2014 8:53 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: bharat.panda@samsung.com
> Subject: Query Regarding new Gatt server attribute database
> 
> Hi All,
> 
> We are working on Gatt server implementation, for Tizen framework with
> BlueZ
> 5.20 as base.
> 
> We have few query on adding new service info to gatt attrib server
database,
> so that remote gatt client can discover the same.
> 
> On Calling "RegisterService" method to org.bluez.GattManager1, after
> getting proper data from GattService1, GattCharacteristic1 and
> GattDescriptor1 interface, It calls,
> btd_gatt_add_service(),btd_gatt_add_char() and btd_gatt_add_desc
> respectively and updates the local_attribute_db.
> Which should be read and updated, when remote gatt client connects and
> starts primary services discovery, but this does not happen, instead it
reads
> from attrib server db in attrib-server.c.
> 
> How can the local_attribute_db in gatt.c, be attached to ATT IO channel,
as it
> has been done for attrib-server db in src/attrib-server.c?
> 
> Thanks
> Best Regards,
> Bharat
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

