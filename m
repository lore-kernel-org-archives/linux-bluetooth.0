Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKhtgBtba1nuhDFu6YK+dQ7n5FJ4v570p-qBKE070TCxQ@mail.gmail.com>
References: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
	<1323358075-27857-14-git-send-email-mikel.astiz@bmw-carit.de>
	<CABBYNZKhtgBtba1nuhDFu6YK+dQ7n5FJ4v570p-qBKE070TCxQ@mail.gmail.com>
Date: Fri, 9 Dec 2011 14:31:34 +0200
Message-ID: <CABBYNZJPnJnrqv7tZBhZw2GETu+v=5fbUVAorcZ6gZw_42RGQw@mail.gmail.com>
Subject: Re: [RFC obexd v2 13/21] client: ObjectPush sessions return transports
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz@bmw-carit.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Dec 9, 2011 at 2:29 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> hmm, I think transfer should be the return of obc_session_put and the
> err the parameter.
>
>>                g_free(basename);
>>                return g_dbus_create_error(message,
>>                                ERROR_INF ".Failed", NULL);
>>        }
>>
>> -       return dbus_message_new_method_return(message);
>> -}
>> +       path = obc_transfer_get_path(transfer);
>>
>> -static void pull_complete_callback(struct obc_session *session,
>> -                                       GError *err,
>> -                                       const struct obc_transfer *transfer,
>> -                                       void *user_data)
>> -{
>> -       struct pull_data *data = user_data;
>> -
>> -       if (err != NULL) {
>> -               DBusMessage *error = g_dbus_create_error(data->message,
>> -                                       ERROR_INF ".Failed",
>> -                                       "%s", err->message);
>> -               g_dbus_send_message(data->connection, error);
>> -               goto done;
>> -       }
>> +       reply = dbus_message_new_method_return(message);
>>
>> -       g_dbus_send_reply(data->connection, data->message, DBUS_TYPE_INVALID);
>> +       dbus_message_append_args(reply,
>> +                       DBUS_TYPE_OBJECT_PATH, &path,
>> +                       DBUS_TYPE_INVALID);
>>
>> -done:
>> -       dbus_message_unref(data->message);
>> -       dbus_connection_unref(data->connection);
>> +       return reply;
>>  }
>>
>>  static DBusMessage *opp_pull_business_card(DBusConnection *connection,
>> @@ -102,9 +86,11 @@ static DBusMessage *opp_pull_business_card(DBusConnection *connection,
>>                                                void *user_data)
>>  {
>>        struct opp_data *opp = user_data;
>> -       struct pull_data *data;
>>        DBusMessageIter iter;
>>        const char *filename = NULL;
>> +       DBusMessage *reply;
>> +       struct obc_transfer *transfer;
>> +       const char *path;
>>
>>        dbus_message_iter_init(message, &iter);
>>
>> @@ -114,20 +100,19 @@ static DBusMessage *opp_pull_business_card(DBusConnection *connection,
>>
>>        dbus_message_iter_get_basic(&iter, &filename);
>>
>> -       data = g_try_malloc0(sizeof(*data));
>> -       if (!data)
>> -               return g_dbus_create_error(message,
>> -                               ERROR_INF ".Failed", "No Memory");
>> +       obc_session_get_mem(opp->session, "text/x-vcard", filename,
>> +                                               NULL, 0, NULL, NULL,
>> +                                               &transfer);
>
> I thought we gonna store vcards in files too so we don't have to store
> everything in memory and then copy again to the application over
> D-Bus.

Forgot to tell you that there is a typo in the commit message, it
should be transfers instead of transports.

-- 
Luiz Augusto von Dentz
