Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8DA3AEF23
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022459; cv=none; b=eE0N5sTuyw6e3lUCLGWE0CT2PtL4Bvufh5W2Z8zFwv2hvBgcvzqAOfqZ5FCkzWGjAGp3k/6SrzA1ihNGmELXhgEtHiWraDURQXIp8SEjW5hJiivYNdKe17USVLKez4z9f1T1UDrdPdBzsdr78O6/a/zn2u9KIkM5wrmVAyAVfJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022459; c=relaxed/simple;
	bh=lmOP14Bu15hKCJcfJsFNbgjaGMAN1gKX6Xs1zRpvce4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yh9vXH0G6Mhip0344HRHag2+n/z5dTK81217sqT/tsBc6cm003NywJ17c0EEc1lOR/89Dx72JXh5x/dmLkuIkqsyj6U+lvuBZLkDTKs8PxFaDMLkB78/ac3YSAbLO5TkYwiBI44LVoGB/REjyE6gc4dGyCCrm4uiLA+YX9wwkho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EI7sR4ne; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TIAxpzeM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EI7sR4ne";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TIAxpzeM"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9SCVW806727
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 12:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	djR0gnFvb7yIczPMk8GCLKch2PIYdEZoalq5Lw+87vg=; b=EI7sR4ne5eOf2ZiU
	6D0P2IFvmhlNlxjBUN5Pp8NMmU33e1+tOLMprWPlPClzlBiY8+4Bu2vjqnYdYGFK
	vheYblEHDKcSe3LwhyWESWj1+LKDdj5zdkbTvuyp77rWSJXldmEBW/g6M2CdlwA4
	sO1UXMq++TODBKHLW5eAi2KhOnez16/1abbpwQulJHCbntfzXVFeSE8i1k4acVrz
	Jwj4Kn289tVZl7Wtd2k5OH21kMtXgpHkB9Tqj81N1iRFwHJBZDZw5aBV5ALXn778
	u1HVDSm8lDACb98/yWvubx+kymNvl0+89VRWX8Pi/ZDD0t0rhq0ybGWdn0raE70T
	lIlpXA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chr5p9jsr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 12:27:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb50dfd542so607040485a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 04:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772022457; x=1772627257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=djR0gnFvb7yIczPMk8GCLKch2PIYdEZoalq5Lw+87vg=;
        b=TIAxpzeMPXLT6mjrTNqzxoTVQF0+ABTEbrrX6zEF/aPBNyaLe4KmFiKXOECOYd9C2t
         qMMA8Jf0Rt5aN93aOhZRd1P0hdwCy8gDtCOQGqzvITUX0lKgp0V6IB4bf5GU6zxgRoA2
         JLf3BJjilGmEMPhAsTg3L/b76hGCHCWmJGA9rRB6wpUGCRwjh+760djWghQv1dCZU3gO
         /kt1dPHLc/Y+M72quSyMZIaFc9jpXQ01EH0i+4M25ymGXeodLgr2hfZZ1g3Sdn+Osv4R
         H9OJtJEgI0CyE+Az0IVF/QgtwlZzW0uaHozpks6ZJdkkzpbpyJ9G0NyShClyfM6VvYVU
         HM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772022457; x=1772627257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djR0gnFvb7yIczPMk8GCLKch2PIYdEZoalq5Lw+87vg=;
        b=onprfMNYX1z230U5EJ8hkMQBYMYvqFfA4ZEvPnnS5P1nRTAQPusJaum4zhYpZzyuff
         WBh+l2Mapr++ER99ZQ+1b0D4XzfqXfIXNUhhWnTVHZ/wlYpeHEDwVjkXXm+LCD582zxm
         62Fbzwsq8HfxohvKlkSH8/aCaObejS3aImLWExw9NTSukNYIiy7ScEfnkmQPE2F8waxK
         dAttR7jh7dZyS+G9TTtdNm49MBO4VUHhB2C9DYw9wbrMkU02d1F4qeApVz7lZRJLf6Re
         svz1Nxc9C2AK6OXXbtjLPpRHpjsIogIlB6p0JI+rB3HB43hClntSqQJTtdwJIEd4pk96
         rCug==
X-Forwarded-Encrypted: i=1; AJvYcCVPUElx+yoJNeOHEmsfhuv9F/f3xOfbHvMsesQ69r6Kx55Og2OuYeDpN3Bu2NaS/x6Rf4E06t9BGB6C7RpgW8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBPEa7NWV0oRiMxRiv1oN0forCCNll8l62+VNomN6ByPi5c9XC
	tfM2/ckg63/C/Xj/AZCedKcrqSoZW/odGdGPUU5GsP9ArXMkKZyT888w75ucJFP5pAgc45ED+Cn
	Diu4L8ysXK5Dae+Bj2dtxNscvo2aWAN9REa8ShzFNagMOvx9/m7mS7O/A6lht3xQ8uz0/85U=
X-Gm-Gg: ATEYQzw4Yiggb+k93mo/QlKYyBLT6MAjzRvum7ZALEpAkup4HAszZ9GiGvvIw41s8iY
	tBdEa89oc1iHIbIYOs57xJ2S8CPE5PLpQC5925nfS6JsF4siINxsQD2MS9TrNK9603DDjEiu78z
	9/2ApyME2G3JrR5ghUGbkIMDuoLWW0cIRcxPh/ho0PyeqGinntxaIo4Can7a5OnMgSPF2JoWJEZ
	CROtBZ1YGZKNG03nLgXCcIaJ7TMNJFZNXEfVnzWYt4s1Cy5niV+J9GxJ0WpqTv+ftrILkefUNR8
	dLQoAuDf8GC71TpRr/18tdEksKTpeuqFc8cvj1NKfWICteIPtPpk8DVYTZiOL2VXPp5AynlB1rX
	643FSMa3pgwBtnAV5fja/DlYVLUkawcaBb+5ggmbbwKaFSPur7ESux0RK8JSExY4jZQstrUvdc6
	YqwMI=
X-Received: by 2002:a05:620a:6910:b0:8cb:52c2:6f19 with SMTP id af79cd13be357-8cb8ca764b3mr1502774285a.7.1772022456833;
        Wed, 25 Feb 2026 04:27:36 -0800 (PST)
X-Received: by 2002:a05:620a:6910:b0:8cb:52c2:6f19 with SMTP id af79cd13be357-8cb8ca764b3mr1502770785a.7.1772022456370;
        Wed, 25 Feb 2026 04:27:36 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b934c9a645csm15099666b.34.2026.02.25.04.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 04:27:35 -0800 (PST)
Message-ID: <954f6a53-b597-47dd-926a-adb5a7513edb@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 13:27:33 +0100
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260225091700.286108-1-wei.deng@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEyMSBTYWx0ZWRfX7NaYJvB0Ei6u
 mX3bNGXmTnfx7UlEWMvSZNjr7WEWCIxx9yF1dlDwuMWUsey+BOkgZQdV4yAkuEJa59OwdbK0/KV
 zJqhUZA0Y/wwA1tBMfvnldmYTARMku8mvZCqdxXVRlreOStBeM99aqxMbtN7ishS1N3QK8SOqxz
 YF67XsQEAMGOJm+6kZiJrQib8rJkpyx5P31FU2NWlckGoyTnK97oJNEfXDrtYgqOxD9AmeWyr39
 Xkt49wpLGCfrW08Az0B4O0/uhvcfUV3KgT7iE6qmfDcKwBBbDnYGb1Zg2oYA2awTfo9JNCar6Vr
 O4dIGFM/iWUyTAmCuUiMB5ol+dmpxCsGJdzrWn/U0z3ND4DZGxwoNAm/ArdPLrpI+hFhJti/C2R
 6SQgR8Yw9aLWUteR0bMZWLSbWYobqjJ2OXdSOQ4nk4lW337rN6AeQyV1z9Izb8IUx3gWexMn0Ki
 3myhb3nw4DRwenhmBGA==
X-Authority-Analysis: v=2.4 cv=GstPO01C c=1 sm=1 tr=0 ts=699eeab9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ICuIv3KJ-OCJFd6aZL4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: kP5zAGaDCqGBXmkOXS2NvtDLvgC4Tnc2
X-Proofpoint-ORIG-GUID: kP5zAGaDCqGBXmkOXS2NvtDLvgC4Tnc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250121

On 2/25/26 10:17 AM, Wei Deng wrote:
> Enable BT on qcs8300-ride by adding a BT device tree node.
> 
> Since the platform uses the QCA6698 Bluetooth chip. While
> the QCA6698 shares the same IP core as the WCN6855, it has
> different RF components and RAM sizes, requiring new firmware
> files. Use the firmware-name property to specify the NVM and
> rampatch firmware to load.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
> This patch depends on:
> - WLAN
> https://lore.kernel.org/all/20260122053624.4068718-1-wei.zhang@oss.qualcomm.com/
> 
> Changes in v3:
> - Rebase patches
> - Remove unintended 'output-low' from bt-en-state pinctrl
> - Use prerequisite-message-id to replace prerequisite-patch-id (Konrad)

Only now did I realize you're the author of both patches!

Next time around, please keep them in the same series, for easier
tracking (since they're very much related)

[...]


> +&uart2 {
> +	status = "okay";
> +	bluetooth: bluetooth {

Ideally there'd be a newline separating the properties from the subnodes

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
