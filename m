Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795395896;
	b=02EjH9jJIHqqLQ/bM0fIFMgJQ+8cS8I5+PfHRLV3pgjUI8l+HZc5SDtUhO04bzjMa7PF
	 YI/DFkhLKesyzn2hIwTwOkF3dfa968v10eNgj4vx9AKf2nBdL3ZpRTlAMJD0Wa7N4Gw21
	 AA6tqZH6Zmnls69B1YOUnQ3YovBRhrZteb3/u5UE2MKtbfAxOGhI9ChobKL2pHAIiOmZL
	 vvLaADIASSZmcFztsYIL18LSZquCcuq4wGqr+90Ss47+BACbi9HQBg+Hi8S+YF5uUkWLp
	 ppsmvIt5WejKRFmBxW2I2ExKX38OBhdduNRUhzkzBFs0Hnv3A8WgeNqIl41iXeS090w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795395896;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=dH7u7XjEOiWxsI8tGO9yQYRC9RMGtFrysc7enioA1ok=;
	b=fN5LzdABdJ0R8+hnxRIJonC7/3Awa6XH5VUR1MJndQLDAVhWlcbW9NRteYsNSh+mXi6I
	 CZ0l0PHkp+X6dzXxldP3NknF1jQTiIEPxd9YqguIWnT3ML7Fi7jQj9X9FV5x70FXJhxA9
	 +YIb81SabaNF5+gVvYN6J++iVJnK6LHq45Ze2Qb/Y9AQjeGY2YxBu7nEONRcyGzXxTtOE
	 3rhIYdCG7npF/nNHIvcxH+hgQ5gtnwUcrXTXkD6Pol1KEBeAzzLNVfuA9+CehCQiLjU7S
	 PFihAOW13FI8plRXcy6XT52leluann/sM/rShlmU4PQt/lZmkQ4I2pYAD5Xypm42yhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AS077RA0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MttSkAkt;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA09606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 01:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDA09606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AS077RA0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MttSkAkt
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AMNrguj179968
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 01:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dH7u7XjEOiWxsI8tGO9yQYRC9RMGtFrysc7enioA1ok=; b=AS077RA0OLTHg3S+
	TSRuus4vtniTveJgCi7KsCCCSg6+ll9uUZHZnp31wouSLmGwLXMgKJ1jcfl70NEz
	ywACOvy9QRxXojt603ycyt5EPZ0CSMtVW38W3iLbEI8QB+AHM02zx81MPHC+/K7v
	HFTEhV3wl6eabero7G1Kie7tQXD4RmU0dbd+K1nTj8zJjE8BzM41EPJ3BCQwP9AJ
	SIDwz6jurhmyiNkbdjI+LMQHtL3dI3VpG3gwGAk8EbCYFRVpHCmBwvbndRX7Zu27
	IWbx74owU+srUq1qtCWbAeSPAfUSNkdJi87to89OAU0YqFG5Lds7v5v2P0WzgVDB
	SPya3A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j342gmh0g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 01:04:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b0a0747175so534452a91.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 17:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795395894; x=1796000694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dH7u7XjEOiWxsI8tGO9yQYRC9RMGtFrysc7enioA1ok=;
        b=MttSkAktt30DK2FnOzDVovsoOGPIZwWGB4/lUyr6xsdCbSUVsNH5W4hm9k548QLlr+
         cEmQ2Q846h5bbKI3cmTEuQjeUnTBt+Q7v5avYjEmh7YVycnyP0ttqkAyjd6O42AZX/Ut
         /dnEl1gNCz4h2bAcxmNfSXQdjw26r3sGnPpUdfuzqcE6MMCKNBicvDh5/jdNbZ+dgVIB
         v+S3aDLmaHbQEWJD9stMQNt5/j71pBZ4FnQg2mz4I+I87UWoz5k6Kjozivy14+3cb0Ty
         J+eEFNEJGHBIMxglybNU5crnHir5ygaxet1PmPLlymBoLgIDBMq024zdSNslGs0srQQW
         uXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795395894; x=1796000694;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dH7u7XjEOiWxsI8tGO9yQYRC9RMGtFrysc7enioA1ok=;
        b=zdy1Q0I+UV8fxUXHc8T2XyYanTbwD7I9HsvzPSGCt4WHkZcZRzj9sohg28QuYdF5PP
         NSTmjIFjJbFgIbw1Jbx08EAU8zczPBw8eezTLKHh/1CMxxiXdlvWOkKMYAiUsnz2HtHF
         aTqjZkGKeP3vhl7DIh9Ng8qcer8R6B7w0yo31hX2P3SeUs3M5QO987g7pSU9Ggw6hc11
         zhzA5hHD9Dawyy0y8mOqFg2PEVisZMnu2q7d4ZCVBivb9YVj487zap/RT8PWCNvuqG5B
         pynvIEjF1Poj4nLAwnY53Uu5OIS+5G4afOsxH9tQnZ16xYCJcz0yT4yjs8rkgDzSY8Ug
         Hnkg==
X-Gm-Message-State: APuU4Z+G447eBskdMStIiH/UAVs9lVkM3jFWMKvkOiO7mVSoxpaWFy6C
	nzRd0fuf0dLKky/lvGIypsPT0ZigQI7dIWHWCFIv7hSK893F+jJ0KcMTDkwUGhr6X84ANV0caK1
	uF9SMNlBurj3+LViiS1v0oYsrB+nKNhRI8PTmlJvdN1DBWBjFOmZSse2wpNRe0lQZBfcHzAhiqT
	oSytjqHQ==
X-Gm-Gg: AZFdTZeih86MVU+AW1w8rCI7lZ+8wUbFs277I/ogDz9RdRELee+o2oGCpvILvob2ZOW
	7xvO4jKFzHJHjc8oyKjmIOnm9RazMcOn/tv714FN4bvOHAAx1EVlr85pwOeQawhVeIRm1TU9IGp
	0EaKEqzGpv1Y/lJKOiCyIRl7Oksa0C/m33L1zhMk9++qNXwacl1UFLoSQH9+Vq6qYs8ZPJN2vbi
	M/Z73ZZDWSue5gXibtcYeWF68ze/7tgf1VhjwjPOHhTd0WdQ8GhraaEnH88izuOAf+JTZFNNpb3
	PB5NhIFdEzTfKoCLY28sAFDxjjW1uQ1NeFZ8gVHF1lqAO2lgYz3MbuPLtb72FOAkSKJ6kg4BRTq
	9vQa+Wf5OCuFEmm4cOoPHZdXxvnvvhhUCIgcaDwy9shc8QcebrGufuGaMxJefGeJYdQq7tu6JHt
	NqCYl6EMMFbGZSBpcfYsEGFiP4oUkfWw62rRcXGQ==
X-Received: by 2002:a17:90a:e705:b0:3ac:9c37:9422 with SMTP id 98e67ed59e1d1-3b41c7e4cf5mr13880076a91.2.1795395894094;
        Sun, 22 Nov 2026 17:04:54 -0800 (PST)
X-Received: by 2002:a17:90a:e705:b0:3ac:9c37:9422 with SMTP id 98e67ed59e1d1-3b41c7e4cf5mr13880059a91.2.1795395893639;
        Sun, 22 Nov 2026 17:04:53 -0800 (PST)
Received: from [10.249.9.249] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41aab4729sm14843431a91.0.2026.11.22.17.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 17:04:53 -0800 (PST)
Message-ID: <249d8212-f68a-4eee-b92c-efb339dd9de4@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 09:04:50 +0800
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bluez 2/3] tools/test-runner: Support running on arm64
 hosts
To: linux-bluetooth@vger.kernel.org, Pauli Virtanen <pav@iki.fi>
References: <20261122-tr_arm64-v1-0-4eccf35daeca@oss.qualcomm.com>
 <20261122-tr_arm64-v1-2-4eccf35daeca@oss.qualcomm.com>
 <edb6288e11cf9eab058cada5151c0c071587eb3e.camel@iki.fi>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <edb6288e11cf9eab058cada5151c0c071587eb3e.camel@iki.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H+5OUOYi c=1 sm=1 tr=0 ts=6b039136 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=eTizAhUy4B9OBve1XdMA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: PIeacQ7aAb21f8cyibndNUypIWi6u5qI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAwMyBTYWx0ZWRfX4XcvbTBCgpeV
 ryC1Nm/8Dj+VwOyyPtO5LqLD6w+uNghda6gfvNAciwMDw7Yp9OjIb4QRlEGZI6VJTVmKuhaRocO
 m2GNwDiGNBMKqcEtWwmbeomN1ID0MoY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAwMyBTYWx0ZWRfX5fF6NJYkyd+J
 hOP8Y9g66+EwyM3jbS14gBHjiYhX9TbByRPOO30NIWm4hdP6Vw1HLrWHxUYg0Ti8eOnNwStYCS9
 3jSU7R3Ea+mefQKFz92lbUzRmDXcQWzu4X5p7WJP/9esvok6eUdZReOZpbs9q0aNpJvyn0HrryI
 d4mxMGTrN5TvrVQB5JlNrt9OhXZeWLTcqzZ74LDEDdQSq2i+nKzdDqrOz7RIWp245CDYqfqPq45
 Jjcd01lM0pUnXzlzKobzoq9SOiEaUd/PJYjYhkYz6M2qi3MQNV9dgG3rWhslF0o/WFr1NV+44BE
 /xn387zFlr9tIFkD8A4vJMCBn6f/7QMYI43wEYMD0GCTIhcd8A5LojzCYZUp067jf+VkMSRTxL5
 yYcaM40GwHEZcjRQ9/68LIAQM2pcI42bpanXxtSct9i9tAjBF9F/7oEgNTcuxcmhB+LXSS1if2F
 exzCoR4gXnHwbEFC5Ag==
X-Proofpoint-GUID: PIeacQ7aAb21f8cyibndNUypIWi6u5qI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_06,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230003

On 11/23/2026 12:24 AM, Pauli Virtanen wrote:
> su, 2026-11-22 kello 02:34 -0800, Zijun Hu kirjoitti:
>> Add arm64 support by:
>> - Using qemu-system-aarch64 with the virt machine and the arm64 Image
>> - Passing -cpu max or host, as the default virt CPU is 32-bit
>> - Using earlycon and leaving out the x86-only options
>> - Warning when /dev/kvm is not accessible, as QEMU then falls back
>>   to TCG
> Should it actually determine whether to run qemu x86 vs aarch based on
> what the kernel image is, and not the host system this is compiled for?

I don't think so. Choosing at build time is correct and simpler than
at runtime:

1) The guest shares the host rootfs and runs the host binaries, with
 test-runner itself as init, so guest arch == host arch == the arch
 test-runner is built for, namely, the build arch decides both the
 host and guest arch.

2) Kernel images come in many formats (bzImage, vmlinux, Image,
 Image.gz, ...), so detecting the arch at runtime would add more
 logic than it is worth, while QEMU for a given arch already parses
 its formats with -kernel.

