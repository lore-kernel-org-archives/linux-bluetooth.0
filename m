Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1 3/4] Bluetooth: BCSP fails to ACK re-transmitted frames from the peer
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <501e6875-ee82-1297-47f4-eab4696c9187@mentor.com>
Date: Thu, 8 Sep 2016 11:28:23 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <95E1F4C0-2F50-4C25-BA00-F5674C70B341@holtmann.org>
References: <1473257710-2073-1-git-send-email-Dean_Jenkins@mentor.com> <1473257710-2073-4-git-send-email-Dean_Jenkins@mentor.com> <09CFA74F-BCE6-4627-A318-E18B3BCEBE07@holtmann.org> <501e6875-ee82-1297-47f4-eab4696c9187@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

>>> Send an ACK frame with the current txack value in response to
>>> every received reliable frame unless a TX reliable frame is being
>>> sent. This modification allows re-transmitted frames from the remote
>>> peer to be acknowledged rather than ignored. It means that the remote
>>> peer knows which frame number to start re-transmitting from.
>>> 
>>> Without this modification, the recovery time to a missing frame
>>> from the remote peer was unnecessarily being extended because the
>>> headers of the out of order reliable frames were being discarded rather
>>> than being processed. The frame headers of received frames will
>>> indicate whether the local peer's transmissions have been
>>> acknowledged by the remote peer. Therefore, the local peer may
>>> unnecessarily re-transmit despite the remote peer already indicating
>>> that the frame had been acknowledged in out of order reliable frame.
>>> 
>>> Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
>>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>>> Signed-off-by: Rajeev Kumar <rajeev_kumar@mentor.com>
>>> ---
>>> drivers/bluetooth/hci_bcsp.c | 82 ++++++++++++++++++++++++++------------------
>>> 1 file changed, 48 insertions(+), 34 deletions(-)
>>> 
>>> diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
>>> index d7d23ce..739ae59 100644
>>> --- a/drivers/bluetooth/hci_bcsp.c
>>> +++ b/drivers/bluetooth/hci_bcsp.c
>>> @@ -485,13 +485,27 @@ static inline void bcsp_unslip_one_byte(struct bcsp_struct *bcsp, unsigned char
>>> static void bcsp_complete_rx_pkt(struct hci_uart *hu)
>>> {
>>> 	struct bcsp_struct *bcsp = hu->priv;
>>> -	int pass_up;
>>> +	int pass_up = 0;
>>> 
>>> 	if (bcsp->rx_skb->data[0] & 0x80) {	/* reliable pkt */
>>> 		BT_DBG("Received seqno %u from card", bcsp->rxseq_txack);
>>> -		bcsp->rxseq_txack++;
>>> -		bcsp->rxseq_txack %= 0x8;
>>> -		bcsp->txack_req    = 1;
>>> +
>>> +		/* check the rx sequence number is as expected */
>>> +		if ((bcsp->rx_skb->data[0] & 0x07) == bcsp->rxseq_txack) {
>>> +			bcsp->rxseq_txack++;
>>> +			bcsp->rxseq_txack %= 0x8;
>>> +		} else {
>>> +			/* handle re-transmitted packet or
>>> +			   when packet was missed */
>>> +			BT_ERR("Out-of-order packet arrived, got %u expected %u",
>>> +				bcsp->rx_skb->data[0] & 0x07, bcsp->rxseq_txack);
>>> +
>>> +			/* do not process out-of-order packet payload */
>>> +			pass_up = 2;
>>> +		}
>>> +
>>> +		/* send current txack value to all received reliable packets */
>>> +		bcsp->txack_req = 1;
>>> 
>>> 		/* If needed, transmit an ack pkt */
>>> 		hci_uart_tx_wakeup(hu);
>>> @@ -500,26 +514,32 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
>>> 	bcsp->rxack = (bcsp->rx_skb->data[0] >> 3) & 0x07;
>>> 	BT_DBG("Request for pkt %u from card", bcsp->rxack);
>>> 
>>> +	/* handle received ACK indications,
>>> +	   including those from out-of-order packets */
>>> 	bcsp_pkt_cull(bcsp);
>>> -	if ((bcsp->rx_skb->data[1] & 0x0f) == 6 &&
>>> -			bcsp->rx_skb->data[0] & 0x80) {
>>> -		hci_skb_pkt_type(bcsp->rx_skb) = HCI_ACLDATA_PKT;
>>> -		pass_up = 1;
>>> -	} else if ((bcsp->rx_skb->data[1] & 0x0f) == 5 &&
>>> -			bcsp->rx_skb->data[0] & 0x80) {
>>> -		hci_skb_pkt_type(bcsp->rx_skb) = HCI_EVENT_PKT;
>>> -		pass_up = 1;
>>> -	} else if ((bcsp->rx_skb->data[1] & 0x0f) == 7) {
>>> -		hci_skb_pkt_type(bcsp->rx_skb) = HCI_SCODATA_PKT;
>>> -		pass_up = 1;
>>> -	} else if ((bcsp->rx_skb->data[1] & 0x0f) == 1 &&
>>> -			!(bcsp->rx_skb->data[0] & 0x80)) {
>>> -		bcsp_handle_le_pkt(hu);
>>> -		pass_up = 0;
>>> -	} else
>>> -		pass_up = 0;
>>> -
>>> -	if (!pass_up) {
>>> +
>>> +	if (pass_up != 2) {
>>> +		if ((bcsp->rx_skb->data[1] & 0x0f) == 6 &&
>>> +				(bcsp->rx_skb->data[0] & 0x80)) {
>> lets start using proper network subsystem coding style now.
> 
> I think you are referring to the indentation style, right ?
> 
> I am aware of the checkpatch.pl --strict warning of
> CHECK: Alignment should match open parenthesis
> 
> Would this style be acceptable so the 2nd line of arguments is one character
> position to the right of the opening parenthesis of the 1st line by adding
> spaces after tabs to do the alignment ?
> 
> +        if ((bcsp->rx_skb->data[1] & 0x0f) == 6 &&
> +            (bcsp->rx_skb->data[0] & 0x80)) {

yes, this is how it should look like.

>> 
>>> +			bt_cb(bcsp->rx_skb)->pkt_type = HCI_ACLDATA_PKT;
>>> +			pass_up = 1;
>>> +		} else if ((bcsp->rx_skb->data[1] & 0x0f) == 5 &&
>>> +				(bcsp->rx_skb->data[0] & 0x80)) {
>>> +			bt_cb(bcsp->rx_skb)->pkt_type = HCI_EVENT_PKT;
>>> +			pass_up = 1;
>>> +		} else if ((bcsp->rx_skb->data[1] & 0x0f) == 7) {
>>> +			bt_cb(bcsp->rx_skb)->pkt_type = HCI_SCODATA_PKT;
>>> +			pass_up = 1;
>>> +		} else if ((bcsp->rx_skb->data[1] & 0x0f) == 1 &&
>>> +				!(bcsp->rx_skb->data[0] & 0x80)) {
>>> +			bcsp_handle_le_pkt(hu);
>>> +			pass_up = 0;
>>> +		} else {
>>> +			pass_up = 0;
>>> +		}
>>> +	}
>>> +
>>> +	if (pass_up == 0) {
>>> 		struct hci_event_hdr hdr;
>>> 		u8 desc = (bcsp->rx_skb->data[1] & 0x0f);
>>> 
>>> @@ -544,11 +564,15 @@ static void bcsp_complete_rx_pkt(struct hci_uart *hu)
>>> 			}
>>> 		} else
>>> 			kfree_skb(bcsp->rx_skb);
>>> -	} else {
>>> +	} else if (pass_up == 1) {
>>> 		/* Pull out BCSP hdr */
>>> 		skb_pull(bcsp->rx_skb, 4);
>>> 
>>> 		hci_recv_frame(hu->hdev, bcsp->rx_skb);
>>> +	} else {
>>> +		/* ignore packet payload of already ACKed re-transmitted
>>> +		   packets or when a packet was missed in the BCSP window */
>> Also use network subsystem comment style.
> 
> Please can confirm which comment style is your preference because I have doubts.
> 
> Below is a list of possible comment styles (I think), please tell me which ones
> are acceptable:
> 
> a)
> /*
> * comment line #1
> * comment line #2
> */
> 
> b) I think you prefer this style aka "network subsystem style"
> /* comment line #1
> * comment line #2
> */

Yes. That is what we are suppose to be using.

> 
> c)
> /* comment line #1 */
> /* comment line #2 */
> 
> d) this style was used in our patch to match the style in the file
> /* comment line #1
>   comment line #2 */
> 
> drivers/bluetooth/hci_bcsp.c already contains styles b) and d)
> 
> If you agree, I can create some style clean-up commits for
> drivers/bluetooth/hci_bcsp.c before applying our Bluetooth patch.

Go ahead if you have time for it.

Regards

Marcel

