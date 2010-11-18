Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101118144710.GD7811@jh-x301>
References: <1290017386-23969-1-git-send-email-claudio.takahasi@openbossa.org>
	<1290017386-23969-2-git-send-email-claudio.takahasi@openbossa.org>
	<20101118144710.GD7811@jh-x301>
Date: Thu, 18 Nov 2010 13:25:36 -0200
Message-ID: <AANLkTikKFkhyjCQi4PzWbn4Y6kt3kqhNgvyUv4zNKxAQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] Add Find By Type Value Response encoding/decoding functions
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Nov 18, 2010 at 12:47 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Wed, Nov 17, 2010, Claudio Takahasi wrote:
>> --- a/attrib/att.h
>> +++ b/attrib/att.h
>> @@ -122,6 +122,11 @@ struct att_data_list {
>>       uint8_t **data;
>>  };
>>
>> +struct range {
>> +     uint16_t start;
>> +     uint16_t end;
>> +};
>> +
>
> Since this is in the public header file it should be prefixed with att_,
> right? (which should also apply for all public symbols here). However,
> it seems like you're only using the struct internally in att.c so
> probably it doesn't even need to be in the public header file?
>
> Johan
>

It will be used in the gatttool, attribute server and attribute client.
I gonna add the prefix att_ and resend the patches.

Claudio.
