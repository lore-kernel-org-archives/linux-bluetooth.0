Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6005828C869
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778030; cv=none; b=W7NGBEXm5IqiuZYIQ4ABiF0cmwQvdxjl7McGppY1foWvhpXWg9dNNRaRcJPTKnWDuIS09zQ2Gk84mJPtXDBRtu5hOvfB4jKcbv26wjJw+naQm/tKEXdq+DVWu9/RoDZV/M+mBFVFdv3l+/8N/jpWkOo1varDPcCoQxDFd5yIiNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778030; c=relaxed/simple;
	bh=qzBNWlpscVdbmJg/J6rGsGk0O5Ycp+YYPi+eM2d0F+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlbZFSRnIQfA/p7KXtbDHkFEXiH4w9DDjdlxttEtT04o6BWY6EBrJWTmBmgq+Rwhuc1dKZxV1Ntp3wgaJUq8ovafjdFBkPCxgJ9igCufwGLT0HB1X6IlJ/i0uXYYg10y/cGd1FbomZR6xDzlmCWGylUIuuhe53JpBzSp3cnsZuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m46tIWI2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m46tIWI2"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9b7WQ006994
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 12:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=L+i3kqjxsqUoIuvHrtmmUXil
	Y+sBbXOpRjrBG/uC5/4=; b=m46tIWI2c6vi6x/SMZE3Uo38JDITcbOLC9qzkAxC
	qbL1//jWPttLPYwqOsRrkcP/CTbt5r6nk3toov2WNYaCV0bIgVIf2MpQTvQ3/p4s
	SRYE2ZBcj1il2PG9+8BGO+GXDGhOSbsNydKDBwCNWunoJ2tPRgQ+YFTrMaeUWHHh
	lxtbZ3t80ckVkT38EIgZgoF+zfsBHWuF/UPw0SGlPP4vE+vN2JHyIZZlrbXTOKby
	AGk2iiGLyGIvcY1/FSxY+xYLdKh1orPcyd7Ri1PGEe2QUlYpIIQgI2HpXIhFGE2E
	Fx/Veo+uGKG5c48TXpqVNlJ6UI43vkDNxo7prAgqgxQNvw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5295bhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 12:07:07 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a88d99c1cso20459756d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 05:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755778026; x=1756382826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+i3kqjxsqUoIuvHrtmmUXilY+sBbXOpRjrBG/uC5/4=;
        b=N8njMnaJH92N/GOqJdBUy/xEgwuk8kh8+7L6Aw3EhbXkVDZDszmHQIsNvuQg/mikk3
         /QfaC7/kDkMxy7XRU9RR2dVNlfRVs+elyhS5ERQg9CPMxegQcHOrEMpwy0kYygy57alD
         Zn6Vqgv9Ao0Qp+z3l7+IWd8bIHjxjlvDEfub/9owOgL9LHfQHFuyF8oMKgujMAxhfMfG
         HEoRfgrsLmPH9gdT7VNYgEdH4RJbA1bmOWqgJRE0GqK4/Uexg+E+FUzd6NyZAfATsPyX
         d4p0plV3QzZM+v2rassasj5Ya3gtuJnawqTDKY5aJJY3dpEvssfjFps+Alqta7Pl8cQ1
         0eFg==
X-Gm-Message-State: AOJu0YzHVtIlZzlq/PcQdI9Dow97A0PGotnRe4wBDrJttLEXAeYWT7qb
	iKVhmxBAmR68vBm1w9ZM0YX4ptvaEnfaSvaIxT7bj/fzqbob/8GBgxfYfJ3hf6WNsXxgwn7j66l
	EYsjAf94KjsMod60L/8qgJSwUYQQbPqhk0afA+IyntQ2g96MWXl7nj/Hr2kUnSWq7ZEbbic1vzr
	z+4DE=
X-Gm-Gg: ASbGncszvqXCLwKQMZmVX9K41Ef9Gi0ihuYT557/27O8X+NGBvdefD3i/PEBTqEwgDC
	8fcus6QSgviZ5Wguhtj2gDBQ6FQYR8xxGWX/U+cyJRSB1/nismwwuLhdFqNFEZXawUbCW5lr7gf
	3ODbXI0tlh4Dvfj6o5YBXt9KUYNCL+y5sKgLP9Iu4RnXCmJdr0wKMKfYMIa3EOzHVKYejtzNr4q
	dvpmemodg6ULiHxkxg+a07DE09phKr+bJiyjS/btCjdBUBULMCG1WMVq29eFgDxacRkQLH3V72V
	k0YFuzREHVTkRp/mYrEoOOYUzwvN6/kN55taHq4244lbmXDYKKhwr7xAaq0C68WUfSMEaZNTw08
	0LfsKladXR7VuxoseU13VwNyRGHtNM/ijl5SGO63+/T/M1Qe8QJFH
X-Received: by 2002:a05:6214:1c09:b0:70b:be30:5bba with SMTP id 6a1803df08f44-70d8903da7cmr23067866d6.50.1755778025242;
        Thu, 21 Aug 2025 05:07:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMRLaAQf52g8SOhUssOoQ8VlQKa8/ddrNqZK6V2qVS2jAuSOxIiK4YGo0zUtLl8zfrRNY+Dg==
X-Received: by 2002:a05:6214:1c09:b0:70b:be30:5bba with SMTP id 6a1803df08f44-70d8903da7cmr23066776d6.50.1755778023901;
        Thu, 21 Aug 2025 05:07:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a43a4a4sm31679791fa.19.2025.08.21.05.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:07:03 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:07:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_bt@quicinc.com
Subject: Re: [PATCH v6] Bluetooth: Fix SSR (SubSystem Restart) fail when
 BT_EN is pulled up by hw
Message-ID: <5upyhx73s4cru2kw6k6yvhrmwkmmh5jf4y2ymbf3famabzxxlt@26sep775vbpu>
References: <20250821115001.2690706-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821115001.2690706-1-quic_shuaz@quicinc.com>
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a70beb cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=Xgb9nbmtQSVvgoRKimMA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: qeFbZkeCNobsfdxAxJwRnxb6JZzVXD4I
X-Proofpoint-GUID: qeFbZkeCNobsfdxAxJwRnxb6JZzVXD4I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXyV+acxMHnu/e
 7AGbKe2hfI6mFpgQeNi6+G6DuRUP7id4EEwyjKEOlnM3MdRUNZT9J8DcPKJRbv3xe9Mp3hJJ3w4
 BdaEqBlCJfyjA4qvQKBe5luXn1fWCrt2yfkEHzZyN0HPXkKJ1j6EdxQg43iovhjQYCmrQm3S0rE
 3/JL3OBYiIIlQaoBKys9n8DRwAH9oKlujnKUxUt+ASc0LwuOXGyKSkGxsCpO4RMDIwtzpuS2A3H
 LB49cBpXHgSRGjo/sZwqeOLpNrq2atXeffoctx5+++Y/YZwFlyDNGqJYd4eN3/tJpCahPaXxOB6
 pgPw2L9MA3pfWdltcSYo3CiRzZegNpwfiQ3xTGpvbxSY9wcclnrEnGK6XvJQy0g+WmX0g3a/oRp
 FcloP0IzJ9xCOc//6wX2/7bZk090oA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Thu, Aug 21, 2025 at 07:50:01PM +0800, Shuai Zhang wrote:
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
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4e56782b0..9dc59b002 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1653,6 +1653,39 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>  		skb_queue_purge(&qca->rx_memdump_q);
>  	}
>  
> +	/*
> +	 * If the BT chip's bt_en pin is connected to a 3.3V power supply via
> +	 * hardware and always stays high, driver cannot control the bt_en pin.
> +	 * As a result, during SSR (SubSystem Restart), QCA_SSR_TRIGGERED and
> +	 * QCA_IBS_DISABLED flags cannot be cleared, which leads to a reset
> +	 * command timeout.
> +	 * Add an msleep delay to ensure controller completes the SSR process.
> +	 *
> +	 * Host will not download the firmware after SSR, controller to remain
> +	 * in the IBS_WAKE state, and the host needs to synchronize with it
> +	 *
> +	 * Since the bluetooth chip has been reset, clear the memdump state.
> +	 */
> +	if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {

Why are you posting patches that don't even build? Which kernel version
was used for developing this patch?

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
