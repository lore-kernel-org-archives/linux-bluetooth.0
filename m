Return-Path: <shapiroc@google.com>
MIME-Version: 1.0
In-Reply-To: <CALM0h1=5KQe2NpEc9OiAHOUGQp-rtsoFhGhzyMzOH8uTbX=ysQ@mail.gmail.com>
References: <20170630172920.1968-1-shapiroc@chromium.org> <5A47203A-A671-4854-9EAB-B09B15AF7680@holtmann.org>
 <CALM0h1m69=96tC+rM_-rXhc-9Kytaw_mZzc99vKXYZvVyjCXjg@mail.gmail.com>
 <CABBYNZ+OwBapaFMFAJMn7xC4+rioXihojyXiGAdJQKC+48wb3Q@mail.gmail.com> <CALM0h1=5KQe2NpEc9OiAHOUGQp-rtsoFhGhzyMzOH8uTbX=ysQ@mail.gmail.com>
From: Charles Shapiro <shapiroc@google.com>
Date: Mon, 24 Jul 2017 13:18:37 -0600
Message-ID: <CALM0h1mh7cHXn7J+-+LyfbPuUvgkFjW8tR-bSaZYP_AU5QFHJQ@mail.gmail.com>
Subject: Re: [PATCH] Support to change set file via arg
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

The links above were invalid...sorry.

Here are the correct links:
E.g.
 - https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/m=
aster/overlay-pyro/chromeos-base/chromeos-bsp-pyro/files/main.conf
 - https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/m=
aster/overlay-reef/chromeos-base/chromeos-bsp-reef/files/main.conf
 - https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/m=
aster/overlay-snappy/chromeos-base/chromeos-bsp-snappy/files/main.conf

I also updated the commit with these links and a better explanation of
the usage.

Thanks,
Charles

On Fri, Jun 30, 2017 at 1:04 PM, Charles Shapiro <shapiroc@google.com> wrot=
e:
> The product id varies in the DeviceID.
>
> E.g.
> https://chromium.git.corp.google.com/chromiumos/overlays/board-overlays/+=
/master/overlay-pyro/chromeos-base/chromeos-bsp-pyro/files/main.conf
> https://chromium.git.corp.google.com/chromiumos/overlays/board-overlays/+=
/master/overlay-reef/chromeos-base/chromeos-bsp-reef/files/main.conf
> https://chromium.git.corp.google.com/chromiumos/overlays/board-overlays/+=
/master/overlay-snappy/chromeos-base/chromeos-bsp-snappy/files/main.conf
>
> Linking is a possibility also, but being able to pass in the config
> path via a flag seemed reasonable also.
>
> On Fri, Jun 30, 2017 at 12:57 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Charles,
>>
>> On Fri, Jun 30, 2017 at 8:55 PM, Charles Shapiro <shapiroc@google.com> w=
rote:
>>> (Removing HTML formatting on email thread so it doesn't get blocked).
>>>
>>> For ChromeOS, we're working towards having a single build/image based
>>> on a reference board that then supports multiple models created by
>>> OEMs.
>>>
>>> Some of the bluetooth config differs on a per model basis, so we need
>>> to have multiple *.conf files ship on the actual image.
>>>
>>> We then modify the init script to check the model at runtime and pass
>>> the appropriate *.conf file to bluetoothd when it is started.
>>>
>>> On Fri, Jun 30, 2017 at 11:42 AM, Marcel Holtmann <marcel@holtmann.org>=
 wrote:
>>>> Hi Shapiro,
>>>>
>>>>> Currently, there is an expectation of the main.conf file at a specifi=
c
>>>>> location.  This prevents system builds that support more than one
>>>>> platform.
>>>>>
>>>>> This adds support so the main.conf file can be specified as a command
>>>>> line arg instead, so systems can manage multiple conf files as necess=
ary
>>>>> and pass the appropriate conf file when the daemon is started.
>>>>>
>>>>> Signed-off-by: C Shapiro <shapiroc@chromium.org>
>>>>> ---
>>>>> src/bluetoothd.8.in |  4 ++++
>>>>> src/main.c          | 12 +++++++++++-
>>>>> 2 files changed, 15 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/src/bluetoothd.8.in b/src/bluetoothd.8.in
>>>>> index 97ef3ec94..d61dcc5b3 100644
>>>>> --- a/src/bluetoothd.8.in
>>>>> +++ b/src/bluetoothd.8.in
>>>>> @@ -27,6 +27,10 @@ Print bluetoothd options and exit.
>>>>> Enable logging in foreground. Directs log output to the controlling t=
erminal \
>>>>> in addition to syslog.
>>>>> .TP
>>>>> +.B -f, --configfile
>>>>> +Specifies an explicit config file path instead of relying on the def=
ault path \
>>>>> +(@CONFIGDIR@/main.conf) for the config file.
>>>>> +.TP
>>>>> .B -d, --debug=3D<file1>:<file2>:...
>>>>> Sets how much information bluetoothd sends to the log destination (us=
ually \
>>>>> syslog's "daemon" facility). If the file options are omitted, then de=
bugging \
>>>>> diff --git a/src/main.c b/src/main.c
>>>>> index bcc1e6fae..87bdb66cb 100644
>>>>> --- a/src/main.c
>>>>> +++ b/src/main.c
>>>>> @@ -490,6 +490,7 @@ static guint setup_signalfd(void)
>>>>> static char *option_debug =3D NULL;
>>>>> static char *option_plugin =3D NULL;
>>>>> static char *option_noplugin =3D NULL;
>>>>> +static char *option_configfile =3D NULL;
>>>>> static gboolean option_compat =3D FALSE;
>>>>> static gboolean option_detach =3D TRUE;
>>>>> static gboolean option_version =3D FALSE;
>>>>> @@ -505,6 +506,9 @@ static void free_options(void)
>>>>>
>>>>>       g_free(option_noplugin);
>>>>>       option_noplugin =3D NULL;
>>>>> +
>>>>> +     g_free(option_configfile);
>>>>> +     option_configfile =3D NULL;
>>>>> }
>>>>>
>>>>> static void disconnect_dbus(void)
>>>>> @@ -577,6 +581,9 @@ static GOptionEntry options[] =3D {
>>>>>                               "Specify plugins to load", "NAME,..," }=
,
>>>>>       { "noplugin", 'P', 0, G_OPTION_ARG_STRING, &option_noplugin,
>>>>>                               "Specify plugins not to load", "NAME,..=
." },
>>>>> +     { "configfile", 'f', 0, G_OPTION_ARG_STRING, &option_configfile=
,
>>>>> +                             "Specify an explicit path to the config=
 file",
>>>>> +                             "FILE=E2=80=9D},
>>>>
>>>> I am failing to understand why this is needed. What problem are you tr=
ying to solve here? Can you give an example.
>>>>
>>
>> Btw, can't you link the main.conf with the board specific config?
>> Still it would be good to know what is that needs changing, is this
>> related to ControllerMode?
>>
>> --
>> Luiz Augusto von Dentz
