Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4B999390-7FFB-4B90-98BA-D9F9C17771F5@signove.com>
References: <295EA951-2357-4B6B-B558-0B3F1D6FFDD9@signove.com>
	<AANLkTi=65C7HQXQW1Bqbgf4sNY3wbV2CzqoENBc-b04g@mail.gmail.com>
	<4B999390-7FFB-4B90-98BA-D9F9C17771F5@signove.com>
Date: Sun, 24 Oct 2010 10:34:54 +0200
Message-ID: <AANLkTikLByb4qKBJP_iBUw2H0EqLo1MA9bttLwBO9s-u@mail.gmail.com>
Subject: Re: (Health) ChannelConnected signal when MDL aborted?
From: Santiago Carot <sancane@gmail.com>
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2010/10/23 Elvis Pfützenreuter <epx@signove.com>:
>> You are forgetting that there may be more than one health applications
>> running over HDP at the same time, if one of them creates a data
>> channel, that data data channel will be exist at MCAP level even if
>> the initiator abort the connection. If other application wants to
>> create a new data channel with the same configuration, it may be want
>> reconnect that data channel avoiding to create another data channel.
>> It is a best practise wich is recomended in MCAP and best explained in
>> the Health Device Profile white paper document to reduce the amount of
>> data interchanged between medical devices (in IEEE/11073-20601
>> terminology: "agents" and "managers"). Remember that channels may be
>> shared between applications.
>
> I'm still not convinced :) I can't see the point of sharing a HealthChannel that is not healthy (pardon the joke).

sure?
Then you should think what happen with the First reliable data channel
in case that you are running multiples IEEE specializations over the
same HDP instance (that is pretty common in IEEE level). Remember that
the First Relible data channel is used for IEEE association and
confirmed event traffic. If you dont allow use that channel by other
application it won't associate with the other device at IEEE layer.
Please, think that with current HDP implementation you can develop
IEEE agent specializations too, not only managers.

HDP specification says:
* The first Data Channel opened on a given MCL shall be a Reliable Data Channel.
* Association traffic shall be carried on the first Reliable Data
Channel that was
opened on a given MCL.

Next you are a text fragment copied from white paper (Alluding to the
example where there are two applications on HDP):
 "...The right side of the diagram shows two devices that typically
both use Reliable Data Channels. In this
case, the devices may share a common Reliable Data Channel (and MDL)
for all data or may optionally
have separate MDLs for their data, but share the first Reliable Data
Channel for IEEE association and
confirmed event traffic..."


>
> Maybe I'm being too pragmatic, but I expect that most real HDP devices will be like that Nonin oximeter: incapable of reconnecting MDLs and incapable of accepting connections. Sharing a channel in that situation will make spend much more, not less, energy, because applications will Acquire() and trigger a reconnection over a channel that actually does not exist and wouldn't be accepted even if it existed.

There are not only Nonin oximeter devices, we have a blood pressure
that reconnect data channels, in the past we played with a weighing
scale wich it was waiting for data channel connections, besides it is
expected more complex devices such as electrocardiograms, and also you
should think about what will happen if somebody uses this
implementation to develop a health device specialization?, for
example, I thinking in smartphones with sensors, etc... IMHO it is
very presumptuous to make such assumptions about the future (may be I
am too idealist) :P

>
> Anyway, MDL aborts are expected to be rare, so the actual problem won't be seen often in practice.
>
> I think we have another, more important problem: naming the channel after MDLID.
>
> For example, the channel that comes from oximeter has always the same path here: /org/bluez/19750/hci0/dev_00_1C_05_00_28_85/chan1. It is incapable of reconnections but always recreates the MDL with the same MDL ID = 1.
>
> Now, let's suppose a MDL is created, destroyed and re-created, but for some reason the application the application takes too long to act upon the signal. You have three signals:
>
> ChannelConnected chan1
> ChannelDeleted chan1
> ChannelConnected chan1 (a second channel with the same MDL ID)
>
> Application will Acquire() on first signal, thinking it is getting the FD for the first instance of chan1, but it will actually get the FD for the second "version" of chan1.
>
> Then it will process the ChannelDeleted signal, closing a perfectly good channel. And then it sees the third signal, and tries the Acquire() the fd it has just closed. If the other side tries to reconnect immediately but does not support MCAP reconnections, this could go on forever.
>
> A possible solution is to use a monotonic number for the channel path suffix, without relation to MDL ID.

That is a problem in remote side and applications shall to know how
