Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5460E238C1B
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570703; cv=none; b=VtlfrzNZCfGUpFfHzHju3r7UgEA4csjv0mRFxh/WzVkRkOJak64lPzv1YzHq7OeUyxyolx7icO99/RELTq5u6nvpbiBylBPAtZDtwk+oJfeHC18gcBOAf6dO53ot3esHwQPzDlQ/8zH3sf4MJIRYFWIZHqVO9oOdfjOnnT8yCgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570703; c=relaxed/simple;
	bh=i6H0SoP9g7Mh40PXCCzXn7OVTXXgFzI0ZkVY8YnTY1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGyR+p4dsHdp4xA9um8XS+Ftq3wxqJWQXOuhuDvdKWCdaByk6LNtfgBUJGlDo9t3j+X3TalEMC2d1lhwvXb/dIje50KyTvWaoXiHF4Q5mZSeXY8OoPOU0EEs7Teu+PorAjjew+GJj2NCL9m+2og6THxz6I2pXzA24CfShkNFL+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=arVCBPAQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="arVCBPAQ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F5Zd36024354
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 09:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xHNwrDHf6UIgXAfQcHTDVtmuWUsHZcYOAu9uyV9exEc=; b=arVCBPAQHFFc+Ihe
	JLN4Ltjj6AY/bXHGHJ8vJ0UqmRM9H4Ql0gmGss0TTlF2rN7MnvnR13fRQdNrPifS
	BJ1tEgheobAOhYRR4irr3L+1ZQai8KEJQ1dDdADuiDOtbqyZoBC0vMREKCW+pOkL
	4xkGt32KK2sCOC3rxcRKf2SLFv/V7gtpD9C/wTyfiHYiAnE36H3Bmm86CiMzfuBL
	6anSk/tE2Qyes7LPY2W0tcZgV3E8iiOwMVUxZ88bjzGk3n9/phS0f3gg5Iu6Afyg
	TJ4nC/wadvdo6sZoaTCxCRcqY47vwgcjPFho0wh4DUGGQhTE4AoWw4j50DPPsvhE
	2baYZg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpabf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 09:11:41 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7dfeacb6dbdso21648585a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 02:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752570700; x=1753175500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHNwrDHf6UIgXAfQcHTDVtmuWUsHZcYOAu9uyV9exEc=;
        b=Z2nLVfIWu2Yv7rfYyPi4RRai+aoh0fki6uXitn7jTNyJx6SOvv5Vo3SONjug27x3DZ
         wARmHE8tJj5l5yquV7YmPR8Bc6nCBXoPuaGNNaFKrFYLrB+R+YzXVs6IMCESX/VmAU/F
         3tXRqPYKpzO/dBcXlfi4pUNij5ZuxSVSViJfts9x70HxdPmbJJNsRfY6SXc09bNpAHHo
         iubYoMloppZi2J2Zy6LNXsXlP+MEl8h6/5ieTiOvnqu/Wo3lZDd6XRYDU5R4fdQFbQaT
         nTkAbj8bVMdjpn1FrOihEO4jHo1AlVsoIjaS0GIiI+qJZbZOPgkuf3ms1JNaQ832FYO5
         vUBg==
X-Forwarded-Encrypted: i=1; AJvYcCVC07FjBgcVZbMkJ5joTUFt+WRvqRN56xasXRXuxOlniO5BNL/MGhI6FIV0hOO4z9Gq6J7aqG67u8Imd0ik46k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtBFhkRYCSFDspYv8Ds3rS68KMWJJQ4LW8wg08u78n4+W2QK9X
	eBEOFa9gS3ic03xEcQL7GtQF2ey+knXxBLRj++szerNqjLfRage6zIN81jKE1+DHCG5j/EnRn6y
	pDLyAHpvT9jD3E4GAyA3uO6VbvYO32DHJxjcNrkyvsegIwAaZA+ofXomNcYO9pP39t4U6wZY=
X-Gm-Gg: ASbGncuwzYLgTWOO3OTDqKpq6FLPzqr0J2ZpNfqnEB2w8sa2Gii/DFrM9+e6TvQCdR8
	Bw0pfOC4pqlEAyjmT3cbiUv3kpFWZhg7d8RMqgcROTQmS7EsHC2PwclYXDcBAIU0DeTq094K8Ha
	CUmtaH6sR4wkazLFv5yZDxuQKhhwAy9kzTc0jZuu62KCaCEwTCtNNRFC+ICVozOVA9SuBwtl7YB
	bWg7pJ5Gh+oVEcZJkuKfkNDW26Kmh/9xMMB/NoEpaTPFhPJfg+MrOt5fS38KfHdZynUwz8cxitP
	MdhW3lRJfl3X+OfVclAOCRJo79wVmR1hu/JTmBmfM1FNLyVJ26lSta9JOT7iOFcubmKbTvXwFbI
	5ayjcButBQPZLI+zJ5ljz
X-Received: by 2002:a05:620a:269c:b0:7e1:1d2a:1224 with SMTP id af79cd13be357-7e33c7a6355mr40169785a.15.1752570699875;
        Tue, 15 Jul 2025 02:11:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR1aw9F8+kXl8naOWf8WjNqzukxHK0EIf4qjUMaJlCHG1KSJuHXl67oTKzisc1bUnW8qs52g==
X-Received: by 2002:a05:620a:269c:b0:7e1:1d2a:1224 with SMTP id af79cd13be357-7e33c7a6355mr40168185a.15.1752570699481;
        Tue, 15 Jul 2025 02:11:39 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e826452bsm980325766b.92.2025.07.15.02.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:11:38 -0700 (PDT)
Message-ID: <ee84aeb0-728a-4642-9686-3abb9588bb24@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 11:11:37 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] driver: bluetooth: hci_qca: fix ssr fail when BT_EN
 is pulled up by hw
To: Shuai Zhang <quic_shuaz@quicinc.com>, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: quic_bt@quicinc.com
References: <20250715051618.724475-1-quic_shuaz@quicinc.com>
 <20250715051618.724475-2-quic_shuaz@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250715051618.724475-2-quic_shuaz@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4MSBTYWx0ZWRfX90SyStZstDRA
 00R8kmTD5AANgy/EAxNZqAGcGYnyCo2wB1oany2E8gLu+fFfxBu0nZzFKkgMCK7LimGB/rlbGJR
 cW8X5paoEcvbhGXLVh21tpQtRYmR1HwgeymK5Iwwrh5vFruvo15xSnjGu7+ix549VFnORYAXjg+
 hpQvbyDw29LTYDjVXasTysZ+8A/Jq1oKXRbIWl9vYwVYafmu57B1Em6rMPyOJMRDuOLWicEMD4I
 /pYAEn7/8+c6yg4a5Td8RawmyOLVv7JMpefSIDJGG72u4DC3UqwJBv3eMSinfR0r+eFiBYIoJeH
 KUqG92yBQBUhkEeeTmh0X0yKYBK27KYUzaZ8tkDj+qRqiJA2msdCDl3AN3DiZ8TFP1Smfw9f86t
 DT8pxBKR2kh0RTb3ptJl4K5SbFp0TIHTx18eYg2bs/eRU+xeHRt1MZUFYZE8YzKoNY0+V+/T
X-Proofpoint-GUID: gdkaRMjRsE8KeC9vFY5kHXxzOgHjOhWe
X-Proofpoint-ORIG-GUID: gdkaRMjRsE8KeC9vFY5kHXxzOgHjOhWe
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=68761b4d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=W-2Lj9y8xAQPGZupIAAA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150081

On 7/15/25 7:16 AM, Shuai Zhang wrote:
> the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be cleared.
> This leads to reset command timeout.

This is a description of what goes wrong in terms of the code of
this driver, and it doesn't explain why you gate the code addition
with HCI_QUIRK_NON_PERSISTENT_SETUP, please share more details about
what you're doing, and more importantly, why.

> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4e56782b0..791f8d472 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1653,6 +1653,18 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>  		skb_queue_purge(&qca->rx_memdump_q);
>  	}
>  
> +	/* If the SoC always enables the bt_en pin via hardware and the driver
> +	 * cannot control the bt_en pin of the SoC chip, then during SSR,

What is the "SoC" here? Bluetooth chip? MSM?

What does "enabling the pin via hardware" refer to? Do we ever expect
that a proper platform description skips the bt_en pin?

Also:

/*
 * If the..

> +	 * the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be cleared.
> +	 * This leads to a reset command timeout failure.
> +	 * Also, add msleep delay to wait for controller to complete SSR.

Googling "bluetooth SSR" yields nothing, so it's fair for me to ask
you to explain that acronym.. it's used a number of times across the
driver, so perhaps a comment somewhere at the top in a separate commit
would be good as well. I'm guessing "subsystem reset"?

Konrad

> +	 */
> +	if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> +		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
> +		clear_bit(QCA_IBS_DISABLED, &qca->flags);
> +		msleep(50);
> +	}
> +
>  	clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
>  }
>  
