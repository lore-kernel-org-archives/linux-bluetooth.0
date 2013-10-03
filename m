Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 09/14] android: sdp: Reuse BlueZ SDP server in Android
Date: Thu, 03 Oct 2013 13:47:56 +0200
Message-ID: <11509963.E6KuFZ7L7l@uw000953>
In-Reply-To: <20131003113512.GA2804@aemeltch-MOBL1>
References: <1380639799-25790-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <12556011.okBRc3D5Dz@uw000953> <20131003113512.GA2804@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > 
> > > Reuse existing SDP server code in Android GPL daemon.
> > > ---
> > >  Makefile.android     |    7 +++++--
> > >  android/Android.mk   |    7 +++++++
> > >  android/bt_adapter.c |    5 ++++-
> > >  android/main.c       |   29 +++++++++++++++++++++++++++++
> > >  android/main.h       |   25 +++++++++++++++++++++++++
> > >  5 files changed, 70 insertions(+), 3 deletions(-)
> > >  create mode 100644 android/main.h
> > > 
> > > diff --git a/Makefile.android b/Makefile.android
> > > index 3e6fec0..bf82928 100644
> > > --- a/Makefile.android
> > > +++ b/Makefile.android
> > > @@ -3,7 +3,10 @@ if ANDROID_DAEMON
> > >  noinst_PROGRAMS += android/bluezd
> > >  
> > >  android_bluezd_SOURCES = android/main.c src/log.c \
> > > +				src/sdpd-database.c src/sdpd-server.c \
> > > +				src/sdpd-service.c src/sdpd-request.c \
> > >  				src/shared/util.h src/shared/util.c \
> > > -				src/shared/mgmt.h src/shared/mgmt.c
> > > -android_bluezd_LDADD = @GLIB_LIBS@
> > > +				src/shared/mgmt.h src/shared/mgmt.c \
> > > +				android/bt_adapter.h android/bt_adapter.c
> > > +android_bluezd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
> > >  endif
> > > diff --git a/android/Android.mk b/android/Android.mk
> > > index 11ac204..b0a531f 100644
> > > --- a/android/Android.mk
> > > +++ b/android/Android.mk
> > > @@ -11,6 +11,11 @@ LOCAL_SRC_FILES := \
> > >  	main.c \
> > >  	../src/shared/mgmt.c \
> > >  	../src/shared/util.c \
> > > +	bt_adapter.c \
> > > +	../src/sdpd-database.c \
> > > +	../src/sdpd-service.c \
> > > +	../src/sdpd-request.c \
> > > +	../src/sdpd-server.c \
> > >  
> > >  LOCAL_C_INCLUDES := \
> > >  	$(call include-path-for, glib) \
> > > @@ -19,6 +24,7 @@ LOCAL_C_INCLUDES := \
> > >  LOCAL_C_INCLUDES += \
> > >  	$(LOCAL_PATH)/../ \
> > >  	$(LOCAL_PATH)/../src \
> > > +	$(LOCAL_PATH)/../lib \
> > >  
> > >  LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
> > >  
> > > @@ -30,6 +36,7 @@ LOCAL_CFLAGS += -DSOCK_CLOEXEC=02000000 -DSOCK_NONBLOCK=04000
> > >  
> > >  LOCAL_SHARED_LIBRARIES := \
> > >  	libglib \
> > > +	libbluetooth \
> > >  
> > >  LOCAL_MODULE := bluezd
> > >  
> > > diff --git a/android/bt_adapter.c b/android/bt_adapter.c
> > > index e21d50c..5016243 100644
> > > --- a/android/bt_adapter.c
> > > +++ b/android/bt_adapter.c
> > > @@ -23,6 +23,7 @@
> > >  
> > >  #include "bt_adapter.h"
> > >  #include "log.h"
> > > +#include "main.h"
> > >  #include "src/shared/mgmt.h"
> > >  
> > >  struct bt_adapter *bt_adapter_new(uint16_t index, struct mgmt *mgmt_if)
> > > @@ -45,7 +46,7 @@ void adapter_start(struct bt_adapter *adapter)
> > >  
> > >  	/* TODO: CB: report scan mode */
> > >  
> > > -	/* TODO: SDP start here */
> > > +	sdp_start();
> > 
> > Why not just start it when daemon starts? Just like in original daemon?
> >
> 
> Can it start without adapter initialized? How can I open L2CAP socket?

It binds to BDADDR_ANY address.

-- 
BR
Szymon Janc

