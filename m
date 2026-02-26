Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419EB1C4A20
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772108154; cv=none; b=bTubCGxgQGsNyCCKdC+W5qyS7Uw3mV1FhdFwlsXIfTJUctNLvCI1C5/VRFUCFJ/3HSYUe/1+CtRhmTklDYz+j79vfuOVNHSnm0oi5fV20ELU6lHwe/1IsClWxJoTeW53ZHcDFmhgkOSIL7yi8WrRlnihO4pHpf+UhCYlqJaqGsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772108154; c=relaxed/simple;
	bh=lXFzGCAdVLAd5URIMznq+00idVT7o2TBbY32aarIi6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHfsvezCG5i2LIXxJPt/thF/0aiFy6VXhOKhwbopPpn+VeH7t1+7MjKNIde4jMx4BiFwLD5vs9SXSO9Oirq7pgPRhZ8CDfHd3YuNbiPnxiOdVTnEwzEor3WR5gfItBwHnrASuLACFGS7qtCT5InP3xPppUOc+n5Rytc21WWAN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ADcYTt9E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iCtpEsnB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ADcYTt9E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iCtpEsnB"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QAL3mK369074
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 12:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vX5qcDAni9HAJLNi0K0MLyXHwUQcxdvzrBmliUoqx4k=; b=ADcYTt9EN+VnIw0R
	Dh/Ko51ROBcDi/iTPY1WnkLkbIcU5ge9mLTPCkrH7rozcUjU1XutnFQ29dN0ZVqE
	pqZva8W4vSqiIXXOp2HIlydTUmnBeqBYCVSw2aqF7l+vhp62muO3WmP+kY9RYTg6
	q7DuFbcJJCSWpvwPqaEvBDqtNUqZesWpnUVgu/HtTwOeOMzS1x3EatxV4hRdb5hX
	B1DunGyPEvvY2qJNL5Ytg8w2bcLG017pKxofNTh67B+VMWOCI+A8xg425aA6O59X
	A7jrUpj72msLsF2vdaAziKXRRlMCm9JEZJeYLHqjM6bS4g+EVJG6oQUbxOsEbney
	5UzusA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj8bdadh1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 12:15:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c710279d57so62142385a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 04:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772108151; x=1772712951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vX5qcDAni9HAJLNi0K0MLyXHwUQcxdvzrBmliUoqx4k=;
        b=iCtpEsnBip2djZdCyU0i3i0dFfD02m3Pep9+wWKeDs/8TynAHHCK4gvfhfOLXUqYzl
         +q5f1f5zNgOpBH4dwY9GgLsi6mJhYccHQBHNBpTZYcKqTK/49p4TmRSeakEbm07DxVCP
         by4MRj5CWMDJGSeE1qiANNgKbcwzKepr+aicwttJDsBDF6oThWFpFiw+x0tPPP7r/lmI
         ojijlYUtW7AKuJsM2snu+78ZIjb79hgEB5zZaciGK3juOVmWy0pkiUewLZh279Ce1Zke
         NPtlOWEh2dUFd/7BGF7xd7CtuG/OXT5VDQAvUrKnWMG5uOzGjINV8xhLvccpHpb9hrAl
         jHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772108151; x=1772712951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vX5qcDAni9HAJLNi0K0MLyXHwUQcxdvzrBmliUoqx4k=;
        b=HzRYHzW4/pusCKYTguap6yOYKm84dZRszCnxoU+XLkEQ0fDSfnDOutvDOLnZoMODfr
         TclYZCcTn8YwGidmnqSmZsi3h3NhYpQ4000SilH1r0JdD+/x6di0bCv6ZQKis9yHJdE/
         oAXRff83/XJa8LVIQIb7EzVl453xbbTRgQhZ6Z9qbIunIS9sC7mG0JrKAyBIAy3WAl9e
         LGrIi+GImREjS2JugGWh7PBjmayY93di4wW1Kpbg3Bd85TAoulxYGUatyUS6zAPIi5T8
         +T4rddMHdUzhlKggPNSCBwPdx59omrZNfymg7M0TGYy6RJ69Tx9knV+NOWkHiAqqzWKb
         +Z1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYIu+6AK9pEehHS+OOt6tzjH50cs1fDy4mnq/Gnlw6JG5MRK8Js0jMOvXLIw8j+ZTZ3OiYALXlUqBb5fTPf2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfPCjjQYTuJlyNM1Ps+GmMhIEI8I37KCRDBesIu0MR+ZHAs2Cp
	szDa6QM75TAvslsd2uP1YGSctuLyBsfTzTBk5/RReaJuNs8phy/JOf6bo6u2Xb9IEU0L6UUCgGS
	vrTh6kYgoqDndTuKO/jXjAuHTPicwWAapF/vl+BcQxhgSq47vOoL/Rc1Ss1Cp9yz6m0k3wrk=
X-Gm-Gg: ATEYQzxFCoDjdqNF2CVcEtu4QU7gtUTev4JZJqKf70qbR0uSEApjrvlZgWzsZiRTrNH
	zJLP5wtsi4uqpJbYRsbVKXt8xcDEcMNaHhyZm9sz2EMDb4SBCVTGPxqFRgepuKvcIjBjT8S9+r0
	4gMlGVfYSPn8GGDzNIHMN/QsEEzsjZvYKQsSrelhSCoVXVpd9d6GXU405TQydv/jgzgfwJZ8JWx
	O7Zl49XO3qicDMEZWmg6lRVWPeQT7KCJv5V2YsbWRLp79ngnJTLNzTGuoNaiwrKRfOLJhHjFySh
	hGVDe4xR8iM3t79/5OfTQP2r2YgOSN5RmxtHfgxy0Kjthb5O+qN4Yyl4icuiT/bt/tzFv+mwH11
	DwaNUoOwlcCwmsjW+n/Vnb8nz3WGnaMv65l3OXK0CpQtTkmtGb50p2+D6XcnUM8z8E1KWBy+4hD
	K0Fl0=
X-Received: by 2002:a05:620a:4706:b0:8c7:f61:eff8 with SMTP id af79cd13be357-8cb8caaf296mr1765672585a.10.1772108151249;
        Thu, 26 Feb 2026 04:15:51 -0800 (PST)
X-Received: by 2002:a05:620a:4706:b0:8c7:f61:eff8 with SMTP id af79cd13be357-8cb8caaf296mr1765668885a.10.1772108150750;
        Thu, 26 Feb 2026 04:15:50 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabd4695bsm436468a12.12.2026.02.26.04.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 04:15:50 -0800 (PST)
Message-ID: <e544645a-e113-4ff0-bb1a-3a6577d6a83b@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 13:15:47 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth
 support
To: Wei Deng <wei.deng@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com
References: <20260225091700.286108-1-wei.deng@oss.qualcomm.com>
 <954f6a53-b597-47dd-926a-adb5a7513edb@oss.qualcomm.com>
 <c1355057-486d-4852-8fbd-f9916786de06@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c1355057-486d-4852-8fbd-f9916786de06@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FKQWBuos c=1 sm=1 tr=0 ts=69a03978 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_q3aKey68L9-M7rtS5oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: q_9Fmjdt7BAhqhjxtTR9N0V92i67ZgJ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDExMCBTYWx0ZWRfX5qDiatd+sf5s
 fngr2c63nzj5c1Llw3LSeUTgUES5N3FvHuF1mGiqwGTyQdvxYpZ7uuzIoJic0+dvqKycfCy0BjO
 0MJMA0RvUwHA1uJ32VSxMZf5Buib+GYhpK0euX42A2+qSRPCBYY6tylupPqgyeN7j/6kXdlgPbp
 btCC61Bo2O6mXdoGiiGTPRIKQBtCc6fMKLiUC16oMeF0R8QOv6sqLrEwQClA2Ar2A+TI9khLIZh
 +mWEksIG4N0tA+U2a8XZ4uxSwCuOH/oQNACEvmD7axjIJfyUE19IST3ZTzON/PqWNAW/H49RyWY
 5vPmGxSrGVGmboG4CKuV2m0SUpbpzvwirytsSumOR3l/e6l+qAaNmb1ewYZayDLu5B65IhQCmm5
 cPfHWWImyb20Cc0Adk1Kp2wqUVEfUxkL/sh+etqREa2XbCtFAT4oMYI+L492NiZcA4Zdn5IlL74
 3TAut8nBIJISxnQ3wBw==
X-Proofpoint-ORIG-GUID: q_9Fmjdt7BAhqhjxtTR9N0V92i67ZgJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260110

On 2/26/26 10:14 AM, Wei Deng wrote:
> Hi Konrad,
> 
> 
> On 2/25/2026 8:27 PM, Konrad Dybcio wrote:
>> On 2/25/26 10:17 AM, Wei Deng wrote:
>>> Enable BT on qcs8300-ride by adding a BT device tree node.
>>>
>>> Since the platform uses the QCA6698 Bluetooth chip. While
>>> the QCA6698 shares the same IP core as the WCN6855, it has
>>> different RF components and RAM sizes, requiring new firmware
>>> files. Use the firmware-name property to specify the NVM and
>>> rampatch firmware to load.
>>>
>>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>>> ---
>>> This patch depends on:
>>> - WLAN
>>> https://lore.kernel.org/all/20260122053624.4068718-1-wei.zhang@oss.qualcomm.com/
>>>
>>> Changes in v3:
>>> - Rebase patches
>>> - Remove unintended 'output-low' from bt-en-state pinctrl
>>> - Use prerequisite-message-id to replace prerequisite-patch-id (Konrad)
>>
>> Only now did I realize you're the author of both patches!
>>
>> Next time around, please keep them in the same series, for easier
>> tracking (since they're very much related)
> 
> Just to clarify — are you referring to the below WLAN-related patch and this one? 
> https://lore.kernel.org/all/20260122053624.4068718-1-wei.zhang@oss.qualcomm.com/ 
> If so, they are authored by different people. This BT-related patch depend on it.

Right, I seem to only have read the first part of the name.. sorry about that!

Konrad
