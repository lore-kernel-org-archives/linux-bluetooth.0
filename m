Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101029211718.GC14961@vigoh>
References: <1288359781-4059-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1288359781-4059-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20101029211718.GC14961@vigoh>
Date: Mon, 1 Nov 2010 16:20:15 +0200
Message-ID: <AANLkTiksc7jKPqxkFEZqvgBJ5ATvGh0nurWS9SZcdtit@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] Bluetooth: timer check sk is not owned before freeing
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo

On Sat, Oct 30, 2010 at 12:17 AM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Andrei,
>
> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-10-29 16:43:01 +0300]:
>
>> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>>
>> In timer context we might delete l2cap channel used by krfcommd.
>> The check makes sure that sk is not owned. If sk is owned we
>> restart timer for HZ/5.
>>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>> ---
>>  net/bluetooth/l2cap.c |   32 ++++++++++++++++++++------------
>>  1 files changed, 20 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index b1344d8..c67b3c6 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -83,6 +83,18 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
>>  static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb);
>>
>>  /* ---- L2CAP timers ---- */
>> +static void l2cap_sock_set_timer(struct sock *sk, long timeout)
>> +{
>> +     BT_DBG("sk %p state %d timeout %ld", sk, sk->sk_state, timeout);
>> +     sk_reset_timer(sk, &sk->sk_timer, jiffies + timeout);
>> +}
>> +
>> +static void l2cap_sock_clear_timer(struct sock *sk)
>> +{
>> +     BT_DBG("sock %p state %d", sk, sk->sk_state);
>> +     sk_stop_timer(sk, &sk->sk_timer);
>> +}
>> +
>>  static void l2cap_sock_timeout(unsigned long arg)
>>  {
>>       struct sock *sk = (struct sock *) arg;
>> @@ -92,6 +104,14 @@ static void l2cap_sock_timeout(unsigned long arg)
>>
>>       bh_lock_sock(sk);
>>
>> +     if (sock_owned_by_user(sk)) {
>> +             /* sk is owned by user. Try again later */
>> +             l2cap_sock_set_timer(sk, HZ / 5);
>> +             bh_unlock_sock(sk);
>> +             sock_put(sk);
>
> You can't do a sock_put() here, you have to keep the referencee to the
> socket while the timer is enabled.

sk_reset_timer is holding sock when timer restarts. The same way done
in TCP code in function:
static void tcp_delack_timer(unsigned long data)

Regards,
Andrei
