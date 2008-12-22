Return-Path: <cyrus@holtmann.org>
Message-ID: <ac290f760812221121k4810beedg64053ff3eba86048@mail.gmail.com>
Date: Mon, 22 Dec 2008 14:21:03 -0500
From: "jaikumar Ganesh" <jaikumarg@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: conn->state vs conn->sk->sk_state
Cc: "Nick Pelly" <npelly@google.com>, linux-bluetooth@vger.kernel.org
In-Reply-To: <1229973494.8047.13.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <ac290f760812171405r79473a67l6769913bc7e62d2e@mail.gmail.com>
	 <ac290f760812171407te7a079eycf45c36d376b0c5c@mail.gmail.com>
	 <ac290f760812181815h719d9c95nb724872a4beb04ca@mail.gmail.com>
	 <1229713080.879.8.camel@californication>
	 <ac290f760812191028p8aa03d6l4374410d742aa9dc@mail.gmail.com>
	 <35c90d960812220816g6670580dlb01e49bf9ca56f3e@mail.gmail.com>
	 <1229973494.8047.13.camel@californication>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Dec 22, 2008 at 2:18 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Nick,
>
>> >>> Looking at this a bit further, I see a discrepancy between the code in
>> >>> function  hci_conn_complete_evt and hci_sync_conn_complete_evt.
>> >>> Is this intentional or a bug ? Like I said below, using
>> >>> hci_conn_complete_evt (when the AG doesn't support eSCO) results in
>> >>> the connect() never returning because the socket state is not updated.
>> >>
>> >> I still have no idea what's your problem. It doesn't matter if the
>> >> remote side supports eSCO or not. The sync setup commands can be used
>> >> even for setting up SCO channels.
>> >>
>> >
>> >  So here is the problem:
>> >     The  AG doesn't support eSCO i.e disable_esco is Y and
>> > lmp_esco_capable(dev) evaluates to 0, so we try to establish a SCO
>> > channel irrespective of whether the remote support eSCO or not.
>> >
>> >  So sco_connect is called, and after the hci_connect, hcon->state is
>> > BT_CONNECT and the sk->sk_state = BT_CONNECT.
>> >  When we get a response from the remote device
>> > hci_connect_complete_evt is called which sets the conn->state to
>> > BT_CONNECTED. However, as
>> >  hci_proto_connect_cfm is not called (this was being called in
>> > 2.6.25) ,  sk->sk_state remained in BT_CONNECT state. Hence, we get
>> > stuck in bt_sock_wait_state
>> >  and the connect() times out.
>>
>>
>> Explained another way:
>>
>> JK found that in 2.6.27 with "echo Y >
>> /sys/module/sco/parameters/disable_esco" the socket state is never
>> updated to BT_CONNECTED. The userspace connect() call then times out,
>> even though the transport is connected. This appears to be because
>> hci_proto_connect_cfm() is not called when the connection complete
>> event arrives. Below is a patch that resolves this issue for us.
>>
>> This is a request for comment as to whether this patch is correct. It
>> contradicts Marcel's change 769be974 which explicitly moved
>> hci_proto_connect_cfm() into the ev->status conditional.
>
> now I get what you are talking about. You guys should have sent the
> patch from the beginning since that makes it clear what you are trying
> to achieve.
>
> So the patch is wrong, because it breaks Simple Pairing. What you have
> to do is check if it is an ACL link, then the code is doing the right
> thing and doing features requests first.
>
>        if (ev->status) {
>                hci_proto_connect_cfm(conn, ev->status);
>                hci_conn_del(conn);
>        } else if (ev->link_type != ACL_LINK)
>                hci_proto_connect_cfm(conn, ev->status);
>
> Regards
>
> Marcel
>
>
>
Sorry for not sending the patch before, we did the patch only on Friday.
Will change it according to your suggestion and submit.

Thanks
Jaikumar
