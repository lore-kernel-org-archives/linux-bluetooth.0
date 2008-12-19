Return-Path: <cyrus@holtmann.org>
Message-ID: <ac290f760812181815h719d9c95nb724872a4beb04ca@mail.gmail.com>
Date: Thu, 18 Dec 2008 18:15:08 -0800
From: "jaikumar Ganesh" <jaikumarg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: conn->state vs conn->sk->sk_state
In-Reply-To: <ac290f760812171407te7a079eycf45c36d376b0c5c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <ac290f760812171405r79473a67l6769913bc7e62d2e@mail.gmail.com>
	 <ac290f760812171407te7a079eycf45c36d376b0c5c@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Looking at this a bit further, I see a discrepancy between the code in
function  hci_conn_complete_evt and hci_sync_conn_complete_evt.
Is this intentional or a bug ? Like I said below, using
hci_conn_complete_evt (when the AG doesn't support eSCO) results in
the connect() never returning because the socket state is not updated.

//hci_conn_complete_evt
        if (ev->status) {
                hci_proto_connect_cfm(conn, ev->status);
                hci_conn_del(conn);
        }

unlock:
        hci_dev_unlock(hdev);
        hci_conn_check_pending(hdev);
}

//hci_sync_conn_complete_evt.

        hci_proto_connect_cfm(conn, ev->status);
        if (ev->status)
                hci_conn_del(conn);
unlock:
        hci_dev_unlock(hdev);
}

Any pointers / hints ?

Thanks
Jaikumar
On Wed, Dec 17, 2008 at 2:07 PM, jaikumar Ganesh <jaikumarg@gmail.com> wrote:
>  Folks,
>     I have a device which supports only SCO connections.  So when the
> application calls sco_sock_connect -> sco_connect, the conn->state is
> set to BT_CONNECT and then bt_sock_state is called waiting for the
> conn->sk->sk_state to be set to BT_CONNECTED.
>     When the HCI Connection Complete event comes, the conn->state is
> set to BT_CONNECTED.
>
>     In 2.6.25 ->  hci_proto_connect_cfm(conn, ev->status) was called
> at the end of hci_conn_complete_evt which used to set the
> conn->sk->sk_state to BT_CONNECTED in sco_conn_ready.
>     In 2.6.27->  hci_proto_connect_cfm(conn, ev->status) is called
> only if the ev_status is 1.
>                      Hence, the conn->sk->sk_state doesn't get set to
> BT_CONNECTED and hence the connect() times out.
>
>    Should we be calling sco_conn_ready in sco_connect similar to
> sco_connect_cfm if conn != null ?
>    I didn't see anyone else complain so am I missing something obvious ?
>
>
>     * I am new to this list so please excuse me if the above doesn't
> make sense.
>
>  Thanks
>  Jaikumar
>
