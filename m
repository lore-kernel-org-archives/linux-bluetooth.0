Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9A4285CBC
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773900417; cv=none; b=psctM8lUVURJrilQqLl6Ayzkujbf04i55Q8a304vfxT2x5JvDcHAuV6jDY6jeCuytYCd8yyDVo+wuKB3jrXdowlFDXvQrrQrzA6qoWYi8CTK9+wePvjslRtvGEds8hH/FTkMyhDLxicpQWZgtulO/rPO6z739JUeaf9VdH3GwIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773900417; c=relaxed/simple;
	bh=tuzz+J+34e+v12d1pIM+5+fDBvKJYNxsgRFFQyZ9pLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHndPC3aq/8d4OmX3kjWCkLZL4I2mIHH3FUAp4ZshstKxL/xxEPRwUC0ddi1ialxRuVvsD/GfjsAnqkiwshA/6L6AEJ1+0EGWfirEJWMF+Aj8OTD9q2LtGBZfh5N6jvM6/yLjVzxx+PXhDuweguB1r4OmFuYbmobUF5eCuNj8DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hRfgi0aE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ChcD+r2m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hRfgi0aE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ChcD+r2m"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J5XMPx3573727
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 06:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mfFkayWmzGcGFz8dmf5cJhDTpdB88iOly1Hax9oyFqM=; b=hRfgi0aEJwFtYRG7
	mtS6dPH05P680prVpDiWzLOnc4MQKKHFRftHejvdMdzCwQ+ht634ChvNpx626jno
	N4V8UmiDUiUSVQpCUu83wAEnhmnMkS712Q1TA/Q/VfgscX0SRb/GkHJuUnR5uX46
	qqvp4dB5+y4pmGjuLgNO+B8lIpskuASnW/+RH+bNg/55h2EGt2vil6bESnG9rYpj
	P2zvlduLSc+l3rAjP3bphHNy6BJjlrmz/p1ZWYGxvMu1s8/jVDL9SCeELiCDgDOK
	6fbE0GieqCqPNHPSu5HwtNxdDmUEHnwTZFUJbx99k3fKR94A8ZpkWhGEny//dpUk
	ktESuw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d083r8k82-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 06:06:55 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1279caef718so852072c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 23:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773900415; x=1774505215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mfFkayWmzGcGFz8dmf5cJhDTpdB88iOly1Hax9oyFqM=;
        b=ChcD+r2m2mDdmDl/ieNwx7I9908DfTRC+ViwmJSDjAC7F0xclevCNziVJWaKgeKuuO
         aMWpdz+uQXUlgrWeiNpRMlF7KB4EEdRZQStUaRwCQq6gmBK6CAS9v3mGB+QepqMiz214
         4LWlNpcILCZ/ZfxsC6KKttiVOJR4cy5AYmSlSbLrKln4o2D4/b3dVbWmzMQlWElXeT5y
         DIIJd4yyJPX1K41MAAIUBkCTuzsno+xh2KFoR9Eewe0aPC0ExAWR0DTUZ9KwuOUimKHU
         kFepf1WFK5SKE1yH3FchBAxmKh9n3zW0x+b7OdgmgBzJsPfab6bJTSqFI5IEFw6Ynsl7
         rAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773900415; x=1774505215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfFkayWmzGcGFz8dmf5cJhDTpdB88iOly1Hax9oyFqM=;
        b=B6MRfNCmPrSXHdK5WrcMnbaog5xRtvTrfqkPP3b/GC7lQj9luP/512eK3+CvpwffJ7
         e5+QZw8ktt3JHVdtJ8BEBeyHJIf0v1+i+RWfqwWzrZcuDttfvbkzIlZNMBKHewCbRw9I
         wbK8b3FBNNUenATaiG0Ix2LObCzRHLJDV8FruwgEbHOzGJ4OQSiOh+TUJ6OIfqqQQrqd
         OMwXcmw+cjDSn/g0cyP07XINuQdHwsYvxllYO0FeGlD2bEsWzcaTTiVCWxmA1wY3cSEt
         jtANPA452om7vTcn3X2zpFUFcUqUgDoSlpAMrYj3ouYYn63+IfoAWDpuppVZMxrpmYCY
         E3yg==
X-Forwarded-Encrypted: i=1; AJvYcCU6JbR070UfaLI+iK/gElGeSkS3pYfVH9EIvgh3Sbzn/73EYAlnGZiR1NB1wQk2HH4COSoVBF8bZ/in8bjuL1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5+w6vJc0UNXg0TzcLIObo1+bkZvBiq1knlRU+QaPDQ8uULJK
	XixuBJo0fAQ5oJfSx9OX2EPvSshT9uQAaICY5x9gO3it+oBmZLyAmFm34GsDYWD0iBbobtrYQhw
	3uW3IAKIpKOPPhf5Yqog7L3HUH05yBucCO5K4+9d8JZvr4hnaapHZNClJlNmvpzG0F1uRt+4=
X-Gm-Gg: ATEYQzxRZBw5PTe+PE05sd8xDoEYlvNjgeVsl5Nl0PvAvyj6jSS+MlF3Fd7pC5utxZ1
	tIIOyguucAaWXavlwxzOeovw+wO947NgvsnVQn6b32nWRQdGEpniXsN/RcB0WixWsyJ1Oi0914M
	XFGgJuLEeck8IxIIKQNrl15r8lVASDWRReD25wHpe3c9Xp0TthcRRy42PVgBD2pp+ljtEqf2viu
	Aj2LJhVvB8SNVYB7o3iHeZQfYHudbUu+BtaBLH7yTyz/VM+F8hJBSvfCYF8Y5GoUgQxSpAS3IsD
	DJQXnywBob7R05/7QXojKwYpbEodIeQcU9mC5I32SoD95cbRzEKCLmWlcoh5VPJgEEQMLEWC+Hz
	xyeSaUwQYyp7W7dgtMI80IvMXlg5Fws5ojMZWHFVObPZ98Ahe5xETbBgx9ysXKNehTKdcVWyhnt
	8=
X-Received: by 2002:a05:7022:699f:b0:128:d450:bc76 with SMTP id a92af1059eb24-129a712f2ebmr3146739c88.26.1773900414680;
        Wed, 18 Mar 2026 23:06:54 -0700 (PDT)
X-Received: by 2002:a05:7022:699f:b0:128:d450:bc76 with SMTP id a92af1059eb24-129a712f2ebmr3146716c88.26.1773900413990;
        Wed, 18 Mar 2026 23:06:53 -0700 (PDT)
Received: from [10.110.94.9] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a6b5f7ec0sm770542c88.8.2026.03.18.23.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 23:06:53 -0700 (PDT)
Message-ID: <4d6d2597-df3f-4421-8760-ea59a46a3b39@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 14:06:49 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_qca: disable power control for WCN7850
 when bt_en is not defined
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20260319031040.4096297-1-shuai.zhang@oss.qualcomm.com>
 <mcjloavd6jhinb2wgfwihsdtbay5n7zv52tn63kzrabcqwyp26@mh5aet76kl7t>
 <1603a5b0-8edd-4c31-b2d1-344ee7df10ac@oss.qualcomm.com>
 <whqo7o6fu6mytf3hpdrrirptx3fpprnp25as3dnam6n4fo7tjq@dolksuaq4irz>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <whqo7o6fu6mytf3hpdrrirptx3fpprnp25as3dnam6n4fo7tjq@dolksuaq4irz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1beJH5St0Gy3wzq8sf-chq3uTrs9dX1D
X-Proofpoint-ORIG-GUID: 1beJH5St0Gy3wzq8sf-chq3uTrs9dX1D
X-Authority-Analysis: v=2.4 cv=ApTjHe9P c=1 sm=1 tr=0 ts=69bb927f cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=hRsDS7zAxf7RtXvUq6kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA0NSBTYWx0ZWRfXyQ9kAq3uaQcs
 ov37a5OEA6wUwB0kyt1Jf4uCV2D5sHNfqOaVka7owbK8ayOluJL2WHfnJgB/wVQzcIanWCSjo+0
 r/ZvaikMG2ulb7claHrjktZgwkDcusQjmc8yyEk4YRhfPVMqXceYoLJPpomM6H77bVFo1sXvRUE
 IzOaVRMevcRP+qXFc7GDlUkSbyS6DrIHOOI/d8I9r6Ow85d3pK3lAIQykp54jou27Ti6UIlgZsu
 dfOay35c3sOYaeiCRqH9iVO0R3enQ5ot2uvvZ4CECPWbe2H6gbkj+dqlPq0YykKTrpH3RpDDZUN
 04D3XFgXuA4L0ZnkkcC0aaF4z7cCQ20TN/NvgYl5Y/4av+h8mMLRMI++xTzl2Xy7KiQMr0V0Vbd
 VA1vZ75t+om1MC1e54NUtLyqgmWFfdMqJNEIKIfdf2CJkLdNOp0Xk5OK9qsWwX0E/fvWV2Jm1Mh
 cElxnmjABpc5Eq9Ne9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190045


On 3/19/2026 1:42 PM, Dmitry Baryshkov wrote:
> On Thu, Mar 19, 2026 at 01:21:58PM +0800, Shuai Zhang wrote:
>> Hi  Dmitry
>>
>> On 3/19/2026 11:51 AM, Dmitry Baryshkov wrote:
>>> On Thu, Mar 19, 2026 at 11:10:40AM +0800, Shuai Zhang wrote:
>>>> For platforms where the bt_en GPIO is not defined, software-based power
>>>> control should be disabled when power is managed by hardware.
>>> What does it mean for this chip, managing the power in hardware?
>> bt_en is pulled high by hardware,
> In which cases is it applicable?


On platforms using an M.2 slot with both UART and USB support, bt_en is 
pulled high

by hardware. The current platforms are Lemans‑EVK and Monaco‑EVK.


>
>> or described in the device tree as a
>> regular always-on GPIO.
> Why?


This is equivalent to bt_en being pulled high by hardware,

and it applies to the same scenarios and platforms mentioned above.


>
>>
>>>> Add QCA_WCN7850 to the existing condition so that power_ctrl_enabled is
>>>> cleared when bt_en is absent, aligning its behavior with WCN6750 and
>>>> WCN6855.
>>>>
>>>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>>>> ---
>>>>    drivers/bluetooth/hci_qca.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>>> index c17a462aef55..4512ff7cd0c0 100644
>>>> --- a/drivers/bluetooth/hci_qca.c
>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>> @@ -2484,7 +2484,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>>>    		if (!qcadev->bt_en &&
>>>>    		    (data->soc_type == QCA_WCN6750 ||
>>>> -		     data->soc_type == QCA_WCN6855))
>>>> +		     data->soc_type == QCA_WCN6855 ||
>>>> +		     data->soc_type == QCA_WCN7850))
>>>>    			power_ctrl_enabled = false;
>>>>    		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
>>>> -- 
>>>> 2.34.1
>>>>
