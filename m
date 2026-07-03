Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2EF3C09E6
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075131; cv=none; b=USs3xVCZHfhOMYvY0QHpC9FNWIkG16D/JyL4SbXYBNOlXZk7wBygsvxuo1VJ3FgpBxJgUfzjOwKGLXee/4337Iy2PBom1SE4jfDKydVQSV3nB7s/aDlC/Fp5Agh5dXPkoYMq3KWxs2qreUv6ARZH+gw2W3isFawmMGYI+cOVQ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075131; c=relaxed/simple;
	bh=TLZfpXNa4jTlpCICpFrGEXH2rtYeXj7nHX5GHDbou8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VE9Ob87rqO8Q9s7dlQdxE3wPfQlDX6V4z5m620QEpLQgM4wNz/Dlk3RLrMLU+GU/q4UxFrB9hMrURkhmwc4JZ9wp2Ud9nZQeQvVgCNgLGaB5aXiEnr0jG31ofXC7PpbFEav+0rmBsHOlUpT76EuZ9evNsjAnkbqxNufNZeEW568=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eRvXERMv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OOZ00OBl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eRvXERMv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OOZ00OBl"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rjeM3123373
	for <linux-bluetooth@vger.kernel.org>; Fri, 3 Jul 2026 10:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a3RaEfFYDUv0hytKdheuNDDTJLMkZO6ds3f7R+dKZTQ=; b=eRvXERMvJqO0khyF
	nE45Jp5cvL8zvZtV71e5sx2xQn9KD7LdVoOD8hU+jjZRdfArthDN/z2DMUDOQ7AB
	dQwRPb2637T/vXZhg9ACdZn0S2AWnOe4Ip2hdTsduVyxCJHGA5SRoYCma+pU2rFf
	/i3Z5/iIkStFR4QiU96wDkqaX3QH+ssHPACrsXeLg2ZwAYwBuhtbrZ4O3uYH9dM9
	ScbqyI8mEGA8FFc0Ckp8GuNBS0QZOYyReOrQz/Yzr+XEpDSDTLD7xhGRCoGhB45k
	Irp9u+gGWoG8i8wdcGtwuiSrqnxxlKsZAlPhAJi6ZfeVJcM1rjSgENMf4xNSDjFD
	byCAGw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qnpcw0r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 10:38:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c069f73e4so1399591cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783075129; x=1783679929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a3RaEfFYDUv0hytKdheuNDDTJLMkZO6ds3f7R+dKZTQ=;
        b=OOZ00OBl15fsaLUrkLQ/i6e1Gl3OW4gLCoFapxrzbwlE8n6JeEtUYJQfiRby8y+7G8
         79mF1v27MKLOlcietanv5AO0LKrM3zW7LuAqdOJ1+rH0BaIWzXvWEjxanQHYlDiVQwae
         Z61BQbb/M9O6D6Ss1EI3vmAy/LC8SuqVUhRQAa11SRnf1nCPasfb4e3hk6tWl7ZbHrYA
         iuCgTVR9Xy3f8onoCrCV+ONRIRdrjI6xTHOwPQ9oZZLgmlzMZrn3vwDfVMBj0bRrP84R
         8MnR+Ks6GHijLM6Srgo1pqEKi50BoGvhV+PZ/ErA78HSK/6AH0bMQQHRJ3cOSUT809Sq
         C49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783075129; x=1783679929;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a3RaEfFYDUv0hytKdheuNDDTJLMkZO6ds3f7R+dKZTQ=;
        b=lJwnBkcsHBjBl1sNSvspz+Qa+0uU4WVxdrUZZGF+zT4PJszskG12Y0FLZDFCfNO48Z
         MjUCz1o7OJPV42twT5txiPZjbTBovDQwJanXWbGzdPhPbjC1SI6YPbq/zJBCwz8iacod
         bYBei4Sn01SGJagtuXGhXntIvDpOtcA/GcsQr1Fk7Rue1kyL4DRMA83qhPRSmcShUmLq
         lrGxC+BXiOMqr6IjeE1LvjjsnPPAst9N7a0ig5RRDp2B6Pv8lMgISlnWW5fnOhNTJPDm
         lZGnigkD3+UPby5JKbnuhAES4ZjE+ZRdpAG15saZf7OVn3fke3NpuCSvH7En3WEiLrPA
         NGxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8iqv5lyu9zuesj+Kseree0V1hnTe55meBV+28Uk2CF/mGgCG1pbAvKo2wfCcOSbIei/7a8NSpQhgnNS0ga9T0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6fiePJhRQ5+cVot/4juyljvTXqp7AfVi62h3mmEACqJHg0ai
	hUhhq0zoe6XMbWTK8Tr2eQat0BXkTpakgLFH8ow2wEO7N0VfIvmsE5nNBJYxlquAbKaTy8kM81T
	xc/MTMojE0kEg5ApPYqYu2VTlANB7nmee4//OvQDztK8m0VMm+gegaSMjWwwZaPqHcTEUk2lOdK
	IohiI=
X-Gm-Gg: AfdE7cmOYDoXLz44kDyhD3Lc75DXqS+N7X7VldtQkJE+8EwUvxIFvQ8/E+U7jrTLalX
	z8m2xEoVowdmrpCopqMD6WLvT5OvWsJyhtM4NTg7JJhZ39qoScvM7xNHrkMftTeg6gZcRgIDe6f
	FtCIrfgdZBpeIbB8OJbN1pIkX6xhQxczqqMATHZiD/fxYrGYLAa61vnZ0W6vUoc0NFRSEZhQUkp
	g+qibEvjfPzL18Wvmur2ZtTRZc9Sr2ekc/4M0cv4E0wFGtG6c0jDcT3XWMm1nTS43hxgYL8Ly/Y
	MidcoOJbgRQskJICn9h/UelneRGpKzNxE0ydU2wVAG6USGXS0JYar1TAela7ei9+H6ez5mlipQ3
	HsIDGLKUyZg5w1EcmS1qmObbR0MCNUXsnhLU=
X-Received: by 2002:ac8:7e8d:0:b0:51a:88bd:95a0 with SMTP id d75a77b69052e-51c26a41ddemr98177321cf.1.1783075129098;
        Fri, 03 Jul 2026 03:38:49 -0700 (PDT)
X-Received: by 2002:ac8:7e8d:0:b0:51a:88bd:95a0 with SMTP id d75a77b69052e-51c26a41ddemr98177071cf.1.1783075128715;
        Fri, 03 Jul 2026 03:38:48 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6091b60sm261765966b.14.2026.07.03.03.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 03:38:47 -0700 (PDT)
Message-ID: <bfd5b522-da85-499e-a36e-b303bde791ef@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 12:38:45 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] arm64: dts: qcom: ipq5018: add nodes required for
 Bluetooth support
To: george.moussalem@outlook.com, Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260703-ipq5018-bluetooth-v3-0-62da72818ab3@outlook.com>
 <20260703-ipq5018-bluetooth-v3-5-62da72818ab3@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260703-ipq5018-bluetooth-v3-5-62da72818ab3@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEwMyBTYWx0ZWRfX7SDlZz/5rV4J
 S6OWMOSZUL1v+4CbY7Tw6ZIr2xPabndpnxdZBNPDUj+xN32bXCSq79rfvoiKKzSynzlLm7uogoO
 3mu6Gvy+sSInjOBYiB8rXuUV9OMYd4w=
X-Authority-Analysis: v=2.4 cv=FoI1OWrq c=1 sm=1 tr=0 ts=6a479139 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=UqCG9HQmAAAA:8 a=t82OjkPGvLD1vuDj7LAA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEwMyBTYWx0ZWRfX2LruzA5u9U77
 /iKMgIQGx7rHMGZ+K42FwE8dEXiIi1KjAj2GDspE5rYKwKzNplFLXUiiJqZI0laQQZ0nzaAf/Ns
 MrGo076zXNErpy78dHBQYr8TPdKkqRmD4I+h5//gEC0IWJvCpwwJyy2vAbrgbUN+aY2UeQMgiY5
 hqq3yK8sJfgR+DwPj6rzrWSrZ7FpkoKeRzMS71+AjJ4VxvY95phxfB60LEAeKXnakOZdiwjIT3r
 Vx0alWabbumh1rYukliSus5IuWcDBwIYwGtcGXehBfRAGNUgl9m3PpcLFzl2+w3N6Hxw9W71xWk
 1ruPH/0fiS2t9Ud08DAGXFfrTR3o75rX5fFZrCvoIy6b6F238V2Pqe2awLV3xsFP9IB5JDFriTe
 LUCeSFgfBq6aB8dGruV72wAkvMB0c3hRs4ojBFR0VCa8hhiHxEET4xnkq1qZMOU+MU9qhK/9icN
 Q6gIXw6xmb2HMfT9DIw==
X-Proofpoint-ORIG-GUID: XKFaqB-YIswHhWRuICZktjet6pGqaX9a
X-Proofpoint-GUID: XKFaqB-YIswHhWRuICZktjet6pGqaX9a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030103

On 7/3/26 7:01 AM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Add nodes for the reserved memory carveout and Bluetooth.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

[...]

>  		apcs_glb: mailbox@b111000 {
>  			compatible = "qcom,ipq5018-apcs-apps-global",
> -				     "qcom,ipq6018-apcs-apps-global";
> +				     "qcom,ipq6018-apcs-apps-global",
> +				     "syscon";

You'd have to alter dt-bindings for this to be allowed. But I
don't think it is. The functions to grab a regmap from an OF
node create one on the fly

Konrad
