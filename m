Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCHv3 06/15] android: Add basic mgmt initialization sequence
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131010095952.GH23879@aemeltch-MOBL1>
Date: Thu, 10 Oct 2013 14:38:08 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A3F24017-452A-43C3-9F98-14CC585FD7A6@holtmann.org>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381243883-2745-7-git-send-email-Andrei.Emeltchenko.news@gmail.com> <0147C8F8-0491-44CD-BCDB-51DF9F6D3315@holtmann.org> <20131010095952.GH23879@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>>> Initialize bluetooth controller via mgmt interface.
>>> ---
>>> Makefile.android   |    4 +-
>>> android/Android.mk |   11 +++
>>> android/main.c     |  189 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>> 3 files changed, 203 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/Makefile.android b/Makefile.android
>>> index e161e6d..9a2c486 100644
>>> --- a/Makefile.android
>>> +++ b/Makefile.android
>>> @@ -1,7 +1,9 @@
>>> if ANDROID
>>> noinst_PROGRAMS += android/bluetoothd
>>> 
>>> -android_bluetoothd_SOURCES = android/main.c src/log.c
>>> +android_bluetoothd_SOURCES = android/main.c src/log.c \
>>> +				src/shared/util.h src/shared/util.c \
>>> +				src/shared/mgmt.h src/shared/mgmt.c
>>> android_bluetoothd_LDADD = @GLIB_LIBS@
>>> endif
>>> 
>>> diff --git a/android/Android.mk b/android/Android.mk
>>> index 2cabff4..f5fd863 100644
>>> --- a/android/Android.mk
>>> +++ b/android/Android.mk
>>> @@ -15,10 +15,15 @@ include $(CLEAR_VARS)
>>> LOCAL_SRC_FILES := \
>>> 	main.c \
>>> 	log.c \
>>> +	../src/shared/mgmt.c \
>>> +	../src/shared/util.c \
>>> 
>>> LOCAL_C_INCLUDES := \
>>> 	$(call include-path-for, glib) \
>>> 	$(call include-path-for, glib)/glib \
>>> +
>>> +LOCAL_C_INCLUDES += \
>>> +	$(LOCAL_PATH)/../ \
>>> 	$(LOCAL_PATH)/../src \
>> do we need these nested includes actually? We could also just fix the includes. BlueZ historically has not been good with clear includes. I started to fix this, but it seems I have not gotten to all of them yet.
>> 
> 
> So how do you want it to be? Here I just added BlueZ top-dir.
> 
>>> LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
>>> @@ -26,6 +31,12 @@ LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
>>> # to suppress the "warning: missing initializer near initialization.." warning
>>> LOCAL_CFLAGS += -Wno-missing-field-initializers
>>> 
>>> +# to suppress the "pointer of type 'void *' used in arithmetic" warning
>>> +LOCAL_CFLAGS += -Wno-pointer-arith
>> 
>> Why do we need to suppress these warning. Can we not just fix them.
>> 
> 
> Is this fix good:
> 
> diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
> index 2c79886..b2f5506 100644
> --- a/src/shared/mgmt.c
> +++ b/src/shared/mgmt.c
> @@ -55,7 +55,7 @@ struct mgmt {
>        unsigned int next_notify_id;
>        bool in_notify;
>        bool destroyed;
> -       void *buf;
> +       uint8_t *buf;
>        uint16_t len;
>        mgmt_debug_func_t debug_callback;
>        mgmt_destroy_func_t debug_destroy;
> @@ -299,7 +299,7 @@ static gboolean received_data(GIOChannel *channel,
> GIOCondition cond,
>        if (bytes_read < MGMT_HDR_SIZE)
>                return TRUE;
> 
> -       hdr = mgmt->buf;
> +       hdr = (struct mgmt_hdr *) mgmt->buf;

are we using a different compiler or why does this happen on Android and not on a regular system like Fedora.

>>> +
>>> +# Define missing flags for Android 4.2
>>> +LOCAL_CFLAGS += -DSOCK_CLOEXEC=02000000 -DSOCK_NONBLOCK=04000
>>> +
>> 
>> This thing is dangerous. Do we really bother with Android 4.2 support
>> and can not rely on a newer version that has this fixed properly in
>> bionic.
> 
> The problem here is that our base android-ia from 01.org is based on
> 4.2.2. Do you still want to remove this?

I don't think we should care much about Android 4.2.2. Why is our base not updated to Android 4.3 yet. And as soon as 4.4 is out, we can ignore 4.3 as well. Chasing after old versions seems a bit pointless until someone actually integrated this into a product.

Regards

Marcel

