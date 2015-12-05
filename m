Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: read data from a BLE device using gatt-client
From: jacques klein <jacques.klein@dalim.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 05 Dec 2015 22:21:22 +0100
Message-ID: <1449350482.29155.23.camel@jkn0.kehl.dalim.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am currently writing a small Bluez-5.35 Linux app to interact with a
BLE device.
I used as starting point and example the code in btgatt-client.c and
most things work.

But I have trouble to find out how to implement the "reading of data
sent" by the device after having sent the command "REQUEST_THIS_DATA".
Things are working because I can see the data displayed by the
att_debug_cb function.

# my (added) function
[GATT client]# request-day-prog <device> <day>
[GATT client]# att: ATT op 0x12
[GATT client]# att: < 12 11 04 20
04                                   ... .           
[GATT client]# att: >
13                                               .               
[GATT client]# att: ATT response received: 0x13
[GATT client]# 
Write successful
# displayed by att_debug_cb, it's ok, the bytes make sense.
[GATT client]# att: > 1b 21 04 21 04 22 24 2a 36 22 66 2a 8a 22 90
22  .!.!."$*6"f*."."
[GATT client]# att:   90 22
90                                         .".             
[GATT client]# att: ATT PDU received: 0x1b

what I don't know, is what I have to setup ( call some
bt_att_register_????() ? )
in order for a callback function of my app. to be called.

Any pointer to  example, documentation, or even google search keywords
will be appreciated.
( I don't want to go into DBUS or Python,  just stay with simple C
calling bt_att_... and/or bt_gatt_... functions )


