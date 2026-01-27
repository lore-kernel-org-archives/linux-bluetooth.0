Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6221E47C5
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 02:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481186; cv=none; b=eULf+4mNJqCjNPo4y0hI+gIylJC5uQ8oy1eFs71/+DjBjY3lISvnr6gWfohbCrHV7QN7CPTcvtRZxADxiTY7zdqyqGxNVfRBsAeXtTfiNRXGysnfNliIf/NxT/dtEqskqOmCNn1cAFu7oLSvvSfuFACt8p2I+g53NPaEZGVdenA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481186; c=relaxed/simple;
	bh=qYGUwbXihG/iKmuSDdI9HDtkTLx4YPjlctibyxe8mIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzBwl552NS1pu1GcDp5KTIw/gnHkqL7dwZK0EZno1yieuOXuG1VBnqjLnnlBIhOxQC/q8VKKFcT/RLlFrP+E8Dpp/XDj6ERh1SuB9n6aCAQWzfhOV/blTonsSawwmyC2hbOx8BUinRZxYV/8QmI8VojVDIHQdu6sh3Ud4MwkHqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UkcT6rxb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d6yv3pXz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UkcT6rxb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d6yv3pXz"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QKgGqf3384245
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 02:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XeVwqmKTK9RiVoW+opV4NCCJgRTh0FhVJy/OJcSidIQ=; b=UkcT6rxbQeTqZVvi
	EVZUrjj35iTHjK9XaNW8K088za7xQcqtvA17A2gP7wMbl7M6ktDL12/HqI+rBGNi
	wr//lvUFGz+FXldRAPC/+/aZKP1aymZuuxtgIkG88tIDtUZXHACeKpwKHDk2POTF
	Rt6Y3NGNRNIaKQLUtLz1DpajRlSkFEQFlGFj0dxqnFdcIVfazCc3PGH3CaB1L7cN
	3/j47fkONdx0FhnDarjOE8NRAYzVoPxwmDAqFGWLCHhOqWjpu5r//yyUyD0tPkC0
	LBjimzLRfiZS+R389dMjDnj/+lCJps5Jv9lwK3KHzPtmpW47SVkHgn4BNNsw/IQ7
	jIz+WQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3a0uwb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 02:33:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c38781efcso4794479a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 18:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769481184; x=1770085984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XeVwqmKTK9RiVoW+opV4NCCJgRTh0FhVJy/OJcSidIQ=;
        b=d6yv3pXzfu7szrhXcOArNltRun8SiEwAnVH5zAzxnu2bnVu8ebtxu8pbKfagcOhWBH
         SAtniuRo53xQZBVzv3wtMuG5POm4NWio3QlJ5q/NqejlPMchCogBdfl/vGnSe9xwHFPX
         O5qXhYkg74v2z2KjsuhjR759VRdcbogsvCzuAQSutNPDpFyRInd9K0Ol7oPF7sc80kUC
         61pSvY5t8efbsuUZpQJoV8p8ltCffs/RbOtA554tyJbRIAjhMq4JJo98R6trCoTggIce
         otC4Ce50fooni54DaWbdgFff/BYhKOnv7hc4sQ/ycD9JwMaUabnfCHq6uVqw/4Yts/nj
         dWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769481184; x=1770085984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeVwqmKTK9RiVoW+opV4NCCJgRTh0FhVJy/OJcSidIQ=;
        b=RkEiIH8jXOoATMPvWZQRAeLsHfSM4Zq6NnlKltXqRT44hrtp70mA2MoWv7FIbT0PJO
         3uajj/8Vo/I9UMg6vURyNIV5V+06dnfl7aNIh8EyFGtim/3GXra1Se9Q6gJVgoTAEzEB
         ti8T2L5WHB5R+fDyqOlr/wia1U57zyQW4azffZ2VOU1jWm8qVrKR3l/33o9J6KllrDHD
         QyYhsMXP3oU3iUhIWWw4FCerSG1SZTG2DvYi1PQhC9WQF+qlZrETXEUdVuiB8NK0iR/X
         MfUq2U9vxv6E6f1UMX+cv7YZTPMudklX7c9u4EZw5+83vOIWnPwIp8/pqOjs3zLz0I1l
         P68A==
X-Forwarded-Encrypted: i=1; AJvYcCVRadGGB1c09lwi/xTNoa5TgmDfekQAyJAGDqqnmb3EfdU8KNQH2nqJQbfxGWkdwRJQl97eBIQmCnHB35yYFAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC+VZnHsUKlRP5g/G8AxsaiE77D2DUp8ZWMbSxDfdb5ReZ//SC
	orie72jhg2z+Q8grKZhL+p+BQ3Ql5yBecDaBMNnl5EEn4XK3Pu86szRGLsoTFpWJfnaZbyMU5Oa
	D0U4/nH1T9uzOmUookk+UFEAipU0Zv3xVtfRy0pD7MA42XEu+W1CsSIg2a/U8Te/0daDwbGI=
X-Gm-Gg: AZuq6aJmXniMbS0mQzZu9GpURnJTTOkq640RCUYtlTwgiPTQWzau055F7eayJAGJ4bk
	hYAr7JwHPlPHVP5fJ0ePUbf8O7vbx+027DaJ8rtFCMUpmvk2VFeOzFmPapZ2YQ1O1a9Yx+6sC/x
	RxIqNGc9pvxqghG69Fb0OcpILiaxyD/SCguu67ULQiByE61bt3bKAA9aTZkgr0JEt9d6neECata
	jIP+0wgpGM3cL2dWfVHwCa4Mr+SlpySpr1c6MqTtfJ7T6ZFDi2j0lOpd+Jas7P3j+bttgN7Ts19
	AHfzDGjuNoh+UdLXdfjCwRqUCZp3h9SsH0EWluPtpiqpKPhtfXj7Vt1kimJPbmQrwlxyDl5tYxd
	r5G4gc8z0YFlZS7MbE8vuKd6CKHKx34zDDSM=
X-Received: by 2002:a17:90b:3901:b0:32d:f352:f764 with SMTP id 98e67ed59e1d1-353fecd08edmr313122a91.2.1769481183850;
        Mon, 26 Jan 2026 18:33:03 -0800 (PST)
X-Received: by 2002:a17:90b:3901:b0:32d:f352:f764 with SMTP id 98e67ed59e1d1-353fecd08edmr313100a91.2.1769481183394;
        Mon, 26 Jan 2026 18:33:03 -0800 (PST)
Received: from [10.253.12.216] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873e763sm10305727b3a.55.2026.01.26.18.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 18:33:03 -0800 (PST)
Message-ID: <7b9fec28-2272-4ff7-9575-76e72cecada5@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 10:32:58 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_qca: Enable HFP hardware offload
 for WCN6855
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com
References: <20260126162444.4194293-1-mengshi.wu@oss.qualcomm.com>
 <20260126162444.4194293-3-mengshi.wu@oss.qualcomm.com>
 <kej5u2hjxjtfdzmgtebns3amz7gmb5d2nciy45jsyglkprgh6s@kt6fodrc3oll>
Content-Language: en-US
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
In-Reply-To: <kej5u2hjxjtfdzmgtebns3amz7gmb5d2nciy45jsyglkprgh6s@kt6fodrc3oll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDAyMCBTYWx0ZWRfX51PGsRf9sKVZ
 H5FYgFS4q8wad/RFN7xEKnyYpQxMJ/7tI8yUKYEIlVAquXGgvm2J+/MJ5uzvIOTyeoWwiTtM8Iv
 BJCzOTweYNICSHMnkvD7JNn44tazSaeMgwvKtX1357AQ/bltMOXCEI1Oe2bbLT71u0D5Nqfhdx9
 f6k/kCiTA27+n/lTo4DSnzhS86OYuPd+JaLWYDitxUNn4lieQWXSId3cXuABmJZMRqSbt77dNlC
 Sc9wzIJxfF1/s7aX6D3pqc3DGvKxjRbotIk1e9TixVZzr+i8d/V2Hkl+vknh1SHVGvWKMgW3Cbv
 j8ctNSIyO6E08ZPXas6DbE3xuPvp26cJeoG6sks74i8n7L4/PUIFnGR8Nm6t9mP5EBYBjW9oBrJ
 E+Qucx1vvUy0pTqYXMW7Ppn5qmHclJkOzOlKV6t1DrLUzOfpA5stZ3dxfByqKigX5W7jgWzfp9t
 s4hfBaW1glnGdBJvu7g==
X-Proofpoint-ORIG-GUID: AMbTF-hKSCDWe4MHW8gfqbVg_lkilJfh
X-Proofpoint-GUID: AMbTF-hKSCDWe4MHW8gfqbVg_lkilJfh
X-Authority-Analysis: v=2.4 cv=a6k9NESF c=1 sm=1 tr=0 ts=697823e0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=F7sWkcXy6VlY_Ae0a_4A:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270020



On 1/27/2026 1:51 AM, Dmitry Baryshkov wrote:
> On Tue, Jan 27, 2026 at 12:24:44AM +0800, Mengshi Wu wrote:
>> Add QCA_CAP_HFP_HW_OFFLOAD capability flag to WCN6855 device
>> data structures to enable Hands-Free Profile (HFP) hardware
>> offload support on these Qualcomm Bluetooth chipsets.
>>
>> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
>> ---
>>  drivers/bluetooth/hci_qca.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
> 
> Any other chips which would benefit from this flag? If you are setting
> it for WCN6855, I'd assume that it also applies to WCN7850. Should it be
> set for WCN6750?
> 

Thanks for the reminder. This should also apply to WCN7850. WCN6750 is not
considered at this time.
