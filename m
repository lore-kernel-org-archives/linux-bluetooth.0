Return-Path: <vinicius.gomes@intel.com>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: "Felipe F. Tonello" <eu@felipetonello.com>, linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH v5 BlueZ 4/4] Bluetooth: Handle Slave Connection Interval Range AD
In-Reply-To: <20170413122203.4247-5-eu@felipetonello.com>
References: <20170413122203.4247-1-eu@felipetonello.com> <20170413122203.4247-5-eu@felipetonello.com>
Date: Thu, 13 Apr 2017 11:24:38 -0700
Message-ID: <877f2o6u8p.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

"Felipe F. Tonello" <eu@felipetonello.com> writes:

> The Slave Connection Interval Range data type contains the Peripheral's
> preferred connection interval range, for all logical connections.
>
> It is useful to parse it in the Kernel so there is no multiple calls to
> MGMT interface to update the device connection parameters and subsequent
> connection command call to this device will use proper connection
> parameters. This saves context-switches and eliminates user-space to
> update the connection parameters each time a device is found or
> bluetoothd is restarted and so on. Also, there is no need for the
> user-space to know care about it because if the slave device wishes to
> persist with these parameters, it should use the L2CAP connection
> parameters upade request upon a completed connection.

nitpick: upade -> update

>
> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
> ---
>  net/bluetooth/mgmt.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 1fba2a03f8ae..ea5d6c85f173 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -7442,6 +7442,46 @@ static bool is_filter_match(struct hci_dev *hdev, s8 rssi, u8 *eir,
>  	return true;
>  }
>
> +static bool has_eir_slave_conn_int(const u8 *eir_data, u8 eir_len,
> +				   u16 *min_conn, u16 *max_conn)
> +{
> +	u16 len = 0;
> +	const u8 EIR_SLAVE_CONN_INT = 0x12; /* Slave Connection Interval Range */
> +
> +	while (len < eir_len - 1) {
> +		u8 field_len = eir_data[0];
> +		const u8 *data;
> +		u8 data_len;
> +
> +		/* Check for the end of EIR */
> +		if (field_len == 0)
> +			break;
> +
> +		len += field_len + 1;
> +
> +		/* Do not continue EIR Data parsing if got
> +		 * incorrect length
> +		 */
> +		if (len > eir_len)
> +			break;
> +
> +		data = &eir_data[2];
> +		data_len = field_len - 1;
> +
> +		if (eir_data[1] == EIR_SLAVE_CONN_INT) {
> +			if (data_len < 4)
> +				break;
> +			*min_conn = le16_to_cpu(&data[0]);
> +			*max_conn = le16_to_cpu(&data[2]);
> +			return true;
> +		}
> +
> +		eir_data += field_len + 1;
> +	}
> +
> +	return false;
> +}
> +
>  void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>  		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
>  		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
> @@ -7449,6 +7489,7 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>  	char buf[512];
>  	struct mgmt_ev_device_found *ev = (void *)buf;
>  	size_t ev_size;
> +	struct hci_conn *hcon;
>
>  	/* Don't send events for a non-kernel initiated discovery. With
>  	 * LE one exception is if we have pend_le_reports > 0 in which
> @@ -7521,6 +7562,18 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>  	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
>  	ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
>
> +	/* Search for Slave Connection Interval AD */
> +	hcon = hci_conn_hash_lookup_le(hdev, bdaddr, addr_type);
> +	if (hcon) {
> +		u16 min_conn_int, max_conn_int;
> +
> +		if (has_eir_slave_conn_int(ev->eir, ev->eir_len,
> +					   &min_conn_int, &max_conn_int)) {
> +			hcon->le_conn_min_interval = min_conn_int;
> +			hcon->le_conn_max_interval = max_conn_int;
> +		}
> +	}
> +

It's been some time that I looked at this code, so I could be missing
something, but I got the feeling that this part would make more sense if
it was at process_adv_report(), there's even the check for a pending
connection, so no need to redo that here.

Apart from this, the series looks good.


>  	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
>  }
>
> --
> 2.12.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
--
Vinicius
