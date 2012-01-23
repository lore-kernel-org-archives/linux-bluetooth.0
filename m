Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327310352.1955.93.camel@aeonflux>
References: <1327309863-12696-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1327310352.1955.93.camel@aeonflux>
Date: Mon, 23 Jan 2012 20:08:37 -0200
Message-ID: <CAA37ikZ=e-+2Jk2wUWmYio96zXkFqr2Q1B=eLi0uyFVUdqNO1g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Remove old unused lock
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jan 23, 2012 at 7:19 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andrei,
>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> ---
>> =A0include/net/bluetooth/l2cap.h | =A0 =A01 -
>> =A01 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap=
.h
>> index f6d5134..c21e37a 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -544,7 +544,6 @@ struct l2cap_conn {
>> =A0 =A0 =A0 struct smp_chan *smp_chan;
>>
>> =A0 =A0 =A0 struct list_head chan_l;
>> - =A0 =A0 struct mutex =A0 =A0chan_lock;
>> =A0};
>>
>> =A0#define L2CAP_INFO_CL_MTU_REQ_SENT =A0 0x01
>
> so if this one is not used, how do we protect any changes at all. I am
> kinda nervous now that our L2CAP is broken. Please start looking into
> fixing this and send a patch series that I can review as a whole and see
> how it progresses.

It seems this lock was protecting the list of l2cap_chan before the
changes to use RCU. I'm failing to see why we don't need some sort of
mutual exclusion among writers e.g. if all callers hold some lock that
already exclude the others. IMO we might need to have a lock/unlock of
conn->chan_lock around list_add_rcu and list_del_rcu calls but Padovan
might clarify this better as he did the changes.

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
