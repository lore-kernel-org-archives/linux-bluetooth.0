Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737B29BDA5
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183052; cv=none; b=VSwkdOFAE4K1y/K1IFAGVEJtLRGl0oEQnBdLENs3+GvvmGjU7/uTOi2a7RUlLUPeeZbBrLKtx84BbWD/QwsQhtx4go9Y8Ip35d62+zkHfRBYh2cj48Os0/82hh+cIpKrHGK1CdhZtvpMSvOj8aRxGdSOCY+A8omLxyTs4Du0ufc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183052; c=relaxed/simple;
	bh=FzhfKAYKhvE4b1t8D4IAourbx7nVeMnR85FO5C0OjB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vn/JtXxK2hL6wDGdQegKxDsKXoMQSJ5OhB9yz7TAhEomnanOumlEdxY6zXED7avepg/j+tNig8lAPRgAF23CzAKANzI3ky4gLPTVAbh3iVbi7UEHTITIjuUZR3PJ74ZO6651HE00rpN0Ou/DOo8nBcNojIb/IzFfdgEk10VhHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mezau7Nz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QBTXveCS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mezau7Nz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBTXveCS"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BULpo6M2916171
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XhaBQ75Rf71lV8FkiGxgw61r/Y/XZi/ecHt0oI9jQCY=; b=mezau7Nzk3XUhMQV
	4EiIg/pK/tFORCyMGoQ/PLNKi4tMRaTvpOwC0hf/CJOAwOsS5nHynXeO0jPK2Lug
	+ctgHBC8aflVVXSofn8SmFDUW5efcuJmNwmuSPIQsKR9k/E/ztH8qFR4e4ygZUH6
	lnWbWyLOZG1JeLAWomz2chAgobMNfAA2BHSbm+k2aTAOiDm6xF0kpNe76juVtC2n
	ZnDJT1ez9iTgc/E6xnjuf66FbrEslT5jCwInbzye1qu+dCeskUyPWcfpuKBXv7hJ
	ZCVWEpV0v2AIeA5mKI34UHkQlCDc0pUkV0ZfJkBE0t/b1C0s7AN90fguASRIdazO
	Z+V8qA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc8ky3deq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:10:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f34b9ab702so28126561cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 04:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767183049; x=1767787849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XhaBQ75Rf71lV8FkiGxgw61r/Y/XZi/ecHt0oI9jQCY=;
        b=QBTXveCSkMcebfwv05aNYzqiTq6OFGOS4yST3rcC6ZQF3BFxBZruUmPsOxx1AqHhFn
         avVg2wKVfb77vU6hjXh+e49NKNtlBFPdIhUTfflRgZYZ3nLQeLAlJNc1yEj2eHglAwh4
         5wbMMHmmJ6c8U/iBrq8qt4i42CL6c6ys+JSy0JO9alqx3pNkiQ4IpyyykZmo0L76+mkj
         wBzALwvIF9ZmUqc8CZufPPE94xcFWt5jyFW4o1o/KBTJxWxteIhyYMhqVcmjC7UKBo6a
         7sVPyOv6dCN7oq8M3uh0I4d17mDcMNdw7CB6GB9j1NJaPdHAnY2Gl19xpJ7VLxm1CW7x
         AIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183049; x=1767787849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhaBQ75Rf71lV8FkiGxgw61r/Y/XZi/ecHt0oI9jQCY=;
        b=X7hg5dB00/POy5RT7zT4QegKrMHw+OJgU3gsTt34XzsncgRdAIukBTOODhADQYIUSm
         xlv0VY+dtquNOCdCUIz7Np+cyIVV86wWNkaJbJPAulWtuW2iRhndK3cTGFmiIRb30zMd
         SLwXLKmhTwPVtwasbqYM11UcdplOM47HjU6WHIDEBP7Ul3UXhEJ+H3l3nibGtA5HtY7t
         rhmAWr4e7Xj4fPjaKtd8gN9on3v0rPgS5AMQVAqL38CvdLns2G64H7Acz/Z7Q2EDok19
         aQcciig0UTOjx9f6CGNAJrP6gWEO7UrOibGrZlc4nRrLluZ1d2CkHHuCA22MA5M2zpHX
         CwfA==
X-Forwarded-Encrypted: i=1; AJvYcCXqv9JOuQfNFrZB8DPI46N3FxudCCnTPuRSqKhiHE59W9dw7BK2xtCWDfg0Wqs8IdMYHfs6DNGVurSSTza/Dyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzlle0p0ekUzadvhL5z87r7gxLo4F12axPDd2AkUQvYs4v/KdV
	z2VGmCPowtQVk5D/uWdmCIl3B1EE0TfTlXlkU6BML+Nrdj6+w78i1cLhTpvMUUA5unxhVa8BNPQ
	JBm5HxlKPhe0yYtPnUYKdQmgDFXUcyZnuItJ/LDZIkLucPKASBBOvU8mBg8/41//nZmvVMa4=
X-Gm-Gg: AY/fxX7RHzdfTYipjMaqOFyf+xUT+NfkJBJMfIGV62j1pVd9OGzPEE+iJDGGAY5QxGH
	XTfSrGMUCbj2TOBEPZjL0FPlYMZT7PyxyA1bhMYJk6OJXAIMLAjxtvfLKuoZbuKyBEx8NpoCWdg
	4VOYYxqIiw26r/IQG0glu+T8XlTsasFfoGgEjHe4JSg0xWutEETTURgStJmbE5jF8OkpGjsnXrt
	jWJuGekntPex5iKWRAlbqzknW2atsoY5Q6v5Byk7TJ8J9Csy2bd3Yv8SRAm9Rs+Q4Fi/ywOHWmW
	uw6yjLry+HEt1HRoggjQO6ilKl6hmyE7nU3Vzny5I6XC/222KV6MzvS4V7c8eyEgUTmHUyV0SuR
	fgSGGJg4NCL/XGYuJRYSAbOqfz3lL6yER1Huh6DW+0+1QoNAW7diXNomXRCuLfzDrSA==
X-Received: by 2002:a05:622a:1983:b0:4ee:1924:c6fc with SMTP id d75a77b69052e-4f4abcb50acmr412852171cf.1.1767183049227;
        Wed, 31 Dec 2025 04:10:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6cFEFkyE8VRxM0b+yrpQtlOmvHQM/Qqxgrd4xJLvYLI3HpIrI34F73/M4v3Vqo3svEu2ifw==
X-Received: by 2002:a05:622a:1983:b0:4ee:1924:c6fc with SMTP id d75a77b69052e-4f4abcb50acmr412851731cf.1.1767183048729;
        Wed, 31 Dec 2025 04:10:48 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90414649sm38031586a12.0.2025.12.31.04.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:10:47 -0800 (PST)
Message-ID: <d42f24f3-ce9c-4804-bad1-f83c832bdaed@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:10:44 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] arm64: dts: qcom: sm8150: add uart13
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-9-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-9-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwNyBTYWx0ZWRfX63jGpoESo/eV
 COZIf9dvN/t8Q2tE9BDuPXF+2/tOvmSQBeHWo02URVLiAJ6Pynk0iTHTNFUGbWVuJ4CXm9I+pqM
 yrfbSYfuYNgLFh2ldAwQXyc3eVgEpksG4k3S0tAUVbGj62ip9Vs8X9Ega+Zkt1hN11dW7obdZ9r
 Vu2eHDzTnLewfz/lknCUu7XyfuY7GhY9gYqzx1041OD+VzYc85xqDfKZSZs7zGq5zfji0Ik7HhM
 KT0Zb+yK0DR59dLF+JBQCMlzJQd2MTbKbg/AkiHJyysL0IlnQv1GMj8BmkaJXqocgLmMRHMEb4x
 U663iTJAamfNHvtiuJBK5x7t5YOx2ZE8Pg3o6b1LJ9zvsE6XVqkm5bTJRXqHSpvlfol3zkUAPwe
 YV7a8WtCrjNJEevmXNpVYVn7bMHDKNhvaZxVoJ09vsGdxu7nMkXnjYjfsHw4cIPbu18nfR2FPdR
 aO1p+yNxEp9/cn3Oftg==
X-Proofpoint-ORIG-GUID: IqaxfZXEU4DUQsW0fGm2O-Di2XOWU1jY
X-Authority-Analysis: v=2.4 cv=BuuQAIX5 c=1 sm=1 tr=0 ts=695512ca cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ROe98goXJRv4GV1sSmoA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: IqaxfZXEU4DUQsW0fGm2O-Di2XOWU1jY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512310107

On 12/31/25 12:35 AM, Dmitry Baryshkov wrote:
> Add UART13, typically used for Bluetooth connection on SM8150.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
