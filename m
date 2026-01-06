Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D60DD27E
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 03:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767668469; cv=none; b=I1dNgML7iSV8lrLvV/xv5II5Lhb8SCoVOPRI5Z7D/CntlxS2vGuwBdmK2/EFuV2Iey93AN5dPwbxkWkiSKn54BDibEL/aeAQQXGPfp2kVrDo021PBnlMkE71TEqn6gStKguxis6s4R1iJKBfAOzrurdx0MqiA9H8a4mSenOzWNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767668469; c=relaxed/simple;
	bh=smPrto0dCXTU+3kaSZgrDcLBBAxeO/3T2UDp09u0XQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yk/Y205+HeWtVFaxPhEijtZ/tcInW1bhxd9yvZ2fxTUrep6JUFytd5ZEEe+hgL1QM15NCnh5DiXjZxJkbh3tSmSxoGmeeHuU7GwlBjl99LJVUQuW+qQvwT20Yk58o29BfOMZdIkRReJsz/nTCP507GKGIYffQhu+J+6RFYjWQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fbupfaas; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GO0PPo22; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fbupfaas";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GO0PPo22"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nTAN2726647
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 03:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OC3u+tApLwVhM1BnYlD6UioY
	tGtVW9pTGK3uJ7VFS2U=; b=fbupfaasrHtJPHxnpsovIPiwnogTONEkjsQpb4DU
	lFsTUP07eVJNoWCp7W5yWDQ232jfxAj/recxppu+F29lPcSFWDF5OaBVLFBiII2+
	4o+bp7lnxADx2DspYbKx/XZBZMVZ7KNiUfZlfi9j0Dkda7kAjs4YbcEVHcDnjqb5
	zZXaj+LrHvnJs9ANlTOYw9ZtzbbZi3xc5KCgluINERDm9gGm/Av4gTRyUpwp+T7n
	RnEdHxs2Fwo7weSQPH90FhqJL4X8q50ebTOiiEcV/ZEtkiyZEoInXg/AROruprPk
	6obh0sXGEAS+4sgyTS54qSpAkyyxbGB1HkiWo3KWJfzGKQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgpn9rfv6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 03:01:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed69f9ce96so16648991cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 19:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767668464; x=1768273264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OC3u+tApLwVhM1BnYlD6UioYtGtVW9pTGK3uJ7VFS2U=;
        b=GO0PPo22us2WG3jpObhmsheQfSf9ejKuvt/aqAJmLZoJ1p1FgrxaZoEXgOXdOmhtbt
         Iu55IsW2zI6OheyMjBIdcOpyp5to03M3fWwRIa9/hFQCbIhqH/kgbGRZjSYuWdDi3lf+
         DoWCIguvKIBfycmX5E3qsQPlvYsm9Of9bP1PAGiyVirKOcI5WqDY3UMt1fApNDj7UWRx
         BmSEhvZylw1xoc8YHFk8FODlb+VHQYzTfhqyo/mghARmazieC2ilg+F/JetABbdIAiEj
         vmghQIRgpqKuzBIW6j4oOfNTTaLejw+6U2mTUW/R2t438wgWxbJn+4A6Rsa+FBSqVGhU
         LirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767668464; x=1768273264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OC3u+tApLwVhM1BnYlD6UioYtGtVW9pTGK3uJ7VFS2U=;
        b=cvv32ODCeEsoxZboXi+hfqIZ3mj5NxS9vsdqBv1fKc9DZJxQmT7hM2Z0h505xWrMaK
         EKEaPLte+zuxZ33NSSuc4KVKqnnSFXTzoe5M11YpW//JmGZW67wFNaNZS2BwSOl0PVya
         yxjCO0mu3s8rD/QhUoIgckwQIDBfVaeS2ci/gPf15X5oV7SUEEOtGRLOtm0A7cnkvcbV
         nuF1aSw3T0+7zu9IA+KLwiPkt6QzVLpvT+V6ajyhfeGdJZ/OjpCTzLiVdnCVqD2rerGW
         iBL2P33yzqxZG8ePkm+qAstTME3bexh5SmsD1cBYtKAF8HET9BwsYH2OXEC8lh+teTdK
         Nc1A==
X-Forwarded-Encrypted: i=1; AJvYcCVEQ73Q2olsWoy5oDj5jhZ1ZlHxipKMhFvMZvnXhEyo/Jr0sHsgnh0EXlhZzu+eORKfapD6PiUFpcf+Gfx003Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeC4nvCB/R0jI7BlNKaDCeuDcCrGcCkNukQwfPGC4NuvDMlqk6
	TwHDxcZelsXEc294N+yuTDQBxsWmXzIpX/MBWRyMqGm93TV4gPNDnHUWqAmXRJM+ETMNpUNM0zJ
	Pp9pZjYh4Lf0VBByprvUtP6zJLqjRMnoa6YMe+REFr0NxYaHy/uO1Wh9P5+sRFo7jHkAs6B0=
X-Gm-Gg: AY/fxX5XW/dFgJADJNLgCewJmFUhWbw0zNpL0DjYaRO1FAE5VJSZq2qgvSQa8GcM8wN
	FRB/qypbPz3R7N1iOd2OvQ2SUj6WJYwY589dAmcm0PdwjAWH45UiaKbGEEuaXaFmWEK3ImS3DYe
	uUcXnZJuYt4wcsSRHGPq+kWSZn4GGCIhiHt7cinrYInIlVyDQQSL7Y+eTWWb55883G2ARzgrbJR
	UeRXvtSfeYvc5TFf6cs3vehxQ+bZSsmfcpGRS5tnWwqiY7Hq3auM8/dmbKgN/iUC0IQhPhfVI57
	Lp2/JscbkcmY5bltMw3WSjeHuOBc5m+uSBnttMHFAWUoDdmaCnolcjEcj+ZlO+1ohu+KLl2QsFH
	kD4ITOu1JswvcD5eam1wo2t3SPPG70WEVrq1WkcKACpEN/QX8BjxBVUBaSinrwzmNEEEH6FKOCz
	PyKzBRLhlY5gPLZdM2AnJk8n8=
X-Received: by 2002:a05:622a:4d88:b0:4b6:24ba:dc6a with SMTP id d75a77b69052e-4ffa77b1dbamr22182521cf.38.1767668464244;
        Mon, 05 Jan 2026 19:01:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEobzTf2lPIangMEN0oHS3jpHzAtpeuUrTGa3tGnhhISVAAxziYc6vwUHpKV/mgzey2QUfvZg==
X-Received: by 2002:a05:622a:4d88:b0:4b6:24ba:dc6a with SMTP id d75a77b69052e-4ffa77b1dbamr22182221cf.38.1767668463829;
        Mon, 05 Jan 2026 19:01:03 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65d0da4dsm233154e87.41.2026.01.05.19.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 19:01:03 -0800 (PST)
Date: Tue, 6 Jan 2026 05:01:01 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v8 1/2] Bluetooth: btqca: move WCN7850 workaround to the
 caller
Message-ID: <5kflcsvtxpd4qz3nogck7xo6sj4brvnp6t2gg72sjc4x3bwm6c@z3x2gdnwb3sz>
References: <20260106024806.480779-1-shuai.zhang@oss.qualcomm.com>
 <20260106024806.480779-2-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106024806.480779-2-shuai.zhang@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Pyx_lyeOEvxDxF-D38jhTBjnxHdXzO4K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAyNSBTYWx0ZWRfX2IeBnc3GjKjR
 2/X3O3KNnRqyiWQVXc+NhHn0ZG51TPAlPT6KfEHASZjLoLomz87TPfl72j1eKVDoXmmAdL17L3O
 7GAjeZFQOF8UWY1TvFhCj9IxxVE++E86+MnJRw+ZUxXbk26hW4grajRVP5jaPW1qdT7t9ugfym4
 EtrXH41LSZLEYge94WjQPzp0lOBCKkjZyv0hxFZJZeRN1u7TMxRQ1Z9g4Y+//mRFnS4V9fSv37s
 +mWtiB4YL/0r0y03sSnTHHIw4Ri7Sf6nHCFQo5MIsOurQwws3fxmqslab/cH9q/EZfybeu8vcwQ
 ml+dUjGVkW6HLL/3O2ER++/P8ER8VMZiwamkrZgqhbPRtUsgQAU7BHS2gf0SFKi0ZkTQwA3AdwR
 Qsi86XhFemmZuMu2xBoGx7E56hcNBZyGD27PRqwTliyPLge02DzVw3GPikSOdRFCbdY/EEJ7pER
 t2T6eHlNxyKUkd5rOoQ==
X-Proofpoint-GUID: Pyx_lyeOEvxDxF-D38jhTBjnxHdXzO4K
X-Authority-Analysis: v=2.4 cv=KfnfcAYD c=1 sm=1 tr=0 ts=695c7af0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=YWdG3P-n8oS0mWOsiswA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060025

On Tue, Jan 06, 2026 at 10:48:05AM +0800, Shuai Zhang wrote:
> WCN7850 will first attempt to use ELF_TYPE_PATCH,
> and if that fails, it will fall back to TLV_TYPE_PATCH.
> 
> To code uniformity, move WCN7850 workaround to the caller.
> 
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
> 

Oh, you have ignored the tags for both patches. Why?

-- 
With best wishes
Dmitry
