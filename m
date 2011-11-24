Return-Path: <cyrus@holtmann.org>
Message-ID: <4ECE6226.3010407@linux.intel.com>
Date: Thu, 24 Nov 2011 16:26:30 +0100
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 0/2] Add org.bluez.Telephony interface
References: <1321970484-10208-1-git-send-email-frederic.danis@linux.intel.com>	<20111122141502.GD15357@aemeltch-MOBL1>	<4ECBC6A0.7080006@linux.intel.com>	<CAKT1EBdHj7E2stDSHT_P2F_O2-O43W6M5NwnPL+_d6ex_gm9nQ@mail.gmail.com>	<4ECCC3C4.20509@linux.intel.com> <CAJdJm_Mn-v0HXf5d4-gxCJeA=y8WEUKqyiqNtLeh-pZSn-9PFg@mail.gmail.com>
In-Reply-To: <CAJdJm_Mn-v0HXf5d4-gxCJeA=y8WEUKqyiqNtLeh-pZSn-9PFg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Lizardo,

Le 23/11/2011 12:06, Anderson Lizardo a écrit :
> Hi Frederic,
>
> On Wed, Nov 23, 2011 at 5:58 AM, Frederic Danis
> <frederic.danis@linux.intel.com>  wrote:
>> The new telephony D-Bus interface is just in charge of performing SDP
>> publication and RFComm connection. All Telephony related code is managed by
>> the agent (i.e. oFono).
>
> How t
>
>> I take a look to the Phone Alert Status and Alert Notification and I thought
>> that this should be implemented in the agent, or in a BlueZ service
>> accessible by the agent through D-Bus.
>
> I'm wondering what exactly has been discussed/decided on the BlueZ summit.
>
> Are we supposed to move everything "platform specific" to agents and
> remove all drivers from BlueZ? Are we okay with have BlueZ depending
> on multiple agents?
>
Yes, this is what I understand for BlueZ 5.

> Besides that, I think your proposed Telephony API is too tied to
> HFP/HSP. I think it is interesting to have a more generic API so that
> other telephony related profiles (e.g. LE ones) could reuse it without
> requiring their own agent based API.
>
> Regards,

With this new D-Bus telephony drivers there will be no more need of 
telephony related code into BlueZ, which will move to platform telephony 
daemon.

My understanding for those LE profiles are, as they are related to 
telephony, that they should listen for D-Bus signals (simple way, read 
only) or should be implemented into telephony daemon.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Centre
frederic.danis@intel.com                              Intel Corporation

