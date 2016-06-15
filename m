Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: "complex" Bluetooth handling
To: "Ben-melech, Shiran" <shiran.ben-melech@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <c290d35f-1637-1199-11a2-e2424262b175@gmail.com>
 <A4D30064D9E2C94BAAF5CE9449A29AAC4B864E3F@hasmsx109.ger.corp.intel.com>
From: Marco Trapanese <marcotrapanese@gmail.com>
Message-ID: <4eaaac10-30a0-2483-8235-99e9c5d993cc@gmail.com>
Date: Wed, 15 Jun 2016 09:20:26 +0200
MIME-Version: 1.0
In-Reply-To: <A4D30064D9E2C94BAAF5CE9449A29AAC4B864E3F@hasmsx109.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Il 15/06/2016 08:54, Ben-melech, Shiran ha scritto:
> For BLE there is a library called TinyB which is pure c++ https://github.com/intel-iot-devkit/tinyb
> Although I'm not sure it support classic BL profiles but I guess you can start with that.

Thanks, it's interesting but I think it's just a guide to make my own 
library because it doesn't support GATT server yet:

> At this time it is not possible to create a BLE server

(from https://github.com/intel-iot-devkit/tinyb/issues/16)

I found an example in Qt5:

https://doc-snapshots.qt.io/qt5-dev/qtbluetooth-heartrate-server-example.html

I will try it as soon as possible.
If it works only ANCS is still uncovered.

Best regards
Marco



