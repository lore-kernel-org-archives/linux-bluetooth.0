Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Oct 2013 12:05:29 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Szymon Janc <szymon.janc@gmail.com>
Subject: Re: [RFC 1/8] android: Import Android HAL headers
Message-ID: <20131017090527.GR2861@aemeltch-MOBL1>
References: <1381999629-9589-1-git-send-email-szymon.janc@tieto.com>
 <1381999629-9589-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381999629-9589-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Oct 17, 2013 at 10:47:02AM +0200, Szymon Janc wrote:
> From: Szymon Janc <szymon.janc@gmail.com>
> 
> This imports BT HAL headers as of tag android-4.3_r3.1 from
> https://android.googlesource.com/platform/hardware/libhardware
> 
> Only changes made compared to original files are trailing whitespace
> cleanup to keep git happy and commenting out includes of
> cutils/native_handle.h and system/graphics.h from hardware.h which are
> not present on Linux.
> 
> Those files are needed for building HAL library and haltester tool on
> Linux.
> ---
>  android/hardware/bluetooth.h      | 468 ++++++++++++++++++++++++++++++++++++++
>  android/hardware/bt_av.h          |  90 ++++++++
>  android/hardware/bt_gatt.h        |  61 +++++
>  android/hardware/bt_gatt_client.h | 275 ++++++++++++++++++++++
>  android/hardware/bt_gatt_server.h | 175 ++++++++++++++
>  android/hardware/bt_gatt_types.h  |  48 ++++
>  android/hardware/bt_hf.h          | 284 +++++++++++++++++++++++
>  android/hardware/bt_hh.h          | 179 +++++++++++++++
>  android/hardware/bt_hl.h          | 123 ++++++++++
>  android/hardware/bt_pan.h         |  87 +++++++
>  android/hardware/bt_rc.h          | 234 +++++++++++++++++++
>  android/hardware/bt_sock.h        |  58 +++++
>  android/hardware/hardware.h       | 232 +++++++++++++++++++
>  13 files changed, 2314 insertions(+)
>  create mode 100644 android/hardware/bluetooth.h
>  create mode 100644 android/hardware/bt_av.h
>  create mode 100644 android/hardware/bt_gatt.h
>  create mode 100644 android/hardware/bt_gatt_client.h
>  create mode 100644 android/hardware/bt_gatt_server.h
>  create mode 100644 android/hardware/bt_gatt_types.h
>  create mode 100644 android/hardware/bt_hf.h
>  create mode 100644 android/hardware/bt_hh.h
>  create mode 100644 android/hardware/bt_hl.h
>  create mode 100644 android/hardware/bt_pan.h
>  create mode 100644 android/hardware/bt_rc.h
>  create mode 100644 android/hardware/bt_sock.h
>  create mode 100644 android/hardware/hardware.h

That android/hardware does not sound good to me maybe 
android/include/hardware ? It might be so that we would need to import
some other library; then we put it also to android/include.

But let's maintainers decide this.

Best regards 
Andrei Emeltchenko 

