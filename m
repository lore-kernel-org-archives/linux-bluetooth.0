Return-Path: <cyrus@holtmann.org>
Message-ID: <4ECCC3C4.20509@linux.intel.com>
Date: Wed, 23 Nov 2011 10:58:28 +0100
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 0/2] Add org.bluez.Telephony interface
References: <1321970484-10208-1-git-send-email-frederic.danis@linux.intel.com>	<20111122141502.GD15357@aemeltch-MOBL1>	<4ECBC6A0.7080006@linux.intel.com> <CAKT1EBdHj7E2stDSHT_P2F_O2-O43W6M5NwnPL+_d6ex_gm9nQ@mail.gmail.com>
In-Reply-To: <CAKT1EBdHj7E2stDSHT_P2F_O2-O43W6M5NwnPL+_d6ex_gm9nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Claudio,

Le 22/11/2011 17:41, Claudio Takahasi a écrit :
> Hi Frederic,
>
> On Tue, Nov 22, 2011 at 12:58 PM, Frederic Danis
> <frederic.danis@linux.intel.com>  wrote:
>> Hello Andrei,
>>
>> Le 22/11/2011 15:15, Andrei Emeltchenko a écrit :
>>>>
>>>> First patch add the new org.bluez.Telephony interface and remove
>>>> functions related to AT parsing from audio/headset.c.
>>>>
>>>> Second patch remove the telephony drivers (dummy, maemo5, maemo6
>>>
>>> is this really needed?
>>>
>>> Best regards
>>> Andrei Emeltchenko
>>>
>>
>> During latest BlueZ conf, it has been decided that telephony drivers should
>> be replaced by the telephony D-Bus interface for BlueZ 5.
>
> We will need also platform specific services/plugins to implement BLE
> GATT profiles. Phone Alert Status and Alert Notification need to get/set to
> platform specific information, such as incoming call, mute once, alert
> level, ...
>
> BT SIG designed BR/EDR and BLE GATT profiles avoiding(trying) features
> "overlap". However, from the development point of view the low layer will be
> shared by both. So, please keep the code flexible enough to be used by
> more than one profile.

The new telephony D-Bus interface is just in charge of performing SDP 
publication and RFComm connection. All Telephony related code is managed 
by the agent (i.e. oFono).

I take a look to the Phone Alert Status and Alert Notification and I 
thought that this should be implemented in the agent, or in a BlueZ 
service accessible by the agent through D-Bus.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Centre
frederic.danis@intel.com                              Intel Corporation

