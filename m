Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4F27EC83.3020502@bmw-carit.de>
References: <1327937436-15480-1-git-send-email-luiz.dentz@gmail.com>
	<1327937436-15480-3-git-send-email-luiz.dentz@gmail.com>
	<4F27EC83.3020502@bmw-carit.de>
Date: Tue, 31 Jan 2012 08:39:56 -0800
Message-ID: <CABBYNZJgNc_Dz5Z8hdBcYq0gJY4Ar3Wt+hRbvrCiUkRWUHo_aA@mail.gmail.com>
Subject: Re: [PATCH obexd 03/13] client: fix not queuing requests properly
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz@bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Jan 31, 2012 at 5:28 AM, Mikel Astiz <mikel.astiz@bmw-carit.de> wrote:
>> -struct pending_data {
>> -       session_callback_t cb;
>> +struct pending_request {
>>         struct obc_session *session;
>>         struct obc_transfer *transfer;
>> +       session_callback_t auth_complete;
>
>
> I don't see the need to have a GError* as a parameter to the auth_complete
> ballback. It looks like a type reuse, but I'd suggest replacing the callback
> type with another specific one.

Yep, we can use GCallback or something similar, gonna fix that.

>>         /* Unregister any pending transfer */
>> -       while (l) {
>> -               struct obc_transfer *transfer = l->data;
>> -
>> -               l = l->next;
>> -
>> -               obc_session_remove_transfer(session, transfer);
>> -       }
>> +       while ((p = g_queue_pop_head(session->queue)))
>> +               pending_request_free(p);
>
>
> Would it simpler to use g_queue_foreach just like in session_free?

Yep gonna fix this too.

>>
>> -       pending->cb(pending->session, NULL, transfer);
>> -       g_free(pending);
>> +       p->auth_complete(p->session, NULL, transfer);
>
>
> It seems like (auth_complete != NULL) should be checked here, or otherwise
> the check in session_request_reply should be removed.

Yep

-- 
Luiz Augusto von Dentz
