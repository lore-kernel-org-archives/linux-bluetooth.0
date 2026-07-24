Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5997A3B9DAB
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784880142; cv=none; b=UPpI++c2LC6i1WFBs55CnSRyf7mkyR1/3uLbMghNS8wUdb1Uy240pkYmY7UafgWOiX5u0KDjmSpSAZUDt09NJlUewi5QuFueYLNJq5S/QlAJB1l3PsfRbt1vglJD0bbMSnCDYh162jyMJ7O0vKeGwq6MxQrTVqLU73+yqjkhPVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784880142; c=relaxed/simple;
	bh=eU1HJeg93SSr/oTa8pUhai6mKfyTGLRRMjqX6oMMAXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+wMzfPsI58MGJirSsY99+oJh1ijnoCN83K9Vu9c7ejgq/pMngHDgMyNNiEL5ZyfZXvD8xtDojfXSWpkU2G9PxvQBot1fZjWPzPFeakgwoBa2Ve3GxxJTGkri3gK3PU/J0a3d6IxZYWTk9o+jg5Zs7fBegwICBkkEFCvJXptogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DV7y2KOq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Il65q+C9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DV7y2KOq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Il65q+C9"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4leRc2163501
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 08:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iHaQAyJrwMTgyLoUAt+XD1qDXwZG4W1qzyvi7HKMkZQ=; b=DV7y2KOqjSEhUawT
	v4IA1OmOmSYhH3VsuvRF5Hmw/o7KXKzN+HWk/aDuj8wVGokQyZ3PqNWlhitQa/j1
	Sg+KoJ/pJxlBBBl27GSEd0NZKuROF8P3N2B7onVkQaagLyd5PZ2qI2w023qQfZpU
	BOhbeJywI2OTyKyIuD/wVgvv2rLb6ikLkLQrRf2rxGsuTbHxkYqbKspIw1ckvjqh
	MnR8F8VRy/826nYXxIkZTUdPlao9lxeG/wMSzXOYeW3LPlq2eu7Cl58WaM2G+Z/n
	WtAwTN2C6kX8jk8iG3PzcHklp+e45OeS63oSzhgjsl8T2vGdwn8O+8svtZ51Eqn3
	IwniDQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkp5vk5q0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 08:02:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc8bde6318so3548465ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784880139; x=1785484939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iHaQAyJrwMTgyLoUAt+XD1qDXwZG4W1qzyvi7HKMkZQ=;
        b=Il65q+C977HQxgsQtjTfIQlzHIaEFJu6cLX3dbk/3N+IixWTvEQCdO2UMBLuPz42S0
         /Qn5CQoOziPIMApegE0JY5VNTKMimsiI4rsS6t05ltr/+Num0cHQKo7kokt5A8r60N6X
         3bhyX1ZqNzVXxW5KPuVsspXGuMnTtX1obmsEhCURCnMKQiR4ijmXV1Y33JRo/y2cHf5u
         8e0D5lM5xIm1p3rfefsoS2A5fhe47bres3m/U70qUVxfdPRKNfqQr5XaoYUGya2dgSyW
         W/reVGWj+4x/TqNg3uhYYu0v6baeliKBD3mnWkLu9T+vLdx/I3OVPOfAw4dcZXyfQtQD
         zRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784880139; x=1785484939;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iHaQAyJrwMTgyLoUAt+XD1qDXwZG4W1qzyvi7HKMkZQ=;
        b=bq4L5MU/izWwLkaUucU1e45QF+RoVtGxF9bYQbXwrzVAVUg5jygxwLRBNUNEH3t2Qq
         LgEKgxHW21dfIqdIf7TEbJVX6Tcstv1tlcI5E3Pg9nWzmTsTkxOPVhUVqqWMYpGsjlJl
         fez9CGaQ3FAJ2WKBwkvRYwP9P51WCAaVVFePEEAjBhgtfjse4n2eZ2GCbvzJNWANV2/4
         ZTVlxDfpZ9dRO34lzoO+MxzLDv6x+67SxNQnZH4BbwKxeeA9/c7X1teQOGPruyhJn8S+
         Qx8yFa1QTNJ6ocwHppqonoi6XAfbNUOceh7rgDhLykUqft4TC2fQGWRoSkyBMlXaTLcT
         V5yA==
X-Gm-Message-State: AOJu0Yw12We/p5YrppnXvuuTObgMivQbH7Ns047w7Ofh8LBpNx8U5Ac1
	BGFVOa0S5ZMhF6Lf0o5pap8QTI+0CNrNVzkxAqN9HX0Kc7f6mvDOlK0wwFbpc90R6+VgIch0jyr
	hrSCWl193ExsSQj9Wng4Bsx+C1psR/c+GnKUt171BQdotxwoL+HBionvpTkBoSWQHs1z2G54=
X-Gm-Gg: AR+sD12yq1U/qvskMdt7q1oMTX4Hhrqlau7poY1DW6A4Q+2sDxJOBPJA7F5/G88FKrN
	NVajDi1cDHoO5MG6o0X2pRfwhJKgx/8RsP/IYVB7k5AP6tYRSFHgovu1Ven3QqN9dG3QfcIjsSU
	tLD1k2iaI0EsRwqaRoS8TH3wFhaJqX9DTqVY1Zu/3KyTel6DIQWp7sCcJDBW+Zq47K8ero0LXPB
	OZKtyxtHvKfpz2Pwx/opX6Oq3HVQW16DXt+e4/YJUHwVoPwTZj9xTu5b3hZ7hDcsqCpqDuXYZLT
	eMlMeZejVBCei6UrXSebzaFRCY/TDEyLC1Jrzk8+zFNo3ajTBroBRDdnJuBUAtbbAWX5q5okKs+
	H1tX8y229ZSLI4s7464N6ro7QyU6xd+8=
X-Received: by 2002:a17:902:ce05:b0:2ca:ef16:8e8 with SMTP id d9443c01a7336-2cfa708d1f0mr73509405ad.29.1784880139160;
        Fri, 24 Jul 2026 01:02:19 -0700 (PDT)
X-Received: by 2002:a17:902:ce05:b0:2ca:ef16:8e8 with SMTP id d9443c01a7336-2cfa708d1f0mr73509025ad.29.1784880138738;
        Fri, 24 Jul 2026 01:02:18 -0700 (PDT)
Received: from [10.217.252.136] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efe3afbsm46566895ad.33.2026.07.24.01.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 01:02:18 -0700 (PDT)
Message-ID: <7bc5d5cb-7f35-4eee-9e3a-695fcd39db6b@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 13:32:12 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: kodiak: mark PCIe root port as
 bridge
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Bartosz Golaszewski
 <brgl@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_hbandi@quicinc.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_anubhavg@quicinc.com,
        quic_mohamull@quicinc.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260723-rb3-industrial-bt-uart-v1-0-3c8e580c09d1@oss.qualcomm.com>
 <20260723-rb3-industrial-bt-uart-v1-2-3c8e580c09d1@oss.qualcomm.com>
 <6a30c443-ed57-4443-aa34-f6bbe5049370@kernel.org>
Content-Language: en-US
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
In-Reply-To: <6a30c443-ed57-4443-aa34-f6bbe5049370@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3MiBTYWx0ZWRfX0aT3MhYmrM63
 lvuNU/BXhRlSsm8dwyjLYqAi1a3aT51FEEhWYHEOcEuqUJ62/aucm7te6YwCNgF7GlMPu5Yuxuz
 EQJ+Js28B82ILALR6hde5o9wXzjfmck=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3MiBTYWx0ZWRfX7QcOdNFkFReu
 +QQRR+VZO/enkW1l+mAtFDDp1AZBoRwqD5Ihfgy+k39O+xIPt11TToALfVXdQcK+QmLslYIOFzY
 dxMaJ3Z4FecQWaSNashfOfRKL0WuCu9FpPQiVmcXuThROSNQglJHkIh09XyNEyB12Te9fenZEON
 E1iZirlcEBWpiFrmqKV942yhMzwYnvXnUv+RW/ZVKQKAP9PPuzNF4Z2nqZBuMe3kbwC0FAAkNcn
 k3K0KcvLbUL8MFiYBmRlGtxvoxVnNnQP5hxFC5Ge6VEhHeMOSTLcn6vWxfZAC5EYv2+5DSdX9kT
 gczUoEWlKNs48X7Eh8waXT4rkrmka+BG5ri9sCwtdx1fiGJvnTKmTEvCsRXd10BsratZydDMkFu
 X1o2CMGs6XIzUAj49jXY6oXtfETk3gESxHtyGhQC11iiXq24fNmjC+K0hiIPi7JBW7MAyT2v4zg
 f8HOE2Ev3c+40wSLcxQ==
X-Authority-Analysis: v=2.4 cv=Z9Dc2nRA c=1 sm=1 tr=0 ts=6a631c0c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=vWUw25gFCHY1kBUJboQA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: yJlmcMwJN_osJd6MJaSNGhLt8bSQ2g7B
X-Proofpoint-ORIG-GUID: yJlmcMwJN_osJd6MJaSNGhLt8bSQ2g7B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240072



On 24-07-2026 01:01, Krzysztof Kozlowski wrote:
> On 23/07/2026 14:31, Rahul Samana wrote:
>> Add the PCI class compatible to pcie0_port so child nodes below the PCI
>> bridge can be matched against the enumerated PCI topology.
>>
>> This is needed by the M.2 E-key graph description used by the RB3 Gen 2
>> Industrial mezzanine Bluetooth UART overlay.
> 
> NAK, there is no such overlay.
> 
> Best regards,
> Krzysztof

Hi Dmitry, Krzysztof,

Ack, I will rework this patch in v2.

For the commit message, I will explain the reason first and then describe
the actual change.

For the overlay reference, I was referring to patch 3 in this same series,
but I agree the commit message should not justify the SoC dtsi change by
referring to a board overlay. I will make this patch stand on its own by
explaining that compatible = "pciclass,0604" is needed on the pcie0_port
node in kodiak.dtsi to allow the PCI subsystem to associate the DT node
with the PCI-to-PCI bridge device.

Thanks,
Rahul

