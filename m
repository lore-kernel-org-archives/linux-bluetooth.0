Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101111091857.GA2862@jh-x301>
References: <1289426161-10045-1-git-send-email-claudio.takahasi@openbossa.org>
	<1289426161-10045-3-git-send-email-claudio.takahasi@openbossa.org>
	<20101111091857.GA2862@jh-x301>
Date: Thu, 11 Nov 2010 11:20:50 -0200
Message-ID: <AANLkTinhT+sauN0HXPom_53i6FRQWDjeSLeBaneLwAmb@mail.gmail.com>
Subject: Re: [PATCH] Add a new configuration option to disable Low Energy support
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Nov 11, 2010 at 7:18 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Wed, Nov 10, 2010, Claudio Takahasi wrote:
>> @@ -623,6 +624,9 @@ int attrib_server_init(void)
>>
>>       sdp_handle = record->handle;
>>
>> +     if (!main_opts.le)
>> +             return 0;
>> +
>
> If the option is called "le" it shouldn't affect GATT over BR/EDR, so I
> think the check in attrib_server_init should only affect the LE socket
> (or then rename the option to e.g. main.opts.attrib).
>
> Johan
>


It is not affecting GATT over BR/EDR. bt_io_listen for BR/EDR is above
this checking.

My patch "[PATCH] Fix possible memory leak of the GIOChannel in the
attribute server" switched the order of the bt_io_listen calls between
BR/EDR and LE. I forgot to send these patches as patch sequence.

Claudio.
