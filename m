Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19A4DBD8F
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621047; cv=none; b=gWI2RZDFQ0dMqm0vQObkPczKZGHBzqteblk6yy4l4utYXD7YbL8RdeMlh5VIFpM2fOJIEC+8ItiExgWmre0roJCyrPR0IIupnBjknjQiHHt7HpK5uH7d74FUnCohCI02AUKhWNGMJdSkUIVRJf9V9xoQq4+xc9O15ZUOhovmRwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621047; c=relaxed/simple;
	bh=8jCrSeZHB1v8sGHQ98I0I2rMmqYVExTJMSbrKIT/U/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AW2B5shWAaO9rV6p63+OV3bdwT305eHk7oO7rWPVr1zSwxQqIcq0yP84x8i/slXYUjrvrxnJdmKTFKOOVE+KLuDcEBA1qQGyDMrKEXpEJVqmsNiiJUg70CZyeoAsDLN5Z+tA9cYPLwl5T3KwL+Gp+TFMVSwXES8WLaUFsZphLZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aVU644Hr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hjEqnsFh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aVU644Hr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hjEqnsFh"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HY1Td2519005
	for <linux-bluetooth@vger.kernel.org>; Thu, 9 Jul 2026 18:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nDO0ELt4xarDeNp50XpZhJxN+arGp/U3imA7JgKtXtI=; b=aVU644HrqqOoF4nF
	mP8RoEKHZkKEk7dN+pZMQXH3kgreOIqDge4xpwRBL3StEw2hMxfraILexrO8dWdX
	TKyUGOVSuTsLgOq9NPn8HquXo3IUzhIyNUs4IYISnHjMw/of4H9vA/DKnL0yq0Ts
	ZOR8oqFB3QNXyAAHGjry09k21oaMUgJsAjdMCSD0U6F2Ui+dcsU6oMExsoRd59QD
	P6yKHNvFM6TkXKSWNOTVMg7BrZaDn34u+Dnn4zvxKNyrSaEzz7ULShibIYOsH6pq
	yd6Tunz+/C1r3qavbB1y8AVylxzmtrYHT3QTpQXO7fXZtIFx7zy3mTu/gYPzSYK2
	opDteg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesrtws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 18:17:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1e777a15so154101cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783621040; x=1784225840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nDO0ELt4xarDeNp50XpZhJxN+arGp/U3imA7JgKtXtI=;
        b=hjEqnsFhkSbus0cOs8krbNOeF0NHbagsSpehsj76PkwGKiR3t/pTT6BCFs/SYJNqi/
         qGU/2+BPaUxxqd2+H6ORMbks0UO2+l8/NdhunakyUpmnMCd223dmxLV/Kmkw8CWYDSkE
         Ew4JaF/pFZmz/VKlImU2J83e7J5U5jR4hrt4ri/moTwrUfQbBJZ1H4l8rpJ6DdCtQArr
         pc/ePWe57QDHTjKSzxy01mKWLTZxlgIS226xo04lTtewT2yLcJobT2tggaaX9N/RFv+y
         JQBh6sZ0wKpdRpcBcCZHP7lCMDG85uLS5UV4Zqtk5uNQENiwHRcMiL/tr9p32Y/ZVxKH
         T7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621040; x=1784225840;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nDO0ELt4xarDeNp50XpZhJxN+arGp/U3imA7JgKtXtI=;
        b=fXJf2xa48Xw9KreXRdjV+kauF2O6WS5FthkBAnNf9mhnzxFzW/AB68TgxJ3Yc9/O34
         m8BrLbN6579lDFj8ORqz592IQ8NK4Gmeq7RiZ35R7N1l0+9VMYcb3fqDWMq7iN9uoGot
         1cfbdJROJxpfs91ASNRcpZvp+k8udZvteYDqf6hiE2HKIcKN+F1wEoApW3qYhrUm1GsW
         g01goYTBRzudkKqPo69pREbLeNBV0p6RjtQX4QZK2SIepRts3tEgUYOEvBiRmBDWIFDd
         49V/DSbHXYMrG4c5xM/LWLzK2SU8VmR/jKvlgjtb6/wKe28WSdmjUWyB8Om0gclJ1AJn
         zGsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr/6PHttKo0Up754As67R3HHCE3rITSGi2/NzaxC4tUbCWJY1VGf7Vq2F4HH3b+wqXqHRfM/avq5GG0eKjHipc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDDuN8hNe8W1WpZw1AlJhG54z1BVjb1gLvt+u9OFUrB7lbPKNN
	E7DQfhafiC1n4gTQWZRDy+QICMHndsrUTzTohf+cVeCdwzi93zxVoP2yYHL6a24d43Ftli9BIRR
	uNspTcRZ4qmqJnZthZViU7a1KOws6eVyP/taO/mmo+xd7fFHsod51chGgFYDEzSd+YPcC6gQ=
X-Gm-Gg: AfdE7cn5E6gQyUxhDkidg8Z7otlZOcNjbY7tmyZ8PZd23k8K0SXdLmcg21ZMw0CG/10
	A+ZfKbSPn5HQNrRGBx3Ml175eQ6xG7uKbR8evD6Dq4SPnjU4dsJKSCgD3mx8SvB6Nda7FpIK7CY
	VlvC2siylMHNgGYSKdET1L+tMaqd1a0OsByztJT4bME0NVZwXu3f21Ru3zRdDMjQ27BY3qqKpXe
	MkXMI3ldnSrMQSJU6I89FIM6l3wOq6HINaqPbM3FKPU9vTxata6mNSBj4+BCjFdEXJ2xeg3/tMP
	ZjhGlVRrFqNLmcWAYR5LqfYgpgq5x9rb7X4eB8mWVmK8QodsRh35O5Twnn3Zizok5mAS/6jXRwT
	aqwTfZhKEErP8L51o58XH6byrG0Q5UlC4odg=
X-Received: by 2002:a05:622a:181d:b0:51c:83f1:bcd4 with SMTP id d75a77b69052e-51c8b2613abmr73375141cf.0.1783621040368;
        Thu, 09 Jul 2026 11:17:20 -0700 (PDT)
X-Received: by 2002:a05:622a:181d:b0:51c:83f1:bcd4 with SMTP id d75a77b69052e-51c8b2613abmr73374791cf.0.1783621039927;
        Thu, 09 Jul 2026 11:17:19 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15adb30f98sm550971966b.55.2026.07.09.11.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 11:17:19 -0700 (PDT)
Message-ID: <11796dd7-11c8-45e3-8f9e-1dc27da0b229@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 20:17:16 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] arm64: dts: qcom: ipq5018: add node required for
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260709-ipq5018-bluetooth-v5-0-e476c41f03b8@outlook.com>
 <20260709-ipq5018-bluetooth-v5-5-e476c41f03b8@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260709-ipq5018-bluetooth-v5-5-e476c41f03b8@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ARCw3T21Jp3xos5Qfw852GNgxpB_G5bT
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a4fe5b5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=HNkros0ZRfBbVPr8Po0A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE3OSBTYWx0ZWRfX+Yk2cxzRRYKf
 kOuzEZHTFm+0kjNmY+ulCLHHPvqK6mhLMNuJVLKJQ0qC+jqXOIlj4PRoe2+WDrdKTPT3lQJsxfO
 SAcGzEIGlE8ZpOwE2a8XyHCItViAsdE=
X-Proofpoint-ORIG-GUID: ARCw3T21Jp3xos5Qfw852GNgxpB_G5bT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE3OSBTYWx0ZWRfX6tfK5xevjwIF
 8PCxCf958RJjeOhVwAJfIvo7eRyFt/MiHJ+C2godo6IX9Ze7G2/DWfrX1oe1XNNWfIWSq5zUbYD
 qJuhRSyWwykqJq1VFLO8AQA330MJIyKGN2iUJaBi0vnZMopNtnf+hWYceSy8hSwXGubaEaSz91e
 WAv/KWtdYnb1mITNRNVkHwJ7ZrHlvobayhXj7QTVc3+L5hr9AkSN+XXojHPMWXRME/bADUXVyU6
 /N7FmHDPvMRWBzjRHHHCBa7W1Q9clcKjqOt7f8bAdnEh9X+T4oDiyxUEf03zswDeYeC1LH5Z/w4
 LvsyltDc86Iqg4DAAECflglwtHhtdLvCkJmFz+fs1vfKztVoGpto1vGCRi/JfuIa4+NUuwpHV3X
 RxNuZd4v9Lvi4CeOmN0pyl4SS/gOTaMmcnRmr55VDLdsS57+2kKXA7TmqEzIHyuzlVqhCA7Jw4t
 25gXXERzXdwrmfdqAXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090179

On 7/9/26 11:18 AM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Add node to enable Bluetooth support on the IPQ5018 platform.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 6f8004a22a1f..8c252fa3ff5b 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -453,6 +453,22 @@ tcsr: syscon@1937000 {
>  			reg = <0x01937000 0x21000>;
>  		};
>  
> +		bluetooth: bluetooth@7000000 {
> +			compatible = "qcom,ipq5018-bt";
> +			reg = <0x07000000 0x58000>;
> +
> +			firmware-name = "qca/bt_fw_patch.mbn";

Hm, rethinking this, it must have ipq5018 somewhere in the name

Konrad
