Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D881607A4
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244610; cv=none; b=I/cdypGwkdxWdn3j4cm6mC35EYWnlAJh7nmJ0lIf8u71VJNYR0OejoCjed6mSAl969T0fhSZvoQwixosp4xDzKXcGJI1n6LCNQ053r0+r9PfZb+9rFnBiNFF6ScluehshcjhmRJIZTTGoflZ6lrxHDJ4z1CDdsU+tyhmw/TFGrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244610; c=relaxed/simple;
	bh=zw7g2Yy6gSTJR6AEXuh6Ij4LgD/Ye5RZbXDj40piSG0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jpyTiQ2nmeuYzkRy3yOe0zrhPozR/QqHAlxU1wV9Z58DrTYTsig7x84NFWdqungjPx2O31pCHajqhrpLihqJjviSxcu7rEkvfbcLRiSNghFvRdMnmqlRQNjnRBcXBCoTCf4Ev6jIqmOrR9VGH8pH06tgafZWqdA0rFs6HBrQenc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AEc5OrVj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DascmWg+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AEc5OrVj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DascmWg+"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648BAGC32198887
	for <linux-bluetooth@vger.kernel.org>; Fri, 8 May 2026 12:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fgy0grFfJFOerAGbvrwoD3Um+wI6cGrkAGMGsBcSdPA=; b=AEc5OrVjL0wweDjV
	LM81Ei88lJb9V/aW+wrlAueL0bNYeUkLPYe0l+CJNzj/JElm7BvQz0XzV9DFrmIP
	GYDFojJHOv94qhRiJiTOT6yu4uI7y/fhkDg+aRCHSL2EW8IgnTZ/6QkVBntS1qoO
	lRTL7yYuDUhFCp5c/aju0VnEDEIDPJPIg2XI6YMadvqW+ErAoaxhtYq0pRyULRCD
	UzbSQFhNpMzl/Iy0nFpEG+rfwZbItzxywgVNAqH9uxxn0EIA7gEz0RNq3j27Kt1v
	qY7o3xM1aDIbqYysgh2U4hq0EcLR+vNt3jM6UBDUXyvWFkBmPGwrTS8jwgGUCLCL
	OoEH3w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e119skcmm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2026 12:50:06 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2f21cb36bbbso213707eec.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2026 05:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778244606; x=1778849406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fgy0grFfJFOerAGbvrwoD3Um+wI6cGrkAGMGsBcSdPA=;
        b=DascmWg+sWfm5gGWxN10T045Iqtf2yCDCB+jqOTryL63ZtsE9ZQ/hSNYyrbD/SUal7
         BggJtYeHlYkHpLpO9zNBOEwxh2KFouFdkr4TtDDG/8mksNnwmixVftb0XYcoed8t/Vqa
         wbGjT0JUmeHP3z28xTeA37gqCrCl7WAOaByAP1muhSYnXqz2TRa2zdvz9NJ+qHiV5YKJ
         c9hrR3MLhZ9wBRBNIKT8uYOYYGRP98wBqcClZKQOojRfSr0FpgjKt1D5ifIjJJ5oaJNC
         T6TPj4JLdJcqjkXw1JtePOPTy2kr3U05S5tBkwoaLUlvo2/3YXe3CbbjMITKTYAxHGgf
         wEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778244606; x=1778849406;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgy0grFfJFOerAGbvrwoD3Um+wI6cGrkAGMGsBcSdPA=;
        b=GKc1tE8qAoknGCb/qtfOh7gMKFkiIEzrdNi+4ao69LjQpU+fbI+1WZBO/ZtZBB028n
         JTfCt59mzOp/8gg3LlH1kaR2bGGY0R7Ts88yc3Wfd1Zsf1e1008jM72tTVZqsLEZZ2gf
         rwZzkU3uB5sn3T22n/0GpMRmnNB76cuixNSf6hLh/mXSFxfCXemAW/YldHDCEfWffDli
         Nl793tET+36fBc2dvGpJ+AIgMkJjjIFLnr5T1rBSvpemjA10ViS+1Z48ba+KR+ebgKF8
         FCTNHW8MJ5igVHWaQx9iaS4MbWO3UOBTyxGjnDjZUEW1JlrFehOEPU/4q+DwDGtkAsya
         w4/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/dBv6rzq+w4QEvoM4m1bomsngXbRkfRCCNNPqOCNvEQusu/yKpQz850A7siwvr83sfZIVMJYc8Z2o1TOBXJoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzejhzmBdsEpuu9H7yiNnk8e6NVsswFfxAIXnsss6xMDFTadmbE
	8UOvBB3mQv0K73n2yF799Ng1GpsvzzNfcNFSMH7U3DjJe13BPQ6O8xivsKaEyDIdQF6Mc9lvLUb
	owCBiR9OzacqYXjTcBZsBKOs+TWvR2geCJSPijbh9BiA01JZ6wlo4xGd10flLIvx2VV9MvS4=
X-Gm-Gg: AeBDiesoaY8VxWQAoUo7HFEq3NYZspmvbZWdGh02PNV/UQCPFGaXE5wOwifr8YSJdPH
	0w8balCfrNrWr6OIYPtnwuW9S3LHbD4ghvtmfE6Q4xYjoe+aQXYiFWeqH1pxq6qa1kveQ0eoafu
	YqZhLGmyvvLAOClf3pxCL85QiHyXxraZeEa2C6OkMUCTG17oOcO3IxgfpLaDOIN7KJePlzkIb9O
	ldo2eJE3bxmhTuqmmgN9wTXXGCcxR+Mgl6A6tpkHjkl4rgeuTontsEnQdDt+T7KuUUZwP3GtnC7
	d14gTCDX7OcfyylsUBqlJYfP6eZsDse1entCCquhFODTYQJSqfestjQyOefRjRlwEU5+o2dPMFD
	WO4yvIcnGCBd/8HclH2VGbG7aBNcz3Wr7nIfARQpnno0=
X-Received: by 2002:a05:7022:68a9:b0:11b:ad6a:6e39 with SMTP id a92af1059eb24-1320b6fa279mr2355542c88.5.1778244605509;
        Fri, 08 May 2026 05:50:05 -0700 (PDT)
X-Received: by 2002:a05:7022:68a9:b0:11b:ad6a:6e39 with SMTP id a92af1059eb24-1320b6fa279mr2355521c88.5.1778244604928;
        Fri, 08 May 2026 05:50:04 -0700 (PDT)
Received: from [10.239.97.27] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132781103e7sm2635918c88.1.2026.05.08.05.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 05:50:04 -0700 (PDT)
Message-ID: <b66ea442-2c02-4662-b5de-f5482736ef7e@oss.qualcomm.com>
Date: Fri, 8 May 2026 20:49:36 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wei Deng <wei.deng@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/9] Fixes/improvements for the PCI M.2 power
 sequencing driver
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260507-pwrseq-m2-bt-v2-0-1740bd478539@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260507-pwrseq-m2-bt-v2-0-1740bd478539@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEzMiBTYWx0ZWRfX0XKjJQiVxJXf
 1T9gWFBjOma0eGxNDL3/UgfdjnKs47xpqLgMp9sqAGvpfIhc+BcScw0GACbif13hNSceJmFR6LM
 bhS6q5Hw5u306V3cnbgHYMSYF0q0nSm3Yq15i1iQ4Dto4pbWlQwIx5F5uhJ+Xw6GW921K/b6aIL
 U8QFw9lDbQWEPsxaaurb/IYDJE4Lm9AHM5dW2EMyTiwNtA2EY4MJ1SYwjV0gSAGC3qWr+S9vn8Z
 BZEqVQeviWQ4sjSV45ZJXMe1LOwFr2LiJzM1rdt3RzUjE5qamfs2Rv7R27rrVHn8yUAEdv1hS7C
 9Cq35fDfoZ25lAyAzXarW8UseGil0ALI1z5iBo2x66EwhKnOIYaAuAExFTriC/7CO8R6xWKPVY6
 Rz2wxOuFOegeO5JoKc4bUOO0CAfXskJ6thOlM1+tl+S/h/nx/aOW3YwBBqPE7CQRm7CYBPEokVN
 pPzT7+w1t8UJuW9k7ig==
X-Proofpoint-ORIG-GUID: 2yb7FuhNUaTITMbivIhJIwRwGznnGw0M
X-Proofpoint-GUID: 2yb7FuhNUaTITMbivIhJIwRwGznnGw0M
X-Authority-Analysis: v=2.4 cv=Dd4nbPtW c=1 sm=1 tr=0 ts=69fddbfe cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=qRrKk6tSi6DhAyMAVQEA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080132

Hi Mani,

Tested with WCN685x on both M.2 card (pwrseq-pcie-m2) and direct attach
(pwrseq-qcom-wcn). BT works correctly in both cases.

Tested-by: Wei Deng <wei.deng@oss.qualcomm.com>

On 5/8/2026 12:06 AM, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series has several key improvements and fixes to the M.2 power sequencing
> driver and also the BT HCI_QCA driver. Notably, this series allows the M.2 power
> sequencing driver to work with more M.2 cards, not just WCN7850. It also allows
> the BT HCI_QCA driver to detect whether it can control BT_EN (or W_DISABLE2#)
> signal on the connector and set the HCI_QUIRK_NON_PERSISTENT_SETUP quirk.
> 
> Testing
> =======
> 
> This series was tested on Lenovo Thinkpad T14s together with the below DTS
> patches:
> https://github.com/Mani-Sadhasivam/linux/commit/29534d15307551b2355eb254601dec511169f0aa
> https://github.com/Mani-Sadhasivam/linux/commit/f4eaacfe647674be200847092b43cdef2194fc55
> 
> Merge Strategy
> ==============
> 
> Since the BT HCI_QCA changes depend on the pwrseq changes, it would be good to
> merge the whole series through pwrseq tree or through an immutable branch.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Changes in v2:
> - Dropped the pwrseq_is_fixed() change in favor or exporting pwrseq device's dev
>   pointer and using it to check for the presence of W_DISABLE2# property
> - Dropped the BT_EN fix for the Qcom WCN devices since it will be handled
>   separately
> - Collected tags
> - Link to v1: https://patch.msgid.link/20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com
> 
> ---
> Manivannan Sadhasivam (9):
>       power: sequencing: pcie-m2: Fix inconsistent function prefixes
>       power: sequencing: pcie-m2: Allow creating serdev for multiple PCI devices
>       power: sequencing: pcie-m2: Improve PCI device ID check
>       power: sequencing: pcie-m2: Create serdev for PCI devices present before probe
>       power: sequencing: pcie-m2: Create BT node based on the pci_device_id[] table
>       Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
>       Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to 'bt_en_available'
>       power: sequencing: Add an API to return the pwrseq device's 'dev' pointer
>       Bluetooth: hci_qca: Set 'bt_en_available' based on W_DISABLE2# presence in M.2 connector
> 
>  drivers/bluetooth/hci_qca.c               |  28 +++-
>  drivers/power/sequencing/core.c           |   9 ++
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 234 ++++++++++++++++++++++--------
>  include/linux/pwrseq/consumer.h           |   7 +
>  4 files changed, 217 insertions(+), 61 deletions(-)
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260422-pwrseq-m2-bt-abdaa71094eb
> 
> Best regards,
> --  
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> 

-- 
Best Regards,
Wei Deng

