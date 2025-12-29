Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A3A1D90DF
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Dec 2025 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767013362; cv=none; b=UaCUdcfa5Yf0/XZPKKReNVxEuBqo8+Pk2cneOQXBCj5/teCG6zll/oIqusgwNi7bm1YFNUHcCT6yyCojwMX8ltPuJ7a7KUCIFFX/BF1d7P4++u2mvZP8SvoFY5hnerff3ASfUNwKD2AVsSiYR0km/g7YxhwyVLxnaJzZ+upvtVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767013362; c=relaxed/simple;
	bh=CVt2FGC14gyUkk0IVe2HRnTfwU5NYRnTMlH/k451/XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ec4hLSpjApXmpIKTq+dEmGmzHArefVqMBee2qm1e4IQGeExbOAv3L/QX1cO78hrgf5diR0ygtDqfG2Nj0LstggaohtUSu7zUuqK6qGrfEp2WBuRGyb73Ou1rr3cX0jMjNFLzaCSeKgPiKc77ninmW9oRe7UFzU44ehJj8+neZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WVEyHRME; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iGRtWQez; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WVEyHRME";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iGRtWQez"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BTA4t1G3370169
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Dec 2025 13:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KGUgj+Kn9KCJ7M8hH8ssNXe59EoU7BgwRO3/h5NqzOY=; b=WVEyHRMEFASVbix4
	tUsPe+V23uIRD/EAUl9BWrvfCzMCGsUQEQZmDYUcDMpBjwP5YO44EWHa8HiTr/dD
	+Xj1JlhW/BxhlAaXKPnEgAZkh9jIujJMxf2ajl6na4PURSTER+EWcnZ9uB45ORsV
	wULhz8aY9p2rEJUHFEJmOoIBhn6mbj1YBhFY37LRx7F6AA9zgxatqtyVp/3UBAXN
	iyGYqR26gUaPzNQU+242oPlb0QQcRTzQWref7lsbV6rh+VxKiCYzGihX6VnuaUgU
	SFME+INiQ6hWjl/iEwoBblSI6hP28ZoaTFNFoDcBv4dq949fvAQpGpx6IuPhE1wS
	pY1wOw==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba4tnvjv2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Dec 2025 13:02:38 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-645527c5474so2203699d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Dec 2025 05:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767013358; x=1767618158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGUgj+Kn9KCJ7M8hH8ssNXe59EoU7BgwRO3/h5NqzOY=;
        b=iGRtWQezu2v07vuXWKFNOH22oL2Y29NwFSmkoVC8eO7MpXxlsPWeh1zLB16EvsJCcg
         62FSQYZUIhLKqrDjBtzii9x/pCUL1BK6X4ii9+P5+RKXllCa7uZRfz8/IzkicGY4rgeO
         z9OJTRsjsHaKLR+TGMt5NmW3MCIs58RAt+j4+spGNlTX02UJrnCj+7bB92egkncIpKXb
         SJlyLY6iyBqNDr7HNk7FZt/w3zc9LkcD+gwDJz+KSq8QHaENr3dL7QRsUJSfa1MhaSmq
         9xcErG0zk18R0KUBCUY//m3YQJZTbvDHf5u3tsGc+pdCH8lc39M2uKcJNWuv8AVdyMqo
         5T6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767013358; x=1767618158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGUgj+Kn9KCJ7M8hH8ssNXe59EoU7BgwRO3/h5NqzOY=;
        b=IwKOugjVQBQfOKRhqMpaGZxPjn3EVDoGLHLqc81zv/t89AY+WakBddG8mhjZobmahB
         KEP/tk2LRE7iXPxOCyeVDjLpMrmfJMyevR6RrkgcH2sDRyTD5o23QDKcN8LdND9tA3Hy
         xTVKRge2TRf4BCv8yIZ2Yh7N8gCl7MFY0NtK+3o6d0G2taQ8YuhKR0fyL6YHDM9AgJd5
         JbiNn5mRid7eRHYCePL658tWo86IlUpnIHOoCPmj8G0tn2HvR3MZYdM+Vm1foyE2rj+7
         9R9zC2U0nIhRi90uC8eLZqFFIyC+us8Mbt1y9757VijwZF2AQhpdTzlstHXf5zaiOqMH
         7GfQ==
X-Gm-Message-State: AOJu0Yx773ANsxDpmdqcJ+DKP9xfqzaoFakqy3aLRLgvEOi0ZhruGIwP
	DY/tksLkcrPm/kkDc6MOukA5fPk19GSGmOmwmKga0nhFQCaNMhUusU3o6ZjMBEv5vvVg5FwcCmk
	tD4EIQSQj9g4506gbYUaW2qhi5goF0f7J2Vdbb+YyHIMajA4y77OnzC5R1gJFWFNQVl4Sg6w=
X-Gm-Gg: AY/fxX7mBmKnKYoYx90icjAV/o/l7nMQPQ+GPkv3JmJYOT4cYlXj276BwcimW1YGA3O
	BeL2oxo8cVt16o2RnwcylQKvFap3SA8vyDAL3MVsY/6/WmZ56sxVTOPoSAQc7eXuDEt5gNDOBIo
	R2b816z15YrPDK0yLmMnViV9ycO0cCSoX7Qt7YlSbYLWFK0FC45y4k8fKoyRgNwyuj5pnod/dHx
	Ex+qeNARD+sXDg9oS2+3xcuMhnw8SbZAqUVLMb+2er1DvVF98zGH+2l6zt1G1LBA3+FmnsoxKD3
	xzwJVJEDMmSUR/DRZwbC0DMOz1x4c5gmZkGfcasof+toXyQwikxST3uUwpv+TgCx2oZkIQuciPJ
	uYNwX5RcDmZC+xzE4Yohb2XFE+dpjv6yl5fe4vCtmew31oC22f/4XJCXRzgt7QuvFBQ==
X-Received: by 2002:a05:690c:dc7:b0:78f:d300:1ba7 with SMTP id 00721157ae682-78fd3002314mr177536677b3.3.1767013357519;
        Mon, 29 Dec 2025 05:02:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJv/cJRIcfHWOehcWwgeznXBqqokkgxA15J4TrsYpAXURJ0KC16Heb7NVu2F1k6ufWr45YOg==
X-Received: by 2002:a05:690c:dc7:b0:78f:d300:1ba7 with SMTP id 00721157ae682-78fd3002314mr177536387b3.3.1767013357182;
        Mon, 29 Dec 2025 05:02:37 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ad1e6dsm3369708766b.21.2025.12.29.05.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 05:02:36 -0800 (PST)
Message-ID: <c39224af-f228-41f6-abd1-bbc79b970028@oss.qualcomm.com>
Date: Mon, 29 Dec 2025 14:02:34 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] FROMLIST: driver: bluetooth: hci_qca: Always perform
 cleanup on every setup failure
To: jinwli <jinwang.li@oss.qualcomm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20251222123824.3000167-1-jinwang.li@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251222123824.3000167-1-jinwang.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G+YR0tk5 c=1 sm=1 tr=0 ts=69527bee cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=NCdfTAm3FWQDpeI5H1gA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-GUID: FuhRT6lK_gob1MixPXbFrROg07eiiqYT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDEyMSBTYWx0ZWRfX2tPZfy+YEkDu
 bAksDYwcfgdiQRFlCZwtcxOUfmj90YxG2Qz8mMSRM1eW5uAeSgEdCuLu9EuQizInXyvLiyOrEch
 FXnaxIu1Gj5Zp2z5MdntkSbiMeksSIs4/lNn+nWPBjyjsF6S7cKec1mzXW/N1sh/8VVf8/nDJLL
 g1Atios9hNANrUSJ8g2o3BhEhSaWXqszC6DIXhIQai9ip0vdihLSOARkmu6InoOmU7mcb27bG8T
 kje4KU2MmuUBhy4h4nxiTeuURmzwIHPXv3FGKCNXw9gj4/gsmtriWF+nfEtDAT78AWPaNjBs4JJ
 4drO3w/Aha+Y/U1EaRXjPA3KmcrwcsmLxCFhDVeOXRHELNEAzJQLLYyNFVaG61NLFPM5o9IqscB
 9hxHPZaLuE9QVsxO4x2fELPqihtG+AnUUQfLSohtrOtIdA5FLGHYMpnz2u0MpPAs24WnH5BfObT
 g8PcOU+5KkqaEOZP5MA==
X-Proofpoint-ORIG-GUID: FuhRT6lK_gob1MixPXbFrROg07eiiqYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_04,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512290121

On 12/22/25 1:38 PM, jinwli wrote:
> The retry logic in qca_setup combined error handling and
> retry gating under a single condition. This caused the final failed
> attempt (when retries reached MAX_INIT_RETRIES) to return without
> performing cleanup.
> 
> So only jumping to retry when there is a error and retries have not
> reached MAX_INIT_RETRIES.
> 
> Signed-off-by: jinwli <jinwang.li@oss.qualcomm.com>

Please fix your git name (unless that is how you actually write your name)

Why the 'FROMLIST:' in the title? It seems like you're the first submitter:

https://lore.kernel.org/all/?q=Always+perform+cleanup+on+every+setup+failure

Konrad
