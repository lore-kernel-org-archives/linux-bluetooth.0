Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F294D3B95E9
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891005; cv=none; b=QsqspvghU1M9GNNa7s8vZpGxvkndoDRQRw57zAYZ2ykgg8vVY457AN9C1oJ55t1qvNN/5bsQZgffuyqDHP3WekAx08WKGh1Df7kiD2dDGizZrrJyo5P3zXVV3O2iQcACHGJ3SrLucL5Lopi+B3ncalZoYuALq8z1j6K0gjIBTyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891005; c=relaxed/simple;
	bh=FDByvO7Zkxj2/ppm/1SFIDDbY8SXymWaQbTc+zWW+j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2zzCrT6TLhyWor/f0idd7VAJqULc0Pbxn4UAd1avHqqxpdCMiJXVJOi+iIxVhNIpvgrpwv6KdgcRi0Y4pwNTKpJltGSEvyKkjTj2CHvD25ghXcdvsNSF3Y5wQB2tZaoxirnwi2fRBbuo+FO6Jxulef69aFghlHi80uQbp2GENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kf004EIN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PG0hqJtQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kf004EIN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PG0hqJtQ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6615lPRR102934
	for <linux-bluetooth@vger.kernel.org>; Wed, 1 Jul 2026 07:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8QZVPNrc75jh4xZ2Qqn1tugjoE34xSMvtytDPvYC40I=; b=Kf004EIN6YHpz2aP
	4EoHMSY2LZKFzwhiKoa9r5MfS+LlCGJ1QJVwqdhnQlcuLUUX6vFx4m8zERGQqhxx
	yVSg1AUHUKARkQ81L2B3IvIgOnEdTOyKC/VIKRbnzkCZK5ArxzT8rAL2TGhPiDd5
	pM6sBHx0Z1ugOfHKOQf4xrGd5M7XEnNSYAcxCsA5SHSSA1RX+l4asgnls8FoyQJi
	duBjHE8A7qhI9XO9felnuTbmUKD4c3iYNqrIGFMpofvUfhyngRESvFRHfEqH1I4z
	eeL4YgUb348z+RUbRVeaKy+Kt+qE1yvAVgzHMc4JvomFJOt69rwK2qg8bnL1chaV
	5adqHw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jvwarh9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 07:30:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37de9c29aecso527820a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 00:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782891002; x=1783495802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8QZVPNrc75jh4xZ2Qqn1tugjoE34xSMvtytDPvYC40I=;
        b=PG0hqJtQ2c0WhlL2pJqfr1LnKI5JhNVh/fxOEupPV3wflnxErV6x0x8gV2ukkIiosb
         wZsTkTew2uHdGZofY4iNnLtgxL0k+BKusge0QrZpVs7emqLFdMgQK2Sdmc/sqYy+u6E4
         MAxn1ZL7rWdtX87XXPizApDpvTeKtRt3VnsqspMhBpoerySXgBBz3XEJFcFuva45NfBx
         oyzfUFFUwhl0jxmOm1R/vDtpQfuIR1BzwSUt/OKwytfHewFkNYbviMtvdZpYJYbI3ee/
         +7HS+XZkWcalL+qpvHk5Y0ydXbzIsNWpmRwl2qWNsPrSl3mJl1euFpW4zC5cs1XZsYIO
         CaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782891002; x=1783495802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QZVPNrc75jh4xZ2Qqn1tugjoE34xSMvtytDPvYC40I=;
        b=bvAk0RTNG9dAEZTnH7Mv87Ng9aIIFeh6p8MGwD9RcYS+VPtEi1FoO1NcC5/nXWQZEQ
         hMaa6Q43d5gOOdOcI5RuO/PIAnN6UJNWAS4mdjNTz+Uqoa0f8RHq0sWztVf4/ZSWMNBQ
         Uv2W/xFpFjL2bVQIA8S4qNf8TNCdr30+pe+4OFh/D3c9NncmgZAx0L3/BGt8epCo2bI+
         htPF/PK7s+XwGDJ+mNWKkbVPx6upa+JGikaIdJP6VvDZlpdya9Jx9mw87RBPgZirH1SX
         pGZoJAFzOqe4k1VgnyqrS+8ZYr0mk3AvNO41Piy8XJhLINdlkhHJNEdXyDFAoJ78BTly
         ubJQ==
X-Gm-Message-State: AOJu0Yyt3kcuPPphIoLqmqP/mvdtAlUWRzuUOIlt1635fMJf5+JdaVzq
	PEpqg9qW/SyO1LfvlbB+i78+nyPfWUA9gDuF++AGsmzuRuGPxQh+8NvciEVejagJL22KjeALv3D
	zQPTPgDEp6mjfUWM/bFb1/ofThdRyJArKYY181uR4aTO88PEUQnffXdd5qLWPqJKHbpS+rYw=
X-Gm-Gg: AfdE7cm7TcB4DhJUVzhIgi6khdKcVAtcL+brbcpiKRG5ZFVMvzVNAQ+I6gyYHkckjwk
	ByoTZDCi3C6SdRLGl3KOecXKzJmQ4JW779enWkJzIHg3wVzX/dz4XMTL8F1rS/yWq4rPE/5tk87
	BK05+Ub95Z73/VBff8W4lNVwiIWB3/Jf5lqeQhhHGhKyOFUJ2vfXEL9OCDFNGSvZPJrdaPEuHH2
	SLMCqE/DP8UI0o1jnhmQbOnuCJHwGSe8RVYsUxdi/1IaKainqTBv4Tc1InkqxS7VaPUC2ZsBS9s
	FWqgVKlo+jswiVoUGfB29oZuDuK/N8toeMRNq4rfZUIudUX7KhhdcRicUPWanUpy7I/9BNAxC6/
	2AA9mClvamXlZgr3940nAfnxS
X-Received: by 2002:a17:90b:2f05:b0:37f:c2a8:ce45 with SMTP id 98e67ed59e1d1-380aa069680mr569352a91.4.1782891001997;
        Wed, 01 Jul 2026 00:30:01 -0700 (PDT)
X-Received: by 2002:a17:90b:2f05:b0:37f:c2a8:ce45 with SMTP id 98e67ed59e1d1-380aa069680mr569339a91.4.1782891001536;
        Wed, 01 Jul 2026 00:30:01 -0700 (PDT)
Received: from [10.216.2.66] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38096a63715sm1201871a91.10.2026.07.01.00.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 00:30:01 -0700 (PDT)
Message-ID: <3af25223-49b9-49e0-994d-842de5ef34b1@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 12:59:57 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v2 0/6] RAP: Move CS default settings
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260630133940.2461816-1-naga.akella@oss.qualcomm.com>
 <CABBYNZKFO-6XcDa5AVxybcGx9-f2egx98UdAk3dprnnQV_kLVw@mail.gmail.com>
Content-Language: en-US
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
In-Reply-To: <CABBYNZKFO-6XcDa5AVxybcGx9-f2egx98UdAk3dprnnQV_kLVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oBIn9wUhbFuo9vm2OsNlpTAAdgSNhNDp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3NSBTYWx0ZWRfX/Tp6+KqGzTNt
 1dhg5yGthCovCM6BmL6JjZrvYSTeKWew93o77cRa7flEmzScU9gF4eOeWwRZR0hzlGUFzkdfqgZ
 cE1569Pz/gzcaVp9/KOis7LPYuhxohk=
X-Authority-Analysis: v=2.4 cv=JKgLdcKb c=1 sm=1 tr=0 ts=6a44c1fa cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=ROzquoHKwsl7TK6HnrsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: oBIn9wUhbFuo9vm2OsNlpTAAdgSNhNDp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3NSBTYWx0ZWRfX8ndmePko6FmR
 rldg1+BC2Ex1RG3Q7Ns6vnCb+D0/hMJTm4AyK+PZCLLlolE4ATJbdjbwn1ufLADFaUO5w+mfGNN
 3ZMgHlAqcGx+1WlALiFm17BvbS6d2WanSE6/5F5usrGckn6+HaeCXuaRUYuGch57gehE+R4QFts
 xVtkAglj+g8rUrwhFCIWkhQbZFy7VI4WIjSJogKg7zyzhXSjIVSKXMCKLKc7pOeTNk52aNl1FIK
 XGaLLXEDckhqWuMXoRDYobYvMM8c7i9+Mtt6SYWi6b7Cc0zed7GiS6idHaO0VfsnGiCZkUxrwI1
 WXKb3U66d0RbePdN1kjvyd50NrbDjfolnjBDyZhMuhRTjt7osOIb0ViNSX9JhD80YZyo8bNbc9C
 YolO7zTzkUqLqYTujV24Z98BE8Otf2zXSVB0U7KMz/PdGencs/AuIiWMsghOu8ZC82c7s7QkaKC
 BT1rl9R+VMLjs5TbgvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010075

Hi Luiz,

On 7/1/2026 12:04 AM, Luiz Augusto von Dentz wrote:
> Hi Naga,
> 
> On Tue, Jun 30, 2026 at 9:39 AM Naga Bhavani Akella
> <naga.akella@oss.qualcomm.com> wrote:
>>
>> This series removes CS default settings (role, cs_sync_ant_sel, and
>> max_tx_power) from RAP initialization and configuration paths where they
>> do not logically belong.
>>
>> These parameters are measurement-session specific and are already supplied
>> through StartMeasurement. Keeping them in main.conf and passing them during
>> HCI attachment introduces unnecessary duplication and mixes per-session
>> configuration with device initialization.
>>
>> The changes in this series:
>>
>>   1. Remove CS default settings from main.conf parsing and configuration.
>>   2. Update bt_rap_attach_hci() callers to stop passing these parameters.
>>   3. Simplify bt_rap_attach_hci() by removing the corresponding arguments.
>>   4. Remove wrapper API
>>
>> Changes in v2:
>> - Change title for patchset 2 to reduce length
>>
>>
>> Naga Bhavani Akella (6):
>>   shared: remove default settings params from bt_rap_attach_hci
>>   profiles: update bt_rap_attach_hci call to drop def settings
>>   rap: remove CS default settings from main.conf
>>   shared: replace the wrapper API
>>   profiles: replace wrapper API
>>   shared: remove wrapper API
> 
> Why were these wrappers needed in the first place? Were these wrappers
> necessary initially? Are you trying to avoid making too many changes
> at once?
> 
These changes were initially intended to be removed and
replaced with a CS menu option.
After further discussion, we've decided to keep the changes and
also add a CS menu option for configuring them.
Please ignore these changes for now.
>>
>>  profiles/ranging/rap.c     |   5 +-
>>  profiles/ranging/rap_hci.c |  27 +++-----
>>  src/btd.h                  |   7 --
>>  src/main.c                 | 127 +------------------------------------
>>  src/main.conf              |  24 -------
>>  src/shared/rap.h           |   4 +-
>>  6 files changed, 13 insertions(+), 181 deletions(-)
>>
>> --
>>
> 
> 

