Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4ECE6226.3010407@linux.intel.com>
References: <1321970484-10208-1-git-send-email-frederic.danis@linux.intel.com>
	<20111122141502.GD15357@aemeltch-MOBL1>
	<4ECBC6A0.7080006@linux.intel.com>
	<CAKT1EBdHj7E2stDSHT_P2F_O2-O43W6M5NwnPL+_d6ex_gm9nQ@mail.gmail.com>
	<4ECCC3C4.20509@linux.intel.com>
	<CAJdJm_Mn-v0HXf5d4-gxCJeA=y8WEUKqyiqNtLeh-pZSn-9PFg@mail.gmail.com>
	<4ECE6226.3010407@linux.intel.com>
Date: Thu, 24 Nov 2011 11:54:59 -0400
Message-ID: <CAJdJm_Pkn5h=sdX_zaN-yMQwP1mjFuGdimHsjnP8tEuk=jnx0Q@mail.gmail.com>
Subject: Re: [RFC 0/2] Add org.bluez.Telephony interface
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Thu, Nov 24, 2011 at 11:26 AM, Frederic Danis
<frederic.danis@linux.intel.com> wrote:
>> Besides that, I think your proposed Telephony API is too tied to
>> HFP/HSP. I think it is interesting to have a more generic API so that
>> other telephony related profiles (e.g. LE ones) could reuse it without
>> requiring their own agent based API.
>>
>> Regards,
>
> With this new D-Bus telephony drivers there will be no more need of
> telephony related code into BlueZ, which will move to platform telephony
> daemon.
>
> My understanding for those LE profiles are, as they are related to
> telephony, that they should listen for D-Bus signals (simple way, read only)

Phone Alert Status has a method to silent the ringer during a incoming
call. It also allows to change to/from "silent" profile. Alert
notification allows to enable/disable notifications of incoming
calls/SMS.

All of this is platform specific, therefore if we are going this route
for BlueZ 5, we need a more complete telephony interface that allows
to implement platform specific telephony bits outside BlueZ.

> or should be implemented into telephony daemon.

Maybe myself or Claudio are not clear, but I think the
"org.bluez.Telephony" interface name were supposed to mean a generic
telephony interface for BlueZ (so any Telephony related component
could use), but for me looks like it is just a HFP/HSP "proxy"
interface.

In other words, if we wanted to move the Phone Alert Status or Alert
Notification to e.g. ofono, your interface (as is) would be not
suitable to connect to a LE socket.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
