Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2F275B03
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570762; cv=none; b=lsUV9rABu8cm4f20Zfe3TYe70iyETuzqZ29o3m2Ag+7AuNBnU25UuoFU/pPOKcuxSkyMgMdQe+xLq/wTRAKHQGBMWyQ6qhZMsyB6wK/8rvNT1DO83F8hEccuLvQZs4CKkluYzx+7kyBLW+eTj+Ag7p1yI7YJ8zDKeSCj3A5p1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570762; c=relaxed/simple;
	bh=lDKZhM7Fc2r3xeeGvaRy/J8DbzQvt7X4L6Km4JLlf2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/m1KyL0MxvQvICYL8+LCus4h8nx5mU/y92OfbZCUpTLkI6hnTJKuLQwBxJwqTfIDQpp25YBBREcuWtxzISK3B7ENAbXyZwYQ85udf41UOMe9MvVoavQuW83edul+N06ad72vAqiQ5C6FNNKSLqa/PkO/gPfBNj9yExfkjhgIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IY/Q2rgb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IY/Q2rgb"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F65qt9012586
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 09:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G5idLq9ANx5fFpzc7JrnxCy350z2ew1gS4p9t5ZoJAw=; b=IY/Q2rgbBRSZzYB0
	ejJWqIC9DMx0pYpmi7VTIhKaW3hmi4QFUxiNPqrcBCSzCIav8uxE3qQLTrycXY8c
	b/rOHsP/3YBh/Fihr8uHr7db8yg+65x7t0cEuyuM4m/Wf/WpYzMQMgT42Lyfh4/B
	QNC66F8IIMxdnCbSfsWe+OPT9is4gv+g19Ay75Oq9lZFbgcwN6j62AsGQsHwyzOv
	zDq5FxMqIgMqmUaC+HcDEv26HwEAVWaGcnQmKZIS9D/wp2KFfjPgd5rivo0zbASC
	1e16d20SLG68imkfBUpdFoEjsF+8Nl/b22b3YQPp4gQphaLISc41b/HcAmni6kqY
	SnUfkA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dyjbhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 09:12:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab7a01c38cso3551991cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 02:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752570759; x=1753175559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5idLq9ANx5fFpzc7JrnxCy350z2ew1gS4p9t5ZoJAw=;
        b=WiC9PruDIj/o5MKdcilvBYxwdCci2ixFN1H7/oL6qXxSwZSWkC28cS47w6RjlUMYck
         PzCTcl6hSX/peQWAq/1AxOp1FQCiCH1KaCKh9PQqekML5WsW96sVRroxYLBtrbHibjLD
         aTaw6NC0WeUjJbwOpRwM+QKNPAjhKsTWvMeuvGzOUpmPQqZd8ceS+stjPKglDXE6gy8V
         w2WYHGpSEeHmBZ9Ed7iGGxmKpePqrpnomTwhczm/J5HD0OuJ7aPw9wpIDRwUVm49FYiQ
         IWFHsbwl6ryqccOgkR9rurrchDOUDRjWcBms0M1Yit2MsT3clHkpkb6Y7piqnydas38T
         BWjA==
X-Forwarded-Encrypted: i=1; AJvYcCXIePfzjOzz8Ks6j9YqSKS1KkAqoBNshxrN+Wqx//zIC1Y+ct5LCg9h75lq3iKHNJdPCyrBVLHivaFgcnFokOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUJ7navOv++0iYRpwuDHygkzu3L1aG/ws/vcrS88J/zZqQPUMj
	Qb8U+cnmiLWGFY5YkzuWg0NYOfZ4S/wLurvDoTk9K3Vb/gHPKxb0Jz493du+CGqMx7eYlJFZtdQ
	7NXLAT72M1l4/4Lu6bykrXMZS6jeHpu89YkyDsx/RucSv/j4BA//jbOptByAQ8vBL8xQvNH8=
X-Gm-Gg: ASbGncu6qlRp15J0TmZIamEgbfGr5OAlV2gF7BxG6LXIOPDgYrtM64sm1w32cR5nu1q
	AQQS/FKUhnd2hY9zrG0Pm9nsFihmDAsuGGbdpKFhEQglpY9UX+O/EXhiREEXbe1Kt/XAEGio2LP
	KwZFjPGBC1KQBwqFi23wCFcN2etqAPk+0lawaHDSpslbMWRKLDVVKWmAjcnfDhG8urjb7awxAjQ
	CWMfxpEWM6zx4gzTwgpQfAX9Hh896OP7K9ZWJZUEHLTuCXWzNUc/l5xWsMXC0wH9tHrmaAxiifz
	RrmF2x9M56k/hGETZkJLGiBer0qE0Q0YTE3v5Nvu4qUuFYxOlffx5DWYI/0trv0pSPebx/zmg44
	3T9nNMCd8qlL3niY/B08S
X-Received: by 2002:a05:622a:4ac8:b0:4ab:76d2:1981 with SMTP id d75a77b69052e-4ab86ebf803mr4610341cf.5.1752570758768;
        Tue, 15 Jul 2025 02:12:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnGsZBIAOn6nc3fROUqaYAWPQIoU0CvWKBzLE3cYYK2sBv/+TA8R6DMWxwMOImdgntLW47XA==
X-Received: by 2002:a05:622a:4ac8:b0:4ab:76d2:1981 with SMTP id d75a77b69052e-4ab86ebf803mr4610221cf.5.1752570758190;
        Tue, 15 Jul 2025 02:12:38 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8313c93sm956104466b.183.2025.07.15.02.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:12:37 -0700 (PDT)
Message-ID: <67431c9f-d843-488d-af32-c70aa183ba19@oss.qualcomm.com>
Date: Tue, 15 Jul 2025 11:12:35 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] driver: bluetooth: hci_qca: fix host IBS state after
 SSR
To: Shuai Zhang <quic_shuaz@quicinc.com>, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: quic_bt@quicinc.com
References: <20250715051618.724475-1-quic_shuaz@quicinc.com>
 <20250715051618.724475-3-quic_shuaz@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250715051618.724475-3-quic_shuaz@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: l9HRkHVyO0JbO-Yaf-dImroSEAed4J2W
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=68761b88 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=jRSd7LoynD_UXNFgLaEA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4MiBTYWx0ZWRfX07XDOMMjXykC
 zf/KROX2EWGtEFzEaFQM5ilJIXixou2HMRxp0A+HYScuQsoyBKkclkuOcy7gTB9BNx8oxmBMx1K
 SOuo8odqvz+qn0wzvm8ckthrMUzbALo+L6UXEk7Fz8PzE66XZoTbmn3dQbbGPidsCsxGM5ekOqY
 t0q/pxo5PJK8eSc4MxGiyztynQwZ88grnTp9cIpgnp77F466RhggDJsTddq+7xKHuiuOOdyOCPU
 ZD2cGw9M7RmGnfmTgIsq17KpHCxnZsF1mvnbPf4NbT/pwQgkU88g/1HiqJ/oQAmgFimlyQsKzwP
 k+fvRojpKT4Vita0o0mq1VE83Yl6WJ3DJx0gPC7queYvz5UuU8zgEZPEmYKYWoIU1IUFg9kr5kL
 QtQAWtrmAXgmdNIkzxycYiKzx1mVwx7tLoX/KeTSf9FMFgifrKP2BeWKQJPfJlPmheuJdrNU
X-Proofpoint-GUID: l9HRkHVyO0JbO-Yaf-dImroSEAed4J2W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150082

On 7/15/25 7:16 AM, Shuai Zhang wrote:
> After SSR, host will not download the firmware, causing
> controller to remain in the IBS_WAKE state. Host needs
> to synchronize with the controller to maintain proper operation.
> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 791f8d472..a17d3f7ae 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1658,10 +1658,14 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>  	 * the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be cleared.
>  	 * This leads to a reset command timeout failure.
>  	 * Also, add msleep delay to wait for controller to complete SSR.
> +	 *
> +	 * Host will not download the firmware after SSR, controller to remain
> +	 * in the IBS_WAKE state, and the host needs to synchronize with it
>  	 */
>  	if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
>  		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
>  		clear_bit(QCA_IBS_DISABLED, &qca->flags);
> +		qca->tx_ibs_state = HCI_IBS_TX_AWAKE;
>  		msleep(50);

This touches upon the code introduced in the previous patch.

Any reason they should be separate?

Konrad
