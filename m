Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263423A380B;
	Fri, 10 Apr 2026 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806183; cv=none; b=jJj4MmCY2Baa0X93KJTRKz5tukf74gEpINulM+QuxcE2MfCOOsCc5GlXbzEZNSQP9XGroPO4ALzRcDRkRs24wK6YSLL6WDhrr5nvlepYYjcUwwdv0GvlVpYBIIgFmYoG5ovWNOZF66ev4N4QQn1mkGMRxSsNPLo8wVYv8daGR1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806183; c=relaxed/simple;
	bh=zp3YGffDETulEjT9/ic2BPpWCGOFzqF0slwqPHmlL2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyIW2Of2IXUhiywrsxGC+wvh0bpkvhEqO5Guhi20Ove30VwrtnrqKoQnyI/rAPmLFC7AxnDqKoBr2WOQ8t96L+VTdc/priHBGgiSFYjV5bohuOihcPbpG0h+beWejpOnjdQtpxuDQyqgm9ClW7sRcxRPf3UcaSKAWL/YSCCaY3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af789.dynamic.kabel-deutschland.de [95.90.247.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 45A014C2C37D55;
	Fri, 10 Apr 2026 09:29:33 +0200 (CEST)
Message-ID: <82e1f358-f5ae-4ad8-9069-2c46996abeca@molgen.mpg.de>
Date: Fri, 10 Apr 2026 09:29:32 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: l2cap: defer conn param update to avoid
 conn->lock/hdev->lock inversion
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260410063001.94728-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260410063001.94728-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Mikhail,


Thank you for the improved version. (Just a note, that there are two 
spaces in the summary after *to avoid*. No need to resend.)

Am 10.04.26 um 08:30 schrieb Mikhail Gavrilov:
> When a BLE peripheral sends an L2CAP Connection Parameter Update Request
> the processing path is:
> 
>    process_pending_rx()          [takes conn->lock]
>      l2cap_le_sig_channel()
>        l2cap_conn_param_update_req()
>          hci_le_conn_update()    [takes hdev->lock]
> 
> Meanwhile other code paths take the locks in the opposite order:
> 
>    l2cap_chan_connect()          [takes hdev->lock]
>      ...
>        mutex_lock(&conn->lock)
> 
>    l2cap_conn_ready()            [hdev->lock via hci_cb_list_lock]
>      ...
>        mutex_lock(&conn->lock)
> 
> This is a classic AB/BA deadlock which lockdep reports as a circular
> locking dependency when connecting a BLE MIDI keyboard (Carry-On FC-49).

No need to resend, but out of curiosity, is the result, that the device 
does not work?

> Fix this by introducing l2cap_conn_param_update_sync() which is scheduled
> via hci_cmd_sync_queue() to run on the hci_cmd_sync workqueue, outside
> any of the involved locks.  The necessary connection parameters are
> captured into a heap-allocated struct conn_param_update_data and the
> sync callback performs the hci_conn_params update, sends the HCI LE
> Connection Update command, and notifies mgmt of the new parameters.
> 
> To guard against a theoretical handle-reuse race (the connection could
> drop and its handle be reassigned between queuing and execution), the
> sync callback verifies the connection still exists and its destination
> address matches the original request before proceeding.
> 
> The allocation is performed before sending the L2CAP_CONN_PARAM_ACCEPTED
> response so that on OOM the peer receives a REJECTED response instead of
> an inconsistent state where the peer applies new parameters but the local
> controller does not.
> 
> Fixes: f044eb0524a0 ("Bluetooth: Store latency and supervision timeout in connection params")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
> 
> Changes in v2 (Paul Menzel, Sashiko/Gemini AI review):
> - Allocate before sending ACCEPTED response to avoid state mismatch on OOM
> - Verify connection handle and address in sync callback against reuse race
> - Expand commit message with implementation details
> 
>   net/bluetooth/l2cap_core.c | 93 ++++++++++++++++++++++++++++++++++----
>   1 file changed, 85 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 95c65fece39b..94dfef9df498 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4670,6 +4670,70 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn,
>   	return 0;
>   }
>   
> +struct conn_param_update_data {
> +	u16	handle;
> +	bdaddr_t dst;
> +	u8	dst_type;
> +	u16	min;
> +	u16	max;
> +	u16	latency;
> +	u16	to_multiplier;
> +};
> +
> +static int l2cap_conn_param_update_sync(struct hci_dev *hdev, void *data)
> +{
> +	struct conn_param_update_data *d = data;
> +	struct hci_conn *conn;
> +	struct hci_conn_params *params;
> +	struct hci_cp_le_conn_update cp;
> +	u8 store_hint = 0x00;
> +
> +	/* Verify the connection is still alive and matches the original
> +	 * request, since the handle could theoretically be reused after
> +	 * a disconnect/reconnect cycle.
> +	 */
> +	hci_dev_lock(hdev);
> +
> +	conn = hci_conn_hash_lookup_handle(hdev, d->handle);
> +	if (!conn || bacmp(&conn->dst, &d->dst)) {
> +		hci_dev_unlock(hdev);
> +		return 0;
> +	}
> +
> +	params = hci_conn_params_lookup(hdev, &d->dst, d->dst_type);
> +	if (params) {
> +		params->conn_min_interval = d->min;
> +		params->conn_max_interval = d->max;
> +		params->conn_latency = d->latency;
> +		params->supervision_timeout = d->to_multiplier;
> +		store_hint = 0x01;
> +	}
> +
> +	hci_dev_unlock(hdev);
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.handle		= cpu_to_le16(d->handle);
> +	cp.conn_interval_min	= cpu_to_le16(d->min);
> +	cp.conn_interval_max	= cpu_to_le16(d->max);
> +	cp.conn_latency		= cpu_to_le16(d->latency);
> +	cp.supervision_timeout	= cpu_to_le16(d->to_multiplier);
> +	cp.min_ce_len		= cpu_to_le16(0x0000);
> +	cp.max_ce_len		= cpu_to_le16(0x0000);
> +
> +	hci_send_cmd(hdev, HCI_OP_LE_CONN_UPDATE, sizeof(cp), &cp);
> +
> +	mgmt_new_conn_param(hdev, &d->dst, d->dst_type, store_hint,
> +			    d->min, d->max, d->latency, d->to_multiplier);
> +
> +	return 0;
> +}
> +
> +static void l2cap_conn_param_update_destroy(struct hci_dev *hdev, void *data,
> +					    int err)
> +{
> +	kfree(data);
> +}
> +
>   static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
>   					      struct l2cap_cmd_hdr *cmd,
>   					      u16 cmd_len, u8 *data)
> @@ -4677,6 +4741,7 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
>   	struct hci_conn *hcon = conn->hcon;
>   	struct l2cap_conn_param_update_req *req;
>   	struct l2cap_conn_param_update_rsp rsp;
> +	struct conn_param_update_data *d;
>   	u16 min, max, latency, to_multiplier;
>   	int err;
>   
> @@ -4703,18 +4768,30 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
>   	else
>   		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_ACCEPTED);
>   
> +	if (!err) {
> +		d = kmalloc(sizeof(*d), GFP_KERNEL);
> +		if (!d) {
> +			rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
> +			err = -ENOMEM;
> +		}
> +	}
> +
>   	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONN_PARAM_UPDATE_RSP,
>   		       sizeof(rsp), &rsp);
>   
>   	if (!err) {
> -		u8 store_hint;
> -
> -		store_hint = hci_le_conn_update(hcon, min, max, latency,
> -						to_multiplier);
> -		mgmt_new_conn_param(hcon->hdev, &hcon->dst, hcon->dst_type,
> -				    store_hint, min, max, latency,
> -				    to_multiplier);
> -
> +		d->handle = hcon->handle;
> +		bacpy(&d->dst, &hcon->dst);
> +		d->dst_type = hcon->dst_type;
> +		d->min = min;
> +		d->max = max;
> +		d->latency = latency;
> +		d->to_multiplier = to_multiplier;
> +
> +		if (hci_cmd_sync_queue(hcon->hdev,
> +				       l2cap_conn_param_update_sync, d,
> +				       l2cap_conn_param_update_destroy) < 0)
> +			kfree(d);
>   	}
>   
>   	return 0;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
