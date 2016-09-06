Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Marco Trapanese <marcotrapanese@gmail.com>
Subject: BLE disconnects after BT pairing failed
Message-ID: <92fef3ec-799a-ada8-2af5-fd0d55bdf099@gmail.com>
Date: Tue, 6 Sep 2016 16:26:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Linux Raspbian Jessie Lite, Bluez 5.40. I have a GATT server and my own 
agent for incoming "standard" bluetooth connections (i.e. A2DP).

I can successfully "connect" to the GATT server, but if the user doesn't 
accept the pairing confirmation (from the BT) I receive this error:

    qt.bluetooth.bluez: Failed to create pairing
    "org.freedesktop.DBus.Error.NoReply"

as expected, but after a couple of seconds also the BLE connection will 
drop. I wonder if it's the correct behavior. I thought the BLE and BT 
connections are indipendent each other.


Best refards!
Marco

