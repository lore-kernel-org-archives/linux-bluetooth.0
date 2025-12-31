Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2AB3168E9
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767182704; cv=none; b=uij7mZdjvneORsTdt2WqJLwT9ArZmu3jSqGpXa63PkZi4aYaTnhy1UaDib3+Ln+My1q9Xz66wcpqjbjTlAkVjyXwVS0WNFPUfOPxxGXoBmV1k/gaRGnVWmm/WIza+p1ObLgMiab8yKri97vFrb9x+hNcrYmcF4t/uK/RPd6RbTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767182704; c=relaxed/simple;
	bh=SENiCz0Nn5G8mBkqXLcSD4qJTOucujaqgbE5UhXTpPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h63zJWkZ3aJsGNWNp0jP/bV/X6V9SghFBNewdLSUIHtNDGk4d/4tjeM7h3y0RUFOIaRGV8LSrp81gYc+vFaplScwGuxsKLJIij5+YoSKQEra5ihbQeyto2NtNBYdaVsGmXC6FXmOVSxOhG26fo6ERuQ64TKA/9SpN5WKIT3sIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YbOT9Q4/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WiV4ZlzE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YbOT9Q4/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WiV4ZlzE"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUNke9R3138113
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cAiyfMF/g9yjPkCOoTBHtDUTlB8CTuK3gitehBAPkvg=; b=YbOT9Q4/hsa5nJM8
	TIFznLqkCr/ro3BwOmX1HN8+eyL3/4lPdrtWG+XrICtYanVCzX8mUnVPczlkRzS5
	NgeTX7fejQHXSMu1pOHPa/Z+IyVCvdG+xIYNsx5b7RjPeoiwGpSCdZc6laz/yrMY
	vuGlayM4mcukTYOTHWmZv3oHMtYvcQ2DJLg9Ams+UUrqsauc2nuHISzYeG+Xdthg
	GXMGPqrKoJEOTdmf44BGdWSUTC7fepB1sRo1f+MIaP2s+ktpdsa8GO7m07pB3YcU
	HTU5eLieB4kLQAVLLd644PsW58xTHipwv9YCKX9rRwTz5icQPRG6R20ywXgLLDNr
	jCQy3Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc8ky3d3b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:05:01 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-890072346c2so16607016d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 04:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767182701; x=1767787501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cAiyfMF/g9yjPkCOoTBHtDUTlB8CTuK3gitehBAPkvg=;
        b=WiV4ZlzEBa9YTRbjkI8jkonTNxWEEdZAIf4zzplXwj1jomFhdY0T/UM0dcFYZlcuCu
         jJbE0coDle/hwBq6PNAgPcAMPYQ2X5+4pe9XBnIWkRq9sugFKqwM81R2KWKMpFG87RXd
         RkyizpPC8V0YugkcPVXHbhAauViThaZmub2CQT8FQSYEklSeBidQ4/Os7Zl4gNdV+XUF
         46lmHguetnxYQp1ioYj16a4+V/COo7/W/52p72l4U4+C70Kic29YoIKh1beyiB0CIG+0
         HAGlRAjuAKdCXAgfvUSOGwiwh4HDheja5vyYwoQvccTFnd/8CuPa4ucUKPG5dJNci6vU
         20yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767182701; x=1767787501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAiyfMF/g9yjPkCOoTBHtDUTlB8CTuK3gitehBAPkvg=;
        b=wrqj6vgEBmUwsYHr2sAMjUSNa6s0uNB18Ey+neyPjpUmEVszKdtDcHFUfaOddVVKMc
         fOucBd+sDm4OpYNeowD6wYkRLIAoeKHvE7u7mXFaUP3cArptET5UEMirWnIfIlkeQ8sI
         CUO3YJJ3kJA2PrAEfkleU3WYDa2ylnCTIDjiv7i0zQ/LS/y6N40LpV4Ql37WXf3M1ffB
         1NP51Rw1U3XZ8XU8CDRCOaTkRkiloTz4hjoovXdlZeJMcS2WdN5ZTRbxbED3/qhacPfJ
         /C+Mu28Hd46B7/0SQt+6sG3I9h5k92e7/hK1c6iry+kSa/L3mHu4wuycMrcw0yj2FHlt
         /BOw==
X-Forwarded-Encrypted: i=1; AJvYcCXMFJgvspKJGCOUC5fkBMA07kRAvkaLIQBFEYAn2qZGSMtaolzb5ocNDm/YMO2aWYRsFuKC9Qoc+3FIguTMY1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVyh6K0YWUvir6H7AkcVZueNtYwUKvJjgLWr4ZiGF/kAqpPmHU
	P+CZk6JZHjIAMV696U6u615hbIl/yDxajekkBxo/bJNNPxvxE32R549ARJ8XICTKpirlfM5GEdC
	XIT94TH82/MYyDJlD2f+ek1TeyTDpOpAE3OLxEsNI30LGJGKvoRfoCgXj1FSYxEAVQQyiG+Q=
X-Gm-Gg: AY/fxX7vYv0wrYr9Ruv0YlxsGPOh8KBF9yPB10IX+KGsO5uwt5TvZK6iobFLKM1qp1J
	GyO6AEBVYaTYvO0gkuU1V5YjFLvYxLojffPFKQa3LxrtoXVxLye1tRYCtfBkSG8sXEfMUp1Qb4r
	PZ1+Q5BoHKCY4/CEU33/oNyoKx03yssvHjos9Fc/aHLZ5R37bJfZfaYze3IJHM2BuJW+P6517P0
	/us58rFQlTSv13H2TxOg7eCjcsfsJt+vHD9+Em6PCqoLIFB/RHOZxWYtpt3zcUbnqitS3SCL5CN
	TJE3JX7Ww5RjiXDBKux+z/fcsPg3vuHqjnB4u+LMMyhOYnaXlJyXWlQ+mzWn8uWByA/Bf3/eYrS
	hPqmAodMihXMyAP54Im+5iSyjl9n/nFKHZofGnPGLmDXgUjlTkZGbctPHmTYdfcv6+w==
X-Received: by 2002:a05:622a:cc:b0:4ee:1db1:a61d with SMTP id d75a77b69052e-4f4abcf3ba4mr419279441cf.3.1767182700795;
        Wed, 31 Dec 2025 04:05:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmspfRwTHtI0ttV2ZEBE7PjFXjLSRr3IkJr1HAIkpcbq09C8vb9gCxrZVPdH50btLnUkiSig==
X-Received: by 2002:a05:622a:cc:b0:4ee:1db1:a61d with SMTP id d75a77b69052e-4f4abcf3ba4mr419279021cf.3.1767182700295;
        Wed, 31 Dec 2025 04:05:00 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159ac90sm37752595a12.29.2025.12.31.04.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:04:59 -0800 (PST)
Message-ID: <dd020ebb-d005-4322-9321-b09199156a9c@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:04:56 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] Bluetooth: qca: fix ROM version reading on WCN3998
 chips
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-3-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-3-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwNSBTYWx0ZWRfX8j2uSZdWEDPN
 5fwwtnUENHWbKA8VsxlFMv+2QwXHzLopQARJkoIJjKsowccjwXp5JOC91+ywHiHjTSRvSWWrHZx
 GD+waaeHeaTvys//grj7v+0Z3s2Xg5mKATvn1jbQ+Cie+b95AqDf8WlCaH9a5fIyxE2HodNCai8
 wOwY+pKFXoXOj0uwY6p15y9ww8N8KPf4KUQ2aw1KRBx/piFHEOTeMAqYJpz6RE8Wy7C+KZ82zKm
 Y75xB6PVXLNFu3FU1j+tec1kGaI4bS7TVE3Ygpsv1OkQu2G0SVIN4w5Rst/H+nb/tmotPUdzVLS
 YLnDZbLtKXPiqoeb4+TW5ZwBwIgGZGO6s1WyK/iI1xqu8MGITExQ2vs69R9WTY4QwI1Fwml8De8
 i3N4iPZELr2dbDCtlw1SpWpCC+RVi061fEgRv8/PFio9vjVWnf1CFo7Y6suxPnpmBNDeTqjPn+Q
 3mrt4ym0hVsxhhEbYCg==
X-Proofpoint-ORIG-GUID: 9eCQIbJxf2zSfXBESSn4JxsasgL6bSAT
X-Authority-Analysis: v=2.4 cv=BuuQAIX5 c=1 sm=1 tr=0 ts=6955116d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=_XeksoCtAhHN6JefJdYA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 9eCQIbJxf2zSfXBESSn4JxsasgL6bSAT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512310105

On 12/31/25 12:35 AM, Dmitry Baryshkov wrote:
> WCN3998 uses a bit different format for rom version:
> 
> [    5.479978] Bluetooth: hci0: setting up wcn399x
> [    5.633763] Bluetooth: hci0: QCA Product ID   :0x0000000a
> [    5.645350] Bluetooth: hci0: QCA SOC Version  :0x40010224
> [    5.650906] Bluetooth: hci0: QCA ROM Version  :0x00001001
> [    5.665173] Bluetooth: hci0: QCA Patch Version:0x00006699
> [    5.679356] Bluetooth: hci0: QCA controller version 0x02241001
> [    5.691109] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
> [    6.680102] Bluetooth: hci0: QCA Downloading qca/crnv21.bin
> [    6.842948] Bluetooth: hci0: QCA setup on UART is completed
> 
> Fixes: 523760b7ff88 ("Bluetooth: hci_qca: Added support for WCN3998")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 7c958d6065be..86a48d009d1b 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -804,6 +804,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	 */
>  	if (soc_type == QCA_WCN3988)
>  		rom_ver = ((soc_ver & 0x00000f00) >> 0x05) | (soc_ver & 0x0000000f);
> +	else if (soc_type == QCA_WCN3998)
> +		rom_ver = ((soc_ver & 0x0000f000) >> 0x07) | (soc_ver & 0x0000000f);
>  	else
>  		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);

This looks like rom_ver is essentially maj|min or so with min = 4lsb and
maj being a couple bits up.. no big deal in the end, but this could be
expressed more nicely

Konrad
