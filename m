Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073153A1CD
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765197018; cv=none; b=GD9jyNYrCGhdPJ4mSyB6sBY2O+i4eu9Cvo8lnO085YWkuaBCJcP7akON6viq6YDlQTtN6vr7HVPbt1UworBGwMQkMIJWFfXp/DzNBquL2es1XWMV6jrwEOhxUGftKyoV6x8lA9blcVlSKwzV6fSYHCVIzIym0yHoVjQn8NYeaYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765197018; c=relaxed/simple;
	bh=tvE3yEyAy4daQLQ5Wyhnvk2QUfrpYDPinxHrz+lmDFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVwmp3KZmuPn7DMN67XUO9YdicZ33DP7XsjBcsPNcmiOU/ziVp5fNhCFQlecd/yZmRvWjrpoeF54c2s0DqgmEx+sBf91QfAXxhO56AXd3DsbhyAVYijJCFaGwHH3dcn03bQVYzy1HCP1eJDlKEYFCEHvtZ/Y6pXSIcsUQz596Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LxIu6/UI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cSp+8VL5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LxIu6/UI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cSp+8VL5"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B8BQS5w826756
	for <linux-bluetooth@vger.kernel.org>; Mon, 8 Dec 2025 12:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2eXnZnC24HFsuyCEmtzqxl1/jfqjCc/ju1FAbAmsEsM=; b=LxIu6/UIBjWA+Y1a
	n+SrpQcOPn0ClfX49SwJ/8I2inCbEqyZysxr9PryNnyPSHibT4E3GNPfTm+DmBOM
	I925bMvgJ6ruxHeghbeFGxXUyDfy2d7nC8RAsNFfa65dSqlC7GuxraAHEqG1W53Z
	qn/Tjc81FPqzejp0fp4TzY/4XR7RwH1nJiArBWisGKvfibo9z7++NUHWUa4F2LEt
	u95xwN/xJRoHib42cRfWuwOjoMjEfPYieEsu0wNUfYP/Udyw8egYnDLqWVp0Gaxz
	x0ly7dZt2J3LBw+XozUlWZ9yo98IUm3YRWCKkponWCq6oxVozCyBD2tWm2/LVm24
	m7dvkw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4awwt885pf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 12:30:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee05927208so12584671cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 04:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765197015; x=1765801815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2eXnZnC24HFsuyCEmtzqxl1/jfqjCc/ju1FAbAmsEsM=;
        b=cSp+8VL557Xyiy2hxZt/hdveIKUC871gR6c6rnr0Tr5nDQGWlXRWX3FqUspPbmNECz
         D3aDRpKnMMB8cxheSOc+5C3TLiqFZs5Y+Dymw7SwqBoSqID94GyRfjAfLYzB0LGLUe5D
         7Kd+3bsx3+61A+Vhv+awb6x1gm6O+MQcERUbA21cZqxLoBrz7L2g9/NtnADfIJhT3vqu
         lBM2xrMSW2YVH1UsbczsORkNLs8YJ/9yEcAdM98i4mN3+I7k3dwS0qZhTxLbj3AX2DrM
         zzC4BQGi1BSz98ucyEhH+mhdPdvtpFP/7mvnNOeeKOo4hnV4iI6jn4CAyUJyug5ZyTnf
         2Olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765197015; x=1765801815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eXnZnC24HFsuyCEmtzqxl1/jfqjCc/ju1FAbAmsEsM=;
        b=X4J9SpKdg4RM7BudzpZmtmHZ2tjtQ/51DB7lDBtXJyvy+xGmeSQdo/7pUDyZUd164/
         o2sTYYZajxJWrHcpoVu0J5WRxnY/qg8OVJeIvsgPMNp6BKY6Tk3oDqRca/fWj8V7Lhxv
         +7MP1RYg+adlnijPe8JddDPuCvEcn0OLLOzm1cFSpWHXrb0Kfm2/nEM51Jkf2Ab7vbaG
         F+V1c+KovIkKj7FREaOArfeoDCH9+SkEg4dKOc3rT07lhu5HbjX/qMHvZvarP201+8p6
         75bZN75GqZPK3HwlV21jK7Y32EXPRKXnNnrceWjYvCDZnCgHws1Y/dkY3K2tjh9MBy+I
         Ur8w==
X-Forwarded-Encrypted: i=1; AJvYcCX63TeseHb6u22V8SziV0y0l8SOiHppJu2iNgsnIVPNu5CBJqZuOJ+Iz0B12FVoICrFMZKQ3eb2zO+3IrKf8mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySERBzGkWZCea4Xj4ucyeTAXzEA2LHYdwEUbTRUgdF9gjOtEGt
	fNO5llZD038eQag+FpgS0KcobOv3jj+ilZxOhe5lUG6uXoMPpr4H/O5Ae6yaVTGE/TOR+bGzC1d
	DxW/KeT8C3E8IRoJty+NND/Yj/1tIEWT5IC8n6wchTkRUTjdWgAP1dA+ovTCjP1XO2Y8MGBg=
X-Gm-Gg: ASbGncs3jeSc2vVyCk9Mm7oCgYQl2KHxtRSG+wWnW13WmqOGOGCEL9XaUKYRt4E+OGQ
	apQIWJNub2R8hOey+nWoef0jAdqOksNobMlHsn9LIUgAdp1BxFxuogsavMwSGsThAkO1wnRR2QE
	HvQLHGYhkEMBnIzJCI5j5UhMTXB9nLteAzzgDd1OGxHE/sUiwOdh8ntUS/kgLsfLRi2aFL15c+k
	acMXzKceUublq9f7dQVoXbkrs3lYlJe6gVUL9+OtlnfP9GqBbEilDETv9r1vdms3BRgHdBu4FcK
	IcZumY9/scKKRV4T74MWe1EwuRezeC0pYMajuTgwZZ4p4XpsjEyKELODCdLxinLrtrs14xNI0+B
	+6/gXcsn6OzvfRKw1R5oTsiGL3jn9k75ppLBtFMb1uwusXtEu/v4FRuAeWiOSREROng==
X-Received: by 2002:ac8:5814:0:b0:4ed:b409:ca27 with SMTP id d75a77b69052e-4f03ff3581dmr83068901cf.10.1765197015180;
        Mon, 08 Dec 2025 04:30:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHN8dIYNJ6Z4DPGSecx8HZD8c5NEJY02Ov20zUdRBdX3vOoO2C/UJIXa8KE0/kz1cVASRlD4w==
X-Received: by 2002:ac8:5814:0:b0:4ed:b409:ca27 with SMTP id d75a77b69052e-4f03ff3581dmr83068481cf.10.1765197014724;
        Mon, 08 Dec 2025 04:30:14 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f449ba82sm1098192466b.22.2025.12.08.04.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 04:30:14 -0800 (PST)
Message-ID: <10077527-0295-4d82-b60f-e566ef5ac076@oss.qualcomm.com>
Date: Mon, 8 Dec 2025 13:30:11 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] dt-bindings: net: bluetooth: qualcomm: Fix WCN6855
 regulator names
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251205-topic-wcn6855_pmu_dtbdings-v1-0-165611f687c8@oss.qualcomm.com>
 <20251205-topic-wcn6855_pmu_dtbdings-v1-1-165611f687c8@oss.qualcomm.com>
 <20251208-soft-beaver-of-justice-ae6fc4@quoll>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251208-soft-beaver-of-justice-ae6fc4@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aKP9aL9m c=1 sm=1 tr=0 ts=6936c4d7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=mXBmC_6-VigSCe0QBTIA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: X4l1y0zM6jlThCQ1kIeyDR6-Rz4xleh8
X-Proofpoint-GUID: X4l1y0zM6jlThCQ1kIeyDR6-Rz4xleh8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDEwNSBTYWx0ZWRfX4294K9tCy3Ga
 med1dZUSY4/773vHvXNBwH8dzji7SVsnGg75lwJlHSxCld2zP4dztgalxJLAR1wx7ANDPSg9TtT
 gNpRwZUXO+HaRy0vBDN7r147XROd7sT2LcEw9HJAq25j9U19TWrf2sSj9UwitZrVuerHfoLW/vi
 H1YczlGpXXkyAsOjytrkDmhUhkZYXvq0YD7spXAzRKrh8T3W1WjOVb6paey2l/C+QJPvvrPEZYh
 5upTSjgOwMc9yw1QtABinTQQiR8AYYWLztJJ9/pDxBy7dDL3lN4MyrYmyDVHJf6KMSzz7gA++dy
 7VAJPMqXlQNTuXXFCdYG9Hu7GF2xIiSBIUhfA7J4MZ3Ew3OUcE9CoLFmIV8nqoRrkfzoL8cR01s
 pACKNUPDn0oyFXDQFHZEyCxqIoShmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080105

On 12/8/25 7:59 AM, Krzysztof Kozlowski wrote:
> On Fri, Dec 05, 2025 at 01:47:20PM +0100, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Commit 5f4f954bba12 ("dt-bindings: bluetooth: bring the HW description
>> closer to reality for wcn6855") changed the vddrfa1p7-supply to 1p8
>> for whatever reason.
>>
>> The schematics footprint for this chip definitely says 7 on the input
>> leg and the driver still expects 1p7. Bring it back.
>>
>> Fixes: 5f4f954bba12 ("dt-bindings: bluetooth: bring the HW description closer to reality for wcn6855")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
> 
> This will conflict with my series which (for whatever reason) are
> waiting for 1.5 months now:
> https://lore.kernel.org/all/20251029-dt-bindings-qcom-bluetooth-v2-9-dd8709501ea1@linaro.org/
> (I wonder how many maintainers need to review them...)
> ... but I can rebase, no big deal.

As explicitly mentioned, this is rebased atop that!

Konrad

