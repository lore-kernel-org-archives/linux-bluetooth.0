Return-Path: <cyrus@holtmann.org>
Message-ID: <1330903638.3392.141.camel@aeonflux>
Subject: Re: [PATCH] bluetooth.h: fix compile issue when using in C++
From: Marcel Holtmann <marcel@holtmann.org>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 04 Mar 2012 15:27:18 -0800
In-Reply-To: <1326708715.3360.135.camel@pohly-mobl1.fritz.box>
References: <1326708715.3360.135.camel@pohly-mobl1.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick,

> The compiler error is:
>  /usr/include/bluetooth/bluetooth.h::131:9: error: invalid conversion from 'void*' to 'bt_get_le64(void*)::<anonymous struct>*'
>  ...
> 
> The reason is that C++, in contrast to C, does not allow conversion of
> void * to anything, and this code gets compiled as C++ when the app is
> written in C++. The macro with the assignment itself is older, but only
> recent Bluez starts to use it in inline functions, thus triggering the
> problem.
> 
> This patch keeps the "struct __attribute__((packed))" magic and merely
> changes the typecast so that it works in C and C++. Like the existing
> macro this patch relies on support for typeof.

so I am applying this patch now, but I still have no idea what kind of
stupid C++ compiler you are using. The section of this include is
clearly marked as C code:

#ifdef __cplusplus
extern "C" {
#endif

Has anybody actually tested this on ARM where we do need the unaligned
access?

Regards

Marcel


