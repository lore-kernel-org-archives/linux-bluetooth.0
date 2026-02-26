Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CD39902E
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097328; cv=none; b=fbL3GPZvcXBp8r7uQFVbqGa3lfK59eX0XcHtpBHOj3nT8FYX1mZ0N6RYpECs5uLge+d2LbgNw3LQtUzP2wJqXwmnMY5a/RWI4i6tWw648XcpYkN+TlkyorVM/XSKb14BH1mNvoSTIIRgPBVggRgEKUNcGQFJbIeFPwON/FqNBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097328; c=relaxed/simple;
	bh=QlW5mac6XApHZfJPctnFhCmABhK3Hs1RwJL21IWHK6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hiAwrNGmy7F1qV/Ow1OtQYUm8oIjz8RVG08uStyuO7AXCz9ICyUZcZ244YOinDhn2qFqexEo28JlvioUGzD5MhzeZV/8J1WtnGsLcP8KgWxnBZ/FpQwLz3pBM4+mZ1sl+ivgizo6j1Ji9eUqY2g2g3j/5/ZHxQBDnM8rzn7ICCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gPFGORJO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CjHamfNH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gPFGORJO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CjHamfNH"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4VLnk3721875
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 09:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZPkSB83KryX1MJwmDnz55Mmxd+DrswTtGJyGY/cSfw0=; b=gPFGORJOofdOrAh0
	WYv5RFOR29P9KC/L+9KB6dbnjL3TS8mWScb1ZG2k/AO9xGTyXJK1N2cS9uE7+YpR
	9KvhF6ftp78kOOFZeFs5p3p8fVGXTZ16xPbA0TW6DCap2zzcLUyU+NhD3sRCo7UL
	CS/xUkrYTRLCNb1Brm9JdmGrJNHgSCfG4Wi7Wz2G2bFKxZaZq81HZT+A9geeQ2vs
	y7inRsvqR0GumDHWJinfBFEl4UU4sFcsTyXPNO7oO+RdNWFdvgjo9aespmLaoOFP
	8bCBt7ktEZ+XnT3cckmZzPCxM3wBn2ZxNuvpu7l43CwcFSX0Bcme0nemkYp85tGF
	dlGatw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chyvf3q10-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 09:15:23 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae0d7f5c6bso1424815ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 01:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772097323; x=1772702123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZPkSB83KryX1MJwmDnz55Mmxd+DrswTtGJyGY/cSfw0=;
        b=CjHamfNH67/P9pq1lmy+oUGcxwGnCsbmhp4YyQ5oVdOD1lDM1ToSxBeM3bYj5ygIpH
         zYhSS+DHvUHVvNfOstot9DjVtgImUSVAwpVN3659q7Oky7SY2rt16hq/LZO3g2Bwb45I
         jDjxzk9lQj2YxXGLjKLpfvqMZXNBJ0XVYJZsxpL0UoO4ng7LDwJjq8+F6cihgNvyeaTf
         XPhJLr8Urri4scA8jzO3ctfG0fNfJqU/kXdtsmfihGZLaamU30iJ2gG+lg9bc2VaMkne
         rtHhM0YoDtPVlKIdHrTh+Ljp42Z++3y/8rwZFn9KzfqZOCbEsTetscjE5OpAEXdKo3Zp
         FVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772097323; x=1772702123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPkSB83KryX1MJwmDnz55Mmxd+DrswTtGJyGY/cSfw0=;
        b=mEzx+6PHCSjLIAzGVlhSQD0hiSCkAbrTripIxifdtpxpAEsnF7mXA+LdIcuEC1gcYn
         udt6vcCCv4zsz+nCIXTaxPew9X/823zODbV/h9W/c/3a/EI84yOy6vbeBvmkoP14c7qG
         fTwkW82KeMn2BEZ5Y/vbQkfjuT+krXKky6tQrpl61rlMXG0+8e0Q13bVLNEiCi/qQPGP
         0SwTpeCN6PpUcrtJBS8Gj+ZkiTGKgtFsCF1NFBeytEHd0m6lyDCRBapMTC/d2J3iIb2B
         jVGhXJVuzfEW9n4B8+BTjR33InBryynFDa3RCHkriJK/QUBgTtwbSG5iXF4NeIkuf+ps
         qbSg==
X-Forwarded-Encrypted: i=1; AJvYcCUrdW8nMDQ27eQUB6J9GzMs/0cpQSzH5RW9ob8s3CvtyoHmX0SewywQD5Dr1e4g03PV5oVZNit6B75oI3RnMMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGREO4l+aAKcTfxYfgW7Dd7xAr4qL7wm08o2X6AUQeZp9s6wx
	QSig3k3QH3vqNHHawIRz77QOQTG9K4JrsvfcFZHcFKGWSZ8kB8474iQZo0sX1KjWIgukHCVc1hC
	EWsd9AO84F5UEUb7nsXx/D6a8y8kxSoy8cIvH13GtMMxgLaMh8EagR82W4bn55X/S/YkRZLg=
X-Gm-Gg: ATEYQzzxfp0lW62xit7kSAQ1ce0vOB8uaHBRbazTxJ+auV99Raz2gjIrclGWZOLv4AS
	8l/UTKXO/q3YIMRUzBgRi130mEfU6WDp9OkrAtFlUk9jaehOOagsqldHiFKyh4yPj1O5Jmx2ZDy
	H+gt8IY9shWK06UbGikjbtArCTiXhPxHFHjQ/s+JVK2WW1zrPnvR3QElMKD64mb/YHTci6puIr6
	KvmWV9RoUaMvuWSZg8a14MCo6JKgbphagJXmVwg2/k7n1BnuOqiv1LYnKuY5O455BXTpMPG71La
	0SAUDh/bLvPfTD4zT20MbPJBar6zUgcKleqvNP6bdVhy65qJK7Z/yDeBe196Yf7rxOzIvOxbxFK
	UCAUKHMPECrSBjxZtPL0gRviBzVIEakIq4Lwm5BNaZ02S
X-Received: by 2002:a17:902:e746:b0:2a9:6281:6a4c with SMTP id d9443c01a7336-2ad742b63e4mr125171485ad.0.1772097322770;
        Thu, 26 Feb 2026 01:15:22 -0800 (PST)
X-Received: by 2002:a17:902:e746:b0:2a9:6281:6a4c with SMTP id d9443c01a7336-2ad742b63e4mr125171155ad.0.1772097322271;
        Thu, 26 Feb 2026 01:15:22 -0800 (PST)
Received: from [10.253.79.190] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa4fsm18661855ad.45.2026.02.26.01.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 01:15:21 -0800 (PST)
Message-ID: <c1355057-486d-4852-8fbd-f9916786de06@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 17:14:33 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth
 support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
Content-Language: en-US
From: Wei Deng <wei.deng@oss.qualcomm.com>
In-Reply-To: <954f6a53-b597-47dd-926a-adb5a7513edb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2HEXWWNOkJmRbvwZcMdZijaxl8B4dmRJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA4MyBTYWx0ZWRfX/qhxcE0YjEf8
 ehKKalAasoN75ZeMI105M0Ggvmw+ZXPLIleES0hjjNyLwRsl6EkgNR8ZE+s4h3T0sQr9s+vkfDK
 kAtDAIKlu89+65A2pKkVcv87wj1WoqX+ob1y9gEdruXouMtejBbfNr5bFUTyKNT/t/ElNJEClsm
 JKPv2pk4TRGFSoKJGn+SsnyEnI4BJCRp7EQz/k7N7hDndh/ZPbc27mXSr5e3bt61XkIY3twCatI
 HH9xVsqup3AezYDvIcDtauCV3QRaBAo5nNtgHOfep9sFbk1AZuiZkaNP9WxHBSpb1/J8K+GzySM
 S2KeM4KmVxpGrK3XaEdOQWbpW2g9UePlSk4f0xFJ+aoHQPd6MqkNDGSklzuA+rXMc7646UDexp/
 7r7ce+qfWpw7dWbxf0VofxyarcgTRvIVJW9RpQsa8/aiRpTKtYcZcAK9X1BaJOYhHC1rUSagzBt
 NhR3Ko0kWf5us9Uf0Vw==
X-Proofpoint-GUID: 2HEXWWNOkJmRbvwZcMdZijaxl8B4dmRJ
X-Authority-Analysis: v=2.4 cv=dZWNHHXe c=1 sm=1 tr=0 ts=69a00f2c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UB3C3iIAKtE6oQ4yFSQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260083

Hi Konrad,


On 2/25/2026 8:27 PM, Konrad Dybcio wrote:
> On 2/25/26 10:17 AM, Wei Deng wrote:
>> Enable BT on qcs8300-ride by adding a BT device tree node.
>>
>> Since the platform uses the QCA6698 Bluetooth chip. While
>> the QCA6698 shares the same IP core as the WCN6855, it has
>> different RF components and RAM sizes, requiring new firmware
>> files. Use the firmware-name property to specify the NVM and
>> rampatch firmware to load.
>>
>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>> ---
>> This patch depends on:
>> - WLAN
>> https://lore.kernel.org/all/20260122053624.4068718-1-wei.zhang@oss.qualcomm.com/
>>
>> Changes in v3:
>> - Rebase patches
>> - Remove unintended 'output-low' from bt-en-state pinctrl
>> - Use prerequisite-message-id to replace prerequisite-patch-id (Konrad)
> 
> Only now did I realize you're the author of both patches!
> 
> Next time around, please keep them in the same series, for easier
> tracking (since they're very much related)

Just to clarify — are you referring to the below WLAN-related patch and this one? 
https://lore.kernel.org/all/20260122053624.4068718-1-wei.zhang@oss.qualcomm.com/ 
If so, they are authored by different people. This BT-related patch depend on it.

> 
> [...]
> 
> 
>> +&uart2 {
>> +	status = "okay";
>> +	bluetooth: bluetooth {
> 
> Ideally there'd be a newline separating the properties from the subnodes
> 

Thanks, I’ll add an empty line before the subnode as suggested.

> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

-- 
Best Regards,
Wei Deng

