Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80136478846
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036907; cv=none; b=taFt0bXfLN6jcHHq8I7fmShsBB3RR7PuFOhF/2GjK7+l8wbqu+5960sRsBThdCLz7hX2Eh+IzTSvnSEfwkX6dcC0t4wGqN7R/sBNS4rpZPwTGxob7mORihvWP+dqzhr9sb2KATKLkpSOIEtyuHINgPZTt29mFAhBernjMse1HqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036907; c=relaxed/simple;
	bh=/wE47tHx3aKn2MTkn9nYdI0y7clxrmOyavMLuXbTuBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uc0ldd1FrXMCyHwqrijKOBk+qd0ibx5hK7doxELoXTcKkJXvYbajghaqFxbhAbMBQm0B4/FOfQB+n1qE5a2pgrYWU+5w7Ewkfgt25v2x13e3u1tTyOfY23dq0l2X6X+3ZuOsTAVggyjTxSyRuqcpstcGhzIj2DK9XvWD8pA0faM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ThANVumK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HNZlxQRQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ThANVumK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HNZlxQRQ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBNrk4377281
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 13:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	chqKibaeCI1dGhNoDz95Zlo/hvuVQqKnNG+MSugrEmQ=; b=ThANVumKb8p0DdzW
	6g0BXZa0QC7V5C7jniRweHJm8TPlmadQNO7mKewjflb9CPT1Ae8Pi4TBNthsaEIG
	gu+CSVQTlAKSv/gK4SU2abVXgnkxQqdfFp2omsXN1o5nUcIBtP3rDciw7VJepc3A
	qEpXPm07nD3hxPbHQt87vOKRuhH8zCVNgzvNzMezHhxk5bznEm2yejCyayjfeICH
	urAi1UWXvdFcJNF4DQJfvS2yTVAidCmmBMC8D7MysjmZs7m+zL7j8qHtqwesgmvc
	ktc+/XwtmlfZkZWwvYh69tMvntvUzl4GN1btjCyFGxpgLrxOwZRsFsS57x2gQqZy
	SRD2TQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdbr4ak26-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 13:48:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cca0ed258cso19058035ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 06:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784036904; x=1784641704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=chqKibaeCI1dGhNoDz95Zlo/hvuVQqKnNG+MSugrEmQ=;
        b=HNZlxQRQefgEMWNn+O812Tjj7NcVE4hSQpbdK/I3a8kGw8pVUlVOo1e/SxTESuyuFr
         usMvoHTf5KXvC3otbms8yfq6ypM561UxFY6cxGRXuYjtBhm/p313YeJ2lMe3gSZNqUH5
         CZR7XKqlJYC5XLxVLX2G3rMEwbaD7EWq1awDGxbyzO+TY9wGGiwRbVxfoeLqmECrExKl
         NEXTox0yC+HCChOninKLaw+Rvdl5RLGbR59N5wqkXPMuqeAj1iDQjj6GuRNu6HdNqF/G
         Zsvs9Q99OCMq+UFvOU8iLXL8VrKCeHag8TmAf8A1lZILLgby6aNZ5ZAlx64gH9dD6pfx
         0Z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784036904; x=1784641704;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=chqKibaeCI1dGhNoDz95Zlo/hvuVQqKnNG+MSugrEmQ=;
        b=lqikha1gASw28gEJ6R6tyuO3ePOb9JmmrrxhsH3tc4bDph9evVHAyAfzENa3THhFDm
         G6A81qkQP7Ui1T68bHwJVarN/kLhyiD19f6uFbhs1XQqmxstrq6R2J/tG6ZvzzUy5Rpm
         oHYB7z+8fq4lwZalg2XmObO9h1lrS7JkuiZMoiBdX25Avy9j0XON+Ydf2aQuirgzkEJp
         AkMV5UI5qbcRDWGLaGYxngO3DRxf/S+tFuwmB6MBhunNeSsM2yXa1bBrIQ57HanWHuGy
         OiFS11MqXsoTeRrbGH3RpppTu7Dr8oUsgpk+eC2VooebRo4Fms4VMcjLhafPdJbLqgCb
         yoVA==
X-Forwarded-Encrypted: i=1; AHgh+RoSKru/+BcxqGJYH8l5V2u4cENPlKeoJQCycoKBLFJq9j8FrTTfzTc2GunKPOLfFtj39Yrj5WJIbf6cvOHrUMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA7NSI67YmvZdRVDxxlZLxxATb+t0GIQaHdwIpiLoBpkH9j+VQ
	XnVjDlFofMQSAqxFl3TnHnmWOwenwdwl4Zv+q4MOv+r0bgMPP8UrRywvXdgq5ffkuT1y5apP1Op
	ITQqiKdYvSHHVGmOCH5OyjDpGsmRBiOMGeCRo7rkgXgJ/zlx7b26OrVobyrvaAXEwsy1wmJg=
X-Gm-Gg: AfdE7ckXTaVEAj6CuW3lsCWvmfdktmMDwEKioL17j6v5ecp3Q55qi6yi5sgNoyx9Igv
	qWqxYwlFbb5Vw1OWGTJmvHlK2pkUisLcYKMCP6EwJBeyRGoGhR5H2s+xxtxOgPTBSFeh/PTyVfP
	HYFIvr/QJRGf0HhdOd/2Ri+H7moqlGwIs3P8ueOfrmMDxwF12oGgJunOwSjC3GwhHE+KGa5XGvX
	htAoV2SW3ClZdxGwwPTF0XPWkNgMlYpjN+xznkd8DmHXaR7WfF1TsqN0aygtuHM9oxbzpw4Hlvn
	TrHSBrkQ2NnNSQLbqpGLqyZ9MmZxerHXDt3R1mevV8f/tP/C6rEXW8CbfB75XvFOC6ZlWUEY84t
	ECkT6DtHBTx9IXcbsgsh3tAlFcjaga4ytzBVdMTUQZ07CzwWIad8YQP7FkRU8Ut1Usutt/xMgjy
	s=
X-Received: by 2002:a05:6a21:a344:b0:3b4:895f:6abf with SMTP id adf61e73a8af0-3c110a23efemr10499628637.3.1784036904170;
        Tue, 14 Jul 2026 06:48:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:a344:b0:3b4:895f:6abf with SMTP id adf61e73a8af0-3c110a23efemr10499587637.3.1784036903570;
        Tue, 14 Jul 2026 06:48:23 -0700 (PDT)
Received: from [10.133.33.8] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3162b59sm9829275a12.16.2026.07.14.06.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 06:48:23 -0700 (PDT)
Message-ID: <3d681f10-959e-4d0e-99e5-a471ef8929a3@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 21:48:20 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add support for Qualcomm QCC2072
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
References: <20260713-btusb_qcom-v1-1-39cabc0dd601@oss.qualcomm.com>
 <CABBYNZJpdeoZ16bObLRPhng2dfyNeK9ix9_-z_hMZhJ0QxTxGg@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZJpdeoZ16bObLRPhng2dfyNeK9ix9_-z_hMZhJ0QxTxGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8K8ZgXHFRJKx1usmKVrksNUWaWWtQMSE
X-Proofpoint-ORIG-GUID: 8K8ZgXHFRJKx1usmKVrksNUWaWWtQMSE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE0NCBTYWx0ZWRfX7u7TkZCocu2y
 KHEMQuiGiXcnNJSvxvAxeBdJnJZjWoG42Huljl4X8/UVw9dGT+BvDIaDX8kFpx6fB+qtt2jeLOg
 Xz/8mIHnCAJP0kQRCC1dEFvuOBAE9mCnR3hRQGLgcM9RNVNB/wAu5SHUm2ZHoZ96pk9x7XWgG1a
 D+BKtic1wcbX2SaPMy+MJ7rtR3woT++T9IavUmvfsMG/QEXwv37DVpT3di5CsdwWHC1MCOMpEfV
 sCOLkPi1KaAwNCwPcM0yqt/tgtyrfm/bWgI5fbarM2Ok/xllTJLAZfzqYcS2A8vGEnnet5WXr6H
 UA+IeQEyooY3BycCH8pZiY2px0iTqitCEbrHQR95IGz0vJU5PzOxNW9dksCGwIoCVqxc5hRTDoz
 3Ol6baLv8dIHjG2tBBbpYu0K67oy9jSPm9fgq7m7TmEVYtdubX+5a23QZR+HE4Zp06xtWoZlcJm
 ha5rm3Qc1MXSukEybuA==
X-Authority-Analysis: v=2.4 cv=F5hnsKhN c=1 sm=1 tr=0 ts=6a563e29 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=QYaiAvbqNJ8jCOfhceIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE0NCBTYWx0ZWRfX+YCkOeMjN47S
 H34FpFJrTA5RhSuWFAsoHsLY/6g3ZE/Yh2XsMu2dxQyJYYCUduvogewfscBn4BQbZmLWFYQDmRR
 yRTpshzbEFpLbzXenlh+0zQ5IJ2GczU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140144

On 7/14/2026 4:45 AM, Luiz Augusto von Dentz wrote:
>> To avoid adding large vendor-specific code into the BTUSB main
>> file, add btusb_qcom.c/.h to support multi-subsystem BT chips.
> Ok, so this is not the first time we are seeing the driver want to
> have it own processing of HCI traffic, but instead of doing post host
> processing it is doing pre host, which creates quite a few issues
> since 1. you can use safer skb helper like skb_pull_data and 2.
> requires to do HCI processing of traffic not meant to the driver,
> besides not being able to use something like struct hci_ev table that
> would help to avoid having the same bugs we fixed over the years.
> 
> So what we might have to do is some way to for drivers to register
> their own event table, provided they don't conflict with the host, or
> if it just HCI_EV_VENDOR then perhaps that can be done with just
> hci->vendor_ev callback.

  Hi Luiz,

  Thank you for the advice. Let me clarify the design:

A.  Why pre-host processing?

  QCC2072's endpoints carry non-BT frames (PERI event and PERI ACL) alongside BT frames. btusb_qcom.c must first reassemble the raw byte stream into
  complete frames — of either kind. Once assembled, non-BT frames are intercepted and handled locally; BT frames are passed up to the stack untouched.

B.  What to do with non-BT frames

  There are two options:
  1. Don't let them reach the host stack at all, or
  2. Route them through the stack by an opaque channel such as HCI_VENDOR_PKT — defined by the stack but with no implementation yet.

C.  Why not skb_pull_data() for non-BT frames

  We want to preserve and log the complete frame for diagnostics, so we deliberately avoid skb_pull_data().

  
We'll also look into leveraging hci_ev table for non-BT frame handling in v2.


