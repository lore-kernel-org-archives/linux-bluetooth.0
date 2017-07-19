Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 6/6] monitor: Add basic decoding for Mesh Data
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170719130939.24893-4-luiz.dentz@gmail.com>
Date: Wed, 19 Jul 2017 19:50:25 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0F17F936-9F15-4257-8F46-F0624705EF90@holtmann.org>
References: <20170719130939.24893-1-luiz.dentz@gmail.com>
 <20170719130939.24893-4-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This adds basic decoding for Mesh Data packets such as:
> 
>> HCI Event: LE Meta Event (0x3e) plen 43
>      LE Advertising Report (0x02)
>        Num reports: 1
>        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
>        Address type: Random (0x01)
>        Address: 29:3C:CE:85:C7:3D (Non-Resolvable)
>        Data length: 31
>        Mesh Data: 37cb3a2bdfca0783b10833cfbdc9e691b0d58b2dada00269181477c901
>          IV: 1
>          NID: 0x1b
>        RSSI: -28 dBm (0xe4)
> ---
> monitor/packet.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
> 
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 2df97fa..efb03bb 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -3665,6 +3665,15 @@ static void print_mesh_prov(const uint8_t *data, uint8_t len)
> 	}
> }
> 
> +static void print_mesh_data(const uint8_t *data, uint8_t len)
> +{
> +	if (len < 1)
> +		return;
> +
> +	print_field("  IV: %u", data[0] & 0x01);
> +	print_field("  NID: 0x%2.2x", data[0] & 0xfe);
> +}
> +
> static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
> {
> 	uint16_t len = 0;
> @@ -3891,6 +3900,7 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
> 
> 		case BT_EIR_MESH_DATA:
> 			print_hex_field("Mesh Data", data, data_len);

Move into print_mesh_data.

> +			print_mesh_data(data, data_len);
> 			break;

Regards

Marcel

