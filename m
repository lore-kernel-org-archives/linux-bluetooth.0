Return-Path: <cyrus@holtmann.org>
Message-ID: <4D4986FF.2070309@Atheros.com>
Date: Wed, 2 Feb 2011 22:01:59 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [PATCH] Bluetooth: Support SCO over HCI for Atheros AR300x Bluetooth
 device
References: <1296211744-2487-1-git-send-email-suraj@atheros.com> <20110202161641.GC2273@joana>
In-Reply-To: <20110202161641.GC2273@joana>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 2/2/2011 9:46 PM, Gustavo F. Padovan wrote:
> Hi Suraj,
>
> * Suraj Sumangala<suraj@atheros.com>  [2011-01-28 16:19:04 +0530]:
>
>> This patch adds SCO over HCI support to Atheros AR300x HCI transport
>> driver.
>>
>> Signed-off-by: Suraj Sumangala<suraj@atheros.com>
>> ---
>>   drivers/bluetooth/hci_ath.c |   18 +++++++++---------
>>   1 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
>> index 6a160c1..161bd20 100644
>> --- a/drivers/bluetooth/hci_ath.c
>> +++ b/drivers/bluetooth/hci_ath.c
>> @@ -162,11 +162,6 @@ static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>>   {
>>   	struct ath_struct *ath = hu->priv;
>>
>> -	if (bt_cb(skb)->pkt_type == HCI_SCODATA_PKT) {
>> -		kfree_skb(skb);
>> -		return 0;
>> -	}
>> -
>>   	/*
>>   	 * Update power management enable flag with parameters of
>>   	 * HCI sleep enable vendor specific HCI command.
>> @@ -183,10 +178,15 @@ static int ath_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>>   	/* Prepend skb with frame type */
>>   	memcpy(skb_push(skb, 1),&bt_cb(skb)->pkt_type, 1);
>>
>> -	skb_queue_tail(&ath->txq, skb);
>> -	set_bit(HCI_UART_SENDING,&hu->tx_state);
>> -
>> -	schedule_work(&ath->ctxtsw);
>> +	if (bt_cb(skb)->pkt_type == HCI_SCODATA_PKT) {
>> +		skb_queue_head(&ath->txq, skb);
>> +		clear_bit(HCI_UART_SENDING,&hu->tx_state);
>> +		hci_uart_tx_wakeup(hu);
>
> Seems you are giving priority to SCO packets, right? why?
>

Yes, There was some degradation in audio quality which improved when we 
gave priority to SCO.

Do you see any potential problem with that? I will re-verify this anyway.

Regards
Suraj



