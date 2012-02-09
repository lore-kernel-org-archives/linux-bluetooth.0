Return-Path: <cyrus@holtmann.org>
Message-ID: <1328771599.28848.13.camel@aeonflux>
Subject: Re: Getting L2CAP ERTM support into better upstream state
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Ulisses Furquim <ulisses@profusion.mobi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Peter Krystad <pkrystad@codeaurora.org>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 09 Feb 2012 08:13:19 +0100
In-Reply-To: <alpine.DEB.2.02.1202081221280.25089@mathewm-linux>
References: <1328678855.28848.6.camel@aeonflux>
	 <20120208090945.GB5917@aemeltch-MOBL1>
	 <CABBYNZ+v5fjUXML7Yq=Xxs_37yOcdPhgr2eLWgPKOyY=LqEQwA@mail.gmail.com>
	 <CAA37ikYNVFdWf_ZAGCfY6rrYeO7054n3y_uwn5f04Xzz9g0Mpw@mail.gmail.com>
	 <alpine.DEB.2.02.1202081221280.25089@mathewm-linux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> > On Wed, Feb 8, 2012 at 7:32 AM, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> >> Hi Andrei,
> >>
> >> On Wed, Feb 8, 2012 at 11:09 AM, Andrei Emeltchenko
> >> <andrei.emeltchenko.news@gmail.com> wrote:
> >>>
> >>> I think this would be good to send as patch series so that people can
> >>> comment. What comes to my mind is that the patch might be reduced if it
> >>> does not change order of functions and defines like:
> >>>
> 
> ... <snip> ...
> 
> >>> those magic number does not look nice IMO and the code is not looking any
> >>> better.
> >>
> >> In this aspect perhaps, but we don't need to take the code as it is,
> >> but the point here is following the states defined by the spec and
> >> that is IMO much better.
> 
> Right - the code as it stands now was ported quickly, and does not 
> take in to account many of Andrei's upstream improvements.  I don't 
> want to move backwards in terms of magic numbers, and there is some 
> extra noise in there due to symbol names.  I need to address these 
> issues before merging.
> 
> I'm also looking for ideas on how to do this as a patch series.  Since 
> it takes a very different approach from the original code, it's hard 
> to make meaningful, small patches that don't break functionality.  At 
> some point there has to be a major switchover but there is a lot of 
> room to split this up.
> 
> One approach is to add inactive code until everything is there, then 
> have one commit that calls in to the new code instead of the old code. 
> Then the old code can be removed.  I talked to Gustavo about that a 
> while ago, and he preferred finding a different way.  Maybe an 
> intermediate step is to put the state machine code in there, but call 
> the existing frame handling functions in every state.

I am fine with this approach. We must make sure that we have a complete
series and be merging it at once. Otherwise dealing with compiler
warnings in -next trees is just creating too much noise.

And to make this crystal clear to everybody. I want _ONE_ upstream L2CAP
ERTM implementation and no future fragmentation. I am dealing with this
issue once and after that is has to be upstream first. No exceptions.

> > I've taken a quick look last week at their code and indeed it looks
> > better regarding following the states. In particular they track
> > rx_state and tx_state and then decide what to do based on that and
> > what happened. I like it because it's explicit about that instead of
> > demanding us to reason a lot on what state we are and what we should
> > do. I'm all for changing our ERTM to that so it'll be more
> > maintainable.
> 
> That was the goal of the design.  It has worked well during in-house 
> testing, and has been through several UPFs.
> 
> 
> > Marcel mentioned the separation of L2CAP channel and socket. That is a
> > work in progress by Andrei and judging by what you said, Marcel, you
> > want that merged before we change ERTM, is that it?
> 
> Andrei and Marcel, let's figure out this order now.  It doesn't make 
> sense for one of us to have a bunch of changes staged, only to have 
> major merge/rebase conflicts when another far-reaching patch set gets 
> merged.

This is between you and Andrei. I want to see the L2CAP channel vs
socket split happening. I do not care in which order. You guys agree on
a way forward and I will just go along with it.

Regards

Marcel


