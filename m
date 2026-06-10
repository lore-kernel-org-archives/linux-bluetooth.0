Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26905373BEE
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781077019; cv=none; b=W9zScMvKXOrM7Z/kIoJWu7LNWuPVW2+K0rIh/lR1+fT95KqXmRkjTGEV9GdTasIMYOA6p94Elx+pAsTDRbzmjt/iqcrgBWTEoZtx6/06+nfio5a1MIqnkZLSTytkGWmA3BzZFdssxRREFXenc9Nv/jsDxVvlQQ+oH80CNL/ZIAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781077019; c=relaxed/simple;
	bh=w1EqAl9oC6gy9TGFnBAmf+O1ebSOZtRQoo+gPKAV2YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+d6fjhj8RIlSnyv+jsOrXFWGA+B7ueVf2/S9mlCpj3UbC6DWI4pgSUXPCeyVSU44mE5UC49vdTrss/pLoyvgwBRUsPWOkJ508MRlZgLvyVhyVaO4ifTJ45ocIpzd1OeY/8TjikO1QLGqobCk/B1IDkTIUnAqZaaiDh+BaRgR6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cdCFdCN/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MDLJLQ48; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cdCFdCN/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MDLJLQ48"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A4WhB2571720
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 07:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3TvlMZYZTNJ+ViXfGDLpDEfqok6DEulBwZlUpy+zIAk=; b=cdCFdCN/auu6SSBP
	xPYbfwmoqoMNg5trvNsdnKboi+9fHvzVGBNkBgYn48iYq+fNTF8NNrkLTwa5yp9L
	SDMPRS7VKdfnLfvVa1Z0DXEUlAotxEzl05dbdHdnCF4rQVyGdxlbfbufroj39Hda
	5zFVfrud2YgDDM3Tq7xIj65T/Iw+pkSDJykyko9H8+GTXL+DF6/8VIACXsEJCl0A
	4fwS3vHIKzO0iUBvtSwU35Q8wtTmORYeg8IuK8suHDwo7gbqIoUeIVTf2Bc3aX5q
	/t5+NLEdj2l+RJrzv7ueOSVBRIECBfhJxT9SePO6Fh3CtaObDdH4C1zDUx5kcHEf
	plRM5w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq10a8msn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 07:36:56 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ced08f46b0so134946106d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 00:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781077015; x=1781681815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3TvlMZYZTNJ+ViXfGDLpDEfqok6DEulBwZlUpy+zIAk=;
        b=MDLJLQ48GnXXnw+p67Z+o40NpnUNImWtKK4AhbUoPKC5HVaqLZNXVlcp9u7ITccVWW
         13Gf80rbdU/cMMHxdmEgteEG9hAwO+xlrkmMeDbjSxODy8ylyUNAjQzP3HKxZVZyvNol
         H4RDVroNQLLCszx6SMzNwNMTbBHcSe7HiASFrl4UoOnvJnvIpsEYX4xZExh/N9JiSPFu
         ghBCv/3yfuAAE+HaG87vKUxfn3SwDJ7rXwrFnSyD6cl2WO8Y41pnDFTlw2uEMxZTYDKu
         me0j0mROEU6Xi5uH5xLLOBOAssgWKYmzf4gSkJ906mmFsaKJfwuFRxoPM06U5mWigRWP
         ge9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781077015; x=1781681815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TvlMZYZTNJ+ViXfGDLpDEfqok6DEulBwZlUpy+zIAk=;
        b=hAJia6NzD0J/gnoxVejO9PAiYpYoghu6ItiSZm0Cw974axBQ4qQEuXeAiCOL9ULSDH
         4+S+Mg+CwGE2zGGBVihl7wTq75HA+svXb5qgSLpn3bdZP+rHnga2nvCEhWKcpISIKBXL
         9HoF45jrXtqG+/YrDCOYI6ZqwdCT3uwhA7gx7x0jq1Acx3exVHBujAW8qdTtm8Ib/6Sm
         12I6Ft5LK3BWp7DFJequ4twKex8adlQrwHoOuY4Lghl59k/CKXbwZK1VKHUhPujYJVOq
         AH8zTL6tRNuz2p2cIZr7LbLDiixY07wxloFWbnt1foa+/t10XSZNd9v43OvGdgQEdGdB
         acbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Lii6c5O8Oq2cWvgbEM0NbCJwuhEVWWUFuSDjDB3RlFSreAFfwAF6rskI6ZqCrz5GnV0A4+EdPhpcCZ5PgB9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfl9w85bmRJNCzwJwupYjvJ6MbbR4xm2BUIXX4Hcyu8yc1OUXh
	pEd97wy4t8PGvIYmXlkgDd9ox5dgL8qyPfYQMrx+qbuo1VM8E3a1uhHN6gBHud6VKHtV0d5qYHm
	hZbk3JBdsZ6QWM7qAD6QDAtJs9JA7P2GmkuqrcA/tqmCwIYW5hpFo4foQeG2Xt8QoBrvw+rE=
X-Gm-Gg: Acq92OFTeocTpjL5Hm+IwQD5NmCu3wUFwsjt4DUhnYH309LisMnPZeVldNUjnnhzKm8
	I0ZVrjGRQQMhqccIPqYkn+mqDcWu06y6dBRNgC+KZxSE7qVcfEVEZM1ZvOn+0ZqBrQYSpwMdEGY
	KFXlZrHcxrmeqBlYvB2dNClKRKnJuMczx4uWAn0mpcTDhx1mykgsuG3MGfr1c7yDnIKk+3BhYmy
	RV8frMCuTxXRZ/FsuwsOs2bhqgEUn6lufimn7ldo3A9E0Z0++2rYcOk+0gKj1Z0Z/vNGHifoM8u
	rAmbzYii8d+4Z7E/P4/RQ/n/jnUN6/Yvzlw3PUHRaQDdboEPvt05AkkXikWSpCrTGUGIUWMCRwm
	MuhjGNZS3HWs4EgAkcXFqdz1oVJdGfTf+txzy+xgcMBpu/HSGp23AOCeu/7Y=
X-Received: by 2002:a05:6214:2aa3:b0:8cb:d479:a103 with SMTP id 6a1803df08f44-8cee8cca594mr268263366d6.20.1781077015556;
        Wed, 10 Jun 2026 00:36:55 -0700 (PDT)
X-Received: by 2002:a05:6214:2aa3:b0:8cb:d479:a103 with SMTP id 6a1803df08f44-8cee8cca594mr268263146d6.20.1781077015170;
        Wed, 10 Jun 2026 00:36:55 -0700 (PDT)
Received: from [10.239.31.31] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fa53sm226999946d6.8.2026.06.10.00.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 00:36:54 -0700 (PDT)
Message-ID: <c0eee7b4-50ee-4635-b8d6-fe9cb4ea05a8@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 15:36:46 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: Add BT FW build version to kernel log
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20260609075417.1160702-1-xiuzhuo.shang@oss.qualcomm.com>
 <20260610064232.2385866-1-xiuzhuo.shang@oss.qualcomm.com>
 <CAMRc=MdojC6T1RuqRNE-ssoRw1pKyUHyOS9AD0ROfCpPPOqw1A@mail.gmail.com>
Content-Language: en-US
From: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <CAMRc=MdojC6T1RuqRNE-ssoRw1pKyUHyOS9AD0ROfCpPPOqw1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GoFyPE1C c=1 sm=1 tr=0 ts=6a291418 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=1RIRpg9Uh1mo8reXIgMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: cRrVVGECy_rLH6Tu1NQBZYzUHC4i1AKC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA3MCBTYWx0ZWRfXz0VXb18WhCVw
 hBZBugslxD3ptgNrylykf9R3UJtjx4HGK62XJA9xTauNO6t2yC6N8AgvSdumML6Ha/Ma3n+1V9m
 r0cQwXYodWhrN17VCj6Ipaslzp/2oi5TVb+jHiDuQ4l6eZJTMCtMUlbbHqRIJ8sFKWcnkOzse5g
 qN5DXKepGA9fTOZ1OGhQKUXTMn7J7eDVpMlQXMArKajHJ5KI6QsqHvR0DJ1s21u0CEGBOw3ifxd
 83Xa2Pajru6BU8F9AGUOZaeiZqFkixHPWmDtzc7tbc6l65k7vWvh7Yq+Wk1eiwu5RfMVYheAlJJ
 6TMb4M4KizLbJcrqz7f/OZvG3LcP266aSZuBmtuh3jo9lL2l9KBo6haDOLQcC4hCrTvdSP/4A1V
 TmHJXjrxRMBLf5ETOKGV76KXKSofS6kukcJdLIu2eblvdWZd4/Jh4SaLLB+/bwOU8+xEWZpVVY2
 RbfD/MintGN4bhy2vGg==
X-Proofpoint-GUID: cRrVVGECy_rLH6Tu1NQBZYzUHC4i1AKC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100070

Hi Bart,

The main change in v2 was the commit message — I added the motivation and an example log line as

Paul requested on v1. Carrying your Acked-by (given on v1) forward was just to avoid losing it. So

v2 wasn't sent solely to collect a tag.


Thanks,

Xiuzhuo
 

On 6/10/2026 3:07 PM, Bartosz Golaszewski wrote:
> On Wed, 10 Jun 2026 08:42:32 +0200, Xiuzhuo Shang
> <xiuzhuo.shang@oss.qualcomm.com> said:
>> Firmware version is critical for bug triage. Users reporting issues
>> typically share dmesg output rather than debugfs contents, requiring
>> extra communication rounds to collect this information. Log the FW
>> build version directly to the kernel log so it is immediately
>> available in bug reports.
>>
>> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
>> ---
> 
> Please don't send a new version if all you did is collected a single tag.
> 
> Bart

