Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLeKZ2MhN3ND5On5gAVWVnVM5txHrDe4_Jkyw2no7bJew@mail.gmail.com>
References: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
	<1323358075-27857-8-git-send-email-mikel.astiz@bmw-carit.de>
	<CABBYNZLeKZ2MhN3ND5On5gAVWVnVM5txHrDe4_Jkyw2no7bJew@mail.gmail.com>
Date: Fri, 9 Dec 2011 14:11:22 +0200
Message-ID: <CABBYNZJACKY9M0tc_gk5mVB4bW4FnhrXsMvDA6DtU20ruCUbzA@mail.gmail.com>
Subject: Re: [RFC obexd v2 07/21] client: GetCapabilities moved to session API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz@bmw-carit.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Again,

On Fri, Dec 9, 2011 at 2:07 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>> +static DBusMessage *get_capabilities(DBusConnection *connection,
>> +                                       DBusMessage *message, void *user_data)
>> +{
>> +       struct obc_session *session = user_data;
>> +
>> +       obc_session_pull(session, "x-obex/capability", NULL,
>> +                               capabilities_complete_callback,
>> +                               dbus_message_ref(message));
>
> I guess you should probably mark this method as async, this way you
> don't need to reference the message. Actually I don't think this works
> without it having G_DBUS_METHOD_FLAG_ASYNC, if you return NULL as you
> did bellow gdbus will return DBUS_HANDLER_RESULT_NEED_MEMORY to
> libdbus.
>

Btw we should probably add a watch to the application so we are able
to cancel the request if the application disconnects before we reply.

-- 
Luiz Augusto von Dentz
