Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F423128BD
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010630; cv=none; b=RAdgBtQmomQJs3tga5qmAWLp52jn/KaKLNL2dGHx0gNXq3zlVC/LKDtHRKnHF1ZT+jD89imi263t5bGDKylMC6EyQOU5tUi4CZawFVmCFB+c/9z6rXCtfluZd0p3QmSUzgrR5oyKQOmRZ+TXfy0yOnB7wB7OdnY85jhkrti577A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010630; c=relaxed/simple;
	bh=M/o4iABkG13l3LWykwucfQeijY75nOOCLb4rdlGXk+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWfI/Ho49vVZRRmEQRu9LF72RXGRrZn0JNp6jaah/AZxIQ6kcXHvXeBR9eYcoZVUO4uCmfvx9EF+FiRNpSOFprZFLA46WH5kC/g9J4NS1KO3xxJkyWyMM8DzRSY8Y6GuEJCXAd915Pl3cSgvv+tqKbhl5DJn6638bKvQ26B3KYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YFnsGrgB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RGGvEdqK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YFnsGrgB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RGGvEdqK"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P4LApg3333662
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 09:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uDyiKV8XxO9EAqIZgFIt2VKH5lEcYu2Q73A/ga61A68=; b=YFnsGrgBBDsbO29r
	naprsbpEFEMat/IjppX07watk2u/VLMbE7e/ME+HDqfCYbKNYABIpFWD4sNKmdxL
	3ThVvOZG1yOIqs2detnx7ZVzn7oIJ3IL37HroZyBvU8P4K6f2pIzUiKgMKMXqQqs
	3+MyLsx9UEw+0wniBBj3Z1OiMVswJ4WWbRrUgMZdJTlnmO5Pl9HFf/LuIURecufy
	yn5cSsanG3j4tuNIGpc/JrubdDQbJM+8duqM3sviDpqwqZijwzRP0+thGzkAdPK4
	sIRIVNR7NNfmGgX+Q2ZXyRquKEh99o2XbPeW2Qa3ZPOKYUMd8JUz20tW327zNMOx
	YjwgPg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chh472be0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 09:10:23 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1277896014fso9046494c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 01:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772010622; x=1772615422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDyiKV8XxO9EAqIZgFIt2VKH5lEcYu2Q73A/ga61A68=;
        b=RGGvEdqKHk7JhkwkhE9bTreU9BLnUm1inWLbuX7gdW0fO+Iq8Kmn8UMZ6vopvP06oF
         pDOhYM1MtfE9SS3A5EoP0fHPod26YJrkoYy4jJ4t6naEpsaGdJs2Yv30+FWwJLvn+JVw
         UfC7JGbA9VDgN63vDuzEqjBUadHSEgwxmK+h8d2v/Kwie5P3hhkAY1eJKczAvDPTi1cW
         +lZ7gssp4AyLV/HIklaSIHBx+ofZCaCNw4cmkQOVauLjkWmUWSTGHHfjvYEp2j5840Xc
         bD4q8WgKtYdp8V5JDRToYUoRfzzITtvQTDn1LJQu8dCaOpGToS5gVSv88ZujDok9jkPR
         Eu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772010622; x=1772615422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDyiKV8XxO9EAqIZgFIt2VKH5lEcYu2Q73A/ga61A68=;
        b=lxh0lMPrMjXyAXAnaGTMNCpyj3Cwto4P1+jITiq+XgjcMzgdvq4PnKZAfEPQwXEFYO
         Rx5aJYr0/TKhYbXf3d/NzwQoifVmBu10Jv41RGJRfaj9UwTioeihvvKFElbERR426wfS
         qnoX+ekg7NiPnVoEgRJmLCdE8ohqNaXOd+r3tWZQSXkgH9frBpY/Llo3gBVz5QgxCnTq
         QZyjLtFx13lKx0hICUK9CA00Y+qBE+WN86zv7Oj9o7BWI5C7IE5J4kclPECEF8K1viZS
         /FxGxDjvif5/fltIeDB86CUDUlPQlFUNNOMUxyozWCos1jKf0mdMUw/Tkm6iqn4keU1g
         8/qQ==
X-Gm-Message-State: AOJu0YynWUn4sViIrCOBLw0YoqJ12HMWWMSXskEDbEnCLdIJsOaKGUA2
	cY0j1bGhF1Enbus+QazPnYQCyLf2DLcSFAGGx9+rgOHdLm9BHmMySaalzLUW991zV+UduGAdFEV
	Dhgkd5xa/mJCt9sSmxvOAtyUbLJojSTGYBSr8EFIkpgdDQztLLGWRqttY50ESDi4DCWRMcjvpRQ
	upnHY=
X-Gm-Gg: ATEYQzw6ORNk+RClVyb2IS54EyKrY1JipL+F2yyVtE67bV4NG0ehKGCwMPUpvUZfsZt
	OakqLritzSiPx3fT98tOfO7lBeE8p3O9qDzGxyM9OeuzGxb1FpM1BF34qcPtaWSFwNz8Q9lB/BD
	s86svk0sxt+I4jk9/bkfjYptuu4OADPrbC3p3MTYOXGAabhHYy1EWyUO7VZmKLKX0eS/CJIlall
	EgyUV7EtOUg/1ejXtO7SWTF0BV2qrTRnfRyRRAboyg4bk/TZ23R7c+Aq+uvtLIiH6bG7rcCB+jA
	eySwnr+hiNfUcrOmeILirdufa8a973wxFJhbDF+gEYwCuuaN/3DawgqhOV1uzWnfgQA71XC/CPb
	kfCeqVMTbw55XPmcj8xsEj4zzPtTTTCUSRvltFccgNQ==
X-Received: by 2002:a05:7022:619e:b0:11b:88a7:e1b0 with SMTP id a92af1059eb24-1276ad628dcmr6590353c88.26.1772010622275;
        Wed, 25 Feb 2026 01:10:22 -0800 (PST)
X-Received: by 2002:a05:7022:619e:b0:11b:88a7:e1b0 with SMTP id a92af1059eb24-1276ad628dcmr6590339c88.26.1772010621743;
        Wed, 25 Feb 2026 01:10:21 -0800 (PST)
Received: from [10.239.30.226] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af10481sm13363243c88.3.2026.02.25.01.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 01:10:21 -0800 (PST)
Message-ID: <93f63aca-bbdc-4e83-ab2d-9a6f366aa9f9@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 17:10:14 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] device: Initialize device volume with a valid value
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
References: <20260122063640.310090-1-jinwang.li@oss.qualcomm.com>
Content-Language: en-US
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
In-Reply-To: <20260122063640.310090-1-jinwang.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: A84NDsnrhdWIvanYy-RDqmtbTE2sEOSR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA4OSBTYWx0ZWRfXw0BRQrau4Sg3
 tPiS5gfjbGbGfVMPBDjsL4/B2xFAJXln7n6JWSlWh/ydzwcq0ml8hJir2ITds/fl4PNLCGfgxSE
 tOfvQQioZJTnwLQ0QKwm2CYRVZrVByddpE/d4MPZtNy0eFp/tGIDYrb+ebaxeT3vMk9N6wxig7V
 +U8QWybrxoAotWoyOHbV6rGW4lewWX/FCL5893eHeLxhE83TxDFlcS90h0zv9sm25yOzQTSSO0W
 dCEuuNhm1BL+/7f206+mksODBn4upWew2gC+qdIVy3pbEGBhGVI23i/0nUKhtmQzNExR0296f5W
 Ep8Z2Ni1FXmuR0+13UeUDSpX/hnzonRY6HFhtCQ4TPltpAgODGfWem8CikTZllbxq2ufET5BRRA
 RXMyJZPglmWCnM96xal6MlVPkD67LYntL2OxUzkYxQipxnNTiayl8Pji8WpMpbI7SKzhfcm0VsB
 Fvv3F+RrY3QMsNkfgRA==
X-Authority-Analysis: v=2.4 cv=fvDRpV4f c=1 sm=1 tr=0 ts=699ebc7f cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=pNy3ab2Oj53foNosMAYA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: A84NDsnrhdWIvanYy-RDqmtbTE2sEOSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602250089

On 1/22/2026 2:36 PM, Jinwang Li wrote:
> When AVRCP is connected earlier than AVDTP, this invalid device volume
> causes the A2DP sink to reject the peer's registration for the
> EVENT_VOLUME_CHANGED notification. As a result, subsequent attempts to
> set the volume fail.
> 
> Fixes: fa7828bddd21 ("transport: Fix not being able to initialize volume properly")
> Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
> ---
>   src/device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/device.c b/src/device.c
> index af8df5f29..cd0b8802e 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4948,7 +4948,7 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
>   		return NULL;
>   
>   	device->tx_power = 127;
> -	device->volume = -1;
> +	device->volume = 127;
>   	device->wake_id = -1U;
>   
>   	device->db = gatt_db_new();

Hi maintainers,

Do you have any comments on this change?

--
with best wishes
Jinwang
