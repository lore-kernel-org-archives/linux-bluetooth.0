Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6E019F11B
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755294525; cv=none; b=fXK1KfsBAdXN7O0V7VqNvk2tN9AtU9VJuvTi36LqOhO8cmuYPxkyJARj9eJ6Nb82pBTsIAVCgi+oY97ExEvat+bI7EBFpKuLbP27xGszyxq48ibxSG6xx02dPdjmysLNWvRqffnn7MnHMxzG8P5wI/yFbgRkKH7WFFLqdv/owSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755294525; c=relaxed/simple;
	bh=mhrUoh+DSjfZVrrPw+Nsk7fI8aBvnkqzQE57gdm55qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlAgN78rn0JEfx91eRiiQrl0lNgN4MkDEMxstTGLdq8qlafN7LkDARgtcZTf4jq93vo0zouMaD2gyKAYiL5q8VQjpaVMnJTVuoqGEWoCOzo69omyDcEwB64qQgm46IO1ZT4CUoYmHiRXdgmhquUq8v8WartrAbiyAbBZA1zdbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X7Ste8t8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X7Ste8t8"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FLmgHV022118;
	Fri, 15 Aug 2025 21:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3azxfqhNzSwS8fa4uccCMLq7
	gy1B9YWDKdwGIQObTuE=; b=X7Ste8t86//bHppSOpwmTbQgsdlfaVWzwIRFqGOi
	R8+xQTx2kF27eyuI9hG5zyYn6KOgI8Y3lGQw2rxsjAz+Iq1vabqZBp1YUvCTM6cO
	RU6fFm2N4rlJxYEvIiGYcqzLAEiLdHRWUvUBlcpaip1EfIIJ7JxFymhjcQtYbahl
	lNib1KWZVkjWNJh1SCdZjtBCPNTlK3qr/xMzatl0brJ5VrJ+GzU0fPMzuME1S34R
	GUGl5OJoIZy+KErMk5+7ZnvUjXPkR19cqEjQizK09blEWsikJEtcKE+nzaXgr6sm
	Zc1ZDZxqXyLP+IokkdIOFtbK/rZu7p6VTi8JpUuZFH6jpA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhxjev0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 21:48:42 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a88dd0193so51043046d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 14:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755294521; x=1755899321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3azxfqhNzSwS8fa4uccCMLq7gy1B9YWDKdwGIQObTuE=;
        b=CQPF3Rd/0trps5JCFyzcNhYBFO0eJyVS/aOYnYtJwxot9bqXPIRih13uhNjYklwfrt
         fdDvGrXnDQboUVS1OY7OhBQqB/sPaeV7LhCy/+k007Ys8Y0fpFMlZp15z1ndHXEi9D3l
         KeFc+jlaD+RxZcmdmnWof8/M2Lu69856Yv2sz/gJz5QRDqVgQWPEhC3MviMIw+6Q8Lvg
         YrM3WSyntaUbRhE6Eh4dJv8bXpTznSPo5UzXJkB8Bpbj2JONSTfOmphduPD9MXH/XQfh
         Xkq/sDEUAYhHDTL62qVOeBuf7EGCXDh7KbB0L9N3CuuY898SVI6pKlCsRaph7JAtJjtE
         nvVA==
X-Gm-Message-State: AOJu0YyoVsvs9kZAn9GmAQSgMj6NVRWKsAEIDPHVuFJChZfxYND9wRCt
	8v4hPcIu94PnZTPfh05natcJJqjH0YQc29RHERrgOZ6RtuHMMSCI2Hl1SQTXgN+HfnEQ6HkT9cc
	OAKdqS1BUf9DgHkupZQv0Tg/QAfy4OaXgb/n1j1AM8bH2wePN09AnxiZZRd4K7iKPz6u8jGA=
X-Gm-Gg: ASbGncsoDbb85x4gErqc51dlOwqrcb8VjhiqIPHBN8di9uFx6cJiTGZPUEF9uk9paIc
	AKBAq7X21w/rYKJCQXRT9DS7WuEyc6GlsUB4OaK9YMqOPq7Lwg+HspdM0MO8hyxLnFPziN2zTk3
	wFkx3TnNfDw7jIyXWjHXN8dHMolOy+nayDhC4AF1u/B0xS24E+D+ugFiqCQ5xz0lJr/UY5k0N2f
	2gjiWLKlTdu/uYaPFljd00cj4RcR6lPX5ER5TkYMPmYKjbIBR3XRblQZK+8nui8nDXudHNq3p8B
	Dh1gu5Ue8Q6dbpW1eTqdY07hyukBFLEKVfxKpuiF1V8O77nQCpDS3Ebz0khAiIC+GwltGTHeAwV
	kUVz0OfDSRwboSxqtgixVS/gKzSTAL0B7bmjbsXUJxntOfoBHKddu
X-Received: by 2002:ad4:5ae5:0:b0:707:6306:28bf with SMTP id 6a1803df08f44-70ba7c0c9damr49234466d6.36.1755294521286;
        Fri, 15 Aug 2025 14:48:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgwpAJSDUnwPnQp2m/lE5EwwP6ImBIjaPY0l0oQ5eg4FpmrJIrILBO05zQvRuPEk1BZenJNA==
X-Received: by 2002:ad4:5ae5:0:b0:707:6306:28bf with SMTP id 6a1803df08f44-70ba7c0c9damr49233936d6.36.1755294520253;
        Fri, 15 Aug 2025 14:48:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35f11csm500447e87.51.2025.08.15.14.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 14:48:39 -0700 (PDT)
Date: Sat, 16 Aug 2025 00:48:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_bt@quicinc.com
Subject: Re: [PATCH v4 1/4] driver: bluetooth: hci_qca: fix ssr fail when
 BT_EN is pulled up by hw
Message-ID: <lfo2phtbykl5dqiuiunxlzz3fybyqt7tcotihzhr27ivm7dk2l@l5q6ilkm5xrg>
References: <20250814124704.2531811-1-quic_shuaz@quicinc.com>
 <20250814124704.2531811-2-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814124704.2531811-2-quic_shuaz@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX4DmHsA+XV09Y
 77eLyfHHUzZtXKpagkJBDFlzfAKv1S8pLMmUuAbrrzZySXn+hWbPkCsbxl79HJaQ8L0V5Vxj+zw
 P63+qPtIwiEdT7a1j5/xHcG1nuAD1TJHhgi9U/BLwkQCF8Q6+R717LPBwIjxD4y8icJ/8STTX1W
 NgWL9IB13mpu/OiUoaLbjb8bsF5vPr/EzMSvijIah2if7V43DyrzO9PuTWPyomfUoVSSqUygsNE
 rHJPXpUFogA+9+tAhTdWdclZ7iWGBVrCcxAIjWDxI8yILYiDwL9uve967m7Kp12i4HZMwxeBuab
 PHbe8BV/BlKh+CbJL7yXBnBN98tCY2+2kAOPiGMU9prcof4f0o6CLCS8B2GRns1ftiwM5Wy4AHH
 hfPN6hJu
X-Proofpoint-GUID: LCOzYoYWyTWDHxJB4H_0nmUFqDqFpQq1
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689fab3a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=wIQ4YbeHDpbAtZWM-s4A:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: LCOzYoYWyTWDHxJB4H_0nmUFqDqFpQq1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_07,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

On Thu, Aug 14, 2025 at 08:47:01PM +0800, Shuai Zhang wrote:

I wonder what does it make to notice the part of the BT test report:

SubjectPrefix                 FAIL      0.66 seconds

and update log messages according to the custom of the BT subsystem?

Please use 'git log drivers/bluetooth/hci_qca.c' if you are unsure.

> When the host actively triggers SSR and collects coredump data,
> the Bluetooth stack sends a reset command to the controller. However,due
> to the inability to clear the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits,
> the reset command times out.
> 
> For the purpose of HCI_QUIRK_NON_PERSISTENT_SETUP, please refer to
> commit: 740011cfe94859df8d05f5400d589a8693b095e7.

commit 740011cfe948 ("Bluetooth: Add new quirk for non-persistent setup
settings")

> 
> The change is placed under if (!HCI_QUIRK_NON_PERSISTENT_SETUP)

Which change? You've described the issue, but you didn't describe what
is to be done.

> because this quirk is associated with BT_EN, and can be used to
> determine whether BT_EN is present in the device tree (DTS).

What can be 'used to determine....' ?

> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4e56782b0..91009c6a7 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1653,6 +1653,20 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>  		skb_queue_purge(&qca->rx_memdump_q);
>  	}
>  
> +	/*
> +	 * If the BT chip's bt_en pin is connected to a 3.3V power supply via
> +	 * hardware and always stays high, driver cannot control the bt_en pin.
> +	 * As a result, during SSR(SubSystem Restart), QCA_SSR_TRIGGERED and
> +	 * QCA_IBS_DISABLED flags cannot be cleared, which leads to a reset
> +	 * command timeout.
> +	 * Add an msleep delay to ensure controller completes the SSR process.
> +	 */
> +	if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> +		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
> +		clear_bit(QCA_IBS_DISABLED, &qca->flags);
> +		msleep(50);

It should be done other way around: first sleep, then clear bits.
Otherwise userspace might start sending SKBs while the BT is still
recovering.

> +	}
> +
>  	clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
>  }
-- 
With best wishes
Dmitry
