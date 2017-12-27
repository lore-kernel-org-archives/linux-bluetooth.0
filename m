Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJeW0y6PLS0DN_JoOV7iXuFH4Bf8DtX2n7_qP=R+PhMaQ@mail.gmail.com>
References: <6f0b4053-4936-8d8c-3095-d6326d9a0e93@jp.fujitsu.com>
 <ce0da439-86d4-eafd-80b7-8591e287f5b0@jp.fujitsu.com> <CABBYNZJeW0y6PLS0DN_JoOV7iXuFH4Bf8DtX2n7_qP=R+PhMaQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 27 Dec 2017 16:55:09 -0200
Message-ID: <CABBYNZK6KSAs6ipwmJO1VtpxryRc+zPNvEhesAt6RLFJA1omgg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/8] gdbus: Introduce g_dbus_proxy_path_lookup()
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Wed, Dec 27, 2017 at 4:51 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Eramoto,
>
> On Fri, Dec 22, 2017 at 5:35 AM, ERAMOTO Masaya
> <eramoto.masaya@jp.fujitsu.com> wrote:
>> g_dbus_proxy_path_lookup() returns the path of the proxy that matches the
>> passed text. It also returns the index of the proxy coming next to the
>> matched proxy in the passed list.
>> ---
>>  gdbus/client.c | 19 +++++++++++++++++++
>>  gdbus/gdbus.h  |  1 +
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/gdbus/client.c b/gdbus/client.c
>> index 6ec611455..bb13709be 100644
>> --- a/gdbus/client.c
>> +++ b/gdbus/client.c
>> @@ -26,6 +26,7 @@
>>  #endif
>>
>>  #include <stdio.h>
>> +#include <string.h>
>>  #include <glib.h>
>>  #include <dbus/dbus.h>
>>
>> @@ -371,6 +372,24 @@ GDBusProxy *g_dbus_proxy_lookup(GList *list, const char *path,
>>         return NULL;
>>  }
>>
>> +char *g_dbus_proxy_path_lookup(GList *source, int *index, const char *text)
>> +{
>> +       GList *l;
>> +
>> +       for (l = g_list_nth(source, *index); l; l = g_list_next(l)) {
>> +               GDBusProxy *proxy = l->data;
>> +               const char *path;
>> +
>> +               (*index)++;
>> +
>> +               path = g_dbus_proxy_get_path(proxy);
>> +               if (!strncasecmp(path, text, strlen(text)))
>
> We better move out the strlen(text) portion outside of the for loop.
>
>> +                       return strdup(path);
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>>  static gboolean properties_changed(DBusConnection *conn, DBusMessage *msg,
>>                                                         void *user_data)
>>  {
>> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
>> index 930aa5f77..99f21b3ce 100644
>> --- a/gdbus/gdbus.h
>> +++ b/gdbus/gdbus.h
>> @@ -341,6 +341,7 @@ gboolean g_dbus_proxy_get_property(GDBusProxy *proxy, const char *name,
>>
>>  GDBusProxy *g_dbus_proxy_lookup(GList *list, const char *path,
>>                                                 const char *interface);
>> +char *g_dbus_proxy_path_lookup(GList *source, int *index, const char *text);

I second thought here, why don't we add the index to
g_dbus_proxy_lookup and make it check for NULL interface?

>>  gboolean g_dbus_proxy_refresh_property(GDBusProxy *proxy, const char *name);
>>
>> --
>> 2.14.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
