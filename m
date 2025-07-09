Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482B222FDEC
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080818; cv=none; b=MGO/jxppkj8WvyPNAygAhP3NwbGQCq9+6M9XAmJpmeb6IPWV64vDdP7wS37utCOu1gntzwMtxzBJ48/TealgSdB92Z8KB2orFjvDrDAicWfiy8OePtsxuL6lINbDa+lCnlr5s9yFz1ut/ZiDRsYjjnz5CX3fn5VEJYyTMMjCyNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080818; c=relaxed/simple;
	bh=Dd21ohWnuUTS/BXEfrNOepJdRU2lCK7un9IzRE42mpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGqYRD9Fyapy8+AwWyrBnItrKFhtcsDiHjuYKcqnH+DeR8CFP7p/FHRkzebJrty62bMDGC2fdTAH7DfD5PNGNlF6BfNMGvPBdzQQSX7NeTn7Vd1BLRfZXhMadJKg0hY6f5XkqmyFd6jZ4MsOI6Prg26jWseCMd+qTeDGOWO98VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MGtx7E7s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MGtx7E7s"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569ComTD002907
	for <linux-bluetooth@vger.kernel.org>; Wed, 9 Jul 2025 17:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wh8yuaaHqpeTognyFmCrL3eiw6cJgczdQVoN39qvEms=; b=MGtx7E7sFI2v1NhU
	9/x6p9kRuVLvZS9Bgv+Y1AVL+bl8gQlirZkBOqoD4ZaItkc+J8+ioyES2sM+XPmO
	cmNne12dEhfxazHku+TMtcD3QGnVRoB8rejhzCCmjhVdOwI5E6xO80Sg1zZkL6bX
	ApjCCEP3PInBtkNqQ2l563mg6vQjKPepDQsyLK5qCqvn9+PX+Hs8bs7MTcuZypzu
	vBAyhvfUyDxO1tpGLxmLQeptUUl7sp7MNwy4GMWVBN6ZrThpQyu62ndb288Jn24X
	WBjpzBrgs9+Y7f9DUOQp/8P1+sEByaL3UpfVSOv9tLTMfQFMcb3WQl6vQUYWWHfZ
	55OtWg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2bd7kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 17:06:56 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6facbe71504so286206d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 10:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752080815; x=1752685615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wh8yuaaHqpeTognyFmCrL3eiw6cJgczdQVoN39qvEms=;
        b=VecpV+M3HkQpAaLxpP0jgbZ069SkX7PN6/m/SGu33mTpINcGY4u2v10PtwLR4vw5wS
         7IGZdlgFjcHAhThO8Z3sq9jBGIVmvTx2br7jDvpNcT1DoGUD42REfzda1t7GIZBMkQPG
         tpA8TU4V5RITf6GsKQ+Utpb3U0pD7hT413vpR7Yfn9IRWOCk+Py+QKq1XY3CRtKxkY/G
         UAZTFTzqrmgpkWf3SuZUMJ74KHLrLclwAqCIjsuEtpbKx8YqLJi1fh8ubVZlt6GTxAMh
         xz9sYa704jBs5BiVsk8D0V8QaTkV96EnrkI9hCBLhg7iQtO/Qm/jpsREkzdpWDVoiTbm
         tQNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZHzDHLSb2pFPL3yA/tbsTDT8h2W2pEFvNi1ubaRE26V6rTbIlXJLEKO95qa/zw0LgUUxo4nBJMjNPWoaDWgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUIj983pXo0Qv6pnc9xbs0f3EGmJzUtXkc6XvZ4GO32Kxnfra5
	iy7qgHrPE9YU5c9S2JrnSFfg2QEnNzo1dbn8rn/I6YAJgWtNCWpJgDXRzqg0FnwzPUqOWszccO7
	i/r8wxMUv3h/4o3RKyYAk/MhN9/aF9YUiKtOhyB82ryExeWBqJjtYHE4pJl3cfdQb+JyiLF0=
X-Gm-Gg: ASbGncsNicePry25Av75yGGa365yfii7EaQS63XU0NRrmfQuxa06eXCMRfO5y0H0ITU
	SmMm5rXKGi7O9WjnDctyPuR96g/qaCwKkpJTu7ltDS7eynTRpIPyGQLDGBp0TxWYVbh1XIPX8Mv
	7+Pu/OWRWb4kTHpBF+3Wu8D4RhvHUHssakpP+xYsXQ/L/F4wewJmOTRVObn02hAXzaWrJL8jC/n
	0Ku46yK+GQj5ebCl61TBvRjcrp4qkfO69uBsK0qm8a06Dl6NsTVp7ZPsrTnruDVCUiTrU/PhtT0
	aese6EcgijSIITTdZSApT6/0qS+IgpW8IvhSIyUAgTmIFTgb2L3zaOgAeZ7FN+PJMh7tF6cLyKY
	+fWo=
X-Received: by 2002:a05:620a:318b:b0:7d4:5d37:4169 with SMTP id af79cd13be357-7db7dd6a732mr172205785a.15.1752080812949;
        Wed, 09 Jul 2025 10:06:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlkcqXa3BSEjEs9eL1FjQsITzwJ/IuC4Kr/+Nt103WxumFedL2DSA4y2nT1n/tQD+IDxMScg==
X-Received: by 2002:a05:620a:318b:b0:7d4:5d37:4169 with SMTP id af79cd13be357-7db7dd6a732mr172202485a.15.1752080812237;
        Wed, 09 Jul 2025 10:06:52 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6abfdb6sm1137405066b.78.2025.07.09.10.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 10:06:50 -0700 (PDT)
Message-ID: <141abf1f-2739-4ccf-8a2b-3451c299ef49@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 19:06:47 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: add a sub-entry for the Qualcomm
 bluetooth driver
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Shuai Zhang <quic_shuaz@quicinc.com>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250709144728.43313-1-brgl@bgdev.pl>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250709144728.43313-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE1NCBTYWx0ZWRfX0JzwcZUz7/Qb
 t7BcTyg5nQUo9NILqppht7NWj7o2jS09e1byNqAvd7VhKhNlwz7EwVa5cTujZ0cR/94XyZ3Dyce
 SJn1xQXa1QmRnDOOqhiXYJTtJVL9WBCI6q/YmmM+hmHTEtqSZQa8rZBcrUXCune9XiRIUCy2MVr
 BdhLnoo6KMLGOsAizd47IO4+lL4tz2a1qpuk/uXUHH33WPtQ98MrPCkHwYPMgCoGCwlV/nJjk7E
 h9B7zPJA1OIHL3wfrCyEXOQ7e0kKeCXi4BK1Vs9vaokttrmVQd44sDd0qBpC1Hn66tLOn1jJ3mM
 H3nydl4RUY2njYMXjBAOv6gFlpeveh4RoY8weTKQ2ZmSLMtRHbEDpCRvZ+NzimmtfSRbGWCiHLW
 NqY+jjJvfEd+OGa5fCO7Z1iqOX5lEO+gp2sFGFzuUIzGOsVpwbB8VzgxA/uPV7XX5kSI/py9
X-Proofpoint-ORIG-GUID: -SMaswJjqbg7-6kSYGva7vzSE1rIeZT6
X-Proofpoint-GUID: -SMaswJjqbg7-6kSYGva7vzSE1rIeZT6
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=686ea1b0 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=rZnPLpBaAhPpgNZSqhoA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1011 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507090154

On 7/9/25 4:47 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Patches modifying drivers/bluetooth/hci_qca.c should be Cc'ed to the
> linux-arm-msm mailing list so that Qualcomm maintainers and reviewers
> can get notified about proposed changes to it. Add a sub-entry that adds
> the mailing list to the list of addresses returned by get_maintainer.pl.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Changes in v2:
> - add remaining QCA files (Dmitry)
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index efba8922744a3..d018923ddd3eb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20464,6 +20464,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
>  F:	drivers/net/wwan/qcom_bam_dmux.c
>  
> +QUALCOMM BLUETOOTH DRIVER
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/bluetooth/btqca.[ch]
> +F:	drivers/bluetooth/btqcomsmd.c
> +F:	drivers/bluetooth/hci_qca.c

+ Jeff, maybe you/ath would like to be included there too?

Konrad
