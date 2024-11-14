Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F51D86CB;
	Thu, 14 Nov 2024 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577781; cv=none; b=pHDYpc+ai17APAe00Q8qEb6mihwSKVzmgC7QT/nXFca70IZYRl/uzY4EXJMOupu1fIfHqaFHrUaeI4anS5WNSmW3A6ntL4Z9od79ONDrzlHfG1bukGBcGnEtHjnaiuRbG3X7boawg3Rn+p+eXR1tsV/kkK3E/iFHAY/26hns1mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577781; c=relaxed/simple;
	bh=ay4FsFVDTkCF1UTnaiaMDigRwTDvh81WbxFK1vwsbnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fx7slUfwF0w2stZi8c7b0CNoe6m3LH2LcPF1aTSoP3vuPwI49zHHVQcxgs6V1uw/LyrfHkjiaDCcpuCrpGbMemKzGnueNeb3pjOK0ind3CV+dyc/sZSVIaAXuvy8TQsVmZgOnhITqnn+/Z2/ydBWfHbbdyI75swiWxXSRPB0dig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0250061E5FE05;
	Thu, 14 Nov 2024 10:49:06 +0100 (CET)
Message-ID: <4d973d61-27be-4830-880a-a3d74c4bbbc7@molgen.mpg.de>
Date: Thu, 14 Nov 2024 10:49:05 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: Support downloading board id specific NVM
 for WCN6855
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Zijun Hu
 <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorande@quicinc.com>,
 Aiqun Yu <quic_aiquny@quicinc.com>, Cheng Jiang <quic_chejiang@quicinc.com>,
 Johan Hovold <johan@kernel.org>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 Steev Klimaszewski <steev@kali.org>
References: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Zijun,


Thank you for your patch.

Am 14.11.24 um 07:26 schrieb Zijun Hu:
> Download board id specific NVM instead of default for WCN6855 if board
> id is available, and that is required by Lenovo ThinkPad X13s.

Could you please start by describing the problem/motivation. What does 
not work with the Lenovo ThinkPad X13s before your pacth.

What is variant *g*?

Maybe also describe the file naming convention in the commit message.

> Cc: Bjorn Andersson <bjorande@quicinc.com>
> Cc: Aiqun Yu (Maria) <quic_aiquny@quicinc.com>
> Cc: Cheng Jiang <quic_chejiang@quicinc.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Cc: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>   drivers/bluetooth/btqca.c | 35 ++++++++++++++++++++++++++++++++---
>   1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index dfbbac92242a..4f8576cbbab9 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -717,6 +717,29 @@ static void qca_generate_hsp_nvm_name(char *fwname, size_t max_size,
>   		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant, bid);
>   }
>   
> +static void qca_get_hsp_nvm_name_generic(struct qca_fw_config *cfg,
> +					 struct qca_btsoc_version ver,
> +					 u8 rom_ver, u16 bid)
> +{
> +	const char *variant;
> +
> +	/* hsp gf chip */
> +	if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) == QCA_HSP_GF_SOC_ID)
> +		variant = "g";
> +	else
> +		variant = "";
> +
> +	if (bid == 0x0)
> +		snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/hpnv%02x%s.bin",
> +			 rom_ver, variant);
> +	else if (bid & 0xff00)
> +		snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/hpnv%02x%s.b%x",
> +			 rom_ver, variant, bid);
> +	else
> +		snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/hpnv%02x%s.b%02x",
> +			 rom_ver, variant, bid);
> +}
> +
>   static inline void qca_get_nvm_name_generic(struct qca_fw_config *cfg,
>   					    const char *stem, u8 rom_ver, u16 bid)
>   {
> @@ -810,8 +833,15 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   	/* Give the controller some time to get ready to receive the NVM */
>   	msleep(10);
>   
> -	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850)
> +	switch (soc_type) {
> +	case QCA_QCA2066:
> +	case QCA_WCN6855:
> +	case QCA_WCN7850:
>   		qca_read_fw_board_id(hdev, &boardid);
> +		break;
> +	default:
> +		break;
> +	}
>   
>   	/* Download NVM configuration */
>   	config.type = TLV_TYPE_NVM;
> @@ -848,8 +878,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   				 "qca/msnv%02x.bin", rom_ver);
>   			break;
>   		case QCA_WCN6855:
> -			snprintf(config.fwname, sizeof(config.fwname),
> -				 "qca/hpnv%02x.bin", rom_ver);
> +			qca_get_hsp_nvm_name_generic(&config, ver, rom_ver, boardid);
>   			break;
>   		case QCA_WCN7850:
>   			qca_get_nvm_name_generic(&config, "hmt", rom_ver, boardid);


Kind regards,

Paul
