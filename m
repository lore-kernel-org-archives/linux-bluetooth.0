Return-Path: <cyrus@holtmann.org>
Message-ID: <ac290f760812171407te7a079eycf45c36d376b0c5c@mail.gmail.com>
Date: Wed, 17 Dec 2008 14:07:52 -0800
From: "jaikumar Ganesh" <jaikumarg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: conn->state vs conn->sk->sk_state
In-Reply-To: <ac290f760812171405r79473a67l6769913bc7e62d2e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <ac290f760812171405r79473a67l6769913bc7e62d2e@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 Folks,
     I have a device which supports only SCO connections.  So when the
application calls sco_sock_connect -> sco_connect, the conn->state is
set to BT_CONNECT and then bt_sock_state is called waiting for the
conn->sk->sk_state to be set to BT_CONNECTED.
     When the HCI Connection Complete event comes, the conn->state is
set to BT_CONNECTED.

     In 2.6.25 ->  hci_proto_connect_cfm(conn, ev->status) was called
at the end of hci_conn_complete_evt which used to set the
conn->sk->sk_state to BT_CONNECTED in sco_conn_ready.
     In 2.6.27->  hci_proto_connect_cfm(conn, ev->status) is called
only if the ev_status is 1.
                      Hence, the conn->sk->sk_state doesn't get set to
BT_CONNECTED and hence the connect() times out.

    Should we be calling sco_conn_ready in sco_connect similar to
sco_connect_cfm if conn != null ?
    I didn't see anyone else complain so am I missing something obvious ?


     * I am new to this list so please excuse me if the above doesn't
make sense.

 Thanks
 Jaikumar
