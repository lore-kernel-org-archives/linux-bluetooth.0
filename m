Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171011190307.28570-1-brian.gix@intel.com>
References: <20171011190307.28570-1-brian.gix@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 11 Oct 2017 22:39:01 +0300
Message-ID: <CABBYNZ+P_Ph+uhhSewCA+wMN0JKwctfQN4d-11qouci3h_bPeA@mail.gmail.com>
Subject: Re: [PATCH v2] Add Mesh management API
To: Brian Gix <brian.gix@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Wed, Oct 11, 2017 at 10:03 PM, Brian Gix <brian.gix@intel.com> wrote:
> Version 2 of patch that fixes compile errors

I guess a better start for this set would be to add the documentation
to userspace.

> ---
>  include/net/bluetooth/mgmt.h | 91 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 72a456b..6bfee19 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -604,6 +604,82 @@ struct mgmt_cp_set_appearance {
>  } __packed;
>  #define MGMT_SET_APPEARANCE_SIZE       2
>
> +#define MGMT_OP_MESH_GET_OPTIONS       0x0044
> +#define MGMT_MESH_GET_OPTIONS_SIZE     0
> +struct mgmt_rp_mesh_get_options {
> +       __u8     revision;
> +       __u8     channel_map;
> +       __s8     min_tx_power;
> +       __s8     max_tx_power;
> +       __u8     max_scan_filter;
> +       __u8     max_filter_pattern;
> +       __u8     max_adv_slot;
> +} __packed;
> +
> +#define MGMT_OP_MESH_SET_SCAN_FILTER   0x0045
> +struct mgmt_cp_set_scan_filter {
> +       __u8     filter_id;
> +       __u8     num_patterns;
> +       __u8     patterns[30];
> +} __packed;
> +#define MGMT_MESH_SET_SCAN_FILTER_SIZE 32
> +struct mgmt_rp_set_scan_filter {
> +       __u8     filter_id;
> +} __packed;
> +
> +#define MGMT_OP_MESH_SCAN              0x0046
> +struct mgmt_cp_mesh_scan {
> +       __u8     enable;
> +       __u8     channel_map;
> +       __u8     filter_id;
> +} __packed;
> +#define MGMT_MESH_SCAN_SIZE            3
> +
> +#define MGMT_OP_MESH_SEND              0x0047
> +struct mgmt_cp_mesh_send {
> +       __u8     adv_slot;
> +       __u8     addr_type;
> +       __u8     channel_map;
> +       __s8     tx_power;
> +       __u8     retx_count;
> +       __u8     retx_interval;
> +       __u8     scan_duration;
> +       __u8     scan_delay;
> +       __u8     scan_filter;
> +       __u8     data_len;
> +       __u8     data[31];
> +} __packed;
> +#define MGMT_MESH_SEND_SIZE            41
> +struct mgmt_rp_mesh_send {
> +       __u8     adv_slot;
> +} __packed;
> +
> +#define MGMT_OP_MESH_SEND_TIMED                0x0048
> +struct mgmt_cp_mesh_send_timed {
> +       __u8     adv_slot;
> +       __u8     addr_type;
> +       __u8     channel_map;
> +       __s8     tx_power;
> +       __le32   instant;
> +       __u8     tx_delay;
> +       __u8     tx_window;
> +       __u8     data_len;
> +       __u8     data[31];
> +} __packed;
> +#define MGMT_MESH_SEND_TIMED_SIZE      42
> +struct mgmt_rp_mesh_send_timed {
> +       __u8     adv_slot;
> +} __packed;
> +
> +#define MGMT_OP_MESH_SEND_CANCEL       0x0049
> +struct mgmt_cp_mesh_send_cancel {
> +       __u8     adv_slot;
> +} __packed;
> +#define MGMT_MESH_SEND_CANCEL_SIZE     1
> +struct mgmt_rp_mesh_send_cancel {
> +       __u8     adv_slot;
> +} __packed;
> +
>  #define MGMT_EV_CMD_COMPLETE           0x0001
>  struct mgmt_ev_cmd_complete {
>         __le16  opcode;
> @@ -824,3 +900,18 @@ struct mgmt_ev_ext_info_changed {
>         __le16  eir_len;
>         __u8    eir[0];
>  } __packed;
> +
> +#define MGMT_EV_MESH_SEND_COMPLETE     0x0026
> +struct mgmt_ev_mesh_send_complete {
> +       __u8    adv_slot;
> +} __packed;
> +
> +#define MGMT_EV_MESH_SCAN_REPORT       0x0027
> +struct mgmt_ev_mesh_scan_report {
> +       __u8    num_reports;
> +       __u8    channel;
> +       __s8    rssi;
> +       __le32  instant;
> +       __u8    data_len;
> +       __u8    data[31];
> +} __packed;
> --
> 2.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
