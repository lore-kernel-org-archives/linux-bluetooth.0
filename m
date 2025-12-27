Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0CE7080E
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Dec 2025 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766878473; cv=none; b=QiAGdxkbL4PWHQQvp9kxx53Uj/8Kk6p2pGzDJ4+yc82LaBdjjk6U3IDmqyNrO7Wrm/cIGYL96X2epPlv+ro1GsWl5x1iqYb5owVurW+KZshrEgM2gl3kQPTv842IwMuzJ31bXwOMWrsjp4apk1rEpFXD9MsuYXbInFatX00NVd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766878473; c=relaxed/simple;
	bh=QK7X48ClXeMWixPFUaz+6tBo1VfO4ELn3XaVOTID9t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdGBfqJhluI7krPFjp/MfuEFUQZQ9TaOOHE23tP8SVw5LYBWmID8hiDTuhSbmHMzowqQgGcu4H0E7xsmcGprR9zGn/Mwoq//83a6kr8dHoXS1U76WEjVc19vt08XZtYtV4zs/ctPc34q+fultYTcs/cNHX4qvxTSR4MoPNtdS1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NvSW/r6k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hy6LrM04; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NvSW/r6k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hy6LrM04"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BRMcU6P469911
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Dec 2025 23:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tgGRjxRiqIJZJSRl1gc2nIa4
	FvuinSm8dT0o+sSvyuM=; b=NvSW/r6k7y22G3VBAVMG6Kv54xdi92cIM/f/jthT
	vDwRBIavRsZa6G4kJuw/cp2oKsGJjhqN4Ob9kgKAgGU46TF3GL9aNNj2DJNjTgdr
	JN0lpmjKaQRnjyul/iAHMqRkN7B/zK9+gjmIOj2/YvmwUk/Ga7CaHvglBePh7Lim
	mDRDLpO2VPnSCzZwN7YByVpByW4lQiEjKgK343wZ40EwsoRu81WLOcEflUBA6FJD
	F8FFgtVMvoL/bKOe5mKo4X9vBM55JFi3zq0sdNZVuaMtUrDSC+613zwkpWSQskoy
	fK9ist0DlQuo53hpGePYWl4YsOIL6UZTRWGb6GF/DAg0xg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba4tnsf2r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Dec 2025 23:34:30 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88a316ddbacso204077226d6.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Dec 2025 15:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766878470; x=1767483270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgGRjxRiqIJZJSRl1gc2nIa4FvuinSm8dT0o+sSvyuM=;
        b=Hy6LrM04soE2L0nGd0QBS9d0yjKr5v0Si0ZvO55mEJPPCNfhXert38RuV17K26t0ac
         bUcE2oO0aR1XgB0Tt9VuC4y2CGm5SzY4A1MOjPuXe2xAa+PhdLSY5+5G+tkJu46MH5bM
         FQcqbypE/1LCvmaNQkzMHR8tTBcID5PYImKntktD4rM9Irtm/bobgrkC4U4IgUYrqyVH
         CU5EQS+Wp81OEjFnzbVKXzuzkV+Skkz2hGgdZ/OVkxaSnPM0hMUliky9XDUEaheAtc1a
         sxNeUIIrgosSlj2yYKvW7bi80msth6jQVROTE0Lk+UjI+89tGbb8pNME54JFUVLLSH2C
         lOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766878470; x=1767483270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgGRjxRiqIJZJSRl1gc2nIa4FvuinSm8dT0o+sSvyuM=;
        b=m0M0yt9jMT+XUjGxvNcqcv8NOgOmyIoraHaX/OhttZzJPV+NwLl5BoI//q/7886Sm/
         KnMj/BZk0XBSfAZgt5vaO/sJ76Cn1igbKEmfGB64YoDFL2pFbK/X3VEQ3yphYF5jCOXK
         7RfUPLiPAZMq/2oR1k2qGzoBrq1B+jqcxBxzjF2JHRqpNheqbCBpYu2ZHHjgNyufOE68
         aeyn++kTicaUglhmKnlcvwpCcE07rTkU7ZravwZCMKZY72jQYFhcDsAin4voSq/Py9uT
         Rzfig4qSn/1WEzpYNyC2mkUi3sqfEbyFHNVKSQmSjBVfojQ/DlhXH8gFwG3Jb/SjsnWP
         wuqg==
X-Forwarded-Encrypted: i=1; AJvYcCWg80iRG6lPaFxijbimXF78f5/xtHtKKpBozplOhDJjwUubj8tJH+VY/UCVenfV5Ii+u8vXsT1vF/boGFGSUgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3bj+coONLPYm0SL2mhqdACSGQUtLTM/LdFYy/XEoY1QKKGCv+
	6PjeO4luGpFK6t3QCsJjfwEnXvp9LpHMA4eqSlYbMMuXwxVIgFjJQp1diXWuVLiO1bxPJiV0dSX
	8OtzFSyRdzs6vDPIt8NgGdYOFBk8eeUw+ZRi0HXbaqKiPpAvU+vtCxwbssQ+PXTVU2P8lNH0=
X-Gm-Gg: AY/fxX54s1S8z5VEOuuRRYEzBWK2ltcyBuHvCGt2zlWL1E+rnDpB6kpzXiEfSqy9UGy
	wtdQpE8oeUxYZAANT7CiokUSvdYvPdpEfrufOjHvF3OutTvZjxGlUoIoHlG09StPYXdgBw8OxwH
	Z8iZ/FaGD6Acoq2rBCT591aniPtFJPpxhC5yYTrE+O2UK76gunUhJiHWnLV/06tWrTBAkAm3t8R
	UFiICCiztBZVLwE4YCa6+kZ0Z8b37yG1kJLiKR/xH7bBz4qhgb75lN8mv2WtNn5HLJRXnfYklFH
	jgbzMv4iyrW8xuoXwBkWVrwbbhbwfKuXxReEJcFQVZu6W0j3SvPJOBO0Gk1hJMWVYdX0EB+bNpS
	wKrVnD5F0UnsfVdtgHYcgohhEwabIvCqyLZr2day4sL0ysWXcBvOLygmEEfm0Cuh39wu+SQjhZF
	UuWy+/ZoL25vERJD+9qBB5YXk=
X-Received: by 2002:a05:6214:20a2:b0:880:5279:98eb with SMTP id 6a1803df08f44-88d86290d80mr417407086d6.44.1766878470224;
        Sat, 27 Dec 2025 15:34:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFr7U6sbXnsmgzXGcvUBmTKWyN07bHNhKftYI+uQ8UCc6xdTNfiJGHcQQgcy/mbTxs1h3EfUg==
X-Received: by 2002:a05:6214:20a2:b0:880:5279:98eb with SMTP id 6a1803df08f44-88d86290d80mr417406916d6.44.1766878469748;
        Sat, 27 Dec 2025 15:34:29 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-381226809d5sm66091441fa.45.2025.12.27.15.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 15:34:27 -0800 (PST)
Date: Sun, 28 Dec 2025 01:34:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v4 1/1] Bluetooth: btqca: Add WCN6855 firmware priority
 selection feature
Message-ID: <7kwwrrrjcpawhelmwnz5mebczre73lubjgl23sa2pc2skrlm4b@p3urdzakyhbv>
References: <20251226075621.3223336-1-shuai.zhang@oss.qualcomm.com>
 <20251226075621.3223336-2-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226075621.3223336-2-shuai.zhang@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=G+YR0tk5 c=1 sm=1 tr=0 ts=69506d06 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=WMkWF6dcPmnm6l8C4LcA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: zQ-wC7_tAklBsEMDGgAkq6zoptFMNDK7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI3MDIyNCBTYWx0ZWRfX2EsXB01S1Qea
 p/Tz5Yu0QwbpXuZN2ED3uBsjlZHylubj5zVa8NpgL8PV8nh3PdUgNjCj5E2coRqq3uVjcSZ5OlR
 QrzwzoNknnS7XC3YTINKh9nm8AKTNMzXV1BIhbGknK3bjVfdcnoOfX3Gki5SxlYTY+dCxiBr6zO
 jTLN26vpt8gWsW6VaJ8PzQBcKYqYf5/vp9aLH3T2MrtpW5E7ZK4UBZVjkBxUQaJ1D7lR8Y0Jszw
 yz6L08iNy9JPyIymyhV3Tz6brkxlcvXo80/y+EPNPIrV5woHxBzj1dX+yttlXzk3/1J2xavkvmz
 +XSgL3ndi0xwS4zAq2tPzntFOTHDVoU+ztBJPdBx7CMk0/nuagUrjg/YGMPsNnoLyurWXHLEycE
 8BrR3omZXfkZHZ0k0OgCghaNLdLN4fjVlKlyVpm8H9L32HfBkSPxC7vrdy7lTtPCEC9X0NAq4Z9
 OZC4Eh1EpwR8ADrJMnQ==
X-Proofpoint-ORIG-GUID: zQ-wC7_tAklBsEMDGgAkq6zoptFMNDK7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-27_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512270224

On Fri, Dec 26, 2025 at 03:56:21PM +0800, Shuai Zhang wrote:
> Historically, WCN685x and QCA2066 shared the same firmware files.
> Now, changes are planned for the firmware that will make it incompatible
> with QCA2066, so a new firmware name is required for WCN685x.
> 
> To code uniformity, move WCN7850 workaround to the caller.
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
>  drivers/bluetooth/btqca.c | 62 +++++++++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 7c958d606..81b0208cf 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -581,28 +581,11 @@ static int qca_download_firmware(struct hci_dev *hdev,
>  
>  	ret = request_firmware(&fw, config->fwname, &hdev->dev);
>  	if (ret) {
> -		/* For WCN6750, if mbn file is not present then check for
> -		 * tlv file.
> -		 */
> -		if (soc_type == QCA_WCN6750 && config->type == ELF_TYPE_PATCH) {
> -			bt_dev_dbg(hdev, "QCA Failed to request file: %s (%d)",
> -				   config->fwname, ret);
> -			config->type = TLV_TYPE_PATCH;
> -			snprintf(config->fwname, sizeof(config->fwname),
> -				 "qca/msbtfw%02x.tlv", rom_ver);
> -			bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
> -			ret = request_firmware(&fw, config->fwname, &hdev->dev);
> -			if (ret) {
> -				bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
> -					   config->fwname, ret);
> -				return ret;
> -			}
> -		}

Separate commit, please. It's not related to WCN685x firmware name
change.

>  		/* If the board-specific file is missing, try loading the default
>  		 * one, unless that was attempted already.
>  		 */
> -		else if (config->type == TLV_TYPE_NVM &&
> -			 qca_get_alt_nvm_file(config->fwname, sizeof(config->fwname))) {
> +		if (config->type == TLV_TYPE_NVM &&
> +		    qca_get_alt_nvm_file(config->fwname, sizeof(config->fwname))) {
>  			bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
>  			ret = request_firmware(&fw, config->fwname, &hdev->dev);
>  			if (ret) {
> @@ -847,8 +830,12 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  				 "qca/msbtfw%02x.mbn", rom_ver);
>  			break;
>  		case QCA_WCN6855:
> +			/* Due to historical reasons, WCN685x chip has been using firmware
> +			 * without the "wcn" prefix. The mapping between the chip and its
> +			 * corresponding firmware has now been corrected.
> +			 */
>  			snprintf(config.fwname, sizeof(config.fwname),
> -				 "qca/hpbtfw%02x.tlv", rom_ver);
> +				 "qca/wcnhpbtfw%02x.tlv", rom_ver);
>  			break;
>  		case QCA_WCN7850:
>  			snprintf(config.fwname, sizeof(config.fwname),
> @@ -862,8 +849,26 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  
>  	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>  	if (err < 0) {
> -		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
> -		return err;
> +		/* For WCN6750, if mbn file is not present then check for tlv file.*/
> +		if (soc_type == QCA_WCN6750 && config.type == ELF_TYPE_PATCH) {

If you scroll up, you will see that for WCN6750 at this point type
always is ELF_TYPE_PATCH, so the second part of the condition is
useless.

> +			bt_dev_dbg(hdev, "QCA Failed to request file: %s (%d)",
> +				   config.fwname, err);
> +			config.type = TLV_TYPE_PATCH;
> +			snprintf(config.fwname, sizeof(config.fwname),
> +				 "qca/msbtfw%02x.tlv", rom_ver);
> +			bt_dev_info(hdev, "QCA Downloading %s", config.fwname);
> +			err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> +		} else if (!rampatch_name && soc_type == QCA_WCN6855) {
> +			snprintf(config.fwname, sizeof(config.fwname),
> +				 "qca/hpbtfw%02x.tlv", rom_ver);
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
>  	/* Give the controller some time to get ready to receive the NVM */
> @@ -923,7 +928,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		case QCA_WCN6855:
>  			qca_read_fw_board_id(hdev, &boardid);
>  			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> -						  "hpnv", soc_type, ver, rom_ver, boardid);
> +						  "wcnhpnv", soc_type, ver, rom_ver, boardid);
>  			break;
>  		case QCA_WCN7850:
>  			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> @@ -937,8 +942,15 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  
>  	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>  	if (err < 0) {
> -		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
> -		return err;
> +		if (!firmware_name && err < 0 && soc_type == QCA_WCN6855) {
> +			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> +						  "hpnv", soc_type, ver, rom_ver, boardid);
> +			err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> +			if (err < 0) {
> +				bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
> +				return err;
> +			}
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
