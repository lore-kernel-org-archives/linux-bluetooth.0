Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140521110540.GA22193@t440s.lan>
References: <1399473907-9698-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<20140521110540.GA22193@t440s.lan>
Date: Wed, 21 May 2014 13:55:34 +0200
Message-ID: <CAMv5Gbf_ky6meMzFG42fGv2JaMGx7XdvwPfPa3xZQ4zQqqUMpQ@mail.gmail.com>
Subject: Re: [PATCH] shared/tester: Add support for debug logs for tester
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 21 May 2014 13:05, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Grzegorz,
>
> On Wed, May 07, 2014, Grzegorz Kolodziejczyk wrote:
>> +void tester_debug(const char *format, ...)
>> +{
>> +     va_list ap;
>> +
>> +     if (!tester_use_debug())
>> +             return;
>> +
>> +     printf("   tester-dbg: %s", COLOR_WHITE);
>
> I think it'd be good to make the prefix consistent with the other
> logging functions here. Do we really need to know that a line is a debug
> print? Isn't it simply enough that the line is printed when debugging is
> enabled? I don't see any special identifiers for the other types of logs
> either. So unless there's a good reason to have it I'd just keep this
> consistent with the other logs.
Ok, I agree. I'll send fixed v2.

>
> Johan

Best regards,
Grzegorz
