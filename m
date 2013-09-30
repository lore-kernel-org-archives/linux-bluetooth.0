Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 12/16] android: Add cap to bind to port < 1024
Date: Mon, 30 Sep 2013 09:36:54 +0200
Message-ID: <7348700.bQ9Re4jemt@uw000953>
In-Reply-To: <1380291161-10232-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1380291161-10232-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> For SDP server we need to bind to lower port, acquire this capability.
> ---
>  android/main.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  configure.ac   |    4 ++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/android/main.c b/android/main.c
> index 5fef095..649867d 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -31,6 +31,19 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <sys/prctl.h>
> +#include <linux/capability.h>
> +
> +/**
> + * Include <sys/capability.h> for host build and
> + * also for Android 4.3 when it is added to bionic
> + */
> +#if (defined(__ANDROID_API__) && (__ANDROID_API__ > 17)) || \
> +					!defined(__ANDROID_API__)
> +#include <sys/capability.h>
> +#endif
>  
>  #include <glib.h>
>  
> @@ -319,6 +332,43 @@ static void cleanup_mgmt_interface(void)
>  	mgmt_if = NULL;
>  }
>  
> +static bool android_set_aid_and_cap()
> +{
> +	struct __user_cap_header_struct header;
> +	struct __user_cap_data_struct cap;
> +
> +	DBG("%s: pid %d uid %d gid %d", __func__, getpid(), getuid(), getgid());

DBG macro already adds function name to string so there is no need to double
that. This applies to other places as well.

> +
> +	header.version = _LINUX_CAPABILITY_VERSION;
> +	header.pid = getpid();
> +	if (capget(&header, &cap) < 0)
> +		error("%s: capget(): %s", __func__, strerror(errno));
> +
> +	DBG("%s: Cap data 0x%x, 0x%x, 0x%x\n", __func__, cap.effective,
> +					cap.permitted, cap.inheritable);
> +
> +	prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0);
> +
> +	header.version = _LINUX_CAPABILITY_VERSION;
> +	header.pid = 0;
> +
> +	cap.effective = cap.permitted = cap.inheritable =
> +		1 << CAP_NET_RAW |
> +		1 << CAP_NET_ADMIN |
> +		1 << CAP_NET_BIND_SERVICE |
> +		1 << CAP_SYS_RAWIO |
> +		1 << CAP_SYS_NICE |
> +		1 << CAP_SETGID;
> +
> +	if (capset(&header, &cap)) {
> +		error("%s: capset(): %s", __func__, strerror(errno));
> +		return false;
> +	}
> +
> +	DBG("%s: capset(): Success", __func__);
> +	return true;
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	GOptionContext *context;
> @@ -357,6 +407,9 @@ int main(int argc, char *argv[])
>  	/* no need to keep parsed option in memory */
>  	free_options();
>  
> +	if (android_set_aid_and_cap() == false)
> +		exit(1);
> +
>  	init_mgmt_interface();
>  
>  	DBG("Entering main loop");
> diff --git a/configure.ac b/configure.ac
> index 3b7a5d9..af418d3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -247,4 +247,8 @@ AC_ARG_ENABLE(android-daemon, AC_HELP_STRING([--enable-android-daemon],
>  					[android_daemon=${enableval}])
>  AM_CONDITIONAL(ANDROID_DAEMON, test "${android_daemon}" = "yes")
>  
> +if (test "${android_daemon}" = "yes"); then
> +	AC_CHECK_LIB(cap, capget, dummy=yes, AC_MSG_ERROR(libcap is required))
> +fi
> +
>  AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
> 

-- 
BR
Szymon Janc


