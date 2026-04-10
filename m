Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDAF7262F;
	Fri, 10 Apr 2026 05:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775799928; cv=none; b=EmJ+SgYhV/ch2l8F+nU/OeYzlAkJr+XqXtc+ey8iLhf/QwnUwJHjeNL/4DdSEusb4KjGWKRz7le2JpddTl6nKS1SmaA6/fM2XhO5u1VlHjH/qkPz1QSqTiv8JtGcG+OQ+UE8O26RkblMHwE88DRVZC8fDJWdOCVmv4e4xwOVq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775799928; c=relaxed/simple;
	bh=Maf0z3v1JwVf4Oj9qkXfl2Yu53BpYPGLrlDqF5Tvva4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBGYXtrDhsPZAbLNJYyohn0jEwKPGVti9Nsf6X+MHigaFW7+ugdh7v2M+delxlBUcjzx0qbh3NCsrL11Bgm622Nkoy5fkZV36hKrE2RFeOxgUCRDTJauQB3fJvshro/JOAvxjeph7h/WtVHbPv0VS3pZ+re5IHsf7C9abpTT588=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af789.dynamic.kabel-deutschland.de [95.90.247.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5B99B4C1AD77C7;
	Fri, 10 Apr 2026 07:45:11 +0200 (CEST)
Message-ID: <f691b9e4-fb27-4915-ad05-8d309a910f33@molgen.mpg.de>
Date: Fri, 10 Apr 2026 07:45:10 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: l2cap: defer conn param update to avoid
 conn->lock/hdev->lock inversion
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260409222122.21394-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260409222122.21394-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Mikhail,


Thank you for your patch.

Am 10.04.26 um 00:21 schrieb Mikhail Gavrilov:
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

Thank you for the great explanation and documenting the test environment.

> Fix this by deferring the hci_le_conn_update() and mgmt_new_conn_param()
> calls to the hci_cmd_sync workqueue via hci_cmd_sync_queue(), which runs
> outside any of the involved locks.

For me, going into more depth about the implementation, for example 
introducing l2cap_conn_param_update_sync(), would be nice, but I guess 
the experts don’t need it.

> Fixes: f044eb0524a0 ("Bluetooth: Store latency and supervision timeout in connection params")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
>   net/bluetooth/l2cap_core.c | 76 ++++++++++++++++++++++++++++++++++----
>   1 file changed, 69 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 95c65fece39b..e59d3af250ef 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4670,6 +4670,59 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn,
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
> +	struct hci_conn_params *params;
> +	struct hci_cp_le_conn_update cp;
> +	u8 store_hint = 0x00;
> +
> +	hci_dev_lock(hdev);
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
> @@ -4677,6 +4730,7 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
>   	struct hci_conn *hcon = conn->hcon;
>   	struct l2cap_conn_param_update_req *req;
>   	struct l2cap_conn_param_update_rsp rsp;
> +	struct conn_param_update_data *d;
>   	u16 min, max, latency, to_multiplier;
>   	int err;
>   
> @@ -4707,14 +4761,22 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
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
> +		d = kmalloc(sizeof(*d), GFP_KERNEL);
> +		if (!d)
> +			return 0;
>   
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

gemini/gemini-3.1-pro-preview made some comments [1]. At a first glance 
they look valid, but I am no expert.


Kind regards,

Paul


[1]: 
https://sashiko.dev/#/patchset/20260409222122.21394-1-mikhail.v.gavrilov%40gmail.com
