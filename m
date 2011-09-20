Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110919214505.GM2643@joana>
References: <1315846853-27442-1-git-send-email-luiz.dentz@gmail.com>
	<1315846853-27442-3-git-send-email-luiz.dentz@gmail.com>
	<20110919214505.GM2643@joana>
Date: Tue, 20 Sep 2011 12:10:11 +0300
Message-ID: <CABBYNZK_RTNbPhkKBr9+J0gSqKNPP625p04m+z4EVevMaGLK6Q@mail.gmail.com>
Subject: Re: [RFC 3/5 v2] Bluetooth: make use sk_priority to priritize RFCOMM packets
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Sep 20, 2011 at 12:45 AM, Gustavo Padovan
<padovan@profusion.mobi> wrote:
> Hi Luiz,
>
> * Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-09-12 20:00:51 +0300]:
>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> ---
>>  net/bluetooth/rfcomm/core.c |   51 +++++++++++++++++++++++++++++-------------
>>  net/bluetooth/rfcomm/sock.c |    2 +
>>  2 files changed, 37 insertions(+), 16 deletions(-)
>>
>> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
>> index 85580f2..bfc6bce 100644
>> --- a/net/bluetooth/rfcomm/core.c
>> +++ b/net/bluetooth/rfcomm/core.c
>> @@ -65,7 +65,8 @@ static DEFINE_MUTEX(rfcomm_mutex);
>>
>>  static LIST_HEAD(session_list);
>>
>> -static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len);
>> +static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len,
>> +                                                     u32 priority);
>>  static int rfcomm_send_sabm(struct rfcomm_session *s, u8 dlci);
>>  static int rfcomm_send_disc(struct rfcomm_session *s, u8 dlci);
>>  static int rfcomm_queue_disc(struct rfcomm_dlc *d);
>> @@ -747,19 +748,34 @@ void rfcomm_session_getaddr(struct rfcomm_session *s, bdaddr_t *src, bdaddr_t *d
>>  }
>>
>>  /* ---- RFCOMM frame sending ---- */
>> -static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len)
>> +static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len,
>> +                                                     u32 priority)
>>  {
>>       struct socket *sock = s->sock;
>> +     struct sock *sk = sock->sk;
>>       struct kvec iv = { data, len };
>>       struct msghdr msg;
>>
>> -     BT_DBG("session %p len %d", s, len);
>> +     BT_DBG("session %p len %d priority %u", s, len, priority);
>> +
>> +     if (sk->sk_priority != priority) {
>> +             lock_sock(sk);
>> +             sk->sk_priority = priority;
>> +             release_sock(sk);
>> +     }
>>
>>       memset(&msg, 0, sizeof(msg));
>>
>>       return kernel_sendmsg(sock, &msg, &iv, 1, len);
>>  }
>>
>> +static int rfcomm_send_cmd(struct rfcomm_session *s, struct rfcomm_cmd *cmd)
>> +{
>> +     BT_DBG("%p cmd %u", s, cmd->ctrl);
>> +
>> +     return rfcomm_send_frame(s, (void *) cmd, sizeof(*cmd), HCI_PRIO_MAX);
>
>
> What's the idea here? Prioritize commands over data? But does this really
> happen? Because we have only one queue to receive the data in L2CAP. There
> is no separation between data and cmd there.

Latency problems as I explained in the other email.

> Also, did you check if we can send RFCOMM commands and data out of order?

Im not sure about that, but by using only one queue the ordering per
channel is not changed, command got high priority to avoid problems
with latency but we don't sort the queues.

> I really would like to rewrite l2cap-rfcomm iteraction before adding new
> features here.

Im afraid we can't wait in this case, this would hold the whole HCI
prioritization, but the changes to RFCOMM are not that big either it
is more to cope with the changes in the scheduler than introducing new
features.

-- 
Luiz Augusto von Dentz
