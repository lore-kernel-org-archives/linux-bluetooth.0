Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C02E62D9
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455052; cv=none; b=iEWh/GJPqoyvXrNe8pXbryv5/fkeEqwgvecq+5LpD00Q3LzvMG25enyOb9nHaJR6DhVSLm4t5043gF/xCYKplhPHV2gpKxtPdSt5nT5Kw+XMzLiZ07qyt4iUocattubTbjKfPr7qd57dZegVdiOVuWwpCoWjioXUEjsiOBn0+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455052; c=relaxed/simple;
	bh=wC9jrPQBmpCZbW2mnXn6p/4PAelbyjfeh2Yka1RlPpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1mjdG4NFuepuYY6H6XAjGv7EOZWpTZsIPQIKX3hfBheyRkxsru0RbMZ0eZaoz1iWH1v0JTGF+ma7E7MMSbjUf2q3Oon4dBJ/rk8N4Rb07V3WxEPClZfb7cqsWIp50coFuUaY0scULTUs+0vbM/oMSNmT7L4PG2W9C8OOrrTuhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W9VWA6S3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QHyzD9Be; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W9VWA6S3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QHyzD9Be"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8qE753066928
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 09:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gTbNCeRSUqu4zDmkAqRY6ARTuww7wMu5rx1tnXDAf20=; b=W9VWA6S3iqRyvA7f
	IQsLcQMaUAo6MrX9KGt2ltCHppKvhII5yVDzVpDzHK2kuP0AaZslI8qh0v3tmdex
	IHtPapbJQePeiqdCjlTAhAHyEtwfT+4h6Zf8mY9rL59hDCZTT0mB7QUXD6jK/LEX
	YPlvGlHt/g2oCFgtmk6x9RRZqHkzt+idAJZfRqmiEEqUOF9drtciI0/PpY5w+sH2
	wGojjqWxaAsCUJXiE3JP1jCqQkACKt3T6EDFIM1KBOrrB9G53FbimPaNVhoSbKrh
	h3vOEeWBL3aHeQUyDP5coXfAtAd1BplIgxkVknbEbhHroHuyOjpgWPgJcKcqpcyx
	cjXoQg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sx9tv3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 09:30:49 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-56f8a5c02b4so826757e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 02:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777455049; x=1778059849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTbNCeRSUqu4zDmkAqRY6ARTuww7wMu5rx1tnXDAf20=;
        b=QHyzD9Ber/f62XoL5ZBFZvm4x3svUARc52JHdvkmGxJFM1r1KXoQLeFZVBJM4bYKX8
         hbT1X1zbStDydBsTeUKWwC+hEDS4qC+COKSwYt+p5AKjsRc+2jXuLqDClnb/Mko4I/2o
         dHJHj9j8jIfR4OkWvsokfrzJrgIsgiyShQcrdPJnqKp4xIiJWFOA3MeHM71e9/5IGupz
         KCRQ8zFenH6I6rcOQHxCPX80hCIDLNj+++LSU44rdBMbg6H9yLzjaurwjk1MbfdbIiC4
         +LNaKvri/UV0Zg8WNC5akFgWqRTRsoLYiNkwpvlzPWIdW4uibQl+NUMVGcHAonbznBo1
         TXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777455049; x=1778059849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTbNCeRSUqu4zDmkAqRY6ARTuww7wMu5rx1tnXDAf20=;
        b=buGKvYVvHgH4foBEohZ07qaJrTaDwZ1pr4qPGWWvuPbzdr9OkAT3W+4SVhOlePqXhl
         hNaEpxS35kD4Dkxgs35sZ54OF4bj+917aoS4Li1SRqIsoNsgTknGXbOiApXPuCAo2vNy
         1w99sdvgBbJH4A2Kkld5nHGz2lPIQfIb3ezBhYrbXutWLMmPyE1dDrPZVjU9WBuTBliO
         SNmTZTjuYEwGP4yp3a3t/SXeh5q1kRec2afsMhd98BVXBc1+Yxs6N1N9c6MlsvQmJLQs
         0qYyHjp6KcWXJwx5YDOYqsPVCNyLkMK4ELNjQOz/ooHOlCyITQCXMWYalzgy1JMMWASX
         KGgg==
X-Forwarded-Encrypted: i=1; AFNElJ9W+9s+2mBu9xOBLv2poKWf3VvpJIb2O3jFdrCsRl+fUwxSD+rns54ufrKKiyDlsT655Pf/12F21jcrBzAObV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzidHXzaZs5VkFTFHgnaxr/Eu8j2bYem2unug+/oXkExhxagrRb
	BU23JFR951p31SMzTH0elJ755jQa8OiLIv9+m4rnczzO46PydZNk/UER7NenZcJEMccM4EiP5HA
	9PmgfLlk0/b0Fs8KiC5uZg1tS4oIy9XJiEktlKyiZpuDUbvUafGWMebU8FoQoslHBbdVmebU=
X-Gm-Gg: AeBDieuj4w28fvi7Ihd1Q812gi9fFZ+EZkHv/NIRnq3wb1KvN+Hhyls32hDc1p1R+0N
	C/v3FrB6vTDLo5vCQtMNwRReJikCgrAVMhgVtxcZp+LaBjj6MufUz2wR65w1cCjcjXugh+y0G+b
	RjAhuX0PqtVMQoZjo6SW0M3K7O1zHUl+Ow31v/sFBzMueKcxNjXTic5MMkYiN5A+45yCUuOAULd
	wWOFYjjVN4dNcgj5bsr4+ggzPo/O73P9qeK6n6H9bHP7ACnNlhFxTpL6pjWRK0NIyOMvsNj0YKw
	TQu681eQM49FaRsroANu6ijBAp/7Cpq7Wx8Nz+jil2ldFUqpIZBxrEZcvDQuhMiTxFF+JsIruUW
	5lmJyDwtVRUnAnIV2gGbV/oKvZvr9u70kH1bO+oEUwJ6nrfvfpOfbfWJthtszBcBUV+bztceUYI
	g5OOgsTGD5VoyYiA==
X-Received: by 2002:ac5:c894:0:b0:56f:6edd:77ae with SMTP id 71dfb90a1353d-573a293d531mr1234274e0c.0.1777455048474;
        Wed, 29 Apr 2026 02:30:48 -0700 (PDT)
X-Received: by 2002:ac5:c894:0:b0:56f:6edd:77ae with SMTP id 71dfb90a1353d-573a293d531mr1234254e0c.0.1777455048034;
        Wed, 29 Apr 2026 02:30:48 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb985e1b108sm65753866b.50.2026.04.29.02.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:30:47 -0700 (PDT)
Message-ID: <aadfa862-a99e-4214-b19f-6854672dc8d4@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 11:30:43 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] arm64: dts: qcom: arduino-imola: Get WiFi MAC from
 NVMEM
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-5-6ad23e75190a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-5-6ad23e75190a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mbjXQy4odwexZ1pUcDYPJCJwtoiV_BkE
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f1cfc9 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=vtxEUVkT7waMBiOsAPUA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA5NSBTYWx0ZWRfX35MkDyj/AG+z
 Xlvduhrt/6TDYtnAsMjq8dHmxkr4xNpoj9ulS7vMWNKMdJiWzuJjZpiKP0eTWoZYDAa3TELpdaF
 rAdl5ymCgx3q72Eh2S9sDNMv93ZQEbAtHCmXA6HOz+5crJUSkikv5QHe00HYlATEu5CMIPIOYU2
 7/8jTUI31kfe4yD0dScBMr0+eiZUFXC3MYmt7bbyh8Cq8qXHnrdiRDOcbd6HZDzHdwIp7T6KWY0
 5WxcUqLW8dFSJu1MiPFI0U25k8/rfCHsc65esbCqYFoW/NfkczLtEcfFO0IC9cabCKJ0wZnqyRk
 FqXB8se0MaGyk2JgkrC+uaGDcMGgVe49bJIkoZ9D191dGDDZtojhi3P/li7mdLfo1BEM6xhH31x
 R4MPIthTv1wn7WPIMYbW53YsPAL3gR8sBy4lUdqhxkJ5rHuIgsvODuycDEgtApXk/9mv3oCF2CN
 AvO4zAFNT2r1ixeIefg==
X-Proofpoint-ORIG-GUID: mbjXQy4odwexZ1pUcDYPJCJwtoiV_BkE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290095

On 4/28/26 4:23 PM, Loic Poulain wrote:
> On Arduino Uno-Q, the WiFi MAC address is stored in the eMMC
> boot1 partition. Point to the appropriate NVMEM cell to
> retrieve it.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
