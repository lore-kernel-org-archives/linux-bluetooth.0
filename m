Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v4 2/6] Bluetooth: Add SCO socket voice_setting option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5163D206.9070000@linux.intel.com>
Date: Tue, 9 Apr 2013 08:30:29 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EA2DBE3E-3266-4F27-BE89-87A6EB5979B8@holtmann.org>
References: <1363716255-21332-1-git-send-email-frederic.dalleau@linux.intel.com> <1363716255-21332-3-git-send-email-frederic.dalleau@linux.intel.com> <DE6F5576-C7C9-4EA9-B242-3489F0651FBC@holtmann.org> <5162BADF.7010608@linux.intel.com> <562DEF75-6DB8-4AA8-ACD5-40929964BC45@holtmann.org> <5163D206.9070000@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_DALLEAU?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> >> #define SCO_SETTINGS  0x03
>>> struct sco_settings {
>>>        __u16           settings;
>>> };
>> 
>> That is my current thinking. However we might start using SOL_BLUETOOTH and start using BT_VOICE or similar as a socket option. I do want to be able to retire SOL_SCO and SOL_L2CAP at some point.
> 
> I just forgot about this because I don't use it and this API satisfy my needs, but it does not allow to distinguish between host side and adapter side mSBC.
> Do you still care about this?

what do you mean by host side and adapter side difference? I am not following.

Regards

Marcel

