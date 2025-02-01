Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6171C1F19
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Feb 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738423802; cv=none; b=FlasQjQK83vwzpInUgo74/GyDxlB9BTbhk7jBjcLhZpcoudBUbio8Fjctb6jpAH1yBIkU3JEMLPd2ioAzt5JRcPmu0+8Oaa2qhb6PEkNQ27las3pUBS7C2ulHMqNPr+Fbv26WDNkZe/tQheUKCWemcbU55t0HljKzdsj83+7CEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738423802; c=relaxed/simple;
	bh=pneZuhBs75U2eZ3BgWmrLrinRinLHenz/os8RktLXi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNsT7GGkV8I23IBVpI3AAOi3PF1/8/jgmO1bogFAh4vMTn283hY4yTP2JLcsSKmWWgtWQcrm9MMqfhd2UzqlkD013+nQ2uwkVEUXvYuApU9ACmd/HXjztUHEc9s6IIbUSF9VnOeZ+wwWv6xmp++SGpIL0zqJ/58QrIrvarmnNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VNh6dXk/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VNh6dXk/"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5117s7Rd004504
	for <linux-bluetooth@vger.kernel.org>; Sat, 1 Feb 2025 15:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mKelcYug8dBYhF4bh8maGBSgnMFBhqrXrUszluVow6I=; b=VNh6dXk/e5B3bEBg
	11J57Jm2YcQUxLQgIlxA+esr9h/JCCwl6AobVeAlUF3m6BGo42y++YQijvU94/TY
	qf7voESjZu2y2P/DrNHQFTERk/UMpIbnQ2zZ2k6MsSSXNlkb90inAEnwJOrM8JZ/
	Nh0WueBnc0UsrrhCZwp7BUFKUivCHgmc6UtB/LXdgL17fPLPoW+3Mv8UCOg/mPA5
	hxdCV9sOhmJVwIiFKy2KwDeuakRSCn3KKAP62kft4yfhoD7TkYZCSG/MlF9GKWU9
	KiY+wfXT6qRqGYcmPFEuP9+798Obi4jLi7p6GCidkKbMEEetxtXH5trGxJQBcf+L
	mPzEzQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44hd6a925j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 01 Feb 2025 15:29:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6fec2de27so81859885a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Feb 2025 07:29:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738423799; x=1739028599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKelcYug8dBYhF4bh8maGBSgnMFBhqrXrUszluVow6I=;
        b=hPJXiC6K3oa13F9KNN0kINeqUoft+FHwTpeeADtX6B+ONf4vgPrSTwRtHOrbYnlv8l
         SyqetFAYpkiBGKCPxm3Eg+3RwDZExTVEjCDUBLsfLCI+cskIvt9spR6rz2qgIv0EyLCL
         dIMSnv9i4wVS+Erlzuw0IXhfN1WzWlCxQuw/zqiGL7CyAdOsP6RX2GhEI7bfraxaPB8N
         2C0CV7irzDp0lRHmAq35hGdyv9wxBuSaIoLwUKdGvXasK/WsKcr41JxRJa/nE/hY9eDv
         v3OPcDJCbMpOLAf62QH4wMqQi3KPo7/2nJ2BAHkCHtKDbh1UNpLtSnKJkfcKnNBAYISR
         vWYg==
X-Gm-Message-State: AOJu0YyExhGrXH6x+KZwKNbvnBLzQqRltczvmwBD1+OdAV/3gLiyvAUg
	L5kTgm1HXkH/BNc3dHVZOVR7LS8leHCdO9Ab4bCqDNvVq9UStYh4nZRVYQmaBvRbbyHCJdiZU5r
	dnM5gfiZYzb52m2s4WOgGVisNMGoq6fCIl5gzJ6QH1zRYjsvxx/UeBYvOHuCDhElUTF4=
X-Gm-Gg: ASbGncuDvBU1rQaRcCaVX8ky9+M/yq2Vb8DpC4dwHl/RNv2HvF2jr3o0G4XddFVFliy
	aFes3jZPVwKYjt+6naegejYw1rUqp3B5AKTSCtuxn7leEAP/hHHFEoKXCw3JHFwz5jzj95rxtp+
	cewddWdowt8GXqopiUSF/2SUoKrwc1UxQHFNpB1BRLyYzP1qiN9MkBpVwyJ1I7ZQ15LPXJ8dCuP
	k4uwIHW1anRjpvO4eOi4QfRj3lYjX/W1LsP05yl0TqzGzZB9g5eDam35894W4366DPzLwBGmAWY
	XrQ6jldqTDmAjgE+precKChYh8OkrIgn0x+dSTsH7ltOg8+W+vLliXvHxmA=
X-Received: by 2002:a05:620a:198d:b0:7b6:d273:9b4b with SMTP id af79cd13be357-7bffcd8bd6emr806168285a.10.1738423798790;
        Sat, 01 Feb 2025 07:29:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUc5dgjKTTrm6WQg/PcNfDDzUg4H36GWDA5vbZTnei8HHKXGpzYGIi+fzUPgn4xgwUNRY6Uw==
X-Received: by 2002:a05:620a:198d:b0:7b6:d273:9b4b with SMTP id af79cd13be357-7bffcd8bd6emr806166685a.10.1738423798473;
        Sat, 01 Feb 2025 07:29:58 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc72404537sm4585702a12.35.2025.02.01.07.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 07:29:57 -0800 (PST)
Message-ID: <1850f3fb-bff6-4814-8f52-ea97ebef85b4@oss.qualcomm.com>
Date: Sat, 1 Feb 2025 16:29:55 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: qrb2210-rb1: add Bluetooth support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250201-rb1-bt-v1-0-ae896c4923d8@linaro.org>
 <20250201-rb1-bt-v1-4-ae896c4923d8@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250201-rb1-bt-v1-4-ae896c4923d8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VotSlyhK0OdJLfvjOfF82xf4XcpWG0I9
X-Proofpoint-GUID: VotSlyhK0OdJLfvjOfF82xf4XcpWG0I9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-01_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502010134

On 1.02.2025 10:18 AM, Dmitry Baryshkov wrote:
> Add support for the onboard WCN3950 BT/WiFi chip. Corresponding firmware
> has been merged to linux-firmware and should be available in the next
> release.
> 
> Bluetooth: hci0: setting up wcn399x
> Bluetooth: hci0: QCA Product ID   :0x0000000f
> Bluetooth: hci0: QCA SOC Version  :0x40070120
> Bluetooth: hci0: QCA ROM Version  :0x00000102
> Bluetooth: hci0: QCA Patch Version:0x00000001
> Bluetooth: hci0: QCA controller version 0x01200102
> Bluetooth: hci0: QCA Downloading qca/cmbtfw12.tlv
> Bluetooth: hci0: QCA Downloading qca/cmnv12.bin
> Bluetooth: hci0: QCA setup on UART is completed
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

[...]

> +&uart3 {
> +	interrupts-extended = <&intc GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> +			      <&tlmm 11 IRQ_TYPE_LEVEL_HIGH>;

You need to either /delete-property/ interrupts, or define
interrupts-extended in the base dt

Though thinking about it years after, I'm not super impresesed that
we have to hardcode what always is the UART_RX gpio manually, every time

> +	pinctrl-0 = <&uart3_default>;
> +	pinctrl-1 = <&uart3_sleep>;
> +	pinctrl-names = "default", "sleep";
> +	status = "okay";

Please add a newline before status

Konrad
