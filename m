Return-Path: <cyrus@holtmann.org>
Subject: Re: can we increase the send buffer size of rfcomm socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: Lan Zhu <zhu.lan.cn@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <113d36d80908280234m34473a05n45654ab37a484ed0@mail.gmail.com>
References: <113d36d80908260307g59eead24v9311d612c8541ad0@mail.gmail.com>
	 <1251309847.2950.96.camel@localhost.localdomain>
	 <113d36d80908270833q4eb7b4eg8d512fdd34e6ca83@mail.gmail.com>
	 <1251401414.2950.122.camel@localhost.localdomain>
	 <113d36d80908280234m34473a05n45654ab37a484ed0@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 28 Aug 2009 09:58:33 -0700
Message-Id: <1251478713.2950.128.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zhu,

> >> >> We tried to write a 64k data to rfcomm socket, but it will break
> >> >> before sending all of the data out. The problem is in function
> >> >> rfcomm_sock_sendmsg() in net/bluetooth/rfcomm/sock.c, it breaks after
> >> >> calling sock_alloc_send_skb().
> >> >>
> >> >> static int rfcomm_sock_sendmsg(...)
> >> >> {
> >> >>    ...
> >> >>               skb = sock_alloc_send_skb(sk, size + RFCOMM_SKB_RESERVE,
> >> >>                               msg->msg_flags & MSG_DONTWAIT, &err);
> >> >>               if (!skb)
> >> >>                       break;
> >> >>    ...
> >> >> }
> >> >>
> >> >> Looks the send buffer is not adequate. Then I increased the send
> >> >> buffer size in function rfcomm_sock_alloc(),  build kernel and try
> >> >> again, this time the sendmsg can complete sending all the data.
> >> >>
> >> >> Can we use the setsockopt() method to change the socket's send/receive
> >> >> buffer size, just like the usual  tcp/ip socket?
> >> >
> >> > yes we can. Send a patch for it and I am going to review it.
> >> >
> >> > Regards
> >> >
> >> > Marcel
> >> >
> >> >
> >> >
> >>
> >> Today I changed the send buffer size but found kernel become very
> >> unstable. It usually crash during sending rfcomm data. Do you know
> >> what's the reason?
> >>
> >> Below is what I changed in net/bluetooth/rfcomm/sock.c.
> >>
> >> in function rfcomm_sock_alloc(),
> >>
> >> change sk->sndbuf
> >> from
> >> sk->sk_sndbuf = RFCOMM_MAX_CREDITS * RFCOMM_DEFAULT_MTU * 10
> >> to
> >> sk->sk_sndbuf = RFCOMM_MAX_CREDITS * RFCOMM_DEFAULT_MTU * 20
> >
> > which kernel is this? There have been some fixes in the network stack
> > for this. Also I need oopses to see what might happen here.
> >
> > Regards
> >
> > Marcel
> >
> >
> >
> 
> Yes, it's our kernel's problem. We used another version and it worked
> fine. Here the change in rfcomm_sock_alloc() is only for testing. What
> I'm doing now is adding a case for RFCOMM_SNDBUF in the function
> rfcomm_sock_setsockopt_old(), as below.
> 
> 	case RFCOMM_SNDBUF:
> 		sk->sk_sndbuf = opt;
> 		break;
> 
> I'm thinking to add a limitation for a maximum buffer size, but don't
> know what maximum size is appropriate here. Do you have any idea?

no that is bluntly wrong. Why do you think the function has _old in its
name. It clearly shows that we are going to deprecate it soon. If you do
this for RFCOMM, then it should also be done for L2CAP. So make sure you
use SOL_BLUETOOTH. And make it similar to what TCP is doing.

Regards

Marcel


