Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADD63DAAAB
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789403678; cv=none; b=mnHY4LOH7U0+Sy78x2riqPo2DfWXiAC0xpTfpDD0ugwoF/r+v0liYuOwgO/3tljva5HxqPNbrBx6/+f4Slo5ztbOmXja1RmDE85kxPhDnMtCCgLVXEcNf7XPhTr2FJPgpfZFQqNtt1Ncw2pEWPmCijgwEtil9wV9hwOw61Cijp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789403678; c=relaxed/simple;
	bh=wsPjLf4erG75POPC5Tzih1/0LmpF5rAW/u7DH/I6EuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6ORP/aGeSDoL+R8wiVt7eLO/roKfg4cUMNuX3FtftGLQyvA9w0xyL3D1Zca9exkdnnwLdjI8piHOBqC37QJ5IDQuibU6uN4XB515DvpObpe28FzNBSsWfdhZCEr/2Rq2+B3j1vOT1JP9R9IgdEwLvkHpAheYQtIXABE60vbX2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O1S9GLB+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UtS+eF6u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O1S9GLB+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UtS+eF6u"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0jcA135908
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 16:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5pxU/5l6A0Bab/y/7YnNiJxy/wwtfvfJ4udS7mKNrII=; b=O1S9GLB+CK2iB+LS
	oEhJhYnIYA+ckNkuAhPNpcfozZQqPtegK/yV2/C7IMdTB0ZxzolCmXIoBZbaYUyg
	+23qZLRnHLFOpRxh93kF0BHG0cH3qkpUIKbe50wFZaTuOBIRKfGhBCTB/XZAH9MP
	1Zk7uDZl7bnX7By331mi3d8Lwm2RJj+MN+CW3IeEZ23vkHUcPUnG1nXtasPjWdtj
	LjuKu7WrmHVQDNO+dyrAVVIU54mSH5qSgkGW2Msv9+Vz9zovrWavP/EWjphiY4tI
	kVWiU7Q8FLyp3u1LLkQbNoWvMsIotBpNouni/3Oqh1BzVsquegPbJjrbkNE8TrCU
	M7WG9g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeuq9m16-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 16:34:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-399315379fcso970196a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 09:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789403675; x=1790008475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pxU/5l6A0Bab/y/7YnNiJxy/wwtfvfJ4udS7mKNrII=;
        b=UtS+eF6uHQN/gSR2Z1jhbv62zXK4OWmhFhlqp3Lr/0nOSPYRXC8e39ShFXTUqFG2os
         jxyHcPf16E2uyUmJRKQ8ZJWKCx5PNHzGAh+CH6J2R/Sd6Pf7LEdihixGIHCXMopnOVJs
         u+bsSOXnJYWWswJeofE54C8+RHBQVaFzJQVXzbkA96jB9gruwW5AP31HjMUh8iLsm+cB
         6HrGQkNTIz82fJfscaZQLrj5w6hb7DybJPtGP9IoxzZWPVN1d5kklog9ZTgCT4IMIcF8
         HUiN6OxJ6PvIUQyDWYemSrHaFqpHq1OumO5xC+B7WgF5Jskog+6Q6Ei8UqCSxIKYZLjg
         X/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789403675; x=1790008475;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5pxU/5l6A0Bab/y/7YnNiJxy/wwtfvfJ4udS7mKNrII=;
        b=v7BdwIZLTRXkRii/cpkl1zqTA+2eR+YCtflUUuqbqYWrW57CEu20q+dPtZrAX3WgH+
         6WOZKU6iyHvW1RduQHXujUsZ5mJLgqxJggmARVfq2W3Vv9nfjBPyzq3TknYjVXP+2SD2
         RrTmxRvQQMzDFE5oJD51qR+4uSXRRgQOOs6iCO0QI8TEij5f4Q9oyXTKZGN9D9PLABOV
         8x/tu0GqKbqe3zlc4lbEvIdqC+Ss5Dt6/qA7JuFJOxsaN4LwXTBic4czyDGJ5j4qd7yP
         uvwmxxwMLR05lbRxBcA+CB0RpWfwGf9SSgkuRDe/32dSSZjuWNDJTc+hXrZOqbkM783W
         6JFA==
X-Forwarded-Encrypted: i=1; AKwUvBxd0OhOxo3dbdVpVXk9qQNBA8dBNBSDBAEVgjkB8fE1uwNSLUZNF0AnZgDsTUawOOCBbhqV4okWqM3eNzZn+7o=@vger.kernel.org
X-Gm-Message-State: AFuF++no2b0XKZdSI99cfQa1OdLw0pauW4eMmpwQX3shBguPHhuNxIa4
	8MkMU6m9tfs6lLdG/UT66NMiFOs5AMJHcyb/vlztDGDjsyGD0KLvBnUFUs9IpnHg07v7e4yED8o
	a8hKynQGvidh+H4Dl9lQgryEccfc0+50BrijTk4D7gvJQwMR7eHfzqwaDfDtA933Q1jL2eeQ=
X-Gm-Gg: AYBFou0ZhsuQHGwSPgay0RIeoE9f3awtaud9YzbEv3VdX6UmwmiWgTSGwn7WGEEzh3J
	qwFEY6xmwg2RD0UL5FYsxluZe2/P9iDV9gaWDkQxzuQGSZbr+MfITOnjz+3KLr+ZDCZ18Y6bMph
	b7/jgGJ5XLDcvS/SRkmZoARFmWzR6/Gq2idjEoS3pbAivP9CbTx5ca+MrZLIu37DT3M7KJwQAOR
	L106k7ITmLBonanw80eZQYzmS3CXWOaWyAH2/P8lFbgLUzZ/q2ypjFOFWgkDCD9JBKP5HEbayKQ
	wVFYhj2CXkkX57FnJtTBB2j/AvUNtsiAaHYVH7h5cT9vHigly56iOlXxBppGVlXvt4CVVP4EnuF
	VzpduzQ8E2dYV7HlR+64Cz0aUEdJUwui+Kk43w3l2eOH+dBViQBjq9ZjlmXmMbj/lqA==
X-Received: by 2002:a17:90b:390d:b0:396:d27b:86a4 with SMTP id 98e67ed59e1d1-39dec02ca06mr4689173a91.2.1789403675372;
        Mon, 14 Sep 2026 09:34:35 -0700 (PDT)
X-Received: by 2002:a17:90b:390d:b0:396:d27b:86a4 with SMTP id 98e67ed59e1d1-39dec02ca06mr4689138a91.2.1789403674876;
        Mon, 14 Sep 2026 09:34:34 -0700 (PDT)
Received: from [10.249.18.74] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd28acbsm240663a91.10.2026.09.14.09.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 09:34:34 -0700 (PDT)
Message-ID: <8511d685-b0e8-424d-b189-da35d18d3d02@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 00:34:30 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Bluetooth: coredump: Fix skb leak in
 hci_devcd_append() stub
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>, Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260913-misc_fix-v1-0-558c1e4028b9@oss.qualcomm.com>
 <20260913-misc_fix-v1-1-558c1e4028b9@oss.qualcomm.com>
 <CABBYNZ+ZUXkSO6ybT03vRCE_1Mwzm1hkbHqrndm2qL0mTLh0dg@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZ+ZUXkSO6ybT03vRCE_1Mwzm1hkbHqrndm2qL0mTLh0dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIzNyBTYWx0ZWRfX/Sk+DNeY1bwk
 teuN14oqNc/h19DKtK+pSxf24OmzXemjwkwkWheuaTSUnVtAlzPOym0KJJtm14+Kg+e3hy7PQJk
 CCyTjAQsTDQ361bqBDfKiIdkmdDJB82rr0bes4Da8ezLJxAHliS5GxLPTAPYrm7BteWk9Dx1e1n
 Cr7zqh6yKTsKgQxy7yIk/wKihYy2j0A8woLp2gYtDu2VcZ3VqtgG+qNP7xyn44EtEQezlal+Xv3
 viDqe58yuZR6laIEzhzgWtE6bC11sYO7XGFRp0EuFYTkxkSq/6yW8n+qHilCJ1U1APZ1XCjxDji
 jx287ygGnjsIwULDgjyytUHpwaD9ZWdvMV8OntOKvZu46Ye716xpL7LvoyoseU2VGK5G/bZd098
 VTkDsjyYrNzDKNCdbP40iK1vgzgnFK/UQRavuqPmVkfOXkXCJLYXlmZohforQK3KymvHwF1QjqA
 R9SwvL/eLmMg5moF0PQ==
X-Authority-Analysis: v=2.4 cv=TrFzFzXh c=1 sm=1 tr=0 ts=6aa8221c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=ppDuoXucZiPIag5SSHgA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 1rMTGPe2KUADmZ7VhlqROby0xndYTUuz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIzNyBTYWx0ZWRfX8NxhEiNyZL4D
 AYyupSjk15OXdKMVfO+iQ0s950AjyV/sf/sySOt9Iy0feUPhSQ6cJ49fAMMTtxhlxjWpJ0lX7v+
 GxAnNhgThtTy6KldTGoG1QjduKx43ho=
X-Proofpoint-GUID: 1rMTGPe2KUADmZ7VhlqROby0xndYTUuz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140237

On 9/14/2026 9:57 PM, Luiz Augusto von Dentz wrote:
>>  static inline int hci_devcd_append(struct hci_dev *hdev, struct sk_buff *skb)
>>  {
>> +       kfree_skb(skb);
> I don't think freeing it here is a good idea; in fact I think the bug

Agree, but freeing it here is the simplest fix.

> must be fixed in the caller so it properly frees all clones, etc,
> actually it may need to check if hci_devcd_init fails and stops
> cloning and calling hci_devcd_append as a result.

It would require a persistent variable to track whether a devcoredump collection failure has ever occurred,
for every devcoredump packet reported by the controller.
