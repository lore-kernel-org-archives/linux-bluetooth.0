Return-Path: <cyrus@holtmann.org>
Message-ID: <54F752D8.1000605@ubnt.com>
Date: Wed, 04 Mar 2015 20:45:44 +0200
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	marcin.kraglak@tieto.com, szymon.janc@tieto.com
Subject: Non-consecutive handle values in GATT
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

     I'm experimenting with an LE peripheral device which provides GATT 
services described by attributes with non-consecutive handle values, 
i.e. there are "gaps" between handle values. According to the Bluetooth 
Core specification 4.0 (Volume 3, Part G, "2.5.1 Overview") it is allowed:

      Although the Attribute Handle values are in increasing order, 
following Attribute Handle values may differ by more than one.

     Based on my experiments, BlueZ 5.28 and also git-master as of today 
does not support non-consecutive handle values GATT table. As a result, 
I can't connect to my device because gatt-client fails to initialize 
properly. The failing place is in discover_descs():

       if (gatt_db_attribute_get_handle(attr) !=
                             chrc_data->value_handle)
             goto failed;

     The value of chrc_data->value_handle is correct and matches GATT 
table one the device, but the attr->handle has the value of previous 
attribute (Primary Service UUID in my case) +2. This handle value 
calculation happens in gatt_db_service_add_characteristic() which has 
strange code:

     /* We set handle of characteristic value, which will be added next */
     put_le16(get_handle_at_index(service, i - 1) + 2, &value[1]);

     Before trying to fix the problem by myself it would be great to 
hear some comments about this issue. Does it seem like a bug or I missed 
something?

     As a note, I can successfully connect to my LE peripheral from an 
iPhone LightBlue app, which does not posses any issues during GATT 
discovery and can read/write the characteristic on the device.


BR, Andrey
