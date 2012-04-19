Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OASRGQJVLJzYHSkgWW+oXRtrOPEKZNacfLb4R=1_9mDg@mail.gmail.com>
References: <1334850342-23063-1-git-send-email-hemant.gupta@stericsson.com>
	<CAJdJm_OASRGQJVLJzYHSkgWW+oXRtrOPEKZNacfLb4R=1_9mDg@mail.gmail.com>
Date: Thu, 19 Apr 2012 23:02:47 +0530
Message-ID: <CACj007mbngLbfBBPvBOeAk8EzBjvJpFPn739hB839Qf_kjx91A@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Update L2CAP Channel State for LE Link
 during Pairing
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Thu, Apr 19, 2012 at 10:53 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Hemant,
>
> On Thu, Apr 19, 2012 at 11:45 AM, Hemant Gupta
> <hemant.gupta@stericsson.com> wrote:
>> This patch updates the L2CAP Channel state to Connected when LE Link
>> is established, so that data transmission can start on CID 4.
>> Without this fix if remote side sends data on CID 4 immidiately after
>> LE Link was established, data was being discarded in l2cap_att_channel()
>> API because channel state was still BT_CONNECT when SMP pairing is in
>> progress. This was resulting in disconnection from remote side after 30 seconds
>> since ATT request was not answered by user space as data was discarded.
>>
>> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
>> ---
>>  net/bluetooth/l2cap_core.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> Sorry, but I really fail to see the explanation above being related to
> the change below, assuming the fix is correct (I don't know because I
> didn't take a look on smp_conn_security() and I don't know if this has
> been discussed on IRC).
>
> I suggest you explain what it means for smp_conn_security() return
> "true" or "false" (at least what you understand from it), and why
> l2cap_chan_ready() (which updates the socket/channel state to
> BT_CONNECT) needs to be called when the condition is "false".
>
smp_conn_security() returns 0 in case security is in progress, i.e. pairing
command has been sent to other side ,and 1 otherwise. So in case security
is in progress, we should not wait until security procedure is finished to delay
the reception of ATT data (CID 4) because l2cap state is still BT_CONNECT
which should be the case, as remote side(slave) can start sending data
irrespective
of security being initiated from master.

>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 15478b3..ef0cc91 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -1189,7 +1189,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
>>                l2cap_chan_lock(chan);
>>
>>                if (conn->hcon->type == LE_LINK) {
>> -                       if (smp_conn_security(conn, chan->sec_level))
>> +                       if (!smp_conn_security(conn, chan->sec_level))
>>                                l2cap_chan_ready(chan);
>>
>>                } else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> Best Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
