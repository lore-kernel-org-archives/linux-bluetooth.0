Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 5/6] monitor: Add basic decoding for Mesh Provisioning
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170719130939.24893-3-luiz.dentz@gmail.com>
Date: Wed, 19 Jul 2017 19:49:21 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1A3FF20F-9423-4CD9-B07C-35A2D28F4EF7@holtmann.org>
References: <20170719130939.24893-1-luiz.dentz@gmail.com>
 <20170719130939.24893-3-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This adds basic decoding for Mesh Provisioning packets such as:
> 
> < HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32
>        Length: 24
>        Mesh Provision: 024874cb0003dddd0000000000000000000000000000
>          Link ID: 0x024874cb
>          Transaction Number: 0
>          Provisioning Bearer Control (0x03)
>          Link Open (0x00)
>          Device UUID: 03dddd00000000000000000000000000
> 
>> HCI Event: LE Meta Event (0x3e) plen 20
>      LE Advertising Report (0x02)
>        Num reports: 1
>        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
>        Address type: Random (0x01)
>        Address: 34:11:85:DC:41:39 (Non-Resolvable)
>        Data length: 8
>        Mesh Provision: 024874cb0007
>          Link ID: 0x024874cb
>          Transaction Number: 0
>          Provisioning Bearer Control (0x03)
>          Link Ack (0x01)
>        RSSI: -28 dBm (0xe4)
> ---
> monitor/packet.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 77 insertions(+)
> 
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 51ba7b2..2df97fa 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -3589,6 +3589,82 @@ static void print_mesh_beacon(const uint8_t *data, uint8_t len)
> 	}
> }
> 
> +static void print_mesh_prov(const uint8_t *data, uint8_t len)
> +{
> +	if (len < 6)
> +		return;
> +
> +	print_field("  Link ID: 0x%08x", get_be32(&data[0]));
> +	print_field("  Transaction Number: %u", data[4]);
> +
> +	data += 5;
> +	len -= 5;
> +
> +	switch (data[0] & 0x03) {
> +	case 0x00:
> +		print_field("  Transaction Start (0x00)");
> +		if (len < 5) {
> +			packet_hexdump(data + 1, len - 1);
> +			return;
> +		}
> +		print_field("  SeqN: %u", data[0] & 0xfc >> 2);

(data[0] & 0xfc) >> 2 for clarity.

> +		print_field("  TotalLength: %u", get_be16(&data[1]));

data + 1. The &data[1] syntax is complicated.

> +		print_field("  FCS: 0x%2.2x", data[3]);
> +		print_hex_field("  Data", &data[4], len - 4);

data + 4

Same comments as the other patch, just packet_hexdump in case of leftovers.

> +		break;
> +	case 0x01:
> +		print_field("  Transaction Acknowledgment (0x01)");
> +		break;
> +	case 0x02:
> +		print_field("  Transaction Continuation (0x02)");
> +		print_field("  SegmentIndex: %u", data[0] >> 2);
> +		print_hex_field("  Data", &data[1], len - 1);
> +		break;
> +	case 0x03:
> +		print_field("  Provisioning Bearer Control (0x03)");
> +		switch (data[0] >> 2) {
> +		case 0x00:
> +			print_field("  Link Open (0x00)");
> +			if (len < 17) {
> +				packet_hexdump(data + 1, len - 1);
> +				break;
> +			}
> +			print_hex_field("  Device UUID", data, 16);
> +			break;
> +		case 0x01:
> +			print_field("  Link Ack (0x01)");
> +			break;
> +		case 0x02:
> +			print_field("  Link Close (0x02)");
> +			if (len < 2) {
> +				packet_hexdump(data + 1, len - 1);
> +				break;
> +			}
> +
> +			switch (data[1]) {
> +			case 0x00:
> +				print_field("  Reason: Success (0x00)");
> +				break;
> +			case 0x01:
> +				print_field("  Reason: Timeout (0x01)");
> +				break;
> +			case 0x02:
> +				print_field("  Reason: Fail (0x02)");
> +				break;
> +			default:
> +				print_field("  Reason: Unrecognized (0x%2.2x)",
> +								data[1]);
> +			}
> +			break;
> +		default:
> +			packet_hexdump(data + 1, len - 1);

break;

> +		}
> +		break;
> +	default:
> +		packet_hexdump(data, len);

break;

> +	}
> +}
> +
> static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
> {
> 	uint16_t len = 0;
> @@ -3819,6 +3895,7 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
> 
> 		case BT_EIR_MESH_PROV:
> 			print_hex_field("Mesh Provisioning", data, data_len);

Move that into print_mesh_prov.

> +			print_mesh_prov(data, data_len);
> 			break;
> 
> 		case BT_EIR_MESH_BEACON:

Regards

Marcel

