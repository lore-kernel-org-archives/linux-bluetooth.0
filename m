Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332562571DA
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973803; cv=none; b=Ylnjasm9Co8QDaAXE+wrHgCOQoOZM2qEE3f+w+62GMOhk+O8ZPcHlrr3yZ1xJebzidsKDduXfsXpXsB3H+rKJ1aSMUZiRLYAhN9R3+1ye+9txS+Xa8iA2hP1+WR6WlqNDH+U4XvbA98pzaIiLnnv0zG8CvsqfUzLLoOcL/EXI7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973803; c=relaxed/simple;
	bh=4UUbDKvfJnySqHMPn8srcX5wl+pBd5iFYc+gAGYdNuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGvQJHRv6bQ9pM7L3Oem/KnH5rRm7XjoAcDMyYbK8+PHVjwUVJoWM/EkFnQNzDM8LOukvPj0/pTBhaA2YERoErlaPIYixphcL2SMF96Cp5qK/6eTTyXtJn36HVGso06rTYmILiqNExo37OCx4pbX7q74x1u76XVEtLHmaMCknqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NaxEUkm7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YKR/TbPT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NaxEUkm7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YKR/TbPT"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCDA1M3186026
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 12:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4UUbDKvfJnySqHMPn8srcX5wl+pBd5iFYc+gAGYdNuM=; b=NaxEUkm7JpyfreOy
	SGOcK8Qn//pAVifi528kz2lmMbR0aFu+8OkQ0NGNiE+cAK/aS5PgoZ3UCL0ou5BP
	YWBNCUfXdARzNfvCYE6bvlhwUMjxjxT/0tDPLozEzGgeVZkLjjd0/J3Qgb6i+J+e
	eBA8OEgR7eCyjBh6z7M9uV+68zZuaG6reyvcQ13QxFbl+MJ21ADw3XCNe3KycOsh
	Xi/ixuGJYwQBVegd4u5w2pFan5GrJ0N7lk/h+/SlgqCGchtAd8kc9WBB7EmeiQ0p
	ILgDmGlRGoMoMxnlkNKSegCDh7MHS2P/EP7DvSJI406GVNvna9ktka6dem2eEKUt
	WtrTUQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3j39hxyy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 12:16:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f34b9ab702so2947531cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 04:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765973796; x=1766578596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4UUbDKvfJnySqHMPn8srcX5wl+pBd5iFYc+gAGYdNuM=;
        b=YKR/TbPT5g+b7qjCASJJXBzC6m7f0L8w9yZCqs6R10NJwe2s4mcV4NTYZb1LhVwqhy
         O4CVEF5ZQTZhVSTu0WAElTv1fd5Y0MxZsI8AIWWQuJwvv9HHRci/9VyEfLrI23nPF/4U
         zqKEbvQ84+ZQk1hVSz9X1UUplKaPSyClm8vtnpyiYCxCe1+zHUmGXnkuakCJ0b2OAR7G
         WakglWcc9UOB1zZoTDnAutGugBqpqBpXsCdOz9Wf/FER8ebzorSaszgirzNq990m0Na8
         SVw4d9x8qi0Z+/ygJTlhoN2k2UvrwyOKWLZLNvwuBdJFkFywAxQlFDfiprB1v/ny+sRe
         SG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765973796; x=1766578596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UUbDKvfJnySqHMPn8srcX5wl+pBd5iFYc+gAGYdNuM=;
        b=u4nVmwXqMK/j+pQlLZ7atEXvJnN9l+Iz578ITxb2fcdS80uRWiFXNglh51DFfwFeSg
         PYzYEAixz3AjdPadCZcyEqE7OiBPbwC7c0CebID69H1VIGwW+uiYNY1yk6vknUXZ0mAy
         rmrh2qZ4lB4gBt9wkaKBpnRue12ogUc8GKDYhReoUDjJgvg3iM0d5Tb6oui6jVcYEPdN
         /7qFisON0Ia314luuL18NHlk3t0KUPjmjvLo7UshsXlCx3zDbj9qQi5yGnX7aEkCwlnL
         CApolRxFfKmTHKEF0rGXy4zT/MOxYzvnshezDkjnVzNaQQ5Hke5yo4EcyX/F5xpAlSP7
         bBaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaNccnGtnCMWbnQf9vlHsT+kThvJPCRCe2M1nZsOWzFY+bLmTP9+7fe1I39aUUStxTCevfp1T/9fOVK8cA6fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqWkC5yPlXdA7DYcDsmG29DlZWMCEbTko2oLP3Dy/ngzeDy56D
	dEJtKrtGFzMua0Uv1N2oyCmbFElYLdT2AOFRo7MA+IozEuQpv/trgemwmEzcZmiZiKV64K4rtIj
	/3oyKDBYpI9JSebcAb4M3JsC8ariDTrnHD36w8HhY5F1pSL1NndN9r2V+94ElD22TgfGgcLA=
X-Gm-Gg: AY/fxX7yVuMgId3Xge6wHGjPG/b/c4Bm0KzgGE1BilQlAix7q7TW3q8fWFwMAyUihZH
	HGtXqYlXvyJUEOF7WCF4dNh8+sT2uxRMlsMllSh4vjWUNM1seHGN6QyqMKiKzB7JndPaYiLx8+I
	N0ZIZAihSuiIim3pjKToR1/t9H77GNgasppg7rS0m4oOiolFPwXzavLOg1GOgR8y3JTXU2/JK81
	Ellj3oqyW9CWNU+1htFW2dp4o1GmpQuyVlLMXiV4Pd2sxr+TqP4fy6mnMjipC4/taBnW4m9mIhA
	SZ7C+lBZOIlyv2XjMxs0JQ7QSVQbIc+NVHMRp0XYqrfql1NvdvfD8e5mHMvGAp4USjQk1yu9Cvp
	8GAROCuB7TbmYllMSaXcfh67CmI25KuZaNBxgvRKidcau95wI6xbz2Y0OWj5aPlh7+Q==
X-Received: by 2002:ac8:584a:0:b0:4d0:3985:e425 with SMTP id d75a77b69052e-4f1d05c4201mr187004041cf.7.1765973796313;
        Wed, 17 Dec 2025 04:16:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJN5acTOjObdEbmCvFz2ySx2Z/+Q93C7nsNct5e75/+BD6gdkMs45m+fLOQa4xV8/snhRMbg==
X-Received: by 2002:ac8:584a:0:b0:4d0:3985:e425 with SMTP id d75a77b69052e-4f1d05c4201mr187003851cf.7.1765973795908;
        Wed, 17 Dec 2025 04:16:35 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2ebafcsm1954317166b.28.2025.12.17.04.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 04:16:35 -0800 (PST)
Message-ID: <038ef14e-addb-42db-8b15-b62ddb2c1a07@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 13:16:33 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] DT: add bindings for QCC2072 Add DT compatible string
 "qcom,qcc2072-bt" to yaml file.
To: Vivek Kumar Sahu <vivesahu@qti.qualcomm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20251217112850.520572-1-vivesahu@qti.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251217112850.520572-1-vivesahu@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5NSBTYWx0ZWRfX3d0myZL1UHb4
 pC2VvZMAk/JtzmWM/L2lizn3ehpPtC5k0GrdMZD97QRdfzZ062h9IB/7jBIuzMFOAQSsKNpX+yd
 t1Jj78uBhFrRyudKZ49CFzi7mIbmVr0UAnAc1J9AaKokZ494jB7JH9VAOUI+LJjetRGRwjH2OFF
 mxyTTZDXFKvdYhWAg9oix4l/PPO0y+QW7LxzA7YJ6oe01cDpXHYTp2A2CcNfBk4sXGW9cf8Qv6C
 7IlJO4nhEjBlaRn8LpjSTsyAVrDAe07rdZ7tNAr0Rc9hZTTrDP7pUU1hxIu/z5DrQa0/ncx9WEv
 cpTgoGArPnOYMUgMFEzPJ+hIjFDrm1gJldZlLqVpFliYRwstgQdLFoe33u20FOUiC9QqG0LDSBz
 YiDikGIZ6FsDiNMeDqcDBJcGagl8DQ==
X-Proofpoint-ORIG-GUID: wHcNvibwFgwXPGvfvwqfNucABRF8CKhO
X-Proofpoint-GUID: wHcNvibwFgwXPGvfvwqfNucABRF8CKhO
X-Authority-Analysis: v=2.4 cv=ToXrRTXh c=1 sm=1 tr=0 ts=69429f24 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Gh5RWWm45Uqc4OsgibgA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170095

On 12/17/25 12:28 PM, Vivek Kumar Sahu wrote:
> Signed-off-by: Vivek Kumar Sahu <vivesahu@qti.qualcomm.com>
> ---

You made no effort to analyze the contents of the file, or what
a valid contribution would look like.

Please read go/upstream and check out the previous changes to
this file.

Konrad
