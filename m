Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A626A18A6D4;
	Fri, 15 Nov 2024 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731652834; cv=none; b=iXpG8zQO+v2LV8yL6DemkbfsINa8gis4EWw9zlFupNF7UmqBFFeFivypYue9cgX/mAaZbhzD4F0hA6PBqDsYxG5U9ux3Esg1W9lUDuRUFbHcBaVOqJcgxhQ8+UO+CF+de3C0C2ptSQ8lADGP/79exratv5So2sHgPNcdInNHHNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731652834; c=relaxed/simple;
	bh=RbL1epgOCMcJWsSwFVWb3i6X6KsJ0DLWG7rlGLapWoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOM8Mha/xn9W5ZNEFXVCm5Q0Ou1UJhF8UMOLRyWMno6Xo/tH/TTnCDbhUk+PQqHhvU+jPFPfR5u3McGP+M2SwdxnaW7m1+Ma4CYHADtGYzbgFfRj9Ar/DCkjWhCI0yDxBW2y76p5p9UgkK6rn+L5JgkEFXesUAaprTcG822Izh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=L7jFc/AT; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="L7jFc/AT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1731652804; x=1732257604;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=RU84HVfLJgvCTtqnHy/8c+ZiPc9ztH45u7G+xHlBOMM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L7jFc/ATWF427fCXUTHLnKtIGfLk+RlAfnru9aN/DMbYsItVC6UyLOEcDOMme+PQ
	 UAqqEYR9tim3N6ftAMxzqwQWdH5yqrRy+uqo/Ub/BGDFzIagNPtwrjC5E70SkY+Nm
	 RPfvAkYNLuM4KKZn2d5yIlVX3j11d+lV4EgCHsAybSNYTt3qk17xDdXxv0gkBVG0k
	 aMAjNIkB78tDoWTgI79jNKxd4NIF2k0b1BKS2qDacp4etfoc/j8bsi03HfB7ZjQ8q
	 fLWKudEpsSpLtMfIZ2/lIe1wHdNwQqE7lLTdqzySI6yvuNM7DTCg8fMrhVG5kj5JO
	 n3KeHi2pGJNYdJHFjQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.0.174] ([84.175.94.57]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MZjQl-1tEm8Z2gr9-00IsfX; Fri, 15 Nov 2024 07:40:04 +0100
Message-ID: <41966d59-063f-4848-9776-399ee348069a@oldschoolsolutions.biz>
Date: Fri, 15 Nov 2024 07:40:03 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: Support downloading board id specific NVM
 for WCN6855
To: Zijun Hu <quic_zijuhu@quicinc.com>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorande@quicinc.com>,
 "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
 Cheng Jiang <quic_chejiang@quicinc.com>, Johan Hovold <johan@kernel.org>,
 Steev Klimaszewski <steev@kali.org>
References: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mtSY/gdP/hTky6JTWjDsTQyDnhLG3IY2r1nME5X4f5HFKT9cmRE
 ypkLrwA76jtTJ3hJgMiiWP/3wImoej3Gg+uGXeGb3JlIgNRESiwPUf80i9c8/tRkQWhSsBd
 iZLGmNhXs7FSRQBHZz4xYCaKejdBb7/2vk30AhwSmGsswYz84ZYpM1p3aCQqrr44na4OSS+
 gvKFX/7asSLGzayJEvjNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1XJSv05HMU0=;kh62fsZOMcw3Qx7HWd+pek2dfxR
 EKhl7RfuEuSsjAFIroLwb8W1M0CItKzc+gA8gKnT5oEQ7dn7+Im5XQJXRsIKHAY46kx7+LJsV
 7WBGszjtrt7L7xVOzYiQY6+zk/naYKdEFiHX7nBGu6BUVpUoVKh4Kl067Kcs2gJwhciArX1oJ
 vdCsTnbNYIA+QCuENDKO8TJaH6Cnb7LPVKDE4f/bQf6wrSWAvKJ1LCxeIztSnGlb7+Lt8th7r
 UYQJZzi2G0mo2pDkrJiGVv8T6fskpeip/RLEB1FEMl/+0ju13D8HNX3JDKlgzR1GC2EUCPP1k
 SqU2obtDJ2etS3miSEcbAQSmpzhFg6IDPi5hPG+5HMaZqKCPFbMKtS0FTE32FPsHxc/Gm8pNR
 hjziCWncWZ0QQKTl35qjX6lN6w2yV34P4l1W3lb79pjIrGH+DY0wP6yWw8zWe5eCQeDYpfohv
 Vr0xPgLL2in/XlPL9QsTqY1zQx2p9gXqlOu95bKkYGek4oUY6TwGDmco6yiIq/xEgADjFfgFF
 gMwe4d1iuoJmhz6xP67iZBTeu1ZLZMU4edO4UOsWXCJgPNeicKYrwRANyIOH+9Pz8thIYnBIM
 jkY/pIFOYFcjU4L66eY4uE6ufKX8wsh/SrpGUYQGplHDDFMmEWeZ6NTe7CsmFvnMzjoKGeAOS
 pdkpA2NMdm9KPqmQAjVECBaD+ANlCO2gSH0WMLXd8VO672oBMB1w0+A8WxxVUtEpM/iIbSc1K
 6e5zLZxqVbH6pS05tORmkB/MtrB812X603vcFqsA/5Mi+LEnJTgRkuPhAUM3+Tkfq6JudA3m8
 lxLD44y5fwaSzpFFbGyJd7TI9ivdfwx0IFsDizH6pNVrrKkf/q3PhC0tkPONhDpvCu

On 14.11.24 07:26, Zijun Hu wrote:
> Download board id specific NVM instead of default for WCN6855 if board
> id is available, and that is required by Lenovo ThinkPad X13s.
>
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
> @@ -717,6 +717,29 @@ static void qca_generate_hsp_nvm_name(char *fwname,=
 size_t max_size,
>   		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant, bi=
d);
>   }
>
> +static void qca_get_hsp_nvm_name_generic(struct qca_fw_config *cfg,
> +					 struct qca_btsoc_version ver,
> +					 u8 rom_ver, u16 bid)
> +{
> +	const char *variant;
> +
> +	/* hsp gf chip */
> +	if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) =3D=3D QCA_HSP_GF_=
SOC_ID)
> +		variant =3D "g";
> +	else
> +		variant =3D "";
> +
> +	if (bid =3D=3D 0x0)
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
> @@ -810,8 +833,15 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t ba=
udrate,
>   	/* Give the controller some time to get ready to receive the NVM */
>   	msleep(10);
>
> -	if (soc_type =3D=3D QCA_QCA2066 || soc_type =3D=3D QCA_WCN7850)
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
>   	config.type =3D TLV_TYPE_NVM;
> @@ -848,8 +878,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t bau=
drate,
>   				 "qca/msnv%02x.bin", rom_ver);
>   			break;
>   		case QCA_WCN6855:
> -			snprintf(config.fwname, sizeof(config.fwname),
> -				 "qca/hpnv%02x.bin", rom_ver);
> +			qca_get_hsp_nvm_name_generic(&config, ver, rom_ver, boardid);
>   			break;
>   		case QCA_WCN7850:
>   			qca_get_nvm_name_generic(&config, "hmt", rom_ver, boardid);
>
> ---
> base-commit: e88b020190bf5bc3e7ce5bd8003fc39b23cc95fe
> change-id: 20241113-x13s_wcn6855_fix-53c573ff7878
>
> Best regards,

Hi Zijun,

I tested his patch on the HP Omnibook X14 and on the Windows Dev Kit
2023, it works well. Thank you!

Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

with best regards

Jens

