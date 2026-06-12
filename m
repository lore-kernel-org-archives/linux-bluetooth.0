Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED737C0EC
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250149; cv=none; b=pr8SbG0e2PAbFM0Nh+tRd0mKTlciZcp2xZgMk7ntJM5p5y9EviOi1tJmujF+Q/hkVw2kak99XVeGz1LMVqPCXHmXU45BYBkK9TDfUcEWnaRGBOVQtAqixCzfp6c5IkeYUlYR+NhkPgQ8pldc/c1lEkVUjCVPFs6ZnB/JSA40NEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250149; c=relaxed/simple;
	bh=8MADXtOGV8KF/kqzB6Db5Pes2x4RwhCItEQeJpl/zmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lknCTDIJt7tnmlnav/ukqJyH+ojXtzw666EiXHXvY85QUHMcAJtUlQR7zKxlVxhvA5JcYtzowMQCe17UzE5ed5S7wPjkn4Lum5t1xrf7zULPsgR087MECRxqKyDEU138YQggbbIzLwJaA2s8A3pm9DWtE7KyzR0F+8HToCWfOi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZXTju7jJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yo5yUxAW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZXTju7jJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yo5yUxAW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C3C2762549535
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 07:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wqpGE+ezK6pliN8Wm+4US6Wkt5RGSUX42MuglKBmfmc=; b=ZXTju7jJkPV7uPln
	egVHuyspw7m5CF8FU7GlgpJ6ZVImud6QpcZ36XaK+bYX9VTDGHpVeuEsrtqLk4zF
	4OrfAIGV5L/yrUn1LVAbhUV1v6IkPK3U6IIULFaL6G6Tcl3x+I54IBNBFPOxjj/J
	s0GWumcWopGN2WMBVa6n8g5Qu7uiE6heC4d8zA4DEbvxlzwPqyDt90txp4Hzr/HG
	R4O7xtuqdV2YwCi0Ou8S0TSGM+8an2VuO5E69u5ABsH92UwZlbJoNUixlxjnLRiX
	A0NFy5eTsXobq4rtJpKM7/xtaYRZKO0XHI1pfb9+lr1cTfnPShreh9Cq70NmZHzc
	vsYW1A==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er29ut7fr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 07:42:27 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6cfd2a26ab0so228966137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 00:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781250146; x=1781854946; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wqpGE+ezK6pliN8Wm+4US6Wkt5RGSUX42MuglKBmfmc=;
        b=Yo5yUxAWKhMS8XVbYOWZ7NRQ/Ppgh/oyf11qO6esshnqggWYKo/6nokwChrOgX2EYE
         45FxWtgMjKGz7hvg7raZ2E7/GZyKF5Qj+r90YaBoWoAn8ewhKdAhR7D3FFCyN/ZE6J6s
         tJDgQWD3Ruym752j00vJGOVs42PsPtAXSJa3PssEvqtcFivrXOrv3FyYi/heDHaT9k6h
         gwdM1CpCywW4Amxa7rSlIvugp6hK1nkqewrCmD6UlLKrtjHlRtHa1DM6WY4vAF7b2OjV
         l8/VyKv8lXfZa2UlzWFmLgpV3/vwaSJ+ZefTolPyHmTD8OghZmqxZ31AfM1LnYAlIxVY
         /HNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250146; x=1781854946;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqpGE+ezK6pliN8Wm+4US6Wkt5RGSUX42MuglKBmfmc=;
        b=AW6mk3HtODwKugW4P+yc3C6xz1vFIw0A+Zxbh1JGO3Zvo2ZvOwk4r/WLt5gcYaO4+2
         6A+mlcZOeeuKEUzhzldSIajiGIao8rWHGYSWI0xgqdcAN0ihZCyA2bpU+Pr0Uv0Da/Xs
         r0aLL2KaUUp988jpLk5+5t5xKKSK9yUqxq+SvsFAS4FWDcU/V/Vl3AjCe59Lykubq0NE
         0i4KsxT2HPw1BfdP85x663/f/JURRJvJkR5zryB9/PRu0dJGNHij0c9GW7ZCxKq2iNCb
         A+luVP+uhokSRQKwdLjmYxFxvIyCT1lY6bNdHBEnMFwdDB0Vk6P48HP5xHodUSxZKZHs
         oQvw==
X-Forwarded-Encrypted: i=1; AFNElJ+OymV8rJ/CqWa5c5i++qdG2HdqDzzdhJXqGoy7tJz+/SUSBbb7geoxOrP5VL9ZPt6T6If6usApBhutwJhQRVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypGUFHcL1yD7Ccn90nzpBhUCg3PyFv7EeRuOPsNaTSYeJTFq0t
	X0/ujn0GK0q4A9Fb6eTKSGhZn+MBJm3YSVN2Gq1jIHmi+grXkedL9S4NwJxIvga7XhTvRd9m+XH
	BbkxluvCBL2u6ok5DkngVEc8KOUcNTmd+SsTCd/PAPsq7tTmLzNxdcEoZS6RVtWfDOaNpSE8=
X-Gm-Gg: Acq92OEweHv7CoJxo4Crfec+58SrpM8hG36CJUyyVgHU2bkpnKBUPjJGS6QAcglNFGJ
	U8y3xJzvb9AUosDE/CrlHOgPauQHX61qe59zDJ9gFZgLcMiTwOnD2vlz75WH27Qbc6Uekl2Ap+Y
	c+IPJ2Uyax/+EPJ/NYq53gO7fYYrwSamPqYa+Ry1ZZ+ClfF5xEgYcu92J5kLHUBeYxu0Zni3F5Y
	5kmBWWHZtjymMXicsEOhfv4GzEtDgvY+wDPtK/ajpCz6sp0FA441WgnobrE1cvS/xD9xIwPrblR
	usPracSSEsnn+7NfJjRaxkcM7HXzNOdV1YcguWJfh/ddWAEfrEkXN7FXRyWun3lTowAstHMmQdd
	NqFiIy7m+62wXEx2XpRccs2ipX1gcDQ5mvzaiIFaANDlkX3E3zVc5Z8JqdIRFHCrzLTyZWt62GV
	oYQfEDlYzm0i+C6OFCf+C11/QfRDvCXNK3H7o=
X-Received: by 2002:a05:6102:5985:b0:66b:a0d7:abc4 with SMTP id ada2fe7eead31-71e888cbcd9mr558691137.0.1781250146517;
        Fri, 12 Jun 2026 00:42:26 -0700 (PDT)
X-Received: by 2002:a05:6102:5985:b0:66b:a0d7:abc4 with SMTP id ada2fe7eead31-71e888cbcd9mr558673137.0.1781250146076;
        Fri, 12 Jun 2026 00:42:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39929c2a00dsm3925651fa.7.2026.06.12.00.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:42:23 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:42:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: Add BT FW build version to kernel log
Message-ID: <ofpsjpkxrnzbnfza2emhli7xp2gwunknywbig6x7pzhis7yqyy@5z75psmjf5s6>
References: <20260609075417.1160702-1-xiuzhuo.shang@oss.qualcomm.com>
 <20260610064232.2385866-1-xiuzhuo.shang@oss.qualcomm.com>
 <CAMRc=MdojC6T1RuqRNE-ssoRw1pKyUHyOS9AD0ROfCpPPOqw1A@mail.gmail.com>
 <c0eee7b4-50ee-4635-b8d6-fe9cb4ea05a8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0eee7b4-50ee-4635-b8d6-fe9cb4ea05a8@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA2OCBTYWx0ZWRfX4bMi+eYnq96W
 CpwJbuT6/uAh64urGA7OlcDMODO+6aQWxJsjcxHWA+vi34g373giovx73Eo4tNqM9x5YnzVht0g
 9+D0f45Iy1TRZD6qinYyWgng2bzT/Xs=
X-Proofpoint-GUID: 4t3oW3d_6UcvlemjUXxJXED5WuUMW8qP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA2OCBTYWx0ZWRfX1shZCKRA1vLY
 zn4+Dc+iyqTf4IwShxZyL1eYKGf79CXSDM0Qv8PeerspA4dQ/NSwJS67qsaDITav8byFO3sp95W
 VODjfoyWWk4WHSrPBWgc6iv8yoHzv+zLGPbdiT9EM/Iydfm6OYqBYDSQrxe8BFkYDjzvQuk164K
 vSi4kCV3jQKY2DJcxG12RbyuyvmbYDafITlnNklNohOBzasVcHmu38aPVAldQCxiivm+GEethH+
 VD5WAVEVxC3gRA+XLyCMUeTyYFQLXLw9LXKazt7yqcMryMUCkCIpjfkDdSqQ4hNLxPvlvPGjJXh
 sGusII1o3ioNk9bw2WRVvZujKNAZj7Auxz4/+rfsJLQo2gT0QE8wb825awTT0bxfe+StKipinP/
 JxzoktIVoSYG63V1Tn2GQ2R6LrzasXfuJ0bV1htk+H3J+Sfwy/toFv1IFO7UCe9SMXbf5PO2wTJ
 I2lH9zZYlQUoMMrlQVg==
X-Authority-Analysis: v=2.4 cv=DppmPm/+ c=1 sm=1 tr=0 ts=6a2bb863 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=yzKO1qJbFRXFCGg-jfsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: 4t3oW3d_6UcvlemjUXxJXED5WuUMW8qP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120068

On Wed, Jun 10, 2026 at 03:36:46PM +0800, Xiuzhuo Shang wrote:
> Hi Bart,
> 
> The main change in v2 was the commit message — I added the motivation and an example log line as
> 
> Paul requested on v1. Carrying your Acked-by (given on v1) forward was just to avoid losing it. So
> 
> v2 wasn't sent solely to collect a tag.

Please don't send new revisions as a response to the previous
iterations. Also don't top-post. Responses should go below the questions
/ comments they are intended to answer.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> 
> 
> Thanks,
> 
> Xiuzhuo
>  
> 
> On 6/10/2026 3:07 PM, Bartosz Golaszewski wrote:
> > On Wed, 10 Jun 2026 08:42:32 +0200, Xiuzhuo Shang
> > <xiuzhuo.shang@oss.qualcomm.com> said:
> >> Firmware version is critical for bug triage. Users reporting issues
> >> typically share dmesg output rather than debugfs contents, requiring
> >> extra communication rounds to collect this information. Log the FW
> >> build version directly to the kernel log so it is immediately
> >> available in bug reports.
> >>
> >> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> >> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
> >> ---
> > 
> > Please don't send a new version if all you did is collected a single tag.
> > 
> > Bart
> 

-- 
With best wishes
Dmitry
