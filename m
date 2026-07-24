Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4715D41A91D
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885085; cv=none; b=jLGn4KLHh6KP4nI1cuRQIfnsk/zbNPHecwSJl5B90yR+Abz++EpLr6Zz0ylfimOXaph4dGDKfQS+/9wOg5MF6AuTReDi4w+ZFiLU0KMqssE04wOg3Gskh9nWZ1dlpDvkO65NNJJDu10cLDKT43iVPDuMI+hSio7FEAcVloOFyl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885085; c=relaxed/simple;
	bh=MRF/D1nCaIS64JEiWMG1w+tIkN/s3ofdLqt4Hk+ctqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aet3p33szKgMau7DQbsuCv0ouwk1snKFisvKhKXQOUjTsD+CUmxQr2raXtduDOakWeCJjT8iiAsHL4aaU75b+1uF26KAQrHTnp0EZQrylSJCCTdiJMIjAdvGHWd86NKK66ubjBYDQp/dKbghiURWuQ7d9V9xYEhOJBhUKlFIYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 390CB4C2C37F0B;
	Fri, 24 Jul 2026 11:23:29 +0200 (CEST)
Message-ID: <a5980d04-4d39-4d3d-bbc8-738abd394fd6@molgen.mpg.de>
Date: Fri, 24 Jul 2026 11:23:26 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: hci_event: Add
 HCI_Write_Link_Supervision_Timeout command/event structures
To: Chen Zhang <zhangchen200426@163.com>
Cc: luiz.von.dentz@intel.com, yang.li@amlogic.com, tim.bird@sony.com,
 naga.akella@oss.qualcomm.com, gustavoars@kernel.org, pav@iki.fi,
 zhangchen01@kylinos.cn, linux-bluetooth@vger.kernel.org
References: <20260724085406.1884991-1-zhangchen200426@163.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260724085406.1884991-1-zhangchen200426@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chen,


Thank you for your patch.

Am 24.07.26 um 10:54 schrieb zhangchen200426@163.com:
> From: Chen Zhang <zhangchen01@kylinos.cn>
> 
> Some speakers do not actively initiate disconnection when power off. As

… powering …

> a result, the center can only wait for a timeout to disconnect, with the

What does “the center” refer to?

> default timeout being 20s. In certain scenarios, this can significantly
> impact user experience. For example, if a speaker is playing music and
> is then turned off, it takes 20s before the music starts playing from
> the center.
> 
> Define HCI_Write_Link_Supervision_Timeout command, event structure, and
> corresponding event handler function, set the timeout to 5s after ACL
> link is established.

Why five seconds and not less? How do Chromium OS or Android do it?

Please also document one test setup up, where you could reproduce it.

> Signed-off-by: Chen Zhang <zhangchen01@kylinos.cn>
> ---
>   include/net/bluetooth/hci.h      | 10 +++++++
>   include/net/bluetooth/hci_core.h |  1 +
>   net/bluetooth/hci_event.c        | 50 ++++++++++++++++++++++++++++++++
>   3 files changed, 61 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 50f0eef71fb1..18a5a17eb218 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1239,6 +1239,16 @@ struct hci_cp_host_buffer_size {
>   	__le16   sco_max_pkt;
>   } __packed;
>   
> +#define HCI_OP_WRITE_LINK_SUPERVISION_TIMEOUT	0x0c37
> +struct hci_cp_write_link_supervision_timeout {
> +	__le16	 handle;
> +	__le16	 timeout;

How about appending the unit for the timeout: timeout_s.

> +} __packed;
> +struct hci_rp_write_link_supervision_timeout {
> +	__u8	 status;
> +	__le16	 handle;
> +} __packed;
> +
>   #define HCI_OP_READ_NUM_SUPPORTED_IAC	0x0c38
>   struct hci_rp_read_num_supported_iac {
>   	__u8	status;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e7133ff87fbf..866903a9b5c8 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -702,6 +702,7 @@ struct hci_conn {
>   	__u8		le_features[248];
>   	__u16		pkt_type;
>   	__u16		link_policy;
> +	__u16		link_supervision_timeout;

Ditto.

>   	__u8		key_type;
>   	__u8		auth_type;
>   	__u8		sec_level;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 741d658e9630..653184d0dfc7 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -606,6 +606,44 @@ static u8 hci_cc_write_voice_setting(struct hci_dev *hdev, void *data,
>   	return rp->status;
>   }
>   
> +static u8 hci_cc_write_link_supervision_timeout(struct hci_dev *hdev, void *data,
> +						struct sk_buff *skb)
> +{
> +	struct hci_ev_status *rp = data;
> +	struct hci_cp_write_link_supervision_timeout *sent;
> +	struct hci_conn *conn;
> +	u16 handle;
> +	u8 status = rp->status;
> +
> +	bt_dev_dbg(hdev, "status 0x%2.2x", status);
> +
> +	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_LINK_SUPERVISION_TIMEOUT);
> +	if (!sent)
> +		return status;
> +
> +	handle = le16_to_cpu(sent->handle);
> +
> +	hci_dev_lock(hdev);
> +
> +	conn = hci_conn_hash_lookup_handle(hdev, handle);
> +	if (!conn) {
> +		status = 0xFF;
> +		goto done;
> +	}
> +
> +	if (!status) {
> +		conn->link_supervision_timeout = __le16_to_cpu(sent->timeout);
> +		bt_dev_dbg(hdev, "handle 0x%4.4x timeout set to 0x%4.4x (%u ms)",
> +			   handle, conn->link_supervision_timeout,
> +			   conn->link_supervision_timeout * 5 / 8);
> +	}
> +
> +done:
> +	hci_dev_unlock(hdev);
> +
> +	return status;
> +}
> +
>   static u8 hci_cc_read_num_supported_iac(struct hci_dev *hdev, void *data,
>   					struct sk_buff *skb)
>   {
> @@ -3240,6 +3278,16 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
>   			hci_send_cmd(hdev, HCI_OP_CHANGE_CONN_PTYPE, sizeof(cp),
>   				     &cp);
>   		}
> +
> +		if (conn->type == ACL_LINK && conn->role == HCI_ROLE_MASTER) {
> +			struct hci_cp_write_link_supervision_timeout cp;
> +
> +			cp.handle = ev->handle;
> +			cp.timeout = 0x1F40;	/* 8000 * 0.625ms = 5000ms */
> +			hci_send_cmd(hdev, HCI_OP_WRITE_LINK_SUPERVISION_TIMEOUT,
> +				     sizeof(cp), &cp);
> +		}
> +
>   	}
>   
>   	if (conn->type == ACL_LINK)
> @@ -4097,6 +4145,8 @@ static const struct hci_cc {
>   	HCI_CC_STATUS(HCI_OP_WRITE_CLASS_OF_DEV, hci_cc_write_class_of_dev),
>   	HCI_CC(HCI_OP_READ_VOICE_SETTING, hci_cc_read_voice_setting,
>   	       sizeof(struct hci_rp_read_voice_setting)),
> +	HCI_CC(HCI_OP_WRITE_LINK_SUPERVISION_TIMEOUT, hci_cc_write_link_supervision_timeout,
> +	       sizeof(struct hci_rp_write_link_supervision_timeout)),
>   	HCI_CC_STATUS(HCI_OP_WRITE_VOICE_SETTING, hci_cc_write_voice_setting),
>   	HCI_CC(HCI_OP_READ_NUM_SUPPORTED_IAC, hci_cc_read_num_supported_iac,
>   	       sizeof(struct hci_rp_read_num_supported_iac)),


Kind regards,

Paul
