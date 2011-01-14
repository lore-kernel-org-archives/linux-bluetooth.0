Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimH2pi+goj0c7Lk6AKRiYDbNQ0fG31WWagz_iZE@mail.gmail.com>
References: <1294915924-17068-1-git-send-email-lkslawek@gmail.com>
	<AANLkTimH2pi+goj0c7Lk6AKRiYDbNQ0fG31WWagz_iZE@mail.gmail.com>
Date: Fri, 14 Jan 2011 08:13:38 +0100
Message-ID: <AANLkTimiV7DRMNPHniyKgja-50fyDc5rSjwGF9Sm6KJk@mail.gmail.com>
Subject: Re: [PATCH] Fix plugin close & disconnect functions call order
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jan 13, 2011 at 6:15 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Thu, Jan 13, 2011 at 12:52 PM,  <lkslawek@gmail.com> wrote:
>> From: Slawomir Bochenski <lkslawek@gmail.com>
>>
>> Normally during an OBEX session, calling sequence
>>
>> service->connect - [driver->open - driver->close]* - service->disconnect
>>
>> is kept. The only exception to this when the connection is reset
>> (when no ABORT was sent) during transfer. Then the sequence is:
>>
>> service->connect - [driver->open - driver->close]* - driver->open -
>> service->disconnect - driver->close
>>
>> This patch fixes it, so memory managament of session/transfer data in
>> service plugin can be easier.
>> ---
>>  src/obex.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/src/obex.c b/src/obex.c
>> index 65f17fc..67684fa 100644
>> --- a/src/obex.c
>> +++ b/src/obex.c
>> @@ -1231,6 +1231,8 @@ static void obex_handle_destroy(void *user_data)
>>
>>        os = OBEX_GetUserData(obex);
>>
>> +       os_reset_session(os);
>> +
>>        if (os->service && os->service->disconnect)
>>                os->service->disconnect(os, os->service_data);
>
> Looks like a good idea, what about removing from os_session_free?
>
>
> --
> Luiz Augusto von Dentz
> Computer Engineer
>

It looks to me that it could be safely removed from
obex_session_free(), as when obex_session_free() is called from
obex_session_start(), struct obex_session *os is in state in which it
does not need reset. In fact it would be required to remove it from
there, otherwise service->reset() would be called twice. The only side
effect is that in case of early error in obex_session_start(),
service->reset() will not be called at all. So the question is whether
this last behaviour is really desired (no other service function
indicating session existence is called before this point)?

-- 
Slawomir Bochenski
