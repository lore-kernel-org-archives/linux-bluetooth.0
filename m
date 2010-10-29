Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101029104435.GQ15050@null>
References: <linux-bluetooth@vger.kernel.org>
	<1287791820-22693-3-git-send-email-anderson.briglia@openbossa.org>
	<20101029104435.GQ15050@null>
Date: Fri, 29 Oct 2010 09:41:55 -0400
Message-ID: <AANLkTimTUFK9id6kQyggt_xWsB-RspwbPoB4m39XU2cP@mail.gmail.com>
Subject: Re: [PATCH 2/6] Bluetooth: fix receiving L2CAP packets over LE
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: ext Anderson Briglia <anderson.briglia@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

On Fri, Oct 29, 2010 at 6:44 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
> Hi Anderson,
>
> On Sat, Oct 23, 2010 at 01:56:56AM +0200, ext Anderson Briglia wrote:
>> From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
>>
>> As L2CAP packets coming over LE don't have any more encapsulation,
>> other than L2CAP, we are able to process them as soon as they arrive.
>
> Why is this change needed? Was something broken without this patch?
>

This change is needed because without it the receiving side would
always think that it was receiving continuation frames.

As the flags parameter is zero, it would fall into the "} else {"
condition, and because no frame was received before, conn->rx_len
would be zero and the frame would be discarded. Without this patch I
was seeing those "Unexpected continuation frame ..." messages on the
receiving side.

>
>
>>
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
>> ---
>>  net/bluetooth/l2cap.c |   17 +++++++++++++++--
>>  1 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index 2bf083e..1ac44f4 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -4768,17 +4768,30 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>>  static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>>  {
>>       struct l2cap_conn *conn = hcon->l2cap_data;
>> +     struct l2cap_hdr *hdr;
>> +     int len;
>>
>>       if (!conn && !(conn = l2cap_conn_add(hcon, 0)))
>>               goto drop;
>>
>>       BT_DBG("conn %p len %d flags 0x%x", conn, skb->len, flags);
>>
>> +     if (hcon->type == LE_LINK) {
>> +             hdr = (struct l2cap_hdr *) skb->data;
>> +             len = __le16_to_cpu(hdr->len) + L2CAP_HDR_SIZE;
>> +
>> +             if (len == skb->len) {
>> +                     /* Complete frame received */
>> +                     l2cap_recv_frame(conn, skb);
>> +                     return 0;
>> +             }
>> +
>> +             goto drop;
>> +     }
>> +
>>       if (flags & ACL_START) {
>> -             struct l2cap_hdr *hdr;
>>               struct sock *sk;
>>               u16 cid;
>> -             int len;
>>
>>               if (conn->rx_len) {
>>                       BT_ERR("Unexpected start frame (len %d)", skb->len);
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Ville
>


Cheers,
--
Vinicius
