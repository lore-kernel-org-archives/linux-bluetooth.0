Return-Path: <jt@bougret.hpl.hp.com>
Date: Thu, 5 Feb 2004 09:19:19 -0800
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: L2CAP non-blocking socket nasty race conditions
Message-ID: <20040205171919.GA5417@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040204214541.GA20129@bougret.hpl.hp.com> <1075942818.2783.70.camel@pegasus> <20040205011102.GA23352@bougret.hpl.hp.com> <1075944624.2783.87.camel@pegasus> <20040205014030.GA23802@bougret.hpl.hp.com> <1075947705.2783.117.camel@pegasus> <20040205022635.GA24757@bougret.hpl.hp.com> <1075948602.2783.129.camel@pegasus> <20040205033019.GA25518@bougret.hpl.hp.com> <1075988978.2783.140.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1075988978.2783.140.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, Feb 05, 2004 at 02:49:38PM +0100, Marcel Holtmann wrote:
> Hi Jean,
> 
> > 	So, in other words I've just moved a tight loop from my code
> > to the kernel code (or glibc). Which means it seems that we only have
> > half of the solution (or maybe it's normal poll behavior ?).
> 
> I had the attached patch in mind. Please check if this also works for
> you, because it should produce less code execution. I think we can also
> remove the list_empty() check from bt_sock_listen_poll(), because the
> list_for_each_safe() gives us the same result.

	This should produce the same result. I'll try.
	Personally, I prefer commented code ;-)

> > 	I think at that point we will need to get advice from the
> > network gurus on how socket notification works.
> 
> I already checked the IPV4 code and they also work with an accept queue,
> but at the moment I don't understand when they put the new socket on it
> and how they keep track of it.

	Actually, I will double check, because I belive that it may be
normal behavior. More later.
	Thanks !

> Regards
> 
> Marcel

	Jean
