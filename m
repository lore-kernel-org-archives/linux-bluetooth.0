Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAB53168E9
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767182888; cv=none; b=kLBCUuavS6I0J/u4D3pb3md+lXOLtu71Q+fLmroaXycGaPwJ1kBzljf3yAnFyp/ojMlUKfSCs+GEdWCTZUVlkrdVDhNF6x4ph4qvNO/hIL9mgsa6izWy4L6CASRiFQ5Mw2t99jAJx9ozisk4V+3uj5Z3tHZ+UL6qMRgoXytCtR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767182888; c=relaxed/simple;
	bh=UmgVRndD2m6Wy75Clz1eg4Rh120+PEWhxXfNEPFzvJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyVMgrD7XvXfEkxdUCFRJY5ljtbeRvQo67mS23IShWMVtHn8UBvXm0a8aRh9fSAfWJCr85Go5o/o7sAxezBmCkpVSpFbgYKqQY4kMWnYjPRsZWBeljv5T1Giew0Y4HSdgyPdX/vvdffqHXQyT8rOsrxV3oFkBhIU9KCssfqcMLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JYYetMHs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZrKX4M3N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JYYetMHs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZrKX4M3N"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV04CtG2551303
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UiJtaHWpT52Ir4SAEeA1tuRYvR+ztp79Uz63Q9MOA7o=; b=JYYetMHsA9nLPALh
	XQ8f+wUf9nxQMuIwnd38JtG7hDZLzN4o4+TD/ckycxr+7gQaMLh50EIYQKZ6oATk
	qcll+ywSq6o0u/AHb9VB99ttFSGI3DUhoa8R31nuG4UeSmyecQ4+sHfamSDb2oh7
	LIjvbTcCuZTBVs6wArIevnxz2V03nrzDOuG8pddkbTUTiq7OfvnjZ6EAroF9TAMw
	XdYPvKFGP7jWjy8WS7i8AGO9p1sHEpzj14B6PcjsKtB0hXURCwzqKuXTcoJAOXXm
	psWe8wkK+kOx394c7HiWsu5MF1nkkvBcWBg1ArsyrKiYAAibjHW0/kZdckgMsM/Q
	TWuPbQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0skm93k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:08:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f34b9ab702so28120601cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 04:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767182884; x=1767787684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UiJtaHWpT52Ir4SAEeA1tuRYvR+ztp79Uz63Q9MOA7o=;
        b=ZrKX4M3NP/+XZkHQ43VEno7s4099ReUYleOwtEVL4R0+sZVH+JSt1Igb13nbsvYtsV
         y00VuPZNa7rJOgPMTQl1jq6LA44aXkh2VQ/AS2cwHCaBgVdgzyoEe5/EZYtb+CbIpHOm
         aPIzcfBY9xCTQwcSIgCHAs6iDw+0m8xqzNDzd8v5XYmxknWyww6MvzPiSU0lC3e9DpDe
         fK5lhHA7z5KmDeLCQ2ff31vfrpUqI4YBBghiy4tQ92azyjLx2C1XGdzXGhuQ97wRhwzK
         AC+SfXbjn3dNsJoJmkSLlOuUAKuaBGZNwqfr6rd/E8zz6/gurORPDL8SZuUR8g09JYll
         QBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767182884; x=1767787684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiJtaHWpT52Ir4SAEeA1tuRYvR+ztp79Uz63Q9MOA7o=;
        b=F7+Ted5opbtyVRcxVyEWOUCHMe+oPVH3agbinNmrharF0w65oJpk4Uuze+FoFhW1lR
         x0k9xJEBIkoqCTLXCEmevn3pfUv28Amoiz3CdbtLTPCSyWIbjsTNO2uj2tJnpecQ1OKU
         XvtiEz/+lJ23BOY7Ow4w8cwYc5anpeo3D6f4/E2CraNLy9LLXshxGYrWpir/HUN6unrM
         mgvvwIou43RZjOFUYDX4niZRFlOWrG46dGjpHSQiPkDvlkV0H5Km+Xtoe4Z5U9GsC70M
         tnhVRX2nT5EQvXVVjjS0PRfkCmSrJROmx/+hTZ3k2BcQZeerg/V6oRw2DKFBqebkgIie
         FlKg==
X-Forwarded-Encrypted: i=1; AJvYcCVuUHqPRogSKDHT/rB3W07X9WVdr/T/JFRgqBIGeR26/MDXD3EcHISuXLfROSs2yCSB0K3S0xKUhguwZKVJQ+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKP1peK4psYwCIQbH+KiGQkLJPO+zQb/0blXhSGRg39nbzYSq2
	zZL87crysLBd+6I4IHz+i6NwPQQ5xZ3Zf4L+STEREhGeT+xMv39U46XAplRXkW601b8sjbCnggb
	GNv3ShpLXbyxSgw4r91frsBK7AEYt9o7OjErOhOk4OnFytFPf812jLaQJgIsARJ8zc+3R5MQ=
X-Gm-Gg: AY/fxX7L3qEssTAf9TjmDZNqilhtvn8uJHTON8UjyT2Ba6Jgt1jWEErOJvnxlUAn7ql
	Br8OeyIm29bMNjaVX2AsGaAf6Yzl/5qRAZrTk+nO05CrwudV45ybNHWGuEPDEptVnkC19T4V84J
	abZXJ4ytEqUudpMRHm/LxKQqjlmGg6vLQOd5GNBB5nUnr4GJEi2PhMp/NdYr08J6ylWa/k1mkuI
	X+QqvuhJE3BnSLax979ikjzcnhCtC4tA0CLjJDonfUyzhWrLcR7Y9Qa6Mvbe+w7rGR2h0lLkfeS
	fdF5culDSILEagVB384dgOw9sJdfqibfpRLWNlUykpxCuJXjQ0m7CfNz9FBjzfA2o8lg0uMn6Cb
	M8N7/kGP8RgAPL0lhDxVr/z6+NNmVYhQXqKBulYWVKdb4E1SOGa78leZbL01K5LUs3w==
X-Received: by 2002:ac8:7c49:0:b0:4ee:1a3:2e79 with SMTP id d75a77b69052e-4f4abddcae9mr410146831cf.8.1767182884078;
        Wed, 31 Dec 2025 04:08:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiPNC0oH8EFPcBv3otDppGjXcWFCcR/VT+vF4VQNNWa4RvyRS8nRSCSTA96lyQ4NSKnYSHFw==
X-Received: by 2002:ac8:7c49:0:b0:4ee:1a3:2e79 with SMTP id d75a77b69052e-4f4abddcae9mr410146421cf.8.1767182883666;
        Wed, 31 Dec 2025 04:08:03 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159a6ebsm37604637a12.27.2025.12.31.04.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:08:03 -0800 (PST)
Message-ID: <83bae671-3174-48e3-b9f8-412d21f8f18c@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:07:59 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] arm64: dts: qcom: sdm845-db845c: drop CS from SPIO0
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
 <20251231-wcn3990-pwrctl-v1-7-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-7-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwNiBTYWx0ZWRfX+wWdY80aXpFg
 Ireb0tr9KFZIIKzTUBpdsFV9cDOkbcEeRoPSbeDFoW/E9/9gDoNkP/f5A8QjHN6M0UGem9bCuG1
 Tewiyt2vha6b2ZBR+R9ZyqFimQozeaf9HmnOBAjHSlUEaEP+gdTPHVQQAVosNwdDfvvREJC9WOS
 bfqCbqzU1Cr6RdBdTEFG5lCP8Lhu02jFvdYNAtU8jpOJagnYxQMG6u8SFFBhE5dXQcBEZY2Q11X
 F6KYAnukJT+ydJxOBlf6IKumiwm0fuAX4nwYmeTqD3OQt+oMnwEbqbD9Uyx/3R2cY7D4WckiqE5
 bS4CaN5v/vp8V7HXHt4LN/esjeoFl+kgHwL2yQj1IV5DP56F3YILBXuTWCxLxkP1tCLfJ53V2eu
 EN9Fva4KpkOMbgNdSBfSI84iK9hEkxOYGJrhvp7xxMR85Z+IOenBoHeEViQkQjn39qmRb4PsPme
 X90lJOgkkhd5vUrLrJQ==
X-Proofpoint-ORIG-GUID: IA_k2DEPXcg6W0VjtIpm3OBwUETNpWm2
X-Proofpoint-GUID: IA_k2DEPXcg6W0VjtIpm3OBwUETNpWm2
X-Authority-Analysis: v=2.4 cv=FJ0WBuos c=1 sm=1 tr=0 ts=69551224 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=wl_8aIJEU-qjyxFuvXQA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310106

On 12/31/25 12:35 AM, Dmitry Baryshkov wrote:
> On SDM845 SPI uses hardware-provided chip select, while specifying
> cs-gpio makes the driver request GPIO pin, which on DB845c conflicts
> with the normal host controllers pinctrl entry.
> 
> Drop the cs-gpios property to restore SPI functionality.
> 
> Fixes: cb29e7106d4e ("arm64: dts: qcom: db845c: Add support for MCP2517FD")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
