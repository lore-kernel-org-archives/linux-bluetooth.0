Return-Path: <cyrus@holtmann.org>
Subject: Re: (Health) ChannelConnected signal when MDL aborted?
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <AANLkTi=65C7HQXQW1Bqbgf4sNY3wbV2CzqoENBc-b04g@mail.gmail.com>
Date: Sat, 23 Oct 2010 18:35:04 -0200
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <4B999390-7FFB-4B90-98BA-D9F9C17771F5@signove.com>
References: <295EA951-2357-4B6B-B558-0B3F1D6FFDD9@signove.com> <AANLkTi=65C7HQXQW1Bqbgf4sNY3wbV2CzqoENBc-b04g@mail.gmail.com>
To: Santiago Carot <sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> You are forgetting that there may be more than one health applications
> running over HDP at the same time, if one of them creates a data
> channel, that data data channel will be exist at MCAP level even if
> the initiator abort the connection. If other application wants to
> create a new data channel with the same configuration, it may be want
> reconnect that data channel avoiding to create another data channel.
> It is a best practise wich is recomended in MCAP and best explained in
> the Health Device Profile white paper document to reduce the amount of
> data interchanged between medical devices (in IEEE/11073-20601
> terminology: "agents" and "managers"). Remember that channels may be
> shared between applications.

I'm still not convinced :) I can't see the point of sharing a HealthChannel that is not healthy (pardon the joke).

Maybe I'm being too pragmatic, but I expect that most real HDP devices will be like that Nonin oximeter: incapable of reconnecting MDLs and incapable of accepting connections. Sharing a channel in that situation will make spend much more, not less, energy, because applications will Acquire() and trigger a reconnection over a channel that actually does not exist and wouldn't be accepted even if it existed.

Anyway, MDL aborts are expected to be rare, so the actual problem won't be seen often in practice.

I think we have another, more important problem: naming the channel after MDLID. 

For example, the channel that comes from oximeter has always the same path here: /org/bluez/19750/hci0/dev_00_1C_05_00_28_85/chan1. It is incapable of reconnections but always recreates the MDL with the same MDL ID = 1.

Now, let's suppose a MDL is created, destroyed and re-created, but for some reason the application the application takes too long to act upon the signal. You have three signals:

ChannelConnected chan1
ChannelDeleted chan1
ChannelConnected chan1 (a second channel with the same MDL ID)

Application will Acquire() on first signal, thinking it is getting the FD for the first instance of chan1, but it will actually get the FD for the second "version" of chan1.

Then it will process the ChannelDeleted signal, closing a perfectly good channel. And then it sees the third signal, and tries the Acquire() the fd it has just closed. If the other side tries to reconnect immediately but does not support MCAP reconnections, this could go on forever.

A possible solution is to use a monotonic number for the channel path suffix, without relation to MDL ID.