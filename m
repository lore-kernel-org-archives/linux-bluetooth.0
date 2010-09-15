Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100914182147.GB5398@vigoh>
References: <1284018181-29928-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1284018181-29928-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20100914182147.GB5398@vigoh>
Date: Wed, 15 Sep 2010 14:17:54 +0300
Message-ID: <AANLkTikPj=MTd7nF5Qucg-cX4yaQKYvXfJL+TXT002+W@mail.gmail.com>
Subject: Re: [PATCHv3 3/3] Bluetooth: check L2CAP length in first ACL fragment
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Sep 14, 2010 at 9:21 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Andrei,
>
> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-09-09 10:43:01 +0300]:
>
>> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>>
>> Current Bluetooth code assembles fragments of big L2CAP packets
>> in l2cap_recv_acldata and then checks allowed L2CAP size in
>> assemled L2CAP packet (pi->imtu < skb->len).
>>
>> The patch moves allowed L2CAP size check to the early stage when
>> we receive the first fragment of L2CAP packet. We do not need to
>> reserve and keep L2CAP fragments for bad packets.
>>
>> Updated version after comments from Mat Martineau <mathewm@codeaurora.org>
>>
>> Trace below is received when using stress tools sending big
>> fragmented L2CAP packets.
>> ...
>> [ 1712.798492] swapper: page allocation failure. order:4, mode:0x4020
>> [ 1712.804809] [<c0031870>] (unwind_backtrace+0x0/0xdc) from [<c00a1f70>]
>> (__alloc_pages_nodemask+0x4)
>> [ 1712.814666] [<c00a1f70>] (__alloc_pages_nodemask+0x47c/0x4d4) from
>> [<c00a1fd8>] (__get_free_pages+)
>> [ 1712.824645] [<c00a1fd8>] (__get_free_pages+0x10/0x3c) from [<c026eb5c>]
>> (__alloc_skb+0x4c/0xfc)
>> [ 1712.833465] [<c026eb5c>] (__alloc_skb+0x4c/0xfc) from [<bf28c738>]
>> (l2cap_recv_acldata+0xf0/0x1f8 )
>> [ 1712.843322] [<bf28c738>] (l2cap_recv_acldata+0xf0/0x1f8 [l2cap]) from
>> [<bf0094ac>] (hci_rx_task+0x)
>> ...
>>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>> ---
>>  net/bluetooth/l2cap.c |   17 +++++++++++++++++
>>  1 files changed, 17 insertions(+), 0 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index ce8f5e4..c95fbd8 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -4654,6 +4654,8 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
>>
>>       if (flags & ACL_START) {
>>               struct l2cap_hdr *hdr;
>> +             struct sock *sk;
>> +             u16 cid;
>>               int len;
>>
>>               if (conn->rx_len) {
>> @@ -4673,6 +4675,7 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
>>
>>               hdr = (struct l2cap_hdr *) skb->data;
>>               len = __le16_to_cpu(hdr->len) + L2CAP_HDR_SIZE;
>> +             cid = __le16_to_cpu(hdr->cid);
>>
>>               if (len == skb->len) {
>>                       /* Complete frame received */
>> @@ -4689,6 +4692,20 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
>>                       goto drop;
>>               }
>>
>> +             sk = l2cap_get_chan_by_scid(&conn->chan_list, cid);
>> +
>> +             if (sk && l2cap_pi(sk)->imtu < len) {
>> +                     BT_ERR("Frame exceeding recv MTU (len %d, MTU %d)",
>> +                                     len, l2cap_pi(sk)->imtu);
>
> I think you have to check if the imtu is less than (len -
> L2CAP_HDR_SIZE) because we don't count the header in the MTU.
>
>> +                     conn->rx_len = 0; /* needed? */
>
> It's not needed. rx_len is always zero here.
>

Thanks, I will fix those issues.

Regards,
Andrei
