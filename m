Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Sep 2013 10:47:39 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 11/16] android: sdp: Reuse BlueZ SDP server in Android
Message-ID: <20130930074737.GD10262@aemeltch-MOBL1>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1380291161-10232-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <B13A32F7-6E42-43FA-B821-D1815119ABBC@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B13A32F7-6E42-43FA-B821-D1815119ABBC@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Sep 29, 2013 at 03:31:24PM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Reuse existing SDP server code in Android GPL daemon.
> > ---
> > Makefile.android     |    7 +++++--
> > android/Android.mk   |    6 ++++++
> > android/bt_adapter.c |    5 ++++-
> > android/main.c       |   27 +++++++++++++++++++++++++++
> > android/main.h       |   25 +++++++++++++++++++++++++
> > 5 files changed, 67 insertions(+), 3 deletions(-)
> > create mode 100644 android/main.h
> > 
> > diff --git a/Makefile.android b/Makefile.android
> > index 3e6fec0..bf82928 100644
> > --- a/Makefile.android
> > +++ b/Makefile.android
> > @@ -3,7 +3,10 @@ if ANDROID_DAEMON
> > noinst_PROGRAMS += android/bluezd
> > 
> > android_bluezd_SOURCES = android/main.c src/log.c \
> > +				src/sdpd-database.c src/sdpd-server.c \
> > +				src/sdpd-service.c src/sdpd-request.c \
> > 				src/shared/util.h src/shared/util.c \
> > -				src/shared/mgmt.h src/shared/mgmt.c
> > -android_bluezd_LDADD = @GLIB_LIBS@
> > +				src/shared/mgmt.h src/shared/mgmt.c \
> > +				android/bt_adapter.h android/bt_adapter.c
> > +android_bluezd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
> > endif
> > diff --git a/android/Android.mk b/android/Android.mk
> > index 36f8798..08e35e4 100644
> > --- a/android/Android.mk
> > +++ b/android/Android.mk
> > @@ -9,6 +9,11 @@ include $(CLEAR_VARS)
> > LOCAL_SRC_FILES := \
> > 	log.c \
> > 	main.c \
> > +	bt_adapter.c \
> > +	../src/sdpd-database.c \
> > +	../src/sdpd-service.c \
> > +	../src/sdpd-request.c \
> > +	../src/sdpd-server.c \
> > 
> > LOCAL_C_INCLUDES := \
> > 	$(call include-path-for, glib) \
> > @@ -24,6 +29,7 @@ LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
> > LOCAL_SHARED_LIBRARIES := \
> > 	libglib \
> > 	libbluez \
> > +	libbluetooth \
> > 
> > LOCAL_MODULE := bluezd
> > 
> > diff --git a/android/bt_adapter.c b/android/bt_adapter.c
> > index 9f64839..42facb6 100644
> > --- a/android/bt_adapter.c
> > +++ b/android/bt_adapter.c
> > @@ -23,6 +23,7 @@
> > 
> > #include "bt_adapter.h"
> > #include "log.h"
> > +#include "main.h"
> > #include "src/shared/mgmt.h"
> > 
> > struct bt_device *bt_device_ref(struct bt_device *device)
> > @@ -118,7 +119,7 @@ void adapter_start(struct bt_adapter *adapter)
> > 
> > 	/* TODO: CB: report scan mode */
> > 
> > -	/* TODO: SDP start here */
> > +	sdp_start();
> > 
> > 	/* TODO: CB: report state on */
> > }
> > @@ -126,4 +127,6 @@ void adapter_start(struct bt_adapter *adapter)
> > void adapter_stop(struct bt_adapter *adapter)
> > {
> > 	DBG("disabled %u", adapter->dev_id);
> > +
> > +	sdp_stop();
> > }
> > diff --git a/android/main.c b/android/main.c
> > index 4792919..5fef095 100644
> > --- a/android/main.c
> > +++ b/android/main.c
> > @@ -36,6 +36,8 @@
> > 
> > #include "log.h"
> > #include "hcid.h"
> > +#include "sdpd.h"
> > +#include "main.h"
> > 
> > #include "lib/bluetooth.h"
> > #include "lib/mgmt.h"
> > @@ -43,12 +45,37 @@
> > 
> > #define SHUTDOWN_GRACE_SECONDS 10
> > 
> > +struct main_opts main_opts;
> > +
> 
> where is this main_opts coming from. I rather not have this.

Otherwise I get error:

sdpd-server.c:241: error: undefined reference to 'main_opts'
collect2: ld returned 1 exit status

BTW: Is this now fixed?

> > static GMainLoop *event_loop;
> > static struct mgmt *mgmt_if = NULL;
> > 
> > static uint8_t mgmt_version = 0;
> > static uint8_t mgmt_revision = 0;
> > 
> > +GList *adapter_list = NULL;
> > +struct bt_adapter *default_adapter = NULL;
> 
> Why are this public variables.

This is the default adapter, it probably needs to be public, otherwise we
have to squash all daemon code to single main.c

> > +
> > +int sdp_start(void)
> > +{
> > +	uint16_t mtu = 0;
> > +	uint32_t flags = 0;
> > +
> > +	DBG("");
> > +
> > +	/* sdpd-server use these settings */
> > +	memset(&main_opts, 0, sizeof(main_opts));
> > +
> > +	return start_sdp_server(mtu, flags);
> 
> Just fill in mtu and flags manually here. No need for variable declaration above.

OK

Best regards 
Andrei Emeltchenko 
