Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <ac290f760812191028p8aa03d6l4374410d742aa9dc@mail.gmail.com>
References: <ac290f760812171405r79473a67l6769913bc7e62d2e@mail.gmail.com>
	 <ac290f760812171407te7a079eycf45c36d376b0c5c@mail.gmail.com>
	 <ac290f760812181815h719d9c95nb724872a4beb04ca@mail.gmail.com>
	 <1229713080.879.8.camel@californication>
	 <ac290f760812191028p8aa03d6l4374410d742aa9dc@mail.gmail.com>
Date: Mon, 22 Dec 2008 08:16:02 -0800
Message-ID: <35c90d960812220816g6670580dlb01e49bf9ca56f3e@mail.gmail.com>
Subject: Re: conn->state vs conn->sk->sk_state
From: Nick Pelly <npelly@google.com>
To: jaikumar Ganesh <jaikumarg@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Dec 19, 2008 at 10:28 AM, jaikumar Ganesh <jaikumarg@gmail.com> wrote:
> Hi Marcel,
>
> On Fri, Dec 19, 2008 at 10:58 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Jaikumar,
>>
>>> Looking at this a bit further, I see a discrepancy between the code in
>>> function  hci_conn_complete_evt and hci_sync_conn_complete_evt.
>>> Is this intentional or a bug ? Like I said below, using
>>> hci_conn_complete_evt (when the AG doesn't support eSCO) results in
>>> the connect() never returning because the socket state is not updated.
>>
>> I still have no idea what's your problem. It doesn't matter if the
>> remote side supports eSCO or not. The sync setup commands can be used
>> even for setting up SCO channels.
>>
>
>  So here is the problem:
>     The  AG doesn't support eSCO i.e disable_esco is Y and
> lmp_esco_capable(dev) evaluates to 0, so we try to establish a SCO
> channel irrespective of whether the remote support eSCO or not.
>
>  So sco_connect is called, and after the hci_connect, hcon->state is
> BT_CONNECT and the sk->sk_state = BT_CONNECT.
>  When we get a response from the remote device
> hci_connect_complete_evt is called which sets the conn->state to
> BT_CONNECTED. However, as
>  hci_proto_connect_cfm is not called (this was being called in
> 2.6.25) ,  sk->sk_state remained in BT_CONNECT state. Hence, we get
> stuck in bt_sock_wait_state
>  and the connect() times out.


Explained another way:

JK found that in 2.6.27 with "echo Y >
/sys/module/sco/parameters/disable_esco" the socket state is never
updated to BT_CONNECTED. The userspace connect() call then times out,
even though the transport is connected. This appears to be because
hci_proto_connect_cfm() is not called when the connection complete
event arrives. Below is a patch that resolves this issue for us.

This is a request for comment as to whether this patch is correct. It
contradicts Marcel's change 769be974 which explicitly moved
hci_proto_connect_cfm() into the ev->status conditional.

Thanks,
Nick



commit 654488a822615b645c43605ab24f0305b56b40dc
Author: Jaikumar Ganesh <jaikumar@google.com>
Date:   Fri Dec 19 14:17:53 2008 -0800

    [Bluetooth] Fix SCO connection issue

    When the AG supports only SCO connections, on receipt of the
    HCI_EV_CONN_COMPLETE packet, the connect state is changed to
    BT_CONNECTED but the socket state is not updated. Hence, the
    connect() call times out even though the SCO connection has
    been established.

    Signed-off-by: Jaikumar Ganesh <jaikumar@google.com>

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ad7a553..3cba788 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -916,8 +916,8 @@ static inline void hci_conn_complete_evt(struct
hci_dev *hdev, struct sk_buff *s
                }
        }

+       hci_proto_connect_cfm(conn, ev->status);
        if (ev->status) {
-               hci_proto_connect_cfm(conn, ev->status);
                hci_conn_del(conn);
        }
