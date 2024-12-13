Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AD917D2
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 00:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734049047; cv=none; b=A7XZfswmtap94xAtXmifXshGOB2sDFMlsKnK7IXSnMn9drn0P3aHdAIPxnndGwKdAtkOuOd+ykpVKvhLvUWUeWpx7MIZ/cJv/mMCqKN665vxIP60PWCKoDuiHGUfXnPJLzwDxgGJj5U9hLzLZhDil+ACvWTk+6nFY3BvwU3gDSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734049047; c=relaxed/simple;
	bh=SrxXmCH+v0QxUaizKqemgaUdx3DE/X8P/ujBSccAkV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucsSwOft63aGHecW9uYX+xdz6FeBJIXPRhW1rrQi0XZmBgwsbJcfF8ilyH5Pr3idGn+ffm4to2JC5ZdUcPy7bmQ1bjMzP6GGr531+QwkwjvFMaO5Yg1pS4+WmUiepTmnNz9DO8D+bd5KgnG1JnlHaqHql5ouGpnhhzoh81u53u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MBImFEvZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MBImFEvZ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCD1Rh9000455
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 00:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A4FGY2FCz++6gIonHBSqZEO3eSKMy5sJo/16rWS0kSQ=; b=MBImFEvZtmLProm4
	OYThpJRoeKbkyK2xi1YKZmm0thirllahSn9ryJLfelTeXpU8YKD0YZ/rPgzjVd4F
	B/AV8oI1+y5w4xe5Rrj/vTPyVZqXHEkmQQIZVyFsX3r3Lw8GcmoNuhPnK7MwZazl
	Nj5OVCzcwrn2Tf/FH1jrYA6lpQ3x7f9noqN+kze5tL4D2hCv7gw1JiFGoUsVHZBO
	OJ8EcHncSEpVu01sa5MszL6pINryHrsZAr2HiIn/SS46Nq9ndUsmIiuptboE1QO1
	ASNY/EoTtjehdw7471/w6+zEJvQlW5nljaeIEJXubjwGKY9fE/iZdzkvL9BBGLap
	JI5lOQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fqes32jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 00:17:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6f134dac1so12879185a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 16:17:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734049043; x=1734653843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A4FGY2FCz++6gIonHBSqZEO3eSKMy5sJo/16rWS0kSQ=;
        b=HTUT10Rl8T7/5cQYPs+6FNdRTWs0TCLWvHIsIftU0/UdwxPS6y4EgU8b+Q7o5Fqx3P
         moIiYIQ40/kBuojUQbEe9TqolJM31AvMrQfpv/u2M9+zTTvgMKwxaxnGJOlrib0SdEkb
         3Gv5AD9ZN2u2jm1Hh8gLCltAdJvZdv6E0Xsw+viQmYRrVvnzqR5phONnBOFJHfz0a2Bb
         eWFGthNth7SYQXwZa8cjzz1icWcVcdicurMm+AiNN0i+rdMkzsT+DslDpvuAS1XVqcUH
         IITCRWGO4mjIuqlnspZObEObD9/T1bg+qj95FvFOuoNgs1OxnmT56KmuPelHnNu10chA
         OxpA==
X-Gm-Message-State: AOJu0Yykcf8XLGFvFxYSX0EggcbZKraEIi2SkBMl9esSaJtD1xyNwiuM
	TuMh9x4oSeuXZQcf8FmGcgnC9y0LIJPrX0740fnQwZYDvHS1Lrydz0KFJHQkVer/P3COG+LFeyD
	tRvCWo9bZNgqlXaZ381sXHGqxqtPCKA892UXGpn23NYN8Dmb75U/Bcecl8mK6hzAUPpM=
X-Gm-Gg: ASbGnctpHS4hnSpHMqu2vnXbJCZni7KE7o1W6lIOwUiGuLjXDGKSRn0sS69SqPNmpFk
	7TlEuuj0xoiYireUp48nWIy892qvGV/DoCIsXCvMvPgP6odBhSBJH2z/yQyfL+Jdu4X4L6Fs5on
	hndICcSc2WSxpwSBOET22o0eLwWPRphPKALM63ksiZFLnYLvHXBPtZe+BJ/ZU1Pj7qTDvq+ik+2
	CHQ0GhZkzPF+OkHj8WxJxKp17jAVWs7LEzVHl6kigT4dLhPv80cdCHgzFa3lRHkRMl8ef+m8u/a
	3XhAk9GjFKsHTfYt09vGBhi0NFSyKlRvQfIr
X-Received: by 2002:a05:620a:2408:b0:7b6:d252:b4f1 with SMTP id af79cd13be357-7b6fbf331afmr29995085a.11.1734049043559;
        Thu, 12 Dec 2024 16:17:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxY4djN7MarljvVzpS9K6J5/bSMD5GkzCk0jj+nReVZgsL4CH6vk2AmGSFs0ThXyFvJRDjCA==
X-Received: by 2002:a05:620a:2408:b0:7b6:d252:b4f1 with SMTP id af79cd13be357-7b6fbf331afmr29991585a.11.1734049043071;
        Thu, 12 Dec 2024 16:17:23 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6761d0ab3sm749107466b.201.2024.12.12.16.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 16:17:22 -0800 (PST)
Message-ID: <94eae703-ed9e-4f57-9786-99db7aaa07d1@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 01:17:20 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] Bluetooth: qca: Update firmware-name to support
 board specific nvm
To: Cheng Jiang <quic_chejiang@quicinc.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_jiaymao@quicinc.com, quic_shuaz@quicinc.com,
        quic_zijuhu@quicinc.com, quic_mohamull@quicinc.com
References: <20241212150232.3823088-1-quic_chejiang@quicinc.com>
 <20241212150232.3823088-3-quic_chejiang@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241212150232.3823088-3-quic_chejiang@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sUiAYi2n5h9tWX4EhP9oD64A4_rr8oJV
X-Proofpoint-ORIG-GUID: sUiAYi2n5h9tWX4EhP9oD64A4_rr8oJV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130001

On 12.12.2024 4:02 PM, Cheng Jiang wrote:
> Different connectivity boards may be attached to the same platform. For
> example, QCA6698-based boards can support either a two-antenna or
> three-antenna solution, both of which work on the sa8775p-ride platform.
> Due to differences in connectivity boards and variations in RF
> performance from different foundries, different NVM configurations are
> used based on the board ID.
> 
> Therefore, in the firmware-name property, if the NVM file has an
> extension, the NVM file will be used. Otherwise, the system will first
> try the .bNN (board ID) file, and if that fails, it will fall back to
> the .bin file.
> 
> Possible configurations:
> firmware-name = "QCA6698/hpnv21";
> firmware-name = "QCA6698/hpnv21.bin";

I think we should agree on one and then do some magic to look up
the other variants.

> 
> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> ---
>  drivers/bluetooth/btqca.c | 112 ++++++++++++++++++++++++++++----------
>  1 file changed, 84 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index dfbbac922..4842f4335 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -272,6 +272,38 @@ int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
>  }
>  EXPORT_SYMBOL_GPL(qca_send_pre_shutdown_cmd);
>  
> +static bool qca_filename_has_extension(const char *filename)
> +{
> +	const char *suffix;
> +
> +	suffix = strrchr(filename, '.');
> +	if (suffix && suffix != filename && *(suffix + 1) != '\0' && strchr(suffix, '/') == NULL)
> +		return true;
> +	else
> +		return false;

How about:

const char *suffix = strrchr(filename, '.');

/* File extensions require a dot, but not as the last character */
if (!suffix || *(suffix + 1) == NULL)
	return false;

/* Avoid matching directories with names that look like files with extensions */
return !(suffix, '/');


> +		}
> +		/* For nvm, if desired nvm file is not present and it's not the
> +		 * default nvm file(ends with .bin), try to load the default nvm.

nvm appears 4 times in two lines, how about:

/*
 * If the board-specific file is missing, try loading the default
 * one, unless that was attempted already
 */

But, even more importantly:

a) do we want to load the "incorrect" file?
b) why would we want to specify the .bin file if it's the default anyway?

> +		 */
> +		else if (config->type == TLV_TYPE_NVM &&
> +			 qca_get_alt_nvm_file(config->fwname, sizeof(config->fwname))) {
> +			bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
> +			ret = request_firmware(&fw, config->fwname, &hdev->dev);
> +			if (ret) {
> +				bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
> +					   config->fwname, ret);
> +				return ret;
> +			}
>  		} else {
>  			bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
>  				   config->fwname, ret);
> @@ -700,34 +745,38 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
>  	return 0;
>  }
>  
> -static void qca_generate_hsp_nvm_name(char *fwname, size_t max_size,
> +static void qca_get_nvm_name_by_board(char *fwname, size_t max_size,
> +		const char *stem, enum qca_btsoc_type soc_type,
>  		struct qca_btsoc_version ver, u8 rom_ver, u16 bid)
>  {
>  	const char *variant;
> +	const char *prefix;
>  
> -	/* hsp gf chip */
> -	if ((le32_to_cpu(ver.soc_id) & QCA_HSP_GF_SOC_MASK) == QCA_HSP_GF_SOC_ID)
> -		variant = "g";
> -	else
> -		variant = "";
> +	/* Set the defalut value to variant and prefixt */

typos: default, prefix

> +	variant = "";
> +	prefix = "b";
>  
> -	if (bid == 0x0)
> -		snprintf(fwname, max_size, "qca/hpnv%02x%s.bin", rom_ver, variant);
> -	else
> -		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant, bid);
> -}
> +	if (soc_type == QCA_QCA2066)
> +		prefix = "";
>  
> -static inline void qca_get_nvm_name_generic(struct qca_fw_config *cfg,
> -					    const char *stem, u8 rom_ver, u16 bid)
> -{
> -	if (bid == 0x0)
> -		snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/%snv%02x.bin", stem, rom_ver);
> -	else if (bid & 0xff00)
> -		snprintf(cfg->fwname, sizeof(cfg->fwname),
> -			 "qca/%snv%02x.b%x", stem, rom_ver, bid);
> -	else
> -		snprintf(cfg->fwname, sizeof(cfg->fwname),
> -			 "qca/%snv%02x.b%02x", stem, rom_ver, bid);
> +	if (soc_type == QCA_WCN6855 || soc_type == QCA_QCA2066) {
> +		/* hsp gf chip */

This is a good opportunity to explain what that means

Konrad
