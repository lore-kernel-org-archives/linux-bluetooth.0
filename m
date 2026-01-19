Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE07735CB70
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768826374; cv=none; b=b1l/HWRyBHUuG64mU4GqCL9Agi/rGOsWu24VFC2R5dsryUrFKyEdRXS7JJ9tGeSJXjTN9MAGanRkOkmexjomOzWb841U87BUREIGr1irx9pMvkFJcLo92TH7HFXMbSFYYSRuchnm4P116ySyRKFftRiS7oyC4Gs54gkKoh5zYHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768826374; c=relaxed/simple;
	bh=C9CMmfRxh7qhhbnL1H5qrLWu6PlLcgbrqLoWO4Ezcjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNGkbzcjdNH9E14qvcxtqnxeQ04G8xsbVUWE/NpAuu72kZO0KTxRDmv1yNvd5/uUBML1TdZcnve7aPtpz8gpoGEgWjk93vTbfkVPO0ELxlevN1A2R0AG4WL19m4tvdyVTYibQdIxIOYfa9/fgrM7bNFXFiCBMIkessk1+CwVTKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PU1wqFok; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XHIAF46l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PU1wqFok";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XHIAF46l"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JAJxIY1531420
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 12:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=u/igNly3caGwOjqEsZYTcGrN
	eQi+egAoMo72lP6pEXI=; b=PU1wqFokf2mQzExpgGKHCiUgbwL7XQ2GA37pRGRv
	TiqZ0WWdRSko6Qj99pBcHid74r6twy4kvB6l/x9WXJxbkW3VTYh5BsIWSb11m6nx
	7WwFicLB7O0xvnO7Hp9jg7n7e5+QuUGYc2urPJHY35WeoVSJ9atGSPX4KUqABb3k
	yg1J+Uzh+1vZC8dZoOWj/rzFfnvwWoUWmSiSIdcNSM3EK9fLZewj9OESoRoi8Yti
	g1Ta7tAEhKCtaV0VRWGoT8LgYWYCjdFXexfCkdoIsbPVMX5BWwJLDTeYDxe1eDm7
	C+xKzLxkvz8Wt4M+8YpkxD8DSWzIX80gpiqRpyGsHilYUw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsjrxrcg9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 12:39:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c5297cfe68so789180385a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 04:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768826370; x=1769431170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u/igNly3caGwOjqEsZYTcGrNeQi+egAoMo72lP6pEXI=;
        b=XHIAF46lXoSRU/y+rgswEec7aIKTsrF6aiM8QYeaVievtGNJwPZC+xfG2q55IAfLR9
         vHBMDDBB+bOm0h6WMIJ3FxKbxKwbchn3eOmRgFeDp0dIwf4RyFPUSnNLM5MKdTsZesdQ
         wjknvVsNX4yUoGlIQhXz1exIcEyMO9Iy/gJ/28nl+YulW0Y44Y5kDQHd8IQpiwY8SwYk
         E9r904Xi5zeowZYs8sERGhSsfD3JQgH9Keo2XAzBXhWAqmpyoUHT6kSCtJrJUahIa5yP
         9OXt3m3WMcG6EmZgojEAzSWwEqde6n9xgeACm6a/JJMgh28gzWjaQlRPub7NtNzoitfm
         Ee+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768826370; x=1769431170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/igNly3caGwOjqEsZYTcGrNeQi+egAoMo72lP6pEXI=;
        b=s5e/VTKioATvWvlj6G6L+HdisD0P5Z19Vz8qeqtX4KssqDjl8nJqDl8eYJNCZs+BMk
         8tA+rTqEgRt872gIEVD1W79CbAoXz+wszrCksefPJe7WvQtHXbQzO7n8QMbnGS/IWaUZ
         JWYzgGISJ27XNnRZorFnq9nAqthoNOWRXpQNNaqJWyMtmbGfZ147TlgFYiK1d4w5cGis
         Y5F6COIi0wn15PF4DM3+UfreFsAdQ2JC+fULfhspCidG/ig4UwZfRopKNCRu0dNdFanj
         siaOqoG+4yE8XQqC36/F4pjFbfKS2KL3SdD++mYQQusc0nRR6yfWuYgHOZQyYlz7ok4u
         c2wA==
X-Forwarded-Encrypted: i=1; AJvYcCVitCJgUoA5weOHwtckRNRt8Un/g6LoG89wcaPaZMPvDeppatFWUOJulk1wIu3jke5y4LPHtvwZlwqgXRIr0kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMMcbOcVstLQmZuy8SxzC1gZsLcWhekRJKBEdSvww+7tHHqYFo
	xY0CQWCaNh5Sz42z3i0G58nvnFn4kEN+6p4PapUFBuuf+6C0Rn1NtTlwp5fa93hYrhhVxDxHXb7
	LUG+hADJZ5gCRS1OxpZ9+wF983QM7KSwm1cEdi6sGsA9JDy1IhP/RaEZpnmwJxeOVoendQa4=
X-Gm-Gg: AY/fxX7t55qL/NUYLCJBlTE/wDgT2T/k1I4dN7FQ62n6Aa27Bn0oGa4mKl+dx841Tj3
	cgYrAW/qoCDFrd0xZf4nysQH71MWtFlwv0XEGQZZlgmhylANLklJVmeMoQVoWrRySJBkIyhg5dO
	ACxt/hA0OvMT3uW5FX+qEVjWHa6nDubzRivUmFEzHA5Uicl9vJxQwvpmrsb/9e0grRS4qOW42+j
	8My0wGfGJLRgO1O65KnalXWQmTtMKnrVs7EvhK/yZyOUdJIM6ZNOh+0D/vyNoG/Uoh8ueaqTumv
	u1Tc1vT9Jan1/E6kan4vwO22apmiG6TlG8aYroJ3+04CIIUWfeIyv7tjVkNROylr6MYKgGAlYOj
	sjqwjPhbYU3VgeBB8GlAZCHYncu0akUveKTH/KSav2ddbbG1Fgwo1FbeBztUCUVRHMEjzNgj0Ho
	Omu37mMXuUS8SWoXykZR8obeU=
X-Received: by 2002:a05:620a:40cd:b0:8c0:cbd8:20b0 with SMTP id af79cd13be357-8c6a6705321mr1398002485a.34.1768826369899;
        Mon, 19 Jan 2026 04:39:29 -0800 (PST)
X-Received: by 2002:a05:620a:40cd:b0:8c0:cbd8:20b0 with SMTP id af79cd13be357-8c6a6705321mr1397999685a.34.1768826369359;
        Mon, 19 Jan 2026 04:39:29 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf3a0db7sm3252151e87.87.2026.01.19.04.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 04:39:28 -0800 (PST)
Date: Mon, 19 Jan 2026 14:39:27 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix not clearing
 cmd_sync_work_list on power off
Message-ID: <hkjzyyrwhdybojyh335w7gl5bgifdml7l72bnxczizk4p2v4hj@76qh6frpcqcn>
References: <20251209140347.2816326-1-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209140347.2816326-1-shuai.zhang@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEwNCBTYWx0ZWRfXx9FBlPkNhM4L
 uUpPpeF6MXx4h9Ksdcumf8daRpGoa6klcKrSFPNtkXnRIGwvhZfPFEM2VbAX/8lMuWcsDy/uXwX
 NGtLDKtCfQMjzUco3agWctyDSaxI3lkttGm9JHaEhfXgnr3LKkUO1PsmdzBUf2/QOA2FbmqDBbN
 vM+jF9comN4sgY8yOxYcmqc/c2FzZRfGJrH5jezPj2dNcsbqNcikn8bngd2ZmG1dHdatr5Gdmmj
 6nPTnoCSkri5xPoaNxibYkdcuKzFCQyHvu4tOzHiMfkQ4/1Vhq0SAqIbatTYJo3h19/cLfHpXa2
 LQkPWFoj+3kVp/OCRhi/WtFjFqLGD2E8y5BjDMzivcMMG631pPZrXgz1WWvgMAKjdCmnZ4rSeVX
 eXcirNLu4D4o9DqrRZ/RItqiUf6aCIkWeEleO/rZLLlB9DmdpoGR1ekjEZi6GkuEo1021+9+zt2
 tzPtW3Q42ZrmuzMjZHA==
X-Proofpoint-GUID: 4JZaMhcH5lRJ5_IiKQnv_YtVs_V3TjcI
X-Authority-Analysis: v=2.4 cv=PPUCOPqC c=1 sm=1 tr=0 ts=696e2603 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=QayldU47vYgVRzYphUAA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 4JZaMhcH5lRJ5_IiKQnv_YtVs_V3TjcI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190104

On Tue, Dec 09, 2025 at 10:03:47PM +0800, Shuai Zhang wrote:
> When powering off the cmd_sync_work_list may contain items which shall
> be cleared during power off as they shouldn't be run during power off
> sequence.
> 
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  net/bluetooth/hci_sync.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index a9f5b1a68..45b593ec7 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -648,16 +648,22 @@ static void _hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
>  	kfree(entry);
>  }
>  
> -void hci_cmd_sync_clear(struct hci_dev *hdev)
> +/* Clear remaining entries in cmd_sync_work_list */
> +static void hci_cmd_sync_list_clear(struct hci_dev *hdev)
>  {
>  	struct hci_cmd_sync_work_entry *entry, *tmp;
>  
> +	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
> +		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
> +}
> +
> +void hci_cmd_sync_clear(struct hci_dev *hdev)
> +{
>  	cancel_work_sync(&hdev->cmd_sync_work);
>  	cancel_work_sync(&hdev->reenable_adv_work);
>  
>  	mutex_lock(&hdev->cmd_sync_work_lock);
> -	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
> -		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
> +	hci_cmd_sync_list_clear(hdev);
>  	mutex_unlock(&hdev->cmd_sync_work_lock);
>  }
>  
> @@ -678,6 +684,7 @@ EXPORT_SYMBOL(hci_cmd_sync_cancel);
>   *
>   * - Set result and mark status to HCI_REQ_CANCELED
>   * - Wakeup command sync thread
> + * - Clear cmd_sync_work_list if the interface is down
>   */
>  void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
>  {
> @@ -692,6 +699,9 @@ void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
>  
>  		wake_up_interruptible(&hdev->req_wait_q);
>  	}
> +
> +	if (err == EHOSTDOWN || err == -EHOSTDOWN)

Which one? I suppose it can become only one of those.

> +		hci_cmd_sync_list_clear(hdev);

What will prevent ocncurrent modification of the cmd_sync_work_list?

>  }
>  EXPORT_SYMBOL(hci_cmd_sync_cancel_sync);
>  
> @@ -5260,14 +5270,14 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>  		disable_delayed_work(&hdev->power_off);
>  		disable_delayed_work(&hdev->ncmd_timer);
>  		disable_delayed_work(&hdev->le_scan_disable);
> +		hci_cmd_sync_cancel_sync(hdev, ENODEV);
>  	} else {
>  		cancel_delayed_work(&hdev->power_off);
>  		cancel_delayed_work(&hdev->ncmd_timer);
>  		cancel_delayed_work(&hdev->le_scan_disable);
> +		hci_cmd_sync_cancel_sync(hdev, EHOSTDOWN);
>  	}
>  
> -	hci_cmd_sync_cancel_sync(hdev, ENODEV);
> -
>  	cancel_interleave_scan(hdev);
>  
>  	if (hdev->adv_instance_timeout) {
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
