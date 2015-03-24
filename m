Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25TkwtuSAPGoqf2+p1ikqLNA+3Os+VtaU-FpAUhPhpzvkQ@mail.gmail.com>
References: <1427139103-26441-1-git-send-email-jpawlowski@google.com>
	<1427139103-26441-5-git-send-email-jpawlowski@google.com>
	<CAHrH25TkwtuSAPGoqf2+p1ikqLNA+3Os+VtaU-FpAUhPhpzvkQ@mail.gmail.com>
Date: Tue, 24 Mar 2015 01:04:05 -0700
Message-ID: <CAD0=r8w6VRaSDgGiiQ2mSftX0d6Qt6EGu-j_715vPi0QENBNOg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] core: adapter: properly set the filter for each
 discovery client
From: Jakub Pawlowski <jpawlowski@google.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 23, 2015 at 5:42 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Jakub,
>
>> On Mon, Mar 23, 2015 at 12:31 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>> This patch adds logic for properly setting, updating and deleting
>> discovery filter for each client.
>
> Saying "properly set" makes me think that your code used to
> "improperly" set the filters, so I'd just drop that entirely.
>
fixed
>>
>> Note that the filter is not used yet, making proper use from filter
>> will be added in following patches.
>> ---
>>  src/adapter.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 116 insertions(+), 8 deletions(-)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index f57b58c..672f550 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -158,6 +158,7 @@ struct watch_client {
>>         struct btd_adapter *adapter;
>>         char *owner;
>>         guint watch;
>> +       struct discovery_filter *discovery_filter;
>>  };
>>
>>  struct service_auth {
>> @@ -207,6 +208,9 @@ struct btd_adapter {
>>         uint8_t discovery_enable;       /* discovery enabled/disabled */
>>         bool discovery_suspended;       /* discovery has been suspended */
>>         GSList *discovery_list;         /* list of discovery clients */
>> +       GSList *set_filter_list;        /* list of clients that specified
>> +                                        * filter, but don't scan yet
>> +                                        */
>>         GSList *discovery_found;        /* list of found devices */
>>         guint discovery_idle_timeout;   /* timeout between discovery runs */
>>         guint passive_scan_timeout;     /* timeout between passive scans */
>> @@ -1355,6 +1359,17 @@ static uint8_t get_current_type(struct btd_adapter *adapter)
>>         return type;
>>  }
>>
>> +static void free_discovery_filter(struct discovery_filter *discovery_filter)
>> +{
>> +       if (!discovery_filter)
>> +               return;
>
> Since this is an internal function, I wouldn't have this above check
> without a particular use for it. Basically, the sites that call this
> code should make sure that discovery_filter isn't NULL when this gets
> called.
>
isn't it better to have this check once here, than 3 times in different places?
>> +
>> +       if (discovery_filter->uuids)
>
> I think this check is unnecessary; afaik g_slist_free_full should
> treat a NULL value as an empty GSList. I'd still test for this of
> course.
>
fixed.
>> +               g_slist_free_full(discovery_filter->uuids, g_free);
>> +
>> +       g_free(discovery_filter);
>> +}
>> +
>>  static void trigger_start_discovery(struct btd_adapter *adapter, guint delay);
>>
>>  static void start_discovery_complete(uint8_t status, uint16_t length,
>> @@ -1654,9 +1669,17 @@ static void discovery_destroy(void *user_data)
>>
>>         DBG("owner %s", client->owner);
>>
>> +       adapter->set_filter_list = g_slist_remove(adapter->set_filter_list,
>> +                                                               client);
>> +
>>         adapter->discovery_list = g_slist_remove(adapter->discovery_list,
>>                                                                 client);
>>
>> +       if (client->discovery_filter != NULL) {
>
> if (!client->discovery_filter) {
>
fixed
>> +               free_discovery_filter(client->discovery_filter);
>> +               client->discovery_filter = NULL;
>> +       }
>> +
>>         g_free(client->owner);
>>         g_free(client);
>>
>> @@ -1693,6 +1716,9 @@ static void discovery_disconnect(DBusConnection *conn, void *user_data)
>>
>>         DBG("owner %s", client->owner);
>>
>> +       adapter->set_filter_list = g_slist_remove(adapter->set_filter_list,
>> +                                                               client);
>> +
>>         adapter->discovery_list = g_slist_remove(adapter->discovery_list,
>>                                                                 client);
>>
>> @@ -1748,16 +1774,28 @@ static DBusMessage *start_discovery(DBusConnection *conn,
>>         if (list)
>>                 return btd_error_busy(msg);
>>
>> -       client = g_new0(struct watch_client, 1);
>> +       /* If client called SetDiscoveryFilter before, use pre-set filter. */
>> +       list = g_slist_find_custom(adapter->set_filter_list, sender,
>> +                                  compare_sender);
>>
>> -       client->adapter = adapter;
>> -       client->owner = g_strdup(sender);
>> -       client->watch = g_dbus_add_disconnect_watch(dbus_conn, sender,
>> -                                               discovery_disconnect, client,
>> -                                               discovery_destroy);
>> +       if (list) {
>> +               client = list->data;
>> +               adapter->set_filter_list = g_slist_remove(
>> +                                              adapter->set_filter_list, list);
>> +       } else {
>> +               client = g_new0(struct watch_client, 1);
>> +
>> +               client->adapter = adapter;
>> +               client->owner = g_strdup(sender);
>> +               client->discovery_filter = NULL;
>> +               client->watch = g_dbus_add_disconnect_watch(dbus_conn, sender,
>> +                                                       discovery_disconnect,
>> +                                                       client,
>> +                                                       discovery_destroy);
>> +       }
>>
>>         adapter->discovery_list = g_slist_prepend(adapter->discovery_list,
>> -                                                               client);
>> +                                                 client);
>>
>>         /*
>>          * Just trigger the discovery here. In case an already running
>> @@ -1922,8 +1960,9 @@ static DBusMessage *set_discovery_filter(DBusConnection *conn,
>>                                          DBusMessage *msg, void *user_data)
>>  {
>>         struct btd_adapter *adapter = user_data;
>> +       struct watch_client *client;
>>         struct discovery_filter *discovery_filter;
>> -
>> +       GSList *list;
>>         const char *sender = dbus_message_get_sender(msg);
>>
>>         DBG("sender %s", sender);
>> @@ -1935,6 +1974,63 @@ static DBusMessage *set_discovery_filter(DBusConnection *conn,
>>         if (!parse_discovery_filter_dict(&discovery_filter, msg))
>>                 return btd_error_invalid_args(msg);
>>
>> +       list = g_slist_find_custom(adapter->discovery_list, sender,
>> +                                  compare_sender);
>> +
>> +       if (!list) {
>> +               /* Client is not running any form of discovery. */
>> +               GSList *filter_list;
>> +
>> +               /* Check wether client already pre-set his filter. */
>
> s/wether/whether/
>
fixed
>> +               filter_list = g_slist_find_custom(adapter->set_filter_list,
>> +                                                  sender, compare_sender);
>> +
>> +               if (filter_list) {
>> +                       client = filter_list->data;
>> +                       free_discovery_filter(client->discovery_filter);
>> +
>> +                       if (discovery_filter != NULL) {
>
> if (!discovery_filter) {
>
fixed
>> +                               /* just update existing pre-set filter */
>> +                               client->discovery_filter = discovery_filter;
>> +                               DBG("successfully modified pre-set filter");
>> +                               return dbus_message_new_method_return(msg);
>> +                       }
>> +
>> +                       /* Removing pre-set filter */
>> +                       adapter->set_filter_list = g_slist_remove(
>> +                                                     adapter->set_filter_list,
>> +                                                     client);
>> +                       g_free(client->owner);
>> +                       g_free(client);
>> +                       DBG("successfully cleared pre-set filter");
>> +                       return dbus_message_new_method_return(msg);
>> +               }
>> +               /* Client haven't pre-set his filter yet. */
>> +
>> +               /* If there's no filter, no need to do anything. */
>> +               if (discovery_filter == NULL)
>
> if (!discovery_filter) {
>
fied
>> +                       return dbus_message_new_method_return(msg);
>> +
>> +               /* Client pre-setting his filter for first time */
>> +               client = g_new0(struct watch_client, 1);
>> +               client->adapter = adapter;
>> +               client->owner = g_strdup(sender);
>> +               client->discovery_filter = discovery_filter;
>> +               client->watch = g_dbus_add_disconnect_watch(dbus_conn, sender,
>> +                                               discovery_disconnect, client,
>> +                                               discovery_destroy);
>
> This code is being repeated here and above for start_discovery_filter
> and you're ending up with these huge nested if-else statements which
> makes this code too hard to follow. I'd simplify this a little. Maybe
> create a helper function that simply returns you a watch_client by
> looking it up in both filter list and discovery list (perhaps we don't
> even need to have both lists, e.g. you could add a filed to
> watch_client that indicates whether or not discovery is in progress).
> Something like:
>
> client = get_discovery_client(adapter, owner);
>
> This automatically allocates one and inserts it in the appropriate
> list automatically. Then you won't need these repeated look ups.
>
I've made method similar to what you wanted, it greatly simplified code. Thanks!

>> +               adapter->set_filter_list = g_slist_prepend(
>> +                                            adapter->set_filter_list, client);
>> +
>> +               DBG("successfully pre-set filter");
>> +               return dbus_message_new_method_return(msg);
>> +       }
>> +
>> +       /* Client have already started discovery. */
>> +       client = list->data;
>> +       free_discovery_filter(client->discovery_filter);
>> +       client->discovery_filter = discovery_filter;
>> +
>>         return btd_error_failed(msg, "Not implemented yet");
>>  }
>>
>> @@ -5160,6 +5256,18 @@ static void adapter_stop(struct btd_adapter *adapter)
>>
>>         cancel_passive_scanning(adapter);
>>
>> +       while (adapter->set_filter_list) {
>> +               struct watch_client *client;
>> +
>> +               client = adapter->set_filter_list->data;
>> +
>> +               /* g_dbus_remove_watch will remove the client from the
>> +                * adapter's list and free it using the discovery_destroy
>> +                * function.
>> +                */
>> +               g_dbus_remove_watch(dbus_conn, client->watch);
>> +       }
>> +
>>         while (adapter->discovery_list) {
>>                 struct watch_client *client;
>>
>> --
>> 2.2.0.rc0.207.ga3a616c
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Thanks,
> Arman
