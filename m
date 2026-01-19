Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBAB30C608
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842731; cv=none; b=M27Q/CBRYlX6nPZ33J2h5B9QcGzM6Q0DaMgf72OqG99OEv9BG1OpboRfwvPaRp1GUceWaW8YYsIRHKpjYbiqQo6MDxbqkxKC4Lkd50J+8FgejlQYxMQRS/8si6KHRJfKs7nIErRpJ48DcPNxWzbcqfP5w23w9KChZuzcUrxwDwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842731; c=relaxed/simple;
	bh=rcJwkzNdyewx+FVQ3AJEoWO4Micsemcg0w+QV0mV21o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goog6MBTnbPZ4svjH/Af4MIknbA00TSRHOOLXOqwLY0cYDLHaC6D4My7xkqb60TW3+EmWwRkqR/h1DZFkSafQLpe/+ZLuG6lyueDkDxUJS5TOlhBmdsAzsCr6Fln89MWD0AFgmtgwHfQy9uDgaD7uSB9xQZEWWCSKl//5zBJVow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=glJKjME7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IiDEpcIL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="glJKjME7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IiDEpcIL"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDQFe1440867
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 17:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3ZsbBKA+dRZT/p5GDI02yQEo
	kHT1R1bEsa+NmtTW5Is=; b=glJKjME74J5wo7nuj0PiVxZMObcfEtwAjdkIEr0+
	WFQNrVSUCT7pUImG41yyLnsZZUXwZGO43p7EBEUY/WZCIhLB+u6rrncLCN4xjSFg
	H65uBU/E1hA2omNNZX/PPoZdla3Z1f6Y4T+/VfGKCKkSUtB8Obu/dFqCCkyjUto5
	o8orl5mjKiodNQCiL91Ir5TyWxaPcXc5cwO2A24SLkaSzxNdgaRh9z/jWMZ2EAWe
	z9rQO+kvvrjuXvbS8o60T8MDgJEcKL0ps6TYfiqTv+FV7WGJFsLRW3M1KHm3Cal/
	5NZGLbNpohWaBm3j+AVt/QTLo//hK8MxVVNkH4fCnAprTA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bskj3h1g4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 17:12:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c1cffa1f2dso1368997285a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 09:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768842728; x=1769447528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZsbBKA+dRZT/p5GDI02yQEokHT1R1bEsa+NmtTW5Is=;
        b=IiDEpcIL8xjNopv6TADhm9tVsFcS9WQlH/qcvYEpo4zdBka9nIIHz5l5ArrekuIyrQ
         u0pf+TaN/DUJM4GbDiiKFMIAT+T6JTL1JtaAVx7GmpWI/hKeBN4ownpwiKPXjBx5sHEt
         viKhzxMyFXNCTjaA88OWlUcwvmheJgi1DObTe6hLt/bRDN9m1smrzZ0mblD96X4RV4s2
         pB/mhGtE7YfDD03TTeLr86gbmWMBKz7iYcfZi521gwhfplxnT6zPvpmUceC1jlH0jepw
         CCeCXMmcdf/BbMWuHVvYL6pFpdhGlMVFnU3ap9Eoho/rDPjiW0e/K+l2FlHcF/D48DS+
         +bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842728; x=1769447528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZsbBKA+dRZT/p5GDI02yQEokHT1R1bEsa+NmtTW5Is=;
        b=C0xTvtlL2udWmzIiW3iF3sWIeCqV1Vt/IB8U9KEZL2Le/y2SFr8ZkjHtLc9gAAQ1ja
         r7e/nRBmJAp7viS42VHa5Xawq1QNiHcKJAGDEWF0EfE8wq/WEgvPaCAIUE+il7ybG+EK
         weCcOa7G4J0nrpJ/BJE+zYG+ZgFfrViEXrMUcdNKQRF8Y8pDAMThqxtPpJaiPbYHcGW5
         TdcU4kjM7b4QwejOFN907mzMMKD1k0NK27PISE4cclGLjlSe3JH4lM8Om9/JT7sn0SpN
         Xqut9TQDyH1278DcE4XSLI6kgBJ2Qc+mWNrd6EzwB7FFYn6oHEgf6XgBqIJMYZvVkU5l
         bJ4w==
X-Forwarded-Encrypted: i=1; AJvYcCW9d1XUkZhnxYJgGLYmnprH7LbWXMuKxvsXL03eKnQLDB2mLKYaZJC+5aIfwj9QEluywP/h7VAEvjX+kybcd3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb1DboxJGbgOGM72BdF2U/Mhwh7pjSkRHvaedv0LlKrQzXPGUq
	6qMucIxk/yf0isO76hcGfsaBblbXMJrKp+Ro/5grM85GmoKMS4mfqHy0CSXGz7jcXxmaVlP5/Aq
	u/Q2OtztanJTnM/ViFWZUAQ4/LoqNuLBkQ+BbJ4fsQCVSII/MkfbxQ1xFMeuTQjE0b6UznB0=
X-Gm-Gg: AY/fxX5f3YTE6ynDFgVN+39PYyoxwDyaWuR2q42Mny52r0nzeqDHjDbcdcDZlONWf08
	6aE1pjY0U/6BhwL3fKc7pqPPhpfo0LA5dRYCoAAM0JvinFhvFNCFOJqYTu3qOggknFE0u/vwefc
	9YbVfi56G6PZJAAICyJS0WoD/FWb8SjQKqPeTPlZBgYyPwLODAhkRhC2f7kNatXu6LOc3YKP9Om
	YQhw4d2OcJx/acjNWcGHGFSRLMTw9b2aynvDvvNF3D5+SaoNiZXDYB+Bp5PB3WVCOCdMhRBC7G+
	JSP3IjddBhbmHSAR4v7El1GcB5CLHzHdObp69SXfxnUjzREl58Vfj+M4mCL2sJaRJcljJgUZQ2i
	/jueMG3tRd1WxoWO8xu+STV4f7XEnKte5rMFIEK1lmH/OLm8IAOok5XLXPj+QckCc0+ZbeCILGA
	wPdAW4MaxfHwCZSU5O+Q5Lm00=
X-Received: by 2002:a05:620a:1910:b0:8c6:b16c:a56 with SMTP id af79cd13be357-8c6b16c0a7amr1198515785a.38.1768842727999;
        Mon, 19 Jan 2026 09:12:07 -0800 (PST)
X-Received: by 2002:a05:620a:1910:b0:8c6:b16c:a56 with SMTP id af79cd13be357-8c6b16c0a7amr1198510085a.38.1768842727485;
        Mon, 19 Jan 2026 09:12:07 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384d8e2a2sm33129311fa.18.2026.01.19.09.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:12:06 -0800 (PST)
Date: Mon, 19 Jan 2026 19:12:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        Bartosz Golaszewski <brgl@kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2 02/10] arm64: dts: qcom: qcs615-ride: Fix BT RFA
 supply name
Message-ID: <skqdemh2r3mukcwc77qwlosossgyabsnrst4hyc44hbpqschxo@szt7dcefsyuw>
References: <20260119-topic-wcn6855_pmu_dtbdings-v2-0-6d1c75608bbb@oss.qualcomm.com>
 <20260119-topic-wcn6855_pmu_dtbdings-v2-2-6d1c75608bbb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119-topic-wcn6855_pmu_dtbdings-v2-2-6d1c75608bbb@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ds7Wylg4 c=1 sm=1 tr=0 ts=696e65e9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Nyj594bfyUKc3hNJ69IA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0MyBTYWx0ZWRfXz0rZkYfrRRRq
 0FFPxDf+SyZ4c6LZ9CJiU1sY0a4i2J+/rifcAsz7YiHBI/5LCZ9FPv8CbQXHyDSbz3iS8LvFyd7
 g5Wmsei5u4epNgvKN7N3Kyhye6lpKAUMIXUjoQzgdhu7M63rlLiKsvIDBzT6Q9GVPOwGD7POf4A
 9oYL3J7ijGwGTVdO4X22i9pDpSf17ADScC3Mddoi8Z5rPTRZjyohi7wKsGOoZ6SeWvJX19AOByc
 5EquhMbs9QC+ZcSofI8/yG+58xNS+OJjM7QotJBJFRal9O3mA3HwlxoUTOhwnWuYYvmS0zPc/7U
 9j8Izr/KsiA6u3XpUTrboB25Z/cCVSBY2aaa9UvQ4a/FNsVfaQwhE9wLJMx5lE+CBtC4MJxixAo
 wEbPuugnEJdIQoAU3OoqNCvtCWYYy9LSopiY9Nl+duUQZdCkn7BCSI4aiPUjHlw1PDQ2nr0VLyb
 AXbfBwTPZwcgyCcjEPQ==
X-Proofpoint-ORIG-GUID: f3xYoWPsuG4MJ3d9eDiOXhw4ErNlFb2O
X-Proofpoint-GUID: f3xYoWPsuG4MJ3d9eDiOXhw4ErNlFb2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190143

On Mon, Jan 19, 2026 at 12:42:24PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Fix up the supply name to align with bindings.
> 
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
