Return-Path: <shapiroc@google.com>
MIME-Version: 1.0
In-Reply-To: <5A47203A-A671-4854-9EAB-B09B15AF7680@holtmann.org>
References: <20170630172920.1968-1-shapiroc@chromium.org> <5A47203A-A671-4854-9EAB-B09B15AF7680@holtmann.org>
From: Charles Shapiro <shapiroc@google.com>
Date: Fri, 30 Jun 2017 11:55:12 -0600
Message-ID: <CALM0h1m69=96tC+rM_-rXhc-9Kytaw_mZzc99vKXYZvVyjCXjg@mail.gmail.com>
Subject: Re: [PATCH] Support to change set file via arg
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

(Removing HTML formatting on email thread so it doesn't get blocked).

For ChromeOS, we're working towards having a single build/image based
on a reference board that then supports multiple models created by
OEMs.

Some of the bluetooth config differs on a per model basis, so we need
to have multiple *.conf files ship on the actual image.

We then modify the init script to check the model at runtime and pass
the appropriate *.conf file to bluetoothd when it is started.

On Fri, Jun 30, 2017 at 11:42 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Shapiro,
>
>> Currently, there is an expectation of the main.conf file at a specific
>> location.  This prevents system builds that support more than one
>> platform.
>>
>> This adds support so the main.conf file can be specified as a command
>> line arg instead, so systems can manage multiple conf files as necessary
>> and pass the appropriate conf file when the daemon is started.
>>
>> Signed-off-by: C Shapiro <shapiroc@chromium.org>
>> ---
>> src/bluetoothd.8.in |  4 ++++
>> src/main.c          | 12 +++++++++++-
>> 2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/bluetoothd.8.in b/src/bluetoothd.8.in
>> index 97ef3ec94..d61dcc5b3 100644
>> --- a/src/bluetoothd.8.in
>> +++ b/src/bluetoothd.8.in
>> @@ -27,6 +27,10 @@ Print bluetoothd options and exit.
>> Enable logging in foreground. Directs log output to the controlling term=
inal \
>> in addition to syslog.
>> .TP
>> +.B -f, --configfile
>> +Specifies an explicit config file path instead of relying on the defaul=
t path \
>> +(@CONFIGDIR@/main.conf) for the config file.
>> +.TP
>> .B -d, --debug=3D<file1>:<file2>:...
>> Sets how much information bluetoothd sends to the log destination (usual=
ly \
>> syslog's "daemon" facility). If the file options are omitted, then debug=
ging \
>> diff --git a/src/main.c b/src/main.c
>> index bcc1e6fae..87bdb66cb 100644
>> --- a/src/main.c
>> +++ b/src/main.c
>> @@ -490,6 +490,7 @@ static guint setup_signalfd(void)
>> static char *option_debug =3D NULL;
>> static char *option_plugin =3D NULL;
>> static char *option_noplugin =3D NULL;
>> +static char *option_configfile =3D NULL;
>> static gboolean option_compat =3D FALSE;
>> static gboolean option_detach =3D TRUE;
>> static gboolean option_version =3D FALSE;
>> @@ -505,6 +506,9 @@ static void free_options(void)
>>
>>       g_free(option_noplugin);
>>       option_noplugin =3D NULL;
>> +
>> +     g_free(option_configfile);
>> +     option_configfile =3D NULL;
>> }
>>
>> static void disconnect_dbus(void)
>> @@ -577,6 +581,9 @@ static GOptionEntry options[] =3D {
>>                               "Specify plugins to load", "NAME,..," },
>>       { "noplugin", 'P', 0, G_OPTION_ARG_STRING, &option_noplugin,
>>                               "Specify plugins not to load", "NAME,..." =
},
>> +     { "configfile", 'f', 0, G_OPTION_ARG_STRING, &option_configfile,
>> +                             "Specify an explicit path to the config fi=
le",
>> +                             "FILE=E2=80=9D},
>
> I am failing to understand why this is needed. What problem are you tryin=
g to solve here? Can you give an example.
>
> Regards
>
> Marcel
>
