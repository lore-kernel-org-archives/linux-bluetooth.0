Return-Path: <cyrus@holtmann.org>
Subject: Re: Kernel Oops: btusb: 4.2rc1 System lockup with BT dongle insert -
 log attached
To: <simon@mungewell.org>
References: <a48f30f621c508955ba989117690fe73.squirrel@mungewell.org>
 <dcf4c0f809904c54f453fe781e30adfe.squirrel@mungewell.org>
 <8297c42b69d89cb9326b938a9adaa997.squirrel@mungewell.org>
 <913a160c809900ee52e7c83350b4162f.squirrel@mungewell.org>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Kim, Milo" <milo.kim@ti.com>
Message-ID: <55A8AA15.2050802@ti.com>
Date: Fri, 17 Jul 2015 16:09:09 +0900
MIME-Version: 1.0
In-Reply-To: <913a160c809900ee52e7c83350b4162f.squirrel@mungewell.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Simon,

On 7/17/2015 3:14 PM, simon@mungewell.org wrote:
>
>> It looks like the firmware 'opt_flags' must be different, so this may be a
>> contributing factor.
>
> Plot thickens.... kernel config has changed since I built 4.1.0rc7, but I
> don't recall doing it or starting a fresh.
>
> /boot/config-4.1.0-rc7+
> --
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> CONFIG_FW_LOADER=y
> CONFIG_FIRMWARE_IN_KERNEL=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> CONFIG_WANT_DEV_COREDUMP=y
> CONFIG_ALLOW_DEV_COREDUMP=y
> CONFIG_DEV_COREDUMP=y
> --
>
> /boot/config-4.2.0-rc1+
> --
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> CONFIG_FW_LOADER=y
> CONFIG_FIRMWARE_IN_KERNEL=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y   <------------!!!
> CONFIG_WANT_DEV_COREDUMP=y
> CONFIG_ALLOW_DEV_COREDUMP=y
> CONFIG_DEV_COREDUMP=y
> --
>
>
> Has a kconfig forced a change?.... Grrr
> --
> $ git blame ./drivers/leds/Kconfig
> --
> c93d08fa7 (Milo(Woogyom) Kim         2013-02-05 18:01:23 +0900 228) config
> LEDS_LP55XX_COMMON
> 33b3a561f (Kim, Milo                 2013-07-09 02:11:37 -0700 229)
> tristate "Common Driver for TI/National LP5521/5523/55231/5562/8501"
> 33b3a561f (Kim, Milo                 2013-07-09 02:11:37 -0700 230)
> depends on LEDS_LP5521 || LEDS_LP5523 || LEDS_LP5562 || LEDS_LP8501
> 10c06d178 (Milo(Woogyom) Kim         2013-02-05 19:17:20 +0900 231)
> select FW_LOADER
> b67893206 (Milo Kim                  2015-06-28 17:39:14 -0700 232)
> select FW_LOADER_USER_HELPER_FALLBACK
> <-----!!!!
> c93d08fa7 (Milo(Woogyom) Kim         2013-02-05 18:01:23 +0900 233)     help
> 33b3a561f (Kim, Milo                 2013-07-09 02:11:37 -0700 234)
> This option supports common operations for LP5521/5523/55231/5562/8501
> c93d08fa7 (Milo(Woogyom) Kim         2013-02-05 18:01:23 +0900 235)
> devices.
> --
>
> So in summary this problem is showing up now as the 'User Helper Fallback'
> is now forced on, obviously the underlying problem needs to be fixed - but
> I don't know when it crept in.
>

The 'CONFIG_FW_LOADER_USER_HELPER_FALLBACK' enables to load firmware 
data manually by accessing /sys/class/firmware/<name>/data. It runs in 
case the firmware file is missing.
This user helper fallback will be enabled if one of LP55xx driver is 
included in your dot config. Please see my patch below.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/leds?id=b67893206fc0a0e8af87130e67f3d8ae553fc87c

However, I'm not sure why this affects your system lockup. Can I have 
more details?

Best regards,
Milo
