Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 26 Aug 2009 18:07:19 +0800
Message-ID: <113d36d80908260307g59eead24v9311d612c8541ad0@mail.gmail.com>
Subject: can we increase the send buffer size of rfcomm socket?
From: Lan Zhu <zhu.lan.cn@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We tried to write a 64k data to rfcomm socket, but it will break
before sending all of the data out. The problem is in function
rfcomm_sock_sendmsg() in net/bluetooth/rfcomm/sock.c, it breaks after
calling sock_alloc_send_skb().

static int rfcomm_sock_sendmsg(...)
{
   ...
		skb = sock_alloc_send_skb(sk, size + RFCOMM_SKB_RESERVE,
				msg->msg_flags & MSG_DONTWAIT, &err);
		if (!skb)
			break;
   ...
}

Looks the send buffer is not adequate. Then I increased the send
buffer size in function rfcomm_sock_alloc(),  build kernel and try
again, this time the sendmsg can complete sending all the data.

Can we use the setsockopt() method to change the socket's send/receive
buffer size, just like the usual  tcp/ip socket?


Thanks,
Zhu Lan
