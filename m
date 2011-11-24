Return-Path: <cyrus@holtmann.org>
Message-ID: <4ECDE842.7010707@gmail.com>
Date: Thu, 24 Nov 2011 00:46:26 -0600
From: Denis Kenzior <denkenz@gmail.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Frederic Danis <frederic.danis@linux.intel.com>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 0/2] Add org.bluez.Telephony interface
References: <1321970484-10208-1-git-send-email-frederic.danis@linux.intel.com>	<20111122141502.GD15357@aemeltch-MOBL1>	<4ECBC6A0.7080006@linux.intel.com>	<CAKT1EBdHj7E2stDSHT_P2F_O2-O43W6M5NwnPL+_d6ex_gm9nQ@mail.gmail.com>	<4ECCC3C4.20509@linux.intel.com>	<CAJdJm_Mn-v0HXf5d4-gxCJeA=y8WEUKqyiqNtLeh-pZSn-9PFg@mail.gmail.com>	<4ECE6226.3010407@linux.intel.com> <CAJdJm_Pkn5h=sdX_zaN-yMQwP1mjFuGdimHsjnP8tEuk=jnx0Q@mail.gmail.com>
In-Reply-To: <CAJdJm_Pkn5h=sdX_zaN-yMQwP1mjFuGdimHsjnP8tEuk=jnx0Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> 
> Phone Alert Status has a method to silent the ringer during a incoming
> call. It also allows to change to/from "silent" profile. Alert
> notification allows to enable/disable notifications of incoming
> calls/SMS.
> 
> All of this is platform specific, therefore if we are going this route
> for BlueZ 5, we need a more complete telephony interface that allows
> to implement platform specific telephony bits outside BlueZ.
> 

These are indeed highly platform specific, moreover, they are UI/UX
specific.

>> or should be implemented into telephony daemon.
> 
> Maybe myself or Claudio are not clear, but I think the
> "org.bluez.Telephony" interface name were supposed to mean a generic
> telephony interface for BlueZ (so any Telephony related component
> could use), but for me looks like it is just a HFP/HSP "proxy"
> interface.
> 
> In other words, if we wanted to move the Phone Alert Status or Alert
> Notification to e.g. ofono, your interface (as is) would be not
> suitable to connect to a LE socket.

It sounds like moving these to oFono is not a good idea in the first
place, since oFono is not responsible for the UI, ringtone generation,
etc.

The question is whether you want to reserve .Telephony interface for
some LE specific bits (in which case we can use something like
VoiceTelephony or HandsfreeTelephony for the current proposal) or try
not expose the LE bits over D-Bus at all (e.g. using bluez plugins.)

Regards,
-Denis
