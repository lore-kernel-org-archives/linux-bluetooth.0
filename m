Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100216113408.GA15436@vigoh>
References: <508e92ca1002160236k34c18949jc7d7187645ef4aa0@mail.gmail.com>
	 <20100216113408.GA15436@vigoh>
Date: Tue, 16 Feb 2010 13:58:34 +0200
Message-ID: <508e92ca1002160358g1c6b599bo329f4f51cae18041@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix kernel crash on BT stress tests.
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 16, 2010 at 1:34 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Andrei,
>
> * Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2010-02-16 12:36:47 +0200]:
>
>> From 0135f732cb45e5e91062aca84a61a40b172200a4 Mon Sep 17 00:00:00 2001
>> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>> Date: Tue, 16 Feb 2010 10:52:33 +0200
>> Subject: [PATCH] Bluetooth: Fix kernel crash on BT stress tests.
>>
>> Added very simple check that req buffer has enough space to
>> fit configuration parameters. Shall be enough to reject packets
>> with configuration size more than req buffer.
>>
>> Crash trace below
>>
>> [ 6069.659393] Unable to handle kernel paging request at virtual
>> address 02000205
>> [ 6069.673034] Internal error: Oops: 805 [#1] PREEMPT
>> ...
>> [ 6069.727172] PC is at l2cap_add_conf_opt+0x70/0xf0 [l2cap]
>> [ 6069.732604] LR is at l2cap_recv_frame+0x1350/0x2e78 [l2cap]
>> ...
>> [ 6070.030303] Backtrace:
>> [ 6070.032806] [<bf1c2880>] (l2cap_add_conf_opt+0x0/0xf0 [l2cap]) from
>> [<bf1c6624>] (l2cap_recv_frame+0x1350/0x2e78 [l2cap])
>> [ 6070.043823]  r8:dc5d3100 r7:df2a91d6 r6:00000001 r5:df2a8000 r4:00000200
>> [ 6070.050659] [<bf1c52d4>] (l2cap_recv_frame+0x0/0x2e78 [l2cap]) from
>> [<bf1c8408>] (l2cap_recv_acldata+0x2bc/0x350 [l2cap])
>> [ 6070.061798] [<bf1c814c>] (l2cap_recv_acldata+0x0/0x350 [l2cap]) from
>> [<bf0037a4>] (hci_rx_task+0x244/0x478 [bluetooth])
>> [ 6070.072631]  r6:dc647700 r5:00000001 r4:df2ab740
>> [ 6070.077362] [<bf003560>] (hci_rx_task+0x0/0x478 [bluetooth]) from
>> [<c006b9fc>] (tasklet_action+0x78/0xd8)
>> [ 6070.087005] [<c006b984>] (tasklet_action+0x0/0xd8) from [<c006c160>]
>
> Are you using ERTM or Streaming mode? If yes, I have a guess about the
> source of the problem. On l2cap_parse_conf_rsp we check for:
>
>        while (len >= L2CAP_CONF_OPT_SIZE) {
>                len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
>
> But on case L2CAP_CONF_RFC olen is greater than L2CAP_CONF_OPT_SIZE we
> can exceed the buffer size. So the right fix will be check if len >=
> olen in that case.

We use test tool which sends "Configure Response" packet with size 262
bytes. So "req" buffer gets overwritten. But in the code nobody checks
that "req" might be overwritten.

-- Andrei

>
>
>>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>> ---
>>  net/bluetooth/l2cap.c |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index 400efa2..69b7280 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -2830,6 +2830,12 @@ static inline int l2cap_config_rsp(struct
>> l2cap_conn *conn, struct l2cap_cmd_hdr
>>                       int len = cmd->len - sizeof(*rsp);
>>                       char req[64];
>>
>> +                     if (len > sizeof(req) - sizeof(struct l2cap_conf_req)) {
>> +                             BT_ERR("Config response is too big");
>> +                             l2cap_send_disconn_req(conn, sk);
>> +                             goto done;
>> +                     }
>> +
>>                       /* throw out any old stored conf requests */
>>                       result = L2CAP_CONF_SUCCESS;
>>                       len = l2cap_parse_conf_rsp(sk, rsp->data,
>> --
>> 1.6.0.4
>
>
> --
> Gustavo F. Padovan
> http://padovan.org
>
> ProFUSION embedded systems - http://profusion.mobi
>
