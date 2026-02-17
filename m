Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E15A84A35
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771310177; cv=none; b=J9yzJjbmINkp3D2OKGST+cq2ahe+A8MwCY2IGE7HEXc0KuIDfJ3MsRt+n8/TQ6cg7h17JBm4QKq67GrgKvERNWVRedxFZJvfkPHWlesYxM5Cm7wP+ovMTe65M5zNbTERQ/xhmB5f/z36vDXcupkS/TacEc79xQq+n6crYrr8Mck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771310177; c=relaxed/simple;
	bh=scImbhq9CBmxyP+rIejIb3Uc+jNFpVsSyEdbGqgm2qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5RkNVLtbh5C1a62XB6XE2UEQhXkLifdcgzBnFQkN/75kccDUtadzAaX5/tqQHUOFhuD6wqv7BmAGxhzUScmJlJAxx1TxuT15uBlp7kYknkFYO0Tqs3Je5tZddOwn62pSCGst78vQq3nuq4IiU73/DbYUBLYFB1G1IwED1dE4LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M3cT6AhF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K+RSRduh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M3cT6AhF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K+RSRduh"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GH4S2D985268
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 06:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=C0z+ZHCDQpvcslXmWkDoLTPK
	gKfxRG4MGWszpvILlXY=; b=M3cT6AhFx5w0/sTo9lhN32p/xvORPOm8lvcU1pKJ
	pvxcHHd9EXg6+q5SVY0htPy+leQwPmH3I01ct6PJxAXfq0sVfZgC7zOU6BEi7qGe
	orfTEH9SbJCNatqMye60wcgEYtN1ZqBsSugA5YKJmxRhm4Qo9qGiMd362hkS1nSj
	l/p1EpnRyyBfqd4AwmzPMhy0IIEiUFZWNNebVS9FF3Z8a+wNFCUV5b2efrLkXX5S
	Ev7tFR4VKq6llwbgD4bkT2xKq+Bkw4rLnwwBK+KxZpKhWkRZcehuPdXyH0M3gpgv
	xEgAc0wDGHXb/joOXLmXeURv7PQg8B7eddzaqa1UBCqzpw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc7ap19ty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 06:36:14 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8947c4398c4so334973716d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 22:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771310173; x=1771914973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C0z+ZHCDQpvcslXmWkDoLTPKgKfxRG4MGWszpvILlXY=;
        b=K+RSRduhhp3e+TAj/HzxVJP8tLAtwC+2JPZY3qnn8DOtl4dVWwdbcKRi2ajQTR3Sxz
         YzwKMDDzzHkwA0ekqb3kf+guNv2rOIwBFGpUINzqLeqYirLHrCOvi4MQJP7Qh4qk4DJA
         hHKkdMeqajdXyjpnq8r4Ij38MiDcyJCYeUXAO8L9bg8Pc9/mRMTBuFG5/Zo23yHUs4gh
         0iZx7fdPTqsfzR29NIFiEdg9Ubk7JSjthHcs4/f+wmhuKhJiHBr/B0SmV9k38QBgyC0g
         Lgvf4zMiMW6UO9gTN7eVYHwb7JpJ6o0rCEsAjHnE9mlZWQWWy7DKV0rgCSKPOJGhJMl9
         vFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771310173; x=1771914973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0z+ZHCDQpvcslXmWkDoLTPKgKfxRG4MGWszpvILlXY=;
        b=aej2nlAelGqeDEQhaTaC8v3JrxB9YzLlTriak+DR1oN9LdM57j+tpcCAnDbrzybTCh
         OWt3B7DCwvkxEsLIGa4VT7QGn6LZ6E6+2jAaKvVQp7jv6BII9cDZriwRhY0t2+DjXcp0
         zsGaPsoVAEvyN0g7xzO3OWq+uVcyVFtc73UWSO34ytrlJfr35oIt0o1gUgbUSUFRicQp
         a6QCZ3E7TtijQCRp0cwCB1Uy6z1wKQHNiR0KaqLax4yFVaqu0gL+ROPR4IY2XcU7QouO
         dPcswckPh7NJ6rmfVaLwSc/0Jivg/2UqGkDSbYyZryOyAha8rSs51FcZW03Fh+e1QA8m
         qGyA==
X-Forwarded-Encrypted: i=1; AJvYcCW9MGGdztJkJwz23wWXmzvJGPMqhSHI41/UCpRBkcPsaJxGZIgzTVkY79pKucZVNlsbKlYw8n1FVCijedifMME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL/criF4uJ0j09OlRBqP61tL3qg1wAl/H4b27KL1x1rDwfbKsy
	WzBseW4qHyixSxS511g0X6Eufj1wL33TZJCJ46oWxjN0akyNTQ1YTNw9v5+ISvnsrsWkGRDVstA
	cP5wKm2zC23aBbQAE4OQkkQmf4gSRVjffwIhOvmky48pYFqJ4hCafI5pMc2Zi7I2Uk0ktJzQ=
X-Gm-Gg: AZuq6aJTcvzXSKvHhCl89iipN6C8sZ7piWi5Zkn6fylYn9VwxubAe31Np4kkRUxGdit
	DztdWQD0AbmCAcMNzl13/74NHEgNTFByoSf8hann0EA4iF2VH7y8Va1lm7IuIuW0VaeUbDS+2h+
	LU7LSH42klm8xjLY606lWDxYuj+w0uQAMuCmoKwzK80Nbcu5OmjfDCgiScU3x54QjJCQX1rgcsp
	NAN0pbpHgF4CRiX9u0I7FfIDK1ldJ5Cm6TYT6Cbr4/QcFZxPybcEnB+xCWyiV2JWI1mEYQi3ViW
	vJXinDf0Y5zbtVrzHVQCta0WkQR2w4lhWbQNEPY9jLy8iuKUTaRZ+60Oc5UDSoUS12QGCJPAwfK
	Qp1Emu0SktkttC1BiTCXeXI26VCZufX9x+eVU56Rbm91UbVZXOct6sDa6c+mEEq/MhiBTIpKahO
	n1aogtVC4lY40kDbEAWnlCrlbNb28jiss5Hdw=
X-Received: by 2002:a05:620a:4689:b0:8cb:4dc4:61d3 with SMTP id af79cd13be357-8cb4dc46c23mr1041158385a.45.1771310173465;
        Mon, 16 Feb 2026 22:36:13 -0800 (PST)
X-Received: by 2002:a05:620a:4689:b0:8cb:4dc4:61d3 with SMTP id af79cd13be357-8cb4dc46c23mr1041155685a.45.1771310172920;
        Mon, 16 Feb 2026 22:36:12 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f56b590sm3656994e87.34.2026.02.16.22.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 22:36:12 -0800 (PST)
Date: Tue, 17 Feb 2026 08:36:09 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, janaki.thota@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Bluetooth: qca: add QCC2072 support
Message-ID: <mt4vrzmq7caqddwtz7nc3tn33zxh7uupoxfmk5pfqobhuex43f@se64qz7qvuh6>
References: <20260217054731.3058567-1-vivek.sahu@oss.qualcomm.com>
 <20260217054731.3058567-3-vivek.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217054731.3058567-3-vivek.sahu@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA1MyBTYWx0ZWRfX7IFxglGftV4I
 F536s9wXrJNWKsYJ31bOyMwgXSgU2dWj2z7Yaoa1ovnvrboy1NKeNbhmJilyKFO3iugxaTKj8+z
 NJso41dpMj4DUuflMBqLgubSkWPzNJcvw5U96+nR+P9/YOsSnP7tz/7+maKflKTqFT9ehj8rZCc
 SDW7S7Ps9iFrszW7j0Hf2EF1AK+AMpJBR0eE+RF5YqW4Rf/DQwnucQlNtrTs8IiLEbbvQeWqCma
 stsVluwd87qV9af/xaOBD3Tj5bI8bgf/yzSRKfa2DzmdfD0PxI1o+e/vCZPv8NsVHSKBotF832d
 iuUE8uwf47IeI5GRQ3J7SVvlK8ZjO188soYrpTXO3YxFy5x9R1XYrmN0uakHRdf7Ndp3Ql8Kt++
 wxs0Gw7T6EdKduNO9YZy2wqT75mK6NpHRbNgOPT8XB8wN2jpr3KkJJM1E7hTSnyKVq63Qm6YGzo
 e8CiJq9ExLlNZAzzzMQ==
X-Proofpoint-ORIG-GUID: M6zUEYvGgkmpvPsED7IkXeqcRKG9ANdQ
X-Proofpoint-GUID: M6zUEYvGgkmpvPsED7IkXeqcRKG9ANdQ
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=69940c5e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=qTpL0HBMRkf-sisulhkA:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170053

On Tue, Feb 17, 2026 at 11:17:31AM +0530, Vivek Sahu wrote:
> QCC2072 is a family of WiFi/BT connectivity chip.
> It requires different firmware files and has different
> configurations , so add it as a separate SoC type.
> 
> The firmware for these chips has been recently added to the
> linux-firmware repository and will be a part of the upcoming
> release.
> 
> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c   |  8 ++++++++
>  drivers/bluetooth/btqca.h   |  1 +
>  drivers/bluetooth/hci_qca.c | 18 ++++++++++++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 9f7e13fcb20e..65c8d2978956 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -807,6 +807,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  			snprintf(config.fwname, sizeof(config.fwname),
>  				 "qca/htbtfw%02x.tlv", rom_ver);
>  			break;
> +		case QCA_QCC2072:
> +			snprintf(config.fwname, sizeof(config.fwname),
> +				 "qca/ornbtfw%02x.tlv", rom_ver);
> +			break;
>  		case QCA_WCN3950:
>  			snprintf(config.fwname, sizeof(config.fwname),
>  				 "qca/cmbtfw%02x.tlv", rom_ver);
> @@ -900,6 +904,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  			snprintf(config.fwname, sizeof(config.fwname),
>  				 "qca/htnv%02x.bin", rom_ver);
>  			break;
> +		case QCA_QCC2072:
> +			snprintf(config.fwname, sizeof(config.fwname),
> +				 "qca/ornnv%02x.bin", rom_ver);
> +			break;
>  		case QCA_WCN3950:
>  			if (le32_to_cpu(ver.soc_id) == QCA_WCN3950_SOC_ID_T)
>  				variant = "t";
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 8f3c1b1c77b3..a175ac31e7b2 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -158,6 +158,7 @@ enum qca_btsoc_type {
>  	QCA_WCN6750,
>  	QCA_WCN6855,
>  	QCA_WCN7850,
> +	QCA_QCC2072,

Why not keep it sorted?

>  };
>  
>  #if IS_ENABLED(CONFIG_BT_QCA)
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 8e035b7c6f3e..7786ced0bbbb 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -625,6 +625,7 @@ static int qca_open(struct hci_uart *hu)
>  		qcadev = serdev_device_get_drvdata(hu->serdev);
>  
>  		switch (qcadev->btsoc_type) {
> +		case QCA_QCC2072:
>  		case QCA_WCN3950:
>  		case QCA_WCN3988:
>  		case QCA_WCN3990:
> @@ -1500,6 +1501,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		 * changing the baudrate of chip and host.
>  		 */
>  		switch (soc_type) {
> +		case QCA_QCC2072:
>  		case QCA_WCN3950:
>  		case QCA_WCN3988:
>  		case QCA_WCN3990:
> @@ -1516,6 +1518,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		}
>  
>  		switch (soc_type) {
> +		case QCA_QCC2072:
>  		case QCA_WCN3990:
>  			reinit_completion(&qca->drop_ev_comp);
>  			set_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
> @@ -1535,6 +1538,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  
>  error:
>  		switch (soc_type) {
> +		case QCA_QCC2072:
>  		case QCA_WCN3950:
>  		case QCA_WCN3988:
>  		case QCA_WCN3990:
> @@ -1551,6 +1555,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>  		}
>  
>  		switch (soc_type) {
> +		case QCA_QCC2072:
>  		case QCA_WCN3990:
>  			/* Wait for the controller to send the vendor event
>  			 * for the baudrate change command.
> @@ -1935,6 +1940,10 @@ static int qca_setup(struct hci_uart *hu)
>  		soc_name = "qca2066";
>  		break;
>  
> +	case QCA_QCC2072:
> +		soc_name = "qcc2072";
> +		break;
> +
>  	case QCA_WCN3950:
>  	case QCA_WCN3988:
>  	case QCA_WCN3990:
> @@ -1970,6 +1979,7 @@ static int qca_setup(struct hci_uart *hu)
>  	clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
>  
>  	switch (soc_type) {
> +	case QCA_QCC2072:
>  	case QCA_WCN3950:
>  	case QCA_WCN3988:
>  	case QCA_WCN3990:
> @@ -2003,6 +2013,7 @@ static int qca_setup(struct hci_uart *hu)
>  	}
>  
>  	switch (soc_type) {
> +	case QCA_QCC2072:
>  	case QCA_WCN3950:
>  	case QCA_WCN3988:
>  	case QCA_WCN3990:
> @@ -2108,6 +2119,12 @@ static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
>  	.num_vregs = 0,
>  };
>  
> +static const struct qca_device_data qca_soc_data_qcc2072 __maybe_unused = {
> +	.soc_type = QCA_QCC2072,
> +	.num_vregs = 0,
> +	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,

No regulators? How is it powered on?

> +};
> +
>  static const struct qca_device_data qca_soc_data_wcn3950 __maybe_unused = {
>  	.soc_type = QCA_WCN3950,
>  	.vregs = (struct qca_vreg []) {
> @@ -2758,6 +2775,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
>  	{ .compatible = "qcom,qca6174-bt" },
>  	{ .compatible = "qcom,qca6390-bt", .data = &qca_soc_data_qca6390},
>  	{ .compatible = "qcom,qca9377-bt" },
> +	{ .compatible = "qcom,qcc2072-bt", .data = &qca_soc_data_qcc2072},
>  	{ .compatible = "qcom,wcn3950-bt", .data = &qca_soc_data_wcn3950},
>  	{ .compatible = "qcom,wcn3988-bt", .data = &qca_soc_data_wcn3988},
>  	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
