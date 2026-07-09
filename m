Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1AC4F798F
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622417; cv=none; b=CF6Ks/iVy2hxbcnC+Z5fCJcr5wWuXwuMKm2CeqONvwJvw2ngRiNXJgYW2oGOUgqIjeXBlaBFYlZir64GvkpycQoB0fCb5ul3U5A/NboZzw7FMuvVuBBGkm5za8FviLAL1w+BdPUMlM1B8QMszBbQ3t9cUlWWKqOA/c5BzSYClA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622417; c=relaxed/simple;
	bh=WoPszd7Zul2Xee86XmDdTUW/wVdb33H/coSaa6iqWK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owtoBRIibSKNb3HsPYl0u2po01oNG4FFZYnREvN2CXMAnPCE3OfdOK0snMayeFc840kZnDZ+Y6gQyTpy7AIL/CewgWV7q6DiA/Pfr1r9/qK7lwuGqaKSicy2SK7UY02hZLRbfVxch9C/O0VoXcaveHArhP8SaOCtHAlSPSShHcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WrPTS+/o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aIPIo70b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WrPTS+/o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aIPIo70b"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HX4w42374349
	for <linux-bluetooth@vger.kernel.org>; Thu, 9 Jul 2026 18:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TvK2VkyfSoUSm5eKmSxUVkwHEdBJLPuUeqmWYrwjAH8=; b=WrPTS+/oAADzAmil
	SMnElwQCyzkotcOL+CyukSHrM2kCzCrEH9g7N5OQFQYsib2gnAGsetKWWbJNhn7i
	5c6gFEo+M9mNEqtPA/TA9/PZV2+8XD3wjMOj6oMoQQZ2CY8l7PetlPSfI7MrKvxU
	2R0Yq2kYvoAPiOrwVlQ7P8dHozT22Jwb7FBL8tr/UW47wfj9PKrx8hOH4CPzLTTU
	bXZOhL6KhVcncjEKNjzPyzpKJGOFLQxVKmuVpioohh1bkaI51Cck/Z+mCdGdGfYy
	fXsD8W+/F5goe6542LcbxLbSF2e1NHQ4QLCYjGFExQM3ghFaBAjrZYAxtnpQk5lO
	gpwcTw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg5gw3x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 18:40:15 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51caa0b48ccso253991cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 11:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783622414; x=1784227214; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TvK2VkyfSoUSm5eKmSxUVkwHEdBJLPuUeqmWYrwjAH8=;
        b=aIPIo70bwXudoifNThbOAZrJUcYl7qtkYkdnyJnPRwc4h31ep+lOu7vAHAcE41BVER
         eYPJeX/DgRMk3N6QbLPjdFRWatXwds7+uQ1EinqMxacclNKSZEH7arjJEjLYbF1OuwY0
         KLS2bz+PVPUwojZrsAlV6nLH3bHe6HFISnq5S8/QAXHR91Rvea7OobInXe8Q2Q51moH9
         UXVTNssQ2yjUU/tfOAjR7NKgijipQ1m8bdXOqcXp1dnnGfIT5tIQhmyn1/kZYNOrcE7X
         phrScob9/jvMcUIitVpI8K9fKuztUWXQeNeH0gJisO3WZC/FDHg2xuZB2kufkIbUspGk
         8bXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622414; x=1784227214;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TvK2VkyfSoUSm5eKmSxUVkwHEdBJLPuUeqmWYrwjAH8=;
        b=kS7G6W+VbE6EexIS4gi+9HfMdACAOCfkYxKk0IY2fdT7Frk1TK47I3b1MM2ZjHWnoc
         Rgoa0BV1rSOHlHEuhXAWG9CNN70Ew3R9RAyEEo7IsgL+JcjoxlTct6OiYtT7TQUfShPR
         Ly1twRpOEfkBwUSNNndBK0ajCOiJjm9tBzuPRuphOsR7o65PKoyvqOMdOaykvd0jsq9H
         qhasY06TUpp3wEKwPUUgvGNLj9mIjG765/eU5VwO6WYviJxJ6Za+5MbxgU+56s+gxlhW
         uB5pjtSzSGWvNqwWVlIMcfBoSjdV84xDkGA9VWmpUhepyGC1dLIbzLmZ6F8iULDFZT+o
         NsTw==
X-Forwarded-Encrypted: i=1; AHgh+RpwSmo4iySFzFVuwBafSQXpQA9aaUZLW3LpyL+b2yzjwP3ZbU2II3CsJrskB3pFq6oh6EfCZHxOcOMiqfqNT7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJduWS4Ao1HICokq+2yyogCDiJTLB+NdlBzrLNyvk0eUYBwXL
	vPtp8sisql6Myk6Bkvmcci23mKNnSR5muaGU3Ff0O1Ms0LiJHhHeDD3EzH5bKQFqQ9+wvKhly67
	ftJi9u9nm4d5rLWrrG00uoh0KsqgE5lJT52bQmrKerV1QlXY8Zcok/uNIWzXAEFBEk9zktY0=
X-Gm-Gg: AfdE7ck0xtsQEiLeCRs6SYH9Qt659pEIKHMu4N02stndd4naCwo3AXlxnT85z45i701
	Cfz5VRtn7aORvuSfVd2E24HwmZCG6CpufErc9XnYXBnl97UrFV/zxLZiKy8dzR4VGqNfLzXa0li
	Kr4yCJ/fqYdsJWu/BUAfBC/+2TX40KgVhSWGT2pbUmDCkLI2989THU1zmmUak/FZLS9JKN3ckrT
	LF42l83Iiw36ooXMQk/8A6QzYMw82U3rYlH0fCyxg95vLPUTwEHtPcTWQAE/e+WSbXSg3ZO7nRk
	eMJ2EArRVUMz0mDcWVHSFE0OEQeZzKwLWSq9WNSEkccqsXAAyf4UxnKTmQ4jNTxn+EL5dZhjOxb
	r5mO0bU0k3ajl9NZgB7ERoHoNltddgLVrNV4=
X-Received: by 2002:ac8:7dd2:0:b0:51c:f3e:781e with SMTP id d75a77b69052e-51c967ad1c5mr45704701cf.6.1783622414012;
        Thu, 09 Jul 2026 11:40:14 -0700 (PDT)
X-Received: by 2002:ac8:7dd2:0:b0:51c:f3e:781e with SMTP id d75a77b69052e-51c967ad1c5mr45702321cf.6.1783622408743;
        Thu, 09 Jul 2026 11:40:08 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d026a479sm312642766b.18.2026.07.09.11.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 11:40:07 -0700 (PDT)
Message-ID: <fab734fd-adfe-45b6-a10f-a8a25f7affb1@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 20:40:04 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] arm64: dts: qcom: ipq5018: add node required for
 Bluetooth support
To: George Moussalem <george.moussalem@outlook.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260709-ipq5018-bluetooth-v5-0-e476c41f03b8@outlook.com>
 <20260709-ipq5018-bluetooth-v5-5-e476c41f03b8@outlook.com>
 <11796dd7-11c8-45e3-8f9e-1dc27da0b229@oss.qualcomm.com>
 <SN7PR19MB673648D6C15A8E15D35F1E5E9DFE2@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <SN7PR19MB673648D6C15A8E15D35F1E5E9DFE2@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FN8rAeos c=1 sm=1 tr=0 ts=6a4feb0f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=u0gBZgl664NcPZBul88A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NCBTYWx0ZWRfX33xPkGyTYGbk
 +D01dojYz3t5037J+i3+54uEtOVd0nP2LpSC8l1/UhJ8+M3T+Dm+VziPon9H4cAJtTIziEb39QV
 zm/OwkGFV28vPHehSBkJ1blHNQQSNCs=
X-Proofpoint-ORIG-GUID: S-smEkCYJGjEEbrrWUwtPoTetyvbJEPw
X-Proofpoint-GUID: S-smEkCYJGjEEbrrWUwtPoTetyvbJEPw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NCBTYWx0ZWRfX66LkYZQdIwa5
 fIQxIQCAZ33YdHUmVZCKm87SsmWY6qoxEZkbWDaoztYsvrvBi5uMAdUBITEV7BO5HBwjTjoPkL7
 JYVPy3vMfkRKqMzB/ehGCXe5fTM2KVLfsX3LX+kt03wFUeIJjHoOYG1tZsop4TMCIBLccenGPJv
 Zv6nmunokRlZIk75PaIiuwqj8mp11TV9smW87jnjkVxE5urk2ZnLeZ73/T17VB6dBec3HzsN7Je
 39488wX8KL/LEZ/Y4Kd2hkc4p2+6f3C7UIZcGTmx1e0zPFf9If3rDtPJUVCirHBniqh7/yntDaV
 IAsqOhLdccFL/WRy1KE3VV5cLfeo8QTlAi6R4ucBWa4macWlSExq6w39nwZMSceE4v69BwdOQl0
 g8Le18VDdVx+bSXImjNm0LWIOET9h18kmHIziQ2Y3Z8nRIQvsu1pgPitTmozRsCWDw2noqCAkri
 q6pkRatazHf1+A13rzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090184

On 7/9/26 8:25 PM, George Moussalem wrote:
> On 7/9/26 22:17, Konrad Dybcio wrote:
>> On 7/9/26 11:18 AM, George Moussalem via B4 Relay wrote:
>>> From: George Moussalem <george.moussalem@outlook.com>
>>>
>>> Add node to enable Bluetooth support on the IPQ5018 platform.
>>>
>>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> index 6f8004a22a1f..8c252fa3ff5b 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> @@ -453,6 +453,22 @@ tcsr: syscon@1937000 {
>>>  			reg = <0x01937000 0x21000>;
>>>  		};
>>>  
>>> +		bluetooth: bluetooth@7000000 {
>>> +			compatible = "qcom,ipq5018-bt";
>>> +			reg = <0x07000000 0x58000>;
>>> +
>>> +			firmware-name = "qca/bt_fw_patch.mbn";
>>
>> Hm, rethinking this, it must have ipq5018 somewhere in the name
> 
> I agree but all QCA BT firmware and rampatches are published in the
> /lib/firmware/qca directory, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git/tree/qca

+Jeff, Bartosz?

Konrad
