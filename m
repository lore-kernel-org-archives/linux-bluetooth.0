Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Oct 2013 15:43:49 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 09/15] android: Add Android Makefile for libbluetooth
Message-ID: <20131010124347.GM23879@aemeltch-MOBL1>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381243883-2745-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <67FF7DAD-8C17-4ADB-8050-5F35CC7C34D4@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <67FF7DAD-8C17-4ADB-8050-5F35CC7C34D4@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 09, 2013 at 09:43:18PM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Build libbluetooth library for Android.
> > ---
> > android/Android.mk |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 53 insertions(+)
> > 
> > diff --git a/android/Android.mk b/android/Android.mk
> > index f5fd863..8f95a66 100644
> > --- a/android/Android.mk
> > +++ b/android/Android.mk
> > @@ -41,6 +41,7 @@ LOCAL_SHARED_LIBRARIES := \
> > 	libglib \
> > 
> > LOCAL_MODULE := bluetoothd
> > +LOCAL_REQUIRED_MODULES := libbluetooth
> > 
> > include $(BUILD_EXECUTABLE)
> > 
> > @@ -63,3 +64,55 @@ LOCAL_MODULE_TAGS := optional
> > LOCAL_MODULE_CLASS := SHARED_LIBRARIES
> > 
> > include $(BUILD_SHARED_LIBRARY)
> > +
> > +#
> > +# libbluetooth library
> > +#
> > +
> > +include $(CLEAR_VARS)
> > +
> > +LOCAL_SRC_FILES := \
> > +	../lib/bluetooth.c \
> > +	../lib/sdp.c \
> > +	../lib/hci.c \
> > +	../lib/uuid.c \
> 
> why are we building a shared library here. What is it useful for. Even
> within BlueZ we do not install libbluetooth anymore.

It is used for tools also like btmon, shall we include those files
directly?

> 
> > +
> > +LOCAL_C_INCLUDES := \
> > +	$(LOCAL_PATH)/../lib/ \
> > +	$(LOCAL_PATH)/../src/shared \
> 
> The library clearly does not include anything from src/shared/. So what is that doing here.
> 
> > +
> > +LOCAL_C_INCLUDES += \
> > +	$(call include-path-for, glib) \
> > +	$(call include-path-for, glib)/glib \
> 
> The library clearly does not need GLib. So why are we doing that here.
> 
> > +
> > +LOCAL_CFLAGS += -O3
> > +
> > +# to suppress the "pointer of type 'void *' used in arithmetic" warning
> > +LOCAL_CFLAGS += -Wno-pointer-arith
> > +
> > +# to suppress the "missing initializer near initialization" warning
> > +LOCAL_CFLAGS += -Wno-missing-field-initializers
> 
> Lets fix the actual warnings.
> 
> > +
> > +# Define missing flags for Android 4.2
> > +LOCAL_CFLAGS += -DSOCK_CLOEXEC=02000000 -DSOCK_NONBLOCK=04000
> 
> And are we sure that these flags are needed for the library.
> 
> > +
> > +lib_headers := \
> > +	bluetooth.h \
> > +	hci.h \
> > +	hci_lib.h \
> > +	sco.h \
> > +	l2cap.h \
> > +	sdp.h \
> > +	sdp_lib.h \
> > +	rfcomm.h \
> > +	bnep.h \
> > +	cmtp.h \
> > +	hidp.h \
> 
> I would really prefer we do not install these.

this creates directly bluetooth with links to headers since this is they
way BlueZ is referring to them. What do you propose here?

Best regards 
Andrei Emeltchenko 
