Return-Path: <cyrus@holtmann.org>
From: "Wan, Shuang" <shuang.wan@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 13 Jul 2009 09:40:17 +0800
Subject: bluetooth-wizard pin fixed at 0000 which is unable to pair with
 headset with other pins
Message-ID: <E2263E4A5B2284449EEBD0AAB751098402CD17452D@PDSMSX501.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Just attempt to pair with a fixed pin device using bluetooth-wizard that doesn't have 0000 as its pin..I have a Gear4-Blackbox Mini (which is a headset/a2dp device) which has a fixed pin of 1234. When I try to pair the device it fails after attempting to use 0000, with no opportunity to enter any other pin.

It might be caused by the hard code in bluez-gnome, see bluez-gnome-1.8 source code wizard/main.c
static gboolean pincode_callback(DBusGMethodInvocation *context,
                                        DBusGProxy *device, gpointer user_data)
{
..............

        /* Most headsets are using 0000 as pincode */
        if (target_type == BLUETOOTH_TYPE_HEADSET ||
                                target_type == BLUETOOTH_TYPE_HEADPHONE)
                pincode = "0000";
...........
}

Anyone has come across this similar issue? Any suggestions?

Thanks!
Wan Shuang

