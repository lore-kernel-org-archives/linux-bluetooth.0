Return-Path: <cyrus@holtmann.org>
Message-ID: <4CE2889F.8050900@openbossa.org>
Date: Tue, 16 Nov 2010 08:35:27 -0500
From: Sheldon Demario <sheldon.demario@openbossa.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Adding a new option to specify medium security level
 for gatttool
References: <1289424095-26628-1-git-send-email-sheldon.demario@openbossa.org> <20101111205448.GA22890@jh-x301>
In-Reply-To: <20101111205448.GA22890@jh-x301>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Johan,

  --sec-level seems more clear than --security to me, because it makes 
explicit that the option is about "level". But is easy to change if you 
want to.

Sheldon

On 11/11/2010 03:54 PM, Johan Hedberg wrote:
> Hi Sheldon,
>
> On Wed, Nov 10, 2010, Sheldon Demario wrote:
>> -- Add command line support to use medium instead of (default) low
>> -  security level with gatttool (--sec-level)
>> -
>> -  Priority: Low
>> -  Complexity: C1
>> -
> <snip>
>> +	{ "sec-medium", 's', 0, G_OPTION_ARG_NONE,&opt_medium_sec,
>> +		"Use medium instead of default low security level",
>> +		NULL},
> Maybe the TODO entry should have been more clear, but I'd prefer if the
> option would be of the format "--sec-level<level>" where<level>  is
> "low", "medium" or "high". I'm not completely sure I like --sec-level
> either (even though I did write the original TODO entry :) What do you
> think about simply "--security<level>"?
>
> Johan

