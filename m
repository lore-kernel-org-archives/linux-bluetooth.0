Return-Path: <cyrus@holtmann.org>
Subject: Re: Name resolution for mgmt interface
From: Marcel Holtmann <marcel@holtmann.org>
To: Antti Julku <antti.julku@nokia.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Date: Tue, 13 Sep 2011 10:48:30 +0200
In-Reply-To: <4E6EFAAF.3050505@nokia.com>
References: <4E6A247C.5040403@nokia.com>
		 <CAKT1EBdGAyxBh_aeTjPAhOeU2vHSsjbpgi91=vG8HqLv8aV0Yw@mail.gmail.com>
		 <1315635815.1937.4.camel@aeonflux>
		 <CAKT1EBc4z+rvgqKr1SuE_iYvBMqhLJ=E5AW6k5cq65nqa9EW=A@mail.gmail.com>
	 <1315854441.1937.28.camel@aeonflux> <4E6EFAAF.3050505@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315903712.1937.30.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antti,

> > I honestly don't know which one is easier. We also have to keep the
> > memory constraints in mind. So for how many BD_ADDR does the kernel
> > needs to store the flag name resolved already yes/no? With system that
> > are running for years, this can get pretty big.
> >
> > My current take on this (which is not final) is that after inquiry
> > complete, the kernel needs to ask userspace to confirm which names to
> > resolve. It is an action triggered by the kernel and userspace just
> > responds with the result to. So the kernel has full control here.
> >
> 
> Can we assume that user space will always reply? Or how long should 
> kernel wait for confirmation from user space, before ending discovery 
> procedure and sending Discovering=0 event?

the kernel should know if there is an open mgmt socket or not. If there
is not, then we should not bother asking userspace. If there is then we
have to have a timeout associated with each request. However such a
timeout is needed by requests asking for the link key or pin code
anyway. So that should be a generic handling in the first place.

Regards

Marcel


