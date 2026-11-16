Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820250;
	b=z1sP4RFvpJx8B9l4ICxTb3eqYK3YooJKgfdwDFqO2H56EvIqlbbtljoMdYl61E90FIjh
	 rfKDE8xV78Phe+jDB/AYm2IArx3cnrGWkkKaa4fC3nO1t6JLNxTfBIWQwK4iB3GthMDd0
	 qOkG7mI66FcihjEv+1p4zX6RXUiXJTOsh66AWmKOJ6NofQNEL2tsDZaedYhXPdup7bbBO
	 zQlarIF6JVPoRLSVBTL+wZvqP0c5I6q21PmpM6K52X4CjPJw1tFTbh5hcfytwJUfCcIxh
	 YtCEBoPYNw+W0iI6OEsZVEwSINZmyrodkBxtpMOE19o3O804PMPg0KfZbS0LZHpPmHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820250;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qL1enoX6YtVLLvPehL7m3Kp4mumHcRuCheMf0bdXEq8=;
	b=zaLxVgNLbKkK3ZgDjfvr6WgXDeV1kWjxe3ug4g7GLIwv0AFfLmLXFJEMIX0MObwm3i0R
	 VxT7WYxP4N7GP87Prn2JmpBHVd82lfAi7rDeCZr//LdKUYmlQYgcOzZfhEyahlLX6gorv
	 I/rQYF8inVbHbnAgOmbr/nVEevuLP2og9jpzdessPerCPjBxUJKqOZkYEkOb9kbQkCaz8
	 trTv7gWR6HZXIX000POySX1ZKR75hfj0wYNOFqErBEbr9NPa/8xeptCJNCkjKL/MISE3s
	 /PCqAhnmRkXsPVG5aJKrVv/pYdxw3DU3vm3JjVjviC9jtiLftf9YHD8oi6arsxprRog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cxbgsMKv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HMYkR62L;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C38606A31C
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61C38606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cxbgsMKv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HMYkR62L
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7ewqW3488782
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qL1enoX6YtVLLvPehL7m3Kp4mumHcRuCheMf0bdXEq8=; b=cxbgsMKvnwbP/If7
	SN4BWt/tR4emAef+3S8QMZUkhWwHp6NaKRWs+AgfbcRNaE155KtFN9BKDKtWZP02
	igx5S+i3ayT3G72Ij0WQMUy6RzDJdkMWEMIJDiD/80ANxyGw2sPFwCT5ESAtDo5S
	J2xDS6e2Ikg0RKV4feW2ybvKb2xGXtRVVJP4oNidtjRDquCY90NnRWZuxNMMhYGX
	XDo9ssK1RcEXV0x4sjeLA6iHBMaPf6+E3SiILRddtDQT0QdV/r+Famk6INYBXebz
	q/mzs2iImEKqK/MkINDivu4JrEpJMKNky4kK/8jidGVNiTm1VjFqLwtV3FFXhWON
	da31QQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmcdncs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:10:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-375f0fd31f4so1699465eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 01:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794820249; x=1795425049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qL1enoX6YtVLLvPehL7m3Kp4mumHcRuCheMf0bdXEq8=;
        b=HMYkR62L2AhrjkVKUG3Bo5UM6ailHK1vtNhM4qTNpcH4xM3bRtxDFAb6twuhl5qucn
         ZdxB+4y68o4yT5Djk25ILfuEwhc7/1QgpNZ+WoipPGISAxuCZ4vX2Y/1eLNUV0VB5QA2
         Gl+KAapmJ0hffGNWKY6U9s0s/EvvtdCNk4BW9NO7bDhdqLdcAZkyEgTc5ufpUD60Emar
         2aR/mkgJhKF5KWvamvHWcVTasy0yvc/pO+4sjCsWH9WIfSg2mhvnQSfU/pppX6m4YFSV
         9JzaMeMmr8hEoDxSwLkrKt4h2ZWgj4rvnMrbYoBNEEcsvYdW+jAHnbuqrrmZC9l1qDME
         XsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794820249; x=1795425049;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qL1enoX6YtVLLvPehL7m3Kp4mumHcRuCheMf0bdXEq8=;
        b=IfGyZxVP2U0DnH+NN+io3s9i0554iE06H6A2fgp3+VqEHpadC7DyZ2jjnEd86Gzxk9
         FTlp4fY8gMhz/RLmkqjwR8vIA1MZR2PfGcr20Zt42mVyY65ZJX9EIvusO5TRkWIXN8XY
         WaESoV4zwjM31Kt0nWaP3w+AkCP51yRxXQO4uZp2N+lC0xnCFoYwkwtz0E/aEIoUVw3q
         X8TV406fvGXqQBL8fwpQKzxRYnT+zaI9FQDcs0w2SzFe47gqI8HxigH2j7OkiG6VHB9U
         Qi74R2vzS2GOM8mwdHLpnGL5gViGEhYYPpcUtJYl4LmVjAzQhrZKXoysIurP92TxPtJG
         KlDw==
X-Gm-Message-State: APuU4Z/v6G6G+kVB5Psi6JmkQ3KgYkeOITQrQASL+yPVh2wCegDJVKrJ
	iLBlYC9Ij+d5CnyEIMoxUiNh6pxMdlD6li4qZmwpqHoX+EC8HonhFR5LTDNp0zHN8NDNQ/NHAkj
	1QWV71YlWFNhBMjuU+Nb+etKvkIP+AFBr6fAND45bzkavaimljaEhCBv6bgoRcaopTd2ftpo=
X-Gm-Gg: AZFdTZc6lsynZInJgz3qbzvVE00uUXCnpWB20HWQGqnujMBxqZwLdoAz94L+Wxs5w1G
	A9rCJb+Wsa4CL1dc5xOGnvXM7/+a3hS4QTlt142ngbVCF1EQQb00K52/+hiXoj28LIiPp02+rUM
	VvV4r1tFr9MSoKDm6EJZZHRmUHQloO9W/8s4dM5rdHO0fjaG69u3ayhdPhIBKeKvp0mXrh/Fd6/
	U5vs3cAbjrVrEGcTHKT6YNCQAjss9O5MW0VCFw2C2dcuZ++PG+tkgYWcv7EGCAtZfIw7UUkyGJr
	2DdcdrqDjyo1svQvZRAbtLnISc8TggOKuvBEdhBgTz1kZnaU3HURv+VJ/QeORZPvSZeDdp93uuP
	EBqveoYmjxbVQij4Xk3mNsq6RkURgEyCiexa0YjgYBSvaJOv7bw9oQSavTpbal3Jzqjo/QIpEz8
	hTzfyIA8c8vMTdGP0b7J/TJg==
X-Received: by 2002:a05:7301:e2e:b0:376:40db:faec with SMTP id 5a478bee46e88-3796676fd14mr8157188eec.10.1794820248623;
        Mon, 16 Nov 2026 01:10:48 -0800 (PST)
X-Received: by 2002:a05:7301:e2e:b0:376:40db:faec with SMTP id 5a478bee46e88-3796676fd14mr8157166eec.10.1794820248116;
        Mon, 16 Nov 2026 01:10:48 -0800 (PST)
Received: from [10.110.59.24] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316f2sm33775116eec.9.2026.11.16.01.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 01:10:47 -0800 (PST)
Message-ID: <ed254e85-d484-4601-bb34-2dc5edc4c06a@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 17:10:44 +0800
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v2 01/20] obexd/pbap: Fix PRODID property name
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
References: <20261111094425.1444893-1-jinwang.li@oss.qualcomm.com>
 <20261111094425.1444893-2-jinwang.li@oss.qualcomm.com>
 <CABBYNZJ=rFAEiQ9KxwTAQfZ+nsuudYaVZgyEr01eqBxaZBMuLg@mail.gmail.com>
Content-Language: en-US
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
In-Reply-To: <CABBYNZJ=rFAEiQ9KxwTAQfZ+nsuudYaVZgyEr01eqBxaZBMuLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX75a+oREiZr9O
 lXThPcUagLMDewhkSyXoR08mdvJSCyh23/xARjNwHGY3Dyb8hpXpC2XDt6GNd9/SiugEHlLtsqw
 ZiYNyR5Y7N4vTa44gqIXTbDgL9T+n2A=
X-Proofpoint-ORIG-GUID: j01M8WbeDvMXS3ZxYhwim9F3Qm0t5qqg
X-Proofpoint-GUID: j01M8WbeDvMXS3ZxYhwim9F3Qm0t5qqg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX44uYOIlsuNh/
 Iq+dkanWQZEt3pqL0nHc/oJvs5za3LJ27xAA4gLHFl3GISVhrG2IeYqq60LitQecG/2kE+qtPaX
 8Mu/mR0QzhsVoH7IwUBDVPJFglcbrGMBY7YYP2J/oERVJVW7KtRweK6zLfYuIU0VSmoYGGaTEFp
 Jucf58r4FipaKzTs2X/6TkXdEoQMqR1GkjVPbIpP2Sxa4hcBmHvJ1WkDF5f+tCRhUFXIEjGc4yV
 UiM7fE9Du8X5KC8VF6g1f8monrVZVo3TNvzHqX2TEK8ZnkZjs40iO+rJE4OK89eBe0L0l/vWY3W
 3w0nn4VWq+WvpObhNnnvngyXjo8iV+sIvi6w++9StCSErUn58sbp5ocVvDfnjA9VQttyUAn4aoU
 MFgbMs5ReccmHCQ0D52X/TPwhVqgTg+OCdJ70aGUx3FGnbOzAUxLIeBIYCdT1JfGGLyfBy5YQTk
 E1E1pY1BNiUSnHHIMPg==
X-Authority-Analysis: v=2.4 cv=Vpy2kO2n c=1 sm=1 tr=0 ts=6afac899 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KLU3AMMsSL419TKnaAkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036

Hi Luiz,

On 11/11/2026 11:50 PM, Luiz Augusto von Dentz wrote:
> Hi Jinwang,
> 
> On Wed, Nov 11, 2026 at 4:44 AM Jinwang Li <jinwang.li@oss.qualcomm.com> wrote:
>>
>> Use the standard PRODID spelling in the PBAP property tables and filter
>> mask so PropertySelector and vCardSelector bit 25 match the property.
>>
>> Fixes: 3a1e6b3e8dc1 ("obexd: Implement Filter related function for PBAP client")
>> Fixes: 4f805f5e09f3 ("obexd: Add EVCard filter for PullPhoneBook")
>> Fixes: c8e98708ea3a ("obexd: Add support to all fields required by vCard 3.0")
>> Assisted-by: Claude:claude-sonnet-5-5
>> ---
>>   obexd/client/pbap.c             | 2 +-
>>   obexd/plugins/phonebook-ebook.c | 2 +-
>>   obexd/plugins/vcard.c           | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
>> index 1970d3357..fbd843a4a 100644
>> --- a/obexd/client/pbap.c
>> +++ b/obexd/client/pbap.c
>> @@ -107,7 +107,7 @@ static const char *filter_list[] = {
>>          "KEY",
>>          "NICKNAME",
>>          "CATEGORIES",
>> -       "PROID",
>> +       "PRODID",
>>          "CLASS",
>>          "SORT-STRING",
>>          "X-IRMC-CALL-DATETIME",
>> diff --git a/obexd/plugins/phonebook-ebook.c b/obexd/plugins/phonebook-ebook.c
>> index beb72b22b..d8621b8f9 100644
>> --- a/obexd/plugins/phonebook-ebook.c
>> +++ b/obexd/plugins/phonebook-ebook.c
>> @@ -81,7 +81,7 @@ static const char *attribute_mask[] = {
>>                  "KEY",
>>                  "NICKNAME",
>>   /* 24 */       "CATEGORIES",
>> -               "PROID",
>> +               "PRODID",
>>                  "CLASS",
>>                  "SORT-STRING",
>>   /* 28 */       "X-IRMC-CALL-DATETIME",
>> diff --git a/obexd/plugins/vcard.c b/obexd/plugins/vcard.c
>> index 0a727b729..3827602cc 100644
>> --- a/obexd/plugins/vcard.c
>> +++ b/obexd/plugins/vcard.c
>> @@ -54,7 +54,7 @@
>>   #define FILTER_KEY (1 << 22)
>>   #define FILTER_NICKNAME (1 << 23)
>>   #define FILTER_CATEGORIES (1 << 24)
>> -#define FILTER_PROID (1 << 25)
>> +#define FILTER_PRODID (1 << 25)
>>   #define FILTER_CLASS (1 << 26)
>>   #define FILTER_SORT_STRING (1 << 27)
>>   #define FILTER_X_IRMC_CALL_DATETIME (1 << 28)
>> --
>> 2.34.1
>>
> 
> Copilot flagged some problems:
> 
> https://github.com/bluez/bluez/pull/2794#pullrequestreview-5861421304
> 
> Also next time lease send with a cover letter and a summary of the
> changes since the last version to make easier to follow what has been
> addressed.
Yes, I have sent v3 with a cover letter:
https://lore.kernel.org/all/20261116090634.1222593-1-jinwang.li@oss.qualcomm.com/

> 

