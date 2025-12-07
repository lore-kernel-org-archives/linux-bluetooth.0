Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF452F88
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Dec 2025 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765144174; cv=none; b=W8wO3xn73AidwLTjx++3DFmx/OsqbItzPs5vkCY1/4a7EWoNywzUjnYiCI9M/XHlvtcinYElSUoYHTX47yjUbJtl+A43tmUdgQorH+Bto9E7LTb18ZiyrU7iPOftXDZ6FYCEntG5su9kRcAsbqeCX9FP2co6Z370BsTDjTx08R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765144174; c=relaxed/simple;
	bh=ADIUFF3NaF66VjOH+E4MOelUR2rRGzihe4N9ijxdzY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5xzglV9V6LrlJWukgZpaleUHwraV2gnN9u/ZW9i/oqb2uMg3Sjdy+5NDjggRS1mycY5wVxlqHOe20wLvLRQEPtSvPbQmshAC5VIQfS6j3OdGPijf5cuzE9YVwT7+joKmEGaUEOAzsSBOvJHI95ZxjYyWRTaubonSPVRp+Jw2aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R7kikaI2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WdiNehUV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R7kikaI2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WdiNehUV"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B7KPeXl3133572
	for <linux-bluetooth@vger.kernel.org>; Sun, 7 Dec 2025 21:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FNixEomyDSFdFEBjauMSbnu+
	A9TeWfJ6DWWKq8tjyZE=; b=R7kikaI2zntv7Yt0DptXvIwTPgEbsEZAR0+6+hCR
	X+AiPaIxZZnDwHJxMz16XF4PX0/n4i9uy1+QMnEasHfovg+nARp4tIo+nYoXXwTn
	4OL0sDo6yQQnVmEG6NzvalZ3PzrEVBIAQuWWsYIXnc26F8Amfo3skdarr9jxplzh
	aieLlypaJV5LGFEHDGcCMuWOIwC8CJLkYpL+Nk2Gd/9Vo4lwLz0DwNSTxKroasKm
	/K0tIeQ8oryUOu5Edxj6D9R00dCYF+S3zMlmbWsWrxf+6zj4ZOue3b4kZdptf7MJ
	9klvW4mT3WjL/eATSBeilD4crd/LKDcrZ8Tp377oBuYj/Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4avcv82wtu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 07 Dec 2025 21:49:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b4f267ba01so1058914785a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Dec 2025 13:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765144170; x=1765748970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FNixEomyDSFdFEBjauMSbnu+A9TeWfJ6DWWKq8tjyZE=;
        b=WdiNehUVFUq5/eqOv+ZFtlfl27+ViDWssnIz6Lcmrq2D+LD2vjyj55KMbXLbiDnq0x
         vRTPcENXnMoGbECaMGJkK+zlKRvr0Y9vu91mAEe2j/A8q+8UUwxonk/axNgpai9Z7d4w
         lY/bIBEx193thfA/Eaoi/W9up+ji8i7cZf1bWiALIJ4k6zS7P3uUdrAdrE0qD3Z3MML2
         aVMSXAnE/wIQx+jR8slIGfNc4+ZDoEkBhST+7U+sakF7+XVoNm/SYmlJ9apRnJUfrm5h
         QtlSLtzViPgYlI9qR7CJm7bSPfAiDp3nAV+7k737eXeXLi/E3U7crKjNw8yOaI4CJiv0
         FmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765144170; x=1765748970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNixEomyDSFdFEBjauMSbnu+A9TeWfJ6DWWKq8tjyZE=;
        b=wN9p0tnVzjgpV3BuZaQahyT23xgEFtwxTpZ7Xu45r0KS9uUsbgZ2e63+DWQ66SdWmb
         g+O4TTvGeYF0Z8WuDOm1EgScDro9dUSNjIByLL9/tSmYX7Jr2jmy0IN+shHlWWVlgY/Q
         ePyVGxiJuop+C2SwZu1t3HBpfQT+6nCsg7ZPurbxSIFSd3eDn8nen9+7TobhJpgWcSrR
         UsF4kfZI1g4Mstjc6/C+pLG+k72Qg3l6vtaOgiDZSsok831VoiBxrnphhX5nvGYmHmFp
         fgBfQ3zPDPgQfqKu473dSsMJwWfg8tuuXBxRwTHaIh9xCxa2ujiowKJTrO7ujBm5TdH5
         E5jg==
X-Forwarded-Encrypted: i=1; AJvYcCWKY0zPaAVWvsqLW6eAtH8w4bl5dr5Em40rgrlA5EICrx6Wlf6NP/Uo+f7k63LFh7Ivgg9lvTH93wvFa1zH+BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWh0q/UvMmKJBeVNcmIV8CH+DY18Dy+9lUA94mGnlMYIQdqHvG
	F43MP3PnS+x8Zw0L0uRCkOVu+FQv/Qs6HXBrLJfiPdn9M5lyPg5lNnm7r74vBjE3L+HnU0IqhHY
	7OtbuqyD5Y+vkpYOGLFHf4/M5p8RuSwqoU/7boi0ofYS5OtxhoxH+VZk+HG8UzDjj4S7+E6U=
X-Gm-Gg: ASbGncvJVLJyaozWYLISlifSvjBONSY3Ccypp32wSCJ/Yvz24NG7eAF+/Cvv+1xnjt6
	mN35CEVJZd5Q2dGtq5SgSM9x72FHgDvnyy94UifTcUXNZ3MaBrGFofhlNrAmtOhMYNWRs+Dp57V
	MPI2K5HjbRgZ+01j713B8bFutESi/iuhwQQG2Xz6XrVyAB146u1Nz1BC6urOKlrt4+MTsSnSBgq
	3KPzKCfaTISz3H9tl2YEa7HKJCg4Kk/BpKvs1XmPgaWHu7529t7A3f5x7YXohBSGzpwbOgFp68p
	+KuNzfl+SoMtUkM6ID0MsP2nLVgdoG+cfIU4M3qsvyk2CVyBT3ScjFYCfl6fRzMmpW/OdvvnBHU
	7DFl82Et9AurRvL5XoYzl2Q==
X-Received: by 2002:ac8:7d12:0:b0:4ed:ae94:5f5b with SMTP id d75a77b69052e-4f0230627b0mr216341101cf.8.1765144170426;
        Sun, 07 Dec 2025 13:49:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuCrwgs4G7PoLCqx7vQwkWcAcli3TelJ0o0m6XK3NwpIKsq9rSS9HSbvJpuZLjZT0AH84kUg==
X-Received: by 2002:ac8:7d12:0:b0:4ed:ae94:5f5b with SMTP id d75a77b69052e-4f0230627b0mr216340781cf.8.1765144169940;
        Sun, 07 Dec 2025 13:49:29 -0800 (PST)
Received: from oss.qualcomm.com ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b2ec2d8csm9597809a12.5.2025.12.07.13.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 13:49:27 -0800 (PST)
Date: Sun, 7 Dec 2025 23:49:24 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 00/10] Fix up WCN6855 RFA power supply name
Message-ID: <xykyhprdmcotntx6kaqhobupysvyhedfktningltk6knl7owtu@rlszij24zirg>
References: <20251205-topic-wcn6855_pmu_dtbdings-v1-0-165611f687c8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205-topic-wcn6855_pmu_dtbdings-v1-0-165611f687c8@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: zvzk6IF0B4ZS3sRfF6SyfXIkLnx8n1V9
X-Authority-Analysis: v=2.4 cv=KL9XzVFo c=1 sm=1 tr=0 ts=6935f66b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=DdBtMnqNxkYIvXj6ev4VzQ==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=M7h3R06PahCMBt7vG34A:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA3MDE5MiBTYWx0ZWRfX4u2A40sMfjLB
 rzzk5SHGYhN9XRctLX9pI3ZURIvnbWOuDz5GQS1gBkIeDVWLQqEkLztdS/VJQD8pdZl/3UvoJ0U
 9Q46UDxWrUN7WxmWQjzJ2sfYyAPk1LahBqHlfpe0TP4WAOZE7GnGusXAGwje74yJ6MUTHiGTR1y
 gEHUW+r0lT8W3J4xA9w0zkeEqrcTAStPSlLrZFoaa47HD2HYyCMqNC1jwTm9zHEwVtobUoQOvgt
 q9/K9r8jjjx9bRgJqJQa4geoFBrrXhaDxS9L9rX7FFXK72rc/v2KVdTRQX3Ak5MTGWtOzhThBS2
 x50zrFzxcrczKBCEn6/QtpdkD5KuAxKLqKF3ufwiOaB6QwBlq8RgqwiziUaxISmTnfOi5FZopGZ
 jHDApO9SBsR5MKk1yzKLGjM1cRk9bA==
X-Proofpoint-GUID: zvzk6IF0B4ZS3sRfF6SyfXIkLnx8n1V9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512070192

On 25-12-05 13:47:19, Konrad Dybcio wrote:
> Commit 5f4f954bba12 ("dt-bindings: bluetooth: bring the HW description
> closer to reality for wcn6855") renamed the supply representing the
> VDD17_PMU_RFA leg to mention "1p8" instead.
> 
> While the supply's voltage is normally 1.8 V, the bindings should
> reflect the actual naming of the pin. Moreover, almost all DTs define
> the output as 1p7, so that ends up looking a little odd..
> 
> Ultimately, this is a "fake" regulator that is consumed for the sake
> of DT sanity and this series is meant to bring uniformity and squash
> checker errors.
> 
> The last patch fixes up a less-trivial warning.
> sc8280xp-microsoft-arcata is left out because I don't know whether the
> mounting of the chip is on-board or as an M.2-y card (although I would
> guesstimate the prior).
> 
> Depends on the long-ready-for-the-merge series by Krzysztof (per-chip
> bindings split of qualcomm-bluetooth.yaml), mentioned below
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
