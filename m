Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4ECBC6A0.7080006@linux.intel.com>
References: <1321970484-10208-1-git-send-email-frederic.danis@linux.intel.com>
	<20111122141502.GD15357@aemeltch-MOBL1>
	<4ECBC6A0.7080006@linux.intel.com>
Date: Tue, 22 Nov 2011 13:41:06 -0300
Message-ID: <CAKT1EBdHj7E2stDSHT_P2F_O2-O43W6M5NwnPL+_d6ex_gm9nQ@mail.gmail.com>
Subject: Re: [RFC 0/2] Add org.bluez.Telephony interface
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Tue, Nov 22, 2011 at 12:58 PM, Frederic Danis
<frederic.danis@linux.intel.com> wrote:
> Hello Andrei,
>
> Le 22/11/2011 15:15, Andrei Emeltchenko a écrit :
>>>
>>> First patch add the new org.bluez.Telephony interface and remove
>>> functions related to AT parsing from audio/headset.c.
>>>
>>> Second patch remove the telephony drivers (dummy, maemo5, maemo6
>>
>> is this really needed?
>>
>> Best regards
>> Andrei Emeltchenko
>>
>
> During latest BlueZ conf, it has been decided that telephony drivers should
> be replaced by the telephony D-Bus interface for BlueZ 5.

We will need also platform specific services/plugins to implement BLE
GATT profiles. Phone Alert Status and Alert Notification need to get/set to
platform specific information, such as incoming call, mute once, alert
level, ...

BT SIG designed BR/EDR and BLE GATT profiles avoiding(trying) features
"overlap". However, from the development point of view the low layer will be
shared by both. So, please keep the code flexible enough to be used by
more than one profile.

BR,
Claudio.
