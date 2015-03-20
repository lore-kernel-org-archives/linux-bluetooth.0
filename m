Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <632611D4-C2C5-415F-8990-1820468BE68E@holtmann.org>
References: <1426786477-27229-1-git-send-email-jamuraa@chromium.org>
	<1426786477-27229-4-git-send-email-jamuraa@chromium.org>
	<CABBYNZ+4MQbhXTFZpjq7G7QUZasoHHd1xLAdtuj-1+nwdrkdWQ@mail.gmail.com>
	<CAJLTA8i=idW6dDBNcsbEf=3pEVSUNU_AooGGaO2LEE++3J-_Wg@mail.gmail.com>
	<632611D4-C2C5-415F-8990-1820468BE68E@holtmann.org>
Date: Fri, 20 Mar 2015 17:44:17 +0200
Message-ID: <CABBYNZKPBua2vh+d_roQ26A8SFHDcAJX-Vq2hbn6uK==LExJXA@mail.gmail.com>
Subject: Re: [BlueZ v3 03/15] gdbus/client: add g_dbus_proxy_set_read_watch
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Michael Janssen <jamuraa@chromium.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Michael,

On Fri, Mar 20, 2015 at 5:39 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Michael,
>
>>>> Adds a new gdbus utility function which will set a function to be called
>>>> after the properties of a proxy are updated.
>>>>
>>>> This enables using GDBusClient for objects without the ObjectManager
>>>> interface as long as you know in advance the object path using
>>>> g_dbus_proxy_new
>>>> ---
>>>> gdbus/client.c | 17 +++++++++++++++++
>>>> gdbus/gdbus.h  |  3 +++
>>>> 2 files changed, 20 insertions(+)
>>>>
>>>> diff --git a/gdbus/client.c b/gdbus/client.c
>>>> index fe0c0db..c913773 100644
>>>> --- a/gdbus/client.c
>>>> +++ b/gdbus/client.c
>>>> @@ -76,6 +76,8 @@ struct GDBusProxy {
>>>>        void *prop_data;
>>>>        GDBusProxyFunction removed_func;
>>>>        void *removed_data;
>>>> +       GDBusProxyFunction read_func;
>>>> +       void *read_data;
>>>> };
>>>>
>>>> struct prop_entry {
>>>> @@ -297,6 +299,9 @@ static void get_all_properties_reply(DBusPendingCall *call, void *user_data)
>>>>
>>>>        update_properties(proxy, &iter, FALSE);
>>>>
>>>> +       if (proxy->read_func)
>>>> +               proxy->read_func(proxy, proxy->read_data);
>>>> +
>>>> done:
>>>>        if (g_list_find(client->proxy_list, proxy) == NULL) {
>>>>                if (client->proxy_added)
>>>> @@ -914,6 +919,18 @@ gboolean g_dbus_proxy_set_removed_watch(GDBusProxy *proxy,
>>>>        return TRUE;
>>>> }
>>>>
>>>> +gboolean g_dbus_proxy_set_read_watch(GDBusProxy *proxy,
>>>> +                               GDBusProxyFunction function, void *user_data)
>>>> +{
>>>> +       if (proxy == NULL)
>>>> +               return FALSE;
>>>> +
>>>> +       proxy->read_func = function;
>>>> +       proxy->read_data = user_data;
>>>> +
>>>> +       return TRUE;
>>>> +}
>>>> +
>>>> static void refresh_properties(GDBusClient *client)
>>>> {
>>>>        GList *list;
>>>> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
>>>> index 9814838..ae281d9 100644
>>>> --- a/gdbus/gdbus.h
>>>> +++ b/gdbus/gdbus.h
>>>> @@ -353,6 +353,9 @@ gboolean g_dbus_proxy_set_property_watch(GDBusProxy *proxy,
>>>> gboolean g_dbus_proxy_set_removed_watch(GDBusProxy *proxy,
>>>>                        GDBusProxyFunction destroy, void *user_data);
>>>>
>>>> +gboolean g_dbus_proxy_set_read_watch(GDBusProxy *proxy,
>>>> +                       GDBusProxyFunction ready, void *user_data);
>>>
>>> Is this supposed to be ready or read watch, Id say this is a ready
>>> watch? Also you should name the callback consistently in one place you
>>> call it ready and in the other function, I would go with the later.
>>>
>>> Btw, it looks like this would still trigger proxy added callback so I
>>> wonder why you did not use it instead of creating a new callback?
>>
>> It is called a read watch because it will be called whenever the
>> properties are all updated on the proxy.  I would expect a ready watch
>> to remove itself after it is done.
>
> we use the term "ready" before and never "read". So I would rename this. If the caller wants to remove the watch afterwards that is fine, but that is irrelevant.

Yep, I would prefer to use ready, but as I commented before this
perhaps is not necessary because even if the user create the proxy
without the use of ObjectManager we still notify via proxy_added in
get_all_properties_reply so I wonder if it is really necessary to have
another callback?


-- 
Luiz Augusto von Dentz
