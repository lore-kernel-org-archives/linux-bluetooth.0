Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330734830.3392.132.camel@aeonflux>
References: <1328884361-3909-1-git-send-email-luiz.dentz@gmail.com>
	<1330734830.3392.132.camel@aeonflux>
Date: Mon, 5 Mar 2012 10:57:09 +0200
Message-ID: <CABBYNZJ1TJZEXnOdMs1vuqWW7oN98ecgQ5g35U6Ve+5tNLCuuQ@mail.gmail.com>
Subject: Re: [RFC] btio: Adjust socket buffers to be at least as big as MTU
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Mar 3, 2012 at 2:33 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> Maybe could be done in kernel automatically as it could be considered
>> broken in case of SOCK_SEQPACKET if socket buffer cannot hold a
>> write/read of MTU size.
>
> I have actually no idea what the right approach here is, but we should
> handle this inside the kernel.
>
> So should setting a too large MTU fail if the socket buffers are too
> small? Or just we just adjust the socket buffers when a large MTU is
> set? Any comments?

I guess we should attempt to adjust the socket buffers if the MTU is
too large to fit, if that fail than MTU changes should also fail and
then client decide if it wants to disconnect or not. We should
probably check for capabilities if the process has CAP_NET_ADMIN we
can probably force the buffers to be bigger than wmem_max otherwise it
should be limited by wmem_max.

-- 
Luiz Augusto von Dentz
