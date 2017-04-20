Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5CEB8780-F5F3-40EC-BC52-1FACB3378FB9@holtmann.org>
References: <20170420123233.8747-1-luiz.dentz@gmail.com> <20170420123233.8747-3-luiz.dentz@gmail.com>
 <5CEB8780-F5F3-40EC-BC52-1FACB3378FB9@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Apr 2017 16:13:59 +0300
Message-ID: <CABBYNZ+KpSpVPLzWh3MuWvkTRJsQhHb+nVVq57+76WT-OjMgpw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] client: Always start an agent
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Apr 20, 2017 at 3:52 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Luiz,
>
>> Always register agent with 'KeyboardDisplay' capability.
>> ---
>> client/main.c | 18 ++++--------------
>> 1 file changed, 4 insertions(+), 14 deletions(-)
>>
>> diff --git a/client/main.c b/client/main.c
>> index 8c9d5c3..7043081 100644
>> --- a/client/main.c
>> +++ b/client/main.c
>> @@ -54,6 +54,8 @@
>> #define PROMPT_ON     COLOR_BLUE "[bluetooth]" COLOR_OFF "# "
>> #define PROMPT_OFF    "Waiting to connect to bluetoothd..."
>>
>> +#define AGENT_CAP    "KeyboardDisplay"
>> +
>> static GMainLoop *main_loop;
>> static DBusConnection *dbus_conn;
>>
>> @@ -2352,23 +2354,9 @@ static guint setup_signalfd(void)
>>
>> static gboolean option_version =3D FALSE;
>>
>> -static gboolean parse_agent(const char *key, const char *value,
>> -                                     gpointer user_data, GError **error=
)
>> -{
>> -     if (value)
>> -             auto_register_agent =3D g_strdup(value);
>> -     else
>> -             auto_register_agent =3D g_strdup("");
>> -
>> -     return TRUE;
>> -}
>> -
>> static GOptionEntry options[] =3D {
>>       { "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
>>                               "Show version information and exit" },
>> -     { "agent", 'a', G_OPTION_FLAG_OPTIONAL_ARG,
>> -                             G_OPTION_ARG_CALLBACK, parse_agent,
>> -                             "Register agent handler", "CAPABILITY" },
>>       { NULL },
>> };
>
> actually leave the agent option and make the argument mandatory. We shoul=
d be registering with =E2=80=9C=E2=80=9D as agent string by default. That e=
nsures that we use the defaults from bluetoothd and mgmt. However the comma=
nd line option can overwrite the IO capability.

Alright, will send a v2 in a moment.

> Regards
>
> Marcel
>



--=20
Luiz Augusto von Dentz
