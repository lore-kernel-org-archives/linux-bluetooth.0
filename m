Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386EC3538B3
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473508; cv=none; b=ZG3DOvpWvJJUtj8rg+83eJv35lWUI6VH0F+0TecX6DrIhQqNzvFF9L+3GPS/sxCM03BJOxcLR9XrA4Rod9d5qaxqM11wbvil01wCKzzc3FIl+8DnjKyqxPKQhM1QC/RbGGBcgDVr9rb/FAVdi5tHFK6mEeYm5onk/BIjiNNFxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473508; c=relaxed/simple;
	bh=aClZuHcSb9Uhnv2j+qNn5O+e/8TzQ6va/JR7DCbHMQA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NrPkWYBxZLlaIdWzD0RrWUl6lRuodqKEnKotEWAHAspDmARqvBrL16841sJuCCLwOMBqk8kVxoanSBjYD5FULIkpFQ/W6QCojgNzLuGL7gRKxv/a+YXlClQJ9miO5x15ZTv6bWh8KH+5G4rGDA+vpjgIqzfkQLhZ+S6wTWxU7Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WZKjXymQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NTOe76Bk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WZKjXymQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NTOe76Bk"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI6dDlB623877
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 13:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	03mXH2egLzCuH4ma2sa+Fb+8aa+ix6ARFLQH5PW+zhw=; b=WZKjXymQpK2hrkE1
	W9FgV6Rfv2AJsNd8h0TmkNeeSeLPbeBJkCiLvyX5CN0Q2Ph1rUOque+/ElSFysdR
	X5CmxFqnwCLjkvaMZaET3rjkWx1c+0bPFU37Jk3T/pMivPEcaCaKTaXYN2BPz7aU
	eYd/fzbt6UGlRJAW618FZ2dj13C322PUfmQzEvG46p0Oiy+I34kge0/sHCA7uAeB
	+IzorHNAaJXR2pPHHwRMfA2B/yrtikAZ+VCx0CxdufYdazKW0Y6dLQBRSeZ8PZpc
	9nCgJJuHNops+PmOaQh2IzdFe/IKK1V8OAUqZf3omiTPuvEhzt9HQVM5CtPoPCiT
	2a5C1Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agahfakuf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 13:45:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3438744f12fso16683257a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 05:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763473505; x=1764078305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=03mXH2egLzCuH4ma2sa+Fb+8aa+ix6ARFLQH5PW+zhw=;
        b=NTOe76BkATuxw1wcupHIJEAJVnnM6li++WV18eBy3qorOcmbtuvDh9VYlYOqZ8zg2c
         HvgM9XbjR+dfdQf9MkhAgDPMxTeXHAb4jlRyWOHwI93qez7Eol7f6JL0EsHqpE535lN3
         3gMXYXgZ1Tdm+E5Re2LQVY2vzFrDXIxN2UYD7M+OJmz2VCK9TMqy51KG8fYNUBVPAtXU
         KZNyNDBLMas8UrE/W1bYRfpiw8KETA/exYIlsHMGGzpwLP3INmCtb0AwNh0S/TpOS563
         YXvJ1e/ZHckP0DkNlHdPTXAFSDzUxJxDdQ7ULOGAybv+ZtlJlG5/iAawD1Jm61bME3Si
         ZBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763473505; x=1764078305;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03mXH2egLzCuH4ma2sa+Fb+8aa+ix6ARFLQH5PW+zhw=;
        b=g90nXgcQn8dDXEewi+X2ceHh/6F+kC7s6PGQJdyr0cfHVz9TS8U7kokLzP3Ekgml8x
         pQQw/0Z1CgL9zww5FP/BvsBFK4+Oc6P+Z7DmrGFCqL8zXIPBx6mx7Xk06w7Uh8YZSbrB
         KN3DVlyQZKkuvWXqtf2wC6WTe9e59amXibJlXQZkWpRpxffkvM/+gyizK5aP4uEpWqhE
         2AM5u1VHT0F7Z6oLZDUDEOUjHX0ziii6utaHjrToR2900i17az3xRDPVQWah1oN7BrpN
         OkBb1RJzClMt5NiURoTTtrjySX6XRUrjN5kSBxYaWTd8kq75H2LU96hjb78VTCFV8LME
         uKJw==
X-Forwarded-Encrypted: i=1; AJvYcCW9MJVihm4wIL7VuIo/tuO96L+HOFt4d/cqH3nol58L3Xz9gmm3QdYoecsY9gxiTxDaghZbZ34QpbbrZ+GiBQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkd7H0w/4gvQBWQ9vYYGNrpT2ZrzJuakKLKb2sl5PTOFTpZaJ8
	LqMxmMV5/y64zVl5MQOldUIU7qHi/0nTxswvH2Fhp4RKpUFI/tJn3M9WPkwWfkrR6glUUjFzWCn
	/g9isJttrugPx2MbKDUtcjjyNUBh44jc0JsKJkd37uZ+VUQkA/ZvyBEDdbviL39MxnofutCE=
X-Gm-Gg: ASbGncu7s7lmivWXVBUYNXCQEPvTidgtNqP/9gD45ZHeSG1uyPegdMKqXUtg9e1Fx5j
	ZLbz0+rVJiBC1NYza3N6eCC0F+8DcS/lz2sY2HqZM129/F2Swn+V24oN0EbeQNp4pJxdGAjGbwL
	fk1jepSwqKfCf2aNHWqiAXE4Cs5e0H8fWMkJRDEh9BICjjKZLp0bxnkPmf7e3K107NRVHqrSYKv
	GDhdGq7paNZC5DG6WjEe0sJIwsLOKXgWXIBMclpvWShLj6WrbxRwZqCLMy02YsMI23WHxKTTyns
	zhUGv2SJZcH8zkt6trDGNVSfwHG3e0Sbifh7k4lKQsiY92QslBpEuxnswNeSWmmpC3Bke/wuc1U
	XzwN1rkQUErJOp5edZvsDwtPhwrZBac+HeZAsTg6JyID2knMWL5MNq0ZjWSlaUM/gdg==
X-Received: by 2002:a17:90b:1dc9:b0:330:84c8:92d0 with SMTP id 98e67ed59e1d1-343fa52bd92mr18759460a91.24.1763473504787;
        Tue, 18 Nov 2025 05:45:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqJn4PqsJV/rc1vAoylUumkDkSJ61qLBRTKe/MRB06FrArotHhlndxnoK/QPxamBdfEmWSrA==
X-Received: by 2002:a17:90b:1dc9:b0:330:84c8:92d0 with SMTP id 98e67ed59e1d1-343fa52bd92mr18759427a91.24.1763473504295;
        Tue, 18 Nov 2025 05:45:04 -0800 (PST)
Received: from [10.110.92.187] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456513d0b4sm13133199a91.5.2025.11.18.05.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 05:45:03 -0800 (PST)
Message-ID: <76edfe9c-1302-4e63-8bcd-ee7dd55a128d@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 21:44:57 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/1] Bluetooth: btqca: Add WCN6855 firmware priority
 selection feature
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com
References: <20251117021645.712753-1-shuai.zhang@oss.qualcomm.com>
 <20251117021645.712753-2-shuai.zhang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251117021645.712753-2-shuai.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDExMCBTYWx0ZWRfX3XerxMQM58b/
 zEMnpiGmer1mYDTO87YpFDBQPZuBGbJf/k7PzYhGmCFy/ZDIb1ZkEz/hJfXZvF/iI8ip17L3OQ7
 0eI9VgE4O9uWPkBfJ6JgSjQZKLr8j2QCk2A7s8xDzZRlplHzdTEYQmrLTpEmVQ3x3RtT/Ss/Gce
 LxyzbJiozqwLfwFBvRqYINpz5HPbehfeTpoTyagDJzzivz/SfamNMKh8HXH0ZZBs97AOlespuq1
 NzEGC9+K5BjOJsu/hD6CH5QE6XZlBzPBL6X2APDgovcnYDwhBFcILeoQ5aQrbbOpN4snNekbnDi
 EWeT8xNsr4DVQDTPVU8dSya9G4rXPzBQTLhB1PqspGy9KrfeWKwibmi1xsZLv2PZl2dyAksN5oZ
 Zpr7cH5wBX1ylv7v15VCQxp4K2OhXA==
X-Authority-Analysis: v=2.4 cv=RpTI7SmK c=1 sm=1 tr=0 ts=691c7861 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=UPmepWTotxaAIdI3lfQA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: mTsvpFZgNBwQeFJ7vGyUvvJBA6Aknrdf
X-Proofpoint-GUID: mTsvpFZgNBwQeFJ7vGyUvvJBA6Aknrdf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180110

Dear

On 11/17/2025 10:16 AM, Shuai Zhang wrote:
> Historically, WCN685x and QCA2066 shared the same firmware files.
> Now, changes are planned for the firmware that will make it incompatible
> with QCA2066, so a new firmware name is required for WCN685x.
>
> Test Steps:
>   - Boot device
>   - Check the BTFW loading status via dmesg
>
> Sanity pass and Test Log:
> QCA Downloading qca/wcnhpbftfw21.tlv
> Direct firmware load for qca/wcnhpbftfw21.tlv failed with error -2
> QCA Downloading qca/hpbftfw21.tlv
>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>   drivers/bluetooth/btqca.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 7c958d606..8e0004ef7 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -847,8 +847,12 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   				 "qca/msbtfw%02x.mbn", rom_ver);
>   			break;
>   		case QCA_WCN6855:
> +			/* Due to historical reasons, WCN685x chip has been using firmware
> +			 * without the "wcn" prefix. The mapping between the chip and its
> +			 * corresponding firmware has now been corrected.
> +			 */
>   			snprintf(config.fwname, sizeof(config.fwname),
> -				 "qca/hpbtfw%02x.tlv", rom_ver);
> +				 "qca/wcnhpbtfw%02x.tlv", rom_ver);
>   			break;
>   		case QCA_WCN7850:
>   			snprintf(config.fwname, sizeof(config.fwname),
> @@ -861,6 +865,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   	}
>   
>   	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> +
> +	if (!rampatch_name && err < 0 && soc_type == QCA_WCN6855) {
> +		snprintf(config.fwname, sizeof(config.fwname),
> +			 "qca/hpbtfw%02x.tlv", rom_ver);
> +		err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> +	}
> +
>   	if (err < 0) {
>   		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
>   		return err;
> @@ -923,7 +934,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   		case QCA_WCN6855:
>   			qca_read_fw_board_id(hdev, &boardid);
>   			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> -						  "hpnv", soc_type, ver, rom_ver, boardid);
> +						  "wcnhpnv", soc_type, ver, rom_ver, boardid);
>   			break;
>   		case QCA_WCN7850:
>   			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> @@ -936,6 +947,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   	}
>   
>   	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> +
> +	if (!firmware_name && err < 0 && soc_type == QCA_WCN6855) {
> +		qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> +					  "hpnv", soc_type, ver, rom_ver, boardid);
> +		err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> +	}
> +
>   	if (err < 0) {
>   		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
>   		return err;

Could you confirm if it has already been accepted?


Kindly,regard

Shuai


