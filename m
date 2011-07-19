Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110719111924.GA17297@dell.ger.corp.intel.com>
References: <1311072514-10572-1-git-send-email-lkslawek@gmail.com>
	<20110719111924.GA17297@dell.ger.corp.intel.com>
Date: Tue, 19 Jul 2011 13:51:06 +0200
Message-ID: <CA+i+Aw1Xh_uDJkznE9cy_m3pjLUCJRC7SiMfkjAe9w6RsGCrtw@mail.gmail.com>
Subject: Re: [PATCH obexd] Fix handling asynchronous plugin reads
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello!

On Tue, Jul 19, 2011 at 1:19 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Slawek,
>
> On Tue, Jul 19, 2011, Slawomir Bochenski wrote:
>> @@ -49,6 +49,7 @@ struct obex_session {
>>       struct obex_mime_type_driver *driver;
>>       gboolean streaming;
>>       gboolean headers_sent;
>> +     gboolean suspended;
>
> There's something redundant or unintuitive about the streaming vs.
> suspended variable naming. I would expect suspended to be the logical
> inverse of streaming, i.e. when streaming == TRUE then suspended ==
> FALSE and vice versa. So one of them shouldn't be needed. And if this is
> not their meaning then they should probably be renamed more intuitively.
> Btw, is any of this relevant once the migration to gobex has been done?
> I think this is something important to keep in mind whenever you do any
> changes due to some quirkiness of OpenOBEX.
>
> Johan
>

The issue is still present in current upstream tree and seems to
prevent MAP from working.

If it goes about names that would be one of streaming_started instead
of streaming *or* streaming_suspended instead of suspended. First one
is used for indication whether streaming was actually started (which
is done once) and the second one is for checking whether chain of
called functions suspended currently streamed body.

-- 
Slawomir Bochenski
