Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC643793C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913725; cv=none; b=UaV3MEnD8g8fr0e+aC20qYSZ0SgJWfef1jqlK2RahtlhEqgjd1VFilnhaD7QLy31xPejWFKLas7PXHai3o7Pt7VP+832fksvoGXQ+Y5j+pwfLAhRVWqJ2X0QSvo/6ndmlWVbBK+0f4YeYd+IjLliFiEcrozuSfsjfN8tVhD6fDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913725; c=relaxed/simple;
	bh=yK3hmx64z7i0/cHqvhJED58JSXNvxIoNHD2ELb77V4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/5yxv7mu3FQckWyPA4jBsjqNKM36cUrPRtooP8fPlZRkoInYxEZsAVa/i77D8IW0tYguY/dXkr6wvf8iGs4TAdj/iOFI0Wd0jgPkKAk7ExCNdaoytMsIJ6eXnGWMKiZQLQbn4L3IOBt9viWCU0Pfb2a4yuDuQ7+8ZZGaj7kfwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aApKDXeE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OB+BuxPZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aApKDXeE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OB+BuxPZ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J74HFG3369997
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 09:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g5icMpeKSq4HWdTCpQ6cHRjSImJbwCnTwsfsfwuFFIc=; b=aApKDXeEFHAKK8b7
	QuShCV3dhM63yyTfAr0aK5g+JsoRVFkXHFzZY9J9Fbiy2ya6AfYu0u+pkBqUWTg9
	PZEKeGF7MWLJNU2pvqrq1fp/urkmeM3TivNn8c1jZRLHewAfUIa2KM1izYS5gAI/
	cPtMpU2lvRHFwA5TirILrSgSdlT2B5kHetzCBjXI7MLHyGPQTd30MK8Ky9xbJteo
	fYZcGBqjKjldIKgpv7Bx0+/S0vaxjyudNHpZUqdUWLF1tz61Nye3QedkNYG7VGF1
	Tt3cPfgB6OefwdgK0Ih6N20uE1uRHjZWG0BeKBXoTYQVPdUZtYAG6Z+u1hGecc2T
	PkOHLQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d00f9jp22-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 09:48:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35842aa350fso3704941a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 02:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773913722; x=1774518522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g5icMpeKSq4HWdTCpQ6cHRjSImJbwCnTwsfsfwuFFIc=;
        b=OB+BuxPZN9riT9pKF231svjSF+IxYyCpYzhg+8KYiUkA+g2yk15LOo0k9dbFEVi8YF
         0vLW4fj8mHp5KoclDVTzNIAUDk5exwdRan2zOWAKSIfhKuI0jnPeWhp3BgzKJ/NSZ9Qw
         ZYtp7/i3yS6mmHw0sXst511baxQB6MyN8ZhAZ6EMSpGcDMnbqhFjLyUaGDcmqdFrBw9p
         cSymYszB4ya5oU5h6/PV1WQjx0xUkFuuUgFG9gqd7tISdg9ynlyDm3ICATLI80s+e4tD
         0f+vN+pZTNhMEL55kck6/lohEhQ4cU3fmSy5xKAGk1WZc9K/vN9N77w98yS1K7iZKzH2
         jQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773913722; x=1774518522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5icMpeKSq4HWdTCpQ6cHRjSImJbwCnTwsfsfwuFFIc=;
        b=LfcNmgR9tzJSwi6QstpiopqCcxvi3ya9wW/H40x/pOrEXo0vZeN2blK45ulG2KXtjp
         gGInb0NGkwQvekfhwmV7elP51gkCuFz4gg2zTYX6/hHTFzqgVG7jgaqFPowj5vAIx3N+
         w3OP94VE6ZHRmIuR4hWs+7wXs7UkDpDC4dwClbGeCnQGbSaR8+8H5tgAshYSOB6s4xOz
         Q8B2jQftdW2RzTZFlueAAzAQem9YcY6vTvnpAkalaJRf8nzEw97bQyXKwjOuFDhZHOnz
         l647d2XEVuF8ouj7TPovTLyEs9rpopggXNu5MQINhomk0Ve124rafrJHJNJoMkQgfguI
         fO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbwxR2CNPqngSEIrSwG+P7No2bZgMaaEliam6mD4QGTv5oWJ6LXBzHkB0jIdqKLczLttgaSFaCmf7nK7L+mYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ3Tp07hf3QQCmrL8F2fWvsihAsZKT9ldfq5d00UaorNpqqZaU
	De6/f3E02wP3Uetwyc/UjH7KVOwON2g0Oi6pTs9xuffz2h69sL59VOno66ksA379202d7ZxYEc6
	UacdpIDK+SSbI+O1Zao8nEnJ5nZNFAWN9OuJ1900du9ruCfGzb7NFnlMgxrW4q41/pq02oE8=
X-Gm-Gg: ATEYQzyRYDLhpBM+xO7RSRwti7QAXOTOymKCFfh1rJi4WgwDcL7s+umpJ7Q+1lqTwf0
	Zt81dy6gjLIoXa8NV5AjTm0qCNbzsPIOAZ50eHyW3BvZhqHJnFw057vUIQxv7WOpwO4u0nU+nxp
	5NqGM764SCzjmDzusJHKIPKyslRvvlU3yp+AYgSAGVisqV9iC+j63Cgr5+6V/OT+GrxPUNbbgKL
	nmaBRsbjxSb3a4wuTy/ecESvbt2DEtLTAJQImhIdAgJpN0XhnaFRWUsJQ30Qutb7TIfXNkqNbX6
	LXxmMK14t+p9wfdlZkfM5EJ+wLL7LqwuqHp2OQ7GpQiE9XakRKwUdqjDzUakoGHE70YD/wtyAd2
	zUY8ab6RmwHCUOv606qZP+ZHk6KY50G+Uc23cMgnkHJ6rF4ezcJxHLLL/BOXvRLbTg/HCSfSJuI
	FJYg==
X-Received: by 2002:a17:90b:2687:b0:35b:9a4b:24e7 with SMTP id 98e67ed59e1d1-35bb9eac31dmr5712198a91.14.1773913722164;
        Thu, 19 Mar 2026 02:48:42 -0700 (PDT)
X-Received: by 2002:a17:90b:2687:b0:35b:9a4b:24e7 with SMTP id 98e67ed59e1d1-35bb9eac31dmr5712180a91.14.1773913721746;
        Thu, 19 Mar 2026 02:48:41 -0700 (PDT)
Received: from [10.110.95.239] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b07a508f00sm17197835ad.80.2026.03.19.02.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 02:48:41 -0700 (PDT)
Message-ID: <1faac95b-4c67-46d5-9c59-da4963e7e8de@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 17:48:37 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: hci_qca: disable power control for WCN7850
 when bt_en is not defined
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20260319075125.76539-1-shuai.zhang@oss.qualcomm.com>
 <CAMRc=MdRGdR=FyQHWC7yfAgpAFxiK6QGjEQXVr7mavWLOPS14g@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <CAMRc=MdRGdR=FyQHWC7yfAgpAFxiK6QGjEQXVr7mavWLOPS14g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA3NyBTYWx0ZWRfXyq9QacnF3Rqm
 H5ujvH9k5RgLBbXVj4maNwUNKxF1Q0txoFo30lMqpomQcnx0/J99EQbeF75aC+2M7A3I/ee0R9g
 9g2FrJFABST2b37qhwu5hTYkD/Mbeey2cjxOYibRuRggnfcNoyKCKfdOH7Va4bAmWOcRuQDGpkB
 k/6X8RCDtabv73RB2my9QRyTYI73YvZ8ZD+07e8aff8NnRKYxGM82iAUdscsrI42AONlWzcliHg
 DNk+8ZKNU27Aa/SR18bh5h+YfJayIkFQn3nA+x5YEb8SdzJ7ge8xTyDCt5+SflZ3UemCHJ4LVOq
 Cl8FnfR1X9Od5YJY2gULv9vOCj/+fWwWY5CavzxG0anRVdatYJBdZTs6NNzthAnORBPsT+/qbK3
 i8C872XPXZEDWbp3etPt3ME5tzBwCYn+Hznc+0cjGivPA8P66HTae3nV2SxxFGNmMiGAQJvGJtJ
 oyWY6+MFb4TC92/P3Jg==
X-Proofpoint-GUID: nI_8w2IgUX4O4TIM_dbEnf80VUb2SnZl
X-Proofpoint-ORIG-GUID: nI_8w2IgUX4O4TIM_dbEnf80VUb2SnZl
X-Authority-Analysis: v=2.4 cv=MJttWcZl c=1 sm=1 tr=0 ts=69bbc67b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=xvFTm4SV79vVDnvSsuIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190077

Hi  Bartosz

On 3/19/2026 5:35 PM, Bartosz Golaszewski wrote:
> On Thu, Mar 19, 2026 at 8:51 AM Shuai Zhang
> <shuai.zhang@oss.qualcomm.com> wrote:
>> On platforms using an M.2 slot with both UART and USB support, bt_en is
>> pulled high by hardware. In this case, software-based power control
>> should be disabled. The current platforms are Lemans-EVK and Monaco-EVK.
>>
>> Add QCA_WCN7850 to the existing condition so that power_ctrl_enabled is
>> cleared when bt_en is not software-controlled (or absent), aligning its
>> behavior with WCN6750 and WCN6855
>>
>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>> ---
> What are the changes in v2?


Sorry, I forgot to include the version update differences. v2 only 
updates the commit content
and adds explanations regarding hardware management.


>
> Bartosz


Thanks,

Shuai

