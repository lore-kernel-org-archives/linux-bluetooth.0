Return-Path: <cyrus@holtmann.org>
Message-ID: <4ECBC6A0.7080006@linux.intel.com>
Date: Tue, 22 Nov 2011 16:58:24 +0100
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 0/2] Add org.bluez.Telephony interface
References: <1321970484-10208-1-git-send-email-frederic.danis@linux.intel.com> <20111122141502.GD15357@aemeltch-MOBL1>
In-Reply-To: <20111122141502.GD15357@aemeltch-MOBL1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Andrei,

Le 22/11/2011 15:15, Andrei Emeltchenko a écrit :
>> First patch add the new org.bluez.Telephony interface and remove
>> functions related to AT parsing from audio/headset.c.
>>
>> Second patch remove the telephony drivers (dummy, maemo5, maemo6
>
> is this really needed?
>
> Best regards
> Andrei Emeltchenko
>

During latest BlueZ conf, it has been decided that telephony drivers 
should be replaced by the telephony D-Bus interface for BlueZ 5.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Centre
frederic.danis@intel.com                              Intel Corporation

