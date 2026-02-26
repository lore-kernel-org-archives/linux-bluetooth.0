Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAAF262FC0
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098380; cv=none; b=dgQuMO0YnGZD/CdPsMT6VrGW3W8jJHNgMMcwlKuIY+EIse9PBU+267LwkgGvsw1eqnqA+YGOqM4IPg+uDX8zB+IV62IXInIoj/sdoIcEs8UdMFxAq+j+kgxPtkfCRgEXjTnrypY2L5zCtQN32kBdipDG3VLyPPrYnx5eWbbVCsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098380; c=relaxed/simple;
	bh=75YVOLzhyztS/Fwr4fgdn84cU9fbvC8GxjP6xzwnu6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNA7i3UNqIp9Iu6gJQLa4PoC62aZn7abodYX603/Ly0Dq6+8gEeiT01/dMXdSLIcEAdOKR7D9cy0fwzlvn0GUB7aZao0e5QlupW0AXIzSFcsReYMGUdF+g404v7kzB1NjXGMM3iZD1viN1sBZ9GHYQ+vy1Bp6eoEvO7B9CJJN0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mn1KgS+O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GaBeiXnP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mn1KgS+O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GaBeiXnP"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4VGNW350868
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 09:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uyo9PkJsca3y+WOAJ0ajcsalmGWBTs5mX7b6mTfT6z0=; b=Mn1KgS+Ox5BSFoMV
	d93Ihvcc0NNYv2Y9cdYbm49f63Qvz38ds4rNi9T5dsHAhdHExCiHWwLCgPZY4HTz
	bBA9g9yL+J0uvm4RDZVzWRwfQhLihMDOUOfXWFEvJXBwiNHXRtwJP5NexpaU0+B/
	4wHi/NwRfpbKFmI/3kA+Wl/ZOoFExGlOYcpwJwLGEnIWPaz6UMFKS6rTWLVmQPqP
	QMx84nnEJVf90GIk3G7qROyMFU6uzIcwRIQF8Ug0Aw8TxhzHs3ZeOpHEeZT8DNSb
	kxYoDCE5YWLl05J/kpeP5T+52xyhd9ftXcKf2O1IDLpPdrIgddfYBd4mEP2yX1JP
	w7B2CQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj54pap93-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 09:32:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ad9f2ee27dso3028545ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 01:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772098377; x=1772703177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uyo9PkJsca3y+WOAJ0ajcsalmGWBTs5mX7b6mTfT6z0=;
        b=GaBeiXnPUoDDkGsUQWhsSDn0W9Mu7scntNtcAf55bn6XViJ7R/qSe1Z2FXtgV+/8OE
         NmVbD69rb4JJlmnuVpzO1B2BEkFtDq70pBAKXKR1MvQKhP0azwBH/7SW14OY7C1+vYAB
         wrDKjUGi6UcWitkChQVexsBZqNUxvJNja92na5zdZMtuN4iuYiACaMsnm8xM52ct7TrS
         c7NTkoIykAzdwlFkzdInJpVXGEsLBG549QOfPu9ckeTHr16HkJfnDjWemGCYpmOrMEiD
         kmfbnWCiCagF3D7P67UYUTkPX/wptGLokKc9+sJyzmme2OFpjfmxR9TV9S2l7QM9KewM
         PF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772098377; x=1772703177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uyo9PkJsca3y+WOAJ0ajcsalmGWBTs5mX7b6mTfT6z0=;
        b=iHnbWbu1zvimBMEtzjP/6uOrbQxAWflGQ1qnQ4JoVk4SVPebyB+PO6+fuAQrJOrEyd
         hHVnve1CSQBUY0D6atNK3tjwP/ZdT7rm068f7TuXYhl6uq8JHhS/2dVLICUhak80KU0b
         fx2wqb9OqRwUgOu7Jdiyp9wVfhdcF9wUvozrfQOUknTB8C02DXQY7nya/v3vGoguwhOy
         LT+xKagxCEPwjkKjEErRJFT3iqdoIcelifS5nVH6DLz+yZRAlipRNo2m7z66Pl/TYlzb
         jCP67k/AVoZmKL0QygYG3wrwfMFak6SpIXw1cihSyhMSiMBcE9Bw8ue/10lrBiDAmaqq
         jBFA==
X-Forwarded-Encrypted: i=1; AJvYcCXY8o3pVzLhff5YxrIk9avEjyCjrAnTP4QckKx5Hf5OhzfCX/tIaeSkMZNEKkdZdnmqvik+z7CqFG2etKwEqn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzer7gfTQ0g7CVP78I/KofJ8deS+f7TM1XL0bMfyJvBUoOQ/8E+
	JotrwQ00hV3AoOolySdQjKMKL3wfVOzFyL70geW6U+uYUUC7Td12MRX2vGFhRNnsHELb0ZOV4Hk
	LCQOZ+YPqLAU53XxvH0n3agAPm204dx7OetZY1CpsVs+z2xuJHk0Cp7Xc6QgCnsPBcWgnkyQ=
X-Gm-Gg: ATEYQzyqvazhrRzOizD3sNLXVNkXVfpcBPjUeP7NqcUMbLw7hqDwv4Yq02Xl6J5KLY8
	kHWwTB9HTS3iNcpaLDS1LTJUJQghADtOXhNUnwIzQQwqYQOANy2YlUhHEUoZCjKSXDePiX/ZT1q
	xUFu4IDpJgaFL6WvO7VnOuz9DxrM3wf65/EdWCFe1KYtZ0J8tNGsecuSO31VYZSpACHvhp3Rkx/
	RRiXWC9y4ACQiK8TsgJs60x6TuYBLiSRuTdTIUmKxmVzkBLfOujfrc8MewfXYoH/7xJzxHwEy2H
	M7FVaQ8ClXgmNTCK+IcWKwZCGoCgVTb+S+qLyqglWGnNV3jIdXlcrPUhNNHXVxpXW5nC6e/SyCF
	ut9VSIBbf2/SZaV3qKkCmavv7SB51fny4ae9wpzw9cXZn
X-Received: by 2002:a17:902:f38d:b0:2ad:b230:bd5d with SMTP id d9443c01a7336-2adb230bfb0mr33451835ad.4.1772098376912;
        Thu, 26 Feb 2026 01:32:56 -0800 (PST)
X-Received: by 2002:a17:902:f38d:b0:2ad:b230:bd5d with SMTP id d9443c01a7336-2adb230bfb0mr33451715ad.4.1772098376450;
        Thu, 26 Feb 2026 01:32:56 -0800 (PST)
Received: from [10.253.79.190] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b22e7sm20214345ad.3.2026.02.26.01.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 01:32:56 -0800 (PST)
Message-ID: <b8d07c22-8b93-4689-a5c2-427e1eb6f7fb@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 17:32:50 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth
 support
To: Krzysztof Kozlowski <krzk@kernel.org>,
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
 <99196fad-9d1d-42d1-af43-80b6a2ab262f@kernel.org>
Content-Language: en-US
From: Wei Deng <wei.deng@oss.qualcomm.com>
In-Reply-To: <99196fad-9d1d-42d1-af43-80b6a2ab262f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA4NSBTYWx0ZWRfX8X2fEdJHop1d
 DYxv2dfJRPtX0y0oqkr2wzd/tRWdEQ5spu6LoDlEGQ0YCnVY5l0BPJ97xSnUBJFz6VlFRSdESXx
 YOEiibtYQIqrNx/WGyIOh5GDbFS34HC/6cuz7aW3FkjjyIJ3yQ6JvW12bTvABzzA53GQVFTABBb
 Jm8s496Nk/ZqPYKFn5nGqV0CZjvRFzPRKewRK6a0PpQY+aqNZbl1AdWTXpm5HAALgjiOjyh4y9n
 NlkvViE5GbBEt/GWMf62i13Q3zVJ+QWQuGvdJSNMslhD7r5malkENUx8+Rv2WABIsIllRnMwKQ+
 bOa+/9whnVvMWOvqIqu3u1yCVIKIkLd1N1+xplF0Zi12rfM3r7gi63UlJvezV/dtmTtKAzj4RKq
 gB+eNKbP6x9Tgpe7a7i05/WBZWtX8371IQuAeMpJZgB/ki8cdqu1MRWm+BsEDwHEx27VF3oFoWM
 E0y10Pz9n17n6qmOKrA==
X-Proofpoint-GUID: raQ1u9w8TpYlOORJ91Dnc3XZjqvXCZ1K
X-Authority-Analysis: v=2.4 cv=I5Bohdgg c=1 sm=1 tr=0 ts=69a0134a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UB3C3iIAKtE6oQ4yFSQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: raQ1u9w8TpYlOORJ91Dnc3XZjqvXCZ1K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260085

Hi Krzysztof,

On 2/26/2026 5:18 PM, Krzysztof Kozlowski wrote:
> On 25/02/2026 10:17, Wei Deng wrote:
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
> 
> 
> Which depends on 5 other patches. Send one complete Bluetooth+WLAN posting.

Thanks for the clarification.

The WLAN patch has just been reposted as a new v10:
https://lore.kernel.org/all/20260225071459.1600394-1-wei.zhang@oss.qualcomm.com/

This v10 no longer depends on the additional patches mentioned earlier.
Given this update, would it be acceptable if I re-submit the Bluetooth patch on top of this v10 WLAN change?

> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Wei Deng

