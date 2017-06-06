Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170606094120.14541-18-michal.narajowski@codecoup.pl>
References: <20170606094120.14541-1-michal.narajowski@codecoup.pl> <20170606094120.14541-18-michal.narajowski@codecoup.pl>
From: =?UTF-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Date: Tue, 6 Jun 2017 11:46:56 +0200
Message-ID: <CAJfb0nt5btOCmzXXaBkvWgJH_K2toBhEGsgUT-ycSfvfNJQdPw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 15/31] monitor: Add LE Set Extended Scan Parameters decoding
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sent by mistake. This is part of the set as 15/31 and 16/31.

2017-06-06 11:41 GMT+02:00 Micha=C5=82 Narajowski <michal.narajowski@codeco=
up.pl>:
> < HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13
>         Own address type: Random (0x01)
>         Filter policy: Reserved (0x09)
>         PHYs: 0x05
>           LE 1M
>           LE Coded
>         Entry 0
>           Type: Reserved (0x03)
>           Interval: 491.250 msec (0x0312)
>           Window: 320.625 msec (0x0201)
>         Entry 1
>           Type: Active (0x01)
>           Interval: 0.625 msec (0x0001)
>           Window: 0.625 msec (0x0001)
> ---
>  monitor/bt.h     |  12 +++++++
>  monitor/packet.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 111 insertions(+), 1 deletion(-)
>
> diff --git a/monitor/bt.h b/monitor/bt.h
> index c44aad7..fd61c53 100644
> --- a/monitor/bt.h
> +++ b/monitor/bt.h
> @@ -2274,6 +2274,18 @@ struct bt_hci_cmd_le_set_periodic_adv_enable {
>         uint8_t  handle;
>  } __attribute__ ((packed));
>
> +#define BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS              0x2041
> +struct bt_hci_cmd_le_set_ext_scan_params {
> +       uint8_t  own_addr_type;
> +       uint8_t  filter_policy;
> +       uint8_t  num_phys;
> +} __attribute__ ((packed));
> +struct bt_hci_le_scan_phy {
> +       uint8_t  type;
> +       uint16_t  interval;
> +       uint16_t  window;
> +} __attribute__ ((packed));
> +
>  #define BT_HCI_EVT_INQUIRY_COMPLETE            0x01
>  struct bt_hci_evt_inquiry_complete {
>         uint8_t  status;
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 1c113ff..78b780f 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -7333,6 +7333,102 @@ static void le_set_periodic_adv_enable_cmd(const =
void *data, uint8_t size)
>         print_handle(cmd->handle);
>  }
>
> +static const struct {
> +       uint8_t bit;
> +       const char *str;
> +} ext_scan_phys_table[] =3D {
> +       {  0, "LE 1M"           },
> +       {  2, "LE Coded"                },
> +       { }
> +};
> +
> +static int print_ext_scan_phys(uint8_t flags)
> +{
> +       uint8_t mask =3D flags;
> +       int bits_set =3D 0;
> +       int i;
> +
> +       print_field("PHYs: 0x%2.2x", flags);
> +
> +       for (i =3D 0; ext_scan_phys_table[i].str; i++) {
> +               if (flags & (1 << ext_scan_phys_table[i].bit)) {
> +                       print_field("  %s", ext_scan_phys_table[i].str);
> +                       mask &=3D ~(1 << ext_scan_phys_table[i].bit);
> +                       ++bits_set;
> +               }
> +       }
> +
> +       if (mask)
> +               print_text(COLOR_UNKNOWN_ADV_FLAG, "  Unknown scanning PH=
Ys"
> +                                                       " (0x%2.2x)", mas=
k);
> +       return bits_set;
> +}
> +
> +static void print_scan_filter_policy(uint8_t policy)
> +{
> +       const char *str;
> +
> +       switch (policy) {
> +       case 0x00:
> +               str =3D "Accept all advertisement";
> +               break;
> +       case 0x01:
> +               str =3D "Ignore not in white list";
> +               break;
> +       case 0x02:
> +               str =3D "Accept all advertisement, inc. directed unresolv=
ed RPA";
> +               break;
> +       case 0x03:
> +               str =3D "Ignore not in white list, exc. directed unresolv=
ed RPA";
> +               break;
> +       default:
> +               str =3D "Reserved";
> +               break;
> +       }
> +
> +       print_field("Filter policy: %s (0x%2.2x)", str, policy);
> +}
> +
> +static void print_scan_type(const char* label, uint8_t type)
> +{
> +       const char *str;
> +
> +       switch (type) {
> +       case 0x00:
> +               str =3D "Passive";
> +               break;
> +       case 0x01:
> +               str =3D "Active";
> +               break;
> +       default:
> +               str =3D "Reserved";
> +               break;
> +       }
> +
> +       print_field("%s: %s (0x%2.2x)", label, str, type);
> +}
> +
> +static void le_set_ext_scan_params_cmd(const void *data, uint8_t size)
> +{
> +       const struct bt_hci_cmd_le_set_ext_scan_params *cmd =3D data;
> +       const struct bt_hci_le_scan_phy *scan_phy;
> +       int num_structs;
> +       int i;
> +
> +       print_own_addr_type(cmd->own_addr_type);
> +       print_scan_filter_policy(cmd->filter_policy);
> +       num_structs =3D print_ext_scan_phys(cmd->num_phys);
> +
> +       for (i =3D 0; i < num_structs; ++i) {
> +               print_field("Entry %d", i);
> +               scan_phy =3D data + 3 + i * sizeof(struct bt_hci_le_scan_=
phy);
> +
> +               print_scan_type("  Type", scan_phy->type);
> +               print_slot_625("  Interval", scan_phy->interval);
> +               print_slot_625("  Window", scan_phy->window);
> +       }
> +}
> +
>  struct opcode_data {
>         uint16_t opcode;
>         int bit;
> @@ -8078,7 +8174,9 @@ static const struct opcode_data opcode_table[] =3D =
{
>         { 0x2040, 300, "LE Set Periodic Advertising Enable",
>                                 le_set_periodic_adv_enable_cmd, 2, true,
>                                 status_rsp, 1, true },
> -       { 0x2041, 301, "LE Set Extended Scan Parameters" },
> +       { 0x2041, 301, "LE Set Extended Scan Parameters",
> +                               le_set_ext_scan_params_cmd, 3, false,
> +                               status_rsp, 1, true },
>         { 0x2042, 302, "LE Set Extended Scan Enable" },
>         { 0x2043, 303, "LE Extended Create Connection" },
>         { 0x2044, 304, "LE Periodic Advertising Create Sync" },
> --
> 2.9.3
>
