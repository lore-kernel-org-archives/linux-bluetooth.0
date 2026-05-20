Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F353D092E
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280448; cv=none; b=aIJ5OW/WBzljRfkTxeor+2jYUxCqY0GmG2jcN8Y41raTQ5TCGZk6DIAZXN5LXt4XE8RjUkyQV6hnvQ4s07mnlTkUEUeUUuBlCzJVzkiuu8lOSPqVNH904AedEvZbU8e7iwriA+Da/8yrBytB7mJuEwUs/xFukQa4+usBGpx+BDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280448; c=relaxed/simple;
	bh=FaiYDWv5ktpOfI7FbTjcTMjQgLuV8H8NQfFgpojEVP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrruPbCWTEkiASH1PbljKlVghHd24VpuMK7N04pnl4ZTeSmVx24+GYYAcOi2Tob3GRY3Ny3xeMfN6Cjyrc0ceTmGo1UmNx2Lh8POSsAIbGcltVKSiDgUby/iHnOrfoGFjiBNP34xNdmlYef6PiX3zxUmnCI8yCwOIsnj7hyq2rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pTA9WPbK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BY4CKkUr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pTA9WPbK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BY4CKkUr"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K72a3V1725708
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 12:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sWlv1f+/kOxg4LIib9PaORtM
	K1pM/yQ62L4lr83A1ew=; b=pTA9WPbKFHaJ3i5vjoo097EkuO7KP9Oh+yMGs95k
	Yj6c2GeGk2jdInRXdfIk1M1pUTzFVfWSY9TH0JdwXh7FXM3Xy5TMUyJVF9AZj3X4
	yfm8H9/bg7Y6BgfQHTlNuIVWx5YkoVccRHLCj6gwk1p6G6e2x745Soeyo9/wOw0G
	fiWmYTwat2dhHEhxf1Pu58zLbcha+qDThXU3gZYw2HtGTq5O0rXvFxKXikZMJSZ+
	TLqM+AyVDhPR379c1B+QfdIzfghf/DxAFo9qzjSgMx3ZJCGlSVMUFd/M80NCZCDN
	qd+BY7HB7F3JbcU5TSSTdPsVmLAcHVM+1bHpsuWrFpwaZQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3qmqv0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 12:34:06 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-95fc8572552so7978734241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 05:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779280445; x=1779885245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWlv1f+/kOxg4LIib9PaORtMK1pM/yQ62L4lr83A1ew=;
        b=BY4CKkUrUk1+WxrjlrDjTavjur4DNg4Cgwy1eXyzdDiVK2KcKuLtLRxlh3nf3AietZ
         X7q5x4fKHDU1TJdKxS3ynw5QiTX2LzqgKDeyf1ma+0kK+2b+m8GfjbajLcGSd1It58iX
         iWsZ0cSncfVa1jYy4ACHXOkDPjx7pNWr/sgPI0rH9KFZRN0t5knzYXbs+XGTuz90qTx7
         SQ7DfdxXUfITRrAn2RZBLvnklAGMlN20MYwZ/32OOhY4QvNVugd5ZKdxD023jdAkuyZc
         Z0sjKSEVWdY7HIUWK7B1IExF8qon44CGOzF5vOwKC+ZRF9vyhAHMkqkqUYwCQ7fdTaoh
         FAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779280445; x=1779885245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWlv1f+/kOxg4LIib9PaORtMK1pM/yQ62L4lr83A1ew=;
        b=CoOCnmNLwh3I9mopjlnr7KHGdaEHDImn9XReSwfWqE1g3uu+R6yrc+9H181+GJhowy
         9nrIopS0bcZ/wqLvW6nMUYs9df21t7h7lxvfvq4EcCr8ORfNpT6B5lM/h5mrOFMEyfEM
         XU5dvrM3dL9vsz4pBbFKwb69QYKzuINrjBkQ1PqbDV4y6AYthlMS9vyvX2Ni38oBM6Ne
         ZY4a89UOBpIW0h0uKmABW9eLprmfzmgGJUSM6BIsh73uFVHBUXR0lfVdVCxyRUum4y19
         /F9GzThMcDkStKC/oYVNEdt5ALopCtgh/v3tkDChj4pag3l0w08rsndUZbVhVm9Gj7PK
         bVdA==
X-Forwarded-Encrypted: i=1; AFNElJ8dI/p+/Jqdlmq3gW1b8qePoMl4HkbPzH+V3cksBYLYnOHvJStj1qYCwCfiaWcsdvs/GaV3b2WbcV6rSSlbgPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybtd2rZpoUKZUZnNBQNdUqIRCmm7QPcfWbh3JlnNekNmvPyhWJ
	keWGH+1bmTYnf2GDUVR9wkyn9/cLSfQPyMZJ794s9nNCS1Y5mcven1DI61TyrW8m9dDz1XtgbaK
	x4FWUoMpp8nGvAdOaNEnizGBG8nZAGWNslC0+gR8gnMJdRxXd/UE3lyaFhWi/l4t4ZVFm96s=
X-Gm-Gg: Acq92OEFABu05ZTdFnVkU44VNMF4Vtb4XCNau5kRmuOSwI409WA1SSb3eU9S6/fHXZy
	j08DIS2bDR02+ME5ZGIZ0aUok2V2je7jslPv9hPegUFObetLhIoCbT/8eZHPaLdazyOJTG3NoRT
	Tuba9AcT9K4xfs0+mF/PVtcdCsAkG3X4ZpAyhbc3wUKodbObg6mZ1H7gaheRNhYZc9IZeMmyr7L
	j7YOIgX+QxjXJZEB+ZGnPNjKvQkVdstUc5aZh480f2wgAxUFx/hihvsGlzEnkKcdW0N303hlKOo
	+WJlTr6qBASj1/p8aBhCDJqXF37xHsbh6pKUOod4KGCM00D6c74K2lVOnCwlD5VY7kjMjp4ggY2
	TIB0JLi8DieOOIgygRozbdkG14alpWEH1YhkHcQXbw6e2hO/0nWyPfgXe5uBYrmPGZwcBxKH/CQ
	AsC3WpVfrII5avmHI87Ufv163myzI6kgtxLNc=
X-Received: by 2002:a05:6102:50a9:b0:631:2624:e5ec with SMTP id ada2fe7eead31-63a3eb8bb94mr12999005137.16.1779280445412;
        Wed, 20 May 2026 05:34:05 -0700 (PDT)
X-Received: by 2002:a05:6102:50a9:b0:631:2624:e5ec with SMTP id ada2fe7eead31-63a3eb8bb94mr12998977137.16.1779280444859;
        Wed, 20 May 2026 05:34:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c4fasm4905823e87.5.2026.05.20.05.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:34:03 -0700 (PDT)
Date: Wed, 20 May 2026 15:34:02 +0300
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
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
Message-ID: <jetl37zsfcs5kl4b7iarbngrdu4ebp7ag2cvpqvkku6tbl6r5n@qozh6n5fq7f3>
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEyMSBTYWx0ZWRfXylOOxtxnS7ae
 UN/S2ZLuvpPxgPimfiCnARKsOcY8s0K1oPbQM6bIlciSuOJ1kVr6bDUwqztG1r4cLPS2gD1vk+q
 W7j+beazobCLxrMHkMxW8uyboIhnlCw2mjJd1sJND3iSZS1QmqGhkHo2Bc5B4lmf2dO8dEfJn/a
 efn/quJNnN3cUQCzuxltDO22XpVI1VU467zIC5WX66fuk2n98TiAV/CLCnRP0AXYsuAmvS5gLq5
 MSrQRm52o4J40m3VZ4yjj5Rjt9ja7umVwULGgJhnalomhQ90vU+0xwMAo7nYdf8bKqG63YTTReV
 VlkWT1/sfely2xGGJmscf5Of7zZmJIRPleFqpFwI4HRhFWovY5/cdFqMbbB3sAl0o5Llw0aj4xq
 K3+SADum6YTIRVYJEkhLCb/K67f6zltzINQbRThKnD3PgV6LHFXxzdOW9LjdPE/5xTSbfun6lGx
 QQpO6UTB0bJLbV8isiA==
X-Authority-Analysis: v=2.4 cv=N9cZ0W9B c=1 sm=1 tr=0 ts=6a0daa3e cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=STQ2a8oQ04ts6E9hehUA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: eIDXb_-XLCFBs5TWZErq_uQb2XXaQtx4
X-Proofpoint-ORIG-GUID: eIDXb_-XLCFBs5TWZErq_uQb2XXaQtx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200121

On Wed, May 20, 2026 at 01:01:44PM +0200, Loic Poulain wrote:
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
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 65 +++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> index 93ed575817af1c5e903662c209ead629fe202ee2..6fcad77f320cb82eccb6f07244d185abfb1976d9 100644
> --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> @@ -154,6 +154,39 @@ vreg_nvme: regulator-3p3-m2 {
>  		enable-active-high;
>  		startup-delay-us = <20000>;
>  	};
> +
> +	wireless-lga-connector {
> +		compatible = "pcie-m2-e-connector";

I think it was discussed that LGA can't be an actual M.2 E-key
connector.

> +		vpcie3v3-supply = <&vdc_3v3>;
> +		vpcie1v8-supply = <&vdc_1v8>;
> +		w-disable1-gpios = <&tlmm 56 GPIO_ACTIVE_LOW>;
> +		w-disable2-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
> +		pinctrl-0 = <&nfa725b_default_state>;
> +		pinctrl-names = "default";
> +

-- 
With best wishes
Dmitry
