Return-Path: <cyrus@holtmann.org>
Message-ID: <516443F7.7030207@linux.intel.com>
Date: Tue, 09 Apr 2013 18:38:15 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?=
 <frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 2/6] Bluetooth: Add SCO socket voice_setting option
References: <1363716255-21332-1-git-send-email-frederic.dalleau@linux.intel.com> <1363716255-21332-3-git-send-email-frederic.dalleau@linux.intel.com> <DE6F5576-C7C9-4EA9-B242-3489F0651FBC@holtmann.org> <5162BADF.7010608@linux.intel.com> <562DEF75-6DB8-4AA8-ACD5-40929964BC45@holtmann.org> <5163D206.9070000@linux.intel.com> <EA2DBE3E-3266-4F27-BE89-87A6EB5979B8@holtmann.org>
In-Reply-To: <EA2DBE3E-3266-4F27-BE89-87A6EB5979B8@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Le 09/04/2013 17:30, Marcel Holtmann a écrit :
> Hi Fred,
>
>>>> #define SCO_SETTINGS  0x03
>>>> struct sco_settings {
>>>>         __u16           settings;
>>>> };
>>>
>>> That is my current thinking. However we might start using SOL_BLUETOOTH and start using BT_VOICE or similar as a socket option. I do want to be able to retire SOL_SCO and SOL_L2CAP at some point.
>>
>> I just forgot about this because I don't use it and this API satisfy my needs, but it does not allow to distinguish between host side and adapter side mSBC.
>> Do you still care about this?
>
> what do you mean by host side and adapter side difference? I am not following.

I was thinking that an adapter could do some adapter side mSBC similar 
to the way SCO over PCM works. (ie when connected the adapter 
automatically encode and forward packet to/from his PCM port).
If it doesn't make sense, just forget about it.

The socket option would look like this (in bluetooth.h) :

#define BT_VOICE  11
struct bt_voice {
	__u16 setting;
};

#define BT_VOICE_TRANSPARENT  0x0003
#define BT_VOICE_CVSD         0x0060

Regards,
Fred
