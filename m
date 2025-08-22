Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821F25B687
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755863104; cv=none; b=m9b+rNtrIVikRvxatXFUBFimo+syjozZxBalFs7ybs+8U2fh0nq2wGykHtF+ZhJ0s3mQ9NUWZvqxehzEahKCSePlgDlR0W+obs9fwSVpuSXghrfhCzCdGq21wf8YOPWfsz98NQ2q3i9tDsLeS+UF0Z67shpKzj6wa/ecUs8u1Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755863104; c=relaxed/simple;
	bh=GF+aq3BmblnP7UO8TZ6Fm61AgyK0+PsKeyXIW4GsEC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8xqdRRZrtUcBpSP80nsVwVmi0fylaulVAg9Mc/K4pUDd1lI18tvW7IjYjUTPD3fHFh3ZtJs0f27PzIbK4NIJJJ2EUi29D9fHr6l6/2AWGq99I5VqvN4qM1anOk27AFuePbfBejA8wsu10OwbfcKLNyfkCxOQwhwHxoMBxdJ5pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pedOmExJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pedOmExJ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UTZC030555
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 11:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FDfUSJe03Awd7FOR2RSCmWZ/
	ZclRfZGke6zPf5LEDxo=; b=pedOmExJ5a38mAt3SKOKe2Ec8DUmTFYovNjq1MmE
	I8c/WxqGFq4yV1U47ow9ltSWOoxT36+v1YIclZfPFCVDyz2kDJCUtAicvNBq3PJU
	P9Wa4uNxU63hSy0YVYb/4e69H8Kne/7K93k8wfBIix+3I0TTB+L85Xswh0PA/IIl
	dT8ZC92dUSP5f+xiPevc6fYvUaXIAgygNDp97ESJqb2sRe0Ti/lPeLQdTt6rA4ui
	rOz1SglWDdweHKhyWv9yK6UASmeH5P5FVOYCGOzLtG8lrPYdQrQJjk4iORCuGRTt
	/vYqiLABooVlBTa38cexBhZfHKVzUoEoe3WNitWixdwm6w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdpw8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 11:45:02 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70d93f57930so35811466d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 04:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755863101; x=1756467901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDfUSJe03Awd7FOR2RSCmWZ/ZclRfZGke6zPf5LEDxo=;
        b=C/1Ini8hk9x6fwjJp+H5zsWIqF/1EUbwWXGkxVwaMVSj/9bImmxFMJc4IwrOhIpH49
         PQwvMvfYICPdPJVBISfFnw9/Tl8qdEPl9mbpIvqNcwR7Ir7cdwaFY62gswTbPVDrBt9d
         I7EO+JM8fLq7/tBoVcPWkV08BejfPP5I1kAeI1QxvwE8VqcvrhDSOymS6IrsbACzBJUj
         HnN8GUg96/uf4xFOklPdaqtLk5BMTocUgrs47e+cS3Y+YVtImZObd5DU3tGkVrOHOJDI
         K3hH4nCNHxWgufFDCSHeJcG+bu1Lir02CD3gar6kozZt5JE+6e9aGL+N/gRKSUI9JvwU
         XBNw==
X-Gm-Message-State: AOJu0Yyr4zwBEpAkspGXDliQkuf49Zr8otKKKLnJNIoABoboOEOYgYTb
	DxuLw0/DBft5JTkBr5FHrJVDQucELGoj6bADTJFlt8+YwJu3oIDN7HRIzPjd/kgWcfKuYmipmPF
	XHUj2lIWS2dJ2WSvLqVxQoM+PAH4XGH+kzs1kV4Q//M3DCfHUk9fMU5FDt25TpTpvINLRVyM=
X-Gm-Gg: ASbGncs7924k/YCMxfKfYmqKVhzqW5CcUVX7obFMknJEgfFAWFxRsbcJd3S01y8pPAc
	7n5ZH15wPFdS9j9xLR06OHV2JKKVwC5yqiHUC0I4S+G+SLumoMMc4knMYATvb6Dng8JL426dpRs
	eCNqfV/pHG8nMw/Zq5JzARMdCL3L/BDzBukJH1eXSWH70Wo7olOEdfS/9GESwOYzYz6RhUsSPoe
	B9/pXFPTdjHfa8LJnbPdDrZC7uLMARgq1eB+xYC2ieDvYtLLT2iLv+oKtlzx9fazaAeclajr7oo
	3lYJtO2XpLqT3Fb5H8aBGPyX3lLrmQs5bZxrf1OzojM8sm8/JrcX5mWwArDpZZyDXekSLy1Xmr8
	tC37RXYm2Xh/wGuk9xy4u25A6zpPi+z16S3ZsZTbksV8qJ3mnXArb
X-Received: by 2002:a05:6214:5f03:b0:70d:9938:55ec with SMTP id 6a1803df08f44-70d99385a8cmr22501896d6.42.1755863101226;
        Fri, 22 Aug 2025 04:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc+zgwxGBs1pfu/9DcgVXcZwNNCpsvXMT8jZWEcMzgwrXXe8vEq+xbRqDG/TBkXvO7KOtQ7Q==
X-Received: by 2002:a05:6214:5f03:b0:70d:9938:55ec with SMTP id 6a1803df08f44-70d99385a8cmr22501366d6.42.1755863100532;
        Fri, 22 Aug 2025 04:45:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef351797sm3464852e87.27.2025.08.22.04.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 04:44:59 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:44:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_bt@quicinc.com
Subject: Re: [PATCH v6] Bluetooth: Fix SSR (SubSystem Restart) fail when
 BT_EN is pulled up by hw
Message-ID: <qirclgwbh556rgkqbejs6nbkbv737n57cgmzgh666ginspya7e@mzacv4crszph>
References: <20250821121627.2727387-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821121627.2727387-1-quic_shuaz@quicinc.com>
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a8583e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=TtMG-BGGMhrgH5IDBmIA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 2s3BttWLC2w9SuBS8_IFHp5icjnNm0RE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfXz5xl1GxTh9Tx
 gGj5uLL7EftH7j3SHkK2pDpqHxP2o1Czyq1O2+9SE4l+PL0+PY1Qv/On/sCEa2G7x99RmGxBVZx
 o3sFMT7LiSWW+T5WTDDcLwuFmBK4m/KMNOW0sTkR+edHl9qYyfTxfcqcy/uuJX+5US7dGHi97uU
 EVUcIUUuGlPSFQE/nGlE/BRcLd2Fb8egGDq+MMD3kOYDFWkACmjSFeyfwJWLbrvUDn9QN5NH+su
 xSaIs/g28F3gIkTB1XOw5s008sSPUqm5dXrI8rAQKt6EsJr9jjZEy/IFkBfpU0vIR5jfyPc4Bnw
 sh76u0wpZcHBVpAGq/8gbz+6LFRIyEVRJqdMS78kKZ2a2ve3p0Uoxk0uC7P+/NJDDK0MzhxJkfq
 6fhIXF7emhS8VU4e3Mldezhuc6poCA==
X-Proofpoint-ORIG-GUID: 2s3BttWLC2w9SuBS8_IFHp5icjnNm0RE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135

On Thu, Aug 21, 2025 at 08:16:26PM +0800, Shuai Zhang wrote:
> When the host actively triggers SSR and collects coredump data,
> the Bluetooth stack sends a reset command to the controller. However, due
> to the inability to clear the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits,
> the reset command times out.

[...]

> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Missing changelog between versions.

> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4e56782b0..9dc59b002 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1653,6 +1653,39 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>  		skb_queue_purge(&qca->rx_memdump_q);
>  	}
>  
> +	/*
> +	 * If the BT chip's bt_en pin is connected to a 3.3V power supply via
> +	 * hardware and always stays high, driver cannot control the bt_en pin.
> +	 * As a result, during SSR (SubSystem Restart), QCA_SSR_TRIGGERED and
> +	 * QCA_IBS_DISABLED flags cannot be cleared, which leads to a reset
> +	 * command timeout.
> +	 * Add an msleep delay to ensure controller completes the SSR process.
> +	 *
> +	 * Host will not download the firmware after SSR, controller to remain
> +	 * in the IBS_WAKE state, and the host needs to synchronize with it
> +	 *
> +	 * Since the bluetooth chip has been reset, clear the memdump state.
> +	 */
> +	if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {

And it didn't improve...


-- 
With best wishes
Dmitry
