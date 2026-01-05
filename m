Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039732E7165
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 22:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767651732; cv=none; b=ZZCBC81oArnN9pog8GZaeDrC2M8QLq98B5pQW58NV8y6IC8JDnvjTqQh81SBKYddEGBLLY01XxY8bBhCgUVJ+APXHY2FKlB81e2zroUW9V39nncBHINYc/ZDWn2CPmbGOaD/I7JQsA+PWaOEwpQcsO7ii0s+W9KaLexEsvrQmZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767651732; c=relaxed/simple;
	bh=xFoS8BL21Vsohu56kpdrQ86rs7COkNPQ81kIF8XOQ/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhmYY6MITIlWj1WH5PL5tGeK7G74QuiRfp5pFKEHHNV5vVYO5++z5CVoFRF92NzRvhMKTnhT8d+i/bAIzfiAxEsdXtFuOX7VcyWaktfoatAVtKiLAui/r+AHXTzRuY0Ud7HBnIXu0GKSi6akNQsH8OGmDuC6Q9xr5OZiXWBKJlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CQ2RmKM1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O0lHbm3+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CQ2RmKM1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O0lHbm3+"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605FKbwK1751529
	for <linux-bluetooth@vger.kernel.org>; Mon, 5 Jan 2026 22:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xlK1yGtAMRQCU4TTQJuWdRbB
	b6vuez75Pa3TFUS9pgU=; b=CQ2RmKM1EZGjndyKkaQ2jVesP+XMnViQ0RnUVym1
	R+KZ7W0yzOFuVvUx/r7oCUg8btFxKlB0pYRHtpHEfRXqh24PBcrOin6Wir1abyle
	M++8zw7ZArLgO1VGXQMGTjBd5jkhnMjzfvSIr86FkV0kKNeC1vqfegz975tP3DIu
	BuG+/Zlrq3smQm60Y1xl5Q8LjyxUrab96IgJjHSi8XYtyjZ/7JGetJQrAbeTQ5pf
	wRyYhu9q63AkNbNc0dpzh2HzM4FZwgXGyR5yqwVCGFSfDYwk18X1nGXRR+Jti94Y
	7sv3FdUI9Ja2PWoqEkE7zrbMKi2yflwMJmQ2cDus31rakA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgfv015cf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 22:22:10 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4edb6a94873so6703991cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 14:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767651729; x=1768256529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xlK1yGtAMRQCU4TTQJuWdRbBb6vuez75Pa3TFUS9pgU=;
        b=O0lHbm3+7pxJXL1Nrxm1l5ZJR6Az4Wje6dpeK+azciam1zEs1FVuJAyswbaY+RIMiY
         w/DN8YFsRn0JkyGnYmJhU8pVeTnoSQdZ2VH5lssT4dzoo0nkJzlJObIl6nHDNQP/aJIV
         efwnXnclGOkhgcnSLO4nfTHnaHnzKXO4AgoDc56WrUJCFQHIViwNya7J88ILdqT/fYlP
         6VMqoknpSQ4jPi6/eMc5cCHSkUr4XlnAUjj/PbQc7DdoM983IyHH1D9mf6cvSZwS0OVG
         sLyuq+bk1dP9nmgEtDM3GOqsl0ip3RitdzzUPvlLgMM7vLUkJPC3kvH1V+07u8wkGs4v
         bTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767651729; x=1768256529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlK1yGtAMRQCU4TTQJuWdRbBb6vuez75Pa3TFUS9pgU=;
        b=SA1Tq96cpXUD0bmj9Zq0ZEbOeOzC4bgX6VVB06Np9zo2sfO3HyX4ctbPGyO5nLzqh3
         YkWOmZQVV73by1rx8ose7pbMHlvA75na/g+F0YZcubyQ97eIe168SXsp6bx7vAHLGz4b
         U8fmEfj7Dc6mLtqnpL6fWDneU1TZlRgedagLmLuTleDaJj3h6VVAVMKPeDkCwKwyxv71
         5Nioqc4sHGWgTQtaSqT1B7piaPYqMycCFHIDF4VP8I3q2JxzwYaJO2GH8PYRE0ppXjI2
         38R66EScG+SGOicrFA4uzJo7muYmPLxbhALdHLwkkaO67PLt/Qcxi4T7F5dtMXqHhnCK
         9PEw==
X-Forwarded-Encrypted: i=1; AJvYcCWd1qYCn3iTom9j+zCSB1how8y5O7+jRnsZk2Vsm3D7J718AiXHPo/O75pNlQxcRz24T3RoYNqspweEZdFivvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUcSrL2gomekVdO7qHxLITPrHGa3l3G3Xh+HAntfWtTfxyHQeR
	/nXXvczpja064Lb145OqFpqDtlaol2hTnotAylnAY/+8RcVpj58x3jRjHH5KSKohWu20tQ0Cu8P
	D/0OHluGPXTrnq0otzl4/0SsmdL0gP9A1DKW+ZMBU4mWMEfZta/lQ8IwFTo9qbcx6g0M6HOM=
X-Gm-Gg: AY/fxX47PUwHU8aUuXrbArs9HkBOF3+DjjgTgE8uojCfr0k6Ww1qkOC95R7n64ltzfq
	Ta3AWRMlpSr4wn7WJNZkvYCU8IKUNnkM0CfAUiYI6+ZwV7ywDLC8acvzw5YIUZRNmHzg6or+o/9
	BS461llM4cCH1Mkm9CA3ok+vJvSG/17FzRSa3aIvoO2ugB4fpxaSujAYvFhXS/zCWo/AVPRqSC/
	WG+lVEIWTYcB3yD4QsG4wBxCgyM/1hI9TF36H6rEx5A9l1ClWMWkaaOUcqf4NnHSP4o5VDyeaQC
	1nHQFr9iaJYXIbdtnUG9zIq9ak3S2aALiM9yHS2neBX+bLeyP0lMGHpTSujCkHy18rhux2ztfRe
	TafpH+iQpEshDjBOCUcSxf7KuOWHQxM+SJEjg/IJRoT7bJryh3piAuw9eAYgNjxPxtamnSH0edk
	8zDbIdM/+lthC/60GDCL5uUro=
X-Received: by 2002:a05:622a:5a15:b0:4ec:b599:2879 with SMTP id d75a77b69052e-4ffa78045b5mr14148541cf.66.1767651729008;
        Mon, 05 Jan 2026 14:22:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLfqYUHuuDhotEDrmSjd0PzwXZGTJ14WL7d3bG5GF/R2Vef9UMGOE2HKXO71V6BSrn8KHciw==
X-Received: by 2002:a05:622a:5a15:b0:4ec:b599:2879 with SMTP id d75a77b69052e-4ffa78045b5mr14148341cf.66.1767651728589;
        Mon, 05 Jan 2026 14:22:08 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb8ae562sm938841fa.26.2026.01.05.14.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 14:22:07 -0800 (PST)
Date: Tue, 6 Jan 2026 00:22:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v3 1/1] Bluetooth: hci_qca: Cleanup on all setup failures
Message-ID: <qymmgw7oteikzceh3kyr664idl3asfqz67c6ibgpjruet4leje@e6xq3ov4gsag>
References: <20260105141427.196411-1-jinwang.li@oss.qualcomm.com>
 <20260105141427.196411-2-jinwang.li@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105141427.196411-2-jinwang.li@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=e9YLiKp/ c=1 sm=1 tr=0 ts=695c3992 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=j7vk0x6oEzrLbjgpdhAA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Xlz2qFLo_9fqfndhF8SMSR8VbX9Gsd-R
X-Proofpoint-ORIG-GUID: Xlz2qFLo_9fqfndhF8SMSR8VbX9Gsd-R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDE5NSBTYWx0ZWRfXx4iyK7jZkvQo
 3ndngsqPyap8HjYriMGY6cWVQBlgVL1lhlbQvusO8DyNu0GqzKqjx6SljcZEMNjaAnb/9y5mEM0
 9U5zm/VA1t2rY9NBfLkCUe/iZBR24y6FMnStQlpFvP61GTu1qkxXlWc4dudnZVNKD/cpVgKqTnV
 C73gjUmNxMo9PXRIr0d0UPw0JawTU64tsLpsGCcPKBuAQ0cA8DD0eYko7ehAZJK2Oc2H5Xm1UYF
 4sQiC4u9TU1JZ4vJxs+F7j0Wq3dUaIYySpz5a2q7tobdOVkH2k5MErfTdpcX4qnf7fu0Eb+eOwW
 n6claJsHeHPnta+MA5UYIKdYoUQ9yJHTLM6GJ6gFGgipPV5pVM9RND9Rln1ZBv9GvoyoZLIV1Nn
 Zgkc6J4Bagjbx/lGmAKEVACqK9FYWTqMQ4nNnGeKrqtxqA3Kf4FMj/bvel0qOT1dPWhhXnE38n2
 ybn5tBOe0Ch02m9Q/xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050195

On Mon, Jan 05, 2026 at 10:14:27PM +0800, Jinwang Li wrote:
> The setup process previously combined error handling and retry gating
> under one condition. As a result, the final failed attempt exited
> without performing cleanup.
> 
> Update the failure path to always perform power and port cleanup on
> setup failure, and reopen the port only when retrying.
> 
> Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>

Fixes?

> ---
>  drivers/bluetooth/hci_qca.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 

-- 
With best wishes
Dmitry
