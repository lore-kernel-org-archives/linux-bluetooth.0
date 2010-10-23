Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=65C7HQXQW1Bqbgf4sNY3wbV2CzqoENBc-b04g@mail.gmail.com>
References: <295EA951-2357-4B6B-B558-0B3F1D6FFDD9@signove.com>
	<AANLkTi=65C7HQXQW1Bqbgf4sNY3wbV2CzqoENBc-b04g@mail.gmail.com>
Date: Sat, 23 Oct 2010 10:00:11 +0200
Message-ID: <AANLkTimvQH4jA=AudrGA7Sj1vAFB3OjocOur2J2=Yy2f@mail.gmail.com>
Subject: Re: (Health) ChannelConnected signal when MDL aborted?
From: Santiago Carot <sancane@gmail.com>
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

2010/10/23 Santiago Carot <sancane@gmail.com>:
> Hi,
>
> 2010/10/22 Elvis Pfützenreuter <epx@signove.com>:
>> Taking a look in the code, I saw that hdp_mcap_mdl_aborted_cb() emits a ChannelConnected signal.
>>
>> I understand that after an abort, the MDL still exists, and can be reconnected, so I understand the intention of informing the application that a channel has been "created". But I'm not sure that it is opportune.
>>
>> The first thing the application will do is trying to Acquire() the channel's file descriptor (that does not exist) and that triggers a reconnection attempt, from acceptor to initiator. While the most sensible thing (in my view) is waiting for the initiator to reconnect -- if it aborted, it must have a good reason, and it will probably reject the immediate call back.
>>
>
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
>

I found the example that I was trying to explain here in page 16 of
the HDP whitepaper, there you can see two applications over HDP
sharing the same data channel (one of them providing support to
diferents device specializations).

> That is the reason why HDP sends out a signal when a data channel has
> been created.
> Of course, the efficence of the protocol will depend on intelligence
> of the programmer of the applications to take advantages of MCAP
> reconnections. In any case, you will need to know when a data channel
> has been created over the MCL (by you, or by other application).
>
> Regards,
>
> Santiago
>
