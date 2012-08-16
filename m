Return-Path: <cyrus@holtmann.org>
Message-id: <69D93B07FE0348AC8E5E38C3EF8D6DB7@sisodomain.com>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1343816803-16228-1-git-send-email-jaganath.k@samsung.com>
 <20120816074909.GA29336@x220>
In-reply-to: <20120816074909.GA29336@x220>
Subject: Re: [PATCH BlueZ v0] gdbus: Fix compilation error if macro "error" is
 defined
Date: Thu, 16 Aug 2012 17:31:59 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

--------------------------------------------------
From: "Johan Hedberg" <johan.hedberg@gmail.com>
Sent: Thursday, August 16, 2012 1:19 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v0] gdbus: Fix compilation error if macro "error" 
is defined

> Hi Jaganath,
>
> On Wed, Aug 01, 2012, Jaganath Kanakkassery wrote:
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
>>  goto fail;
>>
>>  if (g_dbus_args_have_signature(args, signal) == FALSE) {
>> - error("%s.%s: expected signature'%s' but got '%s'",
>> - interface, name, args, signature);
>> + error("%s.%s: got unexpected signature '%s'", interface, name,
>> + dbus_message_get_signature(signal));
>>  ret = FALSE;
>>  goto fail;
>>  }
>
> What's the reason for dropping printing of the value of "args"? I'd
> think that's quite useful in figuring out what went wrong. Even if there
> is a reason to drop it it has nothing to do with fixing the compilation
> error due to undefined "signature" and should therefore be in its own
> patch.
>

"args" is a structure now and that's the reason it is removed and I think
the complete signature of args cannot be available at the point where it is 
printed.
How about changing the commit message to "Correct error message"?

Thanks,
Jaganath 

