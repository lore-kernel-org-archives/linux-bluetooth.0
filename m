Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [RFC 2/2] Bluetooth: 6lowpan: Add connect/disconnect management commands
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418905432-19793-3-git-send-email-jukka.rissanen@linux.intel.com>
Date: Thu, 18 Dec 2014 17:48:23 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E0563D87-B641-495E-8183-BBB6A1E83A81@holtmann.org>
References: <1418905432-19793-1-git-send-email-jukka.rissanen@linux.intel.com> <1418905432-19793-3-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> Allow user space to connect and disconnect a 6lowpan connection via
> management interface.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> include/net/bluetooth/mgmt.h |  15 +++++++
> net/bluetooth/6lowpan.c      |  17 ++++++-
> net/bluetooth/6lowpan.h      |  18 ++++++++
> net/bluetooth/mgmt.c         | 103 +++++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 151 insertions(+), 2 deletions(-)
> create mode 100644 net/bluetooth/6lowpan.h
> 
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 95c34d5..ae69822 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -507,6 +507,14 @@ struct mgmt_cp_start_service_discovery {
> } __packed;
> #define MGMT_START_SERVICE_DISCOVERY_SIZE 4
> 
> +#define MGMT_OP_6LOWPAN_CONNECT		0x003B
> +#define MGMT_OP_6LOWPAN_DISCONNECT	0x003C
> +struct mgmt_cp_6lowpan_info {
> +	uint8_t addr_type;
> +	bdaddr_t bdaddr;
> +} __packed;
> +#define MGMT_6LOWPAN_INFO_SIZE		7
> +
> #define MGMT_EV_CMD_COMPLETE		0x0001
> struct mgmt_ev_cmd_complete {
> 	__le16	opcode;
> @@ -689,3 +697,10 @@ struct mgmt_ev_new_conn_param {
> #define MGMT_EV_UNCONF_INDEX_REMOVED	0x001e
> 
> #define MGMT_EV_NEW_CONFIG_OPTIONS	0x001f
> +
> +#define MGMT_EV_6LOWPAN_CONNECTED	0x0020
> +#define MGMT_EV_6LOWPAN_DISCONNECTED	0x0021
> +struct mgmt_ev_6lowpan_conn_param {
> +	struct mgmt_addr_info addr;
> +	uint32_t ifindex;
> +} __packed;

my thinking was actually to have this all implemented in the bluetooth_6lowpan module. Meaning we just give this a complete new channel number. So HCI_CHANNEL_NETWORK for example. This means that there is a bit of boilerplate with version numbers, supported commands and index listing, but that would mean that the core only has to deal with the basics. And eventually renaming this to bluetooth_network and including BNEP support as well.

Internally we will also need some way for 6LoWPAN to temporally add devices to the whitelist to connect to. Or to cause directed advertising or indirected advertising to cause connections. So this might be something we need to solve first. And testing on how to create large IPSP based networks that auto-connect each other.

Regards

Marcel

