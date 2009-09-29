Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: gfpadovan@gmail.com
In-Reply-To: <1254200130.2659.72.camel@localhost.localdomain>
References: <1254199349-19713-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1254199349-19713-2-git-send-email-gustavo@las.ic.unicamp.br>
	 <1254200130.2659.72.camel@localhost.localdomain>
Date: Tue, 29 Sep 2009 02:15:15 -0300
Message-ID: <6b53b1990909282215l6a823048sf3e684cc8ceeb047@mail.gmail.com>
Subject: Re: [PATCH 2/7] Bluetooth: Initialize variables and timers for both
	channel's sides
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Sep 29, 2009 at 1:55 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Gustavo,
>
>> ERTM entity need to handle state vars, timers and counters to send and
>> receive I-frames. We initialize all of them to the default values here.
>
> while this is a good idea. Where is the justification for pushing this
> after the merge window?

These patches are bug fixes and implementations of missing parts of ERTM sp=
ec.
For instance, they enable ERTM to transmit in a full duplex among other thi=
ngs.
Also, ERTM isn't enabled on L2CAP, so we aren't introducing any regressions=
 and
ASAP we put this code on mainline more feedback we can get from
possible testers.

Should I put this on the commit message?


>
>> Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
>> ---
>> =A0net/bluetooth/l2cap.c | =A0 53 ++++++++++++++++++++++++++++++++------=
----------
>> =A01 files changed, 35 insertions(+), 18 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index 9d586fb..3f9d74b 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -2169,6 +2169,20 @@ static void l2cap_add_conf_opt(void **ptr, u8 typ=
e, u8 len, unsigned long val)
>> =A0 =A0 =A0 *ptr +=3D L2CAP_CONF_OPT_SIZE + len;
>> =A0}
>>
>> +static inline void l2cap_ertm_init(struct sock *sk) {
>> + =A0 =A0 l2cap_pi(sk)->expected_ack_seq =3D 0;
>
> Coding style! The { =A0belong on the next line.

Sorry, :(

>
> Regards
>
> Marcel
>
>
>



--=20
Gustavo F. Padovan
http://padovan.org
