Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458622727F3
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 05:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779341740; cv=none; b=FuWRHNjupMS2XmyEHgI6Jxy2F3gXUuuokaR36HzwQhw4YwmkSwqUbO1wb95oREg+td32qCiNHi84FiTTlGX/0sbbDm6ahGfNN2nB32CN075oKa0WI09u3ngADyF5rfz2xuirJFkcnr2HEu5JQnqm9fUYLb6bEAdXTErlDXAJ4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779341740; c=relaxed/simple;
	bh=0atxgMq+szH5Ufv4SL8n5ZphmTuQpkgcylB475e3c0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQGSHE4ypn6ubqjmYWKGXRNx0zJ054NS6Qox4lmv/AD3BBMo43ugoUYK5O1ceqiCDI/kBsAADTy3DzYLCDzGpwRJ6ONrAt2NSKW0Ngq7exQsIg10QUS/b7L4giTujLbTHO46KD2C0fRjXEh7M9eqXav+XqOgdQWpdZFcniulrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jNMfJxW9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rca2qnQz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jNMfJxW9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rca2qnQz"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KL7GQ93680335
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 05:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F0g/JhXVlwOR6OCAZJKqaxDubpWRdBAIJQr0EQvUGow=; b=jNMfJxW9xHBtQUxc
	aKaXEXMq2MFePFXaTmjFkPLcgIN/QTN7bjNQ7ZOV6ewmLKlWQhFFIInsh8Lj3DwP
	ujW/MtBwmc3rSXTAu5CeC/VSMySBaHOIA/Hth6xv7PtZF8OPbLsHdU2nnW4P7+KE
	If7z8jQe2Yvi9EZqb6V0ojRpszUvJQnDrk+gp8WmSSPnHb6gT57QKqXpiK2XfdhW
	XvkJtphpgblqsUkd3z/yiQ5AijpddtjZSLaQ9yMnDtTjCQAtx7SnQOCYYJlfQi3A
	tPswus286wprB8P4L1E2fVwwIQ47r/7glfDB/QM3eZu3X+STz0jQcyQaRrRox2CS
	c7nrOw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j3987-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 05:35:37 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c827adbf00cso2559298a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 22:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779341737; x=1779946537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0g/JhXVlwOR6OCAZJKqaxDubpWRdBAIJQr0EQvUGow=;
        b=Rca2qnQzquIa5lvSIY9IlPwhTMi8cKpktKnnNpvXcpDaM1/sJO5Ba6uNbjcPA1hZqy
         q1v3ir2MQYa67gBPfYQTsK65X2O0P/VPOpsL63LLZIBzcOm0Fsi0BpgaVUFnIgcLsjaD
         xxxmQq+RwRgTMWNsEKL9RQ14pTKWQpAGu/fiwIa16ouGHJzT69gP/JoiizOyrMrbw+Wn
         FL1YF4dRKTPqobJ3m6Irh3E+yJj9JT1TxxJnbKROSf99XMor3KlxnstypeyDy/xK9pLH
         YplNHNvrk1VreMgEJjBU9SBiYFeFuNwsVjdPIEaJ6pDfcGP0lwZyI5bWk4ndkgb6zzmW
         smVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779341737; x=1779946537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0g/JhXVlwOR6OCAZJKqaxDubpWRdBAIJQr0EQvUGow=;
        b=rGNoQPV9NesFB2m6RaUcUJPaLh9uaH1HjyHqjmKaeVAr+JXIjU9fZmhaT5m0YhjS7k
         uX38MbJTxveeRAgoEiGMJE8wjxKECj+Jn2hJ2Q8dd/Bdaxw5wa4Dg8ikxEnkObXVGDKg
         QxCUxU0fDiEKNm6h4xCCWxGc54RzdkBEWe6VqHzEPAZczOhwn25d7Aw3BndNHBaxyBJ8
         TSw1MvQf5Z1jMS2y1lO76/QVL89VyUu5sgf19ab7j7UGtjMrmmGNu/pJ+GmUnkpe8V0x
         +TnaCmmUpFoX4CGJSHa3NyPxae9cEz2HX7I07CljD4J9cgzFV0BMSQ34k+rBRG44GzS3
         OKDg==
X-Forwarded-Encrypted: i=1; AFNElJ/gFsBUa1w4q8t5sRMwLUhtmIKxzYdnb2kgvpXBkiDyE2vLOs751ULHkprBBPKTpVjvgAZ9p9eSUm8E+lD8cDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHf1zs1Bqs6kQmkZnpBjxtzUI6sTHy2EQg2CIgxOCqETGFoHtX
	Ghj48ec2JLdblGwXy0xgke3DFN1QsFPxOMccAyo8uP71ZdilMkN666l7BBds8RSUEwcNzsqukf2
	M+mrX1PLNr7PBf0oZcDcrw97JHHXTpFoAFyOgLDdznfgjsrgWdkjfnxIzeK/PjDnGu74YtX4=
X-Gm-Gg: Acq92OHFMMw3dZcgcxpMVG+Lxba0Zk/+DhZKTon05WaRTlqojEXMFpIXtwOjlLwDgaC
	JlYDFJUi0GNB87srvpux93VoZQAX0Kq0xEvDWIZmSDczZmOVRv+I9hb0xx4Nh4RUiKzytVy0zcr
	+ThtVEKNdFocCrH/DWf3uE5oj7SnXJZIEkTtyRCKpBokefWbMnlzAyGTf1TjAHbWnXivgUR3aNu
	UwbZlg9cPfGpAPO/21NZ8riI6gS6qqRm/gfHsRcOT+xe/gZtg92dnw7N3NGMZpEdh6N2WjhaxDA
	57QrtopbC5ubHbDk94Ijts3Ib3/qD/q58i5Y0FL5pOhAHdIz1jpR6+bhADA4yRE21EUHxFJHhqW
	ylZ7QncOV5r/y9Eqhiezo7sOcubjbEKQhts9xSay6rRM22RwU
X-Received: by 2002:a05:6a20:3d10:b0:3b2:92e0:f987 with SMTP id adf61e73a8af0-3b3085a9947mr1773935637.16.1779341736850;
        Wed, 20 May 2026 22:35:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d10:b0:3b2:92e0:f987 with SMTP id adf61e73a8af0-3b3085a9947mr1773893637.16.1779341736328;
        Wed, 20 May 2026 22:35:36 -0700 (PDT)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82c4031662sm20680540a12.16.2026.05.20.22.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 22:35:35 -0700 (PDT)
Message-ID: <7bd4795a-4e65-4b23-9151-0540bbfeb5f6@oss.qualcomm.com>
Date: Thu, 21 May 2026 13:35:30 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btusb: Allow firmware re-download when
 version matches
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
References: <20260429121207.1306526-1-shuai.zhang@oss.qualcomm.com>
 <CABBYNZLP+rBrjhdKJLE7N47Bg-g4-6E3vS3yZXvMKwYQ2rMcUA@mail.gmail.com>
 <cf77b8bb-5427-4d0c-b212-51947704378a@oss.qualcomm.com>
 <CABBYNZJpW8=KtN9_G2QOp1YqD3ZJhWGVriyLBh7jUGRFEHPyYg@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <CABBYNZJpW8=KtN9_G2QOp1YqD3ZJhWGVriyLBh7jUGRFEHPyYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0e99a9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ufI6BYMI3Tdet4GtgHAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: _6jdpEoFAr3Q_KR6dTUCbxXBKMUWwKas
X-Proofpoint-ORIG-GUID: _6jdpEoFAr3Q_KR6dTUCbxXBKMUWwKas
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA1MSBTYWx0ZWRfX5jlybr60iTsB
 cNiVvtqQuBdbAJHVXNScQkYt1Yb6kxJkTp98CUqGWDcSBat3iZLS5UevpBfbeheg/t1rQh8sD5c
 dRQZ1aMA/zz9cIMeiPE3bF0JAkdhqzN/M0Tuo3VUYr2LfiwXMQzIrSt2JT6rD35DLj6UqTtz61f
 AelqIgzZIwL9L7qUOgN3wgs+tegr96gnASzLtADSFuDXChR/i9i8GOYyQGyFIsjBLUbi2Qw0RAe
 80TrJF0wbC0pAYe3LJgPc144qfNFDP2eTi1bn0J7zICyLQlYGsl6/6IFO5AkVqa+0Sq+nEUCDwS
 U61FcYg8h3Fr10NQDqJiXhZ4k8A4QKjw9gG49EBTz2Z4C1hMwW/2VjbajJ2LqCOgFCT06hGfi4v
 03fZGYcxmJVk4zM21tsf7FfxiyXG9ZXLRzu4BWJ6wEts+EcpsrrJNwyzX28FgT/7jHEeA/MXGLM
 KWOafM7u54QmRAx/ApQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210051

Hi Luiz

On 5/20/2026 8:45 PM, Luiz Augusto von Dentz wrote:
> Hi Shuai,
>
> On Wed, May 20, 2026 at 2:26 AM Shuai Zhang
> <shuai.zhang@oss.qualcomm.com> wrote:
>> Hi Luiz
>>
>> On 4/29/2026 11:17 PM, Luiz Augusto von Dentz wrote:
>>> Hi Shuai,
>>>
>>> On Wed, Apr 29, 2026 at 8:12 AM Shuai Zhang
>>> <shuai.zhang@oss.qualcomm.com> wrote:
>>>> The Bluetooth host decides whether to download firmware by reading the
>>>> controller firmware download completion flag and firmware version
>>>> information.
>>>>
>>>> If a USB error occurs during the firmware download process (for example
>>>> due to a USB disconnect), the download is aborted immediately. An
>>>> incomplete firmware transfer does not cause the controller to set the
>>>> download completion flag, but the firmware version information may be
>>>> updated at an early stage of the download process.
>>> Hold on, if the download has been aborted then the version should be
>>> reverted, or rather just update once the firmware loading is complete,
>>> so this indicates there is a bug somewhere that needs fixing, not
>>> worked around.
>>>
>>>> In this case, after USB reconnection, the host attempts to re-download
>>>> the firmware because the download completion flag is not set. However,
>>>> since the controller reports the same firmware version as the target
>>>> firmware, the download is skipped. This ultimately results in the
>>>> firmware not being properly updated on the controller.
>>>>
>>>> This change removes the restriction that skips firmware download when
>>>> the versions are equal. It covers scenarios where the USB connection
>>>> can be disconnected at any time and ensures that firmware download can
>>>> be retriggered after USB reconnection, allowing the Bluetooth firmware
>>>> to be correctly and completely updated.
>>>>
>>>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>>>> ---
>>>> Changes v2:
>>>> - Update code comments and commit message to reflect the correct logic.
>>>> - Align the commit title with upstream conventions.
>>>> - Link v1
>>>>     https://lore.kernel.org/all/20260108074353.1027877-1-shuai.zhang@oss.qualcomm.com/
>>>> ---
>>>>    drivers/bluetooth/btusb.c | 8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>>> index 572091e60..70abbabea 100644
>>>> --- a/drivers/bluetooth/btusb.c
>>>> +++ b/drivers/bluetooth/btusb.c
>>>> @@ -3550,7 +3550,13 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>>>>                       "firmware rome 0x%x build 0x%x",
>>>>                       rver_rom, rver_patch, ver_rom, ver_patch);
>>>>
>>>> -       if (rver_rom != ver_rom || rver_patch <= ver_patch) {
>>>> +       /* Allow rampatch when the patch version equals the firmware version.
>>>> +        * A firmware download may be aborted by a transient USB error (e.g.
>>>> +        * disconnect) after the controller updates version info but before
>>>> +        * completion.
>>>> +        * Allowing equal versions enables re-flashing during recovery.
>>>> +        */
>>>> +       if (rver_rom != ver_rom || rver_patch < ver_patch) {
>>> As I said above, this sounds more like a workaround. That said, I
>>> wonder why it would print an error if the version matches, it sounds
>>> to be that if the version matches it should just skip and consider it
>>> has been loaded already in case the actual problem is fixed by setting
>>> the new version only when loading has been completed.

 From my understanding, the current changes should already cover this case,

so no further modifications seem necessary. Please let me know if you 
see it differently.


  I will add a Fixes tag in the next revision.


>>>>                   bt_dev_err(hdev, "rampatch file version did not match with firmware");
>>>>                   err = -EINVAL;
>>>>                   goto done;
>>>> --
>>>> 2.34.1
>> Just checking if there are any updates on this
> I had the impression there would be more changes needed, if this not
> the case than let me know, also perhaps we should consider adding a
> Fixes tag since this might help users experiencing problem if they are
> dual booting or somehow got the wrong firmware to be loaded.
>
>> Thanks,
>>
>> Shuai
>>

Thanks,

Shuai

>
>
