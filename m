Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC9B29D29B
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201812; cv=none; b=uBiOTcRS6bmD5BpLvbTpzcALaUc8wQ80T72jzFTRLCv3jrlxiO7nDzUDxPkRDJYqQPiDPuTHlB54mlW3sWfnQagVttnBAceislP9/pO7oZ+LCUTb15ZBB6H1bU1HBl9QfKmO+CI5R9sl6FCvr7XOJbs2ZwRuks6IoyAwv0VQwiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201812; c=relaxed/simple;
	bh=L1dc92einE9XUo2czagksPV5EG/oQLQnQ/ZhdF/MkOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9w1gFjyZH3tGYNgY7wY1dBWK6mE8hseFj0Fud4i23wE8iTZaRXZhhRogLsSj4UtBcXkgMOHN99bwaAkbfaAilDCoFXP49OI0ff0F7VpoD/PksAITVMBKpgY+NlVmY2drygqe+SUUwqa5xvSPb3/iYFQCfoWai5Z963v+jjTGsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AKl5A0tC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h0CGeqvd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AKl5A0tC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h0CGeqvd"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BVGFOUc3496690
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 17:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RqyAdcZxMRhdoDnUEFGoqY4C
	1m6Fk1zKRYQmRrMBsgw=; b=AKl5A0tCkCngw4hqZBCbc2QbqtT2QYHFEC8ND+w+
	LfFDiNB0aeU6bQY8y6rqdrNgLQYWT+q87uZCM8ug6xfP62ZTcgMUKfBD2CU2XZHS
	q/Rph5q7LRJPnlGRXgtGGrH3qUc4mSeNZoY6TiwOQDb6O3HPC3/OoBOyHzlQ6UWV
	TfWVLmcUmVxSCFA8vW746h3Q4LxhUIpUr2PXL0do7QT3Bzx9UaQpYuYXR2GaNCSu
	P56tkJCHYkhmR+2/yeeJGmL4eUstcj4XzmsnDfofV/4GPcTJn+P4UNIBoac7zghJ
	UFzA8Tew2T+Z1hqGePu9FJYLl1IPNaii8ljxYbB/fbchcQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd76n83e2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 17:23:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f4a92bf359so250554551cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 09:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767201810; x=1767806610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RqyAdcZxMRhdoDnUEFGoqY4C1m6Fk1zKRYQmRrMBsgw=;
        b=h0CGeqvdicEo3oPxFfrnVXMPUU+BVshg0xswTWI5YJaSpxI3d3Z/izw+qJ9VxwuD5O
         7VqCzYjTS9IrUUzRC/tXX3Zb6lJXpMPO/f2UVgWt7fx5IxdNc8DN78FUFgJFBdguQcYB
         iXp1JqP8pNYxaPCgejMicl11bEyKk1owPCPYEXQaEuqvpu0Hv+GHZjgJxTDhQpYHsSDb
         r3CtQAkAtNJQfODDdUWTZjVhQ80PrgUnkHNgoP8r0IxmZENid2MOgU3zjM68nMNg5Wet
         qTxxKUALRuXXnCR94+Of+nEK8/faLF18QCBG6y5VunCKl3KSFkdrstaM9fd/QYoyj5ON
         EQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767201810; x=1767806610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqyAdcZxMRhdoDnUEFGoqY4C1m6Fk1zKRYQmRrMBsgw=;
        b=qX3Skdpm8hVTqEo+jk9Ab3yvEBDSRifkrYeGG5mD5p7r1cVl3eBZPVI793Ee4cSZ7P
         pdf1lKV3n0e434rrXdxaEiD8rZaRGmEIflDNA7GbMxLXspzw8ww+dxtINJf18rx+D49w
         CtS9h4YksjEQ9BKjbTejQ1zxdhGXR216XApgFWdF/CkytzENo1E5zDNwTqeWB/eQrPyf
         VZ1vDOx6lgHcEiT7ADng2XvLuL8R6bWGfxlf4VO+S05eS2LoHliVNGQrxu/dvDaXJScO
         2LehmotkXCvVr/+fZaOtrHCCxg7+HwcJVB5FTwn4WBP6kzMkH5dFdMjU9Q9fAYZNZDTP
         spoA==
X-Forwarded-Encrypted: i=1; AJvYcCXKToGNgJQ+9OyFBVGBgoQYav6W7AEjPelu0X/4chlQPeTfTbJE3/vpbk04935MkSNm/bTXEv74YLZRIy3gLVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyebsMa5t+OZITOytD7FuZPLdWAlrmODZ33YQ8agLhN0gc4ZSEm
	+vyNWgTSel9MfK41dbwAaXU8LjShrSM0v2QsQ9AEMmmD1DkQyX5bCmeIGg2i4uNiS7bMLUVveBO
	YpuXw+n0r3yz36dnDfLFCFB1pFk79MWiVc5+8CH7Vkw+g8ICMbaLKJDCFosn8e8YQK1dxoB8=
X-Gm-Gg: AY/fxX4fMnb8ehuUeU6D1gzvJX5NSZ1Kn/+xTwsZBxUI4kHUo3T5DG6hCDu6KsC/Nqp
	vihZPuhD7+HGzMOuJ+6gMr2g7L6UEpY8lYcpUyDOy9nM3PeVCcDJ+yiyl8Cw8zhoWjVjjP4K9rz
	JNgSkbsqb/y8EsoNya6lCORTSc0PLrcJGWBKr2NV7xTTVeakzp/fd8PozU2MgNwvHYymuflC1bq
	TakwY1kRIcvGFLNWj5oAJylc0G7Ew6f21NnoAWJnBD9BLg/uTBuyUgb1ehvP6UUsVYgqLMn3woy
	zpT3XrYszmnwhFwgHmF+clb205v+8EMW4XwAOSRJWCOx6wUWMUopxCiipTxutXGVO+pEJ2ABqOQ
	+G/pdR6xMSDSP8R+33kribCVvRXIZNFxiipDEQphoVKXoRgxlAQudhG27+QYxBvH/cZBsUkd0Fy
	OUgb21/GMPWN/x+qpVqmn/3oI=
X-Received: by 2002:a05:622a:a11:b0:4ee:219e:e74 with SMTP id d75a77b69052e-4f4abde4c12mr575557101cf.77.1767201809663;
        Wed, 31 Dec 2025 09:23:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNiuv35Naad2vjeZ0xw6PScV7Af9vnkaKsc5ltn48Bz1y26EAB6wcfXdR408bMToyGoHqnPA==
X-Received: by 2002:a05:622a:a11:b0:4ee:219e:e74 with SMTP id d75a77b69052e-4f4abde4c12mr575556691cf.77.1767201809253;
        Wed, 31 Dec 2025 09:23:29 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18618d6fsm11100815e87.65.2025.12.31.09.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:23:28 -0800 (PST)
Date: Wed, 31 Dec 2025 19:23:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v5 2/2] Bluetooth: btqca: Add WCN6855 firmware priority
 selection feature
Message-ID: <wxfba3ldef52mwuhthyh76qd3ppmmhmhuzhck3yziju2iil2vy@6elo3tzkjdvq>
References: <20251231075817.2611848-1-shuai.zhang@oss.qualcomm.com>
 <20251231075817.2611848-3-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231075817.2611848-3-shuai.zhang@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDE1MiBTYWx0ZWRfXxcpsZmkeG2HH
 2r3cLFeFhLd1g6KrFcr+S7y4uroAPkmjyS7sBRN6osdT3y2rtI/UKHBS2kZB+dUIiHqPi5lnOsW
 iSDzg1CA3UTyALM7HHJqxrhA5P30f52MT4sHkgVgRy64Sgxni1caN7lK6qbsHT3y6dyTeoDkpNx
 vv6sXKTytMcPJQGs5ARhXMx1oXEazA7Bi5mh3yZqR+070UGCs+5Jl5S7tJbmZYs02+c6zxoK0rM
 dxXwGHTNTzguHxx0eanktR2PMkGHoYTfFwZayNaOIQI5U8D91wshzVGVB34cPummWK/iSNoRZqU
 XzPi4h34yms1n+KnLBpLl9b+s+wM2Sc0Jx9YkXIYsIHDcBoQzc7/iiKD2wPfCjJ1txdmovOBi1U
 S8KjJwmBagSg2kF+oQ+S20Uaffplc4vjqZIYgq6Mv6TFtpq1b5s3rjhITEN5R6xlug1zHdA8r5X
 HzNs0gpJ19O+XqBGIhA==
X-Proofpoint-ORIG-GUID: oI-1as3zp3Pawgp7YmzafyYFMGuV0s-i
X-Authority-Analysis: v=2.4 cv=TdmbdBQh c=1 sm=1 tr=0 ts=69555c12 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=fHN9rbdO2-7uurTg0k4A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: oI-1as3zp3Pawgp7YmzafyYFMGuV0s-i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512310152

On Wed, Dec 31, 2025 at 03:58:17PM +0800, Shuai Zhang wrote:
> Historically, WCN685x and QCA2066 shared the same firmware files.
> Now, changes are planned for the firmware that will make it incompatible
> with QCA2066, so a new firmware name is required for WCN685x.
> 
> Test Steps:
>  - Boot device
>  - Check the BTFW loading status via dmesg
> 
> Sanity pass and Test Log:
> QCA Downloading qca/wcnhpbftfw21.tlv
> Direct firmware load for qca/wcnhpbftfw21.tlv failed with error -2
> QCA Downloading qca/hpbftfw21.tlv
> 
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> @@ -936,8 +944,17 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  
>  	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>  	if (err < 0) {
> -		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
> -		return err;
> +		if (!firmware_name && soc_type == QCA_WCN6855) {

Same comment as for the first patch: move this one level up,
incorporating err < 0 check.

> +			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> +						  "hpnv", soc_type, ver, rom_ver, boardid);
> +			err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> +		}
> +
> +		if (err) {
> +			bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
> +				   config.fwname, err);
> +			return err;
> +		}
>  	}
>  
>  	switch (soc_type) {
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
