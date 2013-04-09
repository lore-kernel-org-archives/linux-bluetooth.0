Return-Path: <cyrus@holtmann.org>
Message-ID: <5163D206.9070000@linux.intel.com>
Date: Tue, 09 Apr 2013 10:32:06 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?=
	<frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 2/6] Bluetooth: Add SCO socket voice_setting option
References: <1363716255-21332-1-git-send-email-frederic.dalleau@linux.intel.com> <1363716255-21332-3-git-send-email-frederic.dalleau@linux.intel.com> <DE6F5576-C7C9-4EA9-B242-3489F0651FBC@holtmann.org> <5162BADF.7010608@linux.intel.com> <562DEF75-6DB8-4AA8-ACD5-40929964BC45@holtmann.org>
In-Reply-To: <562DEF75-6DB8-4AA8-ACD5-40929964BC45@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

 >> #define SCO_SETTINGS  0x03
>> struct sco_settings {
>>         __u16           settings;
>> };
>
> That is my current thinking. However we might start using SOL_BLUETOOTH and start using BT_VOICE or similar as a socket option. I do want to be able to retire SOL_SCO and SOL_L2CAP at some point.

I just forgot about this because I don't use it and this API satisfy my 
needs, but it does not allow to distinguish between host side and 
adapter side mSBC.
Do you still care about this?

Thanks,
Fred

