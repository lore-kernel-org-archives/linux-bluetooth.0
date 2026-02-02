Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB51E1DE5
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Feb 2026 02:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769999642; cv=none; b=WBsBbIjjL137KrH21MfRHjWvCQA6yXeZh5yS+w3ER3tuFZoj9oJms0b7WF8p7Y531yNFwHlRCSip0DOd9uBl2A/F/QXSMkazFFsZtiQK1naxHipLKnMGjPA2QZymu7uGEVpRJ/FwTs0IVPSfO8sU1Rce/nuytjgarkob0LemxSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769999642; c=relaxed/simple;
	bh=MELLcgdTeOBlLGZ3a276/DZdy0/3FkE+G/AXRs7LIa0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cSAUw7RwjUwtZLH1AzYpBmDkV9GVA38qNRinZbXg3uNfeqzhPWm6Q0/CDuR35hvvrv+Zd1fmz7IHuB46fmo6RrgoqEBSC7gMeXTW0oOYmf9BvWjMp3AG2F9KmxlZtCYjWbnEDGn8er+Xbko+YaDMPtnp3qGnm3Ve9VUTORsOn0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nhj1aYDS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UOQW0NkE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nhj1aYDS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UOQW0NkE"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 611N0WUD1333070
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Feb 2026 02:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KSc19jatgyhABbwDQVcf+MKfLDKY5uGAjHAzUpJQgQM=; b=nhj1aYDSd14WwhKc
	WGNcPO/UK4ZDveXpuZJjGcm3ltYuVJPcbvdrV/r/7s54ErUIeNUwQAGpu/kioM/S
	OZ6OBXsmPcT3QKghwCUkoOJfT7kvjXpSF2AG+FiHa3GyM3MvMPmRsIucaT2h3hc+
	/G3c3vHiY2pWAH/RNI5zIMobUNQjEYNehB3Tly4lcBUrcPzbGKfJoUa3OkTvH8q/
	vC8cBKafkXZF0tkMsOJzbNo6xLMK5Wzm2Jd2LrHO20YgLf1qtP/Ewu5FCUzkZUjE
	wPAA5WK95kKKh8K//6/dwVj1wDkC3pHo6MdCVMmTwe3fHcPOZ2fxP1nxtk504cZq
	3wmpXQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1arrukx2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Feb 2026 02:34:00 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b724ff60e6so4532101eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Feb 2026 18:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769999639; x=1770604439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KSc19jatgyhABbwDQVcf+MKfLDKY5uGAjHAzUpJQgQM=;
        b=UOQW0NkErEVJZajTqOr4dLY9RP4OxakqZjeLWJ0Vu1QaP94/PEdQ+dZ8Dl8ckF/XgX
         kvxQbsLHZTRGchuYheR22A/iaN7Z3MXpp6tDpKKq+D7x8aCVxC7mfGGLGEaEVZA9luXK
         nVdXdYaj7uxXROynfDFW7RbKfbofrTM09ieYF6EUmsxcjAyQOw0zEnnrDFm7O84KnA98
         tBH6Or+ZUAI2vJjtguTuLIVb3er/gap4o+C/lnqR3XD2BR5rw5i9qJa/c7sWkKbL6KJ5
         iBmaBS3Zhi3LNMF+6Mz0VQgbw6sYN8Mm51MPtGKA6rEXwDOIxxziIfkdAPJHYbSCtwzB
         vfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769999639; x=1770604439;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSc19jatgyhABbwDQVcf+MKfLDKY5uGAjHAzUpJQgQM=;
        b=bjeg+Ljz1IiopbeYk4goKoVgYL33wkhb49Ko3/oEc4OaCFcQ47NuatRRk41iJO7T2A
         GkqxEnLxCPPQGSPDw0q+3oFuIITwKA6cB8XXIawUWwGEm8ieGU1sTDSPCzFE9utPKAfh
         pS6Qpjh/klezvUCqjqZFd3b4PND2gc+fxAhINePCRwKc3+sYgpZULv9jW5vpSiSvnQNv
         gJuFohVpa5Q0VqsQMHPLGlXSGfSg1F659HedkrFPrRRVFJY4S6US4c6A07jUMGpjvzVG
         JT4nQNOc4V2Lg6rhF7zcSF/sGYZj6EjkQLGR07fSVAtxeGKDor8yiRTUqDKDt7REanZy
         mmQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHhnAyKJdFUUnWMY2HRHOnmGPKN1aICbZrLFNkKNC4wMo1Ga3ePOqcVpSzHxKPiURpRJnf/ZNPzig0YFKksUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY6ZlQ0pmkuPfvYctQ69SDRe3SLOPf4RN863pirj/wk8n0r0ct
	1JfrPOh0m/Uucf34mRPEngwKdh7nvb3U6pgNpq9N+QL6trykReaO0IiojD/hyU/cj8bfUGoCWfh
	YSWOX4DjzVMVDyXAakS+ioRP7Dj2NpCepKKtRF/8BbSOP1WRPZK+sDpCFGS9/S19kLPVM/ZU=
X-Gm-Gg: AZuq6aKC+wwzyn5zbd1h8K/SpxS4ravvx7VP5eqFYhCXF85Z1yscqevIroSEYsRLmNR
	nrryCkVbanpyGe825NxEqbSUZZx2wq0KHy+KlANpgXnofoV+ZBCtERMpr4bGhWYwZl7M9UU7hc1
	vjXg4jwzKEHMakO+bd/3X/lkwqa/MMbwrYg0I1RJf6E6J+xDIuQklbGVd734ra4atKUzrul++9H
	sr94JnDOuHcgofGikkZJn6OzqqJeOqwGufMGq8AvRJlgIe8CFH7qiPhLA1lnJz/zGp8yU842nkc
	0hL/dNuxCVz9lhZkC7ikDsbSlxKMNECnRMQscvspP7ektZHj605236X7aVSDA8tVRFyBXLlLZqn
	E/6xHvI83hoimtO03SCfwuWdFPQpiIoM+w2RmungpDihGgUbXhQnoM5hVvpXEnSs=
X-Received: by 2002:a05:7300:8b24:b0:2b7:1e86:35ee with SMTP id 5a478bee46e88-2b7c88dd706mr4544946eec.28.1769999639087;
        Sun, 01 Feb 2026 18:33:59 -0800 (PST)
X-Received: by 2002:a05:7300:8b24:b0:2b7:1e86:35ee with SMTP id 5a478bee46e88-2b7c88dd706mr4544928eec.28.1769999638547;
        Sun, 01 Feb 2026 18:33:58 -0800 (PST)
Received: from [10.110.23.229] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cfa53sm19489212eec.1.2026.02.01.18.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 18:33:58 -0800 (PST)
Message-ID: <800555e0-47ca-4d2f-8193-aeef76cdfcec@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 10:33:53 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_qca: Enable HFP hardware offload
 for WCN6855
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com
References: <20260126162444.4194293-1-mengshi.wu@oss.qualcomm.com>
 <20260126162444.4194293-3-mengshi.wu@oss.qualcomm.com>
 <kej5u2hjxjtfdzmgtebns3amz7gmb5d2nciy45jsyglkprgh6s@kt6fodrc3oll>
 <7b9fec28-2272-4ff7-9575-76e72cecada5@oss.qualcomm.com>
 <l2ib5kalse4nop6e6ak5xronejxusnprl4qgz2wxvdw7wpzw6e@aa6fn35id4we>
 <ca86ca83-1951-433a-9903-a95dd4be23b0@oss.qualcomm.com>
 <cx3yjz2nrwe6iwqorx537qzoz4qc3yefpln5ed7z3ocgeqlwq3@arj7auyyfutl>
Content-Language: en-US
In-Reply-To: <cx3yjz2nrwe6iwqorx537qzoz4qc3yefpln5ed7z3ocgeqlwq3@arj7auyyfutl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TrV_1bZuxPPgYshJ5Vn7PbJUO8roACfk
X-Authority-Analysis: v=2.4 cv=FNYWBuos c=1 sm=1 tr=0 ts=69800d18 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fkBO8gU33Nw6SBaqPCgA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDAyMCBTYWx0ZWRfX4lYf7a9OW8ub
 K2pddBiny8V6m+U6+BVSdBIT842gJNyqKo0Ng/UC5Z4R4UTlruvvCzN6FshHXjNbQeXwW3otRgz
 PmVOBwkHV1kiErIgN6a9/CL+S04poUmtc9knzPs0B7XLCRBW9GSNICukIUBiebERsT53I4saM6x
 g2dMZ5xvuyRAO/i6xS942bVmd4znveH0kRi6VF4Y5aAhD2EcP0SpkUgA0MmnJk0IwUSjErnpv/T
 EHYbjnYdnQbKDlEYHlVoiae5fNUCDswM90l0J9v03pc8mRyyf61SJqNUjzqWMhBp88pHvXPVufq
 cNVlmEMg2nek0erHi5P/+09GuVdn56mjMJeiBibWTlf060XfXDDj+iKB4EbEFNFGt52V6TyfWfC
 d2WBgn3pTHxT791/5OnKU6ZDpZb74HqITgfUkfio93iJH2jgOW1+Fw0SIzkadR+rvXOxIp0Vgdo
 sGH2nufEuflmtJCk/Uw==
X-Proofpoint-GUID: TrV_1bZuxPPgYshJ5Vn7PbJUO8roACfk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_01,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020020

Hi,

On 1/30/2026 10:31 AM, Dmitry Baryshkov wrote:
> On Wed, Jan 28, 2026 at 11:17:49AM +0800, Mengshi Wu wrote:
>> Hi, 
>>
>> On 1/27/2026 11:06 PM, Dmitry Baryshkov wrote:
>>> On Tue, Jan 27, 2026 at 10:32:58AM +0800, Mengshi Wu wrote:
>>>>
>>>>
>>>> On 1/27/2026 1:51 AM, Dmitry Baryshkov wrote:
>>>>> On Tue, Jan 27, 2026 at 12:24:44AM +0800, Mengshi Wu wrote:
>>>>>> Add QCA_CAP_HFP_HW_OFFLOAD capability flag to WCN6855 device
>>>>>> data structures to enable Hands-Free Profile (HFP) hardware
>>>>>> offload support on these Qualcomm Bluetooth chipsets.
>>>>>>
>>>>>> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
>>>>>> ---
>>>>>>  drivers/bluetooth/hci_qca.c | 3 ++-
>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>
>>>>> Any other chips which would benefit from this flag? If you are setting
>>>>> it for WCN6855, I'd assume that it also applies to WCN7850. Should it be
>>>>> set for WCN6750?
>>>>>
>>>>
>>>> Thanks for the reminder. This should also apply to WCN7850. WCN6750 is not
>>>> considered at this time.
>>>
>>> What does it mean? It either supports HFP ofload, or not. Does it?
>>>
>>
>> We have not yet enabled the WCN6750 hardware offload feature from the
>> software side. Other chips will support this feature subsequently. If
>> I add the flag too early, it may be kind of misleading since the feature
>> is not really ready yet.
> 
> By the software side do you mean BT firmware or something else?
> 
Yes, firmware. And we will update firmware later to support this feature.

