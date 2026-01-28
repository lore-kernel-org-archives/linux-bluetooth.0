Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A691532D7DE
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 03:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570284; cv=none; b=dZIGCBd+G5ftsthfKKPleCl/fARWHkay0CJmaVrymhz6D+NP9ddgpQX5eO6LMYr6PzxsDUqba3cZSuRwZm5NcKvQh1PSpM28/bGBXfHB5zJM2jifd4nt1GyrB4bS0Kw29zl4B2kn0rDKT3ZvH1Z+bLZ3fXg3cHKHO7b3j/ALasg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570284; c=relaxed/simple;
	bh=xI3rOJ+0WoDEZlNXsmfPyAwcSEf+WB34/w2LHRTItSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIfVhIcj05BXMSZQWZrrecDvoYjM2cpxOUoH+JwI0J6D+onamjaX/U7vn7rKK0mIivbTo3j072O/RJFIIvMaKxp5dXI0bpDvI/qUrEKhEhhuZQ6aFfPV+qrRgBbYdChZvBmtd5sJ2E3W3RRKSuvTBSqH0iFgV1iQ+oYHI+7j4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jv9JYwrD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RtR4Jk38; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jv9JYwrD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RtR4Jk38"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RHhbpb1952806
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 03:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I0UtFjvW43H+5glJTfI17zUFgzb1nhhk/taov4zYytY=; b=Jv9JYwrDMekOnS6k
	Zv24L5KslB+WYHpMAHFAPQuM1mCVicEYQaVjro7gO65CEnyguPCGxHRlAKYCHjar
	wBFTj2WqNmmQ9Uk6za7Nw7NtcP3IQdkgUm76lhOFmnwW+pvGkYOH2m0ln+HbGQew
	WT8giHB1AvrlVT3zHba9ZWvb11MWDJfS48gGgsMzVFB4EW2GUO0761RqKD8w3PNJ
	KGLWqcMqhA7p6FcUFVteFY1MIxCfdX2CmTgcEbae3N9qdacpUZHyvjjONPi9qUrL
	AKY1XyVZOJzbZYogla1JW2M83ybnKEFl3m/3ehrGIyCtT0f0vkiOpI0csgOIuHRF
	AGnAVw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by2119ks8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 03:17:55 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b75222e9easo18513438eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 19:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769570275; x=1770175075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0UtFjvW43H+5glJTfI17zUFgzb1nhhk/taov4zYytY=;
        b=RtR4Jk38AyjTMV66LpVMRDxS6GoVvucvKYBjo9nLw567vwfIQpjZbG77Tvl1tM63tu
         Me1GYNqJUL5VRSxDfhLlRENJnqOwiveytm1jT+x6jbMmeHgHkcpL/LWJMKS9fzGjp4Kg
         2Z5giF7j1PwTedKKy12u6YikOY5Cm9DQE5aa5YXMgLqe6CesK5oxpDDNpMxu7ffzBsru
         j20fynRyhlViquaujKQ36swco6TFJvtbC3EvGEcN0PdHH6ovQUQAb8se11DSVbktTV1f
         TJjbzBCU7MgFtJfJvvJgOJ3bK37EJMBoUiWqTuEBORtvBphh7W3vpChQ0I/UL6zFiTR7
         2qnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769570275; x=1770175075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0UtFjvW43H+5glJTfI17zUFgzb1nhhk/taov4zYytY=;
        b=VEucg7k3XjZsRPZDJrXJqm9HYelky9zQCj+mv2vJgjPTgfMsHD0TgYqeNlCWYm3M7a
         K0MaWXU16CKK4TeiJd26eXaIBy0Vtv7uWUGyolQPZb5WxpsgdGpd/S416Ful+NFQBfRN
         xqj6lucUYgG2miTO5ASjLQjnZTK2HFiUlKKNCbd/mLZQbN5LPBpQAi8GgkN3dibs/uAG
         CTbJdixMr0DTNdnvJ3jAKbgI459DwykRLgPClHawSXz23iRRfgD1TCn+qJSvIGA428WD
         3mySVVOtA+vD5tYATsZ5l4jlh2kfW0pZB+IbCOC3yd24pHMKdfbjPRrdNXHMdiz56h9l
         ClQA==
X-Forwarded-Encrypted: i=1; AJvYcCU57cbqbdymsVVgdeUIkMiXfbjXXKeqf6zSF0lrYBVTiPJxONCGTnrtSLamFx5Rw7wqDg9IpzpZsHNdsHKn2UE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb0HKRW4nGWxMTzVauy1Vmp+PwgfobUhPAwRv4aYMMQzX7wS/K
	hUnjOy8TMHsFyYqLiE22F3T0TAUYRt1xjd0KGegE2MV4JQVAq2KiEwjMpRb+YPPFb7EUGcg0Sc8
	yQAlQxgJuAdY4FNfzx3qUJwn8g/IA5p2EiWcWdIe4OWdoZE02sud76R/CbRGV6Nf48zWWwbo=
X-Gm-Gg: AZuq6aLDlHxLVxvQ5RrpJIElX3hIiFc7r8y8Fxc2Vqu72TgJjgCPHSxeSgZYvusSyv/
	G6zqCSGJl3KDPBbPLaYTfUaveq59Bm74ZxodD5oMBFhO/RPRmn/SQ49lEinhcWs4ZvWoJHmr/kB
	p9JnUjLxKv7K2AS8G2diZlirn9Z3rmxgM7XMrKMAzIIuuDTqwiQKfSfuwO35DuOnWir8UvyZWKl
	FkQVe056+oMoStbfpm/im9n1bufsimDmc3nxrBOveBmXOwsYbJ4LRY4gYfiMXKPKnFsos+VSMVL
	xfyMNDy5tJsdHH1vdjGrItCwFRwsXkkrzMoeSDSgYKVoKZl9xJPBIuCPPLo9+3idH2ijIASXqoI
	/daKRtLDrBemkQr5MLd1QOuwOCR5N4101bHJxlPhNRAknfiQb0M+vtnFWs0krNw0i
X-Received: by 2002:a05:693c:2c07:b0:2ae:6146:37a8 with SMTP id 5a478bee46e88-2b78d8cb642mr2401387eec.2.1769570275198;
        Tue, 27 Jan 2026 19:17:55 -0800 (PST)
X-Received: by 2002:a05:693c:2c07:b0:2ae:6146:37a8 with SMTP id 5a478bee46e88-2b78d8cb642mr2401368eec.2.1769570274680;
        Tue, 27 Jan 2026 19:17:54 -0800 (PST)
Received: from [10.110.38.177] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cf8d6sm911226eec.3.2026.01.27.19.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 19:17:54 -0800 (PST)
Message-ID: <ca86ca83-1951-433a-9903-a95dd4be23b0@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 11:17:49 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
In-Reply-To: <l2ib5kalse4nop6e6ak5xronejxusnprl4qgz2wxvdw7wpzw6e@aa6fn35id4we>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAyMyBTYWx0ZWRfX9tkHKqBxQDOE
 mo9yg5L0sa/yxXKdhakwQHPl/VFm2RSVj05Y/dtbfVxKgfZMYr/BBIZZdZIefZMHP+WqJfN66bd
 3LQLnNIDICui9chjOMEbGDXwoo44L2g6gx2THGu2okU3H8YFOdqJStjtrcZT3/Linc7sjFqyGS5
 aY1o9uGiGS0yp9/H0dimjT+Xi/juNacYfrJtvjgaWIsE1V2WWToNAkQfuDESsLrra4JUEvGnoq0
 AHeKzyjcb1ZqjcpXbGrGE7MxDdZORnUdJPyTx1q9o0YeB5v/624F6fX/TZmWk2zuk6K68+cD1xu
 +c/6TjIAcOsjd4cUQIeNJMzSxoG7cjnzYPuUgwZZkJCxrYP66zJZXynvPIr+r9TdSMSI0sbyy1d
 zEgcVb7OqAi+cPQBTRX+zRZiQ7b43uFWg9/FFk9Le6kJUl0JpqdDtmdUNm2zPxrqgxp13kZ1yGb
 cWdAJUN65GerrMo2ZOw==
X-Authority-Analysis: v=2.4 cv=GuxPO01C c=1 sm=1 tr=0 ts=69797fe3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=4l2wOaegfIFoHesmqJYA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: vtkkdMlu8Qmoix2HXmBuUGv6-jUPSSvI
X-Proofpoint-ORIG-GUID: vtkkdMlu8Qmoix2HXmBuUGv6-jUPSSvI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280023

Hi, 

On 1/27/2026 11:06 PM, Dmitry Baryshkov wrote:
> On Tue, Jan 27, 2026 at 10:32:58AM +0800, Mengshi Wu wrote:
>>
>>
>> On 1/27/2026 1:51 AM, Dmitry Baryshkov wrote:
>>> On Tue, Jan 27, 2026 at 12:24:44AM +0800, Mengshi Wu wrote:
>>>> Add QCA_CAP_HFP_HW_OFFLOAD capability flag to WCN6855 device
>>>> data structures to enable Hands-Free Profile (HFP) hardware
>>>> offload support on these Qualcomm Bluetooth chipsets.
>>>>
>>>> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
>>>> ---
>>>>  drivers/bluetooth/hci_qca.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>
>>> Any other chips which would benefit from this flag? If you are setting
>>> it for WCN6855, I'd assume that it also applies to WCN7850. Should it be
>>> set for WCN6750?
>>>
>>
>> Thanks for the reminder. This should also apply to WCN7850. WCN6750 is not
>> considered at this time.
> 
> What does it mean? It either supports HFP ofload, or not. Does it?
> 

We have not yet enabled the WCN6750 hardware offload feature from the
software side. Other chips will support this feature subsequently. If
I add the flag too early, it may be kind of misleading since the feature
is not really ready yet.
