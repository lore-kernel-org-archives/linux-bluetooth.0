Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867CB3845BC
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981749; cv=none; b=Q2wFYjUijIbcy5Ift0VpDNECZhuTp0TdoSV1lisKD/zpdZXGOdOdguVOCwBQ76SRJAP95EYE9Mi/qBlvoEf+iRzJ1I2rjtkY6njfCZXtZk7LfD1rIvPtZve+fHieuPyJLJUaw4X3DYijP1678EwbkiYmWZYoOWfNiuGGhU3ovV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981749; c=relaxed/simple;
	bh=ERok2CW7sypEcB+fTJ+rHSXjCVjmsMgp5MkJa7SgXlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwgaXd9cu+1m1ZdGPGiRverv7xkJsiFIIEvJSNjvVa87MZS1j/n5u2dOhODBSSD37z71P1zEAi/e11/ETlWMvXkHe5VuHvcttEuJtnYMJARXQWRm8wdv+H36iJeIodBKcsPP4UhE3dRM8OllyHulkPMONy03VhXMI1m7WTpUC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GNkJswRu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ryugn08E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GNkJswRu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ryugn08E"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCKuav2764479
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 14:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GWnXXLZPwPcjYmJ6eTq9/Vxo
	0TPoq/BX97qxf52v9Gc=; b=GNkJswRuSJO8YOrhcZH5ViQhmmPlUTx1wZdL2JzO
	2zHRAgvQoAyrOWU/4pfCWyvZVw9mCbtmoOZ9HbSLh+Vp268RaIF2LPiu6W+slfHl
	XShiE1MaeTzwzXGpWbb1bt+5rLSrMvceqabLXdIthQljzNMZi4QAgM1TGA0xS3/4
	CzkZiRZc4nrA7f+gulEnKefpryeM1eWkN5joIOkI7yAwMXGKkM+5YbhLevEll3Ck
	uZ7BRCZ13KmcdIVHWBmauJFa3RBt+gYSMV2HDnNIYORfi6bOBtlLL2ZHPAYaNr4O
	gaEzUbqrhrpkjWWewtV+NcUuS8iTZ1X614Ol3CEHsy2sww==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3fefjr54-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 14:29:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed782d4c7dso98179591cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 06:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765981745; x=1766586545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWnXXLZPwPcjYmJ6eTq9/Vxo0TPoq/BX97qxf52v9Gc=;
        b=Ryugn08EElPS1mBSbr0s99v3hLt0QO8BNGAW88rF9eS3fwBAUqgaCLb77fWsu5dgKC
         efziWPTpz4/V0SlsyWjAhXAgBtGohh9UCWj/6Oof9QnHVWSdYaU9ELNfIuXJKJs3vAXv
         HQOUX6tXMG8HkOOCxR+ihq0OiMS31dbig3sbklJ7hcwz0Wfolp+0cidglQfT0nort6ce
         6o23Bf0b0BHlSL8teYA6Ba3ZDG0/H7hMBzdZqWwJgJnIXMJhyBp5caokYujTogJUocIA
         WKt3bp0UIRq4OXudcD2x3lvjq71iEpHkFlQXhT0tlS8E9tpYiZaAb++q/ZqFRIhYI20Y
         JZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981745; x=1766586545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWnXXLZPwPcjYmJ6eTq9/Vxo0TPoq/BX97qxf52v9Gc=;
        b=ny3vgKu7BAawF7kudAy7Q0fjKVQbDTUOF8GjxBkJVrkIAIrk1U6cf7vvW0xy2YBFJa
         oGEbyshonPpBYCBeDqtxOEybFMiC9p980sARhunYgO++mLjRZdOlzgox3rYjgkZ/pYL2
         J7Q15oM65B5usy9FCx5XE1Qp8PFQPFA0boWAbSE3zRbSwkbjWf1mvlsZ1bUdYsQTOlVz
         3UCIifQfjRNdbl8YMTntuWU16gbIBAiIPWT8RU5nvlD0lFELmM4RAvQiL6LR/hc6e9f+
         BFW2AwAqzrQQWl2spMoh8GVtlcwX7HXZoIBQmf+rn1aGVQkcCKaBJcMEyZgczcvO5MR4
         9B2w==
X-Forwarded-Encrypted: i=1; AJvYcCWRl+EkmCFnI/uYHpY1v4ZFObMxgXJi/54uKVWxRS4cLanNRfcuLMRsag9OGFPl3ikUpdFZynZ38ocq2LDqlyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9UjTcbU8T9VT5y2HW6z486ri+83FuX7zt4nPoukACnPqfGR58
	u4lRftnaGcwzJyL4bjexxVaXKN5o6Wx38OYPRD3zRqB9+eHdUZ8pfRzykQlIMci2PCsmtNvJ/vd
	RolscNwypsGYAQ4tcPVkXPJa4QumcHoPjiIBrURaN5/hASzaho5IXPfrPHyLsPSG+Om7Q+uo=
X-Gm-Gg: AY/fxX4loEYVRTbr9+GylMrFf9+sJs5v0FslriSa6v+tcFQdEqkxAhlUaVDtMcqSTBY
	Hitvqb8XCaF4pDqStppPZe9hMF20nbGAMm7H/V4qSOqBFZ2wR5JsxgrivTLxac4r/QSSN96hf/C
	Ke0oUeKuojarcp6983FRZCBGiW4TAw1RI+z2QuuQt25HLd5aLdYFuPGI26q6/7WsXUTcBNi/XLC
	fsamd1k08nNYMABjxrUewQmWBxRLoDlU53VncmO26ekSAy2dHDYV39JQ8opfiRvd7QnfdTgiLwL
	9F7VPFjWd06X7pxC65cpRO/YerCkEhCbGjyqSCfxBmxjPBcF6WOHXG6MTQdVHUaa1NOsXArpATw
	cxA2OKkCTQ/b7SzbK0f4fmBuVcl2u0Zv1I+gM34hR2xGFSaeYjt93ls2legNjlamuvVdY+3EOT7
	kX1w67dCmmcFMcVF4OqZZ3Txo=
X-Received: by 2002:a05:622a:2c1:b0:4ee:18e7:c4de with SMTP id d75a77b69052e-4f1d0622d74mr270978131cf.78.1765981745047;
        Wed, 17 Dec 2025 06:29:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHoDLIcQPG1FuC3FZZauVp7VVEdRE8p0W/nAUBeErKUh077HE+3CL82M3hNdbKfxiVebE0Aw==
X-Received: by 2002:a05:622a:2c1:b0:4ee:18e7:c4de with SMTP id d75a77b69052e-4f1d0622d74mr270977621cf.78.1765981744502;
        Wed, 17 Dec 2025 06:29:04 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5990da1a4a1sm2429362e87.40.2025.12.17.06.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:29:03 -0800 (PST)
Date: Wed, 17 Dec 2025 16:29:02 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vivek Kumar Sahu <vivesahu@qti.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: hci_qca: QCC2072 enablement
Message-ID: <xv7zlaoymcuq5kirrgu3thp3trmbdry5maraz34v4tkekinyaf@wgrfk7ukiilk>
References: <20251217112850.520572-1-vivesahu@qti.qualcomm.com>
 <20251217112850.520572-2-vivesahu@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217112850.520572-2-vivesahu@qti.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDExMiBTYWx0ZWRfXwOwnK6UkaIvP
 vI2mQgUg+7NBfosnKk+6X3TDF+KPER+sVEgwgTsbIwE0X6qacUeKydEuK17Y4H+zjN7SOWIPFiL
 p35yZuUny209i41wux7LJLNd/KFvZaqnNgYWUw7FI+TbVQAGVhrxDU6hjUhGcxVY/odsNSQIYdu
 hmzBl9g1Oz8NeTTkWO39h2Jw2238ox27DSdcoHhTf/HsA7JjVcHkTLbqaTUlmZ9v6HXz6lKPy4l
 Fb7nc27Uqpj4Rc/PPbFlwofYZPnkwonMcZxr1cintDQJn66QLMtZgrT2YAgCDhIDtN8b8MF0Jrz
 io+2brZEBMHsZT/hbggN7+JcS9Ukpw9o+5xfhBGUXx0oAQLzpe2eA3F2fsi6ZAfLk4t1C3iZsJv
 h79fUQ9A+EOgfH0LF5NDmuDjDt0dJg==
X-Proofpoint-ORIG-GUID: 8_U3s5B9NWpzJ2Lc1hLjbBWOKysmCxcg
X-Proofpoint-GUID: 8_U3s5B9NWpzJ2Lc1hLjbBWOKysmCxcg
X-Authority-Analysis: v=2.4 cv=R48O2NRX c=1 sm=1 tr=0 ts=6942be31 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=NUmHm4JO40cz2a15_LYA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512170112

On Wed, Dec 17, 2025 at 04:58:50PM +0530, Vivek Kumar Sahu wrote:
> Adding support for BT SoC QCC2072.
> Set appropriate configurations for BT UART
> transport.

Read Documentation/process/submitting-patches.rst

> 
> Signed-off-by: Vivek Kumar Sahu <vivesahu@qti.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c   |  8 ++++++++
>  drivers/bluetooth/btqca.h   |  1 +
>  drivers/bluetooth/hci_qca.c | 17 +++++++++++++++++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 7c958d6065be..7eb095db4a1d 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -854,6 +854,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  			snprintf(config.fwname, sizeof(config.fwname),
>  				 "qca/hmtbtfw%02x.tlv", rom_ver);
>  			break;
> +		case QCA_QCC2072:

Please keep the file sorted. Find a correct place to insert your changes
rather than randomly sticking them to the end. This applies to _all_ the
changes you've made here.

> +			snprintf(config.fwname, sizeof(config.fwname),
> +				 "qca/ornbtfw%02x.tlv", rom_ver);

I hope to see the firmware being submitted to linux-firmware.

> +			break;
>  		default:
>  			snprintf(config.fwname, sizeof(config.fwname),
>  				 "qca/rampatch_%08x.bin", soc_ver);
> @@ -929,6 +933,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
>  				 "hmtnv", soc_type, ver, rom_ver, boardid);
>  			break;
> +		case QCA_QCC2072:
> +			snprintf(config.fwname, sizeof(config.fwname),
> +				 "qca/ornnv%02x.bin", rom_ver);

No board-specific NVMEM dumps?

> +			break;
>  		default:
>  			snprintf(config.fwname, sizeof(config.fwname),
>  				 "qca/nvm_%08x.bin", soc_ver);

-- 
With best wishes
Dmitry
