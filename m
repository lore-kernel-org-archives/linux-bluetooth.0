Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA5221DB3
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782353322; cv=none; b=WQXSO/7tIfFg7A86S3IIy2Nu8D48djCsBzWWzS6VHeKbQODJoiAHcuoCxojYnFyFIvCTucKuquIQE68ltsFTiA6Hjv9OeedBs+KIprk5A2/fbQ2B45y8pyQZRP29KJ8InXTcNXev0DcfxZ/z+pWn2gpNvekY/EPo2RdL3xGDKEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782353322; c=relaxed/simple;
	bh=2ZmXQtki00OVDs26cp72st4xSOWl+5jurCzLVi+ahfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOkhFAhtYjmg41cEVwqt4q7/mmBpdG+0n7uoL38GDyHmJ8u4NJraRxuTR33JR/bQowl1SEYDaZH0XaQZYGGVC8iiD8vZ4GgdHlg3NgLzxmseKolvFn5AdtvcnmkNfEywp5YirebtlcI3tudPr1vAmZSBdB67n5g2aUbBsbc2Zt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FjHklYfA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cU5sxb5d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FjHklYfA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cU5sxb5d"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P25leh448585
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 02:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X9O3LqEnWk1hcXZHFecyP2k3xenALgYADP34G52NT1M=; b=FjHklYfA0K9RSFLa
	OTei3cXDstjXL1d4Hmahd9pepTj+OtSDiekco8TXhCkp4NZVLB6ueRZFxXiuDt++
	1Ca7izHT/torJQRVzOtfV0TOhhtL+zvjgDW90UTkMLFRmMxl3rlyh+2OAPamN+VV
	SEyl3X9HUbdx0O3tgRYNh9mS/MZsAGOmfK7cWXWD7XMQKZTGqUprT6zIkQHTv+de
	nqaI7ue2Mdetn+sJNgF2FAX+FeZlrLKRLz1+kbg4zVRxNpQyUb3NtjX+LaAt0365
	pU2loPGhlmUa4O/tS0EDC630k2z4E5I39tXLkQOdP64nDCS8jP9ypeoSitEjdOuM
	xnY1WA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0nv7h2dq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 02:08:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37deda86778so61255a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 19:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782353320; x=1782958120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X9O3LqEnWk1hcXZHFecyP2k3xenALgYADP34G52NT1M=;
        b=cU5sxb5dfAYs908pOnZ2RgYn9mJ9qGkPeXCwBK0mF4Du2sIWQSkxUfUnHBVMfpUuar
         +DYzQlO4SFoL1SoeIRzRVz8XOnKB+75v2X1FIRn6aJwW8E6KmvVLQzWedwv2Oj62H25C
         omJJuwNocfn8eAGnLc603e/6aWdwbgPxW4zTYLv7G0JU5LcO6o9I+EnyuTx9kq0Fv7Zb
         DWzPob5bUvtgdsJgP4PS6hmnIGACI0qAmGd6A7Uzb69+kv3ufX6mXOVQbmUFKMc77Di6
         MQR5nAorJL+XgHib0sWY2mfHmD3jNQUGplMib9KvKJcZA5/cbSnjPNRn/X0O2r0om9Ks
         1UUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782353320; x=1782958120;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X9O3LqEnWk1hcXZHFecyP2k3xenALgYADP34G52NT1M=;
        b=D/fOPsJd15hNhJSv6dflmkttXTwv4tmHqhue5FpJhp0k1QUcKml4NNRYX2tRAEgCAW
         nucw2e1jbnyxabWeA2weDbhN6sdCSIjya9GvVKgS0jfnQ4EP6m8LXFQHdjypR+NOe62S
         ZYnL+oDvZQqXOwD2uIKh9mikwOp8HirasBXzuH3Lxu5VVqrjWMl9h3/E6nVNbQidXH6B
         kNJq56t4GCVIxMo3X8kP5kW/7UsQWW9aWd+h7nwL5ayaI1NjsD0423VS8KVC6F4rx8qn
         adOajK8lO2rZGgmTGmSdC4xcYkm5hSkxFWHEzpSkU+ZjCDg+wZRUbYw1e97V7YQ8ITql
         PM7A==
X-Forwarded-Encrypted: i=1; AHgh+RpJhPT5YUhmQ3VgZaPVeKd2DjuuxEzfwazMF7ZkMCpgtNry/ABfUiqx+I5eTpmQq4s/sKPAFQEltekm00rY/QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4gz9Y+5gUyrg5xO7UljB8q3Gg8B7bi3wzRB9t91s+4iFh9QU9
	u6RpI0UaWd9nS0qqF3C4xfLPG+Ecj95zIHLC8eydLZOEzwpLvAq30oYutZh+mdotH/eTHsXfLqk
	DeClFnUli3IeFV3w1cwEHZk4FlOgfhsQOqBPffjJLSYyvow0cSOQOxmCy1/wSwWhsCqYkJBI=
X-Gm-Gg: AfdE7cl0BP0X5XZsyHeaveX50bGaK3fb1HenWwJI/2jW9s8ArrixuqPVOB53iEhsiH+
	nv6clpuUSTMMCaznxuz0wvb23m++W9RG4oiRdOv2MBgmrzW+n84CJ09s8IY18VpA1FN/mgb1eMi
	RRdnOqew9CiSBgFzc1GHDD5WXefupbNholMqaxTCF5YHmA6mapQA1OioFJp63HaWRlUsLjNyhAc
	33nRYZ8ZHCNnTR+90I23rAQ8hCLgB+VHwCrNHlAaKhLvUoE6A4YecIsuagSuYHuB54IVQhKKWiY
	SzIyCHgMsxvhrWTennsMYsRRX7w4kQi1uyvpWriIi0u0Z8I8dKAZM/k884Rivf27yTwWsunkUA1
	m5TMIL89gbCYxv16br0G/po/qMYxBGsZIxRH2RsyrzfIfJx+XQXwDRxZpd/f0gY31KzyrkOgtJB
	qMLg==
X-Received: by 2002:a17:90b:1809:b0:36a:5d43:2446 with SMTP id 98e67ed59e1d1-37df9f107a7mr250167a91.2.1782353319768;
        Wed, 24 Jun 2026 19:08:39 -0700 (PDT)
X-Received: by 2002:a17:90b:1809:b0:36a:5d43:2446 with SMTP id 98e67ed59e1d1-37df9f107a7mr250154a91.2.1782353319301;
        Wed, 24 Jun 2026 19:08:39 -0700 (PDT)
Received: from [10.133.33.189] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df3dfdb99sm771198a91.11.2026.06.24.19.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 19:08:38 -0700 (PDT)
Message-ID: <08d5009c-507d-4c01-b888-e28a8c76bc06@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 10:08:33 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] Bluetooth: btqca: Fix undetected error HCI status
 in qca_send_reset()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
 <20260622-bt_bugfix-v1-12-11f936d84e72@oss.qualcomm.com>
 <CABBYNZKx3+08Ajisy7-sHi0TZJNrbgzBzdszcKfiZUiNOdhByA@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZKx3+08Ajisy7-sHi0TZJNrbgzBzdszcKfiZUiNOdhByA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDAxNiBTYWx0ZWRfX8/xQ9DkIGeQ7
 ln7g8KTRgCP0eI2CynJzKpF69JFiUn0ggUIJI8dTBojrgRZnBYwAtM/5CMqux+gNaLXLPRIabPP
 XRbenBZ/VPMzRuGjvzokEV4PF7psCO8=
X-Authority-Analysis: v=2.4 cv=RJiD2Yi+ c=1 sm=1 tr=0 ts=6a3c8da8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=reVOoFzwNVHCOTdQRKoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: _x-5_7aBNcxv0K8FMNPr_9ySvHai9B88
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDAxNiBTYWx0ZWRfXxCEjL6veyH0K
 A0TVr65halBewY8cBPL3GTRA3q4V2L2c5rduRj6aO4k0SKHiLwmX+GQyuv/q9OcDbKJ9t0R5V5J
 3D5pXs2wNd4pSKdHFQxDWNsY09JTKGxTAFRxWqStlri1G2ZyeA7iuYSUhtlRnlQmMNYfFn9lnRU
 jRPjrOGgyhl7O9eIcC6RImohwMl6MwNO5vLahX5E1tYepojzK8zaXAjWzZEpPDLLb+Nrf5hEKHf
 PjyDbfZuUqQ5MvVct04CR41n04i3veUMrNEFosbtaq9nRWG2hpyLndjhRS1xTTQWgCo8pPWR1+s
 nwhMmFoWYD8zHLZWuEqHw2+3MCndt08CHitnpKEVpJwbn6F2qLjGkoGkF6uTtp+f64g8U3aq1uu
 sYyBY4FpWnpUm4K98qH36/N6hg272QQFBEt6ylPASzCgtYPutWno5ijnhOXDDG6zz9JneLv5MWb
 exv5yOoQsDF+PCD8r6A==
X-Proofpoint-GUID: _x-5_7aBNcxv0K8FMNPr_9ySvHai9B88
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250016

On 6/23/2026 11:15 PM, Luiz Augusto von Dentz wrote:
>>         u8 cmd;
>> @@ -990,7 +971,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>         }
>>
>>         /* Perform HCI reset */
>> -       err = qca_send_reset(hdev);
>> +       bt_dev_dbg(hdev, "QCA HCI_RESET");
>> +       err = __hci_reset_sync(hdev);
> So All the fuss about the reset is just to use it here? Actually the
> distinction between -err and status is rather important. The first
> means the command didn't run (timeout, cancel, etc), or it did run but
> returned a status != 0. If you want to capture both then you must use
> if (err). And yes there are parts of the code that test for < 0, but
> that is either a bug or they are intentionally ignoring the reset
> status as it is probably a non-recoverable error at that point.

  1. Agree: > 0 for HCI status code (controller-side error), < 0 for command not executed
  (timeout, cancel, transport failure). __hci_reset_sync() was introduced in this series and will
  be refactored to follow this convention in v2.
  2. Looking at drivers/bluetooth/, 7 out of 12 HCI reset call sites in the init/setup phase
  silently ignore the controller status — not sure if this is intentional or not.
  3. qca_set_bdaddr() and qca_send_reset() will be fixed to return the HCI status code and let the
  caller decide whether to ignore it.

  Will address all of the above in v2.

