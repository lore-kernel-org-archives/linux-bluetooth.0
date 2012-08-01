Return-Path: <cyrus@holtmann.org>
Message-id: <13C5CB6136E1426BB655FBA1B4DD33AB@sisodomain.com>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
References: <1343375053-19193-1-git-send-email-jaganath.k@samsung.com>
 <1343375053-19193-2-git-send-email-jaganath.k@samsung.com>
 <CAMOw1v6wwSLa-goWqZfcEtxMmBXpuQzZit-OgHSDYk+x5cPYTw@mail.gmail.com>
In-reply-to: <CAMOw1v6wwSLa-goWqZfcEtxMmBXpuQzZit-OgHSDYk+x5cPYTw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gdbus: Fix compilation error if macro "error" is
 defined
Date: Wed, 01 Aug 2012 15:47:23 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

--------------------------------------------------
From: "Lucas De Marchi" <lucas.demarchi@profusion.mobi>
Sent: Friday, July 27, 2012 5:55 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] gdbus: Fix compilation error if macro "error" is 
defined

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
>> @@ -645,8 +645,7 @@ static dbus_bool_t emit_signal_valist(DBusConnection 
>> *conn,
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
>                               interface, name,
> dbus_message_get_signature(signal));
>

Ok, I will raise patch.

Thanks,
Jaganath 

