Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OetAmLuiMzZdPFu+TYC4Nh9x9SsJA=YJhYG0fZFe=zkw@mail.gmail.com>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
	<1334786904-26282-16-git-send-email-jprvita@openbossa.org>
	<CAJdJm_OetAmLuiMzZdPFu+TYC4Nh9x9SsJA=YJhYG0fZFe=zkw@mail.gmail.com>
Date: Thu, 26 Apr 2012 16:43:01 -0300
Message-ID: <CAAngNMYNy2i=JqBnPQnCCqYD7VPPsuL3YnpTyZ1hqpZ8ORZsLw@mail.gmail.com>
Subject: Re: [RFC v2 15/16] HoG: Register only one notification callback
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2012/4/20 Anderson Lizardo <anderson.lizardo@openbossa.org>:
> Hi Claudio,
>
> 2012/4/18 João Paulo Rechi Vita <jprvita@openbossa.org>:
>> From: Claudio Takahasi <claudio.takahasi@openbossa.org>
>>
>> Fix registering the notification callback per report. Only one instance
>> of GAttrib callback for all report notifications should be registered.
>> ---
>>  input/hog_device.c |   17 +++++++++++------
>>  1 files changed, 11 insertions(+), 6 deletions(-)
>
> Shouldn't this patch be squashed with some other on this series?
>

I agree with Anderson here, let's fix it before re-sending the whole series.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
