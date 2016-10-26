Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Ben-melech, Shiran" <shiran.ben-melech@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Identifying Bluetooth Low Energy using sd-bus org.bluez.Device1
 interface
Date: Wed, 26 Oct 2016 11:44:14 +0000
Message-ID: <A4D30064D9E2C94BAAF5CE9449A29AAC4B8F6378@hasmsx109.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have written a small C library to work with BLE devices over sd-bus bluez interface.
Currently to identify if a device I have in list after a scan is a classic or a BLE, I connect and pair to it and check if new service objects were added to the device.
This is relatively a lot of hassle and isn't stable, also forces me to connect and pair the device.

Is there another way, best without even connecting to a device, to identify if it's a BLE device?

I saw that most BLE devices have the 1800, 1801 UUIDs for generic access / generic attribute profiles - but is this on all BLE devices and only on them?

Thank You and Regards,

Shiran
---------------------------------------------------------------------
Intel Electronics Ltd.

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

