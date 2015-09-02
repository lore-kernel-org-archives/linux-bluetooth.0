Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6DFBE0FF-297F-4523-9218-2A705E5DA167@holtmann.org>
References: <1441135442-14505-1-git-send-email-kieranbingham@gmail.com>
	<6DFBE0FF-297F-4523-9218-2A705E5DA167@holtmann.org>
Date: Wed, 2 Sep 2015 13:22:20 +0100
Message-ID: <CAB3z_RpmftfeMYXVAGpiYEc-kOxzGWsT1kHbn5Q6m-eCF8YUQg@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: btmrvl: skb resource leak, and double free.
From: Kieran Bingham <kieranbingham@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, Amitkumar Karwar <akarwar@marvell.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 1 September 2015 at 23:12, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Kieran,
>
>> if btmrvl_tx_pkt() is called, and the branch
>>  if (skb_headroom(skb) < BTM_HEADER_LEN)
>> evaluates positive, a new skb is allocated via skb_realloc_headroom.
>
> is that branch actually valid and can happen? I mean someone must have thought about it, but skb usage in Bluetooth is pretty linear and normally all skb should be allocated with a 8 byte headroom.
>
> For example when we look at btsdio_tx_packet() from btsdio.c, then we do not even bother with checking that we have enough headroom. We know that the skb we got from the core was allocated with enough headroom.
>
> I am almost convinced that coverity found dead code here that is never executed.


I started looking at coverity bugs, ordered by oldest first. So this
has been around for a long time, without anyone looking into it or
changing it (or noticing a leak) So I suspect this could actually all
be evidence towards dead-code.
In fact, now I think about it more - it would have resulted in a
double-free - which should have been caught had it occurred ...

I've looked through the other drivers, and see that most only ever
skb_push with 1 byte, and are always happy to do that.
And yes, the btsdio pushes 4 bytes, just like this one, and it is
sharing the same hci_register_dev structure and hierarchy.


I'll re-spin with a removal of the broken / dead code instead, much
cleaner and simpler.


>> The original skb is stored in a tmp variable, before being free'd.
>> However on success, the new skb, is not free'd, nor is it
>> returned to the caller which will then double-free the original skb.
>>
>> This issue exists from the original driver submission in
>> commit: #132ff4e5fa8dfb71a7d99902f88043113947e972
>>
>> Move the error handling, and kfree_skb inside the helper function,
>> where the statistics can be updated, and the skb free'd at the
>> appropriate occasion.
>>
>> Reported by coverity (CID 113422)
>>
>> Signed-off-by: Kieran Bingham <kieranbingham@gmail.com>
>> ---
>> drivers/bluetooth/btmrvl_main.c | 26 ++++++++++++++------------
>> 1 file changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
>> index de05deb..ceaef95 100644
>> --- a/drivers/bluetooth/btmrvl_main.c
>> +++ b/drivers/bluetooth/btmrvl_main.c
>> @@ -366,15 +366,15 @@ void btmrvl_firmware_dump(struct btmrvl_private *priv)
>>
>> static int btmrvl_tx_pkt(struct btmrvl_private *priv, struct sk_buff *skb)
>> {
>> -     int ret = 0;
>> +     int ret = -EINVAL;
>>
>>       if (!skb || !skb->data)
>> -             return -EINVAL;
>> +             goto tx_pkt_out;
>
> with your change the skb can never be NULL since you are checking this before calling this function.

The calling function provides the check before my patch, so yes even
without my change it couldn't have been null ... perhaps the null
check can be removed, although its fairly harmless here.


>>
>>       if (!skb->len || ((skb->len + BTM_HEADER_LEN) > BTM_UPLD_SIZE)) {
>>               BT_ERR("Tx Error: Bad skb length %d : %d",
>>                                               skb->len, BTM_UPLD_SIZE);
>> -             return -EINVAL;
>> +             goto tx_pkt_out;
>>       }
>>
>>       if (skb_headroom(skb) < BTM_HEADER_LEN) {
>> @@ -385,7 +385,7 @@ static int btmrvl_tx_pkt(struct btmrvl_private *priv, struct sk_buff *skb)
>>                       BT_ERR("Tx Error: realloc_headroom failed %d",
>>                               BTM_HEADER_LEN);
>>                       skb = tmp;
>> -                     return -EINVAL;
>> +                     goto tx_pkt_out;
>>               }
>>
>>               kfree_skb(tmp);
>> @@ -406,6 +406,14 @@ static int btmrvl_tx_pkt(struct btmrvl_private *priv, struct sk_buff *skb)
>>       if (priv->hw_host_to_card)
>>               ret = priv->hw_host_to_card(priv, skb->data, skb->len);
>>
>> +tx_pkt_out:
>> +     if (ret)
>> +             priv->btmrvl_dev.hcidev->stat.err_tx++;
>> +     else
>> +             priv->btmrvl_dev.hcidev->stat.byte_tx += skb->len;
>
> I do not like this conditional based on ret. I have to twist my brain to ensure that ret == 0 is ensured so that the skb->len gets added correctly.

This code can go back to being untouched, and left in the parent
function. (Unless you'd prefer it to be rewritten there too?)


>> +
>> +     kfree_skb(skb);
>> +
>>       return ret;
>> }
>>
>> @@ -670,14 +678,8 @@ static int btmrvl_service_main_thread(void *data)
>>                       continue;
>>
>>               skb = skb_dequeue(&adapter->tx_queue);
>> -             if (skb) {
>> -                     if (btmrvl_tx_pkt(priv, skb))
>> -                             priv->btmrvl_dev.hcidev->stat.err_tx++;
>> -                     else
>> -                             priv->btmrvl_dev.hcidev->stat.byte_tx += skb->len;
>> -
>> -                     kfree_skb(skb);
>> -             }
>> +             if (skb)
>> +                     btmrvl_tx_pkt(priv, skb);
>>       }
>
> Regards
>
> Marcel

--
Regards

Kieran
