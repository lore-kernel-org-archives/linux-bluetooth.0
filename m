Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05B72C3247
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183477; cv=none; b=kfXng5ehkZNrtak+Swwze3h+DOM94IoZaCDtQrELRZ3YPktSfeAd8G7lCtnF9CDndGOtbZvCmO125bNtBqlVA2n7wHr2vuKGUYNFu0icqZfjkRipaNHFgG+5VsulNO4/X1+Ine3NC4ZPWx+QMgxKW3PM8Lyi+GMrBJv1IzLmIcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183477; c=relaxed/simple;
	bh=gcWjQ0ei8NJ5xBZ0hZlXZvs27R2RGWslCP9YD3TTtLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFQiq8bDP8fJGb7UOxhFmz7ZLeD2/nNzDizlDhFN5WCr5bDVrblluF6ZROMSWzunap28kqIGo6C+EBZNTCLVQS0kedoXOKQH+TZr8GnzYcmw01OhdDcOgC1zlx0ILIGlOve5X0gA98Pe9TJBhIMtVk3yU5oAn5T9RZBbOSJPfio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YStJLcQ/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dqeetFvo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YStJLcQ/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dqeetFvo"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUNcXAG2551069
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ew+Mk6K5YGioVRYwAsfxjNNsouazMty9EXE0iT6bafo=; b=YStJLcQ/1gj1QPk6
	WGuc2zuuj9YusxG62FdQwA7h0YomzJC5GzziFKj+hKRHqULsP+Cw5zcTarpWCnFz
	uRnUn/5lykugUEgRu5XmtjAksJR3U2c+z53bM5DR7d1zWAjx2PLSJp+ERoSKFk9C
	mNFvcxyXdmKNaKuxlpl0ui4VrF8IxGvRGxIu01R1Y4/UXmnL2UTGncDDRAkcNpQU
	cRqjlMk9n/qmplXKUrRptyC9CM80vtB92iB7N/CVmey1F1Lg3nhvr9bsdeOaRgQI
	2PY+g1zVKxP2t/2nVpb05a5Wa0Z3x7VWztkqmz4ZCaAKgcV0FHdSiyFGL/pH3lAy
	mZVfSQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0skm9mf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:17:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee23b6b6fdso27754821cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 04:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767183472; x=1767788272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ew+Mk6K5YGioVRYwAsfxjNNsouazMty9EXE0iT6bafo=;
        b=dqeetFvoKH4HrRlWz45xfpVyz95h8QBhoCFjhirTtobQ3rki4o6z5WTQvFzsgS8Hlc
         ZB7JwPh1nz0GVYWvSRinbQWcvWlMczehNqRDrPpC7refHPnkQExQkTwu8SOiEFsR6MER
         lPtG/k16XnJ0cgG8X+6Sqt5IOmMymbDU2rCwkJSilqswuJewYJ8W0QT4V9x9sniPBRVH
         PinZLxa2Opwf1pnIe55ynpgD2/IqIHPVpbAU49YgIGcqkrg3dM2cDAJqf2Vmxi65lZwN
         I/3sC/fTqRc9HedaURC8ylQbDln5tY4zd6w/APmQo3eMtTC2os9mkw5qZjeJjN+15lFI
         lB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183472; x=1767788272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ew+Mk6K5YGioVRYwAsfxjNNsouazMty9EXE0iT6bafo=;
        b=YzS0e/yb54u2I9PFL0HQxTEB3xJxuc1COgAAsh9HyeGaPq4DPFwM0JnINblDcSNTdH
         KHbKDPmfVe4Jczxt6yHvdQzxVBNX/ERCGF9t+/gnMkiZzoOqUemUFNxocUo1qdwE2bIy
         vY1VLjh3FUg5OVCBrTrMcfN2SXX8u0cTK4NaIOh1Tewz/eEqrd8cSEff1JGmnTkUuYnp
         AZvHhAbBC987R3rqXf47nBiQXu5sdMkqgmdhFldU2jHNkcrMCIMRpOKiFguFow/cnrEP
         GJOwdwHc362jYiei0Iwmr6ayXz8XMihHqT5tqF1U1y1cVoU/WVmsOqLjmfPv/nOLOZ70
         XIAw==
X-Forwarded-Encrypted: i=1; AJvYcCVf2c6o31mrsfkrZQHw6e0HRTUX7D8+efqIXY0B2qJawkz+G04uJe/wUBi4FQOxn/XiMHp0v90VUaf3XuXGJ/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxDVDvzv7cavzkpt/qGJIcov7QoNAgrTlWDC0Yk+KsfWKVAsKl
	eCC5thjSWKQAN65weh2txrmDGqcHGti9AYhb9IAlrdGCE7VRvtLSiznijefIC00Iy6d8AuWe1Oh
	S7hTCIv1buD7uSkAzlSQNjCtUKzqQqZqQ2ELSarGbrf0EtKpvTkF0ZKhE1kFOMXfsSW0hi18=
X-Gm-Gg: AY/fxX6VQbsxO1BuhUL3PVl1DyS0K70+HwFhvqfvxmUfX96ik/4I4fq/5caO3vkEZGn
	MECx39T0OhnsKIVWy4tX1N1CJCAC171Ws8c0fHMACtDJVh5bU96S3VLzbVPTr4aOk7VZDn2Clk1
	3SXD9Jmpfy/Mjg0S8y3nXmCx7Y33koWVaGXSmczRBetjFy5tannxAll59CwL8lhEISvnUW9ZZrx
	bV4NI5zZk1ScEsIdi4iEVFq3v9h3r1TnzG1vfkKkFam+TR/ZylZiz1DfANCbMpoL32a1nNa5iaV
	mxsQ1ddysgCukCENkl1XE9t+++1JjZZp4paq2tPdMQOMDvC3VM7Ah6onLU0z+meQGWo/ECvLJkR
	S/jkdpzU+ZN3GTHf6SyJXuwk3Q5XEGuCwOle/UCmb3kHoVsL1Dr1cKBoGwG1GkmBOZA==
X-Received: by 2002:ac8:5fcf:0:b0:4ee:2638:ea2 with SMTP id d75a77b69052e-4f4abde8fb1mr390251501cf.9.1767183472209;
        Wed, 31 Dec 2025 04:17:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH957KOviLl3ff9m92xdS8YGRjjD8sUTjMZEhIjpCXfBub9SZDcdgZ+jloiUSvjwXkZhRj+kA==
X-Received: by 2002:ac8:5fcf:0:b0:4ee:2638:ea2 with SMTP id d75a77b69052e-4f4abde8fb1mr390251091cf.9.1767183471721;
        Wed, 31 Dec 2025 04:17:51 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f4ef1fsm4017817466b.64.2025.12.31.04.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:17:51 -0800 (PST)
Message-ID: <604f92a7-580c-4bef-9d13-707f6b1c7105@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:17:47 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] arm64: dts: qcom: qrb2210-rb1: describe WiFi/BT
 properly
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
 <20251231-wcn3990-pwrctl-v1-10-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-10-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwOCBTYWx0ZWRfX/SHK9+s/5Evo
 rnaq9222upGOTDVTaGTmoXNP55INAdgG+2xGIPebf9nlJ6CvtB8fbFSOfQT0y3fQk8fk5cABHVJ
 dxRSm1EuYrdKfa9UOTjLUY5Cyo8kiqQQWNuEC9//No+XHRomuHjFrjAqOwyVjmupJwAc1u77R4U
 5KvhbEexOK+wHEGAUB5pGIzYV5iMy7fGd+Kp2qeKy2QnijwEAtrbcpThfgUtzaO6Nas6h5PkE4d
 0WBtjDdSvxgAXIMDjuIAOOWbMF6RJ56CQ66iZzSzveZR9RgFpUg4aQ7HB8/3PrDzEEwm1UAAVjk
 OvoxCqt8m/fZaNUBpmyx2QQ7HBG3k6Uvp32Ut8QExKLpVvsiWpRNUAdw1xsB3cuIzWCieZd6z66
 RAVtralk5LqljEdK02Ien9mUeXqJOoSbE46uyXifRaB5iCJS/k3M8ojoNYO9miWOkdyGt0c1VOF
 9r70T2Z6JruBmWNN7rg==
X-Proofpoint-ORIG-GUID: TlUpzGgPCsp0MfMu8RFyIoav4AkQykw3
X-Proofpoint-GUID: TlUpzGgPCsp0MfMu8RFyIoav4AkQykw3
X-Authority-Analysis: v=2.4 cv=FJ0WBuos c=1 sm=1 tr=0 ts=69551470 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=YN4nVyxdPvXl5XCbABQA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310108

On 12/31/25 12:36 AM, Dmitry Baryshkov wrote:
> The onboard WiFi / BT device, WCN3950, has a simple on-chip PMU, which
> further spreads generated voltage. Describe the PMU in the device tree.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
