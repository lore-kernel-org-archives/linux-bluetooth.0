Return-Path: <cyrus@holtmann.org>
Message-ID: <4D814334.6080407@codeaurora.org>
Date: Wed, 16 Mar 2011 16:09:40 -0700
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Peter Dons Tychsen <donpedro@tdcadsl.dk>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Arun Raghavan <arun.raghavan@collabora.co.uk>,
	linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: Switching between SBC and MPEG audio on headsets
References: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk>	 <20110315170124.GA15712@jh-x301>	 <AANLkTimF0Ux=-uQiWaWH14r3_YAuyp2o=QrmyeLkWWeT@mail.gmail.com> <1300315111.4500.34.camel@donpedro>
In-Reply-To: <1300315111.4500.34.camel@donpedro>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 3/16/2011 3:38 PM, Peter Dons Tychsen wrote:
> Hello,
>
> On Tue, 2011-03-15 at 16:29 -0300, Luiz Augusto von Dentz wrote:
>> Actually
>> I would suggest configuring both endpoint since the beginning so that
>> we only need to suspend/resume to switch between them, but I don't
>> think many headsets would be able to handle this situation.
>
> Unfortunately, because of a rather silly flaw in the A2DP specifications
> you cannot do this. The reason is simple. You would need a separate
> L2CAP channel for each data link. A2DP uses up to three L2CAP channels
> all on L2CAP PSM=0x19:
>
> 1) First is always signalling channel.
> 2) Second is always data channel.
> 3) Third is always Journaling channel (never really used).
>
> So if you already had the first two, and you opened yet another on
> PSM=0x19 from the same device, then it could be one of the following:
>
> 1) A new signalling channel (multi-profile).
> 2) A new data channel for already opened profile.
> 3) A new Journalling channel for already opened profile.
>

This is not actually true. You can have multiple media channels open 
simultaneously (for instance one for Video and one for Audio) which are 
opened with careful handshaking with the AVDTP_OPEN signaling command. 
In theory, this could be two audio channels as well.  If someone wants a 
Journaling channel, it would be opened without the AVDTP_OPEN signaling.

The support for multiple streaming channels is explicitly allowed for in 
the specification (AVDTP v1.2, section 6.10 - Stream Establishment).


[...]

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
