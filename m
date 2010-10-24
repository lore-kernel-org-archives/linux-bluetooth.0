Return-Path: <cyrus@holtmann.org>
Subject: Re: (Health) ChannelConnected signal when MDL aborted?
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <AANLkTiknmbF78BgGH+KBTfjEvw4rqLVxu3Nnhg3nshB7@mail.gmail.com>
Date: Sun, 24 Oct 2010 15:50:30 -0200
Cc: Santiago Carot <sancane@gmail.com>, linux-bluetooth@vger.kernel.org
Message-Id: <97114F57-A53B-40AE-AB46-600B9522FC8C@signove.com>
References: <295EA951-2357-4B6B-B558-0B3F1D6FFDD9@signove.com> <AANLkTi=65C7HQXQW1Bqbgf4sNY3wbV2CzqoENBc-b04g@mail.gmail.com> <4B999390-7FFB-4B90-98BA-D9F9C17771F5@signove.com> <AANLkTim3m1ogwwx5MqF+z1FDKn4w3xHEN7MOAO5iW_ms@mail.gmail.com> <3511AB9E-2F29-4E9C-845A-674A3EA437E7@signove.com> <AANLkTiknmbF78BgGH+KBTfjEvw4rqLVxu3Nnhg3nshB7@mail.gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Sorry, you are right about that, reconnections are not mantadory in
> all cases for sources. May be we should check this flags before
> keeping the state and emitting the signal.

This could be useful even in this case of MDL abort X ChannelConnected signal. If the flags say that device is incapable of reconnections, definetively no point in emitting the signal.

But I am not sure if you will have the SDP record at hand to do this check, at that moment; certainly not worth forcing a SDP query just to round these particular corner cases.