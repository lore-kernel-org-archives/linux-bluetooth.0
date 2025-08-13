Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7A2F6560
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083122; cv=none; b=UF+Y3u0q4yy2Pjh7ILuzuVMrl6NjsBUREP8zaVkT9Ga+p0f280DjVOws3TXEvvXXSNVCkTEQA/w9CPJZFQql8exvC95ZY9D5F0CBbzjpm+xwKNJYJtZuRLC1Qjlf5qIlIAovxtLYo9K2YFEQg4OTs/K7jEu2GbcwvjetTaF//P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083122; c=relaxed/simple;
	bh=sch5TBjToxGrPL0MVu6AzEEz4ok4bUWP/uIfWkQiEz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNUmGvE+c4b6Zx5Vyn3fsHn5otyPQNtEF6q/mjA8imYcMpJzQregm5IhoHhJsGZdYLBLcJA0ty0/Q3l9Dv6VEdp96OOdM3elV195aeQ7HGmqgYxsr4wZ1OZWoBw+gdmd5N106u9EpXbtI7LOn4ZzrDB3zdwjnxAeJDDUt2pGxsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dYnOVxXq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dYnOVxXq"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mLoM026024
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 11:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iUOmZx2iA1Ss1WAKFvo26UYUKENTpaMWqnAFmsTkpXY=; b=dYnOVxXqInihaU2z
	BiVfUOSypafv55pEmRbwdFdDjrKLLCUjOeVsN11ngfhjO9mG0RcUb2shcPDU8q/D
	GqIKYirN/j8qCcRAJjN7S00McfonX/VgoHKyKFAvgH8F458r4gk56YsDmRYyxXcS
	J2EutwkX8D5at7iwHj/PBjVwiNYrj0/R9pSPtNw1Pn6xJmBzPCp3C32AgrK8QclM
	gXWvcaGDpTVJkhdn3JL4uw1+mCk5GWTt480qypSHYPH8WwSV77K09SHnK51MwvoW
	7nQgM6taOiwRrlOdcSiRaUFae4qumKHFJ4HpR7FmPDrN/dgdJzZ5CmbQzO23dGSZ
	Kkuofg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9suqr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 11:05:19 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70989fdb7f6so17497766d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 04:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755083118; x=1755687918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUOmZx2iA1Ss1WAKFvo26UYUKENTpaMWqnAFmsTkpXY=;
        b=tqIdk68Eg6CURG+IVtQn5o1DHXCHxBNc1Kd4n+xfJB7Adtkz/l9VsRPwrvz9XsEiLy
         M73a/ZIkzR8iklNZti0D+ncMWaTwyyKDquYtpS6oD8GV9I2oiLozfHjuH1MwMDwTp+gD
         8v0G5MwW9V9iQIuGUI770urVdZKG1zAGYi/7PM6d0LiP3wNnutx3IdEOll0r0GS12a9G
         dWShetTErmZPJrHZV9KYSPk/Aim2cn0iguFKuOIbc1bO/YPQBpSKoU1LZgDxdY93qXFZ
         RdvdDql0mL0GwyKj+nAyGTmOKo/bJ1h5w4gEpp2fdqGMqDZQ3Uq5vb9ZYdgWAdKTftlO
         /yow==
X-Forwarded-Encrypted: i=1; AJvYcCWCfkXKFYUnMDsvAdFcOYILdwtqXEu2Rbcv9aVyKxbHgYJd9K0rvBtrsKF8K7CEkwVI/fbJ/us4vY8c4CGruB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgeWjPIc89WVwPCi9UJgKXYouUzT02qIawQOcFFe8gMsUGVabM
	Hgd4kVkkbvT9VJ91oPgfrYKffFwA4HH4PVmGVeZQS3wXqhrlH5BiqbFCkEqQAJety83v2n9Bdzz
	2IqfW+3YEia5jPaGGP1s7EO8U9uBGz3L9AjYPBL/y1wDqny9cjhEb7vbP8XEliDWvC7DuF816Zp
	uNvtA=
X-Gm-Gg: ASbGncuvFMm+fb8MJhnOCK0L+cGeVaychDEbshNpiKRuxib9uaasnSKOBc41JTwpt7O
	9qZGgwj+D/wvu8RoWTzis8asPopWQYyu4zN+qljqCIL8DkcX2ey2Pfaxhjyi+ND9gaXCkh28PTD
	6bSy+YIIc3235rH+4c7yHRZpUUV1bmejgmZH2olphzQIvC1rgNYlaR0V+OE+Gs+grN2dMOiL/ud
	YPN6Ch3njiUmTxSeukK4p4/7S4+f1wRPfytaSuzbSuPZ+/QC+U60dTK9cej/PNaJCQlR1alusQ/
	/KAAJpgYEVuvybJ1mWsdd6bYhXwN/suxr7bQCnlU1t8BuIf1VdOaRBZ3WFnMhO4JGoB7w3vRPnh
	1Vv6D5xVzL+tI1JNNUQ==
X-Received: by 2002:a05:6214:4001:b0:707:4998:712e with SMTP id 6a1803df08f44-709e8953851mr14391166d6.4.1755083117979;
        Wed, 13 Aug 2025 04:05:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE0LNUf1t59zVUgnbYBXxl7wK4EQUqPuL90iLAjgla9CcHvRrfynOHqW0E1DJJOrJoNmHHcg==
X-Received: by 2002:a05:6214:4001:b0:707:4998:712e with SMTP id 6a1803df08f44-709e8953851mr14390696d6.4.1755083117155;
        Wed, 13 Aug 2025 04:05:17 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6181ad55ebasm6547428a12.55.2025.08.13.04.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 04:05:16 -0700 (PDT)
Message-ID: <77881d50-c044-4aae-bd0a-5265e0db51cc@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 13:05:14 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] driver: bluetooth: hci_qca: fix ssr fail when
 BT_EN is pulled up by hw
To: Shuai Zhang <quic_shuaz@quicinc.com>, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: quic_bt@quicinc.com
References: <20250813033505.3868781-1-quic_shuaz@quicinc.com>
 <20250813033505.3868781-2-quic_shuaz@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250813033505.3868781-2-quic_shuaz@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689c716f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=zw15p0q4DuKXwe2BdPcA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: AojP164hqyy1K-cbh_OgNPCkPcM360I9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX4gr34uo7bIY5
 3fm6Sr1lnkukEs6yGCJ4YXoAJ60krPiuynT4PuKJ0YnpXq4q23I9qnB68BCb6BIF3zRVCM5An02
 uMidWArEIe7M2HzFMXsVSNMfJTGsJnjRHX+/d4/LkGVrG0aUp1CTmjAIAWwC00ltKEaP71DMU4/
 wpYgvLX9QP4zwtlck5TUZ7erougrVgcwRC9PpycpJzHRKo25edzXj5HoNxZOaYakjZP33XMe4O9
 NAV6KoR0P06wYajtbGaYeSqs6DFbzALs7oQsHbOhjNugiglpjTWpxzWzNGgcyCNFUpzrZfGUURn
 JMMhFXwDXqh5JR6Nef+CKJhfh04/m2C6zLTdhv07Mlua7FG1kE9xbuIlEVqWwG/PgZCQU4KKZAi
 14bhOJcV
X-Proofpoint-GUID: AojP164hqyy1K-cbh_OgNPCkPcM360I9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

On 8/13/25 5:35 AM, Shuai Zhang wrote:
> When the host actively triggers SSR and collects coredump data,
> the Bluetooth stack sends a reset command to the controller. However,due
> to the inability to clear the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits,
> the reset command times out.
> 
> For the purpose of HCI_QUIRK_NON_PERSISTENT_SETUP, please refer to
> commit: 740011cfe94859df8d05f5400d589a8693b095e7.
> 
> The change is placed under if (!HCI_QUIRK_NON_PERSISTENT_SETUP)
> because this quirk is associated with BT_EN, and can be used to
> determine whether BT_EN is present in the device tree (DTS).
> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4e56782b0..14b2d1bee 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1653,6 +1653,19 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>  		skb_queue_purge(&qca->rx_memdump_q);
>  	}
>  
> +	/* If the BT chip's bt_en pin is always pulled high by a dedicated 3.3V
> +	 * power supply via hardware the driver

weird line break

> +	 * cannot control the bt_en pin of the SoC chip, then during SSR,

"System on a Chip chip"

> +	 * the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be cleared.
> +	 * This leads to a reset command timeout failure.
> +	 * Also, add msleep delay to wait for controller to complete SSR.

50 is a random value, I also see 300, 100 across the driver.. where does it
come from?

Konrad

> +	 */
> +	if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> +		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
> +		clear_bit(QCA_IBS_DISABLED, &qca->flags);
> +		msleep(50);
> +	}
> +
>  	clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
>  }
>  
