Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Oct 2013 14:36:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv5 0/7] Android BlueZ patches, second chunk
Message-ID: <20131018113632.GA507@x220.p-661hnu-f1>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381998406-16662-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381998406-16662-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Oct 17, 2013, Andrei Emeltchenko wrote:
> This is second chunk from my initial big patch set. Fixed style issues
> commented by Marcel.
> 
> Changes:
> 	* v5: Rebased against upstream, hid and pan now uses explicit struct initialization,
> 	adapter-related functionality moved to adapter.c, fixed issues reported by Johan.
> 	* v4: Fixes several typos and missing style issues commented by Marcel earlier.
> 	* v3: Following upstream comments file names are changed from "_" to "-", added kernel style
> 	struct initialization, fixed bug checking status for mgmt commands, added 2 HALs skeletons.
> 	* v2: Corrected android_daemon -> enable_android autoconf stuff, better name for acquiring caps,
> 	renamed hal_msg.h to hal-msg.h due to Johan's comment. Added small test-sdp fix.
> 
> Note that due to Marcel comment this cannot be built unless you include my patch
> for Android bionic library:
> http://code.google.com/p/android-bluez/source/detail?r=77a07e7703b63e280d9880baad30b3375e7df079&repo=bionic#
> 
> Andrei Emeltchenko (7):
>   android: Add capabilities and set userid
>   android: Implement read_info_complete callback
>   android: Use kernel style to initialize struct fields
>   android: Rename hal_bluetooth.c to hal-bluetooth.c
>   android: Rename hal_bt_sock.c to hal-bt-sock.c
>   android: Add HID Host skeleton
>   android: Add PAN skeleton
> 
>  Makefile.android        |    3 +-
>  android/Android.mk      |    7 +-
>  android/adapter.c       |  108 +++++++++++--
>  android/hal-bluetooth.c |  392 +++++++++++++++++++++++++++++++++++++++++++++++
>  android/hal-bt-sock.c   |   85 ++++++++++
>  android/hal-hidhost.c   |  204 ++++++++++++++++++++++++
>  android/hal-pan.c       |  120 +++++++++++++++
>  android/hal.h           |    2 +
>  android/hal_bluetooth.c |  384 ----------------------------------------------
>  android/hal_bt_sock.c   |   85 ----------
>  android/main.c          |   77 ++++++++--
>  configure.ac            |    4 +
>  12 files changed, 980 insertions(+), 491 deletions(-)
>  create mode 100644 android/hal-bluetooth.c
>  create mode 100644 android/hal-bt-sock.c
>  create mode 100644 android/hal-hidhost.c
>  create mode 100644 android/hal-pan.c
>  delete mode 100644 android/hal_bluetooth.c
>  delete mode 100644 android/hal_bt_sock.c

After quite heavy fixing and additional patches of my own, these are now
upstream.

Johan
