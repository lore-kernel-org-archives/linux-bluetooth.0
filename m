Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <04524385-0757-4DFE-B503-352781B4B9BA@holtmann.org>
References: <1389973213-30251-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1389973213-30251-3-git-send-email-andrzej.kaczmarek@tieto.com> <04524385-0757-4DFE-B503-352781B4B9BA@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Fri, 17 Jan 2014 20:09:39 +0100
Message-ID: <CAF3PWx2XmgedAh3owiGN3JQzQZo8gNNRcph7kx=252Uo1yFyuw@mail.gmail.com>
Subject: Re: [PATCH 2/9] android: Build Audio HAL with SBC
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 17 January 2014 19:27, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andrzej,
>
>> Build for Android requires libsbc sources to be available in
>> external/bluetooth/sbc. Build for host requires libsbc package to be
>> installed.
>> ---
>> android/Android.mk  | 14 +++++++++++---
>> android/Makefile.am |  2 ++
>> configure.ac        |  7 +++++++
>> 3 files changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/android/Android.mk b/android/Android.mk
>> index 7e97ec8..63a4a24 100644
>> --- a/android/Android.mk
>> +++ b/android/Android.mk
>> @@ -3,8 +3,9 @@ LOCAL_PATH := $(call my-dir)
>> # Retrieve BlueZ version from configure.ac file
>> BLUEZ_VERSION := $(shell grep ^AC_INIT $(LOCAL_PATH)/../configure.ac | cpp -P -D'AC_INIT(_,v)=v')
>>
>> -# Specify pathmap for glib
>> -pathmap_INCL += glib:external/bluetooth/glib
>> +# Specify pathmap for glib and sbc
>> +pathmap_INCL += glib:external/bluetooth/glib \
>> +     sbc:external/bluetooth/sbc
>>
>> # Specify common compiler flags
>> BLUEZ_COMMON_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\" \
>> @@ -220,11 +221,18 @@ include $(BUILD_EXECUTABLE)
>>
>> include $(CLEAR_VARS)
>>
>> -LOCAL_SRC_FILES := hal-audio.c
>> +LOCAL_SRC_FILES := hal-audio.c \
>> +     ../../sbc/sbc/sbc.c \
>> +     ../../sbc/sbc/sbc_primitives.c \
>> +     ../../sbc/sbc/sbc_primitives_armv6.c \
>> +     ../../sbc/sbc/sbc_primitives_iwmmxt.c \
>> +     ../../sbc/sbc/sbc_primitives_mmx.c \
>> +     ../../sbc/sbc/sbc_primitives_neon.c \
>
> why? Can we not just build libsbc for Android?

This way we can use upstream sbc git without forking it to add Android.mk.

> I rather install an extra library and not have to make this builtin.

Sure, this can be changed. Static or dynamic library?


BR,
Andrzej
