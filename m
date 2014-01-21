Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Jan 2014 14:56:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	"linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/2] android: Add btmgmt to debug builds
Message-ID: <20140121125606.GA22342@x220.p-661hnu-f1>
References: <1389883945-10707-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <BE345789-E478-4C6C-B192-4DAB782CE135@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BE345789-E478-4C6C-B192-4DAB782CE135@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jan 16, 2014, Marcel Holtmann wrote:
> > android/Android.mk | 36 ++++++++++++++++++++++++++++++++++++
> > 1 file changed, 36 insertions(+)
> > 
> > diff --git a/android/Android.mk b/android/Android.mk
> > index 7e97ec8..b3e6a50 100644
> > --- a/android/Android.mk
> > +++ b/android/Android.mk
> > @@ -282,3 +282,39 @@ LOCAL_MODULE_TAGS := optional
> > LOCAL_MODULE := bluetoothd-snoop
> > 
> > include $(BUILD_EXECUTABLE)
> > +
> > +#
> > +# btmgmt
> > +#
> > +
> > +include $(CLEAR_VARS)
> > +
> > +LOCAL_SRC_FILES := \
> > +	../tools/btmgmt.c \
> > +	../monitor/mainloop.c \
> > +	../lib/bluetooth.c \
> > +	../lib/sdp.c \
> > +	../src/eir.c \
> > +	../src/glib-helper.c \
> > +	../src/shared/io-mainloop.c \
> > +	../src/shared/mgmt.c \
> > +	../src/shared/queue.c \
> > +	../src/shared/util.c \
> > +
> > +LOCAL_C_INCLUDES := \
> > +	$(call include-path-for, glib) \
> > +	$(call include-path-for, glib)/glib \
> > +	$(LOCAL_PATH)/.. \
> > +	$(LOCAL_PATH)/../src \
> > +	$(LOCAL_PATH)/../lib \
> > +
> > +LOCAL_SHARED_LIBRARIES := \
> > +	libglib \
> 
> have Johan fix the dependency on GLib instead. It should not be needed anymore.

btmgmt is now free of GLib so Andrzej is free to send a new patch for
the Android build.

Johan
