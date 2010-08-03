Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1280822396.12579.80.camel@localhost.localdomain>
References: <1280820383-10029-1-git-send-email-luiz.dentz@gmail.com>
	<1280822396.12579.80.camel@localhost.localdomain>
Date: Tue, 3 Aug 2010 11:27:33 +0300
Message-ID: <AANLkTi=GCBV1F8ywTkOuhoYNOM88u6NALhc3C+d0KrHR@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: fix not setting security level when creating a
	rfcomm session
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Aug 3, 2010 at 10:59 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Luiz,
>
>> This cause 'No Bonding' to be used if userspace has not yet been paired
>> with remote device since the l2cap socket used to create the rfcomm
>> session does not have any security level set.
>>
>> Signed-off-by: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
>> ---
>> =A0net/bluetooth/rfcomm/core.c | =A0 13 ++++++++++---
>> =A01 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
>> index 7dca91b..08f5757 100644
>> --- a/net/bluetooth/rfcomm/core.c
>> +++ b/net/bluetooth/rfcomm/core.c
>> @@ -79,7 +79,10 @@ static void rfcomm_make_uih(struct sk_buff *skb, u8 a=
ddr);
>>
>> =A0static void rfcomm_process_connect(struct rfcomm_session *s);
>>
>> -static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdad=
dr_t *dst, int *err);
>> +static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdaddr_t *dst,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 sec_level,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int *err);
>> =A0static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdadd=
r_t *dst);
>> =A0static void rfcomm_session_del(struct rfcomm_session *s);
>>
>> @@ -402,7 +405,7 @@ static int __rfcomm_dlc_open(struct rfcomm_dlc *d, b=
daddr_t *src, bdaddr_t *dst,
>>
>> =A0 =A0 =A0 s =3D rfcomm_session_get(src, dst);
>> =A0 =A0 =A0 if (!s) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 s =3D rfcomm_session_create(src, dst, &err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 s =3D rfcomm_session_create(src, dst, d->sec_l=
evel, &err);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!s)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> =A0 =A0 =A0 }
>> @@ -680,7 +683,10 @@ static void rfcomm_session_close(struct rfcomm_sess=
ion *s, int err)
>> =A0 =A0 =A0 rfcomm_session_put(s);
>> =A0}
>>
>> -static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdad=
dr_t *dst, int *err)
>> +static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdaddr_t *dst,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 sec_level,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int *err)
>> =A0{
>> =A0 =A0 =A0 struct rfcomm_session *s =3D NULL;
>> =A0 =A0 =A0 struct sockaddr_l2 addr;
>> @@ -705,6 +711,7 @@ static struct rfcomm_session *rfcomm_session_create(=
bdaddr_t *src, bdaddr_t *dst
>> =A0 =A0 =A0 sk =3D sock->sk;
>> =A0 =A0 =A0 lock_sock(sk);
>> =A0 =A0 =A0 l2cap_pi(sk)->imtu =3D l2cap_mtu;
>> + =A0 =A0 l2cap_pi(sk)->sec_level =3D sec_level;
>> =A0 =A0 =A0 if (l2cap_ertm)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 l2cap_pi(sk)->mode =3D L2CAP_MODE_ERTM;
>> =A0 =A0 =A0 release_sock(sk);
>
> I see what you are trying to do here, but why is this needed? Shouldn't
> it be already correctly set for PSM 3?

I couldn't find any special check for PSM 3, but I guess it would make
sense to make sure it always set the security level from dlc which
triggered the session, doesn't it? As it is now it first triggers No
Bonding and then when we actually connect the dlc it might have a
different sec_level which might triggers another round of io
capability negotiation, not only this doesn't work always, because
there is a bug in bluetoothd that won't invalidate/remove stored link
keys once we got a new one that is not supposed to be stored (No
Bonding), but IMO much simpler too. Maybe we can do as SDP which seems
to do the check in l2cap.c:l2cap_do_connect, but for rfcomm we
actually have to look in the dlcs to check witch security level should
be use.

--=20
Luiz Augusto von Dentz
Computer Engineer
