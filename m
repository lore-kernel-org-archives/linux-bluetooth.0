Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH BlueZ 1/2] monitor: Add LE Set Extended Scan Parameters
 decoding
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170606094120.14541-3-michal.narajowski@codecoup.pl>
Date: Thu, 8 Jun 2017 10:38:24 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F7778D21-46FC-40A4-BA71-E4B7AC73BB9F@holtmann.org>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl>
 <20170606094120.14541-3-michal.narajowski@codecoup.pl>
To: =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

> ---
> monitor/bt.h     | 12 +++++++
> monitor/packet.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 109 insertions(+), 1 deletion(-)
> 
> diff --git a/monitor/bt.h b/monitor/bt.h
> index 660564a..5ec3e5e 100644
> --- a/monitor/bt.h
> +++ b/monitor/bt.h
> @@ -2272,6 +2272,18 @@ struct bt_hci_cmd_le_set_periodic_adv_enable {
> 	uint8_t  handle;
> } __attribute__ ((packed));
> 
> +#define BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS		0x2041
> +struct bt_hci_cmd_le_set_ext_scan_params {
> +	uint8_t  own_addr_type;
> +	uint8_t  filter_policy;
> +	uint8_t  phys;
> +} __attribute__ ((packed));
> +struct bt_hci_le_scan_phy {
> +	uint8_t  type;
> +	uint16_t  interval;
> +	uint16_t  window;

some of the indentation went wrong here.

> +} __attribute__ ((packed));
> +
> #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
> struct bt_hci_evt_inquiry_complete {
> 	uint8_t  status;
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 8ffda90..fb6aee2 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -7336,6 +7336,101 @@ static void le_set_periodic_adv_enable_cmd(const void *data, uint8_t size)
> 	print_handle(cmd->handle);
> }
> 
> +static const struct {
> +	uint8_t bit;
> +	const char *str;
> +} ext_scan_phys_table[] = {
> +	{  0, "LE 1M"		},
> +	{  2, "LE Coded"		},
> +	{ }
> +};
> +
> +static int print_ext_scan_phys(uint8_t flags)
> +{
> +	uint8_t mask = flags;
> +	int bits_set = 0;
> +	int i;
> +
> +	print_field("PHYs: 0x%2.2x", flags);
> +
> +	for (i = 0; ext_scan_phys_table[i].str; i++) {
> +		if (flags & (1 << ext_scan_phys_table[i].bit)) {
> +			print_field("  %s", ext_scan_phys_table[i].str);
> +			mask &= ~(1 << ext_scan_phys_table[i].bit);
> +			++bits_set;
> +		}
> +	}
> +
> +	if (mask)
> +		print_text(COLOR_UNKNOWN_ADV_FLAG, "  Unknown scanning PHYs"
> +							" (0x%2.2x)", mask);
> +	return bits_set;
> +}
> +
> +static void print_scan_filter_policy(uint8_t policy)
> +{
> +	const char *str;
> +
> +	switch (policy) {
> +	case 0x00:
> +		str = "Accept all advertisement";
> +		break;
> +	case 0x01:
> +		str = "Ignore not in white list";
> +		break;
> +	case 0x02:
> +		str = "Accept all advertisement, inc. directed unresolved RPA";
> +		break;
> +	case 0x03:
> +		str = "Ignore not in white list, exc. directed unresolved RPA";
> +		break;
> +	default:
> +		str = "Reserved";
> +		break;
> +	}
> +
> +	print_field("Filter policy: %s (0x%2.2x)", str, policy);
> +}
> +
> +static void print_scan_type(uint8_t type)
> +{
> +	const char *str;
> +
> +	switch (type) {
> +	case 0x00:
> +		str = "Passive";
> +		break;
> +	case 0x01:
> +		str = "Active";
> +		break;
> +	default:
> +		str = "Reserved";
> +		break;
> +	}
> +
> +	print_field("Type: %s (0x%2.2x)", str, type);
> +}

Then lets please use them also for the other the legacy commands.

Regards

Marcel

