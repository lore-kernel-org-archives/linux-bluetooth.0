Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED4C1A0B0E
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781494054; cv=none; b=LDg1z1kODb9LEDk9oem6cxEDn9+X6J11byQhvG2M3C2wzUxqxb+Ui53dQYJRAnDaOp32xrv7e6L28b+ZZmrPGRBuAq5Rhaujt/ZrgaekQa54gHpHhNWG1e30q4jFxE8wYJx4fVSZcByuHGzYRoYziyEqU+MbgPc3/v3QMjwUgKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781494054; c=relaxed/simple;
	bh=8wLDpXhV/J3eJRD1ub1DOXfI7Ih6m/esDW3O+TBLzLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZW4o5BH9KdAyKdvRmICW1IixqxsrhmHod1AZc2A2fylQgGGY5Xu2ax1aMQM5WUpXxUl7JxI/oWswdZ+ITQIDQcFA7v/ZOoyHxrmKq14sTAjmLWsYJmKGro8h29wo67K4lP2iw/SipxI5WBOwfCec0feBFOsTMADU5wFNWw8cFpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HgX6Bx6i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ij49ibTt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HgX6Bx6i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ij49ibTt"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F1hsVW2646490
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 03:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vtQ0N66m1qzYIbSoJN+ny4a37CYzD+xGwJcaHpWLqDc=; b=HgX6Bx6iwBG5RiJN
	KgEQyYwqSH6fH5Hiy1InZgRprlTa4fhRYOFoRZvkQNnyCjJgUdpxR2KKVIpzYGFP
	GgfR7NGFbef7/AmUymLKpDlp+n/bdVFszGb0l2vWJHk563urdMu7GvbQJVAMhUg+
	cSC9UUFui2TR5dvcoJKThcgd2nOqH+JnxGqShzohMocaYUH6jEn47pGuZnScGq38
	fTX2cb+foZI/S7sfVMyXIxyh5g0cMwsPDeOG4DoEYuPQfN8CuFJKENePiupKOWMs
	nwt1ux3zsuyWVMzsjXgCKhQKMsPb0bp1hU6liXyhztS6PnJuyxn/h9tJe3uNvIdG
	fKZINg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eryybw7e2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 03:27:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-915ba226a9bso751278785a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 20:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781494052; x=1782098852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vtQ0N66m1qzYIbSoJN+ny4a37CYzD+xGwJcaHpWLqDc=;
        b=ij49ibTtldSxUuXhRnMCr2F6VyzJ12ITZtHzSz65GiUZVE7yqigXaTjDxJlnjvxere
         k5xPvgYrEkBUeneea4IMe5R1t7wHHigqjCML9NahYeEeybTEQ8pVyF4/Jsp0LhweUWXy
         /GH7ht2t3PumQCEabb0+NMTi6Bzx4pZ6emO0GMfjPSDE8U7sYlpY4zt9XNIJ5GAM5j0S
         27pLLkDCLGnZqjSdumZU438wzK2vMXBF3luN6OmCqIiRYJ3oJ0eJ5QPwopVtBGMsxiOX
         ewlkRBzutRSAJAMrpaR+L7f+6wKsWy06e1IETbDprN2930L8IMHBhPffS29HEbc6rFxG
         7T0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781494052; x=1782098852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtQ0N66m1qzYIbSoJN+ny4a37CYzD+xGwJcaHpWLqDc=;
        b=dfoim+VSLZ6lrSP1V/+T3e180UXoAcE3xWm0srDwNTZNZ1V/FtF5D3O4P9YkEE+Wus
         Ru5j+/ORqoY+Rtf02aV9HCfvGZolTj3vz/HfRaBtaIeb6NRyLxrwlnMnTly3co32qZJp
         9WuqUR3YljZ5skorlPC/4KnAkcodeyq4kA7byXzYWmXTlpn1YsLAO5ijIWkXZmkzDNSF
         TuFm6CBD0/yDAqHroT0qczQ+6A8tfeEAP7ZNij0L06xYaKVaKQofXoiALqXsAKNBGkEU
         c7sSBREHDxKlAyOWI6YawT+/GZVvpquF8E3TGD3Yss4w52b3XZ1d1e3kh3uD+OkqhL6+
         ya4A==
X-Forwarded-Encrypted: i=1; AFNElJ8P3w0nzLquCymd+pZ8fRQzn79mAWIHRUIl0Xo9SHdldAQRRHwkyUYj8CXiRl617et84uDtvvQNlVTKtYc/9aM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1dR7oK6wbOw91nkZT5I1EUu6Tzjgpen2mmMl5MfdLB6mYSm/b
	ZNvpRTpp3sll54DsS2PIOyduV/GGhaJ5FSRvSh/D3jetAqmXHZoDZBvKZgAXDBY1rqWFD7iR5EH
	LRI69UFfVwHHUQUn+1iLXbwi+xZCTbhQZw5FkumMyuiJVSRHpgGxRy656sH5YDp2geXl+2sE=
X-Gm-Gg: Acq92OHm1S1+jDzNBjhVmkPo+KbDEfG1wWIBvFFHCRNE9C/v+/a43dCe0fhhzf9C1z6
	MuOofcf9ATNhXZhBFQcai/n1kTqTClb6+rqshB/OfeH3bte6fMRx2xywF2xDHZwkLaU8REzXhjJ
	+oGPDKcLj3O0YGJMnjSCjLKTc8WtZKbo41bqNH2cvL/9K2DRdYPeENZd2mG9oCTwyI+ymEKwr0s
	Rt3/GvDVvmhVaudwf7dldI1pz/ql6fByVK7RuhCFY2OD4ZFrU+Fe2tUXV4eUCPg33XoGiTk5R4I
	V0mdsQ+It6WF2SAH6Qg9WTsGe/aiuQ9ofoIzDwFeura8AhFcqmseCqGpxOFhlTKdYXFir3kioMT
	iMJJgYE7foLerydRfDUfElAdGkoLUECpmlWkO9CkpZnAQAU5v
X-Received: by 2002:a05:620a:2a15:b0:915:769d:554 with SMTP id af79cd13be357-917f2040654mr1502977285a.46.1781494051907;
        Sun, 14 Jun 2026 20:27:31 -0700 (PDT)
X-Received: by 2002:a05:620a:2a15:b0:915:769d:554 with SMTP id af79cd13be357-917f2040654mr1502974685a.46.1781494051485;
        Sun, 14 Jun 2026 20:27:31 -0700 (PDT)
Received: from [10.239.31.31] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a04b472sm974036985a.37.2026.06.14.20.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 20:27:30 -0700 (PDT)
Message-ID: <5334bdd4-7eb9-43ab-b243-c2153bf29721@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 11:27:21 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: Add BT FW build version to kernel log
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20260609075417.1160702-1-xiuzhuo.shang@oss.qualcomm.com>
 <20260610064232.2385866-1-xiuzhuo.shang@oss.qualcomm.com>
 <CAMRc=MdojC6T1RuqRNE-ssoRw1pKyUHyOS9AD0ROfCpPPOqw1A@mail.gmail.com>
 <c0eee7b4-50ee-4635-b8d6-fe9cb4ea05a8@oss.qualcomm.com>
 <ofpsjpkxrnzbnfza2emhli7xp2gwunknywbig6x7pzhis7yqyy@5z75psmjf5s6>
Content-Language: en-US
From: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <ofpsjpkxrnzbnfza2emhli7xp2gwunknywbig6x7pzhis7yqyy@5z75psmjf5s6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cUrDCeujE6BXAZdLfnRcFejSOZGN2eVb
X-Proofpoint-ORIG-GUID: cUrDCeujE6BXAZdLfnRcFejSOZGN2eVb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDAzMiBTYWx0ZWRfXxJm2rditMB3+
 1D2XyNS9Ej+sKA4jKInLhoJUG+Xz/e7zdlx315fzSJnhWyLcaoPkakM7VGcWFU4eSbZh1Ubdgdj
 h2sn+qGq/BrqjY2/jJFcmuSMedNhb50=
X-Authority-Analysis: v=2.4 cv=JLYLdcKb c=1 sm=1 tr=0 ts=6a2f7125 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=cL4ItX0H0-eYIwf1FeEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDAzMiBTYWx0ZWRfX9AUuSka0Cz1/
 kVAlRtIGkfkiVUqThRUmJg4YIzpMf7Ijotds7TIbxumjkdir+ir41n/MPFBhA4HIHrtZAkY/a/2
 k/ITS1sV/dvHYZ+qkR+2nK/4DUKk3TCMKoji/zYsCuFcNdIRTdQTUWHGOsNQejduy4Ilhp1ShC2
 RUFDdyJm5kr5b35Xu1q1HJGF8XGAczU5Zf+Nuw0wqC+fquIk8VAssL8KGjd728Yr/IUbWnBbcfh
 hXR/Gb49Boza2HpTSgbjEFOdwYy/PxLgPvQrpxQ/9Lt6IXKFBD1blIvVsNb/iDld/rEg6fNBaHc
 uNNqoRXELlp4hdpPwBR3LXwCmowDEg75XzmEwnQLmSsp9N4jkDRHKe53YNwr3ImSatGEwEUAeWU
 lIDQbmXtAWc0KMvHwRbaMsh1bHWhGTsHcKIIAP3Fphrot/Y5zhSAHVI2wxb3NVTttJ3+snjTcxR
 Z+r5VU5XFa/XaJYj9PA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150032



On 6/12/2026 3:42 PM, Dmitry Baryshkov wrote:
> On Wed, Jun 10, 2026 at 03:36:46PM +0800, Xiuzhuo Shang wrote:
>> Hi Bart,
>>
>> The main change in v2 was the commit message — I added the motivation and an example log line as
>>
>> Paul requested on v1. Carrying your Acked-by (given on v1) forward was just to avoid losing it. So
>>
>> v2 wasn't sent solely to collect a tag.
> 
> Please don't send new revisions as a response to the previous
> iterations. Also don't top-post. Responses should go below the questions
> / comments they are intended to answer.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Got it, thanks for your suggestions.
> 
> 
> 
>>
>>
>> Thanks,
>>
>> Xiuzhuo
>>  
>>
>> On 6/10/2026 3:07 PM, Bartosz Golaszewski wrote:
>>> On Wed, 10 Jun 2026 08:42:32 +0200, Xiuzhuo Shang
>>> <xiuzhuo.shang@oss.qualcomm.com> said:
>>>> Firmware version is critical for bug triage. Users reporting issues
>>>> typically share dmesg output rather than debugfs contents, requiring
>>>> extra communication rounds to collect this information. Log the FW
>>>> build version directly to the kernel log so it is immediately
>>>> available in bug reports.
>>>>
>>>> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>>>> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
>>>> ---
>>>
>>> Please don't send a new version if all you did is collected a single tag.
>>>
>>> Bart
>>
> 

