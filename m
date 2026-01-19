Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B84314B9A
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823225; cv=none; b=DN1sTNgXhiED7n82yd0NX5O8OB7ZM3wb9YSAt9CQSbH0sp2b9fosUOx5UrD6gbfmRjtRBPQy4eU32GnJIRHgNc55aBE6ZIofLw3m3KlzqgWLbsyUtToQR1Zp3uk2IhgHEBhugcqkGHQSC2In7dqcsZj6EojbiyoONz8wqVEp8ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823225; c=relaxed/simple;
	bh=WphD3di6sPvBYWLWfOlZFQEfvM5D5MOizS2is20CSA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFFkwjus1se5ElgK3bXfLUGDcEZEWPvefvya7+YEVEbfG/1l76KpwZB7Pw+Ka7hu08T02v9hn4at4w6rqFSYOajtzDRb/JlmzdtOpuddXF6tIZfij1uqRonwamNakaMBzJmq2wdw0vsnyqnteKnoCGmybsLOogT2s0i0EH4IlhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mS9A1G33; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iCQpLgiy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mS9A1G33";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iCQpLgiy"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J90m4K1904958
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 11:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M/kXB9qV/mARKq84Xs1cOBzOK1huJAJfToX9eRl6AHs=; b=mS9A1G339ZJwcryC
	OxlCD1EbNjsXWuZbe33d6R3UEBmqU86gn2skhLjd++cDhn3dshpBcs39QAKbVPhr
	HrB7Up7sr21iyyC9uOOHJb5UcjAPl5a+h5EdlvY5tZCZLl99k35Ar3KeoG0/7Mdk
	47L+YzPTIBCpfJD2ExVdZdvm3FLrZ6vgGw2dF0Btd74K2liYyN1Y1XTQkNxAeWq1
	4jqzTJ65f16ahgowtWb8sYzSwzJ30S12adW5Xp0Kimy2I/GrMNGemADq/OuDONPY
	90proo8DJYg/41vBS79I1hQge6b6KddbzyFBT7Vy1P35NXLC+1zUGye6z/92nnqb
	PO6HFg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsgmu8s57-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 11:47:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c38781efcso3452377a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 03:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768823222; x=1769428022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/kXB9qV/mARKq84Xs1cOBzOK1huJAJfToX9eRl6AHs=;
        b=iCQpLgiye4N4IAZofYZ8fCgmY7iHUie25NRUz4/DSe2qUxnUbZfFmMKMd1+xNnNQuK
         sTFBzF/ToAsyx/SGCP8dCRoAZtMeGHhk3qu8L/qeJLsKsxR+gVfxOXy4rpUp+N4AyzUi
         uzlx6AHtIYWRYeD/UTHhWd8yjUbju5UbJeicYvg/FTZiK+ZZxR7bQTqLz237GKUNqfBr
         Wi40708YDReW9repnHr8+IBwe3RAEBfrl1fIFrNSI432s1G2eHmWqtAvXSf/r688XGCu
         wXQp30P61wmMLztP5h6Lsj/PNzp85CxdWCwwS/Vo0SwUyJQhq1U7Zw9lVyLjzLLC+S8S
         uoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768823222; x=1769428022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/kXB9qV/mARKq84Xs1cOBzOK1huJAJfToX9eRl6AHs=;
        b=kFaeQNG+g4ZXY8YIZF952gTZx+ZTcIqmWMpVfDfU9ykZivukm/yVpwzIIEuy1CDVd9
         cVkL/8/kf5A8HDpQGtAIpiwUePiHVU7XQPhkStEXe6dIBRBppAMGBTY1EmShxyFJDiX+
         objJ/f9ZnQv9bMptBKjdJHBkz3PgzfgB/ZNQElXYekvx51TqcNE4yRfF2dTfvEmgkVrH
         PYXM5eQ4qqO6tSb+nOmtLt9LxbLVya8Rw+fVJsPFn7D7VemSh98QAFVFYxy6Kb4rww5e
         lsiFWQy06Lp1Z1yN2kokeETvggztsh+4n1NUEd9pbKwygim1V/4HubNxKsZ1hCpMsmES
         NeUA==
X-Gm-Message-State: AOJu0YxhT52NdU/myl1Cg0u0/lDQ7f+UvK91UurA7+oqktKc56yEbrq5
	oS1JZs1gPmOaOJtiByG0+pa61xWSkwVOeJ9s5t4cGzz0mLle+2EmgFrPBUW0g8mRjkAbBn4OITK
	3EW+nyojiIhMMOZDylzha2TvBFfa58AXsB1+w7UiHZkJmMyZCvSa5L4RIoeLPK6iygQlVrW4=
X-Gm-Gg: AZuq6aKA4SrHX9ctMWGQPHVvOZ0o0iQ1OG3d6s4q043pP9hrExWpGQ3BRKwBBNzs4zA
	0Wq4xhmEHhXxcs620LIb1jqrRIJtpe8Q4oXl/QtxO2MidvjH2qu0iufmU3QK+Rdmw22sObfXOFr
	yW/7Szjqpp9XNricw6yNg5vfHkR3P5Gu7XknVtR3o46eEFyEBEJozFQk6GebMi1qFQqDtq8UiAG
	LWxD+7alWP5v6Dv2ODzjYyBBje1fa2P8h91qJasSx3uDlLL7mkOpT3OkCVDEqaspf13btjVRXCe
	GMwdCxeZ3c5YqdyQRBNTgnvtWfqEDdbifWJfGgRKo9ucqsImjLjuv8FN3SzIEwSrRHxnu/iaF4y
	5JtglX5VrjGf9Nx4f2YznSe0XQv3sqpD6ih8=
X-Received: by 2002:a17:90b:2d47:b0:34a:4a8d:2e2e with SMTP id 98e67ed59e1d1-35272f973b4mr9869542a91.17.1768823222181;
        Mon, 19 Jan 2026 03:47:02 -0800 (PST)
X-Received: by 2002:a17:90b:2d47:b0:34a:4a8d:2e2e with SMTP id 98e67ed59e1d1-35272f973b4mr9869524a91.17.1768823221716;
        Mon, 19 Jan 2026 03:47:01 -0800 (PST)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf233914sm9089925a12.1.2026.01.19.03.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 03:47:01 -0800 (PST)
Message-ID: <a963b9cf-006c-4fd3-a1d4-789ff10ed10b@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 19:46:41 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix not clearing
 cmd_sync_work_list on power off
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com
References: <20251209140347.2816326-1-shuai.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20251209140347.2816326-1-shuai.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA5NyBTYWx0ZWRfXz2V893MyqV08
 uNJaDztiCMRn+yDUTNGAyx0HSKcdW+GPXLhvQKwCkg5ULD7N6wsdeCF4SJiLZ5XqlYHKOdaUBmp
 rft3P74T/DUQw/A7DRq2+8EEBMBKU7kDOy8KlhVi3lYcCm7RRuSQHJa//qpfFOAc1ppf4xFPqz4
 MIGcJ0qnBVwD94ZP89gSTRMWRKeNTTElWT3IqhZ/zGdNj7FVZjq3DXg1GW9EZT/mipRpfuYdTxu
 Ofl0cicry01La/L7wJl9T89PLjbLYmEurAcqzDpMSKshWF3bQYxqqLVfOtWuuppVcAmCcAbioJJ
 1oDZelTdUFhooyzzY5XyJvocsS5uMk7hmUSrujhRO+yLryOZ8S3ailP7D8OJ2A78ROqQcPsgdso
 dmlTInR2kcWwwnJ0jT0TbW57KXa70mwoi+JvPkdPhI6GCNIGXOyO127y9NseEzYM/4avHpOfw0s
 n3gKQcHMj3v6x9xWDqw==
X-Authority-Analysis: v=2.4 cv=Is4Tsb/g c=1 sm=1 tr=0 ts=696e19b7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=bkFCjwZo7dHlCUbkh74A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 3zdGUmXZ5Io0-Zj6uIlBD1_8TffcrRqY
X-Proofpoint-GUID: 3zdGUmXZ5Io0-Zj6uIlBD1_8TffcrRqY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190097

Hi

On 12/9/2025 10:03 PM, Shuai Zhang wrote:
> When powering off the cmd_sync_work_list may contain items which shall
> be cleared during power off as they shouldn't be run during power off
> sequence.
>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>   net/bluetooth/hci_sync.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index a9f5b1a68..45b593ec7 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -648,16 +648,22 @@ static void _hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
>   	kfree(entry);
>   }
>   
> -void hci_cmd_sync_clear(struct hci_dev *hdev)
> +/* Clear remaining entries in cmd_sync_work_list */
> +static void hci_cmd_sync_list_clear(struct hci_dev *hdev)
>   {
>   	struct hci_cmd_sync_work_entry *entry, *tmp;
>   
> +	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
> +		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
> +}
> +
> +void hci_cmd_sync_clear(struct hci_dev *hdev)
> +{
>   	cancel_work_sync(&hdev->cmd_sync_work);
>   	cancel_work_sync(&hdev->reenable_adv_work);
>   
>   	mutex_lock(&hdev->cmd_sync_work_lock);
> -	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
> -		_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
> +	hci_cmd_sync_list_clear(hdev);
>   	mutex_unlock(&hdev->cmd_sync_work_lock);
>   }
>   
> @@ -678,6 +684,7 @@ EXPORT_SYMBOL(hci_cmd_sync_cancel);
>    *
>    * - Set result and mark status to HCI_REQ_CANCELED
>    * - Wakeup command sync thread
> + * - Clear cmd_sync_work_list if the interface is down
>    */
>   void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
>   {
> @@ -692,6 +699,9 @@ void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
>   
>   		wake_up_interruptible(&hdev->req_wait_q);
>   	}
> +
> +	if (err == EHOSTDOWN || err == -EHOSTDOWN)
> +		hci_cmd_sync_list_clear(hdev);
>   }
>   EXPORT_SYMBOL(hci_cmd_sync_cancel_sync);
>   
> @@ -5260,14 +5270,14 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>   		disable_delayed_work(&hdev->power_off);
>   		disable_delayed_work(&hdev->ncmd_timer);
>   		disable_delayed_work(&hdev->le_scan_disable);
> +		hci_cmd_sync_cancel_sync(hdev, ENODEV);
>   	} else {
>   		cancel_delayed_work(&hdev->power_off);
>   		cancel_delayed_work(&hdev->ncmd_timer);
>   		cancel_delayed_work(&hdev->le_scan_disable);
> +		hci_cmd_sync_cancel_sync(hdev, EHOSTDOWN);
>   	}
>   
> -	hci_cmd_sync_cancel_sync(hdev, ENODEV);
> -
>   	cancel_interleave_scan(hdev);
>   
>   	if (hdev->adv_instance_timeout) {
Kindly let me know if there are any updates.


Kindly, regard

Shuai



