Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v4 06/13] Bluetooth: Use selected PHYs in extended connect
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1531301495-14479-7-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Sat, 14 Jul 2018 19:30:16 +0200
Cc: linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <57CD0B95-352D-4F3B-8CCA-EA4E19F20615@holtmann.org>
References: <1531301495-14479-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1531301495-14479-7-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> Use the selected PHYs by Set PHY Configuration management command
> in extended create connection.
> 
> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
> ---
> net/bluetooth/hci_conn.c | 63 ++++++++++++++++++++++++++++++++++++------------
> 1 file changed, 47 insertions(+), 16 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index cc967ca..5d421a2 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -777,8 +777,9 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
> 	if (use_ext_conn(hdev)) {
> 		struct hci_cp_le_ext_create_conn *cp;
> 		struct hci_cp_le_ext_conn_param *p;
> -		/* As of now only LE 1M is supported */
> -		u8 data[sizeof(*cp) + sizeof(*p) * 1];
> +		u8 data[sizeof(*cp) + sizeof(*p) * 3];
> +		u8 init_phys;
> +		u32 plen;
> 
> 		cp = (void *) data;
> 		p = (void *) cp->data;
> @@ -788,24 +789,54 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
> 		bacpy(&cp->peer_addr, &conn->dst);
> 		cp->peer_addr_type = conn->dst_type;
> 		cp->own_addr_type = own_addr_type;
> -		cp->phys = LE_SCAN_PHY_1M;
> 
> -		memset(p, 0, sizeof(*p));
> +		if (scan_1m(hdev))
> +			cp->phys |= LE_SCAN_PHY_1M;
> 
> -		/* Set window to be the same value as the interval to enable
> -		 * continuous scanning.
> -		 */
> +		if (scan_2m(hdev))
> +			cp->phys |= LE_SCAN_PHY_2M;
> +
> +		if (scan_coded(hdev))
> +			cp->phys |= LE_SCAN_PHY_CODED;
> +
> +		init_phys = cp->phys;
> +
> +		plen = sizeof(*cp);
> +
> +		/* Use same param for all PHYs */
> +		while (init_phys) {
> +			u16 min_interval, max_interval, supv_timeout;
> 
> -		p->scan_interval = cpu_to_le16(hdev->le_scan_interval);
> -		p->scan_window = p->scan_interval;
> -		p->conn_interval_min = cpu_to_le16(conn->le_conn_min_interval);
> -		p->conn_interval_max = cpu_to_le16(conn->le_conn_max_interval);
> -		p->conn_latency = cpu_to_le16(conn->le_conn_latency);
> -		p->supervision_timeout = cpu_to_le16(conn->le_supv_timeout);
> -		p->min_ce_len = cpu_to_le16(0x0000);
> -		p->max_ce_len = cpu_to_le16(0x0000);
> +			if (!(init_phys & 0x01)) {
> +				init_phys >>= 0x01;
> +				continue;
> +			}
> +
> +			memset(p, 0, sizeof(*p));
> +
> +			/* Set window to be the same value as the interval to
> +			 * enable continuous scanning.
> +			 */
> +
> +			min_interval = conn->le_conn_min_interval;
> +			max_interval = conn->le_conn_max_interval;
> +			supv_timeout = conn->le_supv_timeout;
> +
> +			p->scan_interval = cpu_to_le16(hdev->le_scan_interval);
> +			p->scan_window = p->scan_interval;
> +			p->conn_interval_min = cpu_to_le16(min_interval);
> +			p->conn_interval_max = cpu_to_le16(max_interval);
> +			p->conn_latency = cpu_to_le16(conn->le_conn_latency);
> +			p->supervision_timeout = cpu_to_le16(supv_timeout);
> +			p->min_ce_len = cpu_to_le16(0x0000);
> +			p->max_ce_len = cpu_to_le16(0x0000);
> +
> +			p++;
> +			plen += sizeof(*p);
> +			init_phys >>= 1;
> +		}

Same comment as for the ext scan parameters one. I think we need to make this more readable since this is too complex. In addition it will make it really hard if different parameters are used for different PHYs.

Regards

Marcel

