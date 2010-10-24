Return-Path: <cyrus@holtmann.org>
Subject: Re: (Health) ChannelConnected signal when MDL aborted?
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <AANLkTikLByb4qKBJP_iBUw2H0EqLo1MA9bttLwBO9s-u@mail.gmail.com>
Date: Sun, 24 Oct 2010 16:44:04 -0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5AA6D2CA-9EE2-49EC-BBE0-F1185DE42BF5@signove.com>
References: <295EA951-2357-4B6B-B558-0B3F1D6FFDD9@signove.com> <AANLkTi=65C7HQXQW1Bqbgf4sNY3wbV2CzqoENBc-b04g@mail.gmail.com> <4B999390-7FFB-4B90-98BA-D9F9C17771F5@signove.com> <AANLkTikLByb4qKBJP_iBUw2H0EqLo1MA9bttLwBO9s-u@mail.gmail.com>
To: Santiago Carot <sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> sure?
> Then you should think what happen with the First reliable data channel
> in case that you are running multiples IEEE specializations over the
> same HDP instance (that is pretty common in IEEE level). Remember that
> the First Relible data channel is used for IEEE association and
> confirmed event traffic. If you dont allow use that channel by other
> application it won't associate with the other device at IEEE layer.
> Please, think that with current HDP implementation you can develop
> IEEE agent specializations too, not only managers.

Ok, I think I see your point now. Thanks for the patience :)
