Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB21E008B
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 01:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756259841; cv=none; b=lb0xcVwjW+eh0RsqQDU8RgRWwYD47U2d7D3NguDkRRIO+lppdDJfILz3g82IybzvyBvUvjEnxzkeYverSkGHzG3fBkgerMylJ482Z/dn/cuWIes9gCMg07maihQAIlQzRiG5Vkxhdcv2I5XUv2jSJip4Kz0RHPTHv0qx4DqMseo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756259841; c=relaxed/simple;
	bh=r+1XfEORO59jMquhV9Pm2QNKKblDliJN3+Zs8N+eN+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nqe+/w8453sAW/NAD8d5SAMpxE0z/owAQDQsuuftNVvqNm19tie+GZLNsBDpByVj3Gae1njdmd5A30s+mYOjJOZzGdh0vxtXXlJQSsKsjuLdWpic3jasQB0jlYd7HlRopeb42p1Q0ett7hTJQiD61rwupl2BSpHAypRFVJINmrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hU/G9xpm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hU/G9xpm"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QGPnEw002835
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 01:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tjs/w6Rugmz9OyiMttcxwIC9
	NEhSLG+c8hsBrGYuSRo=; b=hU/G9xpmmMKa/B7l1dbuor9QatKTA7g51k3EsaGY
	AndFvgdieGPhb2vHNvPjh87GOPcBfTr5eea5I7OL/jhJimUKGRbpFeld5Nj1MnSw
	VQphoYgkUBsx8L6+FDsIYSw+Mxq7nxvNvt9R7bODrALivkX9tVkRNFYQfCNAvDO0
	mGObapZUutJj4B558yEu9/kZcicrDscnO60arU4mTL7JsUIDYoupqxN5OuopbpOx
	UA0xJB3zqiZK890Mi7abQPI/3gEvkb8HTjFR/nW3wjRdCCuPab4Dtx9pPGRS/tI5
	pTP0j2fCze8MarAuet2OCgGXyz3bmkg2r8WXfDnnSyt8KA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpewasb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 01:57:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109919a51so268655821cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 18:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756259838; x=1756864638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjs/w6Rugmz9OyiMttcxwIC9NEhSLG+c8hsBrGYuSRo=;
        b=o1mx43BQFb6h7SkPLD1Y36dd7BwYRU/klTSv4ES08UvGxtLI04SF7vY4mXNOmlrm0r
         NCqKWbEcePaI2SQA22v3AqC03Yvb+zsXwGuNU6/BThhCa6uCu5s61xwPJHMkTzRy/ITy
         xzxo+3oea5QBXUWhAvZ+mLQeaDhgluE18TyiDhRpFRsif8FxnY/4/RY5CebT+xNP5Ozh
         VAWeulf4pANEphukvgGEnvxLtS7/TG4pF6Ntf6uz3/V0hD45OuVMdZ9etGNqn3AXvLKe
         SUcSD5vzrS6GT3FDq+tjG1f1VBUHUdwK7wfplX0li5D3dHo6EPxqgNoh3x8YXsoCAkeB
         fFTw==
X-Forwarded-Encrypted: i=1; AJvYcCUBUWk2SugenNODsygq0K5xMClxMc/n0SLjjLewN567FLPXdpuYGjGYi1qrKqJXwQ8FQ9OrrenVKQofIlOx55o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTbXVPEjhZuczkTBV7rHK/Z1+x9zCxtZPVgLWhsROl/y31NYUp
	agoAChAVUxHtbpiVXPGjNE+K6SKcdLN+mj2XgyslRp5Fk5ri1gv0WnxpRTNxFRdh/kUE9LNj2bq
	tBj+q0D1YYPU5FDRBNIp291zSiAmcoD+itV+EMUBiel5vNpPlkMiOoUe+J0Pojn5KyYdRFyTbTq
	1EFCg=
X-Gm-Gg: ASbGncvGT3e9RthuuHy04hp5QKgtFvZofBFYbPOW9mUG25GwE/kzFziwx3QRSZUAaVx
	S/Z3d2/x3zzmvYfR6dUacxGCrjTPTLaNwTBx8VRaJIcD2DNADrj7tTWtbUZU6Fd90bCY7995L48
	y0DLSuECjKFmqtzKhpBU9z94EkCbY8fc0BC4QNPRwNvWrBqZNmRrCZf7egby5DgFPYd28DCy4r/
	Ym4zs9huXOpgqZgEEEez1dLLH5nzOe2gJQj3bbGUSPRSyWsk9leBgxVjiTw2mLSG80bmuXKPM9F
	wehBNUYmSQDC9VBfmmKMc6YbZIdRuH7KU5K553eYiiwWK7XrSehrnyf9IpGrjqXDLsCOBrEEA6Y
	OseRk4Mq0s1qD0wxXLefhJQs4SF2QLv64T0u3fiseeePEPY/oadx+
X-Received: by 2002:a05:622a:5485:b0:4b0:e93d:8752 with SMTP id d75a77b69052e-4b2aaa6e4eemr227657111cf.37.1756259837766;
        Tue, 26 Aug 2025 18:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNcffuYMtkF0UrerifJit2fOix76wByWZmgmXEEbQpG6a1LmiRtbpsz46LSTWotCAlBbM17A==
X-Received: by 2002:a05:622a:5485:b0:4b0:e93d:8752 with SMTP id d75a77b69052e-4b2aaa6e4eemr227656911cf.37.1756259837245;
        Tue, 26 Aug 2025 18:57:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f52453de2sm296165e87.100.2025.08.26.18.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:57:16 -0700 (PDT)
Date: Wed, 27 Aug 2025 04:57:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com
Subject: Re: [PATCH v10] Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail
 when BT_EN is pulled up by hw
Message-ID: <lpndrvnjklmqglg22y7fnfeeyrp6odoedixosjc4n2jygeq4ve@ootpynfw5zvs>
References: <20250825113858.4017780-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825113858.4017780-1-quic_shuaz@quicinc.com>
X-Proofpoint-GUID: 52rpHnYPYTpTf7aZoqibY7RD5htss_AS
X-Proofpoint-ORIG-GUID: 52rpHnYPYTpTf7aZoqibY7RD5htss_AS
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68ae65fe cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=Xgb9nbmtQSVvgoRKimMA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfXxScwFHI78hnE
 GsZGrCzhpBBfK9l2siHAN50FYlTRNY3KH3yYPbG5+5BiQ4wxr19RLM4d2DtzQ5msENIz+5MdqE/
 FIRDk9elUhKAlMxrB9Bxrru4FDs9ahQQXa58qvDTLg5ugEXBUMHa2th/P+EjjVta1OQTnDTleQE
 bkQqz9jqR+sbQIjPRBtQeOFKOdfQ5Z4b5VAW8WGoeR53wdwmiMs6Wf80VEfzGw67Ho+j4pSqiGn
 LB3watsxv5IamQ590dFno+gpSlRWrTLGV7OuKRDld9RhtBglRPr8GpWlAeygUaj1KNTRT3u8qMg
 ALumx/ttpkUDIHQ0qY6sUrxGzi5b7EiehDXAEuT6Dn+4Xm+ObEMF1PZAwfw5iiH7Biznaxh2OQy
 CIEWAWOS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

On Mon, Aug 25, 2025 at 07:38:58PM +0800, Shuai Zhang wrote:
> When the host actively triggers SSR and collects coredump data,
> the Bluetooth stack sends a reset command to the controller. However, due
> to the inability to clear the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits,
> the reset command times out.
> 
> To address this, this patch clears the QCA_SSR_TRIGGERED and
> QCA_IBS_DISABLED flags and adds a 50ms delay after SSR, but only when
> HCI_QUIRK_NON_PERSISTENT_SETUP is not set. This ensures the controller
> completes the SSR process when BT_EN is always high due to hardware.
> 
> For the purpose of HCI_QUIRK_NON_PERSISTENT_SETUP, please refer to
> the comment in `include/net/bluetooth/hci.h`.
> 
> The HCI_QUIRK_NON_PERSISTENT_SETUP quirk is associated with BT_EN,
> and its presence can be used to determine whether BT_EN is defined in DTS.
> 
> After SSR, host will not download the firmware, causing
> controller to remain in the IBS_WAKE state. Host needs
> to synchronize with the controller to maintain proper operation.
> 
> Multiple triggers of SSR only first generate coredump file,
> due to memcoredump_flag no clear.
> 
> add clear coredump flag when ssr completed.
> 
> When the SSR duration exceeds 2 seconds, it triggers
> host tx_idle_timeout, which sets host TX state to sleep. due to the
> hardware pulling up bt_en, the firmware is not downloaded after the SSR.
> As a result, the controller does not enter sleep mode. Consequently,
> when the host sends a command afterward, it sends 0xFD to the controller,
> but the controller does not respond, leading to a command timeout.
> 
> So reset tx_idle_timer after SSR to prevent host enter TX IBS_Sleep mode.
> 
> ---
> Changs since v8-v9:
> -- Update base patch to latest patch.
> -- add Cc stable@vger.kernel.org on signed-of.
> 
> Changes since v6-7:
> - Merge the changes into a single patch.
> - Update commit.
> 
> Changes since v1-5:
> - Add an explanation for HCI_QUIRK_NON_PERSISTENT_SETUP.
> - Add commments for msleep(50).
> - Update format and commit.
> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

> +	if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {

Please. Stop. I've asked several times to make sure that your patch
builds. It still doesn't. You are still using some older kernel version
as your baseline. This patch won't build even on released 6.16 (which is
already too old for development).`

So... Please find somebody next to you who can do that.

> +		/*
> +		 * When the SSR (SubSystem Restart) duration exceeds 2 seconds,
> +		 * it triggers host tx_idle_delay, which sets host TX state
> +		 * to sleep. Reset tx_idle_timer after SSR to prevent
> +		 * host enter TX IBS_Sleep mode.
> +		 */
> +		mod_timer(&qca->tx_idle_timer, jiffies +
> +				  msecs_to_jiffies(qca->tx_idle_delay));
> +
> +		/* Controller reset completion time is 50ms */
> +		msleep(50);
> +
> +		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
> +		clear_bit(QCA_IBS_DISABLED, &qca->flags);
> +
> +		qca->tx_ibs_state = HCI_IBS_TX_AWAKE;
> +		qca->memdump_state = QCA_MEMDUMP_IDLE;
> +	}
> +
>  	clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
>  }
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
