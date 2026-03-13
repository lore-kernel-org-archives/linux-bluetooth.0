Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B529408
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404199; cv=none; b=dE4DJCwGt/Kht/xs4TGEXNitTOWlmMNgWtD2N1UoKexDMvWTWlZlr3mAwy2X6MZaZFj9YTVcFQQZFSkAk+ViSGFzguU3GAa28X1YDn/qoUnBH5lYtcU1AYGiS+jVZevpUkibix+XIoc4TIeePH123kbnTE++NEwz2rUn3SPxBZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404199; c=relaxed/simple;
	bh=xEfIqwAvCrIzypzvqBGix1qsgoiR+HtZqXThTD/h2uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZwgiGt/u6JXYy4lUWRRId1+lvueT2X1NOe8nmqbExRrdXinIThRD9iZOyA4vcjdStFbQpe/5h9UJkFiKT+iExz6swJLuLDXnE60s2+slkH0rauLQtOzbrUQbIIZmwp+n7MDjZ2l+4VtlP1fYsUSie8PO+Kj19tTbOpvGwXoyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fm4GDGgT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jJ7RVREI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fm4GDGgT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jJ7RVREI"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D9B3ll3906285
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 12:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NNUJ5IqCd3Oqw2HL5xxF4SqfTaOfSP4PBNslwEEXpYU=; b=fm4GDGgToa6BwCsg
	LD53b8aNpBwPg58vBnnMM4I3WVWBL72R0fmGc6nOIijaBetaoQ0qC4O4xpmk5JYu
	He8F/9eCAiO9sPgMDYGRgMIQ8UZ8USgiYz9pG7OHY/S4sX92GqLYnkJQDoJaPiBT
	ZSdkWxiEa7xqOCNUoNpM2Fp0f8LYm+k10WA8vBiCP2eQWb/ugT2qI2oBfdX5sHTH
	O+24EZGo0KLtbbAHBn+1+JIM+VTiKsLINsoG6ov6akxgVLH5beQsJhAX/GaIQQsf
	/g8gRyTa41lcJwtnLOXUoB+H+diHMKR23HFif4B9FNPQmcFXf4wuyWfu5/NMUVsC
	9cNndw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvfqs8k0j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 12:16:36 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d753cb3174so18877793a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 05:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773404196; x=1774008996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NNUJ5IqCd3Oqw2HL5xxF4SqfTaOfSP4PBNslwEEXpYU=;
        b=jJ7RVREItRU7hV4o/O11BP8sRP9aELG8qgVn8JigFhBKCwcIX4/x/QuP+hCAO6B41p
         Hd7JXCJanJMogrCj/zzFSOKxQYaxjSHusf1SuMvg5baxsWhVtUwgr8HE8nx5SmiWe3+S
         B8il6TJScEkoJKpZUQKDbYYSpXwnuVKVPO1hU0yDbA1DAS6mbrydOaA+kLQiPA0kpcoM
         Xr0ZbacyuWbp8rauntCbo3+FhPJ19R1lV/S0xhdR2ImZ53bKtyBtaAEe/0+MMe7KDj4x
         jBXmo21/4Uitj0lE+4p0ttwQrXxeexxzUyQzFrtbhR8PtFVdV/fAfvYG3f5FG+MHq27Z
         nyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773404196; x=1774008996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNUJ5IqCd3Oqw2HL5xxF4SqfTaOfSP4PBNslwEEXpYU=;
        b=nfl+FPpAD7i/CKWzCccaHRXDGNFkiN94h6ICpUM96Jr9Q3K/UJxdihHrU7kxnnhngp
         75OyJge31/2Rw7xYHdbP5f6GjjQHin5J/9avfJh/zJhvOei/0KrAAkzYiD/dnaTc7fZw
         6W3ZXodqMoLZ8giF0zCDLJCESxRWqZkcwUTnXZlFDYYQAWIAzZ/I1wZ+sVhl6342RAro
         krzt0aOpBqKMNYCVmbBthy6u7S4CUi5zH/4ReJvVDJNYxRB7yuknAaYg0Ae669rMAwq0
         7+s23mAsXKjDmOFRZEAZiQIGWymfv6ca2jfVU/GXnWjrwA/DH4Fdz6flAkZuW3d8fVwN
         JoZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRxYW3QAiOHp9Ukm7Gls52NI3fFawGUHDkgAeNpgaaGG6P7hd0DDkZFLOW4FEKlz+cwo95a0myldqR0uJyS1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+cA1N1zPcfTO4OREZgh3z1d/wzyc9S9O8V0Ov4SYRbW4aCKe9
	IphU9lYF8VvZ02rb4EeqUaVUHv6+pZG8/ExPnfJcS9v4fEY4IqdqzosEZuzd8X2VGw2wEO6Eyzz
	7JqVmfCiCvHUl9UFcDE426Gf13osmbH/CiSh31LcSopPveXPTX+9Yv5TiHhDRWPqFtC/aKlM=
X-Gm-Gg: ATEYQzxh33Mhc/0J8FtLxdu7wTgs0Og+GGr+qDbZYvN2Q1oy7z5T4YlSq1GIzie/RZZ
	yf+9kYg6Hs1zZzPwhQySzSy0dRYQMyi7t0PNyLzbNAVgKRHZGJFJfy3OkY467dS7TRmlO1B0YC+
	4Mt9whLu2ePMEXLh1004586lqkjtjQvj5UmhC8VqEYfnoO3qu9cZCGPfXDeEu854mGa6Koe4kx4
	faM1hwfYJHCji/G7iqkvm9/5dJh/knHGZkrcPZl33VcGX76MH2Hq6C0TwHwYx+pV9T2X7p451i5
	EUxdfOQrkgQ+aR0mmyFyJ52ShG8LuImV27yICZGZSt5OvtrtjKMn7rEnoCYiX7HRYqqwIkw9QWG
	aQhFWDQo/vRPVIvfHp62xCEOl1gbhtoxNRMjgi5nbuxWe1tI=
X-Received: by 2002:a05:6830:710f:b0:7d7:57c4:365e with SMTP id 46e09a7af769-7d78251bf42mr2068131a34.18.1773404196337;
        Fri, 13 Mar 2026 05:16:36 -0700 (PDT)
X-Received: by 2002:a05:6830:710f:b0:7d7:57c4:365e with SMTP id 46e09a7af769-7d78251bf42mr2068106a34.18.1773404195995;
        Fri, 13 Mar 2026 05:16:35 -0700 (PDT)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ac8975csm6132745a34.8.2026.03.13.05.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 05:16:35 -0700 (PDT)
Message-ID: <61eea507-1cdc-45f2-b688-a4719e79107e@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 20:16:29 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btusb: Allow firmware re-download when
 version matches
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
References: <20260108074353.1027877-1-shuai.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20260108074353.1027877-1-shuai.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hIG7ExgyP-AszMrUxFI3he84ClQabvo8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NyBTYWx0ZWRfX+4CXGRDqNfL9
 DeUb76r0W6lqBsiiAz6eGx4ciXPMeOkoyMrasyBEb0zJHBdnpqBMhsxR2k1xMJuRApAR0SvV+Ii
 CNfMiwIhTAK11LKfX1LFsffZSF7mFjJ2VAyddCiGLtBtfvDi20eLF+RmNG2h6ZXpQ5Kq01BRwn+
 0QckLNXPoLssLsi1gL0DZN6gkjfwXlkxq1KPvvkE28h9Vzh/n7MfeQckIggShSnvtwRCsuL3uxd
 LkJVSfVbpR1da5BOy/XdTqeGKmdrQr2X1OguKgGGvKp95+vfBPSEVGkr8m7DMzi5a68ouoDdH0o
 Kr7HB7qv2A2PfifSzazTT4OE8gsKE6r4eH81JPwvYlBtYWFZpLr0270BMBGONrY6OWA9mZtnVZH
 SoZ/nZsBhr0SKswBxc/dXc3iY8V8Hbh4mJjRCaZwkQC4rZxIS02YEJMJt9ecwssjgnmNm0qT2Fc
 YijVOXaz8qQ86o79JZw==
X-Proofpoint-GUID: hIG7ExgyP-AszMrUxFI3he84ClQabvo8
X-Authority-Analysis: v=2.4 cv=GoNPO01C c=1 sm=1 tr=0 ts=69b40024 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=XLcW7MSiMK0kOx3OsRAA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130097

Hi reviewer,

On 1/8/2026 3:43 PM, Shuai Zhang wrote:
> Since USB can disconnect at any time, if it disconnects during
> the BT firmware download, the BT controller firmware version may still
> be updated even without completing the download.
>
> When USB reconnects, the BT host detects the same version as in the
> firmware file, which prevents the firmware from being downloaded again.
>
> Therefore, remove the equality check to ensure that after
> USB reconnection, the BT host can still download the firmware.
>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>   drivers/bluetooth/btusb.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 646de80c7..991064a25 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3503,7 +3503,10 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>   		    "firmware rome 0x%x build 0x%x",
>   		    rver_rom, rver_patch, ver_rom, ver_patch);
>   
> -	if (rver_rom != ver_rom || rver_patch <= ver_patch) {
> +	/* Allow rampatch if version is greater than or equal to firmware version.
> +	 * Equal versions are acceptable for re-flashing or recovery scenarios.
> +	 */
> +	if (rver_rom != ver_rom || rver_patch < ver_patch) {
>   		bt_dev_err(hdev, "rampatch file version did not match with firmware");
>   		err = -EINVAL;
>   		goto done;

If there are any updates, please let me know.

Thanks,
Shuai

