Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B3237F8DD
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770651834; cv=none; b=HemSiL2hduRmbawl8owH55kGU18UY29qE38NVSnFbb56GEWhgAd8dBszYJTLzoiOKRd/SMp3ANAMr7aZvb9r79yHKzimLUtqVEU9AU7/YfIJOud/6sgzYUeP3kIic9OcjcLr2gcrHosqbfx3wn2MUCC65aN4yNpo63lUkw8xvd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770651834; c=relaxed/simple;
	bh=pejDHyWUpgYcyOlJ64FLXWGKSBF60+zMdKwBdwSIais=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hz/tEEX3RLpyBTfULy+V8I0vGTQQHdMoqHqb7mtSnRQVQ7iubE1ryfK2uYEwH3OTnIdTCbBzQBtSNwuGwDpxQuutzj8D1aVRoopBpVmozRyp+GmqOo+EFFz5gDgmZbHy/4vNJcqqz9qpyFzN6IRusFfxWOkquYC5aWM91rwi1Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FQtse8AY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HcuKkMbb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FQtse8AY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HcuKkMbb"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619ApFmY2586852
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Feb 2026 15:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FOtvKz5XsYK8DeBlcq3YrSmTR4LSM+UOfrV33PKISmk=; b=FQtse8AYZRVjF3UU
	JSgByOh9HyACVFbNxBxv/6j6M9BMPiXtUmOTYEz9Ua+MPkIqPMRNRM/M35JneDkW
	oPtG8956EBfUH1b5yFZGymhkXrqhhrosF4wDkmaOKhAVZnuh8b3NtuXzEzQoLYzD
	OC3Zb4ofdv6im6MM8ummEos1dyVwNH3UYm34BYkg+RYFdsRx3QTnTmKLT51CGjez
	dGmTccjZOwXb03NLp0fPEb8tcCIU3U40ptYsWjr35tjn8QxxdQhsfKqzffjYxG2S
	+3Bb7dOpmyuZn8GkP22iMsdG7QxTwMWf2jjxkFlAa3yzSnD3vjnCpetfsgQesINz
	fYn9RQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c793bj2c3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 15:43:53 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba66faa692so1046774eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 07:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770651832; x=1771256632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOtvKz5XsYK8DeBlcq3YrSmTR4LSM+UOfrV33PKISmk=;
        b=HcuKkMbbMZD0JcJ1d8LoqNGMQf04uSD1eOmIUW0RnMIWGJVG/QJrocqOcbjl23JHmA
         IvVCzp8qgzmOqUeoM7G5LlLY327qoiLR4h9/G5DcExmsrUBV+l5xmWlT/ylrDxV0IfVe
         70zJ+oNCrxvGcohYRDc3lT/lUeefGBMEFig89moGjeDEODHm0YI5FWGTWAd/BXB3Hoxe
         13f560iWALRMq/fFkRz/SJ7FHDJX94MkgqQ3+okTQgqLB0odJfLpUKgfFK6FpCLOaK2d
         HYofxajUrJuYQ8ioeFYmKydOW0aYoGsB6aVcR52bnci2Lepb+meQOrHC7WWKEIdCuXrG
         A/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770651832; x=1771256632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOtvKz5XsYK8DeBlcq3YrSmTR4LSM+UOfrV33PKISmk=;
        b=Du0yd+uy391F98S9agNY07Xldrgibz2Ae2Av2IWImBxnL8oQHtiT6QP6Qn9e/Ar2OO
         7HzbKh0Ia+PfDggXSZ4ECecOxIpy03FWl3EuTMTGyxZQ3aLARjzBsEt+Ju+GsZXk2A2I
         nyFwgcBcYQ7kIG44FMNnxLj9/+c4ZENxLHq2sltnZktOlAdIQPVYKv+d9ScCQtuv7Dfz
         6j/E8jxZAWQUnZJqGOWDfhAlvZkij6+Tww2QVDKTg4cgF1npts5KfbTr67QLqWSPr7sd
         ELfT3Y0kgOFqT88IN+pZ5eWNPq2cIYNwYh2/sJw0s2/7TL/UBLrW+E5zbY3W5MB5IOiz
         1dqg==
X-Forwarded-Encrypted: i=1; AJvYcCVHjd3MXa0GsU1NcaWvHHc4IcbAOuEkkwZFyfZAO4PODokVkXmdduZofIaOGlIpj42lltJhRkLTSOp8uRGYpIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9AfPSgKV0ayO2qc25eQFkOsVBL4lNSbrig/ab2XNfGGOuTlWM
	kjx6nIVD0JfkrOUBYX0/epYkyj1qamBACD9O3td+jlw/v825eqMRxKG9ZgYGOEYeX5e17H1LGaM
	JG0/PNWIAM8Z5+W1mriDQSeqbJ3whx/TTf3fP/nNsJQqkr6VxuGDa4rScnazefhPkLw6zXds=
X-Gm-Gg: AZuq6aIOhYcVdoDRom0RXq9P8WlGxTzawEL1nbclf3fazjmgNkn5oUCR6C0g7suKNFZ
	GrYAzvJUZPolEnvNUV1mcZrYVfVUU7ePd4XszdphHPpl0UtV2qLlwSdZXc0yGljaoU780e8V0Jb
	xG8EvjCAeuFck5koAiXrRw+viEGjO9ipypMrC9oBGnKSSaXfCfbIcdQk7l8I5SM3NkIUzDvMZy1
	DoxP7PJmtvk+/7qCWqehhq9IVsxIkq05S3rZLqbIgfU6ebxgKo2SCWzLZMtyq9WqFxGYC5sbDG+
	g120Oo8y1doXgpphmD0Y1y4jgXyNC4LgyJ77RqL5slCtbehqJtmLVFx5cnE3c1TBjRX+9XqtuZw
	zDpZ2a3trgr+ENo0d3y0TGhs/PYTm2IXq4xijZo4=
X-Received: by 2002:a05:7300:54a:b0:2ae:5d3b:e1c6 with SMTP id 5a478bee46e88-2b856724153mr5412650eec.21.1770651832081;
        Mon, 09 Feb 2026 07:43:52 -0800 (PST)
X-Received: by 2002:a05:7300:54a:b0:2ae:5d3b:e1c6 with SMTP id 5a478bee46e88-2b856724153mr5412625eec.21.1770651831309;
        Mon, 09 Feb 2026 07:43:51 -0800 (PST)
Received: from [192.168.29.235] ([49.37.135.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855b0f624sm8742742eec.14.2026.02.09.07.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 07:43:50 -0800 (PST)
Message-ID: <8fab20ba-9924-48a6-b417-5ebd28b77cd9@oss.qualcomm.com>
Date: Mon, 9 Feb 2026 21:13:43 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: net: bluetooth: qualcomm: add
 bindings for QCC2072
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260209080613.217578-1-vivek.sahu@oss.qualcomm.com>
 <20260209080613.217578-2-vivek.sahu@oss.qualcomm.com>
 <7cb9a945-651c-426d-8cc7-1ec1174ac68b@kernel.org>
Content-Language: en-US
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
In-Reply-To: <7cb9a945-651c-426d-8cc7-1ec1174ac68b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ctOWUl4i c=1 sm=1 tr=0 ts=698a00b9 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=z/GpFUkVOss2g+jQkJ5YVA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=OcUlRVwiwL7_3OGRxjQA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: oZHLTmCCcsz1I5snu2eDxz7Q1MCaT5ht
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEzMiBTYWx0ZWRfX2VUU5/FDNhvC
 a1+760Sz8mEi6qiHUQsTkOtMlEIzkqeOCag1EX4VLw05XoTUQbv7yqB61kgxlhS45fibfYgzbR4
 pLSu0GcaOCJmEXPxvXqhUcZWxzuaub3O5iFPH/npGJ5I7FYBWBkgj/8QJYDKSHo4o6RshLHGCOq
 volVnS91wjJDbtH8MdHMDR33aXPYzPffhMVWTM2Xw0sKe7v+0cyJJsE+0ihiW+cBeb5RTNLuvGs
 Kkh12tRccDZJiLDhVSiYoNgoQRahy/D5hR/jQyifBkOTaJUAXg69MpXd51MW85sHGhKfMo+fmQv
 rMOgsh332OQ5rliwbrZ82qv+xVAXq29ZkrC6HbGLaikAnqSrbeWKIEN3Gq1muLiDdEKlVv07xMU
 19G4FRvnlCHHdsXsizA3I4QPZzqiH/epltrauDCCZwv8y+APf92xZTAM8OMvCezAgS2C6zoCyrh
 2pyM9LEaxbdeCI3JseQ==
X-Proofpoint-GUID: oZHLTmCCcsz1I5snu2eDxz7Q1MCaT5ht
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090132


On 2/9/2026 1:37 PM, Krzysztof Kozlowski wrote:
> On 09/02/2026 09:06, Vivek Sahu wrote:
>> QCC2072 is a WiFi/BT connectivity chip.
>> It requires different firmware, so document it as a new compat string.
>>
>> Correct the sorting of other chipsets for better readability.
>>
>> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml  | 3 ++-
> There is no such file.
>
> Best regards,
> Krzysztof
The patch is updated on 
"git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git" repo 
but it appears that CI build is running on 
"kernel/git/next/linux-next.git" where this file is not present. Let me 
check linux-next branch and see how binding doc file is created. Will 
upload a new patch set based on that.
