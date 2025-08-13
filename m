Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59E11A9F9E
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083521; cv=none; b=FNIcMnhMvU8FE7st0uCZ/GxApW9VugSGyJyi0OEB/o0vJ/7Y1XX74WXONL+/jYLviunGY9t+NIKGRJ4QYQZTYJ4iNYEsOGsJX0yzuSJ4dCfgVwZXgasxrLkGmF0KgwDpRm4fdmTVQMQqYuulCTt5YUXsbdRvusr9G7YloYBP4CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083521; c=relaxed/simple;
	bh=aG2w3++GlP8FSxeSoENjbAw7qhESeS7SNMbbt3zHZaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quEaLozD4h0dEl0bGasnM9pf7s9fvf8rtvF4ODa6RTP0BKXccMIp3PRSGMigucd2I3ECZVmn9AxytBvGtvO6F6zFT+/BfWssRyCsgEJkW9fpaW5xRNoY9HhHIr0/n6L5pD0+95qDgi1gUUR5jHsUN2QkmkehrPSEkVTAwqWH1oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aSb5afW6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aSb5afW6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D9f46g022312
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 11:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9a9/MagtEYxspNjJutJnXaxyzY3EaY4+0V2FdsH7W3o=; b=aSb5afW6Ybc7nlEY
	L/hZ0nKvek9Z23K7wqo+FjtFbM9scDaGIBymaSmjwPyZu6hNucVvJzfSwovoOgd5
	GJgZATVmQY0sHBrKw6tLlsnCLWkJFIXCE9RdcGBR1DMp6rZUgswFRTiWkMrUTcJi
	xngKQna7HbuhdafDXfQb9/yL1XouXoOHBl18b0nG3wMLFyHaJy7YwpP8r1pDzRmL
	KDwYiGHiKvBpnxTw5ZSUOx/3pVhyPk2Z/KsrDBGgQWYxzdQ+wbSjaQujSbmcU6tj
	32snPoi8PgHmBPT7WfAG7sH7sqGy1eAHak9lX5CLperQ1oexOWVudeWuPsgz1CpP
	x4g1Dw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48gr9rr7sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 11:11:59 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b06ad8dadeso16460371cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 04:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755083518; x=1755688318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9a9/MagtEYxspNjJutJnXaxyzY3EaY4+0V2FdsH7W3o=;
        b=KrBSwwdi2FdSSSII+SLO4nTC2D3bVVZmWRcSH3GbfAwiZ71xlEKzEKjoSNN6oPxjNG
         IJZAYP2PJhHtChS82kHp+Oad1bimW957XUZ4mDcO4AQhtgaKmpqB82Dn5OKYije2Lap7
         mW/cr+8TNxRmVRkCVFmRTORKK0ZPG6/QsXADK3aA2EAoc6dFw7l6sJJPpp2r0rCDHrNN
         tion6nm4flVzpG2d5udUgV9z4znEgQxHUauoNBMtvKjgLul49dDhe+3F2Z45rnu+Av8J
         ukJPMa1G0pAwiNU7Hvh1BNWSVeQv/7A1r7tf7P5FmGZl5GriuFKwy0qx31Nq84Sot38A
         vSbw==
X-Forwarded-Encrypted: i=1; AJvYcCUaCMOLRhsSPHqtTaF5UKfNG0MpRDqFZNjRMQnXdIkxtKDEX09oppvu9HZ/2tF3Hm+8n3OAd0ozLAJNqhD2Obo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTOerLdyycGB4L3TcJpyDrWhHBq87MhUFAj5XzUMxUdgHk5d4f
	rrStQdafKbMwbD/eZlvG8oVPkfyPuLRE7rjOyX4R5SNQRiLiRjRr/bt6EDvqW/5sHnZnHVOZJGX
	f1TyhNAP55Rz4OMSiPWewfUcY8k75oqrMQCEf8NNAMvNb6Rjyou9Ui3Ck8b/hF1C6+xnPo40=
X-Gm-Gg: ASbGnctYW5KZcDnCAnBla7XmOZkzx/hR2OjKA7XLpQ37Y0i4UcTjPTZo5NVvH4DvL8T
	CCSOcSUbwL7d05sOiFCRKUru0KbwlvLRr36CnUNm9KB8XwLKuon61mJ47Vr8eyWq2IN+yriEHgc
	hbEQHOcbpY9wJntxbfXOPpUhdsMdn74xgtbDbQLkLTmA9765KNFDJOt3Sb1JlWPnlwVD/9BdgA2
	mz6zrmz5QEM4A6bjtjn22dauXvJcBd5FlqfyReb9VeIknocGxDnuhp8fuXWno9eBI4vvdJnJTRH
	r2YJ56AAy9EWL4JB6k284mdure7v0xnns4u7ceOLapLID/VYxLpjS1oT5LZm5ZSz9lTrCXKq/Kp
	16Mdjg1Km7/GW1Uu7+w==
X-Received: by 2002:a05:622a:1a03:b0:4a9:a2d2:5cd5 with SMTP id d75a77b69052e-4b0fc6f6340mr14072201cf.6.1755083517536;
        Wed, 13 Aug 2025 04:11:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9hv8At2ld98/A++aXSCzw4i6XuNtCjRqkoFXv7OrvV7SHX95KyS03qs4FAEk7hoguNfKeSA==
X-Received: by 2002:a05:622a:1a03:b0:4a9:a2d2:5cd5 with SMTP id d75a77b69052e-4b0fc6f6340mr14071941cf.6.1755083516907;
        Wed, 13 Aug 2025 04:11:56 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e820asm2371584066b.90.2025.08.13.04.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 04:11:56 -0700 (PDT)
Message-ID: <5c94849c-88af-4094-8967-c3b04d33c27b@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 13:11:54 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] driver: bluetooth: hci_qca: Multiple triggers of
 SSR only generate one coredump file
To: Shuai Zhang <quic_shuaz@quicinc.com>, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: quic_bt@quicinc.com
References: <20250813033505.3868781-1-quic_shuaz@quicinc.com>
 <20250813033505.3868781-4-quic_shuaz@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250813033505.3868781-4-quic_shuaz@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA5NCBTYWx0ZWRfXzzTfMQtsTuN5
 8TQSViQXafgX4w1T4hPFH/Pplzh5mbSUustTwdSjtFzBEb3ypBHIGwB5ZH5D+fo1SNAl53wPcj4
 qJGWI18jkirHYnC7EjTdgaeHtHHkNFvZFb470ZgA/swowyRnKSkjnBC+vxKNFPNoV54HOg+Vo86
 3Slb5UJctwtc067NIz0BoJWXimEtyEnXRVGy9/WbVH2NY7AsRm+okn9L3XjAXnA8odVRUp5zCQC
 39lpdL4qLjD0QwXumNcT4rO6OmujvJdiDzrHpwdXtt+1HZBhKqYSuQMX7aXmQO2jPMKi4Gb6hL2
 gG1+UUrqEFdaFeZljX4vak9rKOmh06PV7I7nIu7alpM12ZvtHnXjM83uza1G6GjfmMohy7Ift/s
 Ni3CeH0t
X-Authority-Analysis: v=2.4 cv=NIrV+16g c=1 sm=1 tr=0 ts=689c72ff cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=MAoXZctyg3N9BN3KD1oA:9 a=QEXdDO2ut3YA:10 a=D0TqAXdIGyEA:10
 a=xa8LZTUigIcA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: VIGgaItHydFmXMoQG-1BRKtoMdwD6kVN
X-Proofpoint-GUID: VIGgaItHydFmXMoQG-1BRKtoMdwD6kVN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508130094

On 8/13/25 5:35 AM, Shuai Zhang wrote:
> Multiple triggers of SSR only first generate coredump file,
> duo to memcoredump_flag no clear.
> 
> add clear coredump flag when ssr completed.
> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---

Please read

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

and adjust your commit message accordingly.

>  drivers/bluetooth/hci_qca.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 50ec9b155..33c2dd7b8 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1662,11 +1662,14 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>  	 *
>  	 * Host will not download the firmware after SSR, controller to remain
>  	 * in the IBS_WAKE state, and the host needs to synchronize with it
> +	 *
> +	 * clear memcoredump_flag to ensure next submission of coredump date.

"Since the bluetooth chip has been reset, clear the memdump state"

Konrad

>  	 */
>  	if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
>  		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
>  		clear_bit(QCA_IBS_DISABLED, &qca->flags);
>  		qca->tx_ibs_state = HCI_IBS_TX_AWAKE;
> +		qca->memdump_state = QCA_MEMDUMP_IDLE;
>  		msleep(50);
>  	}
>  
