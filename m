Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKtES_LgxOBjx-aaDCKionV039M+mDHF5WJ3SZVAn2ABQ@mail.gmail.com>
References: <1349114021-19067-1-git-send-email-luiz.dentz@gmail.com>
	<1349114021-19067-2-git-send-email-luiz.dentz@gmail.com>
	<CAMOw1v503Fxkx6tD-cN1s_buev89ytSG1P-ngSxUCLk4eMVa6Q@mail.gmail.com>
	<CABBYNZ+f+idjJw1_i4uqoTJTdXMfr1xHAvdpGj4-59vchV+ouA@mail.gmail.com>
	<CAMOw1v5Gcz47GfSNkpccKG2FDwzF1aJQ9nVO2VMKChGQXcP_Cg@mail.gmail.com>
	<CABBYNZKtES_LgxOBjx-aaDCKionV039M+mDHF5WJ3SZVAn2ABQ@mail.gmail.com>
Date: Thu, 4 Oct 2012 11:42:58 +0300
Message-ID: <CABBYNZJwoPJn3JY++98jL+zrTLiPghJpm+9CRdvmKW+4Xx=6cA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 02/10] gdbus: Remove connection from g_dbus_remove_watch
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>, Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Oct 2, 2012 at 4:57 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Tue, Oct 2, 2012 at 1:49 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> On Tue, Oct 2, 2012 at 5:05 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Lucas,
>>>
>>> On Tue, Oct 2, 2012 at 7:23 AM, Lucas De Marchi
>>> <lucas.demarchi@profusion.mobi> wrote:
>>>> On Mon, Oct 1, 2012 at 2:53 PM, Luiz Augusto von Dentz
>>>> <luiz.dentz@gmail.com> wrote:
>>>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>>
>>>>> The connection is not really needed since the list of listeners is
>>>>> global not per connection, besides it is more convenient this way as
>>>>> only the id is needed.
>>>>> ---
>>>>>  gdbus/gdbus.h | 2 +-
>>>>>  gdbus/watch.c | 4 ++--
>>>>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
>>>>> index 0a8a27c..3bd8986 100644
>>>>> --- a/gdbus/gdbus.h
>>>>> +++ b/gdbus/gdbus.h
>>>>> @@ -217,7 +217,7 @@ guint g_dbus_add_signal_watch(DBusConnection *connection,
>>>>>                                 const char *interface, const char *member,
>>>>>                                 GDBusSignalFunction function, void *user_data,
>>>>>                                 GDBusDestroyFunction destroy);
>>>>> -gboolean g_dbus_remove_watch(DBusConnection *connection, guint tag);
>>>>> +gboolean g_dbus_remove_watch(guint id);
>>>>>  void g_dbus_remove_all_watches(DBusConnection *connection);
>>>>>
>>>>>  #ifdef __cplusplus
>>>>> diff --git a/gdbus/watch.c b/gdbus/watch.c
>>>>> index 07feb61..00cedae 100644
>>>>> --- a/gdbus/watch.c
>>>>> +++ b/gdbus/watch.c
>>>>> @@ -285,7 +285,7 @@ static void filter_data_free(struct filter_data *data)
>>>>>                 g_free(l->data);
>>>>>
>>>>>         g_slist_free(data->callbacks);
>>>>> -       g_dbus_remove_watch(data->connection, data->name_watch);
>>>>> +       g_dbus_remove_watch(data->name_watch);
>>>>>         g_free(data->name);
>>>>>         g_free(data->owner);
>>>>>         g_free(data->path);
>>>>> @@ -752,7 +752,7 @@ guint g_dbus_add_signal_watch(DBusConnection *connection,
>>>>>         return cb->id;
>>>>>  }
>>>>>
>>>>> -gboolean g_dbus_remove_watch(DBusConnection *connection, guint id)
>>>>> +gboolean g_dbus_remove_watch(guint id)
>>>>>  {
>>>>>         struct filter_data *data;
>>>>>         struct filter_callback *cb;
>>>>> --
>>>>
>>>> This will lead to a broken build which is not nice to bisect. Any
>>>> other option besides adding with another name, converting everybody
>>>> and then renaming?
>>>>
>>>> The only other option I can think of is adding an ifdef and an option
>>>> to build-sys... this would avoid the final renaming.
>>>
>>> I guess this time it worth having the break of bisect in favor of a
>>> more convenient API, if you look at what the code is doing the
>>> connection is useless and normally we end up having to call the core
>>> to figure out a connection that is not used for anything.
>>
>> Ahn? did you read what I proposed as an option? I proposed splitting
>> the patch in 4 as opposed to 2 as you did.
>>
>> 0001) WARNING, whitespace error below
>>
>> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
>> index 0a8a27c..d254562 100644
>> --- a/gdbus/gdbus.h
>> +++ b/gdbus/gdbus.h
>> @@ -217,7 +217,12 @@ guint g_dbus_add_signal_watch(DBusConnection *connection,
>>                                 const char *interface, const char *member,
>>                                 GDBusSignalFunction function, void *user_data,
>>                                 GDBusDestroyFunction destroy);
>> -gboolean g_dbus_remove_watch(DBusConnection *connection, guint tag);
>> +#ifdef _GDBUS_WITH_NEW_REMOVE_WATCH
>> +gboolean g_dbus_remove_watch(guint tag);
>> +#else
>> +gboolean g_dbus_remove_watch(DBusConnection *connection, guint tag);
>> +#endif
>> +
>>  void g_dbus_remove_all_watches(DBusConnection *connection);
>>
>>  #ifdef __cplusplus
>>
>>
>> 0002) Convert everybody adding the definition on Makefile.am
>>
>> 0003) Remove the define from Makefile.am
>>
>> 0004) Remove the old code from gdbus/
>
> That sounds overkill for so simple change, I will send updates to
> other projects using gdbus to see their reception, if they are
> receptive to the changes I think we can ignore the bisect problem.

Apparently you raised some concerns about this changes, but note that
this should not affect watches to different/private connections since
the watch itself carries a reference to the connection, in fact if you
look at the changes the connection given as parameter is completely
ignored, you could even pass NULL and it would still work.

-- 
Luiz Augusto von Dentz
