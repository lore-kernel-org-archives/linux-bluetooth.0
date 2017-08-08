Return-Path: <michal.narajowski@codecoup.pl>
MIME-Version: 1.0
In-Reply-To: <684EAE9E-5929-45C5-A3DF-550B580360A8@holtmann.org>
References: <20170731133910.26745-1-michal.narajowski@codecoup.pl>
 <20170731133910.26745-5-michal.narajowski@codecoup.pl> <684EAE9E-5929-45C5-A3DF-550B580360A8@holtmann.org>
From: =?UTF-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Date: Tue, 8 Aug 2017 10:14:58 +0200
Message-ID: <CAJfb0ntkfdLQ5M97=UwV0ypxfG8Le_nNyx3GHfmVgTRMwPMtaw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 04/11] monitor: Add LE Extended Scan commands decoding
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I added this global new generic in the last patch. I will fix the typo
here and in the last patch.

Best regards
Micha=C5=82

2017-08-04 16:27 GMT+02:00 Marcel Holtmann <marcel@holtmann.org>:
> Hi Michal,
>
>> This patch adds decoding for following commands:
>>
>> LE Set Extended Scan Parameters
>> LE Set Extended Scan Enable
>> LE Extended Create Connection
>> LE Extended Advertising Report Event
>>
>> < HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13
>>        Own address type: Public (0x00)
>>        Filter policy: Accept all advertisement (0x00)
>>        PHYs: 0x05
>>        Entry 0: LE 1M
>>          Type: Active (0x01)
>>          Interval: 30.000 msec (0x0030)
>>          Window: 30.000 msec (0x0030)
>>        Entry 1: LE Coded
>>          Type: Active (0x01)
>>          Interval: 30.000 msec (0x0030)
>>          Window: 30.000 msec (0x0030)
>>
>> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6
>>        Extended scan: Enabled (0x01)
>>        Filter duplicates: Disabled (0x00)
>>        Duration: 0 msec (0x0000)
>>        Period: 0.00 sec (0x0000)
>>
>> < HCI Command: LE Extended Create Connection (0x08|0x0043) plen 29
>>        Filter policy: White list is not used (0x00)
>>        Own address type: Public (0x00)
>>        Peer address type: Public (0x00)
>>        Peer address: 11:22:33:C0:DE:C0 (OUI 11-22-33)
>>        Initiating PHYs: 0x04
>>        Entry 0: LE Coded
>>          Scan interval: 10.000 msec (0x0010)
>>          Scan window: 10.000 msec (0x0010)
>>          Min connection interval: 30.00 msec (0x0018)
>>          Max connection interval: 50.00 msec (0x0028)
>>          Connection latency: 0 (0x0000)
>>          Supervision timeout: 2560 msec (0x0100)
>>          Min connection length: 10.000 msec (0x0010)
>>          Max connection length: 480.000 msec (0x0300)
>> ---
>> monitor/bt.h     |  60 ++++++++
>> monitor/packet.c | 406 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>> 2 files changed, 449 insertions(+), 17 deletions(-)
>>
>> diff --git a/monitor/bt.h b/monitor/bt.h
>> index 0160dcc7f..74439b9e5 100644
>> --- a/monitor/bt.h
>> +++ b/monitor/bt.h
>> @@ -2275,6 +2275,47 @@ struct bt_hci_cmd_le_set_periodic_adv_enable {
>>       uint8_t  handle;
>> } __attribute__ ((packed));
>>
>> +#define BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS            0x2041
>> +struct bt_hci_cmd_le_set_ext_scan_params {
>> +     uint8_t  own_addr_type;
>> +     uint8_t  filter_policy;
>> +     uint8_t  num_phys;
>> +     uint8_t  data[0];
>> +} __attribute__ ((packed));
>> +struct bt_hci_le_scan_phy {
>> +     uint8_t  type;
>> +     uint16_t interval;
>> +     uint16_t window;
>> +} __attribute__ ((packed));
>> +
>> +#define BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE            0x2042
>> +struct bt_hci_cmd_le_set_ext_scan_enable {
>> +     uint8_t  enable;
>> +     uint8_t  filter_dup;
>> +     uint16_t duration;
>> +     uint16_t period;
>> +} __attribute__ ((packed));
>> +
>> +#define BT_HCI_CMD_LE_EXT_CREATE_CONN                0x2043
>> +struct bt_hci_cmd_le_ext_create_conn {
>> +     uint8_t  filter_policy;
>> +     uint8_t  own_addr_type;
>> +     uint8_t  peer_addr_type;
>> +     uint8_t  peer_addr[6];
>> +     uint8_t  phys;
>> +     uint8_t  data[0];
>> +} __attribute__ ((packed));
>> +struct bt_hci_le_ext_create_conn {
>> +     uint16_t scan_interval;
>> +     uint16_t scan_window;
>> +     uint16_t min_interval;
>> +     uint16_t max_interval;
>> +     uint16_t latency;
>> +     uint16_t supv_timeout;
>> +     uint16_t min_length;
>> +     uint16_t max_length;
>> +} __attribute__ ((packed));
>> +
>> #define BT_HCI_EVT_INQUIRY_COMPLETE           0x01
>> struct bt_hci_evt_inquiry_complete {
>>       uint8_t  status;
>> @@ -2885,6 +2926,25 @@ struct bt_hci_evt_le_phy_update_complete {
>>       uint8_t  rx_phy;
>> } __attribute__ ((packed));
>>
>> +#define BT_HCI_EVT_LE_EXT_ADV_REPORT 0x0d
>> +struct bt_hci_evt_le_ext_adv_report {
>> +     uint8_t  num_reports;
>> +} __attribute__ ((packed));
>> +struct bt_hci_le_ext_adv_report {
>> +     uint16_t event_type;
>> +     uint8_t  addr_type;
>> +     uint8_t  addr[6];
>> +     uint8_t  primary_phy;
>> +     uint8_t  secondary_phy;
>> +     uint8_t  sid;
>> +     uint8_t  tx_power;
>> +     int8_t   rssi;
>> +     uint16_t interval;
>> +     uint8_t  direct_addr_type;
>> +     uint8_t  direct_addr[6];
>> +     uint8_t  data_len;
>> +} __attribute__ ((packed));
>> +
>> #define BT_HCI_EVT_LE_ADV_SET_TERM            0x12
>> struct bt_hci_evt_le_adv_set_term {
>>       uint8_t  status;
>> diff --git a/monitor/packet.c b/monitor/packet.c
>> index f43be9adb..6a602d8a8 100644
>> --- a/monitor/packet.c
>> +++ b/monitor/packet.c
>> @@ -2305,7 +2305,7 @@ static void print_num_reports(uint8_t num_reports)
>>       print_field("Num reports: %d", num_reports);
>> }
>>
>> -static void print_adv_event_type(uint8_t type)
>> +static void print_adv_event_type(const char *label, uint8_t type)
>> {
>>       const char *str;
>>
>> @@ -2330,7 +2330,7 @@ static void print_adv_event_type(uint8_t type)
>>               break;
>>       }
>>
>> -     print_field("Event type: %s (0x%2.2x)", str, type);
>> +     print_field("%s: %s (0x%2.2x)", label, str, type);
>> }
>>
>> static void print_adv_channel_map(const char *label, uint8_t value)
>> @@ -6506,12 +6506,11 @@ static void le_set_adv_enable_cmd(const void *da=
ta, uint8_t size)
>>       print_field("Advertising: %s (0x%2.2x)", str, cmd->enable);
>> }
>>
>> -static void le_set_scan_parameters_cmd(const void *data, uint8_t size)
>> +static void print_scan_type(const char *label, uint8_t type)
>> {
>> -     const struct bt_hci_cmd_le_set_scan_parameters *cmd =3D data;
>>       const char *str;
>>
>> -     switch (cmd->type) {
>> +     switch (type) {
>>       case 0x00:
>>               str =3D "Passive";
>>               break;
>> @@ -6523,13 +6522,14 @@ static void le_set_scan_parameters_cmd(const voi=
d *data, uint8_t size)
>>               break;
>>       }
>>
>> -     print_field("Type: %s (0x%2.2x)", str, cmd->type);
>> +     print_field("%s: %s (0x%2.2x)", label, str, type);
>> +}
>>
>> -     print_interval(cmd->interval);
>> -     print_window(cmd->window);
>> -     print_own_addr_type(cmd->own_addr_type);
>> +static void print_scan_filter_policy(uint8_t policy)
>> +{
>> +     const char *str;
>>
>> -     switch (cmd->filter_policy) {
>> +     switch (policy) {
>>       case 0x00:
>>               str =3D "Accept all advertisement";
>>               break;
>> @@ -6547,7 +6547,18 @@ static void le_set_scan_parameters_cmd(const void=
 *data, uint8_t size)
>>               break;
>>       }
>>
>> -     print_field("Filter policy: %s (0x%2.2x)", str, cmd->filter_policy=
);
>> +     print_field("Filter policy: %s (0x%2.2x)", str, policy);
>> +}
>> +
>> +static void le_set_scan_parameters_cmd(const void *data, uint8_t size)
>> +{
>> +     const struct bt_hci_cmd_le_set_scan_parameters *cmd =3D data;
>> +
>> +     print_scan_type("Type", cmd->type);
>> +     print_interval(cmd->interval);
>> +     print_window(cmd->window);
>> +     print_own_addr_type(cmd->own_addr_type);
>> +     print_scan_filter_policy(cmd->filter_policy);
>> }
>>
>> static void le_set_scan_enable_cmd(const void *data, uint8_t size)
>> @@ -7552,6 +7563,183 @@ static void le_set_periodic_adv_enable_cmd(const=
 void *data, uint8_t size)
>>       print_handle(cmd->handle);
>> }
>>
>> +static const struct {
>> +     uint8_t bit;
>> +     const char *str;
>> +} ext_scan_phys_table[] =3D {
>> +     {  0, "LE 1M"           },
>> +     {  2, "LE Coded"                },
>> +     { }
>> +};
>> +
>> +static void print_ext_scan_phys(const void *data, uint8_t flags)
>> +{
>> +     const struct bt_hci_le_scan_phy *scan_phy;
>> +     uint8_t mask =3D flags;
>> +     int bits_set =3D 0;
>> +     int i;
>> +
>> +     print_field("PHYs: 0x%2.2x", flags);
>> +
>> +     for (i =3D 0; ext_scan_phys_table[i].str; i++) {
>> +             if (flags & (1 << ext_scan_phys_table[i].bit)) {
>> +                     scan_phy =3D data + bits_set * sizeof(*scan_phy);
>> +                     mask &=3D ~(1 << ext_scan_phys_table[i].bit);
>> +
>> +                     print_field("Entry %d: %s", bits_set,
>> +                                             ext_scan_phys_table[i].str=
);
>> +                     print_scan_type("  Type", scan_phy->type);
>> +                     print_slot_625("  Interval", scan_phy->interval);
>> +                     print_slot_625("  Window", scan_phy->window);
>> +
>> +                     ++bits_set;
>> +             }
>> +     }
>> +
>> +     if (mask)
>> +             print_text(COLOR_UNKNOWN_ADV_FLAG, "  Unknown scanning PHY=
s"
>> +                                                     " (0x%2.2x)", mask=
);
>> +}
>> +
>> +static void le_set_ext_scan_params_cmd(const void *data, uint8_t size)
>> +{
>> +     const struct bt_hci_cmd_le_set_ext_scan_params *cmd =3D data;
>> +
>> +     print_own_addr_type(cmd->own_addr_type);
>> +     print_scan_filter_policy(cmd->filter_policy);
>> +     print_ext_scan_phys(cmd->data, cmd->num_phys);
>> +}
>> +
>> +static void print_enable(const char *label, uint8_t enable)
>> +{
>> +     const char *str;
>> +
>> +     switch (enable) {
>> +     case 0x00:
>> +             str =3D "Disable";
>> +             break;
>
> =E2=80=9CDisabled=E2=80=9D.
>
> And didn=E2=80=99t you do this a global new generic one already in an ear=
lier patch?
>
> Regards
>
> Marcel
>
