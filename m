Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC074195D0
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621026; cv=none; b=C7G+ts6KOEWU+1SUsIwXlY8e7W8oZl0hwUGV1zdbPdhlArvu+AJSi4bAB8hLvXocXdZQd/RxBz7+emNzvDrXtEO3Gb0Lr07vYMDcouZxMUXtwoM2oRUWupf5d2sXadrKlmka1AYWOiblCFr72cN6XrdLfeL+/J1xEPnZ998Ny8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621026; c=relaxed/simple;
	bh=1TwrHJALVemOdWqPWInxD1rzKRkbLpWIAC6sBRbz/54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOovbQQbWtt0KPEyMELlCQ+rd00jfKXmO5BZ8BXK0Tb7T+0HGJ6H05fkksl3CBAKnOql3M1OSqtMmQkl09TO8GaTvBN2Tpbu68grAIHw7cH9Vav7TTsVZavNH7yrIkQyDY/HcCdRz+my4A8+PTW3M8kPG8Nyb1mzsNcVq1p1ZBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eLRPVel3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XZtLc95s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eLRPVel3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XZtLc95s"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HXRoL2388894
	for <linux-bluetooth@vger.kernel.org>; Thu, 9 Jul 2026 18:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UGjdfApLUPZZEfiPZI9k22tEfoB4RKgXjIaUHpRLtfM=; b=eLRPVel3BG08+nQu
	8ORvn+sTGCeH+2/bd78WUotRqrv7lz1bSww8PsImzDnjWwn0Psw6+Df70rPuL+ES
	yyt79QsAPSLZ5gIMYMY8Lmv19XrjZKvePGIJHp7jxXZUz2rc+6vfucPGPwtRT3kc
	tvoMsxU/BNK1ut2O3bE5DAZIAgDQ3jv4YTqdopRCaNkIpllfHz+p5l/f77/YQG6l
	KlFGB3edkDr0dnQCWlcMiOmqf2q6JuLFwKSOCpyuciRyWVVTzIe5sdbOCh2NO8sY
	59HUYdJhTpCa1JzZZ0Q4GS01ZDSOhedYheuYr3Ieo6XbDKXcKDZgkwebWdXaVG9a
	yRuxfQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa1ydvcb8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 18:17:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e661ce1dcso2747585a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783621022; x=1784225822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UGjdfApLUPZZEfiPZI9k22tEfoB4RKgXjIaUHpRLtfM=;
        b=XZtLc95s5KosYJYncHuLubOzNP0pFxmpABKr5OSGtoH3Nfeo58KuMmnRNgindVy0Fi
         rsy5ZwOzWCd/JS5MavAHiubejAbHNXLaqUivBtA7alQV5kh7zm+etclmugrx8FhsxhVu
         sPMSgXICxjI6/VoueMN3WU2MJkM7+FOWRf+C4kBnrkRJ8UWU2CptEbsjwoaTLZaz7L/A
         v9TaaMCvmX0ZV9ndKz4miC9IwJC4BmhKhjcOGd6ZH63iiuRmSn9yoRDVwc5/Uwrkz9fs
         /HsxXY+hftIrFzuryrR682mzxqG8C+g1k5J3aqdL5XZUVzVq0nXHFyHP7P9/LIT5a9np
         B81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621022; x=1784225822;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UGjdfApLUPZZEfiPZI9k22tEfoB4RKgXjIaUHpRLtfM=;
        b=rvNB+D0PQcEDCXBuV474Ux4KGWQkkdQIy6YUi/dixG6khG85g4hbbUWIdkEqQy8SWH
         lIyYL055WHOSfZbb4BXtdQMY7vYSGx1MfyG9q09gevG57kHRDJwLLvZyaukxS+/BJ41r
         qxPV8FR6GgoL/+99QElsKmZ2Hmp51KeBzg/pVU0+jDKQeylJeHeiSTJW+cVlJSKkjVAu
         6PZgQsQhWGnzozqwLYZyw5qdudjQOBkymofo+V289NXBciUy8wxDuoMU4J6lxV1V7pAP
         Kb5razXb9AQqKUJaLvpHFeYWG9v+KFOQKWDiivICp/9lMl/WydRm03wri2uFmQmO7FVu
         Pw5A==
X-Forwarded-Encrypted: i=1; AHgh+Rpx2GBdioNbtNSBOM9i6G+Mtp/BddA95MyeWr8pYv58IsRAhp4V+xoFSxavGzhPGUuYh+hqLMgnThGEXEspiNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8PvZTDNtNeYgbfFLF9zvQvB/ONDoiEie3u0IsgjPbqvm8zSQC
	uz5BpEGaZlpa8FO4Rgb8tVdBjctI7t+WUPyVU8/DTnFe/TIrDlkRJpsf+Nu9C6GxrImtARdV9xK
	1dP9K0HUWUe/Z9XeRc3DDsuYgpTw9SD077YvSHTdAGHl/eS3ACElKg8i0GoDebts0ImbxND8=
X-Gm-Gg: AfdE7cnjoJ7kUZA82ezpw/Ne22VGbgSOnty7HgbKVSRwnbHubxcz2r5hTqkmYBDCoZO
	8RWuAzcVyEk+cz+Dbrnd/rkBUBlN2TYeoewkLWZHrrqgvZxasEbWjsjDno09TGMRTHr1xQ52nIq
	I1Ja0jmDXCwVAl9mQq3ctFRqdRgjOkLYa9BmGUaWTz1JuQvlTmJMQeQPoNh+YA8FCWorXeZawxV
	TpweeoDKiE0ts2MbWngbNsCH7uYUp+2SMzedXOpcN7TOqdJ4fnnc+Z8AGjVMtdOWA8K9KFNYxBq
	PXHGGe4GIHHGiLortw32EpOHqGSFqcDdFk2eFCCHMEUTwLKhnCjQJL9PCJ0/OufXV+GvYDEtexX
	ovF6nrUvx+W2kCA6sTEi/ovo/zpxQ0PSGOy0=
X-Received: by 2002:a05:620a:1722:b0:92e:d1e1:8300 with SMTP id af79cd13be357-92ed7964e63mr433311585a.3.1783621021904;
        Thu, 09 Jul 2026 11:17:01 -0700 (PDT)
X-Received: by 2002:a05:620a:1722:b0:92e:d1e1:8300 with SMTP id af79cd13be357-92ed7964e63mr433308085a.3.1783621021398;
        Thu, 09 Jul 2026 11:17:01 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15bc428775sm441974366b.6.2026.07.09.11.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 11:17:00 -0700 (PDT)
Message-ID: <db6c35f7-b2d2-490b-b2ed-4805eb0a967b@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 20:16:57 +0200
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE3OSBTYWx0ZWRfXwEUSZ6S/lsbu
 AEuiO/5Sfa1bsX/tgWT2BRcM1cbBPoBQIm/3/RppNPstNMb9NHqEymER4xTeaM5D2y7FbLZjSN7
 STPe49vywQUuUPKKo5eOxrHak+FkWHU=
X-Proofpoint-ORIG-GUID: Rj4qTovXeKI4lhpUvYTz1hPAomU0F64P
X-Authority-Analysis: v=2.4 cv=cOLQdFeN c=1 sm=1 tr=0 ts=6a4fe59f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=mz1jdwAY7f1nGK1u_T4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: Rj4qTovXeKI4lhpUvYTz1hPAomU0F64P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE3OSBTYWx0ZWRfX0YgKLh0ZEEnM
 S7mHrhxvszsfw0bV/ns10nYd6QO2gYr0dFYAqNE8nsGjEYGxfqiIL89nLK8cFBhUGfgEPmhURZw
 /rDvBii0ntbx8Rf/gYC8modbpdTWfC2t6Htm1VllVNMkuEC3JETz/t6Kap7GfHY5x68Vk1dJPsz
 GZZSmUP6fUVvWEslrhNIM9zLXket9aRRhP8UHq/gwA1Y4cojd0NwQKkLZ+my4QCmjrDWozXC9bv
 S3id/Y8uPfjqJugrY69pwijyGCLu6glg2dVSIuX+tW4sWQsPBY7PJcfrUoepfVx2Y0W7r2Vvio9
 M7ISkqhMEVqkqVi2OqX4RWnsMHwgsGY1eZd69+5t+xnm+BCb5MbrbHbUSVFHcNNIOhU/Z8AD9QI
 qd4XwXTvkwxWQeKfGWxMBQEeqzXr+Bxs1xK1jtZRyUXKq2qfXSBAuP3GLWGGTup7FdW/uI+c/4k
 1v7eSkB8d683EEXLQaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
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
> +
> +			clocks = <&gcc GCC_BTSS_LPO_CLK>;
> +			clock-names = "lpo";
> +			resets = <&gcc GCC_BTSS_BCR>;
> +
> +			qcom,ipc = <&apcs_glb 8 23>;
> +			interrupts = <GIC_SPI 162 IRQ_TYPE_EDGE_RISING>;
> +
> +			status = "disabled";

Since the firmware is unsigned, I think it could make sense to
enable this by default

any which way

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
