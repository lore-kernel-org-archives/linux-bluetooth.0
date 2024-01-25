Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986C1FB2
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 03:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706151912; cv=none; b=PtRYkkajYOHDHapl79g03zv/fHKOZSkVG8u/CcWfVrZZ4ztmhbCf/E0YxAScKsBuX+raubA1IVVqiKWCgqz4G6Lmyr2gHcKMvCLz6Xv7GG3VIbaEBZpOgy0a2PCQARsuIU2IoWQy8LVYgO1EnjyqyQf24EGlNLKcyQGPWRr/7tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706151912; c=relaxed/simple;
	bh=FYZ2YXoSgcxEgiS4JTJqTskhdLh/HWMVBv6wwA53zLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrYrRPtBu38J0erkINlCuboOM89XB4fsVxYV8qJyBfgwMo3k+BhiIsl7PLqp7Hi42m2WiMhZ7HlIM3q1HeWywfId8W3VSLjGg8v1kLbIVzGgwDeHJSr7RShhLUvfx8LsWMVHXyc3cdi67/HDt316GHPxIsJQ3zComE804a+YO/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=ox0r3ObZ; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="ox0r3ObZ"
Received: from [192.168.0.138] (71-212-26-68.tukw.qwest.net [71.212.26.68])
	by endrift.com (Postfix) with ESMTPSA id DFD30A25D;
	Wed, 24 Jan 2024 19:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1706151901; bh=FYZ2YXoSgcxEgiS4JTJqTskhdLh/HWMVBv6wwA53zLs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ox0r3ObZ6b/b2Y0aVkXksmZ89kaKR3XW09MTUe6qj6/j9R3BIAR5CTimh2xpC4ClM
	 5Lr1DKeOuDQF2LY4ERyw1rEtVrOu2UjTC0E5oqYWZJuMbQMXLpSkX4h2rZ9Sb1dpbn
	 bYCxGOBYm3vqDB6AGDzgELmZiW+O4B9H6L10krT1FG7msyPuGiJPz09f55ViuW+KjW
	 CUXwDA6L1Nc06BmOwvWDUywc4l/Namc1IHfvNJm+15jP2fBTd0kwrxRCTKUcuAigzo
	 aZ1+hrhFcbIB578w6gdyZl3MGY0xkKp+tpfPBKvnMNrLBWAEIJWkKZOUA1fkB9wQnD
	 LZaCoZ6BihaVA==
Message-ID: <94235415-0001-4bba-a27f-519533a4a0ce@endrift.com>
Date: Wed, 24 Jan 2024 19:05:00 -0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 1/9] Enable alternate Bluetooth connection modes
Content-Language: en-US
To: emil.l.velikov@gmail.com, linux-bluetooth@vger.kernel.org
Cc: Rachel Blackman <rachel.blackman@synapse.com>
References: <20240124-disto-patches-v1-0-97e0eb5625a3@gmail.com>
 <20240124-disto-patches-v1-1-97e0eb5625a3@gmail.com>
From: Vicki Pfau <vi@endrift.com>
In-Reply-To: <20240124-disto-patches-v1-1-97e0eb5625a3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Emil,

I didn't write this patch. It was written by Rachel Blackman, and I believe I just rebased it onto our local tree with the expectation that it was just our local tree. It would be better attributed to her, potentially with a Co-Authored-By for me.

Vicki

On 1/24/24 15:43, Emil Velikov via B4 Relay wrote:
> From: Vicki Pfau <vi@endrift.com>
> 
> This patch improves Bluetooth connectivity, especially with multiple
> controllers and while docked.
> 
> Testing:
> $ btmgmt
> [mgmt]# phy
> 
> Verify the SupportedPHYs in main.conf are listed.
> Verify that multiple controllers can connect and work well.
> 
> Co-Authored-By: Rachel Blackman <rachel.blackman@synapse.com>
> 
> [Emil Velikov]
> Remove unused function, add default entries into parser, keep only
> default entries in main.conf - commented out, like the other options.
> ---
>  src/adapter.c | 46 +++++++++++++++++++++++++++++++++++++++++
>  src/btd.h     |  2 ++
>  src/main.c    | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/main.conf |  5 +++++
>  4 files changed, 119 insertions(+)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 022390f0d..4c6b8f40f 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -86,6 +86,18 @@
>  #define DISTANCE_VAL_INVALID	0x7FFF
>  #define PATHLOSS_MAX		137
>  
> +#define LE_PHY_1M 0x01
> +#define LE_PHY_2M 0x02
> +#define LE_PHY_CODED 0x04
> +
> +#define PHYVAL_REQUIRED 0x07ff
> +#define PHYVAL_1M_TX (1<<9)
> +#define PHYVAL_1M_RX (1<<10)
> +#define PHYVAL_2M_TX (1<<11)
> +#define PHYVAL_2M_RX (1<<12)
> +#define PHYVAL_CODED_TX (1<<13)
> +#define PHYVAL_CODED_RX (1<<14)
> +
>  /*
>   * These are known security keys that have been compromised.
>   * If this grows or there are needs to be platform specific, it is
> @@ -847,6 +859,36 @@ static bool set_discoverable(struct btd_adapter *adapter, uint8_t mode,
>  	return false;
>  }
>  
> +static void set_phy_support_complete(uint8_t status, uint16_t length,
> +					const void *param, void *user_data)
> +{
> +	if (status != 0) {
> +		struct btd_adapter *adapter = (struct btd_adapter *)user_data;
> +
> +		btd_error(adapter->dev_id, "PHY setting rejected for %u: %s",
> +								adapter->dev_id, mgmt_errstr(status));
> +	}
> +}
> +
> +static bool set_phy_support(struct btd_adapter *adapter, uint32_t phy_mask)
> +{
> +	struct mgmt_cp_set_phy_confguration cp;
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.selected_phys = cpu_to_le32(phy_mask | PHYVAL_REQUIRED);
> +
> +	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_PHY_CONFIGURATION,
> +				adapter->dev_id, sizeof(cp), &cp,
> +				set_phy_support_complete, (void*)adapter, NULL) > 0)
> +		return true;
> +
> +	btd_error(adapter->dev_id, "Failed to set PHY for index %u",
> +							adapter->dev_id);
> +
> +	return false;
> +
> +}
> +
>  static bool pairable_timeout_handler(gpointer user_data)
>  {
>  	struct btd_adapter *adapter = user_data;
> @@ -10458,6 +10500,10 @@ static void read_info_complete(uint8_t status, uint16_t length,
>  	if (btd_adapter_get_powered(adapter))
>  		adapter_start(adapter);
>  
> +	// Some adapters do not want to accept this before being started/powered.
> +	if (btd_opts.phys > 0)
> +		set_phy_support(adapter, btd_opts.phys);
> +
>  	return;
>  
>  failed:
> diff --git a/src/btd.h b/src/btd.h
> index b7e7ebd61..2b84f7a51 100644
> --- a/src/btd.h
> +++ b/src/btd.h
> @@ -151,6 +151,8 @@ struct btd_opts {
>  	struct btd_advmon_opts	advmon;
>  
>  	struct btd_csis csis;
> +
> +	uint32_t	phys;
>  };
>  
>  extern struct btd_opts btd_opts;
> diff --git a/src/main.c b/src/main.c
> index b1339c230..faedb853c 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -128,6 +128,7 @@ static const char *le_options[] = {
>  	"AdvMonAllowlistScanDuration",
>  	"AdvMonNoFilterScanDuration",
>  	"EnableAdvMonInterleaveScan",
> +	"SupportedPHYs",
>  	NULL
>  };
>  
> @@ -182,10 +183,32 @@ static const struct group_table {
>  	{ }
>  };
>  
> +static const char *conf_phys_str[] = {
> +	"BR1M1SLOT",
> +	"BR1M3SLOT",
> +	"BR1M5SLOT",
> +	"EDR2M1SLOT",
> +	"EDR2M3SLOT",
> +	"EDR2M5SLOT",
> +	"EDR3M1SLOT",
> +	"EDR3M3SLOT",
> +	"EDR3M5SLOT",
> +	"LE1MTX",
> +	"LE1MRX",
> +	"LE2MTX",
> +	"LE2MRX",
> +	"LECODEDTX",
> +	"LECODEDRX",
> +};
> +
>  #ifndef MIN
>  #define MIN(x, y) ((x) < (y) ? (x) : (y))
>  #endif
>  
> +#ifndef NELEM
> +#define NELEM(x) (sizeof(x) / sizeof((x)[0]))
> +#endif
> +
>  static int8_t check_sirk_alpha_numeric(char *str)
>  {
>  	int8_t val = 0;
> @@ -226,6 +249,36 @@ static size_t hex2bin(const char *hexstr, uint8_t *buf, size_t buflen)
>  	return len;
>  }
>  
> +static bool str2phy(const char *phy_str, uint32_t *phy_val)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < NELEM(conf_phys_str); i++) {
> +		if (strcasecmp(conf_phys_str[i], phy_str) == 0) {
> +			*phy_val = (1 << i);
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static void btd_parse_phy_list(char **list)
> +{
> +	uint32_t phys = 0;
> +
> +	for (int i = 0; list[i]; i++) {
> +		uint32_t phy_val;
> +
> +		info("Enabling PHY option: %s", list[i]);
> +
> +		if (str2phy(list[i], &phy_val))
> +			phys |= phy_val;
> +	}
> +
> +	btd_opts.phys = phys;
> +}
> +
>  GKeyFile *btd_get_main_conf(void)
>  {
>  	return main_conf;
> @@ -673,11 +726,24 @@ static void parse_le_config(GKeyFile *config)
>  		  0,
>  		  1},
>  	};
> +	char **strlist;
> +	GError *err = NULL;
>  
>  	if (btd_opts.mode == BT_MODE_BREDR)
>  		return;
>  
>  	parse_mode_config(config, "LE", params, ARRAY_SIZE(params));
> +
> +	strlist = g_key_file_get_string_list(config, "LE", "SupportedPHYs",
> +						NULL, &err);
> +	if (err) {
> +		g_clear_error(&err);
> +		strlist = g_new0(char *, 3);
> +		strlist[0] = g_strdup("LE1MTX");
> +		strlist[1] = g_strdup("LE1MRX");
> +	}
> +	btd_parse_phy_list(strlist);
> +	g_strfreev(strlist);
>  }
>  
>  static bool match_experimental(const void *data, const void *match_data)
> diff --git a/src/main.conf b/src/main.conf
> index 085c81a46..59d31e494 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -231,6 +231,11 @@
>  # Defaults to 1
>  #EnableAdvMonInterleaveScan=
>  
> +# Which Bluetooth LE PHYs should be enabled/supported?
> +# Options are LE1MTX LE1MRX LE2MTX LE2MRX LECODEDTX LECODEDRX
> +# Defaults to LE1MTX,LE1MRX
> +#SupportedPHYs=LE1MTX,LE1MRX
> +
>  [GATT]
>  # GATT attribute cache.
>  # Possible values:
> 
