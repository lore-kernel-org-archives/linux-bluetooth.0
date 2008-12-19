Return-Path: <cyrus@holtmann.org>
Message-ID: <ac290f760812191028p8aa03d6l4374410d742aa9dc@mail.gmail.com>
Date: Fri, 19 Dec 2008 10:28:24 -0800
From: "jaikumar Ganesh" <jaikumarg@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: conn->state vs conn->sk->sk_state
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1229713080.879.8.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <ac290f760812171405r79473a67l6769913bc7e62d2e@mail.gmail.com>
	 <ac290f760812171407te7a079eycf45c36d376b0c5c@mail.gmail.com>
	 <ac290f760812181815h719d9c95nb724872a4beb04ca@mail.gmail.com>
	 <1229713080.879.8.camel@californication>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Dec 19, 2008 at 10:58 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jaikumar,
>
>> Looking at this a bit further, I see a discrepancy between the code in
>> function  hci_conn_complete_evt and hci_sync_conn_complete_evt.
>> Is this intentional or a bug ? Like I said below, using
>> hci_conn_complete_evt (when the AG doesn't support eSCO) results in
>> the connect() never returning because the socket state is not updated.
>
> I still have no idea what's your problem. It doesn't matter if the
> remote side supports eSCO or not. The sync setup commands can be used
> even for setting up SCO channels.
>

  So here is the problem:
     The  AG doesn't support eSCO i.e disable_esco is Y and
lmp_esco_capable(dev) evaluates to 0, so we try to establish a SCO
channel irrespective of whether the remote support eSCO or not.

  So sco_connect is called, and after the hci_connect, hcon->state is
BT_CONNECT and the sk->sk_state = BT_CONNECT.
  When we get a response from the remote device
hci_connect_complete_evt is called which sets the conn->state to
BT_CONNECTED. However, as
  hci_proto_connect_cfm is not called (this was being called in
2.6.25) ,  sk->sk_state remained in BT_CONNECT state. Hence, we get
stuck in bt_sock_wait_state
  and the connect() times out.

Thanks
Jaikumar
