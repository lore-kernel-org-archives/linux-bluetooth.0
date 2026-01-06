Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9005922129F
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767667181; cv=none; b=FkGIXRHl6opvz/dXmgIQ7zO2cbJ2cXl/M4FVwcjXH2UW8Ue49FvnQFoGj6yNfxjqHtuKCNJPF+/ZzQblJ4ClFBuA1jZvM/gCd2C8kwN3mz9r1Ftm2MZVD166ckka/At1djpHYgVtknWhcsNw/WUaSMpl41R0hzapERTBQC0WHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767667181; c=relaxed/simple;
	bh=hTB4fD+SnIRjCI5Os57oYczxRZilJ5YBn87gFUYBfBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKq4cerTMhgVyaLvTecF0Bzp02D6+Gl2KnV9XhI1u9l0DlCCLck4zcEwYHbqgchvUWDrTDMOApf3oscRimc7iAFLoTnnvWtS0tIYXdMjknE+Tar7YtYC9Z4xUlDwl5V5nF3JDxrtgyp3njLNHXFGvOIvCms/16b8RYw+1smRzhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A4Bj5AYK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BDiejOeI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A4Bj5AYK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BDiejOeI"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nbdM2943900
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 02:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NltUFZ8Kvfxzp9EkpX/p5NI2dH6GPKLbj/KuIpRee+Y=; b=A4Bj5AYK1qll9esB
	coqnsbQlsA/anrdwLe2zXCUoA+85ai2ibTvfNj+OBaA28KiYtwj0znh+68Aay//4
	svbqGF8flAdn69Seq9GLmQGWdzqAH5Bw+7j7qO7aIpcuOf8aJ35uxUt4Z+ejCcsN
	Ru36Ciew1/rYthDOcxqG8JMo7JINKXtWugeulDmblssfg5PxDapCT1UpuMSSKpql
	rAuv0fQYVWKehVw8RIG6npmDB0DcQeJ2TIZDTq4XvblajchImm4YdH1qQmWAammQ
	5mlrGkYUgJ9hH7RTXot4rdR/Ws3lHsfrB7N/2eJANHwFCA91gudmuZ8aemDVuepE
	8ruryw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgfv01p3t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 02:39:39 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-bc2a04abc5aso424858a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 18:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767667179; x=1768271979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NltUFZ8Kvfxzp9EkpX/p5NI2dH6GPKLbj/KuIpRee+Y=;
        b=BDiejOeIkJ40hNdczx3USrlzVGEJQELsFPwLyaW8Y5nQSyxp2PlsB0NiVvIvqvUzV+
         HiXmnQnnqIG2QQUP2oHI8i+cuQ0mRBQTYijD1q61glRLo79t+fW3LVL1lUXoRGwkXdJm
         N6pc3ObrLoSS37iH0FCNLBvZyg4Mh4g+djlZWw1lNbEgab8Hbrjleo26bAAy4L1wvE97
         5K09NSzF0NpYPUl5vRiqUj5ANLJY0HhSM4hmvMHBMGoNR5MUuVnIuX4fYGfxAFVrL5EV
         ICwc1HUcdsdyvEN2oPyL1Ll75qJTDofbtxbreG/5Eroa9iIkLKRhgdHQ6lPUcW7LptXi
         Z0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767667179; x=1768271979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NltUFZ8Kvfxzp9EkpX/p5NI2dH6GPKLbj/KuIpRee+Y=;
        b=FbbFyJKsE4uZLscKEPK4BZma7IdR/AonuGWMtK3rl1Fk+CCbW3yg80vDq/q9hg0zzL
         kKUdmhTj/drIDc6wu70Im1QqC3KVsqEo0DeVS8kSUau0kFEKipxNzOKPm+UXUWkIhh7E
         3v1KsmAxvZWF8Y9X8YiMIi+QjIDUHg39kMNyVs30kz9IHMcMd6TBFAwtlsJosG02wmoO
         6E59ibRhyxaCd8KmGta4MChavJBUOFKj/ilw7iy51xqwxFcMYA3rljYMqimC0Hdl51tZ
         NB2j9S9DYxQ5xcyJFJEfPhJbapcI5G5F0IszBJdf+Xg4UqPog02S6gl7weXH0tIuQLhH
         OZLw==
X-Forwarded-Encrypted: i=1; AJvYcCVYGUsoOuHyz11qHK3GZ4apMsYSwqqj185WL4QH3R3YOvIfqyhIGnkdJ9rRrHYtuU5gkNro2B6E0rVp4pM2yvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1sDDn8xMTrbtV9nzu2Balt6+869/I0bxOtJanjkM1AEZ7XFEC
	YivcCP/G9KIYX+8G7TGQx1/PpDUhjlKzemIKXYCwIv84NF7frfsfsGiMwVyNCfC8z8aGhE60ZP/
	HFO3FfW5W/UGf4vu4nL8+RTVBJUeCbqr2CioRSM5Daz0X89W2ZNfrP/DxbSaRz2O1rHk6fxw3oN
	tSe3M9LA==
X-Gm-Gg: AY/fxX6DxEhqNZ/iC5bqZyVSzqH6jdnrpyCP4PTrGoii8BPnJQ4nruzLEb+nb1LVzzL
	GheNXBLI1YYagQwX3cB64+TLLGNh2gmR/G0pg/axGcmE09iOAjPr+nvw6UsfULn/iWkaCtqVoZE
	9swCIWwmLNyKKNL66zctb8STGdPPEtNY05vkXcbTPWsKM+DSeGT02EEgZAOBueemX72oDkgPgG2
	2vwDRWCbWwXNPKD2DljYxErVNmpXfl5y2EM8wJLeT1q4XP1sxBS+kZQ7vlWPOAiWagEzK1FjyOI
	f4eQOSch0zWrJQJGjYEWqpciUntK22wO8589bVz5L/cKt/r+Hl0RyZmXzF635sH4pj4d/WYix1Y
	IBw/PLo4fT25hLmbneV8zOIacXfYTDhzLASDpzo8vi9vZE83RcauNgwv7LzRygXtA
X-Received: by 2002:a05:7301:5406:b0:2b0:4c33:8e41 with SMTP id 5a478bee46e88-2b16f8eca3bmr1037921eec.20.1767667178973;
        Mon, 05 Jan 2026 18:39:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRrLoWTYikJbsEVNnT3PE01iHJxcTTp0zsKYplfnuw1rCWOjWPctDK6C9AhO3OUWsROb8zng==
X-Received: by 2002:a05:7301:5406:b0:2b0:4c33:8e41 with SMTP id 5a478bee46e88-2b16f8eca3bmr1037893eec.20.1767667178473;
        Mon, 05 Jan 2026 18:39:38 -0800 (PST)
Received: from [10.110.93.66] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b2256sm1234417eec.25.2026.01.05.18.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 18:39:38 -0800 (PST)
Message-ID: <9745b711-4c12-4219-92e2-425a954a67ee@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 10:39:33 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/1] Bluetooth: btqca: move WCN7850 WA
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20260106020738.466321-1-shuai.zhang@oss.qualcomm.com>
 <tfdeucc7opjtjuo723hskens3te3eg5ohm7db6tbhompbtgkkq@vsqgz5qtmbr2>
 <6d29459c-2cd8-44ed-b64f-6947cf620960@oss.qualcomm.com>
 <CAO9ioeVCRF1ADsrXeHzP7hKoudvMQ1f6cZPDx5jt_8C7SLmYZQ@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <CAO9ioeVCRF1ADsrXeHzP7hKoudvMQ1f6cZPDx5jt_8C7SLmYZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e9YLiKp/ c=1 sm=1 tr=0 ts=695c75eb cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=NnUceZfHqhrCt5kD85oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: lbAxFGVkebyEOM869g0bdmi33mZFcaLF
X-Proofpoint-ORIG-GUID: lbAxFGVkebyEOM869g0bdmi33mZFcaLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAyMSBTYWx0ZWRfX/t5d4h11HOSh
 FWp7awp1m9AEQtgtEPF6hODv8tVIkArz7OGTJDhtCGQ2sdOrwi6zqyadQkOvzC/ryA+soDNHGxZ
 8t4eo4Yo1TA0TqwSHOZTRAis8z+fScnSAf5+V+1WvZl6kGH+T8K90C1MPK5tYN5UlY6emCWb+gV
 ddZrcmAbywk4Fj1ZgYHw0w391Bwk8I82USnbERGhDQSMVgtUILZlesJt05KrJ4gHusW43uwU4TI
 7syYLJ5AnVHEWFxLQXUpu/SfxgONvME2LU+X3lHcL0ZiCYeBw8+LRCuYhWDjciULnkw3qeAaRAo
 SdEs2SbSbOYuNxIJi1jwKbNOzLV9SEfR6zen7BRhAP2EFqDBAoXCxNYxFGriH+liSNK0rjr1xl3
 KkKAng/ctAMAGKHJlG2+ECx0zmkHrXKebx4LJPXe1pIb+oP4ufe4izmdHo+bogsGqykb3kLWAHR
 vtFzkNTas9kMc1QYfiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060021


On 1/6/2026 10:32 AM, Dmitry Baryshkov wrote:
> On Tue, 6 Jan 2026 at 04:21, Shuai Zhang <shuai.zhang@oss.qualcomm.com> wrote:
>> Hi Dmitry
>>
>> On 1/6/2026 10:16 AM, Dmitry Baryshkov wrote:
>>> On Tue, Jan 06, 2026 at 10:07:37AM +0800, Shuai Zhang wrote:
>>>> Move WCN7850 workaround to the caller
>>> Why have you lost the second patch?
>>
>> I thought the second one had already been reviewed, so I didn’t need to
>> submit it.
>>
>> Do I need to submit a new version that includes both patches?
> How else would it be merged if it is not submitted in the latest
> version of the series?
> Have you read Documentation/process/ ? Especially submitting-patches.rst?


I will update the version, and I will carefully read the documentation 
again.

Thank you.


>
