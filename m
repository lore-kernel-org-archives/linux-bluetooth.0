Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36BF29D288
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789402607; cv=none; b=eosJOwykyBwNDs3H5kymIM12ctNlYCW5Ybl2rISJEvp3s+tcdsI0GvLjego/NC0E+AiDLU39FVVlEVCd3iMJsct95SZsJQyPiI+ilE68T8Zb19rhM85YeSexg24buEgORx2+KsVeMsdqaZYRvgiW5oTY0N1CIS24EscUnYOkrW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789402607; c=relaxed/simple;
	bh=s1Tnk0AuVXR6U8XH5iVHbw1LZkx41GsY7RfR5uUdpKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NoM0i6sBlTYE3Z5keCBCHDrvJnhpNigyKag4Cd6Y2qMosGMEoblKrrZ+mXZPDouB1603tdMmzFnUiJJdD6o2pVBh6vGIMUY2Rrg0yGuXieAAfgde4wfO5jFppL89DAmBqGWPGHc5YFqNVkwdWrTGkzDntqtccM+4roeyl1vbv/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BL7tvRv7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B4+Bupe1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BL7tvRv7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B4+Bupe1"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0J5t1514307
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 16:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BCqe0XzHDMtUy40xDqhXeEHj3hyeZLQemGcSFzEK3XI=; b=BL7tvRv7BxFqjuh1
	uxR5d3hXkFVbwoM9rL1QgKKNs1H9Q2d8pvYuqZJM5dFEDhvyQ5c1YCSUCuHXuhAJ
	6T6kY5IQwxTCRo9bKiOvi9qH9g70DvXyqgDRNq1JRwFhoPbqFcAJEXH8QwnA8wz/
	0WbS7utEJjIOt1dgzKcL94EPt1670PAdVTs+Ogr5YesIp/6h2ssH7s8phJxiTBki
	FFjyevydb7Mac3ClfIv3QZlx9sIAl8TQF8AA2Mc9+JdU68jd+58mxsyCJx4wN8U9
	gKqi3gbnNVumORPlQA5L8j+XV8nEN1wtOQNDCUY6stlxV6eOwJAHojZCYLjepWTg
	aBCcpw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3k0bfvr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 16:16:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbe416a212eso194653a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789402604; x=1790007404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BCqe0XzHDMtUy40xDqhXeEHj3hyeZLQemGcSFzEK3XI=;
        b=B4+Bupe1caqO8eRe17G356IrT0UTUlcdqmumt7E91NDFUWnnGG4QXz7gc6BSbndT4x
         pdxsTjbOes+9s+nB+MSBX9g9SZryj2+PaFtsVgFNoetDTcwb+U9chYxHm6fDm5FVs9X6
         NrmmaEcUuwRZiVoOvaoKFUhFKRIILtSWs5wup1uWK64cYQJ+hnyDfPJ/QpUEPcSB02uN
         qq/x9x6oF7v6CmD3g1EDXLA/mB3Q10t5OaWi12OwrrsymHig7b0s1t7/XZIJXM2NDbeh
         z7SvvrwAedCwbBAWbshgvlP4kWVeHdjUb/hvRqZq9qsopyx0f6iP7RcHMwGuuAyyQ8ST
         6U1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789402604; x=1790007404;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BCqe0XzHDMtUy40xDqhXeEHj3hyeZLQemGcSFzEK3XI=;
        b=fmp0nLBCLCyf05z4pGiq0J71R029dwZFLxoLxoEvejcg756CB8KjudTf12BY5h+GX8
         +VihPYtuDsm3eI8/O0KyNOKWk/27KXXP3xHxJ9exQvy8RVyUk44rhalYvXtzdil71u0U
         XQWd95HVU9WMo6s6YAv0Pk92tRN0sf0mEktYEpeNHl+G1qqV/R6L8nQfx4xIWGE95IYD
         BymyQcdxf4SVgV+KqJj6GkQubDop1GYG4Trs+nXqY5Vt1zpCqM7qSxFj1adCteK6s60y
         /Kr9waqT/hgC4G194GYA9X7fgZ14P5LLoth+Weq1NV3pRqSlOYAi3OTmSD1fVGo/nFrV
         LktQ==
X-Forwarded-Encrypted: i=1; AKwUvBytXCxQEjYw7kWLXcF7//RxEB2qnLUeL8J2BD5BbWy8eIMgUi50y5G3oA4dd04HzM1QFrZNj5DMjfqq76E/kuM=@vger.kernel.org
X-Gm-Message-State: AFuF++kUwPph9tcIQbO20BQYzkglE/6JpIG6Gmj+AsLXCEnqMh8AYdyB
	+3j7fJGb00YzTgpRkxWIBGYiJ8n/xT9Csr+bqF48RlZUB2c0Y6v48cXpSx6ED5fKl4TZoS9ZikU
	/xSKitUr+qMvRn+uGPaY/7AVerbSlyA0ORZs3u5qYoqEu61oaT12YqQmw0XeaR3LdhAHJx/VvMz
	vxk7snkOfM
X-Gm-Gg: AYBFou0D7DMpmZhXSEiWpFhFoEwWc4uvCq+UI/7j6jJk3FUCYxmbcU26I4Fll4ifzt+
	RSo8nQukH5qal6VOQEvUtXzRzFNfsUbVfilWyIp40tz4Zkp39UpL3xqaI/MpLPC+xxzcNBMAGzl
	6q8+UFVHwmmE6inl1DR1Lj+OSCyJsLJIxqd4kqQilPjL/e3os7AZs3jNy2sJ++7KGCLyq58Uz2q
	maTvJqwWZBBa9Ba814rIviP0Jnx8rsyW+Y9F/PzPBFkv9AXO/1GWsOzmeJUOIdAlMpk3rcrs8Kv
	bmQGSQpsiRBuDpaDcDMjNBnukz30yXX0G8C0bhfiEDOPg1cezWI1V+sfznbZr48FU6ogOBLxtel
	Q+7s1/OJHRzr/kwGu8YOqaEnc8oIunZLeXgV/MQLzw+LHlJHMVEbQhhsbZqvW52isew==
X-Received: by 2002:a05:6a20:2451:b0:3d1:1b5f:d802 with SMTP id adf61e73a8af0-3db400036d2mr4716409637.0.1789402604387;
        Mon, 14 Sep 2026 09:16:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:2451:b0:3d1:1b5f:d802 with SMTP id adf61e73a8af0-3db400036d2mr4716373637.0.1789402603878;
        Mon, 14 Sep 2026 09:16:43 -0700 (PDT)
Received: from [10.249.18.74] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4f712a817sm1292816a12.2.2026.09.14.09.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 09:16:43 -0700 (PDT)
Message-ID: <2e989526-983e-4056-87da-7aad0f79fc98@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 00:16:39 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] Bluetooth: coredump: Fix btmon heap-buffer-overflow
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>, Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260913-misc_fix-v1-0-558c1e4028b9@oss.qualcomm.com>
 <20260913-misc_fix-v1-2-558c1e4028b9@oss.qualcomm.com>
 <CABBYNZJpwkbFB8E4uHu4AcHjtR8R0CKnhj0Zesf1umoLyiqecQ@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZJpwkbFB8E4uHu4AcHjtR8R0CKnhj0Zesf1umoLyiqecQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIzMiBTYWx0ZWRfX+VXSRrv4dMzx
 ZvC6QngaZucwU2odlPlbQGSiM89dW6s6XVvcjGXLot/sYPRu4DVufXaz3++S080OXURpmfKA71n
 vi24iJUL44D9DIY3eIqmtDJro6OSuQ8=
X-Proofpoint-GUID: Z8rFxiEszhqbxqTbjLLIWoQZGbKHC7Pi
X-Proofpoint-ORIG-GUID: Z8rFxiEszhqbxqTbjLLIWoQZGbKHC7Pi
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6aa81ded cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=P7WIEfRXt6mtrGuOy4wA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIzMiBTYWx0ZWRfX59I+8og4iPbQ
 XAl9oqxoNBz/xX3w12hKCb4NjZXC4c/xep+S/61NC8wWeElbpJf/YbY5A6+EnplWEJpb+k411A6
 3bcIV0EjY4XXwp2ZVDkQHTHF/oEb7hAZ8hzBeXLnIwRmi1ORXyIF5PTg0rhiW7/7+0igCqtGSPv
 7z2wD/s0yitJEpMN3mIApwYL6hM31VZPT1hTLTxx4Qss2UYuHJ9pofIm//iUwtzkIeQ2RXsH9og
 0Of+Miz9zjuzFZb7OmGUKk+4Twoe0HU/5Z9WDECg0HlIN9GGFHRyxUwb2OCTmgPo25sB9Su9vqt
 9ShWLa+XYw0SCeYP2crU4sQDlJJ5zWuGSPtskNpY9N5qlBskD4oWU+Q/ttNLXy+KAFCj01FxHh/
 jN8M0Hya0Sbzyam3ulkd+ak0ErjOHPr5xdyjiONntnAbykH9+x3BDydoZgqihvsE3TsmImYvlP1
 oGJfA7ooyMFkci9Ibpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140232

On 9/14/2026 10:05 PM, Luiz Augusto von Dentz wrote:
>> Issue:
>> ERROR: AddressSanitizer: heap-buffer-overflow on address 0x51b00000065c at pc 0x7f50b987a029 bp 0x7ffde88dc8d0 sp 0x7ffde88dc088
>> READ of size 17916 at 0x51b00000065c thread T0
>>     #0 0x7f50b987a028 in write ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:1096
>>     #1 0x5b4f3443ae3a in btsnoop_write ../src/shared/btsnoop.c:289
>>     #2 0x5b4f3429cbf0 in data_callback ../monitor/control.c:969
>>     #3 0x5b4f3444fa9d in mainloop_run ../src/shared/mainloop.c:104
>>     #4 0x5b4f34451da6 in mainloop_run_with_signal ../src/shared/mainloop-notify.c:196
>>     #5 0x5b4f342953fc in main ../monitor/main.c:303
>>     #6 0x7f50b8c2a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
>>     #7 0x7f50b8c2a28a in __libc_start_main_impl ../csu/libc-start.c:360
>>     #8 0x5b4f34295ed4 in _start (/usr/bin/btmon+0x29fed4) (BuildId: b41caafb24db693946c283eaea48112186863d2d)
> This probably needs to be fixed in btmon if it attempts to read past
> the buffer size. Also, since it now supports vendor packets that may

Agree, will fix on the btmon side.

> not be limited by HCI packet size, perhaps we should allocate based on
> the channel MTU which probably needs per-vendor configuration to allow
> collecting its vendor packets.

This issue has nothing to do with HCI_VENDOR_PKT (0xff).
This problem has likely existed for a long time across almost every vendor's devcoredump since controller's RAM size almost >= 1490
The root cause is that devcoredump data accumulated from MANY MANY packets is being sent as a SINGLE DIAG packet to monitor channel.

