Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895D03E8660
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938227; cv=none; b=kd7rgPrIQN/eMghMldaQdB8gAKTlf21QgfELZsFRxBU4Aq96nI91OU9CHPFDGlELIA1dpGv+OZ1H6F7Z1utunkGUJTLHm2sh3a9Ck6or+p7V0UorzcVITKp1o4+EG7iqzz3daMWr9YdCqEfJ18pmPUBSfPbSrgrYgTNLLdtG9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938227; c=relaxed/simple;
	bh=8CaFrrRl0bYCwAnytdOVBas5jSi/EskoqZwbiOciaDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6VKyWFwCRe3O4o9ZNfyMnFAZYq5sa8QYBoUYQko9KDpg8MUBCb1mOs3bI/PnTs846wKo2XNJ1l9013MwlZ2yKyStX/VZsv/YrNj7ZT87OAWlNnulKzYaxJkpxcGXD5UBKtLZHeYHLaUu1GU4BOX9pXen65E6/I89ZbSQm9vD7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=isCLpplT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LKIi3k4F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="isCLpplT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LKIi3k4F"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D9uc4r1089702
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 10:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f0lg1PCrnQJqL/OGVEi7UrhdDZxSWTLWWm0o+6JbcWA=; b=isCLpplTZDAIw494
	aN0GdXyy/afrMn3zkAAdMA6TeN9O/EExfOPXJZtl4eU14Hm7Q0a1DO70WUWsnbrI
	jNtEKM4d41syYP8PQB9eqM6PZ0NaznvAloIiZh1YlYdwuDX2+l+GRvzrjq+mT0vU
	1VA8tV0+sBC+M5ybuK6A4+aaPu1Lddj53zlF8fVzyiiqVWC7ETDNcEPDesA50lIC
	Sj3zu9d78JgaLiHQo/+H7oPlKBSESjwZbREz/mJEZBTQIBjNMSi+LcVRtmato+r4
	6WfD5NUjJzrRXOrvQYqV2yMfVokWQzwLb1epn/XCLfef0XipnlIzUVIduCPuVRj5
	HIiH0A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwu4r32r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 10:23:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-384cb1637c2so825225a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 03:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783938223; x=1784543023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f0lg1PCrnQJqL/OGVEi7UrhdDZxSWTLWWm0o+6JbcWA=;
        b=LKIi3k4FldDYzFkE9GpDob7/A93TTXzo7fBdEzLirRUEZYFGek/SQ6O9eU+zesFFQH
         PJ5jWIU7lhErbmiW1GwMu2SFKOF/dv3l1ukPXX2bx9pZ6e51hpoAM+iM9Bw482uVjcZt
         zsYdTyPXQWV4LjVkXvd3bEX7T5Pb7gWL67jZPQQohnHMIpeGUlMDEk82hU0KOi+01VQ7
         9nZ2zpZvKbLSMHX6rES8JDObJReN58O4rEDbLrDnJwBkogDZn0Tw3eAhjfq1rTfljrzM
         ugxB0+I1YDOqyDuwNK4BBHIB6ChoXzW7UVQRf9NFPWzoTSCHKIv+/Ys8MWHD6cjF6Ny9
         Eaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783938223; x=1784543023;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f0lg1PCrnQJqL/OGVEi7UrhdDZxSWTLWWm0o+6JbcWA=;
        b=cpovQBxuEQAs8vLLyQrnfYkQi+oc3l53O2CkAbg/FBEea4aTyFtQ7s3Tg80rt63RJO
         Ih6lwvsJrEVdiw/IiJwdWcHWSi1PYonH7X2jzlR5NLSlCQJ0IaqBRIQtW+MVZB9//6Az
         GcMtpma6k4vxj12LDHh+FN9zshp3p3NPdjpxl+xnFDaefQG9kfhcgUY3VM6CF+J2CVtn
         druWtkA9x3EbIRiXxiKzcvXlKuk13drFe85zZbEjCh0US1JqRz2drfTaMSjh9g4Z6eo/
         76IRYchtE3axHw29t5bOW8C02eCvLsXaWS6dfX8lWfgODXDtE12cZYYk57xJTO04Vl2s
         +okQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpqdg2hf+t5MrG770FwV57SSRZJyLWyhUiDk3rID7MoHeAJUihDKmUOmp3OOwjw/0wr+TsVR8g7RAqlkpzzeCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwy3PYgkmPHkcpiU6r4DK7Rg0ds/pXojrX9TLTENQLIrStEFTL
	2H+Kqj5dyAHKxEZrbKY9L50/lgHCPk5vEAwbA8MH5xrOvsXC1uvAYWnKy3xG4wGc6cniHz3KPkK
	UZb2lO5Y9Szf6ta32eds86qhaAalTguqx1K+nX8IW5fYrVt3ZRpcA7hXzFBQ9nExe2JNBYzo=
X-Gm-Gg: AfdE7ckuimxf94i8fIwoDbw/ycs4g6TorwLZfhsrsVP0QDT9E+cqNpq5HSHxLLZpsDH
	7lPUu/DDoGHN/BNu4I7apO0fmIenHGvssr6K1lU6ud/YNOIHt3TxWUk51yQ4AcFOMuudhsxR+km
	td9C3IveHqFxdx43fF/NejXttl1+jgG7WVzAKefs56wD5+gRyKcet88DbWXZS5zqAjHC6TUrEpK
	VNSumMFOv027GlYmblV4FyCkgoKtDahruj+ROWqB8KqFWRyg24sJ87sRiE++AafQhr71KrP6Ojd
	sX4dcmFtVSC2LUyM6Tdo4DZ2W/6knm047Ij7NuqiCKclJpAaenxbRdFO3izp8wnz/JpUZsA9d5o
	UBAlkebY62T+KowcHUAXoOkLL9Cw4WX7TMckOyk2I1r9vCt+WwBBTv50r6cYhRmeXPB6If6ozPh
	SmRg==
X-Received: by 2002:a17:90b:4f81:b0:381:77cd:38ca with SMTP id 98e67ed59e1d1-38dc7bd893cmr5300895a91.4.1783938223402;
        Mon, 13 Jul 2026 03:23:43 -0700 (PDT)
X-Received: by 2002:a17:90b:4f81:b0:381:77cd:38ca with SMTP id 98e67ed59e1d1-38dc7bd893cmr5300888a91.4.1783938222941;
        Mon, 13 Jul 2026 03:23:42 -0700 (PDT)
Received: from [10.133.33.254] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a57dc46f4sm6231892a91.11.2026.07.13.03.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 03:23:42 -0700 (PDT)
Message-ID: <a26a0640-2d2f-4bd7-9793-c20aeb6aaca8@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 18:23:39 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Bluetooth: btusb: Preparation for upcoming Qualcomm
 QCC2072 support
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com>
 <CABBYNZLYXEAqXrVfCxFtgYEU-gCZariPYiGbk3zES0tQ+4qSAQ@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZLYXEAqXrVfCxFtgYEU-gCZariPYiGbk3zES0tQ+4qSAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FMErAeos c=1 sm=1 tr=0 ts=6a54bcb0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ZllgiZUDiiplec_xgN4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEwOCBTYWx0ZWRfX+ySa+jguWgs+
 joEVoVpzNBvQdioLdP34npgToWYcipnHkrdBIx1Nz3e0SBPYurYQmCs2W37D4lZeLrtoFzh3igc
 bsawtrhGBLrDAvhYEMa+3wun7ADVjYE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEwOCBTYWx0ZWRfX9Qd0Gven9pwR
 bHJWTRE+rzA7HSYjMzJJZ0gYvXQq+g8JQE7wHSHg73j4ymf9aUdeI4u99kEMiZERtwZJGN+AiFM
 /9NkhzYxtEI87RJ6XtXR+7S+7lgz+Rg6fAUVXZ7/1/Qe6r4ewJ/huDcI1li9CeUUulDkUZkvT5p
 /1WzHLErxPG42CRGczL1viClEwNaEHRU85MinLuBD86HWupYz0NtafHglgsv7EwsqiCNg576OnS
 31rDczQKK+jhomk3sQadLEVFA0q1qxHmz6WKXnW1EMOHq/QuzA59Pq/fNWYhs2xV3cpBaatSFek
 6Tt1TJXBsOvtLBJqX3ot7Q+BV3lWNyCcv0kkAvm/uf7qh/KN+/7ov7aHyaHjvKN2CGyy+HYPp2W
 mvhZOd68LVTDrv4S4wia0OCr3vAc29jJuOyXqWmHVSw7WmQG05UeaHHHLpIDVCbe4A6fTDY/fAf
 FH9QJ/LdFWuTLm7dwiw==
X-Proofpoint-ORIG-GUID: hiFeQR0rhILm8yHUKeFCywpWMQm9eMjK
X-Proofpoint-GUID: hiFeQR0rhILm8yHUKeFCywpWMQm9eMjK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130108

On 7/9/2026 9:46 PM, Luiz Augusto von Dentz wrote:
>> This series collects the btusb and devcoredump changes required by the
>> upcoming Qualcomm QCC2072 Bluetooth driver. None of them are QCC2072-
>> specific: they refactor btusb into a shape that can host vendor-specific
>> source files, and make a few coredump helpers reusable.
> I really this not a 'lets redesign btusb because our driver is not
> standard Bluetooth Class' kind of thing, we already have hdev->setup
> and other callbacks for vendor specific functionality, if you want
> more than that perhaps it needs to be become it own driver.

  Sorry, the cover letter was misleading — this isn't a redesign, and the
  QCC2072 driver does use the existing callbacks (hdev->setup, hdev->send, and
  the recv hooks). The change to btusb_main.c is small (+67/-2):

    https://lore.kernel.org/all/20260713-btusb_qcom-v1-1-39cabc0dd601@oss.qualcomm.com

  The only reason for the file split is size: the Qualcomm code is ~3700 lines,
  which I'd rather not add to btusb_main.c. 

  Please take a look — if you still think it warrants a standalone driver after
  seeing it, I'm happy to discuss that.

