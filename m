Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327170562.1955.55.camel@aeonflux>
References: <1326993579-14429-1-git-send-email-octavian.purdila@intel.com>
	<1327164299.1955.53.camel@aeonflux>
	<CAE1zotJs0gJOQUX_w+A31gw6zedBGnLscyWRKya8KdNKTM4+4A@mail.gmail.com>
	<1327170562.1955.55.camel@aeonflux>
Date: Sat, 21 Jan 2012 20:44:25 +0200
Message-ID: <CAE1zotLwpoq-6kKpsCf_KWY+AbjTa9Pd4m_v_wKX6JdmJ9O8nA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: silence lockdep warning
From: "Purdila, Octavian" <octavian.purdila@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Jan 21, 2012 at 8:29 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Octavian,
>
>> >> +void bt_sock_reclassify_lock(struct sock *sk, int proto)
>> >> =A0{
>> >> - =A0 =A0 struct sock *sk =3D sock->sk;
>> >> -
>> >> =A0 =A0 =A0 if (!sk)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> >
>> > Why are we keeping the !sk check here if we already hand in the sk. It
>> > is most likely checked by the caller already.
>> >
>>
>> In rfcomm_sock_create (called from bt_sock_create) sock->sk can be set
>> to NULL so I think we should keep the check.
>
> it has been too long since I looked at this part of the code. You need
> to walk me through it why this is still true.
>

Hi Marcel,

In bt_sock_create we have:

        if (bt_proto[proto] && try_module_get(bt_proto[proto]->owner)) {
        	err =3D bt_proto[proto]->create(net, sock, proto, kern);
                bt_sock_reclassify_lock(sock->sk, proto);

and create can be rfcomm_sock_create where we have

        sk =3D rfcomm_sock_alloc(net, sock, protocol, GFP_ATOMIC);
        if (!sk)
                return -ENOMEM;

So after calling ->create() sock->sk can be NULL and thus we can call
bt_sock_reclassify with a NULL parameter.

Does this make sense?

Thanks,
Tavi
