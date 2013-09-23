Return-Path: <cyrus@holtmann.org>
Message-ID: <52400F2B.9010501@linux.intel.com>
Date: Mon, 23 Sep 2013 11:51:39 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android: Add skeleton of BlueZ Android daemon
References: <1379679871-29623-1-git-send-email-frederic.danis@linux.intel.com> <226042C8-264A-469E-8D6A-F41141DC0552@holtmann.org>
In-Reply-To: <226042C8-264A-469E-8D6A-F41141DC0552@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

On 21/09/2013 19:14, Marcel Holtmann wrote:
> Hi Fred,
>
>> Define local mapping to glib path, otherwise this has to be inside central
>> place in the build repository.
>>
>> Retrieve Bluetooth version from configure.ac.
>> ---
>> .gitignore         |    2 +
>> Android.mk         |    9 ++++
>> Makefile.am        |    1 +
>> Makefile.android   |    7 ++++
>> android/Android.mk |   24 +++++++++++
>> android/main.c     |  119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>> configure.ac       |    5 +++
>> 7 files changed, 167 insertions(+)
>> create mode 100644 Android.mk
>> create mode 100644 Makefile.android
>> create mode 100644 android/Android.mk
>> create mode 100644 android/main.c
>
> lets split this out a little bit. Code additions should not be intermixed with additions to the build system and especially configure options.
>
> I rather not have a top-level Android.mk. It should be enough to provide an android/Android.mk.
>
>> diff --git a/.gitignore b/.gitignore
>> index 8a25a3e..331a18b 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -98,3 +98,5 @@ unit/test-gobex-packet
>> unit/test-gobex-transfer
>> unit/test-*.log
>> unit/test-*.trs
>> +
>> +android/bluezd
>
> If we keep using prefix btd_ for certain set of functions, then it might be better if the daemon is build as android/bluetoothd or android/btd.

OK, I will rename it android/bluetoothd

>
> <snip>
>
>> +
>> +#ifdef HAVE_CONFIG_H
>> +#include <config.h>
>> +#endif
>> +
>> +#include <signal.h>
>> +#include <stdint.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +
>> +#include <glib.h>
>> +
>> +#include "hcid.h"
>
> I do not think we need to include hcid.h here. If we for some reason still do, then please try to cleanup that first.

OK, I will remove it

>
>> +
>> +#define SHUTDOWN_GRACE_SECONDS 10
>> +
>> +static GMainLoop *event_loop;
>> +
>> +void btd_exit(void)
>> +{
>> +	g_main_loop_quit(event_loop);
>> +}
>> +
>> +static gboolean quit_eventloop(gpointer user_data)
>> +{
>> +	btd_exit();
>> +	return FALSE;
>> +}
>> +
>> +static void signal_handler(int sig)
>> +{
>> +	static unsigned int __terminated = 0;
>
> Make this static volatile bool __terminated = false instead. Remember that you are actually using signals here and not signalfd.

OK, I will do this.

>
>> +
>> +	switch (sig) {
>> +	case SIGINT:
>> +	case SIGTERM:
>> +		if (__terminated == 0) {
>> +			g_timeout_add_seconds(SHUTDOWN_GRACE_SECONDS,
>> +							quit_eventloop, NULL);
>> +		}
>> +
>> +		__terminated = 1;
>> +		break;
>> +	}
>> +}
>> +
>> +static gboolean option_detach = TRUE;
>> +static gboolean option_version = FALSE;
>> +
>> +static GOptionEntry options[] = {
>> +	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
>> +				G_OPTION_ARG_NONE, &option_detach,
>> +				"Run with logging in foreground", NULL },
>
> Do we need this option at all. I think we should always run in foreground and the system manager need to make sure we are spawned.

I think this is useful when debugging in conjonction with debug option 
and logging to console.

>
>> +	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
>> +				"Show version information and exit", NULL },
>> +	{ NULL }
>> +};
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	GOptionContext *context;
>> +	GError *err = NULL;
>> +	struct sigaction sa;
>> +
>> +	context = g_option_context_new(NULL);
>> +	g_option_context_add_main_entries(context, options, NULL);
>> +
>> +	if (g_option_context_parse(context, &argc, &argv, &err) == FALSE) {
>> +		if (err != NULL) {
>> +			g_printerr("%s\n", err->message);
>> +			g_error_free(err);
>> +		} else
>> +			g_printerr("An unknown error occurred\n");
>> +		exit(1);
>> +	}
>> +
>> +	g_option_context_free(context);
>> +
>> +	if (option_version == TRUE) {
>> +		printf("%s\n", VERSION);
>> +		exit(0);
>
> I prefer if we start using return EXIT_SUCCESS and in error case EXIT_FAILURE.

OK, I will do this.

>
>> +	}
>> +
>> +	event_loop = g_main_loop_new(NULL, FALSE);
>> +
>> +	memset(&sa, 0, sizeof(sa));
>> +	sa.sa_handler = signal_handler;
>> +	sigaction(SIGINT, &sa, NULL);
>> +	sigaction(SIGTERM, &sa, NULL);
>> +
>> +	g_main_loop_run(event_loop);
>> +
>> +	g_main_loop_unref(event_loop);
>> +
>> +	return 0;
>> +}
>> diff --git a/configure.ac b/configure.ac
>> index 41c2935..3b7a5d9 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -242,4 +242,9 @@ AC_DEFINE_UNQUOTED(CONFIGDIR, "${configdir}",
>> 			[Directory for the configuration files])
>> AC_SUBST(CONFIGDIR, "${configdir}")
>>
>> +AC_ARG_ENABLE(android-daemon, AC_HELP_STRING([--enable-android-daemon],
>> +			[enable BlueZ Android daemon]),
>> +					[android_daemon=${enableval}])
>> +AM_CONDITIONAL(ANDROID_DAEMON, test "${android_daemon}" = "yes")
>> +
>
> This needs to be a separate patch. And it should just say --enable-android.
>
> In addition it needs to be added to bootstrap-configure and distcheck handling.

OK

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation
