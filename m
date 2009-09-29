Return-Path: <cyrus@holtmann.org>
Subject: Re: null pointer error in bluez kernel
From: Marcel Holtmann <marcel@holtmann.org>
To: Lan Zhu <zhu.lan.cn@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <113d36d80909262020y3dc487v880012747475a8e7@mail.gmail.com>
References: <113d36d80909262020y3dc487v880012747475a8e7@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 28 Sep 2009 22:03:03 -0700
Message-Id: <1254200583.2659.82.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> When we test Bluetooth "out of range" case, occasionally we got kernel
> panic result. From the panic log we can see it was caused by NULL
> point error.
> 
> In one panic case, the NULL pointer happens at:
> 
> " if (sk->sk_state == BT_CONNECTED)" in the function
> l2cap_sock_sendmsg() of l2cap.c
> 
> In another panic case, the NULL pointer is at:
> 
> "parent->sk_data_ready(parent, 0);" in the function l2cap_conn_start()
> of l2cap.c
> 
> In a normal call sequence, these null pointer shall never happen,
> because it is already well considered. But it seems that the "out of
> range" test usually leads the unexpected call sequence which may
> randomly cause NULL pointer. Is there any way we can use to avoid the
> NULL pointer?

what kernel version is this? Never had this problem since the link
supervision timeout should trigger a HCI Disconnect.

Regards

Marcel


