Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC85134751E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774434236; cv=none; b=HpzIp6hRismi96i0Ovrg3QJ3dU1C8HCtoJVXJ6HeiW8MRC52O74Ch0mOkiWEh1JTwoSy/SIAcpfQfdBPX3Og7uB1I13pagHiPWVYYWrmzpTtaHxVOIorv6GJ/QVIHijkggJKp5lIgXZ21CdLBZHEC6JcvjYQTgGewvdzHTYEv6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774434236; c=relaxed/simple;
	bh=tiugVCApbLnreQybVLzJSsSQbksTSsmN0ivYj7TsXU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YT63tzgaJ7ueL0b5b/0RPSuZHydQSHiZZMfQ8+tveqQX8QCQ7DPJL38k2Fdy+W47nERW9jjw/CslY0Eu9TvWV5VJTPKjt/vzQF1bfVC8PiHadZczgvafHyW20NhXGt7h8HTIWFVH1kMvshMa3PSiF60RSPHrnv2hQ1A1f9s1prU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZtRvWoIZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fI8t5UNM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZtRvWoIZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fI8t5UNM"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PAEGSN919620
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 10:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r9EdSi7+IKe5aYDc3/lI8XYHiIIlvxsHXy20MZv5RDQ=; b=ZtRvWoIZzbNPKY2d
	6F3mUleJTLJe95l6OBvmnaX9USdBTdXome/Pzc/CHuFzWvuiRSflCDaUZkJy+BKZ
	4bSXpq99PYefbrDPaIfTjlpzX6uhwA1QtleHCLr3JaGhLWe+5HjTFw2kVmGNAU2D
	Gz5g2A+smS97eyRQQMhIGWWeScmTqsamu5cgt4nTjPy5oSthabGvYqt/vCEFuf+h
	fPvoYR0P14DhBCBIpA1NvorsQT8OkfAN7Qk5JuGcevQb2WRs20geo5R/ZORQAm0Z
	F9lS88wjeCUBMczXeOxm1F/ZPnQCWNOgwDHVxRYrRH5nvzJT4cZ+weDFkgDsDy9r
	qCUIiQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d489mhbdf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 10:23:52 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so4731791eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774434232; x=1775039032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9EdSi7+IKe5aYDc3/lI8XYHiIIlvxsHXy20MZv5RDQ=;
        b=fI8t5UNMtUFbRWfLmDU4QHtOnU8oLOnt5pjN7Y6/udUnMtzNiOqcval/lby7hEvvRP
         sNiX+VtwkVLI2H3tEI2vIQEXrXef4wQ6YigbBFcFmcQYc5dZfL8u9lQQ7WNb41QVapG4
         tnv6b2RJbpGA/GJa0UGAF59GcJ7J5zpY8EG9FrJmNCqjITyRA7QI4Nty/OUkrSYVFoYE
         5gTojUZqlGxZRFyEDullsdNFGaPAtsFRtNOOQDkSEJ1SCfdpbKkN59nO3o0ArUrYRw/m
         EkX6fUiw6S4ImNYt9frcOm40MgLbIcYu3YblYD/etTWQLZcoECgezbbxxrW7juWsHYuR
         J2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774434232; x=1775039032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9EdSi7+IKe5aYDc3/lI8XYHiIIlvxsHXy20MZv5RDQ=;
        b=MdxkImHXGFBgge9FNM01tgr8e+KuBpXQeXx0xcoXevomDvunFGZEhuuLgP1rL07JC8
         jGySL2iHYqDhaQREhPmKgpdyOuCK3guLZrHMp13SBIGKdZTpyKvPe1htdddKJaw9nb0w
         ANapU+vQZXkpByc8pSH5AJ20RBbfMplmtj2+hglxc0Aveoww4GVIZ6oDOjKiDZw5lDKH
         AwoJec2ucMJRP1Uzm61k3GJbg5BmMDOEcOaJw2uIcowTs0XLMeBHgbWV4SlAwLwIiM1A
         SiDJwNxMzwrTg4y7ryYBWIjd5mO0I3HRmE+zJbrCubvMpzJpPEmkCL+UCB0A5b0sf2iA
         bLcg==
X-Forwarded-Encrypted: i=1; AJvYcCX3L/NvGfsPnMbxT2gBQybWW5q/4HNzNnIraNJQG29FdTg7GF4p4AfgeGgcMLZHmEWv0Su4Wr/suFEdluPGVhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGtUzjOlH7+u2aZoDjgvzoVHfRjdUy1VscYSOK1m37rG7EviBQ
	RuCpdpX87Npmwk/ekVV/P28Iwk/ylOHCjqapyQMbgJcSTTEB9eqvkCUzpL/nHKCze4Lyp4W8fpR
	CVtHFITRMMPdvsKghhwn+4ZEz6ax/LYM7ab+hX283e+l1lAex1O+qZNpZ0RPy5QbAIXCCMbQ=
X-Gm-Gg: ATEYQzxQYJ6QzU6KCNAC04Om0/Q54qu+kfGlS567hkuauEqk/g5ksYpDdaGwxrn42ZG
	fESSKcPKQMyfo9EUi6LHsaYlHcBwvFWFTD4SI2AUUqFAHR8vWZ/ZKSdFwsY5mwEZrFwFi87KUqS
	EkQJVVqXd2GVCHqJgDGMvgG6QUJUY1C9F/Usmch1bHZWy2mq5wi9WXsr6Qlq+JKcxYcIcNwSepD
	WLp9x4rLm+F2Yonwr1fQF02YZ8dRNtrmAfMm3zAGipuYnQVFENRaBPZP6Lb4zLMENUfia+81T8m
	db+OXuVybs8Dbfyr2VdbRQRiRx73LQcktgPM+ymB5YwVQYAW5A/6ZUUL+gLKGzZZ6CXsV+2LvmH
	r5SGFWtQc846/ova0dMHe/K9fmVdiPkNSPad6W9xHymwqWssNRXzy258gpAa/23mEaQGfZ3gvEl
	bP
X-Received: by 2002:a05:7300:fb87:b0:2ba:68d6:47ae with SMTP id 5a478bee46e88-2c15d3f77fbmr1590186eec.34.1774434232233;
        Wed, 25 Mar 2026 03:23:52 -0700 (PDT)
X-Received: by 2002:a05:7300:fb87:b0:2ba:68d6:47ae with SMTP id 5a478bee46e88-2c15d3f77fbmr1590158eec.34.1774434231682;
        Wed, 25 Mar 2026 03:23:51 -0700 (PDT)
Received: from [10.110.10.38] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17d1ddsm17511082eec.11.2026.03.25.03.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 03:23:51 -0700 (PDT)
Message-ID: <e779ca66-c927-410f-b84c-54df6aed5913@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 18:23:46 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: hci_qca: disable power control for WCN7850
 when bt_en is not defined
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
References: <20260324023016.3889062-1-shuai.zhang@oss.qualcomm.com>
 <CAMRc=Mf4gVhwUZ8t1jQ_ohX9dfGcAX7ay3WGZP+LmsTM87xL8w@mail.gmail.com>
 <CABBYNZJciviNAL_n4ce+Ncn-bHn1utcBj4VVJGFhpYMRZxrH5g@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <CABBYNZJciviNAL_n4ce+Ncn-bHn1utcBj4VVJGFhpYMRZxrH5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA3MyBTYWx0ZWRfX4woa4eVIYJDW
 YHIvKjCMVkB3xEpPaLpBi6lkp20YlpAJD7iKeDhi1UhgroRlo3/2Yzlj9l1zoVZre/g/rXn0/9I
 UG2Kx1PT/kbxu7cj10Imck2YnFiU+mXPRYZ/RHsMUtlPST+2Kj80FetXQ59WATZyPzVPGYN8Sf+
 mgVS+69V7D+haU4P/18Gw+dChED0cE7MvyLM0EDyl6lUT3IwiPI4YL2PNIkLde6cxXCWgNUp2K2
 BSTf7Cvq8hIMT8WODm4RFVbonuowogMJjFyid+10CrW52TR0m1B9N5WQC5PsXO6GolKEBvGJkk5
 dMetcNTVok8H8CZZdS54y9Bix7E0dFZDMAkjHdNWGeMDhipM0vGR2Iq4oQgmQEevqreyvfr0Nz6
 +pzC50DOfVE9+7st0eDN47QJs1zBQen2vRY+nAZCXwOr7/VOXWaU5XBItFRiQrAh3yWVqIuWrri
 ftJLGSra3kbGY4VixXg==
X-Proofpoint-GUID: BxbUL5YXbjldwldAlbMChu_T8q_EXn8d
X-Proofpoint-ORIG-GUID: BxbUL5YXbjldwldAlbMChu_T8q_EXn8d
X-Authority-Analysis: v=2.4 cv=AKSYvs3t c=1 sm=1 tr=0 ts=69c3b7b8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=LITGez8UpPA1zbsMazEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250073

Hi Luiz

On 3/25/2026 4:01 AM, Luiz Augusto von Dentz wrote:
> Hi Shuai,
>
> On Tue, Mar 24, 2026 at 6:33 AM Bartosz Golaszewski <brgl@kernel.org> wrote:
>> On Tue, Mar 24, 2026 at 3:30 AM Shuai Zhang
>> <shuai.zhang@oss.qualcomm.com> wrote:
>>> On platforms using an M.2 slot with both UART and USB support, bt_en is
>>> pulled high by hardware. In this case, software-based power control
>>> should be disabled. The current platforms are Lemans-EVK and Monaco-EVK.
>>>
>>> Add QCA_WCN7850 to the existing condition so that power_ctrl_enabled is
>>> cleared when bt_en is not software-controlled (or absent), aligning its
>>> behavior with WCN6750 and WCN6855
>>>
>>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>>> ---
>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Let's check if the following is true before I push it:
>
> https://sashiko.dev/#/patchset/20260324023016.3889062-1-shuai.zhang%40oss.qualcomm.com

The question raised by this check is whether |qca_power_shutdown()| 
properly considers WCN7850.
WCN7850 does not need any special handling and is intentionally covered 
by the default case in |qca_power_shutdown()|.


Thanks,

Shuai

