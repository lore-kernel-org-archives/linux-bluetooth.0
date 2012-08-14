Return-Path: <cyrus@holtmann.org>
Message-id: <4055A7F7C23040269F1BF78CA05E2844@sisodomain.com>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
References: <1343816803-16228-1-git-send-email-jaganath.k@samsung.com>
 <CAMOw1v6_boNFVPeuujtzMp409Spd0cPV6-kxmvN31+W9TdgQpg@mail.gmail.com>
In-reply-to: <CAMOw1v6_boNFVPeuujtzMp409Spd0cPV6-kxmvN31+W9TdgQpg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0] gdbus: Fix compilation error if macro "error" is
 defined
Date: Tue, 14 Aug 2012 19:54:36 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

--------------------------------------------------
From: "Lucas De Marchi" <lucas.demarchi@profusion.mobi>
Sent: Monday, August 13, 2012 7:33 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v0] gdbus: Fix compilation error if macro "error" 
is defined

> On Wed, Aug 1, 2012 at 7:26 AM, Jaganath Kanakkassery
> <jaganath.k@samsung.com> wrote:
>> The variable "signature" used in error is not defined.
>> ---
>> v0 -> Made error message as per Lucas's suggestion
>>
>>  gdbus/object.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/gdbus/object.c b/gdbus/object.c
>> index 900e7ab..9689006 100644
>> --- a/gdbus/object.c
>> +++ b/gdbus/object.c
>> @@ -645,8 +645,8 @@ static dbus_bool_t emit_signal_valist(DBusConnection 
>> *conn,
>>                 goto fail;
>>
>>         if (g_dbus_args_have_signature(args, signal) == FALSE) {
>> -               error("%s.%s: expected signature'%s' but got '%s'",
>> -                               interface, name, args, signature);
>> +               error("%s.%s: got unexpected signature '%s'", interface, 
>> name,
>> + 
>> dbus_message_get_signature(signal));
>>                 ret = FALSE;
>>                 goto fail;
>
> Ack.
>
> Lucas De Marchi
> --

Ping.

Thanks,
Jaganath 

