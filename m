Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1382004486-24512-1-git-send-email-szymon.janc@tieto.com>
References: <1382004486-24512-1-git-send-email-szymon.janc@tieto.com>
Date: Thu, 17 Oct 2013 17:37:27 +0300
Message-ID: <CABBYNZLiTQCncGgWB0iDUwMtFRzzeOkDvNeA0N8ZnwoBhbxNGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] android: Import Android HAL headers
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Oct 17, 2013 at 1:08 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> This imports BT HAL headers as of tag android-4.3_r3.1 from
> https://android.googlesource.com/platform/hardware/libhardware
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
>  android/hardware/hardware.h       | 230 +++++++++++++++++++
>  13 files changed, 2312 insertions(+)
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

Pushed, thanks.
