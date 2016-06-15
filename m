Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4eaaac10-30a0-2483-8235-99e9c5d993cc@gmail.com>
References: <c290d35f-1637-1199-11a2-e2424262b175@gmail.com>
 <A4D30064D9E2C94BAAF5CE9449A29AAC4B864E3F@hasmsx109.ger.corp.intel.com> <4eaaac10-30a0-2483-8235-99e9c5d993cc@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 15 Jun 2016 10:53:18 +0300
Message-ID: <CABBYNZL-BYpN=fuHfv4vdjeWPGAicn+hveXPFPCngxAwVR8LdA@mail.gmail.com>
Subject: Re: "complex" Bluetooth handling
To: Marco Trapanese <marcotrapanese@gmail.com>
Cc: "Ben-melech, Shiran" <shiran.ben-melech@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marco,

On Wed, Jun 15, 2016 at 10:20 AM, Marco Trapanese
<marcotrapanese@gmail.com> wrote:
> Il 15/06/2016 08:54, Ben-melech, Shiran ha scritto:
>>
>> For BLE there is a library called TinyB which is pure c++
>> https://github.com/intel-iot-devkit/tinyb
>> Although I'm not sure it support classic BL profiles but I guess you can
>> start with that.
>
>
> Thanks, it's interesting but I think it's just a guide to make my own
> library because it doesn't support GATT server yet:
>
>> At this time it is not possible to create a BLE server
>
>
> (from https://github.com/intel-iot-devkit/tinyb/issues/16)
>
> I found an example in Qt5:
>
> https://doc-snapshots.qt.io/qt5-dev/qtbluetooth-heartrate-server-example.html
>
> I will try it as soon as possible.
> If it works only ANCS is still uncovered.

I guess you don't want a mixed topology with both LE/BR, in that case
you will probably need to work in support GATT over BR/EDR properly
since the focus was on LE link. For audio, and media in general, that
have been a lot of work around car IVI systems, so provided you use
the same components (e.g. PulseAudio, oFono) this should work out of
the box.

-- 
Luiz Augusto von Dentz
