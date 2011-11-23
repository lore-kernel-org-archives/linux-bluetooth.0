Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4ECCC3C4.20509@linux.intel.com>
References: <1321970484-10208-1-git-send-email-frederic.danis@linux.intel.com>
	<20111122141502.GD15357@aemeltch-MOBL1>
	<4ECBC6A0.7080006@linux.intel.com>
	<CAKT1EBdHj7E2stDSHT_P2F_O2-O43W6M5NwnPL+_d6ex_gm9nQ@mail.gmail.com>
	<4ECCC3C4.20509@linux.intel.com>
Date: Wed, 23 Nov 2011 07:06:59 -0400
Message-ID: <CAJdJm_Mn-v0HXf5d4-gxCJeA=y8WEUKqyiqNtLeh-pZSn-9PFg@mail.gmail.com>
Subject: Re: [RFC 0/2] Add org.bluez.Telephony interface
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Wed, Nov 23, 2011 at 5:58 AM, Frederic Danis
<frederic.danis@linux.intel.com> wrote:
> The new telephony D-Bus interface is just in charge of performing SDP
> publication and RFComm connection. All Telephony related code is managed by
> the agent (i.e. oFono).

How t

> I take a look to the Phone Alert Status and Alert Notification and I thought
> that this should be implemented in the agent, or in a BlueZ service
> accessible by the agent through D-Bus.

I'm wondering what exactly has been discussed/decided on the BlueZ summit.

Are we supposed to move everything "platform specific" to agents and
remove all drivers from BlueZ? Are we okay with have BlueZ depending
on multiple agents?

Besides that, I think your proposed Telephony API is too tied to
HFP/HSP. I think it is interesting to have a more generic API so that
other telephony related profiles (e.g. LE ones) could reuse it without
requiring their own agent based API.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
