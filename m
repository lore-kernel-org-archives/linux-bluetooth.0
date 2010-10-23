Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <295EA951-2357-4B6B-B558-0B3F1D6FFDD9@signove.com>
References: <295EA951-2357-4B6B-B558-0B3F1D6FFDD9@signove.com>
Date: Sat, 23 Oct 2010 09:50:58 +0200
Message-ID: <AANLkTi=65C7HQXQW1Bqbgf4sNY3wbV2CzqoENBc-b04g@mail.gmail.com>
Subject: Re: (Health) ChannelConnected signal when MDL aborted?
From: Santiago Carot <sancane@gmail.com>
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2010/10/22 Elvis Pfützenreuter <epx@signove.com>:
> Taking a look in the code, I saw that hdp_mcap_mdl_aborted_cb() emits a ChannelConnected signal.
>
> I understand that after an abort, the MDL still exists, and can be reconnected, so I understand the intention of informing the application that a channel has been "created". But I'm not sure that it is opportune.
>
> The first thing the application will do is trying to Acquire() the channel's file descriptor (that does not exist) and that triggers a reconnection attempt, from acceptor to initiator. While the most sensible thing (in my view) is waiting for the initiator to reconnect -- if it aborted, it must have a good reason, and it will probably reject the immediate call back.
>

You are forgetting that there may be more than one health applications
running over HDP at the same time, if one of them creates a data
channel, that data data channel will be exist at MCAP level even if
the initiator abort the connection. If other application wants to
create a new data channel with the same configuration, it may be want
reconnect that data channel avoiding to create another data channel.
It is a best practise wich is recomended in MCAP and best explained in
the Health Device Profile white paper document to reduce the amount of
data interchanged between medical devices (in IEEE/11073-20601
terminology: "agents" and "managers"). Remember that channels may be
shared between applications.

That is the reason why HDP sends out a signal when a data channel has
been created.
Of course, the efficence of the protocol will depend on intelligence
of the programmer of the applications to take advantages of MCAP
reconnections. In any case, you will need to know when a data channel
has been created over the MCL (by you, or by other application).

Regards,

Santiago
