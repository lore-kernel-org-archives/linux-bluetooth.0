Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 4/6] monitor: Add basic decoding for Mesh Beacon
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170719130939.24893-2-luiz.dentz@gmail.com>
Date: Wed, 19 Jul 2017 19:47:10 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C276D00F-8640-467F-8F14-BC6646060FBD@holtmann.org>
References: <20170719130939.24893-1-luiz.dentz@gmail.com>
 <20170719130939.24893-2-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This adds basic decoding for Mesh Beacon packets such as:
> 
>> HCI Event: LE Meta Event (0x3e) plen 37
>      LE Advertising Report (0x02)
>        Num reports: 1
>        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
>        Address type: Random (0x01)
>        Address: 36:47:34:FC:63:DA (Non-Resolvable)
>        Data length: 25
>        Mesh Beacon: 00dddd0000000000000000000000000000000000000000
>          Unprovisioned Device Beacon (0x00)
>          Device UUID: 00dddd00000000000000000000000000
>          OOB Information: 0x0000
>          URI Hash: 0x0000
>        RSSI: -28 dBm (0xe4)
> 
> < HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32
>        Length: 24
>        Mesh Beacon: 0100c7005d732329eadf000000003e60e50797ef6d5c
>          Secure Network Beacon (0x01)
>          Flags: 0x01
>          Network Id: 00c7005d732329ea
>          IV Index: 0xdf000000
>          Authentication Value: 003e60e50797ef6d
> ---
> monitor/packet.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 77 insertions(+)
> 
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 4ed0faa..51ba7b2 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -3513,6 +3513,82 @@ static const struct {
> 	{ }
> };
> 
> +static const struct {
> +	uint8_t bit;
> +	const char *str;
> +} mesh_oob_table[] = {
> +	{ 0, "Other"							},
> +	{ 1, "Eletronic / URI"						},

Electronic.

> +	{ 2, "2D machine-readable code"					},
> +	{ 3, "Bar code"							},
> +	{ 4, "Near Field Communication (NFC)"				},
> +	{ 5, "Number"							},
> +	{ 6, "String"							},
> +	{ 11, "On box"							},
> +	{ 12, "Inside box"						},
> +	{ 13, "On piece of paper"					},
> +	{ 14, "Inside manual"						},
> +	{ 14, "On Device"						},

On device.

> +	{ }
> +};
> +
> +static void print_mesh_beacon(const uint8_t *data, uint8_t len)
> +{
> +	uint16_t oob;
> +	int i;
> +
> +	if (len < 1)
> +		return;
> +
> +	switch (data[0]) {
> +	case 0x00:
> +		print_field("  Unprovisioned Device Beacon (0x00)");
> +		if (len < 18) {
> +			packet_hexdump(data + 1, len - 1);
> +			break;
> +		}
> +
> +		print_hex_field("  Device UUID", data, 16);
> +
> +		oob = get_be16(&data[16]);
> +		print_field("  OOB Information: 0x%4.4x", oob);
> +
> +		for (i = 0; mesh_oob_table[i].str; i++) {
> +			if (oob & (1 << mesh_oob_table[i].bit))
> +				print_field("    %s", mesh_oob_table[i].str);
> +		}
> +
> +		if (len < 22) {
> +			packet_hexdump(data + 18, len - 18);
> +			break;
> +		}
> +
> +		print_field("  URI Hash: 0x%4.4x", get_be32(&data[18]));

I would also packet_hexdump here in case there are any leftovers. We want to see if there are eventually malformed packets.

> +		break;
> +	case 0x01:
> +		print_field("  Secure Network Beacon (0x01)");
> +		if (len < 21) {
> +			packet_hexdump(data + 1, len - 1);
> +			break;
> +		}

I think that beacons are fixed size.

> +
> +		print_field("  Flags: 0x%2.2x", data[0]);
> +
> +		if (data[0] & 0x01)
> +			print_field("    Key Refresh");
> +
> +		if (data[0] & 0x02)
> +			print_field("    IV Update");
> +
> +		print_hex_field("  Network Id", &data[1], 8);
> +		print_field("  IV Index: 0x%08x", get_be32(&data[9]));
> +		print_hex_field("  Authentication Value", &data[13], 8);
> +		break;

If you want to allow decoding of longer packets, then packet_hexdump at the end.

> +	default:
> +		packet_hexdump(data, len);

break;

> +	}
> +}
> +
> static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
> {
> 	uint16_t len = 0;
> @@ -3747,6 +3823,7 @@ static void print_eir(const uint8_t *eir, uint8_t eir_len, bool le)
> 
> 		case BT_EIR_MESH_BEACON:
> 			print_hex_field("Mesh Beacon", data, data_len);

Why not move that into print_mesh_beacon.

> +			print_mesh_beacon(data, data_len);
> 			break;
> 
> 		case BT_EIR_MANUFACTURER_DATA:

Regards

Marcel

