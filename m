Return-Path: <cyrus@holtmann.org>
Message-ID: <f8a8efe40807170233i2fccc66lc5a1f7ee1b1abca@mail.gmail.com>
Date: Thu, 17 Jul 2008 11:33:44 +0200
From: Mateusz <m.patelak@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: RFCOMM connection timeout question (rfcomm/sock.c)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm trying to understand the following piece of kernel code in rfcomm/sock.c.

rfcomm_sock_connect -> rfcomm_dlc_open -> bt_sock_wait_state

The last procedure waits until the sk's state changes to BT_CONNECTED.

1. When creating sk socket the sk_sndtimeo member of sk is initialized
to RFCOMM_CONN_TIMEOUT, which in my kernel code is HZ * 30 which, as I
see it, should be 30 seconds. However after enabling debug, I can see
that the timeout returned by  sock_sndtimeo is 7500. How could this
be?

2. What is the role of the bt_sock_wait_state? If timeout expires it
returns error code 115 (EINPROGRESS). What does the situation look
like here? Is the client still trying to connect to a remote device?
If so, how should the client program handle this error code? Is
ignoring it a good option or should it rather call the
rfcomm_socket_release function? What would happen if the client tried
to connect to the same remote device using rfcomm_sock_connect after
receiving this error code? Is there a way to notify the client that
the connection was made (BT_CONNECTED) without waiting on the
bt_sock_wait_state function.

3. Is there a way to control this timeout in a more flexible fashion
or is it impossible due to some BT specification bits?

Thanks in advance for all the answers. Your support and suggestions
are greatly appreciated.

Best wishes,
Mateusz
