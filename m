Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41519477E58
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994518; cv=none; b=jHei4VS87FNdp0Z4YEZ0zvxbMyFUd94XHNcLwZH/+bjycC8qYcRwczB7HKDvr4bMBTyULy4ipxIYBxcyXADb9+pqXsIHH5yXC7PnS5pSzYeERyB+pwKwVkEZqPkdxUyN0aUuxcxuwpamVGWrUxTOpW/8NfZ+hI7xL96TYNCOp5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994518; c=relaxed/simple;
	bh=3MllCn5BW2jrVs3X10aZDREK9qNt2/q4oENR3SMY8Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjhIiQCp12lOuT0Sj28awS7ckmz8O3/MiN/JvS5miQlSd5Bfl9MhSXAKjr8fjqSiW/J/mkBGo7JbV9VOwsIomhd5J0j3ZTI2mru6fIOpuDvqOnqHvj/6Pi5OMNksVbZha6AIZ/wbJf19pxvv0J9YCmkJDuH/yjlTPk+5zs381lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UlTzxC5j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZmY3dknn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UlTzxC5j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZmY3dknn"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6628V4hj3009475
	for <linux-bluetooth@vger.kernel.org>; Thu, 2 Jul 2026 12:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VDGgtPcQYtpiwnqPVv2kEVYa
	FPC5xtBpVIXV+o0dHpE=; b=UlTzxC5jRcDHV4OgshrD3hyQkpLBL93a6jgb/d3q
	Bf97kKBx8jxKZ30pm6uEUUoN0Boi+eE93hmGy2deef58KLPO96uHzJvw/FGnil89
	71F5yijgnZxZtd5nUxwGGekWPdYUaj9CHaFbXUHCpxLSKsDnZQ8WgxNyRt+71omd
	nEIoUPteLadDEFUXCurmxDWW+hmho1icFKly5EBePvmFiaIUxVZ0FWht7TlgWczt
	uO8TBRuShIneYDrf37slY5a0AMiSDuh7Kyu8E2x41YphnNSYLbIHj96xoKpWYfUt
	3/gOHAykmG94PWkZvBn0bgTzIxYDQ1NDr7mujtHnnV9oBw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f579ruwu2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 12:15:15 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5bd7f21101aso1613562e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 05:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782994515; x=1783599315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VDGgtPcQYtpiwnqPVv2kEVYaFPC5xtBpVIXV+o0dHpE=;
        b=ZmY3dknnwbqNJBBk8KChpKRnJm10tst7ygGIWIrRSbWIAtyy8zMeNiPO+C5PvBGs8r
         es2s2tfU7K/9wtz2lKvVBso3CavxPl5LvMdb1u1dgJRxF2HU0Eq7jTRE38fG5TMmlyza
         TwlgeTF/m1gQyBg/p6yaV+A32qq5IvxTKUFRc2AWmrmcByPrpnMrjK/3+yyUDFO0sROl
         /h/dEDI58Xl9iZqoztBal/lY3zAbLOP3m7tMwsdu5fJG/6E6IMm2NqILv9LbQHwrKguE
         CgRY/+8AszPuOy/xWpYPULtnsbW1Jvzgt8UdraPJzVRUogH8J0mjqWMzKtd5ZblA4rHR
         xIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782994515; x=1783599315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDGgtPcQYtpiwnqPVv2kEVYaFPC5xtBpVIXV+o0dHpE=;
        b=g9P5JDOUfWX/mKXJZ3W94Fwihj8GEDJrLWowFobEsJ11/MXbZuaTO59KPRwjSyDP5y
         UYu7PN7hO8vQF4RLAZrWPCLmqpQbZ1sXJTi5CjCx3BV53n7UucbzSJIIab7cJYVa4BBJ
         ZMXfjHKvo0B70WG/oG66nhNOA00Ih6aPYzyI1cldjCoSBaqUce46KjV8jauorfQJe7ek
         y5VJb9/nxEbBG0O7pcl5988yTz2QJkAjUFbMbRBWvIdeGwJ/AdyyPPEkynkusuY2QDVz
         Ab+yVsdtnlSy8AD6P1U01SRGz6aFMU8wZOzUQuDVWqu8Fr8j7KuHsqpSNf9BiqHB68B2
         TThQ==
X-Forwarded-Encrypted: i=1; AHgh+RoTW8q+mb8tUMZRDLiH0XGioubdIdODqpaa0MSTIoE625+NLoWMDAlkeCSdzGK9RmVkUrwi1JUBjRHRCHAcRTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEm8INCYs6POCyJSVBJAPkv9uqO+5fIbmvG8drgTfRxZfjq0ek
	ebUpOEJ2PtDjoGWKeQtvibOhrO1Mn48n1slxr2/sB/hkSS8/9SEYQ2w8ppNvtw5fEssbgA853A/
	kinr/wrA9BcNH2bt85OCOddy8zWn0vcpibtOvKmEmLUaKGbfisvW3Hj22coOHf/TnLA+2bmE=
X-Gm-Gg: AfdE7cnnZY5fCvkxWdgEEUhLW7sI83rl/Z/yp0YBPSP/dahXb9XzywIAf9C2/pK2KOR
	6sCfgYqM+Zuznfx521K+i5tEjfAIudiW2U2LBXkiM1hv6owJXbSj5jnha2iIeLK8UNgBjFlKeje
	0U0A+0ZyKyHBzU7nhkwxzEESKVor4IitlkP6NzhMNK40kjSSdaIZ4i1F7MSBl2qw5JWvaW1hC5o
	SKAjBfWSp6WVd/nL8GkQmseE3EBAqhMFZW8720exvATkElbiO8nZ4MipAxbEyrE4N5ysaa2vG0V
	Shj0r+fy0P2vJG4yz5uyR8p1y9sp+F6vMq0eD8l7OiaiNykRUkZBgf8rpUpo3PSVVrKmLvAqX1Q
	XiH0yhJG8hX+830yX3XRBaF/0Kw9B4nA8mxtG/4FWE9XQZt9ED86inwI1hPk1nWo72MRi+JZCch
	xN92AsiHwV+ZjloPacmQEb/ruF
X-Received: by 2002:a05:6123:2c5:b0:5bd:89bd:354c with SMTP id 71dfb90a1353d-5bddf6a3077mr2355568e0c.11.1782994515144;
        Thu, 02 Jul 2026 05:15:15 -0700 (PDT)
X-Received: by 2002:a05:6123:2c5:b0:5bd:89bd:354c with SMTP id 71dfb90a1353d-5bddf6a3077mr2355549e0c.11.1782994514536;
        Thu, 02 Jul 2026 05:15:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec89e25e8sm647776e87.72.2026.07.02.05.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:15:13 -0700 (PDT)
Date: Thu, 2 Jul 2026 15:15:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: monaco-arduino-monza: Add
 QCA2066 M.2 WiFi/BT support
Message-ID: <kojnsrskuifjqsrq4xsm4inz7xr6hhfvugy3vz5ogddcu5y2ia@olrsxmnevu6c>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
 <20260702-monza-wireless-v2-4-7b56e2a6a6d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-monza-wireless-v2-4-7b56e2a6a6d4@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyOCBTYWx0ZWRfX/5A2Ev/DEw43
 KNr0k8BhXm0szu5mjXcqt2t3iwy5oKh9ZIRMzWKMLllKDQ1io7j6KRMU+c3NDzkoUwc1sFDLr8S
 /6XpCI4TrMeRlFdhfzsByDgl3Sv82HHJGJEs/tsUv+GLxiJZQuG4uNOJwYVF9flaXSsUuMHj5W6
 q0vE4I/ZZNJ91QDh/89CxlzotWqwh86Bq1+bGfqAXot3JTSacDxMEFYjHZ0Joxe4b28T1qCh8L9
 8+Y3dztm8/LCehUcTdwSnldvP+yhQVyDIN6XCwtqJKLZpLDUoFahOr1UZibER5gk1+t23SqhFtR
 kHuRrxyIRPGFdN/X+9oBf0SmB/kc6wScVOimleh2EWv/8ACdMpzA0Ox3EMl/XBKyLRJzAft3r6r
 QMnebmEdn5xwF5nI3WZmypny6OeLxTQI6bLM2QCcuNrIiKgkDlFv//kLCUn+50G7InC8Hu0Vfok
 JPLH3G/KWdlEaLCXoZw==
X-Authority-Analysis: v=2.4 cv=X8pi7mTe c=1 sm=1 tr=0 ts=6a465653 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=STQ2a8oQ04ts6E9hehUA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: rdN2w8dE5NHQ5sKN3P6THNbjXUzCIYbD
X-Proofpoint-ORIG-GUID: rdN2w8dE5NHQ5sKN3P6THNbjXUzCIYbD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyOCBTYWx0ZWRfX4HnlmgVMBy2b
 j2u/O3UGcMMpKpWkGODvdzsjehbOTmbCTBh3ro6GK/FuQPF5DnwFjOFpsWb+uSl0zCt9oGHyC1t
 5hY7qRjLC5JsmYSkkCOQgVWZ9672h54=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020128

On Thu, Jul 02, 2026 at 12:46:16PM +0200, Loic Poulain wrote:
> Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
> Arduino VENTUNO Q board. The module is interfaced via LGA and is
> compatible with the M.2 Key E.
> 
> Add wireless-lga-connector node using pcie-m2-e-connector binding,
> connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
> the Bluetooth interface.
> 
> Add pcie@1,0 downstream port node with pciclass,0604 compatible so
> the pci-pwrctrl driver can acquire the power sequencer and enable
> the M.2 slot before PCIe enumeration.
> 
> Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
> (gpio56/gpio55) used by the power sequencer.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 64 +++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
