Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018D72905;
	Thu, 14 Nov 2024 06:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731565089; cv=none; b=aGSMqw7DoW7EBsNnciGP4nJGU8B2eS3UF+Erzx6xFMRXePH0xBzLnV3arXTqQXV3R5H+MSkHJdXT5Q/PpZpR+ulA0qoygRhSSRe4tbDZbwq9gDMiw2qCXvthP5VRbm8TxyXgogMStVvoisFkVXY7JeBjAZHZP03S+qdqyVLMDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731565089; c=relaxed/simple;
	bh=sHJlo2FLFsJ7Uji8r7aDxn9YA49sJdhvgojiFNtwKzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eZUPhjsWcv72z0LkX1gnQbN6bh0OwXXB1f6flHyFRrtX80pA8/SnI/o7twrfjTqdHYBgDhe6sZkEZ44/eX+A1prSD23dZ7O6pD73nM35EPbtjn4ChjmO/HTs6pJyaRTaWeDMr6gQJEU3i8WCYXPmnW6jztNcksSALD1H3CozOwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UQ8V8tr2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UQ8V8tr2"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADH1YZc026934;
	Thu, 14 Nov 2024 06:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xV7SX88N/8wgOJjZeZMVo7UIpnrhyzDZOFnZkeq+pEE=; b=UQ8V8tr2RiRv6G5w
	OFXu57nJ9ZvTcFJINliCKc0wKBYjlfb2BimA29i6xLaf0A24kkKVD1OyNIHomSch
	B5k8QEPA/UoVeGky3GzY3lL9N5yt+4E0lFK4OcW5kR1sRZlCMzS1tqAIYgaEZt8F
	MPxnbELDDQS3l8z70ZR1CCQCqIhxiA/HV4rbVa65nI8/ic5tjxpZ2MIzfv2m56rx
	2L2aa5Bw5smEdVWU7wEX9S9XxafCmBmgWDC9O0IeDK7419s1XJF3nUURc4EZWLWK
	POpuHBk7xMVkcX7jO0srNv03gHCimmemxYxJolciEfVj/aWopph2LnU3PXPW7TRq
	FYl0Xw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vt732vus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 06:18:01 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AE6I04d007750
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 06:18:00 GMT
Received: from [10.253.78.176] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 13 Nov
 2024 22:17:58 -0800
Message-ID: <8500baf7-59e4-4d8c-8485-3ef7aa106f16@quicinc.com>
Date: Thu, 14 Nov 2024 14:17:55 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] bluetooth: qca: generate nvm fw name from boardid for
 WCN6855
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Steev
 Klimaszewski" <steev@kali.org>,
        Bjorn Andersson <bjorande@quicinc.com>
References: <20241003-bt-nvm-firmware-v1-1-79028931214f@oldschoolsolutions.biz>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <20241003-bt-nvm-firmware-v1-1-79028931214f@oldschoolsolutions.biz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NC8lWdsXQcbDH1lmY5dfyrEcyaJscxGQ
X-Proofpoint-GUID: NC8lWdsXQcbDH1lmY5dfyrEcyaJscxGQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 clxscore=1011 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140045

On 10/4/2024 3:21 AM, Jens Glathe wrote:
> From: Steev Klimaszewski <steev@kali.org>
> 
> This is based on the 2066 work, which the 6855 is basically the same
> thing.
> 
> The already existing function qca_generate_hsp_nvm_name() appears to do
> the right steps to generate the hpnv file name. For WCN6855, the suffix
> seems to be the board id with prefix b, though.
> 
> Add specific masking for boardid to generate the full name.
> 
> boardid == 0 -> use 0 as parameter
> boardid <  0x100 -> add 0x0b00 to it, otherwise add 0xb000
> 
> This generates correct hpnv* file names for the files on the Windows
> partition that appear to work better with the hardware than the default
> .bin.
> Tested on Lenovo Thinkpad X13s, Microsoft WDK2023, and HP Omnibook X14.
> 
> The specific firmware is found on the Windows partition, and is supposed
> to work a little bit better than the default .bin.
> 
> Co-authored-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Signed-off-by: Steev Klimaszewski <steev@kali.org>
> ---
> This is based on the 2066 work, which the 6855 is basically the same
> thing.
> 
> It generates the fw name to load from the board id, taking the file
> name format for the WCN6855 into account. The hpnv* firmware files 
> can be found on the Windows partition ofthe device. They usually 
> work better with the specific hardware. If the file is not found it 
> retries with the default name.
> 
> This has been tested on:
> 
> Lenovo Thinkpad X13s
> Microsoft Windows Dev Kit 2023 (Blackrock)
> HP Omnibook X14
> ---
>  drivers/bluetooth/btqca.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index dfbbac92242a8..ffc75680b322b 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -564,6 +564,21 @@ static int qca_download_firmware(struct hci_dev *hdev,
>  					   config->fwname, ret);
>  				return ret;
>  			}
> +			/* For WCN6855, if Windows firmware file isn't in place
> +			 * then use the default .bin file.
> +			 */
> +		} else if (soc_type == QCA_WCN6855) {
> +			bt_dev_dbg(hdev, "QCA Failed to request file: %s (%d)",
> +				   config->fwname, ret);
> +			snprintf(config->fwname, sizeof(config->fwname),
> +				 "qca/hpnv%02x.bin", rom_ver);
> +			bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
> +			ret = request_firmware(&fw, config->fwname, &hdev->dev);
> +			if (ret) {
> +				bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
> +					   config->fwname, ret);
> +				return ret;
> +			}

NO

1)
qca_download_firmware() is  also called to download *PATCH* hpbtfw*, if
downloading PATCH failed, your logic will wrongly download *NVM* hpnv*
instead, right ?

2)
if board ID  is available, must use board id specific NVM, must not
fallback to the default NVM is not for QCA_WCN6855.

>  		} else {
>  			bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
>  				   config->fwname, ret);
> @@ -773,6 +788,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  			 "qca/apbtfw%02x.tlv", rom_ver);
>  		break;
>  	case QCA_QCA2066:
> +	case QCA_WCN6855:
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/hpbtfw%02x.tlv", rom_ver);

>  		break;
> @@ -788,10 +804,6 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/msbtfw%02x.mbn", rom_ver);
>  		break;
> -	case QCA_WCN6855:
> -		snprintf(config.fwname, sizeof(config.fwname),
> -			 "qca/hpbtfw%02x.tlv", rom_ver);
> -		break;
>  	case QCA_WCN7850:
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/hmtbtfw%02x.tlv", rom_ver);
> @@ -810,7 +822,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	/* Give the controller some time to get ready to receive the NVM */
>  	msleep(10);
>  
> -	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850)
> +	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850 || soc_type == QCA_WCN6855)
>  		qca_read_fw_board_id(hdev, &boardid);

a switch since SOC types will become more and more
>  
>  	/* Download NVM configuration */
> @@ -848,8 +860,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  				 "qca/msnv%02x.bin", rom_ver);
>  			break;
>  		case QCA_WCN6855:
> -			snprintf(config.fwname, sizeof(config.fwname),
> -				 "qca/hpnv%02x.bin", rom_ver);
> +			qca_generate_hsp_nvm_name(config.fwname,
> +				sizeof(config.fwname), ver, rom_ver,
> +				boardid == 0 ? boardid : (boardid < 0x0100 ?
> +				(boardid & 0x00ff)|0x0b00 : (boardid & 0x0fff)|0xb000));
>  			break;

why not to refer to existing qca_get_nvm_name_generic().

i will post a patch and cc you.

>  		case QCA_WCN7850:
>  			qca_get_nvm_name_generic(&config, "hmt", rom_ver, boardid);
> 
> ---
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> change-id: 20241003-bt-nvm-firmware-47e4d1b70a99
> 
> Best regards,

