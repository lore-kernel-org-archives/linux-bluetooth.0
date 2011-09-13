Return-Path: <cyrus@holtmann.org>
Message-ID: <4E6EFAAF.3050505@nokia.com>
Date: Tue, 13 Sep 2011 09:39:43 +0300
From: Antti Julku <antti.julku@nokia.com>
MIME-Version: 1.0
To: ext Marcel Holtmann <marcel@holtmann.org>
CC: Claudio Takahasi <claudio.takahasi@openbossa.org>,
        linux-bluetooth@vger.kernel.org
Subject: Re: Name resolution for mgmt interface
References: <4E6A247C.5040403@nokia.com>	 <CAKT1EBdGAyxBh_aeTjPAhOeU2vHSsjbpgi91=vG8HqLv8aV0Yw@mail.gmail.com>	 <1315635815.1937.4.camel@aeonflux>	 <CAKT1EBc4z+rvgqKr1SuE_iYvBMqhLJ=E5AW6k5cq65nqa9EW=A@mail.gmail.com> <1315854441.1937.28.camel@aeonflux>
In-Reply-To: <1315854441.1937.28.camel@aeonflux>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Marcel,

On 09/12/2011 10:07 PM, ext Marcel Holtmann wrote:

> I honestly don't know which one is easier. We also have to keep the
> memory constraints in mind. So for how many BD_ADDR does the kernel
> needs to store the flag name resolved already yes/no? With system that
> are running for years, this can get pretty big.
>
> My current take on this (which is not final) is that after inquiry
> complete, the kernel needs to ask userspace to confirm which names to
> resolve. It is an action triggered by the kernel and userspace just
> responds with the result to. So the kernel has full control here.
>

Can we assume that user space will always reply? Or how long should 
kernel wait for confirmation from user space, before ending discovery 
procedure and sending Discovering=0 event?

Br,
Antti
