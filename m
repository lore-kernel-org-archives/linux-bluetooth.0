Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B02BE62E
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886914; cv=none; b=BVLkS7Y/9wCdjhz67+4G2r8kNrWsJEGmh3C/3e7Jl8ZuGUHQbPf7h82hfWg07aXPyCSUFmjsSBeBs9xeOeafv2v1X5olxDgctn0fRDborfIKe9aMRfkmp5LkVKpQ4DXpLo5J9u0iAaCP60kR8UIvrBw1KMjUeu1KnYHGiOHwQBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886914; c=relaxed/simple;
	bh=XnfyyBM6Pz+Nxj3ytKVde+CXgWpxq6tYu+r2xS+ravM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qj5hJ53QQ9sxjAMJK7zCa3+eVAUxo8gVjPmCvd0zzkRHffjApuxyR8zNS8rCdXpiXvVujmwHxKBI5jdgq4lX15EiqjaBWLQ5CoxOxKfROYvTXXnu9pIJFqdEFMNY9g4zhvqFaTEsGSLJEDoZQH2PmFcxY69w7cAFUgydTt0syvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WsHZD8bU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WsHZD8bU"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MHZuTI025810
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 18:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=z3XjF/GiPBvLacOcQzaE00w+
	swQurw1OEiUWR3vIT3E=; b=WsHZD8bUiNGS77HfTwzv0EQtuW6ifmDmqfUy3Eiv
	rObPs+LQFsS77HSBCwTVpwLLjBDlC1G9zS8Q/JgXbd/tO+5aOp5X0qgAJKubzx59
	mNA4sM36AcPMyeAnAsGfsxBALIYYuDSTnsWdQJ8TonyZXQ/D0sVRsVrh8lPY7dcR
	T/FJrvhC2dlna2o/DNS42kftjrksAu+hPlB6W4JXr2ErCJyh4eV4Ej9T5pSfrdMZ
	BJhJ3tOFe5xG4fu5EbJnMMkgmk617Zk/d0CHRV1UisvpHNmWW+rDGcwsLZjzUV49
	xU30ssrrS7zUbFFuESZjv3yRwR7T2u/UlhpPVlTVTSLbrA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48pw3cg4c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 18:21:51 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70d9eb2ec77so13183026d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 11:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755886910; x=1756491710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3XjF/GiPBvLacOcQzaE00w+swQurw1OEiUWR3vIT3E=;
        b=ff+4bMDMiGF58VG8s6+owulbBqcChDLagZRc/o6+aEuwxFs3Kyc8VEinZWNVWiT5nm
         qvcJ/I10S4bCFNMvpVIWUFvsrjtY+cIXU4bpK6LAsl6QBMYnp9P7KothQzVs+5tY841b
         Z1xr3BI5nKTYq8zqGH4dyfSMU8QCPRgRNDS0+avhJV6YKzIGRXvYl3lsVJzK83y1IbWZ
         narcc/Sy4bCqbigqDdGjFRzKeqvjzVjrO1ALUk7oeNAEgEZvMq2g3GRq5KAIbp8OX0dy
         d0aXKg+PFaIeGuRXaDQjRpUURQOn3Vi0njJ9LIvcYUD0vLQLgkpU7DrVQvs6boB0qXIR
         /ybg==
X-Forwarded-Encrypted: i=1; AJvYcCUYlwgpCPlg1lmzRhDYra9wjE3pGiaL1ydzWxvKVr/sRfrwnrXGMkKOe1WpegIRzZJq6kzNuE4JG6Fc88bPzCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Adh2TGMKCl5HiU3EaIK6o31HoOFkruF/hM+C6PtzR3pxqd58
	uzBgSzE2LgwuD8j3jS89UxFY1SF+iPpn9uiJivbtz+rja4y5I0Uu1BS2p+A6T4wsV60tgb4cBNX
	oZ/PSVqTX4S7Iu/7eCVHjXfqWJYqxXonF+vVwHs+nvH3ZVzHAiNGM53baX+BjSMYS9WLRl38=
X-Gm-Gg: ASbGncvmKSbUGzcgLQpduF6AZaVrItbAzzBVTn2CyDeEdyaLV8ooeFuX/m8iDNrS65+
	ZONbqeufC7JoXEDNoUaymfYIrJ520llhBbF8qpd7rf3daJBiwvgPNcgtRBokITh4MJmdltzcLvr
	9/otd3yKy0QuVMoOdzugxqLDv5kN2gwF8rrBv5fwxT8TLiVE7jPNRto8XpMesuHywVvUhalZrd3
	d7o6/VOedqdp8YDPrwExCp29Wm/TPYIUZlLZT4j9AaediJTiRCg/Vgi9jJqmiW/0sxtI0zpL5/p
	jBPc1f7aZk6hisV6syb1jKsWfZXqZtpZdrJNd5zYEEE4aSDLp9U/EX3FrPMRbyejrbbAR/zmvTm
	+vW2lCcem8dpyGQMJ8eTzIQxVMhR47EFbHTLDsk5z+8vYbhuCnHHP
X-Received: by 2002:a05:6214:2a4d:b0:707:4229:6e8c with SMTP id 6a1803df08f44-70d971f5efemr56637106d6.12.1755886910427;
        Fri, 22 Aug 2025 11:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXxaLnv1Y9uAXo5cfUz4pwJXUczPdAECaz58MIxnRLI3/YKXEsleDUu2qANw4OMZIlzAK5zA==
X-Received: by 2002:a05:6214:2a4d:b0:707:4229:6e8c with SMTP id 6a1803df08f44-70d971f5efemr56636626d6.12.1755886909861;
        Fri, 22 Aug 2025 11:21:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c8ba22sm86692e87.100.2025.08.22.11.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:21:48 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:21:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com
Subject: Re: [PATCH v8] Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail
 when BT_EN is pulled up by hw
Message-ID: <eg6hush5t5r2seelkolmb3hqjlmh7w3yzekb3lnn4sm3qxufee@e3eberzr4izp>
References: <20250822123605.757306-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822123605.757306-1-quic_shuaz@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE2MSBTYWx0ZWRfX/2ouBApz2cxY
 pdpSPnzpiOcITXe/TGaKcqQiY8Fa5wML2y6zaJuTwQgsxl2srriGBpSLNcu630bi1S7rU2j12yi
 1r3M8AEuQwX4jsNkbE8EVdX5VuqToj2XVxSVbMH3ONI0OL+Y3j2FBn55Q4OCHsyKeFt+Xn6SEqv
 gyMFn4kjsjt4FoqrvKc4fAE55vBAVVI9dAQ5tRm7/os6jDfhtHFuo49NiGuPCjWJ9GQ9qdFrAfc
 iXO5YdNHF0yUe83m2j5XbTPO/N58DSztU6VtXXFr1CHS1iC8amRNFmPMA58ROjMMcJrnYh5184K
 SF2vVAv08pIl27btzhlSFD5KSJc+eDZDNmHyV83dMZCRivGWmig6UoCUFsjcFz8aNHhHMnQtwp4
 U8H+ihc5
X-Authority-Analysis: v=2.4 cv=EJ4G00ZC c=1 sm=1 tr=0 ts=68a8b53f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=Xgb9nbmtQSVvgoRKimMA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: AFiB3Yw39YCzFdaFZEun2W_6_HOdxJ26
X-Proofpoint-GUID: AFiB3Yw39YCzFdaFZEun2W_6_HOdxJ26
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508220161

On Fri, Aug 22, 2025 at 08:36:05PM +0800, Shuai Zhang wrote:
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
> Changes since v6-7:
> - Merge the changes into a single patch.
> - Update commit.
> 
> Changes since v1-5:
> - Add an explanation for HCI_QUIRK_NON_PERSISTENT_SETUP.
> - Add commments for msleep(50).
> - Update format and commit.

Changelog doesn't belong to the commit message. It should be placed
under tripple-dash.

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

Still based on some old tree. Could you please stop doing that?


-- 
With best wishes
Dmitry
