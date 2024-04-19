Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A96171AF
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510262; cv=none; b=Kv4La7RxwUsV09DbO5mFSA6kk7EUWb1cx/UmDIeEetdHcPxiuSQf+pZ2qpi4yiiYTh4WTEpJ8xkSE2k8FXyPFpKzP56WMN12UgdG68p7KO6NFFXWVeYwWYlBP3o72wGUL8DklRtjt3noxTGgWv9v/2pxJSMiQ1qFOhKpcvkHw9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510262; c=relaxed/simple;
	bh=6qtJ/0C1AWfK2BwJCzV7XVonY6XQ/r1KV1Wp5Sfeors=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mQsT6/IGLj5xuw3VaiCz9Yqq8Jce3DbUFJ9Izpw/AIulZF16pNpXLB9NaWzv1EkTLERlZksnltrwkweMtmUuasNinSVZJgDwxXx40Y/fO/jpOm8DyO03ZKf+gUgU6WHJvQGWl2/G1sbfHbEcdxQgS/QTYIno0NsjMjQSFpN8cjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fP7Ul13E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fP7Ul13E"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43J73n7R027265;
	Fri, 19 Apr 2024 07:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=n9lQJzxmmOzXLkAPcLO38XHxanEiN+GlvNly3VeMATQ=; b=fP
	7Ul13E9D7eUR0rd9GFpH5O/Jd1tvb4uH4BaU8DkEnMK+EuZR8yqzsBvz64Vzd2Z2
	+WXMJsCNLgxIYyt8r8QFYf0V8O7sf03X07morOtSX0HYjlA/UaauPDfOym6RYcTu
	h/bgFTQp+lZxXukl2aLB3Qgyk/LRiCgv7opf8yztSRr6iKN2qj/nsVmO8pBWDJt2
	WAYk1uaLjoDARelLwQPuJ15L9FXj5JK3uFOjh3/h9SBAJ5ea07j75G77z+e34JZc
	U3Dc0WFZWMCVmljUFO37c0IwjQ6CH9ICJUGtwklj9q0prpo82KTxVlQZOCnUGmjg
	NizXtWsGgfvrebxSELZg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xkgd70cs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 07:04:15 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43J74FRL013587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 07:04:15 GMT
Received: from [10.253.13.178] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 00:04:13 -0700
Message-ID: <362984a6-7567-4d06-920f-18a6fc8a4908@quicinc.com>
Date: Fri, 19 Apr 2024 15:04:11 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: Support downloading board id specific NVM
 for WCN7850
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>
References: <1713340174-1304-1-git-send-email-quic_zijuhu@quicinc.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <1713340174-1304-1-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lTOtvd84_lgrZ28YU8AQqwGF6Sx7Wlhq
X-Proofpoint-ORIG-GUID: lTOtvd84_lgrZ28YU8AQqwGF6Sx7Wlhq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_04,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404190051

On 4/17/2024 3:49 PM, Zijun Hu wrote:
> Download board id specific NVM instead of default for WCN7850 if board id
> is available.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/bluetooth/btqca.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 19cfc342fc7b..3ff1d3f99d7b 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -629,6 +629,19 @@ static void qca_generate_hsp_nvm_name(char *fwname, size_t max_size,
>  		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant, bid);
>  }
>  
> +static inline void qca_get_nvm_name_generic(struct qca_fw_config *cfg,
> +					    const char *stem, u8 rom_ver, u16 bid)
> +{
> +	if (bid == 0x0)
> +		snprintf(cfg->fwname, sizeof(cfg->fwname), "qca/%snv%02x.bin", stem, rom_ver);
> +	else if (bid & 0xff00)
> +		snprintf(cfg->fwname, sizeof(cfg->fwname),
> +			 "qca/%snv%02x.b%x", stem, rom_ver, bid);
> +	else
> +		snprintf(cfg->fwname, sizeof(cfg->fwname),
> +			 "qca/%snv%02x.b%02x", stem, rom_ver, bid);
> +}
> +
>  int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
>  		   const char *firmware_name)
> @@ -709,7 +722,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	/* Give the controller some time to get ready to receive the NVM */
>  	msleep(10);
>  
> -	if (soc_type == QCA_QCA2066)
> +	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850)
>  		qca_read_fw_board_id(hdev, &boardid);
>  
>  	/* Download NVM configuration */
> @@ -751,8 +764,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  				 "qca/hpnv%02x.bin", rom_ver);
>  			break;
>  		case QCA_WCN7850:
> -			snprintf(config.fwname, sizeof(config.fwname),
> -				 "qca/hmtnv%02x.bin", rom_ver);
> +			qca_get_nvm_name_generic(&config, "hmt", rom_ver, boardid);
>  			break;
>  
>  		default:

Hi luiz, marcel,
could you code review for this change since a new product needs this
change ?
