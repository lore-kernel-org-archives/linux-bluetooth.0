Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A1B29ACEE
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Sep 2025 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034917; cv=none; b=gpupG/Fm8fNAvPL1dIw2j3YlWGefgJjqvexPAxAsLSfWAxioOQL3a483NdoWMQvRl5nzUtBM98JmNfm1qTib8+/OpYPc7YO+vmOrNDWhhWPZ4QFRHIp8z50T1hAC2B3l2NCF9uNHH+bU53s+0q7S6z12NbmbevT6PbNB/a0mxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034917; c=relaxed/simple;
	bh=V6mHa38mysjYNRJUEikUz02oIziJBYgb5Fn53aeXasQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oH8tuZDXIeExxtk6ku0G6fsmobcjIM77ndT24Q3LLAcGoMpbBiwnYK1AvGERotPNZJYGeVroSrPVdr20Uc6Z0yuGsM+vWhOk+iwBkj+3/tLHInZkdZiAEmc03kN8TdkhFYYDbNEeVE3GxfWpPYJG0et81D6uU+SfwfoDDTsKI6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S5jmmFXE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S5jmmFXE"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9xrUl001513
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Sep 2025 15:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=of1NnpvC4m4tAzpcErPDN2SR
	dIgBrxNnPJCO+YtJdQA=; b=S5jmmFXEAGqIf5L0QoMesRIqTnoVPzOsRe2iJitg
	5eIr79BJhftgy4zM8bnRENnZseeoTmdcZ4huluSUi9LESv4Q/gQSeCkwZcktAdko
	Rj2hR68MotuHGXkp+fCaRf+EHLx0LzZ8ryWBQWfokNfmdr4mjwA8yZVTCuRMSOd5
	E+OmWZjiobz4pvdvMEI3S99mKivdIvVZZwa9vFxiK6+YMLICUZEfJ1c8pkzaHqZK
	wOSF2wl76YEob1iD/VGbgrS+UVciQ3C4O7Drrvr+69Ez5OSNV7Gwhff+McETG6s6
	BNUBUZ2AKBEjE6n8aQO1PJO/aXz6ssLlvZtipNbWnhu5BA==
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqq08ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Sep 2025 15:01:55 +0000 (GMT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4240730201bso31157725ab.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Sep 2025 08:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034913; x=1758639713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=of1NnpvC4m4tAzpcErPDN2SRdIgBrxNnPJCO+YtJdQA=;
        b=uuhu7eAJfdGJJr3UBtRgDPorCKB6+qrx2ygPlMSDskYl0CaqKnPVnHtYbRAEnrqaeV
         YaY/a+AuTex4xXMKte6phDaLtfeDvGuCgpIKSjdRhHK/wZfjrVSckfkRuYxPUH4wW3JP
         nQyk7eCJyXt7NiEdfwVB5UfN1VTN/VRxtt7ZZywt60RbwQscl2T7fu58B4EWDFeKILOm
         fwI9FkiLc1urVmr8ORWI/SFi/er7aO4s6Drs/8zMP+Zt/ecmL/K1NaDeoMAZqQy7EuG7
         VlJR4zGn3ts9+v2saR8PdQbERBf3CH3guNF5BahpZt25hKbVfX3Kc+VvU/pzI2QG9XBY
         104Q==
X-Forwarded-Encrypted: i=1; AJvYcCWblNLKdHXJtk2jMBcrMqi8kkZbNfLofV4794LS+hC/u2WLHgAC7+pCJWeeivr7w07IdWGgnpeJevoU6YQW8PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOmbAzPVPoBgNXanoO5y72Btk5pvMvnXbhMUg/tEAd4/xG8kyQ
	HpDH1xPWSTdmujYmsA/9JXKV8EftbdSX3011SdS6gIx436a/ADrFC/6lt7ENd9S/lF/NYAR0qy2
	TKKxjqjU5gNbyI8KQ0Kk8NIgieIKNKgYGNT4nka0cfQpbAG6ewfCL7/ghQQqohTur/JQjwXI=
X-Gm-Gg: ASbGncuJK5mLGDs9kyODJa2e1sZ7QF364SeMfBCKSGJYS7t/oCjljyQWFde7BYqDfaE
	jCD2jFMEMvJZnE7GIQF0WZg3GYGfqlLcJU6ybVcTCuTsdncReE7o336oVBEy2pYT4FchphdOBlU
	NKr9Ro+bjrXPw51eylngHlC4nQ7hFyE34hmf6zvD5/Ey6+v+e++zcXCVnnk9FijAJ85xm4+vFFX
	nh1ScK+imHS7n5//J64imwxPXJP2JyLh88udpFZ8UmMXUp6S/WoouXVWFc6UQNU1TYlqcYPQKdr
	SJ4MJ/YilCkvblptXrpgJGEatfDYe30vjsQYzkdE91MgfuBKNP5boIM2kplnI2EB1KdYs3AzvVv
	3iDY0ohUTuSZorq1LRCYA7MpR3irhq+sdWF4bl/AMCfB389HYFKr5
X-Received: by 2002:a05:6e02:198d:b0:423:fcd6:5487 with SMTP id e9e14a558f8ab-423fcd6574fmr107539465ab.14.1758034912436;
        Tue, 16 Sep 2025 08:01:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNVfwi9Bmg9i65JLMcvGviSI5VrkiLbBHhSFRGqNxTjXkVrJjQuB13UCEP8RrnMUXYQhCfcw==
X-Received: by 2002:a05:6e02:198d:b0:423:fcd6:5487 with SMTP id e9e14a558f8ab-423fcd6574fmr107538745ab.14.1758034911743;
        Tue, 16 Sep 2025 08:01:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-350c15a7382sm30545931fa.16.2025.09.16.08.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:01:49 -0700 (PDT)
Date: Tue, 16 Sep 2025 18:01:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com
Subject: Re: [PATCH v12] Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail
 when BT_EN is pulled up by hw
Message-ID: <vipw44g3fmaf7yhv5xtaf74zbgbkwhjgyjtguwdxgkkk7pimy6@eauo3cuq3bgi>
References: <20250916140259.400285-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916140259.400285-1-quic_shuaz@quicinc.com>
X-Proofpoint-GUID: eS5CAvd9Uj0GDLhj2CymwlzHVZeiLn-J
X-Proofpoint-ORIG-GUID: eS5CAvd9Uj0GDLhj2CymwlzHVZeiLn-J
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c97be3 cx=c_pps
 a=i7ujPs/ZFudY1OxzqguLDw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=H90gdJbu_grP5bgN1gsA:9
 a=CjuIK1q_8ugA:10 a=Ti5FldxQo0BAkOmdeC3H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfX8qoNlEHoQz6D
 tLHaFCgAqjceG9P74MTVr5sIvUqAVx+4busoBvzNRRDQoFJp/kAMV3Dby+RFMXGFnTKA9aST1e5
 nXqas5DDrHPQxS/Jx72oirKhAp+1Wn01cGYRqRYfD2gn87HW3PuVQ8w7gKcDNaZ6WPSEiQ3ovFa
 xJ+bQ/Gla2DAmXpt1lMd9QkJJ5gtyuROfVRqEDkDQZfscJLgIELIQyXPbsthKSXkBOOQ+9Y1Hnj
 AHrqWZnXa9SKbtYsQoQRr6PGU25LVfHJHShgWNYDH54X6QN76boYG3fSJMl+0zCmJDumrKi2rAy
 IoBhlvcPcC5USLZXCq0mQ06dg1zw+lf7QDIj6yKKMEcqmItyEPWTdoMeppx8aWvH9e6ILVEW6nv
 f6aAHNy1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186

On Tue, Sep 16, 2025 at 10:02:59PM +0800, Shuai Zhang wrote:
> On QCS9075 and QCA8275 platforms, the BT_EN pin is always pulled up by hw
> and cannot be controlled by the host. As a result, in case of a firmware
> crash, the host cannot trigger a cold reset. Instead, the BT controller
> performs a warm restart on its own, without reloading the firmware.
> 
> This leads to the controller remaining in IBS_WAKE state, while the host
> expects it to be in sleep mode. The mismatch causes HCI reset commands
> to time out. Additionally, the driver does not clear internal flags
> QCA_SSR_TRIGGERED and QCA_IBS_DISABLED, which blocks the reset sequence.
> If the SSR duration exceeds 2 seconds, the host may enter TX sleep mode
> due to tx_idle_timeout, further preventing recovery. Also, memcoredump_flag
> is not cleared, so only the first SSR generates a coredump.
> 
> Tell driver that BT controller has undergone a proper restart sequence:
> 
> - Clear QCA_SSR_TRIGGERED and QCA_IBS_DISABLED flags after SSR.
> - Add a 50ms delay to allow the controller to complete its warm reset.
> - Reset tx_idle_timer to prevent the host from entering TX sleep mode.
> - Clear memcoredump_flag to allow multiple coredump captures.
> 
> Apply these steps only when HCI_QUIRK_NON_PERSISTENT_SETUP is not set,
> which indicates that BT_EN is defined in DTS and cannot be toggled.
> 
> Refer to the comment in include/net/bluetooth/hci.h for details on
> HCI_QUIRK_NON_PERSISTENT_SETUP.
> 
> Changes in v12:
> - Rewrote commit to clarify the actual issue and affected platforms.
> - Used imperative language to describe the fix.
> - Explained the role of HCI_QUIRK_NON_PERSISTENT_SETUP.

I'll leave having the changelog inside the commit message to the
maintainer's discretion.

Otherwise:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 

-- 
With best wishes
Dmitry
