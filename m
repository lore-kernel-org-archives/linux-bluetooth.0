Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8354223DC0
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755294623; cv=none; b=JNWyzvkOdHjhIX79Ho4pKGtuUEFQ6MZmvMoe27HcGAehVqx7aZ/iP7ftuWmvFoAG4MJ3adoHRs1dgupwbfFGxkqncfgtErkVfyJvuBHbaGFqeMThLMVxoL9vP/RmghCaF7E1t/atCD8SpsvkJ4gMkyfw1iIEFoLE9OWBla/kSQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755294623; c=relaxed/simple;
	bh=ac6REAN/JqiiNucTg9v1LZRbSCQNXBlBx3v+c0Pm+HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SObej70p5PaMkY0QUn23EYBZ8MqzzNXXVpc/sMh/2vwdGFaMdZvmQ/wnpZs5vyqxMWWa66mt/ZkFu3/QsqRvROHRL08jfG9UKY+g+ZW8/xl1s9PoYGthWYf0m+Lv1Ov/NNyVn61kqL7UX7IK0KFajlD3708W8xXZAad4X/UtIro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iqeXlKVL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iqeXlKVL"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FJKmx7014962
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 21:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=l6biuOa3UQqrG/aG5ZQm2Xkt
	ryFNEMSGQa2bcvMVOWY=; b=iqeXlKVLj5lNIrOGE4KCW2NwLU7/kf2pl12Y0enR
	subly3hox08avcKdk6iuBsTBj8BJxnSmIqYrkTWSVA1FB2FqcnOgNYvchiJ1eudj
	vPj5JsRTz0XcOCaYke8ILhL7AljiyO+JuWpYN5Miri/Ai6Hj2zEyWi1jyRGveLwJ
	/zXHSsq/nqimf+PVZGi26WBY7nx2XTIomrXO0Eh2THEa1tpcuwxM39XG58zCMThg
	yoL3TfauXfqyNNLojj4GInTkt/107M0ayxIAbnQNGcVkdZq731l9eMegol3JFf9D
	6GgqR14VL25TV5Y6tHvY7hk2PgGftkMw5DrU9iLRo9ZyQA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmm7pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 21:50:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a8b32a6e3so46731316d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 14:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755294618; x=1755899418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6biuOa3UQqrG/aG5ZQm2XktryFNEMSGQa2bcvMVOWY=;
        b=lDDfy6M/Mn9lLf4TXI/MZN/6/lRxDayjN/FnxMnkNtgWP/sI/OrWAzHKEA1ABq+r/Z
         PCaa7o1kulP0DWFjzeCdwlvrDmCyFHlZwor4FIC8fhv1dBtkV7JsQUCo8gR/m7K0WV89
         xPJa+asGkxw6X35bUJRhsEOfEHmxWKPig2ba1lAImR9kPmxuuAidzN1ouS2fXyRf+PoX
         nmOeV4OPrXRO2RnF8xL/36TTIrXacSy68VkvCPVmiaZUP7+6GYzPYHr/c1T7e8hmu8DD
         nT/zb4SkfwWAVu75bZEifOwFiAHMmZe0LuIMumPlgdQcRAIGMlbTCiBggJEknAgCaW6g
         IE/w==
X-Gm-Message-State: AOJu0YzNdG0yEOK3r5TBgGNZDBFU1meBIDRs9t0qUnRGAXzfguZA39wq
	odJOTjE/0a3rNZqf95bUt0MS1S+CTZHB5PgPXhzs5lXCWC+iPAwTf5rYyoL8FvE5516cw32dmLJ
	nsVVlwJhqSpnBD4agI6NhmUuGaS49RHgdIyEihpLbpkAozIY3VzuLW9L4QYbP21EvwSEFLqkG62
	1c/VM=
X-Gm-Gg: ASbGncvhhtOzMfgxWw99+r7QJ2PPB6h99OeD47v0elz7kQR1MeatqlhIV0vE/hqBEVw
	c74p3jvWZLWRxIKFZKLA9S/GP8w72+rADIAI8NlaG8BXl14NLYeLysvsfxgLWTApDuRPETC/bmg
	ZELWNu7kp5iHDBoUfLljU3pAtYZjBxhZrumDN93NLS+yXY1OUTpN+tkOlbRdSVE9rvoEhkekV/H
	AiBFj+p/RZCIg73S+DtMFc857oydBua63iiMIyKCii1TjB+fBCQSddZmuktSdQoPk3E6v4CC7ZZ
	DUNjUnCO4geryKu7dgzhQggvVoYueRikGzgEVOLv8p32vvvokaS3ceQDv0dMNj7V5RiNIKsKrWa
	ZlMnfAnJ6f4bP6lsDzTCtPFJkkwg6/DIl04Ij1zieo36qwnB0laE6
X-Received: by 2002:a05:6214:21ea:b0:6fa:a4ed:cce5 with SMTP id 6a1803df08f44-70ba7c64341mr46773156d6.44.1755294618309;
        Fri, 15 Aug 2025 14:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoBDgThzHLi7aS/ngV2P6hg7JYNx9cDvk0VaYMWTVe/02CHjMjhOZeKmEk9YV638GzF6fEww==
X-Received: by 2002:a05:6214:21ea:b0:6fa:a4ed:cce5 with SMTP id 6a1803df08f44-70ba7c64341mr46772876d6.44.1755294617753;
        Fri, 15 Aug 2025 14:50:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3514cdsm503149e87.14.2025.08.15.14.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 14:50:16 -0700 (PDT)
Date: Sat, 16 Aug 2025 00:50:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_bt@quicinc.com
Subject: Re: [PATCH v4 2/4] driver: bluetooth: hci_qca: fix host IBS state
 after SSR
Message-ID: <ndgufkvb7gkqeco45xlru2x5ai335s3vhx6wso7pksqcyfdjll@azfjjboa7bc4>
References: <20250814124704.2531811-1-quic_shuaz@quicinc.com>
 <20250814124704.2531811-3-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814124704.2531811-3-quic_shuaz@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfXwT6xtMwAksy2
 xnFImpD5677ClH9+ELHQgJ6b25u+xFt0DjPuWTyOSoX4SbZMS0AXIwFTQLcDlONxjG62sm7ejvN
 OXS9++gh1D1yvT619VT64jjzxG6kxIa6QIvv9PnoaCM2ZHseUWZpYKxFG3FuuZPxgX/O44JY37g
 mSyKrwwbwmnYukApT25njrmgUjutEMWjIyW1wpRyUHqINv2WmIe+QnP9sOKNu4EcJLEHyL9nZRO
 Srf1J1eIfZ/AzEbZjSUAOGxqcPapJ4JuRHuCi1cSet9pHG2+ZLrIdLBRmtMVwiPMawD7n2gtB92
 q8YWN2GX2/h9jo8i0FHPl/8T34bYXuiweN3EopcP37xW6Qf0vCiXdbGpaqiKHhLWI8/wrV0P1mk
 LlZR0d/U
X-Proofpoint-GUID: udPYrarkt3xnd-7ezeB8jONti47DHZa1
X-Proofpoint-ORIG-GUID: udPYrarkt3xnd-7ezeB8jONti47DHZa1
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689fab9b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=MNOoASI8n59Jp-IQCpEA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_08,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

On Thu, Aug 14, 2025 at 08:47:02PM +0800, Shuai Zhang wrote:
> After SSR, host will not download the firmware, causing
> controller to remain in the IBS_WAKE state. Host needs
> to synchronize with the controller to maintain proper operation.

It totally feels like all these patches fix the same issue and should be
squashed together. Please also add a sensible Fixes: tag. Possibly
add cc:stable too.

> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 91009c6a7..d37cd2368 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1660,10 +1660,14 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>  	 * QCA_IBS_DISABLED flags cannot be cleared, which leads to a reset
>  	 * command timeout.
>  	 * Add an msleep delay to ensure controller completes the SSR process.
> +	 *
> +	 * Host will not download the firmware after SSR, controller to remain
> +	 * in the IBS_WAKE state, and the host needs to synchronize with it
>  	 */
>  	if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
>  		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
>  		clear_bit(QCA_IBS_DISABLED, &qca->flags);
> +		qca->tx_ibs_state = HCI_IBS_TX_AWAKE;
>  		msleep(50);
>  	}
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
