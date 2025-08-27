Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AD930CD9F;
	Wed, 27 Aug 2025 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292227; cv=none; b=C/SQULVum33kLs8Jelo/qGYwCkaxXUmy7lE1nsW9DiASt50D6Q5cTLDN5Ffb0CDGwE9qAa3j0wlpiLycsuayWxnhBtPTG4K5mC0Sn+rNDXjrbA9lkK3iBcKptWKQLWNEJ3nO7Au3xzw7j7u5678w/tlHXR0TJfVz3J+TApPdWYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292227; c=relaxed/simple;
	bh=71TjIHXaemnR5GSOcFGJQ0u9QJZgPjfVehYXuruYTns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0BCmTxFjd4SVuiXLlEwcjQawmzwgo8T1/04Cujb5rTZwbiuJQ+/Uc34VnZZm3RcUkWE1TNnMgi4X/qyLTcvMOZ6jpMZe93mN2Q6dZuvwTumQI8qkMCBLIIJLo9lPCJY/KEc8v9tHTEsctXe2UgIbCxz5AiCf4cChXwn1bKdTnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.202] (p5b13a549.dip0.t-ipconnect.de [91.19.165.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D3D0260213B1E;
	Wed, 27 Aug 2025 12:56:50 +0200 (CEST)
Message-ID: <a261ed13-4c0b-43cf-b177-d33272626d25@molgen.mpg.de>
Date: Wed, 27 Aug 2025 12:56:50 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_h5: implement CRC data integrity
To: Javier Nieto <jgnieto@cs.stanford.edu>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250827043254.26611-1-jgnieto@cs.stanford.edu>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250827043254.26611-1-jgnieto@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Javier,


Thank you very much for the patch. Great work!

Am 27.08.25 um 06:32 schrieb Javier Nieto:
> The UART-based H5 protocol supports CRC data integrity checks for
> reliable packets. The host sets bit 5 in the configuration field of the
> CONFIG link control message to indicate that CRC is supported. The
> controller sets the same bit in the CONFIG RESPONSE message to indicate
> that CRC may be used from then on.
> 
> Signed-off-by: Javier Nieto <jgnieto@cs.stanford.edu>
> ---
> 
> Tested on a MangoPi MQ-Pro with a Realtek RTL8723DS Bluetooth controller
> using the tip of the bluetooth-next tree.

Any btmon trace?

I’d add the above to the proper commit message.

> It would be nice to have this feature available for somewhat more reliable
> communication over UART, especially if RTS/CTS is disabled, as this is the
> primary benefit of the H5 protocol. Thanks!
> 
> ---
>   drivers/bluetooth/hci_h5.c | 42 ++++++++++++++++++++++++++++++++++----
>   1 file changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index d0d4420c1a0f..7faafc62666b 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -7,6 +7,8 @@
>    */
>   
>   #include <linux/acpi.h>
> +#include <linux/bitrev.h>
> +#include <linux/crc-ccitt.h>
>   #include <linux/errno.h>
>   #include <linux/gpio/consumer.h>
>   #include <linux/kernel.h>
> @@ -58,6 +60,7 @@ enum {
>   	H5_TX_ACK_REQ,		/* Pending ack to send */
>   	H5_WAKEUP_DISABLE,	/* Device cannot wake host */
>   	H5_HW_FLOW_CONTROL,	/* Use HW flow control */
> +	H5_CRC,			/* Use CRC */
>   };
>   
>   struct h5 {
> @@ -141,8 +144,8 @@ static void h5_link_control(struct hci_uart *hu, const void *data, size_t len)
>   
>   static u8 h5_cfg_field(struct h5 *h5)
>   {
> -	/* Sliding window size (first 3 bits) */
> -	return h5->tx_win & 0x07;
> +	/* Sliding window size (first 3 bits) and CRC request (fifth bit). */
> +	return (h5->tx_win & 0x07) | 0x10;

Could a macro be defined for the CRC request bit?

>   }
>   
>   static void h5_timed_event(struct timer_list *t)
> @@ -360,8 +363,10 @@ static void h5_handle_internal_rx(struct hci_uart *hu)
>   		h5_link_control(hu, conf_rsp, 2);
>   		h5_link_control(hu, conf_req, 3);
>   	} else if (memcmp(data, conf_rsp, 2) == 0) {
> -		if (H5_HDR_LEN(hdr) > 2)
> +		if (H5_HDR_LEN(hdr) > 2) {
>   			h5->tx_win = (data[2] & 0x07);
> +			assign_bit(H5_CRC, &h5->flags, data[2] & 0x10);
> +		}
>   		BT_DBG("Three-wire init complete. tx_win %u", h5->tx_win);
>   		h5->state = H5_ACTIVE;
>   		hci_uart_init_ready(hu);
> @@ -425,7 +430,24 @@ static void h5_complete_rx_pkt(struct hci_uart *hu)
>   
>   static int h5_rx_crc(struct hci_uart *hu, unsigned char c)
>   {
> -	h5_complete_rx_pkt(hu);
> +	struct h5 *h5 = hu->priv;
> +	const unsigned char *hdr = h5->rx_skb->data;
> +	u16 crc;
> +	__be16 crc_be;
> +
> +	crc = crc_ccitt(0xffff, hdr, 4 + H5_HDR_LEN(hdr));
> +	crc = bitrev16(crc);
> +
> +	crc_be = cpu_to_be16(crc);
> +
> +	if (memcmp(&crc_be, hdr + 4 + H5_HDR_LEN(hdr), 2) != 0) {
> +		bt_dev_err(hu->hdev, "Received packet with invalid CRC");
> +		h5_reset_rx(h5);
> +	} else {
> +		/* Remove CRC bytes */
> +		skb_trim(h5->rx_skb, 4 + H5_HDR_LEN(hdr));
> +		h5_complete_rx_pkt(hu);
> +	}
>   
>   	return 0;
>   }
> @@ -556,6 +578,7 @@ static void h5_reset_rx(struct h5 *h5)
>   	h5->rx_func = h5_rx_delimiter;
>   	h5->rx_pending = 0;
>   	clear_bit(H5_RX_ESC, &h5->flags);
> +	clear_bit(H5_CRC, &h5->flags);
>   }
>   
>   static int h5_recv(struct hci_uart *hu, const void *data, int count)
> @@ -686,6 +709,7 @@ static struct sk_buff *h5_prepare_pkt(struct hci_uart *hu, u8 pkt_type,
>   	struct h5 *h5 = hu->priv;
>   	struct sk_buff *nskb;
>   	u8 hdr[4];
> +	u16 crc;
>   	int i;
>   
>   	if (!valid_packet_type(pkt_type)) {
> @@ -713,6 +737,7 @@ static struct sk_buff *h5_prepare_pkt(struct hci_uart *hu, u8 pkt_type,
>   	/* Reliable packet? */
>   	if (pkt_type == HCI_ACLDATA_PKT || pkt_type == HCI_COMMAND_PKT) {
>   		hdr[0] |= 1 << 7;
> +		hdr[0] |= (test_bit(H5_CRC, &h5->flags) && 1) << 6;
>   		hdr[0] |= h5->tx_seq;
>   		h5->tx_seq = (h5->tx_seq + 1) % 8;
>   	}
> @@ -732,6 +757,15 @@ static struct sk_buff *h5_prepare_pkt(struct hci_uart *hu, u8 pkt_type,
>   	for (i = 0; i < len; i++)
>   		h5_slip_one_byte(nskb, data[i]);
>   
> +	if (H5_HDR_CRC(hdr)) {
> +		crc = crc_ccitt(0xffff, hdr, 4);
> +		crc = crc_ccitt(crc, data, len);
> +		crc = bitrev16(crc);
> +
> +		h5_slip_one_byte(nskb, (crc >> 8) & 0xff);
> +		h5_slip_one_byte(nskb, crc & 0xff);
> +	}
> +
>   	h5_slip_delim(nskb);
>   
>   	return nskb;

The diff looks good. Feel free to carry:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
