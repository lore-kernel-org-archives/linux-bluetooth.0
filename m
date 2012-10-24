Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121023131633.GA12443@pzkagis.cz>
References: <1350640763-24186-1-git-send-email-luiz.dentz@gmail.com>
	<20121023131633.GA12443@pzkagis.cz>
Date: Wed, 24 Oct 2012 10:51:07 +0200
Message-ID: <CABBYNZKDsz=Go0gOPJXTReqk=8NnHtFF3=zSmR58B+m2KhEkVQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] AVDTP: Do not keep a internal reference
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ludek Finstrle <luf@pzkagis.cz>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ludek,

On Tue, Oct 23, 2012 at 3:16 PM, Ludek Finstrle <luf@pzkagis.cz> wrote:
>> +     avdtp_cancel_authorization(session);
>
> Why do you call avdtp_cancel_authorization here? It's useless as above you have
> in the same function:
>         if (session->state != AVDTP_SESSION_STATE_DISCONNECTED)
>                 avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
>
> and the first if statement inf avdtp_cancel_authorization is to check if the
> state is AVDTP_SESSION_STATE_CONNECTING (otherwise return).

Right, that could be removed then.

> See below. Why you deinitialize the session different way for ref=0?
>
>> +     else if (session->ref > 0)
>> +             connection_lost(session, ETIMEDOUT);
>> +     else {
>> +             struct avdtp_server *server = session->server;
>> +
>> +             server->sessions = g_slist_remove(server->sessions, session);
>> +             avdtp_free(session);
>> +     }

The reason is simple, if there is nobody holding a reference it is
useless to call connection_lost.

> If I change whole block above (starting else if ((session->ref > 0)) this
> way it works with N900 as expected:
>
>         else {
>                 connection_lost(session, ETIMEDOUT);
>
>                 if (session->ref <= 0) {
>                         struct avdtp_server *server = session->server;
>
>                         server->sessions = g_slist_remove(server->sessions, session);
>                         avdtp_free(session);
>                 }
>         }

hmm, that actually make sense if the caller releases its reference on
connection_lost then we can free immediately but the mystery here is
how you end up in disconnect_timeout if there are still a reference
being held.

-- 
Luiz Augusto von Dentz
