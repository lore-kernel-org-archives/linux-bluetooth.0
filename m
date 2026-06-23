Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91B6370D47
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209633; cv=none; b=fc2ydp6njGhttKak/j+4NjcX5Mu2QJL2LM/x0OcWDYDgqv9qOMa6xftnUk6WhFbhY0KReYBwYNuS5QjU/X/T7rW6+ul6touJ5BuTyZxR1PQACVbMDkrpmyh9b89At3JKfDt8bvVwW67dqM85A2ILWQlizRiyZRom9Vz8pHgjLYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209633; c=relaxed/simple;
	bh=EJXaXSaBfHLWDhV5TxKzmZaa8c2UwWzoscLqN9Fbqfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0gCaWnaNnzm0MU8FMr801uXFynSeghSuiYcuRv32WqS6XxUDTDCoKxDiuGt0qqCfcBFkAz2eXXbwQwKkPpiCy9OD/HYPzlxF9MbhNiyGPBWdcJRG2qrf0IN68VlAWJLBX0TAREvznn6SfoiJebFsjl8WeCSAlzhvE3+uCjrYbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KvTMnO+y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RzrxNdr4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KvTMnO+y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RzrxNdr4"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N8kisg3355629
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 10:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EJXaXSaBfHLWDhV5TxKzmZaa8c2UwWzoscLqN9Fbqfw=; b=KvTMnO+yMyDwn+HT
	9IIPbGMmqupPW41TmZcBK3RqMLuQdMGhEyyfPRuXa6p8UswpvW9Zye6NW4QDKJQM
	qmfcQJcte26IC0ymRlYf4wao0UX6iYt4X2t335LM4wJ3RJjEuXKDhhJpF+CWoBZP
	VDuTIry9BU4d8rEbtM8NYlRQ1giEu+VV3Qy2Ymk5mxK2Awkmq0sJchROCJCaPEKx
	SCYKgVG5ShXRENpennIoTiJF2ey95k12GdKrfeKqCCApYOQofwS3yvON53YCHMxR
	4FdeVBMtX8TNTMgKcFsIYiDpfdG+NlDjK6hmBQ1gqJjf4g6Ta41d9xIQGUnaeRMo
	y8ucIA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eypx38e4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 10:13:51 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84533f2f5a7so1130654b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 03:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782209631; x=1782814431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJXaXSaBfHLWDhV5TxKzmZaa8c2UwWzoscLqN9Fbqfw=;
        b=RzrxNdr44Vl3XKwtFC9BC+6fuN11giwNl+Id/slenrKW08dF13E9rEbC524DI0HiiG
         GxmCaIjPLYS1AnXz8EyV4yXz1KbMTCBd1ON5PWYnkayu+TeCxivsAxwMkWKcMTVmiQSF
         WR3K/xz20LH8AMVs8UZsgWDlpxz2Il5kQtw4ceIjZPz4yUyEgpCxM774ISO1Ra/wF4Kz
         HIGGr1TUVzfmYeoHMIRxM5+FyHkQLtEUkJ2+cvO3vPrc53HjzRt4pH2znF5JwkVZf61N
         IMSVcbIPNH1PFVSLYjiT4zxVkoa9xLr7n/7xJWG7aDia087effXMqYjndS7G55lvwcJO
         lv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782209631; x=1782814431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJXaXSaBfHLWDhV5TxKzmZaa8c2UwWzoscLqN9Fbqfw=;
        b=GSn3RyBEFqMJIgzjP3nJzCE/4eQ6XeNOHbcLluZuNgi0ycLMFUP+aIJf1lImpphZwk
         tp1QOMQZy0Ox7l4GD/2ZApPO1AKxinXlvbAyS1v+UnyXgRgmBcsP2Aw4xhpDNohWzkia
         Y8ylXurmVRh5g/NcrbLzprYUkAREJtU21aAZs0qvNvZv/b19UfoIlfZijqEpBFUtXSUh
         nxWcQb3uy4B8x+7pSp+7ncVm7I4uuE/43LR96Zzm9vLzWgQBfpQfdEAJsNI0FvXPtvMR
         e9i7/z85T9BVDZmkeFbOYd+DcpcnRHiu+gSlm5PjrQpIPJVbnFPz+mpcfRaiaXtBMx0e
         x/GA==
X-Forwarded-Encrypted: i=1; AFNElJ9+JYqTCiovAPTmXHjAZkS95ax91+Z0dK/xtue1WoPFNsDFz5BxeFmxTn8PDhzxa40hJSx6m2xG91N1F3U/gxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPlMJxsjipNg0/+mAgjp0UDeh1GZp09LTqdscaPNJfsH3bMs+7
	0RjZppBf77RvcYHn9BDUflj6MBLVK4fF2Bj8hYOFxLZzzu7VqocGjjZie+qewUCOiwr+fio+Lbg
	9hN6a8OTB6BJ7nHxD7VEpqj3J5AGghRKa4gPT987hX44orGyEn9bE7h9flq3h6OGBv/wNhPw=
X-Gm-Gg: AfdE7cmoPUBcuz18Bbq1jkcOgepXlWKCGmrN0XGrazjh1pGnwyjKtCgCJjKYyiV/Mo5
	jYJP05k9S5VicXm+tlpSRJnQN7SSx46gw+DASAd+tNVM3A+L3y+ObDsL5624yP83cckcoI1AS1P
	UfNIPl+twkuq/FxOXXozVOODBqJjAvonUVWQZQlmQ9mhVukdJnI8oUUSwa/s0PwZTu+YUeiKeCj
	/CJpsK1kIO8C6uB1pITR+DTctN8aNzWcMFXoy+vGo7w+zaweh0vJb2o1nEMpbPoGLviJdygJl2k
	ywG/i2FWSEpy+0rDByLMJ8sdVODMrcg1ZujOsikB2MJeCzZ1juHSvVVpYzmVPyi+PJNxMtE41Ri
	P6ilrVghcVqvL90WhJZzwpfUTLD+eeUe3qa1zKGH9vf/LeTh9/cuKVjHhm0SoUXQDLuWBPv2RVQ
	3whw==
X-Received: by 2002:a05:6a00:2d26:b0:841:dc7e:b42e with SMTP id d2e1a72fcca58-8458f10e66fmr2081622b3a.0.1782209630635;
        Tue, 23 Jun 2026 03:13:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d26:b0:841:dc7e:b42e with SMTP id d2e1a72fcca58-8458f10e66fmr2081602b3a.0.1782209630246;
        Tue, 23 Jun 2026 03:13:50 -0700 (PDT)
Received: from [10.133.33.161] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564da57a0sm11630112b3a.26.2026.06.23.03.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 03:13:49 -0700 (PDT)
Message-ID: <094d24f5-46bb-4225-b86e-4b3f203017de@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 18:13:45 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] Bluetooth: btqca: Fix undetected error HCI status
 in qca_send_reset()
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
 <20260622-bt_bugfix-v1-12-11f936d84e72@oss.qualcomm.com>
 <CAMRc=MemaY=ON2q-Cuzis0sZ9WfqjvBsFzxxCYRZrXeFPNJ0_w@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CAMRc=MemaY=ON2q-Cuzis0sZ9WfqjvBsFzxxCYRZrXeFPNJ0_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EsfiaycA c=1 sm=1 tr=0 ts=6a3a5c5f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=-FsiJwt97AdDbmgBbfIA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: dXx0i3D57Ur__rsD-9fBQp7PTc1CaK0j
X-Proofpoint-GUID: dXx0i3D57Ur__rsD-9fBQp7PTc1CaK0j
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4MyBTYWx0ZWRfX8MUOq72cmStU
 4Yo4C0BsTnM12S6V2OVSdC6en5lgIPusT9+NkNn/rdj5bSwuzw/Nv0bj0gs/e9y/KJKDVMHogF3
 tOeazCJQ8P3jJJRxt5LGqHhkO0Rrdsk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4MyBTYWx0ZWRfX/28lkjFXRo0e
 d2uso7k+V2UFjP45Kdl2on5cvISy53E3nHxmatWx2NxlCyWaZUufH5BstdUjmQLsT/wzQp28fXO
 1Ie3HJRSVmzlAp1E+okOqc24jzX+doPQOzPA8xBH9Xrk6iG910ulQ1ucqWk0EMwx/Ep+UKd7UhL
 QhzsURCd7wzMLql8LJPxAaPzMLhoGBskpDUeoHRSdsqxynNjYqJdCKaB4FDGSe6ax8rfETTWf2r
 Jznm3AVcIPpP3H3er6DcPd0ir955UayGHUgayzpbCSoihsmskztjHbEsMhN6aAMDAGKO51bdahY
 kQnTBlGswp4rO0lE2JaUwmy0Bn46Bp9UR5E3VeexwKetllD8tgE6wChUiNTPkY0Soe9jB3mlFmj
 9ub0h2liUDyvSlEd9wIDMOkfXAXv/pGq2TRAvOldllw+d/LWAFFbG0kee+WDHZmzLWdwFB0+I0Y
 Sw0NSIg9vyJae0/nVbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230083

On 6/23/2026 5:03 PM, Bartosz Golaszewski wrote:
>> Fixes: 83e81961ff7e ("Bluetooth: btqca: Introduce generic QCA ROME support")
>> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
>> ---
> I think the fix should go in the front of the series. Even if it requires the
> new function.

Agreed on the reordering. However, handling HCI status errors for the
reset command needs more discussion before we can finalize the approach,
so the fix may be further optimized accordingly.

