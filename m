Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DB44F7CD8
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 21:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792100486; cv=none; b=rVoWm8i+dxCQINj/uk7GhGntpAnLsxIP/FHzzTIP6zOtrtoOyHJoySwQhm9npD4bnJwI7zyKdX3RaNxlewS38U5MA7NmM7qoLLDw8mRz49flvEwJiGdOU7B6eqZwNKgdRrIB9ykj7u/gSSoVeZ2OwVX93JiHrgwx9pfKjzvTe9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792100486; c=relaxed/simple;
	bh=kdE/oL2qvaXHvtKxe2PNb2/c7DP0GEJRE2hGcp9ZR1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMPjL5pzmJe6jzvq3Orrw7Xc6hy+/hLTVaxPtXdkThd7KiouBJy5Q/rO6lraoW+72MEhne5eEXFlKGAtIzD5lgsIXkzci2bA1YjZn+Q4TPDbRp5C8fBuG0UB8RVwd/ZEPFSFVbRHMHLdSXXqqpreMnimDozn8rwYXBgaaMOAWmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W/StAFFS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UG++uUUX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W/StAFFS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UG++uUUX"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FGPL2P1596361
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 21:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4a8omtOMUvQnoW/+es8xVBAFKUdGDbUKsFkbcORMiDo=; b=W/StAFFSUlaMH/gX
	bWP5VXvrGrIROnXbTGVO+AR1RJ+1y2mROeuPGaW3Fv2a4Xg9e52C37hD10AGP5ZV
	l8L9csl+Vnocq3pep9ta5lTtWO+K9jla/+t7/Kef1QS/kS6/BUhxmvsjOwP+KEyE
	h0J6DW6yXFjbnlsB7no0uwMvXp8bGz+iuJ2k6HKCVBmANtY1V2M5h7ZR9Fk6nxAK
	aoGIq/DXlxFw/QFgh0YVZQypqTDbe+3RgbErz0HhSSyq6KQMHG59SzSPL4KLv6SW
	1NQtADzCZdgqWh7LdaiSoBh+p60HxB0d2vTSOCCJdZb3UJulSUKImnUjvOF0feyk
	HhA8kw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2vajjk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 21:41:24 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso11634339eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 14:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792100481; x=1792705281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4a8omtOMUvQnoW/+es8xVBAFKUdGDbUKsFkbcORMiDo=;
        b=UG++uUUX9sCsT5iXOcUipEb6SLXyWma/F2Ln1AmLZhpqbmBIwik2U3x+YLiSuvEmgW
         EwlEIDV6RQwbWNSFhSqJHd3pdqimhBNhjRJig+yMk1L9l5b2QxWf9NyWv6l5e+vXZoTR
         fd38umcEBSzRxqoE6KSqb4vSRrDrZkQDw9pygTqTg0M834gG4W42fixwa744sispcTgD
         rbtDxGpzTphTZXalZJaOWzrhjMnXGl1kdw8SrAYvA7rNHwO1CMrip+v4r1EsQ9q+xXTs
         BYO7ac98m8hywbtehwoTRRIxRqAEYmPzZpkYJ+C71WtVqdc8m++K2fHEcXfVFaVIksCr
         sF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792100481; x=1792705281;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4a8omtOMUvQnoW/+es8xVBAFKUdGDbUKsFkbcORMiDo=;
        b=l/xSXg8AGBgQGI4HxhkH8PJdGOFJBbVJBVTaoCNEsfPXlFrRGvTEF6c9+gfOdNHkzG
         5hHf30HKQFe7jqGAegyqMOIYNvpOvcXglaEyIssiZjcz/R9N7OXsXGG6Qn+YoXhK1IO8
         R/fFTe+zJgFteWSOtuNoZIjRDBUvEz2W/V+u4/qOd2MdzUiaTJ1lBPDfdKp0aMrMRQBW
         ZDjxtB9Z7klMrwP2ML3jYiHLFzFpc70iNYIHDOIXRluu92qSBL4InXM1xGLr/tY19qbf
         oaviL2WsybzOJdrgTYr2DZYwxQtPZbwyMjNQaFe2Q3oCEqMyRwSOUQRm6+n4q6tbggNu
         vZFA==
X-Forwarded-Encrypted: i=1; AKwUvBw8J2b4r9bMyRwyKVAm1sVooWa5eyj+W0HxT4cCQKlyqxgvC6ZruegryTh02WtoupZycxZnIIHApUAvTtWCjYI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMev9uL+ca4QW4HPQ+1vwK289mzuBbCz7mCF3Ci4qUweFBZxzs
	vieumpaxTOtJRnTjLLadnVmq291fE8r+zYkAM3ODwdYo89BBHJJ+rBCENC/OjI27VvG2Y9Ufe69
	i6Czvdl6TP6zw3RlQlOHkRRdAy1URxf34Y3QdaLUSRoD2pgRuC3AgVhKfekVpDt+rxfRTr4U=
X-Gm-Gg: AYBFou0f3QvptakONFAQzEkDmLWNDBmoQTZa6mX9gIAwMeACBugd/g52PIlnxu3ZoCQ
	QIS9T4Ci0JTz+dWN10stp8EQ0woNE8Jh7Cwm+IJlp1vVyIUPI/AflXmy0RB6Nj5QKTEF/ox1Y7v
	Bc1t5zHTKvNmQMFWkL7ZizKgHvytpnhlZwuo362ssx7BZShUSYncWnfJe/dHpMTDXEdxDMGRvWE
	epmcgELKoeSA+5/sPBt9vpQWXWMQAzyONMRownC83tPMOAAIkaSa96nZ8Avv98FdcidaTUejRPj
	ulDRsQHA1NVbajZXZ5KpmB8dDjBkM0jE5tWyquXDbTDVnoRmUe7LHCZPAk/2WAQJW17gPRjHsMS
	j8OufEG/EqnCHAEIpSWylTu4Jys8uYQRm1GWB+G9yGNyRoZ4abXKbGd9rPg==
X-Received: by 2002:a05:701b:2411:b0:147:a685:9125 with SMTP id a92af1059eb24-16a56c9f443mr25855989c88.2.1792100480856;
        Thu, 15 Oct 2026 14:41:20 -0700 (PDT)
X-Received: by 2002:a05:701b:2411:b0:147:a685:9125 with SMTP id a92af1059eb24-16a56c9f443mr25855932c88.2.1792100479947;
        Thu, 15 Oct 2026 14:41:19 -0700 (PDT)
Received: from [192.168.1.20] (33.sub-75-218-193.myvzw.com. [75.218.193.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b859142sm302156c88.18.2026.10.15.14.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 14:41:19 -0700 (PDT)
Message-ID: <8ed23bd7-f783-47c4-8a30-bfdf74e95015@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 14:41:17 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/5] nvmem: Add UEFI variable NVMEM provider
To: Bartosz Golaszewski <brgl@kernel.org>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
References: <20261014-b4-nvmem-efivar-v1-0-187c85f65018@oss.qualcomm.com>
 <20261014-b4-nvmem-efivar-v1-2-187c85f65018@oss.qualcomm.com>
 <CAMRc=McDsv0k0bD2LoaXfOh7uyFo=HRyO098H=N=QeMFDXsLKQ@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAMRc=McDsv0k0bD2LoaXfOh7uyFo=HRyO098H=N=QeMFDXsLKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NiBTYWx0ZWRfX59fiU/bI5wNd
 RqeYI1BwUIv7Sg0wksehoVzKSc4rUeB5GLEZzME0vy59tAZ7V8s5YxnnwMDZJGzR8KjU9F/nXE0
 GByMOw1JqnGTynsyXpBdHJxTmiuVcfx7XsVWEUJQSyUGQP8vk0dIwxjbjVKZblXhk18qIikkLe9
 0Oyw+sPRkbWe1GL0BWIeLyY43P8Y6tX9W09ksvh1JX70eh7XIADJUly56+zdhLhGevsIGAPWFaS
 dA6GB3w83tdyGPTnDtJCrSBWHYNl/0Kyx4XhFtyGSN7AmS3zr6Re7oBQBDUXDSlm6e36/jahR95
 OUMI/SWGhT01s+DcqozhMpd6PTUWmWGMcv7rsCq6te1LtwTNDvYIaKu9ozzGJ40FvfLK0Jh8c78
 hJq8YSuAWX+L2nuuuV1+GuejDDgGAQeEAm8eTs+A5IuhLvx1clYWWQWXQ+ALZM42tDSFcCGXRF7
 lYOry1hJI0z7SyPYQ5Q==
X-Proofpoint-ORIG-GUID: 62zdQhX90CDLkKKBPlc7s8nr4UT7y5lB
X-Proofpoint-GUID: 62zdQhX90CDLkKKBPlc7s8nr4UT7y5lB
X-Authority-Analysis: v=2.4 cv=G/CJgNk5 c=1 sm=1 tr=0 ts=6ad14884 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=AnolQpdaNwb4XK4FG+QP+g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=S4S59HBQktVEhwL6IfYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NiBTYWx0ZWRfXzXqFRpA+iBx3
 0vpzNbXrYuatl0pPAVZxYOMpUzv0u9ZcMTVM8O4koQiomXsxFQxHQW6TFziIEaGahYxG636vJ/J
 d7lpsagL0doCzn18+KYhhKeE/dSiFXg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150086

On 10/15/2026 6:22 AM, Bartosz Golaszewski wrote:
> On Wed, 14 Oct 2026 15:02:40 +0200, Abel Vesa <abel.vesa@oss.qualcomm.com> said:
>> +static int efivar_nvmem_find_guid(const efi_char16_t *want, efi_guid_t *out)
>> +{
>> +	unsigned long max = 512; /* in UCS-2 chars; variable names are short */
>> +	efi_char16_t *name;
>> +	efi_guid_t vendor = {};
>> +	efi_status_t status;
>> +	int ret = -ENODEV;
>> +
>> +	name = kcalloc(max, sizeof(*name), GFP_KERNEL);
> 
> efi_char_16t *name __free(kfree) = kcalloc(...);

	= kzalloc_objs(*name, max); ??

