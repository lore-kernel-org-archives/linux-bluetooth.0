Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5FB2459D2
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553691; cv=none; b=uuaBcw6m604ke+3I5/mQyTI8j5DqVtI9Z+9hbUD7tO9sBn4nu4Jes2PwWyOxtQhno3QsFD4eoiG6PDRNQC5hMWUyPgmxvjwRFAHILmb8oZrN9G6J/lqX5SEUWtAf6avReoreFRNSuXLHWhgC2zbGmf3XQRi4ig5smlDw3fbDBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553691; c=relaxed/simple;
	bh=Lh5oB1TogTDhhf6F1woBj5A/GsBEZtmaaMW6fOqoOcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=mgziKgz2hTDvTS8N9KKZrWoI31AMxyLwNsucBRUd2W6zciXdtDDPvebNgUjvCPM5FiB2jwchQcv8egJXCBQskpGmHZNR8tgE7yt71g0fmExEIqERCoWvH3C4HrBYGddNaZmKV4tkpqJDzAgKlwi5EeD06Vcy+x0L2tlpIe0plkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7c7.dynamic.kabel-deutschland.de [95.90.247.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 20EA661E647B3;
	Thu, 07 Aug 2025 10:01:13 +0200 (CEST)
Message-ID: <6072d8b2-e67a-4654-97c7-3a4fe33d64bc@molgen.mpg.de>
Date: Thu, 7 Aug 2025 10:01:12 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Bluetooth: hci_core: Fix using {cis,bis}_capable
 for current settings
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20250806194836.291949-1-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250806194836.291949-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Am 06.08.25 um 21:48 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> {cis,bis}_capable only indicates the controller supports the feature
> since it doesn't check that LE is enabled so it shall not be used for
> current setting, instead this introduces {cis,bis}_enabled macros that
> can be used to indicate that these features are currently enabled.
> 
> Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
> Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
> Fixes: ae7533613133 ("Bluetooth: Check for ISO support in controller")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   include/net/bluetooth/bluetooth.h |  4 ++--
>   include/net/bluetooth/hci_core.h  | 13 ++++++++++++-
>   net/bluetooth/hci_sync.c          |  4 ++--
>   net/bluetooth/iso.c               | 14 +++++++-------
>   net/bluetooth/mgmt.c              | 10 +++++-----
>   5 files changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index ada5b56a4413..e5751f3070b8 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -647,7 +647,7 @@ static inline void sco_exit(void)
>   #if IS_ENABLED(CONFIG_BT_LE)
>   int iso_init(void);
>   int iso_exit(void);
> -bool iso_enabled(void);
> +bool iso_inited(void);
>   #else
>   static inline int iso_init(void)
>   {
> @@ -659,7 +659,7 @@ static inline int iso_exit(void)
>   	return 0;
>   }
>   
> -static inline bool iso_enabled(void)
> +static inline bool iso_inited(void)
>   {
>   	return false;
>   }
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 4dc11c66f7b8..bc29f2e2e16f 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1915,6 +1915,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>   				!hci_dev_test_flag(dev, HCI_RPA_EXPIRED))
>   #define adv_rpa_valid(adv)     (bacmp(&adv->random_addr, BDADDR_ANY) && \
>   				!adv->rpa_expired)
> +#define le_enabled(dev)        (lmp_le_capable(dev) && \
> +				hci_dev_test_flag(dev, HCI_LE_ENABLED))
>   
>   #define scan_1m(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_1M) || \
>   		      ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_1M))
> @@ -1981,14 +1983,23 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>   
>   /* CIS Master/Slave and BIS support */
>   #define iso_capable(dev) (cis_capable(dev) || bis_capable(dev))
> +#define iso_enabled(dev) (le_enabled(dev) && iso_capable(dev))
>   #define cis_capable(dev) \
>   	(cis_central_capable(dev) || cis_peripheral_capable(dev))
> +#define cis_enabled(dev) (le_enabled(dev) && cis_capable(dev))
>   #define cis_central_capable(dev) \
>   	((dev)->le_features[3] & HCI_LE_CIS_CENTRAL)
> +#define cis_central_enabled(dev) \
> +	(le_enabled(dev) && cis_central_capable(dev))
>   #define cis_peripheral_capable(dev) \
>   	((dev)->le_features[3] & HCI_LE_CIS_PERIPHERAL)
> +#define cis_peripheral_enabled(dev) \
> +	(le_enabled(dev) && cis_peripheral_capable(dev))
>   #define bis_capable(dev) ((dev)->le_features[3] & HCI_LE_ISO_BROADCASTER)
> -#define sync_recv_capable(dev) ((dev)->le_features[3] & HCI_LE_ISO_SYNC_RECEIVER)
> +#define bis_enabled(dev) (le_enabled(dev) && bis_capable(dev))
> +#define sync_recv_capable(dev) \
> +	((dev)->le_features[3] & HCI_LE_ISO_SYNC_RECEIVER)
> +#define sync_recv_enabled(dev) (le_enabled(dev) && sync_recv_capable(dev))
>   
>   #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
>   	(!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 387c128f2ba0..aa7d7a8ec3ee 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -4531,14 +4531,14 @@ static int hci_le_set_host_feature_sync(struct hci_dev *hdev)
>   {
>   	struct hci_cp_le_set_host_feature cp;
>   
> -	if (!cis_capable(hdev))
> +	if (!iso_capable(hdev))
>   		return 0;
>   
>   	memset(&cp, 0, sizeof(cp));
>   
>   	/* Connected Isochronous Channels (Host Support) */
>   	cp.bit_number = 32;
> -	cp.bit_value = 1;
> +	cp.bit_value = iso_enabled(hdev) ? 0x01 : 0x00;
>   
>   	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_HOST_FEATURE,
>   				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index eaffd25570e3..5ce823ca3aaf 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2483,11 +2483,11 @@ static const struct net_proto_family iso_sock_family_ops = {
>   	.create	= iso_sock_create,
>   };
>   
> -static bool iso_inited;
> +static bool inited;
>   
> -bool iso_enabled(void)
> +bool iso_inited(void)
>   {
> -	return iso_inited;
> +	return inited;
>   }
>   
>   int iso_init(void)
> @@ -2496,7 +2496,7 @@ int iso_init(void)
>   
>   	BUILD_BUG_ON(sizeof(struct sockaddr_iso) > sizeof(struct sockaddr));
>   
> -	if (iso_inited)
> +	if (inited)
>   		return -EALREADY;
>   
>   	err = proto_register(&iso_proto, 0);
> @@ -2524,7 +2524,7 @@ int iso_init(void)
>   		iso_debugfs = debugfs_create_file("iso", 0444, bt_debugfs,
>   						  NULL, &iso_debugfs_fops);
>   
> -	iso_inited = true;
> +	inited = true;
>   
>   	return 0;
>   
> @@ -2535,7 +2535,7 @@ int iso_init(void)
>   
>   int iso_exit(void)
>   {
> -	if (!iso_inited)
> +	if (!inited)
>   		return -EALREADY;
>   
>   	bt_procfs_cleanup(&init_net, "iso");
> @@ -2549,7 +2549,7 @@ int iso_exit(void)
>   
>   	proto_unregister(&iso_proto);
>   
> -	iso_inited = false;
> +	inited = false;
>   
>   	return 0;
>   }
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 1ce682038b51..c42dffe77daf 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -922,16 +922,16 @@ static u32 get_current_settings(struct hci_dev *hdev)
>   	if (hci_dev_test_flag(hdev, HCI_WIDEBAND_SPEECH_ENABLED))
>   		settings |= MGMT_SETTING_WIDEBAND_SPEECH;
>   
> -	if (cis_central_capable(hdev))
> +	if (cis_central_enabled(hdev))
>   		settings |= MGMT_SETTING_CIS_CENTRAL;
>   
> -	if (cis_peripheral_capable(hdev))
> +	if (cis_peripheral_enabled(hdev))
>   		settings |= MGMT_SETTING_CIS_PERIPHERAL;
>   
> -	if (bis_capable(hdev))
> +	if (bis_enabled(hdev))
>   		settings |= MGMT_SETTING_ISO_BROADCASTER;
>   
> -	if (sync_recv_capable(hdev))
> +	if (sync_recv_enabled(hdev))
>   		settings |= MGMT_SETTING_ISO_SYNC_RECEIVER;
>   
>   	if (ll_privacy_capable(hdev))
> @@ -4513,7 +4513,7 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
>   	}
>   
>   	if (IS_ENABLED(CONFIG_BT_LE)) {
> -		flags = iso_enabled() ? BIT(0) : 0;
> +		flags = iso_inited() ? BIT(0) : 0;
>   		memcpy(rp->features[idx].uuid, iso_socket_uuid, 16);
>   		rp->features[idx].flags = cpu_to_le32(flags);
>   		idx++;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
