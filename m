Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: gfpadovan@gmail.com
In-Reply-To: <1235856798.6074.34.camel@localhost.localdomain>
References: <1235797347-1816-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1235856798.6074.34.camel@localhost.localdomain>
Date: Sat, 28 Feb 2009 18:49:02 -0300
Message-ID: <6b53b1990902281349m2c2ed590h6264863ce415b7af@mail.gmail.com>
Subject: Re: [PATCH 1/3] bluetooth: add write_lock_bh to __l2cap_chan_link
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Feb 28, 2009 at 6:33 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Gustavo,
>
>> fix race condition
>>
>> Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
>> ---
>> =A0net/bluetooth/l2cap.c | =A0 =A02 ++
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index ca4d3b4..355f375 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -175,12 +175,14 @@ static inline void __l2cap_chan_link(struct l2cap_=
chan_list *l, struct sock *sk)
>> =A0{
>> =A0 =A0 =A0 sock_hold(sk);
>>
>> + =A0 =A0 write_lock_bh(&l->lock);
>> =A0 =A0 =A0 if (l->head)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_pi(l->head)->prev_c =3D sk;
>>
>> =A0 =A0 =A0 l2cap_pi(sk)->next_c =3D l->head;
>> =A0 =A0 =A0 l2cap_pi(sk)->prev_c =3D NULL;
>> =A0 =A0 =A0 l->head =3D sk;
>> + =A0 =A0 write_unlock_bh(&l->lock);
>> =A0}
>
> a general rule of thumb is that function starting with __ are the ones
> that don't use any kind of locking.

Ok. I noted this after send the patch. :-(

>
> Regards
>
> Marcel
>
>
>



--=20
Gustavo F. Padovan

Computer Engineering Student
Institute of Computing - IC
University of Campinas - UNICAMP

email: gustavo@las.ic.unicamp.br
gtalk: gfpadovan@gmail.com
mobile: +55 19 81030803
