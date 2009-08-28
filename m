Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Aug 2009 18:54:34 +0100 (BST)
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Lan Zhu <zhu.lan.cn@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: can we increase the send buffer size of rfcomm socket?
In-Reply-To: <1251478713.2950.128.camel@localhost.localdomain>
References: <113d36d80908260307g59eead24v9311d612c8541ad0@mail.gmail.com>  <1251309847.2950.96.camel@localhost.localdomain>  <113d36d80908270833q4eb7b4eg8d512fdd34e6ca83@mail.gmail.com>  <1251401414.2950.122.camel@localhost.localdomain>
 <113d36d80908280234m34473a05n45654ab37a484ed0@mail.gmail.com> <1251478713.2950.128.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1251482074.966253.827.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 28 Aug 2009, Marcel Holtmann wrote:

> > Yes, it's our kernel's problem. We used another version and it worked
> > fine. Here the change in rfcomm_sock_alloc() is only for testing. What
> > I'm doing now is adding a case for RFCOMM_SNDBUF in the function
> > rfcomm_sock_setsockopt_old(), as below.
> >
> > 	case RFCOMM_SNDBUF:
> > 		sk->sk_sndbuf = opt;
> > 		break;
> >
> > I'm thinking to add a limitation for a maximum buffer size, but don't
> > know what maximum size is appropriate here. Do you have any idea?
>
> no that is bluntly wrong. Why do you think the function has _old in its
> name. It clearly shows that we are going to deprecate it soon. If you do
> this for RFCOMM, then it should also be done for L2CAP. So make sure you
> use SOL_BLUETOOTH. And make it similar to what TCP is doing.

Eh? Why would you need to invent a SOL_BLUETOOTH setting for this when
there is a standard "SOL_SOCKET, SO_SNDBUF" option that covers it already?

  http://www.opengroup.org/onlinepubs/000095399/functions/setsockopt.html

regards,
iain
