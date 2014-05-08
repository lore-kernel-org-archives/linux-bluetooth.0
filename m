Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 May 2014 10:36:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] input: Add userspace HID support
Message-ID: <20140508073646.GA14385@t440s.lan>
References: <20140506004501.318D810193E@puck.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140506004501.318D810193E@puck.mtv.corp.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Mon, May 05, 2014, Petri Gynther wrote:
> Enable HID protocol handling in userspace when UserspaceHID=true in input.conf.
> 
> Benefits of userspace HID:
> 1. Persistent HID/input pipeline
>    For a Bluetooth HID device, the corresponding kernel HID/input devices are
>    created only once when the Bluetooth HID device is used the first time.
>    The HID/input pipeline is not destroyed and recreated every time when
>    the Bluetooth HID device disconnects and reconnects.
> 
> 2. HID vs HoG parity
>    Enables HID and HoG devices to operate the same way in BlueZ stack, using
>    uHID kernel module (/dev/uhid) to pass HID report data between bluetoothd
>    and kernel HID subsystem.
> 
> 3. Debugging
>    It is easier to debug HID protocol in userspace than in HIDP kernel module.
> ---
>  Makefile.plugins           |   3 +-
>  profiles/input/device.c    | 674 +++++++++++++++++++++++++++++++++++++++++++--
>  profiles/input/device.h    |   1 +
>  profiles/input/hidp_defs.h |  79 ++++++
>  profiles/input/input.conf  |   4 +
>  profiles/input/manager.c   |  10 +
>  6 files changed, 754 insertions(+), 17 deletions(-)
>  create mode 100644 profiles/input/hidp_defs.h

Considering that we're using uhid also for the Android HID solution
(see android/hidhost.c) is there an opportunity here to avoid code
duplication by sharing some code? I'm not saying that this must be done
before we apply your patch, but if code sharing is possible it'd be good
to try to refactor common parts into src/shared/hid.c or similar.

Johan
