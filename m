Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Jan 2014 10:36:50 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Fix bluetoothd installation path
Message-ID: <20140109083513.GA9810@aemeltch-MOBL1>
References: <1389199321-26623-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1482934.Q0UzPI5uvD@athlon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1482934.Q0UzPI5uvD@athlon>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

On Wed, Jan 08, 2014 at 05:57:22PM +0100, Szymon Janc wrote:
> Hi Andrzej,
> 
> On Wednesday 08 January 2014 17:42:01 Andrzej Kaczmarek wrote:
> > This patch removes explicit LOCAL_MODULE_PATH definition for bluetoothd
> > and bluetoothd-snoop modules which caused both binaries to be installed
> > in /system/xbin instead of /system/bin folder.
> > ---
> >  android/Android.mk | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/android/Android.mk b/android/Android.mk
> > index 16339b1..8eb918e 100644
> > --- a/android/Android.mk
> > +++ b/android/Android.mk
> > @@ -75,7 +75,6 @@ $(shell mkdir -p $(LOCAL_PATH)/../lib/bluetooth)
> > 
> >  $(foreach file,$(lib_headers), $(shell ln -sf ../$(file)
> > $(LOCAL_PATH)/../lib/bluetooth/$(file)))
> > 
> > -LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)

I would better change this to:

LOCAL_MODULE_PATH := $(TARGET_OUT_EXECUTABLES)

Best regards 
Andrei Emeltchenko 

> >  LOCAL_MODULE_TAGS := optional
> >  LOCAL_MODULE := bluetoothd
> > 
> > @@ -264,7 +263,6 @@ LOCAL_C_INCLUDES := \
> > 
> >  LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
> > 
> > -LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
> >  LOCAL_MODULE_TAGS := optional
> >  LOCAL_MODULE := bluetoothd-snoop
> 
> Applied, thanks.
> 
> -- 
> Szymon K. Janc
> szymon.janc@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
