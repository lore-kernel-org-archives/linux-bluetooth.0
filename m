Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26422FDEC
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Nov 2025 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762723210; cv=none; b=unQAtRvrp9iMYGXEXVz/m6iov5n+QoMYTrYdfgXJ99OagOXF9Sr8dnMaqPQ7KflCN0RmNXggAHkmIiRotwy40iEbnxzvSK/JYEryKk9Unm4k/rsCClcaQyXkTnYk1VajNmzhAH4KG/RKipSDTgCEA03+/8BuHFSOLRxoeQRY45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762723210; c=relaxed/simple;
	bh=3kLuEtqOYFVKEThNqmDGAzD+Sfex2UQnxoC+sk8K5NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNSef61dkNsrv5qXXG509Q439idY3zL1C08HSlRAoUE5x6pld3uiW/Szg/TUi8Uy32yXCkfAF0o2h/T6ttY7iXnIVP6irUqIPLyX9OhuuAztyFqXdo9xlrOMqsr5k51GBeelrzHUXgxkxOZHqMEyVvVirOOJwpmYJTiK7tPGrYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dwx/yBFK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NrOe3H9c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dwx/yBFK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NrOe3H9c"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9Hc71a1144629
	for <linux-bluetooth@vger.kernel.org>; Sun, 9 Nov 2025 21:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pbVsXejt6h39ywCxmkDZ92ta
	+Bmr5io8nWG70XNXbyM=; b=Dwx/yBFKPv9FIkUU8TOmrtC5wBVk1ViYs9PF/gWB
	ClkIPlZTPm6aUYAQL/zdhOFrGAiBNjPJlnPCy8kj6XBVXhdDtW6ZkBVj3pcZXGq4
	toN8NOkNE4c3SbQt3hb19yG5AnjwrUu1DCJHDlE8JF/5L6uvtUgK5LcKpIRE+Ngm
	t3Ep2M6pwJ/9tCEi6SPCr6hjl+y18WJPEL/CXqHlQJWsQYOA8IXKT5otvdU0oKV7
	yEVI4P1VQdrEfcSyyth/cCdZzIUAaKtBBfCypIn6xRytxKMPvC2IfNUJqofJpIaI
	rHBGxVqYIm16Fy8xUY4MAjj7NMtb4FMeX5ZlDaLRlssJnQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xvjapee-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 09 Nov 2025 21:20:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edb7cbe452so5036801cf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Nov 2025 13:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762723207; x=1763328007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbVsXejt6h39ywCxmkDZ92ta+Bmr5io8nWG70XNXbyM=;
        b=NrOe3H9c8oFnsu1VF/QCNQfvNlM3WQObKCtnLp6kRkDMcCiQPumXjari7QzRIuJYLL
         iAF4Jku9bFXRWACspmMGf133X4qotHw/XZPKds91qIM/+cCedpGtksPq4ExdjyNuSgKA
         3MasZjbss8SwB35nUJWxi3JY+M9liD9OagaVCcWkUbSrCTcJyEpYnT5HZPEBNNssr2ms
         WvLbouO6aX0di5XlFZPgwgg/WSJpOQ1cvpTEQ61Okb3HNGoLeSP1X2EGJuMG5yfLruHE
         wRmUNZsvZQlksZA2rkMwoYran2cayzxE907arZGrZscKJgEZHnSb8g+ZBbcqBSlfcc7d
         gJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762723207; x=1763328007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbVsXejt6h39ywCxmkDZ92ta+Bmr5io8nWG70XNXbyM=;
        b=bT90gbjhndU4AAWq9B6Qy2KJs3sOQPdVFCpzlyjagAOKta9WTsVwIZUcJ1Nhm+M9EX
         Qzsxi9AsSImbBCfD5aEnfSiWcR9/rPOLtFwZzbH/mxXWO522hKI/R8aoHAU2pOOA+dZ9
         s1R4bQIwOMoHoaLIyb1Afv7ypaTaZCg0pF6Vv9cQfT8s8+wXA5Rbr/xrd/oKC2NIrPjF
         Ephbg/TjA5Sgzqx1BQQLF9YKvLAoJdmxLLoSP/bNeeHNdF1rmqdu4urD34gFWXs3x9MV
         xI8XS2bsH6Wi4o0s9dJAogGCkPdH77B4PwwsYYCz+d7fhtNvhPMPoCLk+4VJXwDRMYZj
         kptA==
X-Forwarded-Encrypted: i=1; AJvYcCWJJfbsu2AGneJ08kwP5+MfhqJk/Hvxl6nZ/RvcTkNuD6bXk96obAQ6nmbogyRO6N/CKe2uKMSE9WKa0wuEljk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqT39QdQ79RryN9XQmlILk9Be1BZ+ERY+yKyYraw8Vu7mf0nBT
	wzs0bfcWuDwDcrMlBlTMajQFTG2okyXbw9YM1HoZ3+gXdFXNKcHKcaMAAYBuJ7UwPjyPJA7Nw+4
	hcv7tCD98KGG/d7MYH4IlKjPsCO5cKPAQB2F/X5eohrV2YlIbi/bpzVLuIHQA38s+odF+GK4=
X-Gm-Gg: ASbGncvO800omdeL6RlIpUL9ylFEn0i5mDwjiCDlBo7xjxSwrIny5XuVQY0BUYf7jqm
	/ECX/wvxdHzMi5rtn1N1JUS8v3MV/+5kHi44H9/mgMwnoZ8VhZ32zd7Y9gkJKmRqpQrhXVok/9U
	klskaqVvERXpPH7vk2SVVZh0OsfVt9HsxoQ7gh0eoOT0fRdcODSvZTLSiKEem1ASLzNSstAMwbs
	CaD9S0WgwTQOAV1XxvE0EQLNhHGlOEzY3p9BKewpvYS3a3EYUcyD+vfyRFXf0tYcezTuJD1Guww
	0VfWZ/mjSrms5neRaclfUp7DP3Tr2PK1T8BZoVgFNp46HpKgxjsGVEBnWXUFBrTHPe5g/5h1rkP
	rU74yUK2FUaqj6sDPzq6fhVhhvdyyUVWu+7oBrEiRTY4MBPjbBDYeOtOhI3adE5TJVWPrltnMc0
	0bk6bzTuV7SEbJ
X-Received: by 2002:a05:622a:1391:b0:4e6:ef26:3152 with SMTP id d75a77b69052e-4eda4fe0d46mr74479301cf.80.1762723206726;
        Sun, 09 Nov 2025 13:20:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYVBQScxAvnOfUXqgyJ3sZSK5uT7+bzU0vnJcBmWRUuT8ax0C+UWHx2AcA9vXBjJQ5A/MiZw==
X-Received: by 2002:a05:622a:1391:b0:4e6:ef26:3152 with SMTP id d75a77b69052e-4eda4fe0d46mr74479011cf.80.1762723206344;
        Sun, 09 Nov 2025 13:20:06 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a3a1c2dsm3412544e87.84.2025.11.09.13.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 13:20:05 -0800 (PST)
Date: Sun, 9 Nov 2025 23:20:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        quic_chejiang@quicinc.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Fix SSR unable to wake up bug
Message-ID: <lfvc5ndd6sb4hpgf7yxnajve3ipiptll52lzxjomjfpkjba2qk@3lgl6doz5tvc>
References: <20251104112601.2670019-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104112601.2670019-1-quic_shuaz@quicinc.com>
X-Authority-Analysis: v=2.4 cv=QuxTHFyd c=1 sm=1 tr=0 ts=69110587 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=NZlr1TM-Zul8l3pKAykA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: bjVE2-x3oVsXgpgo_CCJNyVvokmLPhvz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDE5MCBTYWx0ZWRfXwmwRnmUGF7It
 xmTJPz+np0bH58yZw0tnSktiC3GF6bjK5Jmufdw9G1417lFDn7WUsaXtHP+DjMht516CEWu/PX9
 TCluog0nzGs0goRXdQHkEP0cWpgJ0HncsZ3O9QopOkSW4juknXcoVskdYR0FPcvB2oPg2F0QnXz
 s7MggXh82lD3wBcsulp2gJwDFmtK/zH8tc/ba0B8Jz7mRNz1HP4sw4CU8rVe6Y6ok+cdA8+LFSc
 T8dhLfLea1e05dBUlsdCfX+hrcfUwnqVV8EAinjrdSTt586jxX93GlU5GRKaneF64p//PPrK9ze
 GadKOrVwNMGFXAnPPaOgtnP9rzvvAiTO4pO4ao1E4E6gOzSCicSM46Jvj0pfwMW5iWcxCDkxlrt
 cxGmR0qU3QiOrzyOJTHVdgwRmMB0pQ==
X-Proofpoint-GUID: bjVE2-x3oVsXgpgo_CCJNyVvokmLPhvz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_09,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511090190

On Tue, Nov 04, 2025 at 07:26:01PM +0800, Shuai Zhang wrote:
> During SSR data collection period, the processing of hw_error events
> must wait until SSR data Collected or the timeout before it can proceed.
> The wake_up_bit function has been added to address the issue
> where hw_error events could only be processed after the timeout.
> 
> The timeout unit has been changed from jiffies to milliseconds (ms).
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>

Missing Fixes tag.

> ---
>  drivers/bluetooth/hci_qca.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
-- 
With best wishes
Dmitry
