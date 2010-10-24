Return-Path: <cyrus@holtmann.org>
Subject: Re: (Health) ChannelConnected signal when MDL aborted?
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <AANLkTim3m1ogwwx5MqF+z1FDKn4w3xHEN7MOAO5iW_ms@mail.gmail.com>
Date: Sun, 24 Oct 2010 11:28:13 -0200
Cc: Santiago Carot <sancane@gmail.com>, linux-bluetooth@vger.kernel.org
Message-Id: <3511AB9E-2F29-4E9C-845A-674A3EA437E7@signove.com>
References: <295EA951-2357-4B6B-B558-0B3F1D6FFDD9@signove.com> <AANLkTi=65C7HQXQW1Bqbgf4sNY3wbV2CzqoENBc-b04g@mail.gmail.com> <4B999390-7FFB-4B90-98BA-D9F9C17771F5@signove.com> <AANLkTim3m1ogwwx5MqF+z1FDKn4w3xHEN7MOAO5iW_ms@mail.gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

> In that case, the problem is in the remote side, because the Bluetooth
> SIG certification requires the devices to support reconnections, so
> the problem is not in our side but in the remote side that isn't
> compliant with the standard. I think we don't  have to change our
> implementation regarding buggy devices that don't follow the
> specification correctly.

I think an HDP device is NOT required to support reconnections. In HDP spec item 5.2.11   there is that bitmap in SDP record that says whether device supports reconnections and CSP.

> More over, the situation that you mention. When receiving a
> ChannelDeletion, the application shouldn't close the data channel,
> because the in the normal situation, the DBus object for the data
> channel will be removed, so no closing of the channel will be
> performed, the only thing that should happen is that the application
> will "forget" about this channel. When the second ChannelConnected is
> received, the application will typically perform an acquire that, in
> this case, will be very simple because the channel will be already
> connected and the fd will be transmitted.

So the application must follow a very specific behaviour when handling a ChannelDeleted signal, and worse yet, it must do it to fix a problem that we could fix simply by changing the way channel paths are named.

If it was the case that we simply could not change the channel path naming, this behaviour should at least written very clearly in API.

> In general, I think, guys, that we are thinking again in very estrange
> situations. As we said in the Recife's meeting we should design the
> implementation and the API for working with compliants devices, not
> with buggy ones and also we have to simplify the use for the API,
> making it simple for the application programmers in the most usual
> cases not in the strange ones, that will happen very rarely.

It's weekend, and playing devil's advocate is fun :P 

Seriously now, my objective is the same, avoiding that a perfectly sensible application act (closing fd after receiving a ChannelDeleted event) causing a race condition. And IMHO a condition that may happen with compliant devices as well.