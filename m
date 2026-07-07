Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1EC2E0938
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410668; cv=none; b=fmStJfKzha6hBA+IfmToaO/cgaNds9zTA2Ybvkq4nIupnCA+ZrHx0AkdL+6LWXIAVXul0gxaLyL070AG1+voaMmTvhtjsoMcwNPCbGz185HLQ82HROWf2wpIZ00YUaltU8EbjqES/Ku5z75B2lLxZi5zPqnShzmpbsegg7jY8Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410668; c=relaxed/simple;
	bh=Maxo1860W3v7cOruvNsebLdIGgVgbGVgvp0cEF5t6ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCr1kz1IHiqTb79bPy1BLQt1hE2xen5wqHTkmf+90RYxK0DPod6x+CdbuxQ7RPLE2DcIPIXIrybcFVr3vhW8PADSTYcIPIGLIkMUmaFG6OcHcZmY+Tricw0dJiFH9K8m0gVq2J0qm94PiSvMsrCF0vYg3nlOyYRNWG2/0FH0lrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mI0scv5Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VhUUumMb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mI0scv5Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VhUUumMb"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66748a5Z2449587
	for <linux-bluetooth@vger.kernel.org>; Tue, 7 Jul 2026 07:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bnZ3rlISTDjYOEAxPA/dNYNjWT8PUBILAhglC5VQ8wg=; b=mI0scv5Y9oHpnFaH
	1jrVtGsFXeuDRR0M6qUoakxnVUc/NPEmENught+XeNsQHp6IHxNauA6l+z8Thka9
	JyRAjZHxtZD1fRaNvq29pbzqkN+jk8g+QbgaSGXeTZ31KK+ppvQAzXpYwlgIq4re
	mIhKqXl180y2e+dZJw3huTKD1OGlsfsBfOYxD96QrNkyMY/39zLirZnnFWj6TZVE
	ceevLNtxdmZlHJYAIujU2NcIXDYpwxIMeNg76RsSdDCZLtsnBzJ1wmsAMUPQWtV1
	mlQ6/0cAvBBc8/PtKsIjGAZ6NfPD/2hbv+MpZJxyXeazOQeUWSf5icwm9gnZ8RSy
	iCqr1Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su70tc1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 07:51:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c08e9c344so15468551cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 00:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783410665; x=1784015465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bnZ3rlISTDjYOEAxPA/dNYNjWT8PUBILAhglC5VQ8wg=;
        b=VhUUumMbjdAxPAgWZDstwMf5kGdcayox9MkQQO1atCtcjRR/sGkna0IQIF1W6K3LJu
         bs1oZMyZ0sVn1NzRrY/ucF+hmarfuk5SSMDdlA0vSMSg4/9dr4h1wuMvg7DtSvqEBYCc
         +94D/f0iNZcLlvKPlg1Qg034Am2Zs6+3mJYKY2gT6KRUYQ2SFIRgcEEZsNj13j57RvIM
         vRB9Wqm/ZUZcx7ck0L9D+DOgnUfrprXMSgyOEKmAjjO1cc/lbdp0cBKChgZ6QvY4josv
         V384mzLSXonu+OsQaTPvCLFC+LV9YkVnz6AT/kMePfIeBgbHQf2REWJ2c6d0xhiNc5rP
         /jbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783410665; x=1784015465;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bnZ3rlISTDjYOEAxPA/dNYNjWT8PUBILAhglC5VQ8wg=;
        b=BBzKX74PaIw6a0O9XsAlqmB0qThVW2GLIheskARiIWnq5bVFRXtRrTdHyxbv9FIrkq
         /RbNAsGHPmb5x4sUDqdFt2LvhR4yBgv8eC5/XQWWAJQZdLcU61zZZCBO/WEWVWYTkB3E
         hGD8QwxsA+iJ6U+HPrlsYBRtqrPyrRd05Vkkeqzq0AMoG6S5eLvBTgXuM80bMAOk0DO/
         0EfRs/fIy73gpkyLxJ2YfeXwq3NuPo1PYRJl7azVi9qJr+qOavpnekVrfbKoGCDyTkZF
         UCa30sxNarxicSo9hPwwR+5n/S8/KLOkM/6TEHRlmhLo735CzegtuooKXWM0EgVIcL8d
         pa9g==
X-Forwarded-Encrypted: i=1; AHgh+RoXbOkcEkO6K1Oa4EuVmLoYmWYmtMJk8gMqgvfTk/sD/JcS5ErkQJQKqbo7pjz+ol6zG7yIginYp2y6V5vrc4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkPG/etKVZHY1vNh0tUkPbDkqVUYcjh7Op1i/S4AP2ln3WXbXx
	6VKaCN/aZa+VHMU8f6KIbFO0r2yNAXX7xAZJJRmubNDU2nS79VN/KvUn75S9ugjv0WkPJxWGmCk
	wgbWiYb4888dY8xf9NdFrU552GfCTT+4z7DtaIabCYiQCGPsZE49+1VK34F75ehe42bT+xbE=
X-Gm-Gg: AfdE7cnmLn2kDCOK6KrCGMWC2JNbTBE6O/jtYP0dyqg5U9u0kpQCtM6sHOq9zlxNfSS
	+WGXmH4ZR5SGupEdVgGUZ1VKY8DRUFlSTSs+o5hhAykF51NydfaDAlOBDLuHgnIuh3XZx4AxU75
	j3ADJRuupTTVm0WS3uq5tTFiC6PYR2Q/H1bHip+0KQhoO7r8S/8SQcH72sEGYbj7REz6Y+xkA3x
	xb8JCFQ4Cgvo7YUISGNtraPXne8CO5WtHCe3l3DnCj2+JWnPmTReyimlImAZXV5Yiz8bU1Xo0Pk
	FCI+VKrgb72lizh9hiPthlpKCTn4ZEQbAX/Kvohkpvc2OXO7sjuwEJA+LlvFndNREZFn33iKfe7
	E35ZX+bQVpKhQ4rLAiGrSUzxg8OXTI6enJi4=
X-Received: by 2002:ac8:57c2:0:b0:51a:8c9b:6492 with SMTP id d75a77b69052e-51c4be98f79mr125902891cf.9.1783410664927;
        Tue, 07 Jul 2026 00:51:04 -0700 (PDT)
X-Received: by 2002:ac8:57c2:0:b0:51a:8c9b:6492 with SMTP id d75a77b69052e-51c4be98f79mr125902741cf.9.1783410664424;
        Tue, 07 Jul 2026 00:51:04 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad82311fsm75025366b.8.2026.07.07.00.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 00:51:03 -0700 (PDT)
Message-ID: <6d8c0326-1b3e-4eae-b528-22ca77dbaf6d@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 09:51:00 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: ipq5018: add nodes required for
 Bluetooth support
To: george.moussalem@outlook.com, Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260706-ipq5018-bluetooth-v4-0-350262a30959@outlook.com>
 <20260706-ipq5018-bluetooth-v4-5-350262a30959@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260706-ipq5018-bluetooth-v4-5-350262a30959@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA3NCBTYWx0ZWRfX6h1CbOdBizSO
 qoFyik+FnSk88t3DH5EZ1RtCZyJh0/luo937ZLZwP0N7gUoj9S579N9wD2bbZZ8YluvB6U4MRL8
 zDjbWItpZ0Sei5Py+t0SL3+uI1jm2UmwSQHKV/chFLr7zfn+KVdzxBZDa/H0PFyY1Y53oPCPS9L
 /zMqBl+EYmCmrqlKUAx0y50eq9c2CCuuxSEOEBg5XTgRpa+cwQXR8VDd/5+6fLRTBNznwAxdjqv
 QGN70v6QXXycj5kJAwpAg4oIaHl/JIoZ9sf1NY78C57uhLXkm5Y4TEO4i7TsPNi4bdT2Cn/jWkG
 KlqgZ+25wRE0I1yfPv9EKx4PDbMhsyHJJMiK5/UKmLpHnDC+YezcPi08Rm0aYeLfR+AYxSMcRIp
 ti0C7ZVZKcQ8HBtSj2BvHx7LWvF6b5HIwP5NtswZFDqni2LOJiwSsFW2cfm5lCptj+fVCQ8fyHf
 E2UMysGAtnCxPXku2RQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA3NCBTYWx0ZWRfXxZlCEV7QBgr7
 lgaaLZdcIRF2U6ax+Xy6aywUm7Vp1Y2hFsl5KkAx43QFrEnah5N+5IIwNCpxdWFB6F1x6jc2HBC
 dGmu9Pse3xIdlZ31lWMch0ipB+VBamc=
X-Proofpoint-GUID: PLqbaCbtGhS4egckvxWPCUyfoLDSJk9Y
X-Proofpoint-ORIG-GUID: PLqbaCbtGhS4egckvxWPCUyfoLDSJk9Y
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4cafea cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=t82OjkPGvLD1vuDj7LAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070074

On 7/6/26 7:26 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Add nodes for the reserved memory carveout and Bluetooth.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

[...]

> @@ -136,6 +153,11 @@ reserved-memory {
>  		#size-cells = <2>;
>  		ranges;
>  
> +		btss_region: bluetooth@7000000 {
> +			reg = <0x0 0x07000000 0x0 0x58000>;

FWIW RAM starts at 0x4000_0000 - I'm thinking whether this should
just be the 'reg' value of the bluetooth node. This makes even more
sense as you write to this region using I/O accessors

Konrad
