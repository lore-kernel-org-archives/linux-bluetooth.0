Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm bind : Address already in use
From: Marcel Holtmann <marcel@holtmann.org>
To: Tetsuo Shiraishi <tetsu@s-direct.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4.3.2-J.20040713015123.0463e378@emi.s-direct.com>
References: <4.3.2-J.20040710152845.0669b538@emi.s-direct.com>
	 <4.3.2-J.20040709223728.06828b80@emi.s-direct.com>
	 <4.3.2-J.20040709223728.06828b80@emi.s-direct.com>
	 <4.3.2-J.20040710152845.0669b538@emi.s-direct.com>
	 <4.3.2-J.20040713015123.0463e378@emi.s-direct.com>
Content-Type: text/plain
Message-Id: <1089656770.4644.69.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 12 Jul 2004 20:26:10 +0200

Hi Tetsuo,

> >you should have mentioned that, because dund creates a /dev/rfcommX
> >device node for starting PPP. Maybe there is a leftover, which leaves
> >the DLC open and so the session can't be terminated. Maybe a running
> >pppd holds the socket descriptor open.
> >
> >But I won't have time to look into that in detail. If you provide me a
> >patch for dund or for the kernel RFCOMM part, I will review it.
> >
> 
> I tried to make patch for this.

sorry to say that, but that is not the solution. Implementing some kind
of garbage collection is not ok. This is the Linux kernel, if you think
that this is a bug, find it and fix it. And don't work around it.

Btw you forgot the locking while iteration along the socket list.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
