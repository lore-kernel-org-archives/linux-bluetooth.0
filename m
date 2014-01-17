Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 1/4] android: Add sample init.bluetooth.rc file
Date: Fri, 17 Jan 2014 10:06:31 +0100
Message-ID: <51482604.krZi3C0Dta@uw000953>
In-Reply-To: <19D4671A-DE2F-49A3-9FEE-F17B5B1CA32D@holtmann.org>
References: <1389713283-13038-1-git-send-email-szymon.janc@tieto.com> <2728377.B2HgAZfSS5@uw000953> <19D4671A-DE2F-49A3-9FEE-F17B5B1CA32D@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Friday 17 of January 2014 00:53:54 Marcel Holtmann wrote:
> Hi Szymon,
> 
> >>> This file is intended to be included from device init.rc.
> >>> ---
> >>> android/Android.mk        | 16 +++++++++++++++-
> >>> android/Makefile.am       |  1 +
> >>> android/init.bluetooth.rc | 27 +++++++++++++++++++++++++++
> >>> 3 files changed, 43 insertions(+), 1 deletion(-)
> >>> create mode 100644 android/init.bluetooth.rc
> >>> 
> >>> diff --git a/android/Android.mk b/android/Android.mk
> >>> index ae52ab4..f13e703 100644
> >>> --- a/android/Android.mk
> >>> +++ b/android/Android.mk
> >>> @@ -109,7 +109,7 @@ LOCAL_MODULE := bluetooth.default
> >>> LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
> >>> LOCAL_MODULE_TAGS := optional
> >>> LOCAL_MODULE_CLASS := SHARED_LIBRARIES
> >>> -LOCAL_REQUIRED_MODULES := bluetoothd bluetoothd-snoop
> >>> +LOCAL_REQUIRED_MODULES := bluetoothd bluetoothd-snoop init.bluetooth.rc
> >>> 
> >>> include $(BUILD_SHARED_LIBRARY)
> >>> 
> >>> @@ -263,3 +263,17 @@ LOCAL_MODULE_TAGS := optional
> >>> LOCAL_MODULE := bluetoothd-snoop
> >>> 
> >>> include $(BUILD_EXECUTABLE)
> >>> +
> >>> +#
> >>> +# init.bleutooth.rc
> >>> +#
> >>> +
> >>> +include $(CLEAR_VARS)
> >>> +
> >>> +LOCAL_MODULE := init.bluetooth.rc
> >>> +LOCAL_MODULE_CLASS := ETC
> >>> +LOCAL_SRC_FILES := $(LOCAL_MODULE)
> >>> +LOCAL_MODULE_TAGS := optional
> >>> +LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)
> >>> +
> >>> +include $(BUILD_PREBUILT)
> >>> diff --git a/android/Makefile.am b/android/Makefile.am
> >>> index 7806f79..b205019 100644
> >>> --- a/android/Makefile.am
> >>> +++ b/android/Makefile.am
> >>> @@ -134,6 +134,7 @@ android_audio_a2dp_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
> >>> endif
> >>> 
> >>> EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
> >>> +		android/init.bluetooth.rc \
> >>> 		android/pics-gap.txt android/pics-hid.txt \
> >>> 		android/pics-pan.txt android/pics-did.txt \
> >>> 		android/pics-opp.txt android/pics-pbap.txt \
> >>> diff --git a/android/init.bluetooth.rc b/android/init.bluetooth.rc
> >>> new file mode 100644
> >>> index 0000000..e2be9e8
> >>> --- /dev/null
> >>> +++ b/android/init.bluetooth.rc
> >>> @@ -0,0 +1,27 @@
> >>> +chown bluetooth bluetooth /data/misc/bluetooth
> >>> +
> >>> +chown bluetooth bluetooth /dev/uhid
> >>> +
> >>> +on property:bluetooth.start=bluetoothd
> >>> +    start bluetoothd
> >>> +
> >>> +on property:bluetooth.stop=bluetoothd
> >>> +    stop bluetoothd
> >>> +
> >>> +on property:bluetooth.start=bluetoothd-snoop
> >>> +    start bluetoothd-snoop
> >>> +
> >>> +on property:bluetooth.stop=bluetoothd-snoop
> >>> +    stop bluetoothd-snoop
> >> 
> >> I think this is actually racy. The ctl.start and ctl.stop sound like they have special handling inside Android init. If you accidentally set bluetooth.start , then bad things happen.
> > 
> > on property:foo=bar is also triggered if foo is already set to bar so I don't
> > see what could happen wrong here.
> > 
> >> 
> >> So I would propose doing bluetooth.daemon=on/off and bluetooth.snoop=on/off
> >> 
> >> We just have to make sure that when bluetoothd or bluetoothd-snoop die unexpectedly that these properties get set back to off.
> > 
> > I'm not sure if we are able to set properties back to proper state if service
> > exited in such case (that would trigger loop in init).
> 
> there is a service-exited-<name> type of action. I think we should look into using that one somehow.

I'll exercise that and send V2.

> 
> > My idea was to use bluetooth.start/stop to start/stop (actually stop is needed
> > only for bluetoothd-snoop service) service by bluetooth user (sort of "sudo"
> > wrapper) but don't care about values in those props and if one want to use
> > props to track service lifetime then just use init.svc.bluetoothd{-snoop}
> > property.
> 
> Fair enough.
> 
> However then I would prefer if we do bluetooth.{start,stop}=daemon and bluetooth.{start,stop}=snoop to make this really tight into how our solution works.

OK.

> 
> >>> +service bluetoothd /system/bin/logwrapper /system/bin/bluetoothd
> >>> +    class main
> >>> +    group bluetooth net_admin
> >>> +    disabled
> >>> +    oneshot
> >>> +
> >>> +service bluetoothd-snoop /system/bin/bluetoothd-snoop
> >>> +    class main
> >>> +    group bluetooth net_admin
> >>> +    disabled
> >>> +    oneshot
> >> 
> >> Does net_admin include CAP_NET_RAW actually or are we using some sort of patched module for this?
> > 
> > I'm not sure, this was probably just copied from <4.2 android. Since we
> > start as root and drop caps I think this can be removed.
> 
> The snoop process just needs CAP_NET_RAW and write access to the file location. I would prefer to really make sure it runs with as less right as possible.

OK.

-- 
Best regards, 
Szymon Janc
