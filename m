Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EE43C2F
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755002542; cv=none; b=iDT41f2fgx6nZbCzC3mcNKTTn96dfAMuiixggtKxr6fv/EGn4xAoT5uMcUC/h+M52IB7bPmDtiqjJTJrFuue6Jq7oEHrMHxuH74fq8+9yg/JeADwuHZ713Ylw5htLLQGi1tRFGS++s0sokIJpGQl7JAmnOFQXpl5LgSFneC5WQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755002542; c=relaxed/simple;
	bh=SgQjqMKBt7CJWaLMvJg19AhV102Y25Y0xPyg8I8J8aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVCnJGeGwW7SLjuZUk/2zsGMwexSIaMh8H6p2SwzGs0NvOOECBOuau0TamM0xEQFAYy7tSQPw+lEb0Esz66fWz6hUPtI2x1lIY+VBUholtv+z0si+46dTEGU/k50ncDw+HTd4rakI6F6SpJw3dokQ8SLF6/zTmz7XzrW67wNm3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hwwqwRSP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hwwqwRSP"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvfUb012906
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 12:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EB5A3Viw6Ds+mqLzJLs8Ml12
	bye1MT8yz9osTr/W+pY=; b=hwwqwRSPJbki84ihsFMw2BHE33luy/1jFHZoDc1t
	W+G58+AWEksnB3YJ6ZT4vBix187MAVToB+eMXElFkwsY6ncHetgDZBY+gpszgl+g
	yGfTWZ8RUm4akXC8ZAKRgwkK+8HvWzLi/w5vAi1gRGJhPcUrdNfbCbBENFJT3qe2
	K/IYAzRx0SV0okkdrbau43DzRldha9MxH5wgQPijFxouf/Qq5RTJxxVluZC3fbSG
	kRqnHsCCSA71oNma1RuzlojsBRBWJQxEHn4vDxXx+afBjvqjnBm2g0tsnGSjJoPM
	UaVlw0mBesAofOpCBX/0tMksxKrEaUxG4/dudQQmZ+jhRg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbb98w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 12:42:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-709ddca79dfso8184296d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 05:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755002538; x=1755607338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EB5A3Viw6Ds+mqLzJLs8Ml12bye1MT8yz9osTr/W+pY=;
        b=gE1RLdadsKHS+wpxeR61mbw95+jXK6RUfeLsGvt0xLAYyU/iryy0mWqfmx+7MlF+FZ
         jUFkM2EDPSUN9n2LHxeAriQ2M8Jo93d5Ji06IudRsDUtLzS5Nvb87drcc+Ak/kkqUiHS
         SWSqSlsgrgg3/o+U3teGpuzpd7bqkyqmXVt4qktM1SznR8yGZ8Ad2EO1tKLe5rvB4N4C
         b9KAWOVfoa1DdwmohKUJ1I5Ho16TEPWV5jNI/1HC0RG4qpqiDEKYpeD1ZLAqSORhr+/T
         yQcNWXRk+fr89Iv64mBZ7SHTR+lxA3V3WAlz+HhJH94zSrgYWCxN6kAS4LV/fVkgyciP
         a0lA==
X-Forwarded-Encrypted: i=1; AJvYcCXBkXdkz6ZU+kfEo6bR74hLRGb8TX9VnqbZbcCpwz8RMsu78kZk2lYQwi2MsPoVnGwbGSBvuKHHWk5g1AWteSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAJKnotYoQQZdMZt1T5QRlZ/mboyMCyNA0o/q2MJLtSB4lBv5S
	ndsTjK65OLHJsXNTlveUH4OgmDtBAZkZ+Yx9WR2C91FpoBB0IkDZk5n49eR5CpBCAzM9HJHmIRt
	sYh3uFeW9+8cIHNAisg9uFXMXGxNpc5Q6UwEUa7fXgYztyjyhgpui8RMb1jRVQME0bZAtyec=
X-Gm-Gg: ASbGncuaL5+0dS0H9io7MHjEIkHI5752IXF8FWJEZNTm7pkMyFWrF9S9/36D/A7Wrzg
	07vQT5ljcukWLri05rtHealS84rpTWJkOX9gSi7c197cofIWejezoQDPwqdJxk2PPwFFE/J5G4i
	tOU0MjmbQ5epFIxIRPtDWv/m8ljjBB6mTmj6YgseuU7v4/EsovfXPZyJAfTbKHo1cMLzyYYgF+9
	MwxDAs0mKXZGzh6d4EVl6yTDzAPanADOj7SF1OxAYYquCmmVk22y6rdgfMw8XpKSZgYFB5Yzx/6
	swLFpTXGMcdbml0rQ8wHn3WuC8LU6mijaXcLUgsmIzt055Nceye4Qup5mCWgHyhbRgkGbMM8Zng
	9dSHUADKOqvjqRwoFx2zEDi8HMmoBtezNDaOp9fJ2hnr2YH/8FyhR
X-Received: by 2002:a05:6214:3016:b0:707:44b0:2d76 with SMTP id 6a1803df08f44-709d5eb5873mr42459486d6.37.1755002538282;
        Tue, 12 Aug 2025 05:42:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOgbYxP8lmbkd//5XN/QyyavN/KbzNNXgjBL+A0ZKtWNtx/5x9JoFKTTaNkf4QNt8EyMMYLQ==
X-Received: by 2002:a05:6214:3016:b0:707:44b0:2d76 with SMTP id 6a1803df08f44-709d5eb5873mr42459046d6.37.1755002537776;
        Tue, 12 Aug 2025 05:42:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cac6a3e06sm2834909e87.172.2025.08.12.05.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:42:16 -0700 (PDT)
Date: Tue, 12 Aug 2025 15:42:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Shuai Zhang <quic_shuaz@quicinc.com>, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_bt@quicinc.com
Subject: Re: [PATCH 1/4] driver: bluetooth: hci_qca: fix ssr fail when BT_EN
 is pulled up by hw
Message-ID: <tvnw7nxld5s3fa7c57apw3ppubpwa7kpvormbbqh7vawd3d6uw@go44tyl5f3hs>
References: <20250812113620.3135226-1-quic_shuaz@quicinc.com>
 <20250812113620.3135226-2-quic_shuaz@quicinc.com>
 <4ac0db96-8107-4809-8b13-580d75948ef9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ac0db96-8107-4809-8b13-580d75948ef9@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689b36ab cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=s1kbfEM2HHd9KEI90ywA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX1nsK1il1h8sy
 /iXukNsWyFYplFZCu1k5hvN7rYV8mGUnBv1FvWcfxnAeEohPVdx2XPbaXXusrZC6ZjsCKt/oeyd
 Awzyv5pAyoXLOZEu8Pt1mLSZ0B5ljYgx4VNz9+HgyavIw5QswgzXsXn0kMxKzTG+P7fQWhOVXDT
 ZpQzAtUET7a2IxxFidzIs0JEGRZY0lrrNXMmH4zhlv0M4BPhqqrb76iWcoHp7bQtlFx7XyUeSJa
 5aVB8HhbjOQ4zb67hDG9wqQJomvJTBPyCZMwC4RxW+JHXbsUOlCUWG3BgYqjU+UTG3zUnnjaAw9
 d2ThqiYJsVaF+4/7hhV2d0qNIgmnd1ERtE6zVrjtgxVF36m4wrCdBWwo3QxQ2hHCJLc1re4DmxV
 QBAE9t7M
X-Proofpoint-ORIG-GUID: YDuNeoq5V9jq71-o9DxqBUZNoMZc0K8d
X-Proofpoint-GUID: YDuNeoq5V9jq71-o9DxqBUZNoMZc0K8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

On Tue, Aug 12, 2025 at 02:36:24PM +0200, Konrad Dybcio wrote:
> On 8/12/25 1:36 PM, Shuai Zhang wrote:
> > When the host actively triggers SSR and collects coredump data,
> > the Bluetooth stack sends a reset command to the controller. However,due
> > to the inability to clear the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits,
> > the reset command times out.
> > 
> > For the purpose of HCI_QUIRK_NON_PERSISTENT_SETUP, please refer to
> > commit: 740011cfe94859df8d05f5400d589a8693b095e7.
> > 
> > The change is placed under if (!HCI_QUIRK_NON_PERSISTENT_SETUP)
> > because this quirk is associated with BT_EN, and can be used to
> > determine whether BT_EN is present in the device tree (DTS).
> > 
> > Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> > ---
> 
> I have received this series two times, you didn't add a version
> prefix (make the next one v3 so as not to confuse the tooling), there
> is no changelog and you still haven't added the relevant people to CC.

To add more on top of that, there were already v1 and v2 several weeks
ago. Please make sure that your versioning is consistent and monothonic.

> Please read the internal guidelines at go/upstream and switch to using
> the b4 tool.

-- 
With best wishes
Dmitry
