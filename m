Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Ben-melech, Shiran" <shiran.ben-melech@intel.com>
To: Marco Trapanese <marcotrapanese@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: "complex" Bluetooth handling
Date: Wed, 15 Jun 2016 06:54:06 +0000
Message-ID: <A4D30064D9E2C94BAAF5CE9449A29AAC4B864E3F@hasmsx109.ger.corp.intel.com>
References: <c290d35f-1637-1199-11a2-e2424262b175@gmail.com>
In-Reply-To: <c290d35f-1637-1199-11a2-e2424262b175@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

For BLE there is a library called TinyB which is pure c++ https://github.com/intel-iot-devkit/tinyb
Although I'm not sure it support classic BL profiles but I guess you can start with that.

Good Luck,

Shiran Ben-Melech
SW Engineer @ Flex Services | Intel Corporation
iNet: 8-465-3851 | Cellular: 054-6662594
Website: http://flexservices.intel.com

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Marco Trapanese
Sent: Wednesday, June 15, 2016 08:11
To: linux-bluetooth@vger.kernel.org
Subject: "complex" Bluetooth handling

Hello,

I'm working on an unattended machine (i.e. with no direct user
interaction) which should handle the following Bluetooth features:

- A2DP
- AVRCP
- HFP
- GATT server
- ANCS consumer

all at the same time. I mean, the user might listen to a song and answer to incoming calls, while he's receiving the ANCS notifications and exchanging data through a custom GATT profile.

I have a USB / BT,BLE dongle and I'm using Raspbian Jessie with bluez 5.40.
Right now I'm just trying to make the things work before write a C++ application which manages all the stuff.

First question:

1. I mainly find Python scripts, but I'm interested into Qt5/C++ libraries. Is there something out there? Before write a new one from scratch....

2. Do you know any working example to subscribe to ANCS push notifications?

3. Do you have any suggestion about how to handle all those profile together?

Thanks!
Marco

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
---------------------------------------------------------------------
Intel Electronics Ltd.

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

