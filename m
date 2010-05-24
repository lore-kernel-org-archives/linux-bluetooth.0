Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100523023906.GB3385@vigoh>
References: <1274436293-15063-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <20100523023906.GB3385@vigoh>
Date: Mon, 24 May 2010 15:14:13 +0300
Message-ID: <AANLkTikjwu1anyryCcEgqDSeMDZBlSuPrxx-7n7qcJet@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] Bluetooth: Check sk is not owned before freeing
	l2cap_conn
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo

On Sun, May 23, 2010 at 5:39 AM, Gustavo F. Padovan <gustavo@padovan.org> wrote:
> Hi Andrei,
>
> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-05-21 13:04:52 +0300]:
>
>> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>>
>> Check that socket sk is not locked in user process before removing
>> l2cap connection handler.
>>
>> krfcommd kernel thread may be preempted with l2cap tasklet which remove
>> l2cap_conn structure. If krfcommd is in process of sending of RFCOMM reply
>> (like "RFCOMM UA" reply to "RFCOMM DISC") then kernel crash happens.
>>
>> ...
>> [  694.175933] Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> [  694.184936] pgd = c0004000
>> [  694.187683] [00000000] *pgd=00000000
>> [  694.191711] Internal error: Oops: 5 [#1] PREEMPT
>> [  694.196350] last sysfs file: /sys/devices/platform/hci_h4p/firmware/hci_h4p/loading
>> [  694.260375] CPU: 0    Not tainted  (2.6.32.10 #1)
>> [  694.265106] PC is at l2cap_sock_sendmsg+0x43c/0x73c [l2cap]
>> [  694.270721] LR is at 0xd7017303
>> ...
>> [  694.525085] Backtrace:
>> [  694.527587] [<bf266be0>] (l2cap_sock_sendmsg+0x0/0x73c [l2cap]) from [<c02f2cc8>] (sock_sendmsg+0xb8/0xd8)
>> [  694.537292] [<c02f2c10>] (sock_sendmsg+0x0/0xd8) from [<c02f3044>] (kernel_sendmsg+0x48/0x80)
>> ...
>>
>> Modified version after comments of Gustavo F. Padovan <gustavo@padovan.org>
>>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>> ---
>>  net/bluetooth/l2cap.c |   25 +++++++++++++++++++++++++
>>  1 files changed, 25 insertions(+), 0 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index bb00015..11060d6 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -2927,6 +2927,13 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
>>               break;
>>
>>       default:
>> +             /* don't delete l2cap channel if sk is owned by user */
>> +             if (sock_owned_by_user(sk)) {
>> +                     sk->sk_state = BT_DISCONN;
>> +                     l2cap_sock_clear_timer(sk);
>> +                     l2cap_sock_set_timer(sk, HZ);
>
> Using the sock timer like you are you using looks too hackish, there are
> kernel struct for such defer works. I still prefer the first solution,
> that avoids the call to l2cap_chan_del() only.

OK. Then let's go for the first solution.

> But we have to solve the problem with the sock_kill() call, I'm
> wondering if add a check inside l2cap_sock_kill is good idea. So we
> check if the socket is owned by user and if yes, we just return, however
> may have problem with socket refcnt doing that.

I think by just using refcounting (sock_hold / sock_put) we overcome
the problem.
No need for extra checks; they looks hackish when we can use proper way.

> Looking to the rfcomm code I found something that could be cause of the
> problem, there isn't any sock_hold() in the rfcomm code, maybe is it
> missing? Nevertheless it does the sock_put() without call sock_hold().

Do you mean it is unbalanced? sock_hold is probably executed in some
function returning sk (which is not the best practice).

> Like you I'm trying to figure out how to fix this issue, I don't know
> yet how to fix it properly. I advice to take a look on the rfcomm code
> and check if we really are missing a sock_hold() there.

My first version of the patch adds refcounting to RFCOMM send function.

> Also is not easy to reproduce such sequence of l2cap and rfcomm packets,
> so I can't test the issue here too.

I guess this is harder to reproduce with desktop system but you can
add mdelay when sending RFCOMM. This way tasklet has more chances to
preempt krfcommd process.

@@ -1668,6 +1671,8 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct
        if (err)
                goto done;

+       mdelay(100);
+
        if (msg->msg_flags & MSG_OOB) {
                err = -EOPNOTSUPP;
                goto done;

Could you try adding mdelay? There are reports that reproducing is
possible with rctest

Regards,
Andrei
