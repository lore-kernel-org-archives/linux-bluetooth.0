Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110919213625.GL2643@joana>
References: <1315846853-27442-1-git-send-email-luiz.dentz@gmail.com>
	<20110919213625.GL2643@joana>
Date: Tue, 20 Sep 2011 11:15:28 +0300
Message-ID: <CABBYNZ+A-urMHEVdbhikPQfXOv7dAYUB1bDKW5kFajPng93hrA@mail.gmail.com>
Subject: Re: [RFC 1/5 v3] Bluetooth: set skbuffer priority based on L2CAP
 socket priority
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Sep 20, 2011 at 12:36 AM, Gustavo Padovan
<padovan@profusion.mobi> wrote:
> Hi Luiz,
>
> * Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-09-12 20:00:49 +0300]:
>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This uses SO_PRIORITY to set the skbuffer priority field
>>
>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> ---
>>  include/net/bluetooth/hci_core.h |    3 +++
>>  include/net/bluetooth/l2cap.h    |    3 ++-
>>  net/bluetooth/l2cap_core.c       |   27 ++++++++++++++++++++-------
>>  net/bluetooth/l2cap_sock.c       |    2 +-
>>  4 files changed, 26 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index e2ba4d6..0742828 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -32,6 +32,9 @@
>>  #define HCI_PROTO_L2CAP      0
>>  #define HCI_PROTO_SCO        1
>>
>> +/* HCI priority */
>> +#define HCI_PRIO_MAX 7
>> +
>>  /* HCI Core structures */
>>  struct inquiry_data {
>>       bdaddr_t        bdaddr;
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index 4f34ad2..f018e5d 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -511,7 +511,8 @@ struct l2cap_chan *l2cap_chan_create(struct sock *sk);
>>  void l2cap_chan_close(struct l2cap_chan *chan, int reason);
>>  void l2cap_chan_destroy(struct l2cap_chan *chan);
>>  int l2cap_chan_connect(struct l2cap_chan *chan);
>> -int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
>> +int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
>> +                                                             u32 priority);
>>  void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
>>
>>  #endif /* __L2CAP_H */
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index b3bdb48..0b6e1ae 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -556,6 +556,7 @@ static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
>>               flags = ACL_START;
>>
>>       bt_cb(skb)->force_active = BT_POWER_FORCE_ACTIVE_ON;
>> +     skb->priority = HCI_PRIO_MAX;
>
> As Mat pointed out we can't prioritize commands over data, this could to
> misbehaviours and loss of data. However, if the command is not related to any
> cid, like the information request/reponse we can put HCI_PRIO_MAX on it.

Yep, I got it fixed already so we don't have a separated queue for
commands anymore, this alone should already guarantee packet ordering
of the channel, but Im afraid we need to keep HCI_PRIO_MAX for
commands since those may have a timer associated to them (either
locally or remotely) so if the priority is not set according the timer
may expire before the frame is even sent, actually I already faced
this a couple of times when trying to connect to multiple devices
simultaneously a high priority socket prevented other channels
commands to be sent causing a disconnection (connect timeout even
though we succeed to page and create an ACL link).

The key problem here is that priority may increase latency and that is
not something we want to happen for commands because it may cause IOP
problems, so the use of HCI_PRIO_MAX is to minimize the latency.

-- 
Luiz Augusto von Dentz
