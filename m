Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D731A9F9E
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083644; cv=none; b=GImT+4OofT7VeLKZh/nDwELfbWRmVFMJhk5Hh+OkUZy8ijOrAJMOPgOw6B49Vtb1A7t2+6CcRfnle7O1/DvJDSzAfJBgj6igId/a8rxloR5zppovH85msiredBv61zQDWJ0/dcuWjTufauWdB6L2DcxewNFAKCumzSwm1qjHZoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083644; c=relaxed/simple;
	bh=URLN0J3viIGWjUPM9pj9P03nzVRIC7f2xtWJzWviqtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGCK2ljL8Unlnp4TImXxLc1N9ILPETvlopUxda4em3KXghLNstJvrv9dGONeV3+u6TOwxUf0pzRfX2fPO92ciPPloAftlowCNN3uYkU9x7y22xnPjM22EznQH0VxVQHsBRyJt8h6hDm9NwjXpuMyAx0TwLyM9yKM5Ah1dWLHmyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J28Hi7sg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J28Hi7sg"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mdq5016406
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 11:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wXB54FjLkG2LqKyo+58XNe64zZqgQ86PWmPICf+KF7c=; b=J28Hi7sgoK9JToLf
	xY4XoQtPbNb3vtEzQ9IUIy+rK8hbvl2wmzZxGB6Mn/Sh+lkv06AOL3ux9yKTpTSg
	or1CyLpAWKm6gSmAXffyU6NIhPEjARfz4Rh/d7qJIJLBegd14Px56Mjhj3xeA9QU
	hFGT07QNF+ds3gjLlsEH3dfwxCgKH3ejUeJ5389lUISDbmts2xw0Jk06lotNTKjb
	wdzjuRJul4LxBe+nVcLSoRE0xDvkTWdIpQdtaQ4AwpjFcKtfsJFz8tS46UDtrNuh
	ycmkcYiU+L12jKFFQ7ihu1q4JV53iXYHP2LfxHI1ei7wt6pnHwQjlGS4xBI3rwhF
	OetkBw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbeqt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 11:14:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b0c502e87bso5203841cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 04:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755083641; x=1755688441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXB54FjLkG2LqKyo+58XNe64zZqgQ86PWmPICf+KF7c=;
        b=lCIE1UWpi7efKb2il7qrbdUnIiSXS3vMv2XtirG5zZzztMLcSOIV/doY4vvgwyM8DB
         glp4DW3UDBIJhBJwLT7Uru1/o7CHsxGqRpWHkJD8Opd0SWeMOpTN0CzKdjBzLXeXN6qs
         th6ZxUFLelSpWP+i0KdQBX3fIkPx0GYLNO6upHZdOwCJwtqiLH27NcsznEqdwJdd4NIK
         VlSDOUy0XBUNe9owXOl2ukHCrQmmkC1AXNUp3D/2ATTkdHrYUy0VP34QeZTBpedh9rXB
         /0U4hgC8G0sU1SV3xNCEEhUj787MFaV39t9+blDLuhmB/nZYA16qMg+J9n75oMf/R2T4
         2daQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3YCYJHEydChLPPLaReJ0BytBHrlcWYylEEHSlDQc2hm04Uniw918cgHG4ozeOm22b9Gkp3MSBr6dP8oBD3Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBuAzRXZERFpUEP5taV+kX9ky60wGGohah09gonV5GrghFhNdi
	1VZsIB7/sc/8joZpJSWmX3NQhzGr7yRil3H0PLlU2A7Q0+gWPNV/5FsYDDBQOUh8+1q3u5QZtjD
	BqCX02R85Bq6kX28x46sJGmFWQ4dgerIbESAOCTJQk3BpmtRJLEHAr8jsFvVH7dKjnJwKgN22cp
	CkqJs=
X-Gm-Gg: ASbGncsUdkEzH7HtZNAfeMt/k6TtpALOkrHO40TPlRpf0QITh+U2TKoZ6EV3Yfz5TaN
	VgIr0xoEEh0/jQyBN1KojwjAC2ux4W1BdSN8Gcdvt7xuds0DQmlbfFAtpYYVc0QA0AB+LsIad3M
	MMb4cvp/3GfWBRSZ7ey2Wv67hzsxL0BFti4xChHs1Eo0DbIxeoZup+vcW2FbPRNSGQIztFm4INt
	JlyJQzvVvmFzF3KwkvK4j1cNWntHEeI2rxvO1nmEcmBeqnbPg+0MjkpZw/Cr7MaG5OzWbgpxztH
	2In5pL9UACqMTc3qFOGZocefZcmTGG5J3ROVefglBFe8q4NLLW0+ZAAdOCB05j7PtKdFfVYXznA
	9es0APp8YONc0gANGHA==
X-Received: by 2002:a05:622a:46:b0:4b0:af20:f3c0 with SMTP id d75a77b69052e-4b0fc4b6efemr14963411cf.0.1755083641264;
        Wed, 13 Aug 2025 04:14:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEenB4XKW+CNs2ccR/ZwR4FK59NIDOCXTd1clj8q+3NsTk4JuXQkOVb4eo5aHs+X5qGIf+I7g==
X-Received: by 2002:a05:622a:46:b0:4b0:af20:f3c0 with SMTP id d75a77b69052e-4b0fc4b6efemr14963131cf.0.1755083640704;
        Wed, 13 Aug 2025 04:14:00 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3981sm2361230366b.35.2025.08.13.04.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 04:14:00 -0700 (PDT)
Message-ID: <55bad41f-b483-4609-a85a-3f89c49ddfb5@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 13:13:58 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] driver: bluetooth: hci_qca: SSR(SubSystem
 Restart)process failed due to tx_idle_timer timeout
To: Shuai Zhang <quic_shuaz@quicinc.com>, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: quic_bt@quicinc.com
References: <20250813033505.3868781-1-quic_shuaz@quicinc.com>
 <20250813033505.3868781-5-quic_shuaz@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250813033505.3868781-5-quic_shuaz@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689c737a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=FCqFOTUeBOOQReXOLEEA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfXwEUbEQIdE0/n
 PmUxOEmnq7YVQWle87MCz4Tq4YDcPUw+6En14nP9LKoyTAd3OqOr0t2dZV0GhMh4uffmwZ54jRs
 ezfTpf9UvYgWq6p5zuYqp0LERqOokUp51z0GEpQHBBKEdWEh4/nmvpkv0VriPS8XIwkrXfz7Vwi
 jJ5TtOlg1zMsh8F7P+5Gav9L2SHXVFOD3Qdha4+YmOaE/2W7JNphnZ8pRt5J0yh7cOM9t9z1US8
 R//k2HO8Cm8jB9r2KguZWTejXF6H+ushZQnBxbsFMd6E2x+fQ0atALLkCC3NvFLdJdT6ognklno
 WDmPLH0YI6MIeKKS33S9DK/ygbV0IkmcB+xe2WviGt8lJj7I1SF/KhYu4tjgLM9Q4j57z//cSyo
 wM3jZ2eh
X-Proofpoint-ORIG-GUID: SVC6l-w8PGf0RoD78D1xLBKnxXmbZ-Fg
X-Proofpoint-GUID: SVC6l-w8PGf0RoD78D1xLBKnxXmbZ-Fg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

On 8/13/25 5:35 AM, Shuai Zhang wrote:
> When the SSR (SubSystem Restart) duration exceeds 2 seconds, it triggers
> host tx_idle_timeout, which sets host TX state to sleep. due to the

Host? Looks like we're sending a command to the BT chip and that
triggers the issue

> hardware pulling up bt_en, the firmware is not downloaded after the SSR.
> As a result, the controller does not enter sleep mode. Consequently,
> when the host sends a command afterward, it sends 0xFD to the controller,
> but the controller does not respond, leading to a command timeout.
> 
> So reset tx_idle_timer after SSR to prevent host enter TX IBS_Sloeep mode.
> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 33c2dd7b8..1fb8eea09 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1668,6 +1668,15 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>  	if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
>  		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
>  		clear_bit(QCA_IBS_DISABLED, &qca->flags);
> +		/*
> +		 * When the SSR (Sub-System Restart) duration exceeds 2 seconds,

This comment will become out of date quickly, refer to 'tx_idle_delay' instead

Konrad

> +		 * it triggers host tx_idle_timeout, which sets host TX state
> +		 * to sleep. Reset tx_idle_timer after SSR to prevent
> +		 * host enter TX IBS_Sloeep mode.
> +		 */
> +		mod_timer(&qca->tx_idle_timer, jiffies +
> +			  msecs_to_jiffies(qca->tx_idle_delay));
> +
>  		qca->tx_ibs_state = HCI_IBS_TX_AWAKE;
>  		qca->memdump_state = QCA_MEMDUMP_IDLE;
>  		msleep(50);
