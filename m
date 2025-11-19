Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C23732AAA3
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538690; cv=none; b=Y+rYs/1mZBkVLOu2FVjuf6E/tnpYhJlhrP889AzNd07QWviNE8Gksmlx+ZX9qd3+1VaWHyJE8T3OZomIHwux1wGv9pg0IxnFA7p9Fw/xb3YOtyoj+OcybOWHYpkSjH15LDIUDinqocT7MKiJUeDfvNxY4/XzQSiiKdKzGeHTi7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538690; c=relaxed/simple;
	bh=wWKQDuouWIsDixjwE0XyK+8nltKyTBInoJL1AP4cxoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiFzzOUdsmpfyXcnJwnL4uYJaFYLWg7vB8n5uI+EGBEzq7/ssFNBj5m4cJbTlffipNPSHbfww6a9SdV0KC27qMzqfobpI5S1ywjAfytQcPOvNxthpnEnorZDlK7pk8YQrTTTtT97N5XDwVwJIGV0+jkPObXWV/SoORoXGzxGHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jIKywK3r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QAwSTPQT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jIKywK3r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QAwSTPQT"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ61RYH826900
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 07:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2XjfQmr7tdw+9KHryrOocOif
	T9IiBmdnXI4W6fT2KkY=; b=jIKywK3rD63Z/R3mA0eipkDq8Y4uKlglc3lPht1H
	2BpD3eU8ynw5031nkH/rv89XLuOZv0/x3WRJtXCQucc0ktQxt4IFTKlVuAf89XRy
	6Q4mbi5Y3m9n9uE23GhvXZoayxGHixUegHcTApXsLUw7XzODOAvi4oS7WREowacp
	GavbJ0fYnzcxaeEtX6Gmben0aLAbVrJBFtmCfKUD2w3hwf2W/UkWvVLbnZE1Wykq
	WBQrhmlzmWEHaiNOHeQfRwvnHf13UdY2a07V8d3BdRhPS0fK4vvS5+v5vEpoBdtt
	rcw+8DzMvk+A0s3BLVjWLqYLMIS/Z/9qHgX//nwelDZsfQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ah88w8a3v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 07:51:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b2e2342803so1188564285a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 23:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763538687; x=1764143487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2XjfQmr7tdw+9KHryrOocOifT9IiBmdnXI4W6fT2KkY=;
        b=QAwSTPQTLjaD7lQIO2DokUZe3BSuykMoakkIr13y8IqwElqFf0Bo8eCcVQZtypchmU
         8WUKWbN6MUM5wcScCBUr0ts8gsAtjqrlBGWcRiyNfR5dyooGIEG6I2ZjISdGQsDHP7X+
         HFDeqocdSVZ6X8E2EbGNz7FbiyjaAdHWUrIpVcMkY+0MJ9DOgM4SH7OlC+oqbEdYDyBc
         BmvuCQmMWM6uFJXwovlkx9ssdjLgt4ipAgYgleLivEtShY8Aet9Yeba+Mi890u2mqIzj
         3c9QLk5roUSw1IVuSMgcQctWH2gPj603wyR6D6Dl9ndQ4H084hIKU/Do96CY+gB7XRAM
         in7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538687; x=1764143487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XjfQmr7tdw+9KHryrOocOifT9IiBmdnXI4W6fT2KkY=;
        b=HkbVc9RinNzMRPmR+gHnMSO7nnST1iFIZyj7n+zezezUGjOa0VyznC8i4I1Buh6Tsp
         71ctz44Xkj6sRGNe0wO04bq9aZttcaghf0Bd3kUa3dc49/qURgWDlk2ZhO7MUNDeDEmB
         CNfSwtUKKBMh1KkZQ0QcO7Ox2IKDEgDMtgazK2Z3Ic4Y/nJrGLtBb0f3yfhUX689oTm6
         YTq/SZy1BxMewGV38Isy9FzPb3+kEjwKSB1S9TJS7jTzcWR9aa1Xrp4VXk3z02UT0K6V
         xh/q3D4N7sf20JLYfdOkQtceXgO88AWvjOfGbULMZ934Y/qhFKLewhou6CFqjLsH7vBu
         0cQg==
X-Forwarded-Encrypted: i=1; AJvYcCX/0BaHQxJpgyzqHHWOf91S9nCwXNRZMHsWMj/AJe9plzweOM+taDNW5nvFyHGDjFTYUULpPJKVQ+PymJZvi4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws66foGFdYsmW34TkqAmnovXaKuDb80zy7ZMzBqbInvx4b4ATv
	8CYBtBc1llKManOxJiKEXt+eRLfDYkLaKn2i4eX5Ki51nESjCdlHJ1WKZXLzJtHE/f96ZKYQyFW
	m4Ds9legaAGoM9IneMkhBtzJEVTYljrKW9az0VqafpP5iidDaBh3ImCuMdtf8Tz2c67aB8wY=
X-Gm-Gg: ASbGncsugzjOk+Ayx/crUJHb3WOmbj+VS0TT+bTRYfccc8imUY8w2uTIolpp7MOt3iX
	8awn9nOdiqTCcuEIw2xqsn/I3wVaoguyTJPvB1AI6Xu9HhA5ssM2jxgGFqxCgGWhR2uhgnHI4bt
	LeSQDPDHbr7xyU67sFMgHaf7LstU2aAUuJuyITwoh4RwmP2GWNsVjENM3ad8IXYt9oBMTJTR1SD
	i9Y2qpH39LVdQgAVObrRO4kTv71TJgyAobVZ4LK9iWhKTklyPYQE4w6rM59Qpm0o1WlVHMF76Bd
	divUy/FjJw6zqSC6VcAIzwKM/FXFn1GYFLkn9/qMFM0iAYUmOx+8mZJfOjgkeAp07nZh8p2O4TL
	s/YE8lrjQ2kdDqEQGw9rAjJZ1gglvgm76FcJxuf4j34da2fH9Iy1o0DILj4VeIZV8O8FmBbvt0P
	iEYvmSTN1M0YpfyJC59wClThs=
X-Received: by 2002:a05:620a:2908:b0:8a2:a5b2:e3bc with SMTP id af79cd13be357-8b2c31e904emr2349528985a.89.1763538686836;
        Tue, 18 Nov 2025 23:51:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmwiwC6dVFx6NmfG+wYr7pqxNybyE3jGE4HgxI2bEAvpklfPkCwwaYej8biFwFpQXl2WHGsA==
X-Received: by 2002:a05:620a:2908:b0:8a2:a5b2:e3bc with SMTP id af79cd13be357-8b2c31e904emr2349526885a.89.1763538686425;
        Tue, 18 Nov 2025 23:51:26 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595803b8427sm4454564e87.45.2025.11.18.23.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:51:25 -0800 (PST)
Date: Wed, 19 Nov 2025 09:51:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com,
        quic_shuaz@quicinc.com
Subject: Re: [PATCH V2 1/1] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth
 support
Message-ID: <j4ji3vemr4q4t7lrnkphi3thd2lk5ngfm5gscuabiuuadc6b56@byxfajvl2r4p>
References: <20251118140406.1551669-1-wei.deng@oss.qualcomm.com>
 <20251118140406.1551669-2-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118140406.1551669-2-wei.deng@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA2MCBTYWx0ZWRfX14QHULHeadM5
 M5LwuZ4B5+tfuWCTnvCGRr1nE1wZjWyNq93veDOZKpYIB1WDZc7v19wYv7Re5+KZafVxLvLk5s0
 ORQb/Sch7VKJHUG16E5T6NSPY48nx123JdHSKFe/AMEF6FmJdnaInZMndxSfm48kY/Oxb4GRuYY
 6O5FyhQdDdjAwxV90qeTDYyAdYKHjGBjfmK/b00V+5AKmEFDvHCY6S5RFOQ8ax/OFI5W31Vi900
 DSjQY8Hjh73e/cFkXM6L9+QvDSzvg4bWm0x+6WK932qEDGlTBBZWiSZySyDn9E5KyGzYkJuZoC7
 vf24tHQZHPpJ52QUeXRhq0V0koQRIBFXpX9R38/laMU5GM6691xyhJ40nLEggawaRn5KrrhUhOv
 3vr9vt027kkYyHtzN89+v8fJIlS2Kw==
X-Authority-Analysis: v=2.4 cv=YKqSCBGx c=1 sm=1 tr=0 ts=691d76ff cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=dDEM-9S5bOE7Kyg1U10A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 5Eu6u16Aogj4XcnAkcM3lLxBk6sUl50F
X-Proofpoint-GUID: 5Eu6u16Aogj4XcnAkcM3lLxBk6sUl50F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190060

On Tue, Nov 18, 2025 at 07:34:06PM +0530, Wei Deng wrote:
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
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 28 +++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
