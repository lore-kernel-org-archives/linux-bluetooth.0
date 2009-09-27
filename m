Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 27 Sep 2009 11:20:12 +0800
Message-ID: <113d36d80909262020y3dc487v880012747475a8e7@mail.gmail.com>
Subject: null pointer error in bluez kernel
From: Lan Zhu <zhu.lan.cn@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When we test Bluetooth "out of range" case, occasionally we got kernel
panic result. From the panic log we can see it was caused by NULL
point error.

In one panic case, the NULL pointer happens at:

" if (sk->sk_state == BT_CONNECTED)" in the function
l2cap_sock_sendmsg() of l2cap.c

In another panic case, the NULL pointer is at:

"parent->sk_data_ready(parent, 0);" in the function l2cap_conn_start()
of l2cap.c

In a normal call sequence, these null pointer shall never happen,
because it is already well considered. But it seems that the "out of
range" test usually leads the unexpected call sequence which may
randomly cause NULL pointer. Is there any way we can use to avoid the
NULL pointer?


Thanks,
Zhu Lan
