Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 21 Mar 2011 14:58:32 +0100
Message-ID: <AANLkTin3yvX_M-iA_op2ygmbP2BNd_99gp7HnoY=gzWR@mail.gmail.com>
Subject: crash in rfcomm_check_security()
From: Vitaly Wool <vitalywool@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I experienced a kernel crash while downloading pictures using OPP to my device.

The crash turned out to happen in rfcomm_recv_sabm():

        /* Notify socket layer about incoming connection */
        channel = __srv_channel(dlci);
        if (rfcomm_connect_ind(s, channel, &d)) {
                d->dlci = dlci;
                d->addr = __addr(s->initiator, dlci);
                rfcomm_dlc_link(s, d);

                rfcomm_check_accept(d); <--- crash point!
        } else {
                rfcomm_send_dm(s, dlci);
        }

Effectively it was the rfcomm_check_security() that crashed because
hci_conn_security(l2cap_pi(sk)->conn was NULL at the moment so
dereferencing it resulted in the crash.

As far as I can see, the flow was the following:

rfcomm_run()
  rfcomm_process_sessions()
    rfcomm_process_rx()
      rfcomm_recv_frame() <-- l2cap_sock_timeout() happens around here
        rfcomm_recv_sabm()
          rfcomm_check_accept()
            rfcomm_check_security()

I verified that session->sock->sk->state == BT_CLOSED and it confirms
the fact that there was a race between processing received frame in a
separate thread (with some latency then, of course) and sock timeout
which is processed almost immediately.

So the basic question is, how to handle that? Is it okay to just add a
NULL check in rfcomm_check_security() and hope it'll get sorted out on
its own? Or should there be an attempt to rewrite the whole sock
timeout handling so that it's race-free?

Thanks,
   Vitaly
