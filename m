Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1265228487.31341.136.camel@localhost.localdomain>
References: <113d36d80909110053ybd2c203xeda76bd36248bb17@mail.gmail.com>
	<35c90d960909211752u389e5d6dqbd4afe0e055c43d0@mail.gmail.com>
	<35c90d960909211829u71880f94j861055c61efc8c@mail.gmail.com>
	<35c90d960909221318m4b918d2dg3e2688a89427319a@mail.gmail.com>
	<508e92ca0912180620l3550bdb7w1211094681cbc87b@mail.gmail.com>
	<1261173555.4041.91.camel@localhost.localdomain> <35c90d960912181430t4bf36fb9gbc6ae71eeaf16602@mail.gmail.com>
	<1261177347.4041.103.camel@localhost.localdomain> <508e92ca0912220820j30e08e0ar84bcf0efb0bf4f9a@mail.gmail.com>
	<1265228487.31341.136.camel@localhost.localdomain>
From: Nick Pelly <npelly@google.com>
Date: Wed, 3 Feb 2010 16:19:01 -0800
Message-ID: <35c90d961002031619h4f4cea2ftc8c5500d86f52df9@mail.gmail.com>
Subject: Re: kernel panic happens when disconnecting Bluetooth headset
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
        Lan Zhu <zhu.lan.cn@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Feb 3, 2010 at 12:21 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andrei,
>
>> >> >> Processing a RFCOMM UA frame when the socket is closed and we were=
 not
>> >> >> the
>> >> >> RFCOMM initiator would cause rfcomm_session_put() to be called twi=
ce
>> >> >> during
>> >> >> rfcomm_process_rx(). This would cause a kernel panic in
>> >> >> rfcomm_session_close.
>> >> >>
>> >> >> This could be easily reproduced during disconnect with devices suc=
h as
>> >> >> Motorola H270 that send RFCOMM UA followed quickly by L2CAP discon=
nect
>> >> >> request.
>> >> >> This hcidump for this looks like:
>> >> >>
>> >> >> 2009-09-21 17:22:37.788895 < ACL data: handle 1 flags 0x02 dlen 8
>> >> >> =A0 =A0L2CAP(d): cid 0x0041 len 4 [psm 3]
>> >> >> =A0 =A0 =A0RFCOMM(s): DISC: cr 0 dlci 20 pf 1 ilen 0 fcs 0x7d
>> >> >> 2009-09-21 17:22:37.906204 > HCI Event: Number of Completed Packet=
s
>> >> >> (0x13)
>> >> >> plen 5
>> >> >> =A0 =A0handle 1 packets 1
>> >> >> 2009-09-21 17:22:37.933090 > ACL data: handle 1 flags 0x02 dlen 8
>> >> >> =A0 =A0L2CAP(d): cid 0x0040 len 4 [psm 3]
>> >> >> =A0 =A0 =A0RFCOMM(s): UA: cr 0 dlci 20 pf 1 ilen 0 fcs 0x57
>> >> >> 2009-09-21 17:22:38.636764 < ACL data: handle 1 flags 0x02 dlen 8
>> >> >> =A0 =A0L2CAP(d): cid 0x0041 len 4 [psm 3]
>> >> >> =A0 =A0 =A0RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c
>> >> >> 2009-09-21 17:22:38.744125 > HCI Event: Number of Completed Packet=
s
>> >> >> (0x13)
>> >> >> plen 5
>> >> >> =A0 =A0handle 1 packets 1
>> >> >> 2009-09-21 17:22:38.763687 > ACL data: handle 1 flags 0x02 dlen 8
>> >> >> =A0 =A0L2CAP(d): cid 0x0040 len 4 [psm 3]
>> >> >> =A0 =A0 =A0RFCOMM(s): UA: cr 0 dlci 0 pf 1 ilen 0 fcs 0xb6
>> >> >> 2009-09-21 17:22:38.783554 > ACL data: handle 1 flags 0x02 dlen 12
>> >> >> =A0 =A0L2CAP(s): Disconn req: dcid 0x0040 scid 0x0041
>> >> >>
>> >> >> Avoid calling rfcomm_session_put() twice by skipping this call
>> >> >> in rfcomm_recv_ua() if the socket is closed.
>> >> >>
>> >> >> Picked from:
>> >> >> http://android.git.kernel.org/?p=3Dkernel/common.git;a=3Dcommit;h=
=3D1048e007842da2d6440679e1ca80f45438a6369d
>> >> >>
>> >> >> Signed-off-by: Nick Pelly <npelly@google.com>
>> >> >> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>> >> >> ---
>> >> >> =A0net/bluetooth/rfcomm/core.c | =A0 =A03 ++-
>> >> >> =A01 files changed, 2 insertions(+), 1 deletions(-)
>> >> >>
>> >> >> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/co=
re.c
>> >> >> index 0313e88..56ffcb8 100644
>> >> >> --- a/net/bluetooth/rfcomm/core.c
>> >> >> +++ b/net/bluetooth/rfcomm/core.c
>> >> >> @@ -1148,7 +1148,8 @@ static int rfcomm_recv_ua(struct rfcomm_sess=
ion
>> >> >> *s, u8 dlci)
>> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> >>
>> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case BT_DISCONN:
>> >> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfcomm_session_put(s=
);
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s->sock->sk->sk_=
state !=3D BT_CLOSED)
>> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfco=
mm_session_put(s);
>> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> >> =A0 =A0 =A0 =A0 }
>> >> >
>> >> > I am not a big fan of conditionally decreasing reference counts. I =
do
>> >> > think it would be better to fix this by holding an extra pair of
>> >> > reference counts or actually fixing the imbalance. What about the o=
ther
>> >> > patches I proposed?
>> >>
>> >> Your proposed patch was to add an extra hold() / put() reference coun=
t
>> >> around the offending put(). I did test this patch, and found it does
>> >> not fix the underlying imbalance, it just moves the kernel panic
>> >> somewhere else.
>> >>
>> >> As best I can tell, my patch does address the underlying imbalance. I=
t
>> >> is in production on Android phones and seems to work well. As best I
>> >> can tell, there is not a cleaner solution that does not involve
>> >> significant refactoring of rfcomm refcounting.
>>
>> We have this patch also in Nokia N900 phone. And this was the best solut=
ion
>> for the problem mentioned.
>>
>> > the RFCOMM reference counting is something nasty and it does need to b=
e
>> > re-written. One thing that needs to happen that we stop using the L2CA=
P
>> > sockets directly. We have to put a proper L2CAP in-kernel specific API
>> > in between that ensures we are not mixing things. That is the one issu=
es
>> > that we always had in this area.
>> >
>> > Before applying this patch, I like to have additionally a comment in
>> > front of this conditional put call that explains a little bit the
>> > problem area here. The long explanation with logs etc. should be in th=
e
>> > commit message. I have to make sure that we fully understand what is
>> > going on here and why we did it.
>>
>> What do you think about following comment:
>>
>> --- a/net/bluetooth/rfcomm/core.c
>> +++ b/net/bluetooth/rfcomm/core.c
>> @@ -1151,7 +1151,11 @@ static int rfcomm_recv_ua(struct rfcomm_session
>> *s, u8 dlci)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case BT_DISCONN:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfcomm_session_put(s);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* When socket is closed and w=
e are not RFCOMM
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* initiator rfcomm_process_=
rx already calls
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* rfcomm_session_put */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s->sock->sk->sk_state !=3D=
 BT_CLOSED)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rfcomm_session=
_put(s);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>
> looks good. Just turn this into a proper patch and send it to the
> mailing list so I can apply it.

Sent.

Nick
