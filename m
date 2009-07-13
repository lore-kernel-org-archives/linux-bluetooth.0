Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 13 Jul 2009 06:00:43 +0200
Subject: RE: bluetooth-wizard pin fixed at 0000 which is unable to pair with
 headset with other pins
Message-ID: <6AC5A55546F64545AE996F8200E3AC4E06E31569@NL0105EXC01V01.eur.slb.com>
References: <E2263E4A5B2284449EEBD0AAB751098402CD17452D@PDSMSX501.ccr.corp.intel.com>
In-Reply-To: <E2263E4A5B2284449EEBD0AAB751098402CD17452D@PDSMSX501.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Wan, Shuang
Sent: 13 July, 2009 05:40
To: linux-bluetooth@vger.kernel.org
Subject: bluetooth-wizard pin fixed at 0000 which is unable to pair with headset with other pins

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

--
Does it work with simple-agent?
