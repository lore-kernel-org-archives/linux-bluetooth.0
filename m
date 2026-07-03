Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C752BDC05
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783121559; cv=none; b=tBkDjfp1FJYPt1xzJwGQp+YdP5PLL1YeOsfniT+eo5zdrMU/YGk4x6qjJ+bNC0jnsGQc+QAP1RtzxJ6H4UgUMBZGwKj+DnXjZ0zmV+d3GHR0mcRUluDf9J+w2eofbRcXDjsv4mPUP+Ki+InVTSiecm279nBn4PcuCTTpo0PoCvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783121559; c=relaxed/simple;
	bh=wuESj9b85l1vW8rE4jIgNP5KS9UrLnHyyKAbSfhB5js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONSW1zPU8aY/FyhPzjgCPLxH7VkZ/ccCbsbPzeIekMNkt1t6D2gh3dTI0XbrWEK9z4hKb8e9lpJKE0QCgjKwe8ezQdsnuA+C8jXc6C8T7J0QVeEj234XsqQx2nd69MYuM1DFQXydWCfDMY/pqdbhZi5mZve5V2S1dRmRhK6F6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ByB6X4sj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BKyGoFNg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ByB6X4sj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BKyGoFNg"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663KQIWb1022297
	for <linux-bluetooth@vger.kernel.org>; Fri, 3 Jul 2026 23:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rCUR0wz38uCbldyWNaolcJvt
	e3Z+vL8gly+V3QJ2IU0=; b=ByB6X4sj1Aby7ZzUMNL/uU4Si6hzDCv/8oNQU/Yx
	WTYmdMdZqzPL2s8EdHrfnar1dNAUCGNlGHhG2vNSyHSnaNSxoNgQhQ05HU9Kifc2
	MQwi3MKD+6WVhX1yLTsXBLuI6D6cKtgGEJQF7eX26xgpmeDGwK//0hgrOxOZUBAA
	lmSIcaTUjUnJZGsunoBzM/XDf9Pa+ojs7mIIOql7Hl6uUkghsagqsDq+i1HU2Pse
	4sUREjrslbD6eebEXiw9/NzWaq382vJlAKP5QkM4UwFAw+8LBPdpl9/qNVP0xp6P
	3SzeaBV7CUzDd/KqpaLHdi3DArwFShTe14B2+HaXGwE25A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u3323m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 23:32:37 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8f0f45415cfso11714266d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 16:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783121556; x=1783726356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rCUR0wz38uCbldyWNaolcJvte3Z+vL8gly+V3QJ2IU0=;
        b=BKyGoFNggRYlfNeH/15yKRSWXD/m4saLNLPh5orcws2itq/C5FIU6ICG2rvhyJmJfb
         xjLAVEiQRmNW3wmHg6K1c2SuOqmQ8l66mvjXdn1dtbc1MJ3PfmMyFu7O9OVw5TZVj9SU
         j+s16UhfvTW/kjb37ih9+jANDje2uWLk6ynKgMoYXepQcnY7eM1zzrUTBkbxHbWDgmX2
         v2koLVX7Wv0eRAg6onhe0qtrztmXrq3eZVSPHpfPK111GweuyMS/R/mdfZGKWTfO1jT5
         sz44HJHPPEkMoAcgcmxXWvfvmxDhNOtFmef7fG6WhBxA3HXLilogIJ+Vhsw7bXjbvlw0
         BtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783121556; x=1783726356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCUR0wz38uCbldyWNaolcJvte3Z+vL8gly+V3QJ2IU0=;
        b=np1mux9JaZYyH77NuhZAZIvKrPVwGBD+HKFx2oVwaoaKAwlAtGCfjVU3mhA3hYc8SB
         qzAXrYZaUnL0J1PrEolFQmYKtwcstHFuKRz4i9RSwPT5mRsL/RcvPSy6uhttiAcoT8XR
         0NjefxGrTXarz9gzjj+HTyb7YHq6qW4iChtZOEpZOQTpYFqC0NpWi4EXJwkwTZWjDfiw
         qHTQwuRgskOWvPWyjwPB0n4aUKbmdey7BvymxbotsIzc1Gejyxtxg2N1RT/Abzbgqea2
         re4BbWPjcbee4hWTTX4Vyo/vMijjnNYABIbZxaGRY6fbcST/tbVEuRMLTbrStepwoJsi
         sLqg==
X-Forwarded-Encrypted: i=1; AHgh+RqG18Zp8UouzxhzcELcGIQTTjbPloJfPbwm8aH8q8A3SlP0pH5A8QQ0Lai1uQrhwej/d9R9ny1hlDzztuxHkJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYtv/pFEOQ2N1YJLi7Hrfi9c0fSi9Eo5tQfs84KOY1MYJcbeHH
	amzI8wCAOiZZLSoOcW7NVVEr4IX/QfLcMCqqegKdIJ+LcA9XSGkc83/q5r5U+M+pZm5wDJ4C39a
	QwF4qTEQjW0V5TsZOwbzsV0Sa3k7PAKKPZNILCF42YQbUkPlL+JoyPzxFtBBf3ntI1PMro+0=
X-Gm-Gg: AfdE7cnLzRVd3KsT/ctrZemFgcqFIDqTxsAd7HFBQ3dIxCXy8CMJJ/GlarIJ+unkDwY
	1hh9yywukQT93wGNFmfFweTpFM9lWwJSRsoAxsZnAyZeP5+rB/r5CbwE8gIVfadPbCPPCxVsxoI
	DfUb2RPiVt5Sl8VGQLU4OQrEGCObOhfD10RXcJihoDLFQf6Xpj7REQtvP402cDIk9mAnXvBE8vm
	+/K4m/nOtpbvnQaKJ6/ESKXYDZORdV9ptug0IyhJVpq69DUgOToMwdkedeJi+cDWZZuWILb3qm5
	0HeC44rzDMf/EFqWzRjYAxWlKqU6NTxpG3GnQruKHN0CrlDZi17euhi4bhXNaJu75FzaymK5vQr
	FqiZteKCCCezs4reo9DkIXdFE+uCT5oWjkI7ItJPSrHKqWaKutl1ThjXeniD+nh65cw7UouYPRv
	ewdmsVhpEEpQ/HvuibuIt6Mbtj
X-Received: by 2002:a05:6214:3d9e:b0:8e9:f62b:8f90 with SMTP id 6a1803df08f44-8f74ccaf291mr18725926d6.54.1783121556568;
        Fri, 03 Jul 2026 16:32:36 -0700 (PDT)
X-Received: by 2002:a05:6214:3d9e:b0:8e9:f62b:8f90 with SMTP id 6a1803df08f44-8f74ccaf291mr18725536d6.54.1783121556087;
        Fri, 03 Jul 2026 16:32:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13c3be4sm839833e87.73.2026.07.03.16.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 16:32:33 -0700 (PDT)
Date: Sat, 4 Jul 2026 02:32:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: george.moussalem@outlook.com
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/6] Bluetooth: btqca: Add IPQ5018 support
Message-ID: <hb5njj6m6dsc5ply5mfvagbut45uw6v6pomsrah4g6wuarp6lt@vaarxn4bwnwl>
References: <20260703-ipq5018-bluetooth-v3-0-62da72818ab3@outlook.com>
 <20260703-ipq5018-bluetooth-v3-2-62da72818ab3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-ipq5018-bluetooth-v3-2-62da72818ab3@outlook.com>
X-Proofpoint-GUID: InAGvas2toJhdJxjftUNG69MTI1EVkoE
X-Proofpoint-ORIG-GUID: InAGvas2toJhdJxjftUNG69MTI1EVkoE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIzNyBTYWx0ZWRfXzHcTCoCXwwax
 TTyN4SMoV7DEbmF9Z0sZBGWylNHomeOoGXb6frrhX/G1iiY8smOUjf+kxIfZM8H4RNR36/Ehnlp
 YqSY8qFe88CGO4eP6ZY/IuAxXWyNdTo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIzNyBTYWx0ZWRfX00u1Et5p8CR/
 Q8/xU70WnE+S+dKyweZwF2cG/NZOtom7qdZEzHtdIVnhYLxrWcOfrWc2QMKi48ca4PXdBD9vf2P
 uRbYtQvCQ+IOVE/GeuITaRLdGfd0YfvFQVmD+06mdk7CAGu9ylRvGbtK66mrZVOakQOWPvShKER
 91LKFcELkh6C402CqUikIiJ1H+2iBncd4wmmo24ULX8weCP+w6TaR5wBSBnEt1cXXZhLK3BbpaR
 f+wRi64aWcYe0NID/zKRpE6w0AVtgsZXbZ33G0exmUHpWo0iy1rjuM6mo/Yn8CQBjfd/1IlZI3u
 MFIJfvlciEBeDbT5YRveOFga0Uueqb6bhtI/b4Dvh+OCBrdIkSj+MNgCf2YA59YBJtREnRg770M
 BzPkbxtdRwmrXbHxaIIYtoEG/HjSC+R7eUC1aMhpRmelk9PU479fRfafmqAzBZNIXUGFPaGFeSt
 qdFKpWQkrCrK+D8ic1Q==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a484695 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=UqCG9HQmAAAA:8
 a=EUspDBNiAAAA:8 a=o9JC6ioeNWgGuw0WDxEA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030237

On Fri, Jul 03, 2026 at 09:01:50AM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Add the IPQ5018 SoC type and support for loading its firmware.
> 
> The firmware tested has been taken from GPL sources of various router
> boards. Firmware files needed are:
> - qca/bt_fw_patch.mbn
> - qca/mpnv10.bin
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  drivers/bluetooth/btqca.c | 16 ++++++++++++++++
>  drivers/bluetooth/btqca.h |  3 +++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 04ebe290bc78..e136e91976cf 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -380,6 +380,9 @@ static int qca_tlv_check_data(struct hci_dev *hdev,
>  		break;
>  
>  	case TLV_TYPE_NVM:
> +		if (soc_type == QCA_IPQ5018)
> +			break;
> +
>  		if (fw_size < sizeof(struct tlv_type_hdr))
>  			return -EINVAL;
>  
> @@ -794,6 +797,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	else
>  		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
>  
> +	if (soc_type == QCA_IPQ5018)
> +		goto download_nvm;
> +
>  	if (soc_type == QCA_WCN6750)
>  		qca_send_patch_config_cmd(hdev);
>  
> @@ -881,6 +887,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850)
>  		qca_read_fw_board_id(hdev, &boardid);
>  
> +download_nvm:
>  	/* Download NVM configuration */
>  	config.type = TLV_TYPE_NVM;
>  	if (firmware_name) {
> @@ -939,6 +946,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
>  				 "hmtnv", soc_type, ver, rom_ver, boardid);
>  			break;
> +		case QCA_IPQ5018:
> +			snprintf(config.fwname, sizeof(config.fwname),
> +				 "qca/mpnv%02x.bin", rom_ver);
> +			break;

Please keep the switch-cases sorted.

>  		default:
>  			snprintf(config.fwname, sizeof(config.fwname),
>  				 "qca/nvm_%08x.bin", soc_ver);
> @@ -958,6 +969,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		return err;
>  	}
>  
> +	if (soc_type == QCA_IPQ5018)
> +		msleep(NVM_READY_DELAY_MS);
> +
>  	switch (soc_type) {
>  	case QCA_QCA2066:
>  	case QCA_QCA6390:
> @@ -965,6 +979,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_IPQ5018:

Sorted too.

>  		err = qca_disable_soc_logging(hdev);
>  		if (err < 0)
>  			return err;
> @@ -1001,6 +1016,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +	case QCA_IPQ5018:

Sorted too.

>  		/* get fw build info */
>  		err = qca_read_fw_build_info(hdev);
>  		if (err < 0)
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 8f3c1b1c77b3..343cd62d1137 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -54,6 +54,8 @@
>  #define QCA_HSP_GF_SOC_ID		0x1200
>  #define QCA_HSP_GF_SOC_MASK		0x0000ff00
>  
> +#define NVM_READY_DELAY_MS		1500
> +
>  enum qca_baudrate {
>  	QCA_BAUDRATE_115200	= 0,
>  	QCA_BAUDRATE_57600,
> @@ -158,6 +160,7 @@ enum qca_btsoc_type {
>  	QCA_WCN6750,
>  	QCA_WCN6855,
>  	QCA_WCN7850,
> +	QCA_IPQ5018,

Sorted too.

>  };
>  
>  #if IS_ENABLED(CONFIG_BT_QCA)
> 
> -- 
> 2.53.0
> 
> 

-- 
With best wishes
Dmitry
