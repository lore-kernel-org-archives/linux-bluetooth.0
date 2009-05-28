Return-Path: <cyrus@holtmann.org>
Subject: Wacom Graphire Bluetooth HID driver - help needed
From: =?UTF-8?Q?Przemys=C5=82aw?= Firszt <przemo@firszt.eu>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain
Date: Thu, 28 May 2009 21:43:33 +0100
Message-Id: <1243543413.21667.23.camel@pldmachine>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I'm working on Wacom Graphire bluetooth tablet driver. It's a HID driver
and it's almost ready to be released, but I still have some problems.
The main one is that the tablet works in mouse mode and I need to send a
control message to switch to tablet mode. Currently I'm using an ugly
hack in /net/bluetooth/hidp/core.c - hidp_add_connection:


        rep_data [0] = 0x03; rep_data [1] = 0x00;
        hidp_send_ctrl_message(session,
                       HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE,
rep_data, 2);
        /* 0x06 - high reporting speed, 0x05 - low speed */
        rep_data [0] = 0x05; rep_data [1] = 0x00;
       hidp_send_ctrl_message(session,
                       HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE,
rep_data, 2);

That hack is based on wacom graphire bluetooth driver created by Andrew
Zabolotny, that driver has never neen mainstreamed, beacause of some
philosophy issues (as far as I understand it)

Any ideas how I can send the control message from HID driver level? Is
it possible?
--
Przemo Firszt


 
 

