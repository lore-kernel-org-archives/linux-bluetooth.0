Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594C82D97AB
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315739; cv=none; b=j9otSVR9kDhjNoTq+SAoIEGk6ZQ0rbfjUyZqrAzULenLsm2Gn0OPzRnDFi0hhfIYdV78Dmr1m/h8jaViA2aKa6nJEwkGtYOFJmsyW/YvXIvH9G78SLBP7922i4Y7cVAUqsLSFk0ubnZjbEfwoR/rqWeWpdebtKtrX1+o5MD+3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315739; c=relaxed/simple;
	bh=rJSXGs0qmlV4yY94G4RzjP3fvNdmxV1EujtMkx7W+hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0jyxKOjus9zP1/TqxuCGa1+2x5jLUyzy2d2ISRtkGQEeunPbqGDQRvpqcVzfKy6isRejhQfO0lH8ZHIfXaignLohR7BTW2f5hJUYWa0ajnQ6TbExHex0TUNcZS2WStwXV3YR22mYE6l80+4pP+yA6JSoF5Gas37TnkVwrd5ppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b7nvkxL+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rog7+L82; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b7nvkxL+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rog7+L82"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GNUebm2417581
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 08:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CKPdjKHIyZEmV+w4LwJOMfNyPVeO224qAfDUWQc/Pwk=; b=b7nvkxL+LZAsaAzs
	aQRDYelLVxhBpxWbWLsK8edzWyWjzy6K181GfVmJZqkX/84F6Qns67ll94yLpPEH
	HXa8DbtBtixW17rqIUaLpRGt5pPlP+fwl5DMOLeo1Qq2am4RBEPFN1MYgr7xzq69
	/nj4yosh5ADBVeqe/fLvcuv3Kqr3qpa8Ixb3e8PfDUktG5ydrb/K6pCeJ3vndq3a
	gHEc/33WmDoay60LM0ePFvqiGFdVwRGomgB3+dMiZ3HNhqR5h+cIO07eYLcc37WT
	+qwecsm9XxjzPdCUdmuNIhevqvKKPgdLA/LVR7w8coZ8gLoFWIraeH5oDxp+N5Nr
	P/hQ0A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6tm9grk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 08:08:56 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c6e18f1cb86so12660963a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 00:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771315735; x=1771920535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CKPdjKHIyZEmV+w4LwJOMfNyPVeO224qAfDUWQc/Pwk=;
        b=Rog7+L82GuA/JHm8GpiK0xNEwmdAlyzuyVWdnQ59wQOw8BQLEkhRA5r+cWKGLL/5F+
         xL7hlsqOe8k7BCyaYHpez8nxuX0P79IHfpKBFxm+TC2HTOafQAJsnaG6PPnLK8l3fQXL
         2Xu21HfQ0sf7dZ3qEQnxT84NbsP6cVYn2JWRzIKrMBgWhdI1r09nTDrUjV7z2BPLFkb6
         i+CMLYSqvzIw8BjV07iA9S2Db+DcZHlfICWuMomPKIjtsZIStW4f6vqFXv5A+2VgnpG8
         c6vuh3NETHSokndO/UyU/cdoqK8Uv1JKfA4tGT5dCb3FEekf9EhgEfzJHQM1znQywaDM
         L9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771315735; x=1771920535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKPdjKHIyZEmV+w4LwJOMfNyPVeO224qAfDUWQc/Pwk=;
        b=hrVpBO3yzjpm0hUxJL+V2TvK67QNAiv+D0oiN15p30DJ07sL7d427d59wVAWDO+a4c
         548ASpyZILb4wEueKsIEt1FbzJO7IYKA2/aFeI3/EEGyE3aAojAY8JaKXHExCa4z6JDm
         IP3fJ1xheCgDBjKDQ+e+QMRUSixjCh/y6JMbAXKOR2i1h7YkDVIwdIQKBPtb23//eKbR
         DtCRDmXvJCrEGCp1l1rknWDSeGExy2HuTIp/Mgahva7nGEBl3OPrtZ0tqqWRCqRE2hb0
         SJtlRF+fGT86v18TmHptYze07K8Ny0ULpL76tdXIXFv1O3scvguBSrZ3TURUY/pIyMjv
         BnRA==
X-Forwarded-Encrypted: i=1; AJvYcCWcwylgLhS1NroAVpssTBmPBVKXZZyWC0SI+AAj4zmhPPWAr82QOX4ws2ypqAeBK7bBXzQhzKldOHnS4GI75M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwayzdOfura+eiAObljtCcbk6g2hcCnejFASmd1AFw81pT3ADYC
	J3TKpBaOTp33zE6r8CiKvkIVWlZlR9GnsDaACi4hnnrClyATmLL3IDTeVTeie44Ug/swO15KLjS
	bCjypilS6UglVkLKwpT7kczoiA1LiDAULIwRisMFNAJx9pKxScndNMK4VI1H+GEk/9si3w9w=
X-Gm-Gg: AZuq6aKcTIBPwGaINOI7hfDTdcHXuX2QbEvuZjSfVQrycmmzMo42b1ziYbh3BhCRkak
	VQo8RaDqr/pOG5M/v8W/AUKCohg8RqwyfHGruCDd1yJTKUGfQCizouUEfbApK+yajVvaw5Fp4mX
	10kJxT5US6mEF2GE7QXYkKysXhhAjpPZg+SsAHEMv8CutLu8r8lnz61TJblsFfPputo8+4KT1Dm
	WZfxHIBspNEGQcyBJ/9Gf2891eoiEp69omMLk5arWdVWSuuy+KaHXTTtKrobNlf8VIPJub2+m2g
	YEvYP7uDdKYf5Cg+dKFYoXyHQjhT3jIGDwFzwgxqz0eeAOrMQ0hby+i0t0pW2nx87+gPDcy5zI6
	v4M911ryF1HxMIi7B8LolHIvDbRfZjKJ8aMeZdzlNvAYgk7Lg
X-Received: by 2002:a05:6a20:3ca6:b0:366:14ac:e1ed with SMTP id adf61e73a8af0-3946733da51mr14209044637.63.1771315735291;
        Tue, 17 Feb 2026 00:08:55 -0800 (PST)
X-Received: by 2002:a05:6a20:3ca6:b0:366:14ac:e1ed with SMTP id adf61e73a8af0-3946733da51mr14209025637.63.1771315734827;
        Tue, 17 Feb 2026 00:08:54 -0800 (PST)
Received: from [10.218.16.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e5332facfsm9014266a12.32.2026.02.17.00.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 00:08:54 -0800 (PST)
Message-ID: <dcbe7aba-0559-4fe7-8c19-abd9f74f5221@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 13:38:48 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: bluetooth: qcom,qcc2072-bt: Split to
 separate schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, janaki.thota@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260217054731.3058567-1-vivek.sahu@oss.qualcomm.com>
 <20260217054731.3058567-2-vivek.sahu@oss.qualcomm.com>
 <20260217-avocet-of-glorious-romance-8cf9ec@quoll>
Content-Language: en-US
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
In-Reply-To: <20260217-avocet-of-glorious-romance-8cf9ec@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ebIHRJ_QCzemqxfY53rnJZGjxIv-Twd3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA2NiBTYWx0ZWRfXyyQM7s517htU
 EcJeMTOUZbe3ZNcAcrPKTdFB1V0JayH3ErlKRmXyXJbrmBCfk6+jmZ2G6oY6Yp0vNyQ2ylYbr4P
 X4d6K3A4cW5ENIgCk3XmdAahyd9J7kNp3TIW/qfzGgIp7JJ04OcsWWg5ZZ5Ve9q1KqO/tczeQ3n
 V6GIbwVtdUeOjRu2F/Si/y9hNEX/3grmubpVYPU4xHlizq8DH1NavqLJ2viuXuq6xZo5xCyGsM5
 8nXGz0Gw2MuWJfZL8UQqHpPTA12oOa4t8ET+9NwEcMmTVvcO5GLdbHBTAuEQI0Ftmb/2ekmpv6s
 CNMbcmolkAQYMqhemxFyVNaueXSy0EjnDcz3X2vSfcddZvnMHIxsu8pugRje1u5P4p3VB8kgXjH
 +58M//Nr5KKziFXtKpZMf4L+QtaJymEs5B7FDv5jbNmAh0KIzIYX1+91B80k6JfJvAS8bLZrqdx
 ALnb9CYgGARAEeTS8OA==
X-Proofpoint-ORIG-GUID: ebIHRJ_QCzemqxfY53rnJZGjxIv-Twd3
X-Authority-Analysis: v=2.4 cv=IOoPywvG c=1 sm=1 tr=0 ts=69942218 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=X7cMRLG0ekiW5Bl67NYA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170066



On 2/17/2026 1:21 PM, Krzysztof Kozlowski wrote:
> On Tue, Feb 17, 2026 at 11:17:30AM +0530, Vivek Sahu wrote:
>> One big Qualcomm Bluetooth schema is hardly manageable: it lists all
>> possible properties (19 supplies).  Split qcom,qcc2072-bt to separate
>> bindings, so device schema will be easier to read/maintain and list only
>> relevant properties.
> 
> Huh? I do not see any split here and I do not see how this commit msg
> relates anyhow to what the patch is doing.

Let me re-write the commit message with more clear information about the 
patch.

>>
>> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
>> ---
>>   .../net/bluetooth/qcom,qcc2072-bt.yaml        | 48 +++++++++++++++++++
> 
> 
> Best regards,
> Krzysztof
> 

