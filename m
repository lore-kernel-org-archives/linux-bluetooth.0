Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B9626B2D3
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064880; cv=none; b=EmKsN1B69o9SNHAijB3MS+zZpDpJ0K5gwdHTVKgSkht4vyU2VN7GylQOZQJXx18tF2RXkMjvBfBl1kORH//vdDauLbShXzhyL1S6QODnMyp/GDmu1BPwO0J3qDDABTQUQgYvqeNvGCE0tlSzSEBAEY4iGkQI1wbRN85p/kao28k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064880; c=relaxed/simple;
	bh=AI/sQdV27pRuG1UG93jWy8O0cfI7jlAIBk7rWDkB574=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVWIKNAxfUYd2eml1GnnwVcaEkuSKI4fxr5EUQPhZ/5g9nBVshfY6KcoLjPg9dDCHBIz3hFSKX9Qsjlx+GOpXIIACHkdkzz8bY8PE0bQt1RB8Pb04yfiVKm3eyq1Nx3xGIQ1RcaTbWnYpz8r4Bwxf2va6DyAzKq6Tu6XVBrs4S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z0l1U0QR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S2jgeUOu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z0l1U0QR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S2jgeUOu"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADINCnw1173770
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 20:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PN5o3JxT68gD62VcfZEL3Ebk
	8On0PDZMV5SQeeSv2nc=; b=Z0l1U0QRe+5Z3laKQk1X/sUI81ErD6j4oCHnvbat
	E3mmXqEajKCbno1nfP7Eek/UB98l/bE+64k1CtCWqgXRNeVpmbvWqzZ9Pr1zj2AV
	2CHps/Q+AJmhZLjNSvj6IIM83Uq2Qm8Hfnc2clhwTRyBeSCMitcukgdCiyxGPaMR
	YQjeTePPiHkgQj0y5+iSm0+qr63Sym6mOjeIJJ414YjlSTiF9NetQYUSF/FJlnhS
	b5ONlBoCNYi/Sn7hwbsiwaQQ2Ms1blJs3/nJ88qV2MM7tP8MDIKcJh2gjTpXG/2t
	cudmqU59lKmNFi2JTzeEZ4+qAib7ekQVUT7r7n75lB7OLQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4admj8ga92-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 20:14:38 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88233d526baso45029886d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 12:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763064877; x=1763669677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PN5o3JxT68gD62VcfZEL3Ebk8On0PDZMV5SQeeSv2nc=;
        b=S2jgeUOuVxAol1EHKO6OSYgST0siriSlRxuI8bb+QeTWMGAaUySq3bZ1CTum30QcNn
         lUjSg5b9Liyoa4roizOhtDpby9juJ1+0wpLcivPyykwUecKxi7BsMlNxhQTOwC5Fq6/Y
         kMZfG87XnlzBFg3L5u+5aL6DS1wiyC+k6P4P0BwWfQgY7eazrouJnSrEm9bKIJ+EPvjf
         hafP7B97dZ2h17CFlNMs3QutfBEvoXZJ+M7GE2pKsph8yST8mvkbFjOW+9SWVNIA8JLO
         IEfZMuDF2QFTYQUY0ZbnklFtErR+4D0fpOKcAw+6vt+VZrFCbYhjBw9BPZno3Y+2tV9T
         ubhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064877; x=1763669677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN5o3JxT68gD62VcfZEL3Ebk8On0PDZMV5SQeeSv2nc=;
        b=CnuGS5RA1AjhD/pzJ/MWtvjpArNtqGAJz/QfOZUXR1V1XYVfepkBiHA5JSkSYZqTEB
         db0A/wGT54uN7s1bqRg46zAg1O6UOHa3/2iNf4okW6nk4kGCl3yVAnic7fjdk2sSUeSF
         A3+ViGvV1TPnYMkDtGltnZtFRh4hYpQuWlSpyn4ES8GMUI8Yez+p+rrErv/4IaCoZSZe
         qtZGKAFoALTaoOk1QMaPskn2doJ/feEE/nxNg9dTbz2gdidaDb6fhCb81YThCz+WN5jn
         vRXL8xJ6gWQiKLrb/EkFw5Dkrt8kYQfBg2wtn8+JAxhPLbs2MvrfuHx8ImLdKTwzLhDS
         YI8g==
X-Forwarded-Encrypted: i=1; AJvYcCWveG+zTt+u09eQ60Mdw7oDI0su3jpgV5a+Xz+8T1VxJlw+tK5kIDulNOUkcFDqacFCDj/eT79m6OpemuGt4So=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTBhDg6shmX/kDD0L614Cu1XEIwgm0BFkEZqMlEhU4/fR0YNi0
	A/kxXk3EwVURdKBjOwkhdm6OgZ9BGAepPxbtQUnZNJggVJxf9K9Z3fXyMniOmaPLMTnkJE4S0uG
	kaVi4bRJqJ9MoJQ0wCCdyUMa5c3EUjZY+EJfJetIAl9N/pWVwqXGftAnF25Go/EcEjLGMdtA=
X-Gm-Gg: ASbGncsK8BO8G1VykIqbirAEhMj+OqfhANcJIhrjUpBVOIffINYz8Me7AoqieYY7N75
	o2M9cvS2YWdfc5ZSigomFOq58M/YwHY+9HGAtf0FOedAsa2H/WwAEetQojaWfDgHq4UbNECH54g
	oYthzV1g+cLcyJas4VlnfxkPZ68BF1OYPi2Acp5GZhAeh79iEo1CM5GUxil6upqquc3g7kvfgA4
	3W86/Ip1jJwklrw09B5P3/fP8Cmw/lzh5iwOmhehVAKB/wWCx7vpo1Nx0LpiQXuCj+crZj7n1JC
	7xsOlX/tBMfMM/Y0ctMw38K9U6DEjzWaHLIiMeILLUwZ47xyheGcV/d0j3cw4AOpVixJPUlyvxS
	yPOT8sHR12OM1C3PzKG5By3esJVRwwqm6d0dxCTs3rkXs9cHIiaGTIOJCzDj9aadV8XFw0hB3nl
	9egCkOYZOqfqLf
X-Received: by 2002:a05:6214:628:b0:880:4dd6:20c4 with SMTP id 6a1803df08f44-882925b634emr6722106d6.25.1763064877405;
        Thu, 13 Nov 2025 12:14:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7gf2nNHl2mDJHcdRunnsr1cDxkVTsv5LoLojLfO7ZxN24jktHyKPFTPyMsxGUSBzT78TNdw==
X-Received: by 2002:a05:6214:628:b0:880:4dd6:20c4 with SMTP id 6a1803df08f44-882925b634emr6721736d6.25.1763064876942;
        Thu, 13 Nov 2025 12:14:36 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37b9ce2798asm6298391fa.23.2025.11.13.12.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 12:14:36 -0800 (PST)
Date: Thu, 13 Nov 2025 22:14:34 +0200
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
Subject: Re: [PATCH] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth support
Message-ID: <nh6rlcyamnm2spm54oitckujnxp7wna26vomxvlrik3mlhh3no@22skfvcsrfhj>
References: <20251113130942.2661069-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113130942.2661069-1-wei.deng@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: mBhazLXKlcMX9R7UhHwPwxXwXIh0rtJ4
X-Proofpoint-GUID: mBhazLXKlcMX9R7UhHwPwxXwXIh0rtJ4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE1OCBTYWx0ZWRfX96lG2oc1Ctw1
 NV5nxmUd1HWGA38e2o3/ncyl2PnB7ZHPi9NjKTF2tR1HFyfs2SYjIkEdIUeDDwjsDT2/MAldddf
 svavW8W9dea0kT+iBQQfb8Iamw74mYTKwdHUdFxYBRmXI/EZaqAWptuLTEbi0rR98FMhhl0tPZ6
 K+IKWY4M6xHC+PKmVBpk2HsTqVS0broa+2VZGbiDF86B6yXMIv3SrpyyPD2XAIWCjok6c7U+pg2
 X+/1ulhuxg2JA4+cmv0kAxNSun7LICC20AYqgJjZZLaiQkk2JQXaoAdVgtw/spxmNhe38VBfBjK
 SGZk1HfIgc1U52SaQ59Q9yYMQJDPVDtTT+Wr09moWyMFD0j9I23sBryewwT+S9VZANx2GKl77Ym
 NTZ5tCafhzx3feUTIZM7XIss/fchnA==
X-Authority-Analysis: v=2.4 cv=AJKKJ3lP c=1 sm=1 tr=0 ts=69163c2e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5bVZ9rrVUiTTcsr0HSkA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130158

On Thu, Nov 13, 2025 at 06:39:42PM +0530, Wei Deng wrote:
> Enable BT on qcs8300-ride by adding a device tree node for BT.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
> This patch depends on:
> - WLAN
> https://lore.kernel.org/all/20251113055148.2729943-1-wei.zhang@oss.qualcomm.com/
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 28 +++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> @@ -571,6 +580,25 @@ wlan_en_state: wlan-en-state {
>  	};
>  };
>  
> +&uart2 {
> +	status = "okay";
> +
> +	bluetooth: bluetooth {
> +		compatible = "qcom,wcn6855-bt";
> +		firmware-name = "QCA6698/hpnv21", "QCA6698/hpbtfw21.tlv";

The reason for these firmware-names should be added to the commit
message.

> +		max-speed = <3200000>;
> +
> +		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
> +		vddaon-supply = <&vreg_pmu_aon_0p59>;
> +		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
> +		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
> +		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
> +		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
> +		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
> +		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
> +	};
> +};
> +
>  &uart7 {
>  	status = "okay";
>  };
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry
