Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100619005327.GE14514@vigoh>
References: <1276692725-10284-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20100619005327.GE14514@vigoh>
Date: Mon, 21 Jun 2010 12:16:23 +0300
Message-ID: <AANLkTimFaghkLTgStLyTuHicn3d6q-efPWgfx9jnmO_x@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: check l2cap pending status before sending
	l2cap connect request
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Jun 19, 2010 at 3:53 AM, Gustavo F. Padovan <gustavo@padovan.org> wrote:
> Hi Andrei,
>
> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-06-16 15:52:05 +0300]:
>
>> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>>
>> Due to race condition in L2CAP state machine L2CAP Connection Request
>> may be sent twice for SDP with the same source channel id. Problems
>> reported connecting to Apple products, some carkit, Blackberry phones.
>>
>> ...
>> 2010-06-07 21:18:03.651031 < ACL data: handle 1 flags 0x02 dlen 12
>>     L2CAP(s): Connect req: psm 1 scid 0x0040
>> 2010-06-07 21:18:03.653473 > HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 1 packets 1
>> 2010-06-07 21:18:03.653808 > HCI Event: Auth Complete (0x06) plen 3
>>     status 0x00 handle 1
>> 2010-06-07 21:18:03.653869 < ACL data: handle 1 flags 0x02 dlen 12
>>     L2CAP(s): Connect req: psm 1 scid 0x0040
>> ...
>>
>> Patch uses L2CAP_CONF_CONNECT_PEND flag to mark that L2CAP Connection
>> Request has been sent.
>>
>> Modified version of Ville Tervo patch.
>>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>> ---
>>  net/bluetooth/l2cap.c |   11 +++++++++--
>>  1 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index fc81acb..1ed51ad 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -387,13 +387,16 @@ static void l2cap_do_start(struct sock *sk)
>>               if (!(conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE))
>>                       return;
>>
>> -             if (l2cap_check_security(sk)) {
>> +             if (l2cap_check_security(sk) &&
>> +                             ! l2cap_pi(sk)->conf_state &
>> +                             L2CAP_CONF_CONNECT_PEND) {
>
> This is wrong, you have to add parentheses here:
>        !(l2cap_pi(sk)->conf_state & L2CAP_CONF_CONNECT_PEND)

Ah! My mistake when rearranging patch. Thanks a lot for the review.

I will send a new patch when I will test everything.

Regards,
Andrei

>
>>                       struct l2cap_conn_req req;
>>                       req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
>>                       req.psm  = l2cap_pi(sk)->psm;
>>
>>                       l2cap_pi(sk)->ident = l2cap_get_ident(conn);
>>
>> +                     l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
>>                       l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
>>                                       L2CAP_CONN_REQ, sizeof(req), &req);
>>               }
>> @@ -441,13 +444,16 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>>               }
>>
>>               if (sk->sk_state == BT_CONNECT) {
>> -                     if (l2cap_check_security(sk)) {
>> +                     if (l2cap_check_security(sk) &&
>> +                                     ! l2cap_pi(sk)->conf_state &
>> +                                     L2CAP_CONF_CONNECT_PEND) {
>
> Here too.
>
>>                               struct l2cap_conn_req req;
>>                               req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
>>                               req.psm  = l2cap_pi(sk)->psm;
>>
>>                               l2cap_pi(sk)->ident = l2cap_get_ident(conn);
>>
>> +                             l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
>>                               l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
>>                                       L2CAP_CONN_REQ, sizeof(req), &req);
>>                       }
>> @@ -3828,6 +3834,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>>
>>                               l2cap_pi(sk)->ident = l2cap_get_ident(conn);
>>
>> +                             l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
>>                               l2cap_send_cmd(conn, l2cap_pi(sk)->ident,
>>                                       L2CAP_CONN_REQ, sizeof(req), &req);
>>                       } else {
>> --
>> 1.7.0.4
>
> Otherwise the patch seem fine to me.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Gustavo F. Padovan
> http://padovan.org
>
