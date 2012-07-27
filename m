Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v6wwSLa-goWqZfcEtxMmBXpuQzZit-OgHSDYk+x5cPYTw@mail.gmail.com>
References: <1343375053-19193-1-git-send-email-jaganath.k@samsung.com>
	<1343375053-19193-2-git-send-email-jaganath.k@samsung.com>
	<CAMOw1v6wwSLa-goWqZfcEtxMmBXpuQzZit-OgHSDYk+x5cPYTw@mail.gmail.com>
Date: Fri, 27 Jul 2012 15:58:52 +0300
Message-ID: <CABBYNZLUWKcpd_Had_4z_3ig30jhkQr_zFaE4rfDoRVbeg5D-Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gdbus: Fix compilation error if macro "error" is defined
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Fri, Jul 27, 2012 at 3:25 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> On Fri, Jul 27, 2012 at 4:44 AM, Jaganath Kanakkassery
> <jaganath.k@samsung.com> wrote:
>> The variable "signature" used in error is not defined.
>> ---
>>  gdbus/object.c |    3 +--
>>  1 files changed, 1 insertions(+), 2 deletions(-)
>>
>> diff --git a/gdbus/object.c b/gdbus/object.c
>> index 900e7ab..0f05234 100644
>> --- a/gdbus/object.c
>> +++ b/gdbus/object.c
>> @@ -645,8 +645,7 @@ static dbus_bool_t emit_signal_valist(DBusConnection *conn,
>>                 goto fail;
>>
>>         if (g_dbus_args_have_signature(args, signal) == FALSE) {
>> -               error("%s.%s: expected signature'%s' but got '%s'",
>> -                               interface, name, args, signature);
>> +               error("signature does not match");
>
> argh... indeed.
>
> However I'd rather fix it by letting a similar message (without args,
> which have a different type):
>
> error("%s.%s: got unexpected signature '%s'",
>                                interface, name,
> dbus_message_get_signature(signal));

Yep, the message itself can be keep, just fix what is broken.


-- 
Luiz Augusto von Dentz
