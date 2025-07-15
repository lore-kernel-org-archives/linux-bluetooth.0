Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D840275B03
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570774; cv=none; b=Eek34q4Z1R9GArGmnJZ2yO2Idb2nGaKUC0DbL5ReRYsh938Y/oXoLIaewIvkB3uSR0hS+9S1wYYqbsOCulbGPsi7+8dfbGX6rD9GAZaRgp6jPjN/vPJ1jv01e/1ca2FN0jzU38HgqXztmsZlkwtW10Nn59d4U0S6uiF7TRoEJfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570774; c=relaxed/simple;
	bh=nQBArhL1fpXczSe/0o7z2BgRBvZFm0FMWbtMWPTW/oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Af9LsvdrkC6Q5+/HEYrMdrR4CRVb3DIgtUSHSjK/7XhL4ipmqzZfrE0el32tw6TQhE5ZYuJRnirzIwG9gvRG8zLTcDlm51zlpa0CdlyBMvITcnkS13fqDCBO172uMddsfvX3hGn1njfi+EXVsD62nzoTievDF5YcQpvsKxByzEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZJtfPuBu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZJtfPuBu"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F5c7Co026351
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 09:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v2rCrP0gitYkz61kp4FaGz7nVfzNXIt3MBJTuyV54Lo=; b=ZJtfPuBuxu4xWIB4
	TJLMba6vSPa6JAikg6E06A1I+YCdrlTyzUW52BrroqkX9Fh6thGZecK7jJtaS+G5
	peoKLdOmFzQmqp7ujZMevx9m+UUtXEDujm3KiilxWublRNxI3EtJsnCWzgncEGZc
	7CI4pxeg2xiqR+yFRIX8gLaAVTxP2FHKFnenMw5VvJfTEpMkgJ1LV1UamEVUPV1u
	S23C07aOjpSyhoqtqrq0puFzF4Gfvg7RZvN01kfioW0Fp2K2Get3lUfUvs0F+K/J
	AKQTyii2m6k7f3w/2V+YmUciu36RjpHvvv7ivvAB1o3DzWfPXDK5cwtxS2TEcWDR
	juTC8g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drjbq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 09:12:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab5e4f4600so2935961cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 02:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752570771; x=1753175571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2rCrP0gitYkz61kp4FaGz7nVfzNXIt3MBJTuyV54Lo=;
        b=M4xzdIQf9DWUdknX+pj4gbq3B7mpx5ilqttpn5yRwLsoKP2gYQpiWELrZdsbj+RxOn
         cQMLfI3N+GPR7CPSw/QOQxBxV++o/boiS0uAEHJqqheYBg3C7Y5EtILyGied6wyKDkua
         J9OqYRPMXKRdH+My0fwYHqhNAzHUPu26nKx+hC/GoxcN6rBwfocQdGymjBN2TqFfJBLF
         MgQCd39umu+uX+qfp9TiT8Ie4CYVgcuqOu0mEjIrM1dsNFU0QTMczWl+8/+lu1rexeri
         SCfuPrarv+e2FF53w/8mmhEwEUCPcbSaJnOSIubuqj2Lnkc/5UeWFxhYwtPzDB6GrVTJ
         ttOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXebug6DWI9pw87M/pXorVbURrFApN+rAP97z6bPf+jafvaktGF8V9BGtE7YoG586zESOwtO/QSycd/sg+9PlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQbQTwyUhLjVuzH6xuBs33Iyf5gNrwzjo384hmL5gecJYQH2d0
	TuphpNODPysLOIyag31IjnwpQ7nOtY0FD2CrUhGtoMbEBYtbkyBfrr4NoFr4TU3ZfOGOQ+/sCCh
	TqCds1SDQecIUGn+9LmdFUVUY+/EUfsI4ojnL5FV+p8FvE129sIS9XBuKuKpzHOW08gFZsCE=
X-Gm-Gg: ASbGncv8crN9jd+KyntYRyZIf/FihKKknokVazh+cDO4EiCuqQm6XU2Mbg+7vgCoD9a
	Bj6QPFmhljHgB9/CFUGovNBwaqL94yxeY+1cl5tZlzdVit3mNYf+oXVDw4d7a3NDAframpwTO6w
	hQLqPE88NSUFPHMlUCHkbVHI5qDtCwB++hpGzrFNhVjqMR4vGQsOhtYsldQ8YR6MNICsJCXy6F7
	hrFc5RjwzuQz5US4zDk7qY8Qf+LgF+IUV5mhymuRCq1LCxj7416pEl2uMaEwbMcUUBlLKwl1Lfc
	aLxdUOMq0YlZH95WYyKnKq2i/ZZHPFoWABMnLBvEk6kGKtLKNWnAYkrHC6GR42RB1CNGMY1Text
	LvCFM+ds561RXY6UbFtpF
X-Received: by 2002:a05:622a:4a08:b0:4ab:635b:a309 with SMTP id d75a77b69052e-4ab86c9cfc2mr5190331cf.0.1752570771099;
        Tue, 15 Jul 2025 02:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzWwnPodE6Q+Kq7WShiNEjqjIhyPVP6HIt1NVt2xIwm4w220wZPwscEj953VSTSXm27X71GQ==
X-Received: by 2002:a05:622a:4a08:b0:4ab:635b:a309 with SMTP id d75a77b69052e-4ab86c9cfc2mr5190181cf.0.1752570770632;
        Tue, 15 Jul 2025 02:12:50 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82635aasm951769066b.84.2025.07.15.02.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:12:50 -0700 (PDT)
Message-ID: <2df40d26-7874-4398-bc18-0122dd197c90@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 11:12:48 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] driver: bluetooth: hci_qca: Multiple triggers of SSR
 only generate one coredump file
To: Shuai Zhang <quic_shuaz@quicinc.com>, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: quic_bt@quicinc.com
References: <20250715051618.724475-1-quic_shuaz@quicinc.com>
 <20250715051618.724475-4-quic_shuaz@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250715051618.724475-4-quic_shuaz@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: O4cqPOH6FgnAd56MIwkVO6GCBds8j47j
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=68761b94 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=SXdkGL_ce-MxmC-6jFEA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: O4cqPOH6FgnAd56MIwkVO6GCBds8j47j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4MiBTYWx0ZWRfXxy0IYk9G5W2K
 MT9i+8r8ng1zdMi6YXNZu7IZl2yYUS7Z9Js8Ro0pg53PFSeTE5sbAgYBfZynU7N3gzPc1jxR5xg
 HSf/KFMUu5Tu/xwCEJmgkarEZgGmrdyJTaF6DOeD6HCdISAhQGg5Ls4A+L4ekhB89c/bzVpUQMo
 kWAXb2n72b8T2pw0I0HLtctwA8GL32UBV3ZBfMG3igso+Y2Dn6n/phOPsvzilbwXzs4LEQCx5w0
 VGG8w+yjjwYvzXw98C7Roem5LZ0H2iEgxZN/jePGYG4DfrQ8aOYZGKNSJ5zf2pwAIUgCSk5mqwK
 +HGcsG0tpKmlgh5fNxPErHdFpxvgq8DuHtz9QyAa2u/PZc0MlCUsKGeEB9Tx0CBaWg7B2dI79/+
 UO/dWrOWcLbpdfGgQX6OEY4J/Ts8k1eG/eNZjqK3IvYDQRvfo4KqduQhfBKwAmhIb7u+93Sz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150082

On 7/15/25 7:16 AM, Shuai Zhang wrote:
> Multiple triggers of SSR only first generate coredump file,
> duo to memcoredump_flag no clear.
> 
> add clear coredump flag when ssr completed.
> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index a17d3f7ae..e836b2c29 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1661,11 +1661,14 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>  	 *
>  	 * Host will not download the firmware after SSR, controller to remain
>  	 * in the IBS_WAKE state, and the host needs to synchronize with it
> +	 *
> +	 * clear memcoredump_flag to ensure next submission of coredump date.
>  	 */
>  	if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
>  		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
>  		clear_bit(QCA_IBS_DISABLED, &qca->flags);
>  		qca->tx_ibs_state = HCI_IBS_TX_AWAKE;
> +		qca->memdump_state = QCA_MEMDUMP_IDLE;
>  		msleep(50);

Same comment as patch 2

Konrad
