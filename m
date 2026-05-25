Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31003A874B
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691764; cv=none; b=k+mBYZGWndk7P4RGafXaEiwKw26zYqO75JzOQfWR3qX1VTX9z19wF+eJbbplxLSDyENtINahUaJQHQCEO4zYwknCQl2BQPh2ZgJhWUeFxa05MT87e+TJb4zFoGCJmKxxx8ieUxJQQcpN7JYB3JQ1GLX9pBDY28SzInTKnBp6RoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691764; c=relaxed/simple;
	bh=utLLGRdarLRCiW1US6VVGRZPWxf5/fO3v/VjqNUQ/5Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fvSM9LFpT00HNeBwxb4fDhRSDfouGpmV5hqkbvihYUiGPn0+F1c3GjYSrtf0cbGkE2kENBb5rdz7CQEgXrM+cHpF+yGqnKgW/AoM0oDuy3ldWl5gJ/n7AZR7L6kv2iI6UQk2T35WdNl+iWW7U91m1H8HlhNM3vqTnrwOXwvqTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CHmOp2n+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SDz/esvW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CHmOp2n+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SDz/esvW"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P3RRkh3890153
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 06:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xa1aVs2gD/q5yikyQaG219MKMNic86aisit5i/OTAcg=; b=CHmOp2n+w+lkf2EW
	khHn4UFhTvWFL/8VH5pPtW+s7qG8bs2z+9FbqIf1UWO43dSYEnq7FF40cO6n8/U3
	+//b9TdlGUiHWXU7HzCUNZRi6AtA4w4aiL2TshEYThiHHWe5RFnTjFgGBPITWqPJ
	XN9JfvbE+QiuNHfPsktgcbTX85fBMpimwx0zfgRFzP88obCSUOmdAJWrkqp8vLl9
	xF4Lgj1vA1p8MBO3nSlCBqxNG3qHHv+PzFASa0yL5aYek3SRVT+IpYYBNkvUc4XS
	NMLMpzJprUHCoXXdVbN4ZkGPATMxC5yl3Il7vt9nToziREFs0+izXn2UpqdfM6Yd
	H97NNg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4aswem3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 06:49:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so14800816eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 May 2026 23:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779691759; x=1780296559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xa1aVs2gD/q5yikyQaG219MKMNic86aisit5i/OTAcg=;
        b=SDz/esvWSqTudXrS/3Ck89zw2tF4qNUy5zggx0M/iZ7yFii7AOkROXFrpw2+98KqAE
         w6Xi9tFIZDPbuzd9gA0ScLz+bgmvYfaV1mp/TJK8bm0xqLMDfxshbSjnJIBxGX/M70vg
         dmgYKAHkIKsgxL06Y4sWlX4KMfT47f3cGsC29qN6D0fPGO1y3Azqca/Syr0LjO9tg+Zs
         oewV5NORdGC/8WKsf3Lx4ac/tVMc/ICg3q5B1CWtUeO0g/UvpdA176iWVs0Xipy/9k/t
         OzRx2jojhRtEeZzKqfeGKk3o/5guknf+PKpk7hhoNmuq94QdDdKbTY7yZP2uuKwd2gJI
         UDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779691759; x=1780296559;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xa1aVs2gD/q5yikyQaG219MKMNic86aisit5i/OTAcg=;
        b=LUb10YAdNnN+1OkIZNP9RCAbPEwylE4AkkA9B+KCGolEWrfS+ZUR8sdhGDTMqiSxr2
         1/Y++rBQ7lZa5ZkosGmrK4RwDlVpsPH6yuDt4860ZFBdXnI63QFUDkkeLeyjV8BgH9P9
         wIqHeiPk2FokTplTnFndqeaNXMk71s+CddQiOeKQl1t75Fu04pCgGHBiv2CcQsJFPrSm
         G53gJ+577f+nwGvGQ8UXuRZn2EMF69XE3VrJbmI2SQ6XT39zVQpD68mdwASDpxDCkYKT
         VO/Izves7UuR8WrQU43LOFNI8mnroOVuDjLJVW8Ts0c+9u11PtqaBdDs1iG0YOO2EDKI
         v43A==
X-Forwarded-Encrypted: i=1; AFNElJ99UCyT+n2bu777ekdSih7b4Nn0tC7/5WgUBtxq3TMDI2KOJAHT8wqK8yLgrwOzldG6VwCu7c/jvI5prTFKO44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaxx/aFpkOIVGz183P8WT/PxpOLb5DKloJ7/w2K/fUtk6VWGsj
	cmz6t05l8BK66I4f86yOhf1s2XUR8tmr+Okjti1xhPhSQiKgWBTe3vxNBtvE20eeDk/lMTUnqo7
	4PqSuYskcEcXdLxOJSZbQPVzugTBFF0p31O0Nw5IQd1RcstLn4OJeEWs4LBQslOua0rhE31U=
X-Gm-Gg: Acq92OEMk7OiRI/ROB8Ck00vFkbzwOrg2airZTA9Po0wBnwtG5de8/INjDOejJ9wJQT
	tjZzCkd9+Rg1nsIsf+Qj3flMFD5LnFIsCW3wYEpAZGdFSgwFT3sD/SCPzcK1nQMjl01IZW3o66I
	5gE9YoSWl7PUqwmeW+6sFgax2nEmd74ZRCnIZ2hUTBVMiEv8M7SfL7V/Xpv94QmjfjAk8RVw0Tm
	s6ywsz43/y/Zucah/00xqBTiw7v+YEruI3WDtwNQ9Ka/Tlo5NJJrfFAAeDkC9R7dv0Amt9a+f+A
	LK3b39OA/qdutBVePylT9roV/xEYOH0g5RR21b+DXEW9td+F9pGU3NQlrFloz9AXPVufImBcCKr
	1jeZLEZ99XZ4Z2uvbhA3CQ3llF8evxFLVEGro0K+dl4EuCaNqS0HhGHipqDfcnWtRxHKVlM1dKH
	YgAA==
X-Received: by 2002:a05:7300:ad09:b0:2be:7fc2:fc38 with SMTP id 5a478bee46e88-3044904e1b2mr6215571eec.5.1779691758540;
        Sun, 24 May 2026 23:49:18 -0700 (PDT)
X-Received: by 2002:a05:7300:ad09:b0:2be:7fc2:fc38 with SMTP id 5a478bee46e88-3044904e1b2mr6215559eec.5.1779691757979;
        Sun, 24 May 2026 23:49:17 -0700 (PDT)
Received: from [10.110.33.191] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452259de0sm6536599eec.22.2026.05.24.23.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 23:49:17 -0700 (PDT)
Message-ID: <4e3d1338-7680-4ccf-a2d1-875c81605d8f@oss.qualcomm.com>
Date: Mon, 25 May 2026 14:49:12 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Increase SSR delay for rampatch
 and NVM loading
To: Paul Menzel <pmenzel@molgen.mpg.de>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, stable@vger.kernel.org
References: <20260522110838.1158643-1-shuai.zhang@oss.qualcomm.com>
 <1b8e8129-4f42-429e-bd70-5e368551739c@molgen.mpg.de>
 <CABBYNZLQ5m-24twTZaHXzi6QHqgGdvuDt1aaYwbEi0Vt=R2Dfw@mail.gmail.com>
 <55439fa7-2057-4dd7-9651-db15bd27de3a@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <55439fa7-2057-4dd7-9651-db15bd27de3a@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA2NSBTYWx0ZWRfX7TpBlP79ehId
 hBnjrs4jV6ljnprqmeOJM1YPH4AsN6Q6Hy63UVC0j1Xok9NTHeS1wQaAt/t51otaBCvGtwhLIK3
 6opMkpv/gKsZeR/8CU6OsvC5MuiU5cEl3SnHL6KW12MiDy+2YBflc9AJUHzn4ZH7JmXYHIACDRo
 ARuzHasdxL7MOsivZpqkqVEIUCg820+mazTh14Ct7qWcrh7qKqQhpoaJQq8PjIxPUjkJBzvK0GL
 0KO/8S5dSmkPxWg0ArV2CW0if+PYPPGr+raEjLbhNlleNUsZWWeqQ0eMZASJh3GJrn3sfBq6+oJ
 exD6PlLjw5K36Y3cii+UJFVudT1fyUIGp3V9zHSMYhbdrb8ghU+wXpDkJxbbTVyhBuj9JPhYBEA
 KZVEnp7t1TzQeAg+jNgmiqMiRnvWmxqgpfeW3OjeL+TaX/Z3kxwRjXZkTw3DfuPW5Ljebs9T6oX
 YleSMcnf2/54fr/1ayw==
X-Proofpoint-ORIG-GUID: WcwK07cuSMHNsjYLxhte0GcQqaIFy0C8
X-Proofpoint-GUID: WcwK07cuSMHNsjYLxhte0GcQqaIFy0C8
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a13f0ef cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SMXFAHEO-8xBPAYFaCoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250065

Hi Paul, Luiz

On 5/23/2026 4:42 AM, Paul Menzel wrote:
> Dear Luiz,
>
>
> Thank you for your reply.
>
> Am 22.05.26 um 18:22 schrieb Luiz Augusto von Dentz:
>
>> On Fri, May 22, 2026 at 10:50 AM Paul Menzel <pmenzel@molgen.mpg.de> 
>> wrote:
>
>>> Thank you for your patch. Please mention the delay in the 
>>> summary/title.
>>> Maybe:
>>>
>>> Use 100 ms SSR delay for rampatch and NVM loading
>>>
>>> Am 22.05.26 um 13:08 schrieb Shuai Zhang:
>>>> When bt_en is pulled high by hardware, the host does not re-download
>>>> the firmware after SSR. The controller loads the rampatch and NVM
>>>> internally.
>>>>
>>>> On HMT chip, due to the large firmware file size, the
>>>
>>> Please document the size (> X MB)
>>>
>>>> loading process takes approximately 70ms. The previous 50ms delay is
>>>> too short, causing the controller to not respond to the reset command
>>>> sent by the host, which leads to BT initialization failure.
>>>
>>> Maybe paste the log?
>>>
>>>> Increase the delay to 100ms to ensure the controller has finished
>>>> loading the firmware before the host sends commands.
>>>
>>> Why can’t it be increased to 1 s?
>>
>> Why would increasing it to 1s be a good idea? Actually a _proper_
>> driver should be able to detect when loading has finished, not just
>> use an arbitrary timer and hope that works and the controller is
>> responsive afterward.
>
> Indeed it’s not a fail safe in this case, and that’s what my comment 
> was about, that it should be explained why 100 ms is chosen, and not a 
> flexible way implemented. Sorry for not being clear.


The 100 ms value is based on actual measurement data from the controller 
team. In HMT2.1 ROM,
the BT boot time (warm reset, which is the SSR recovery path) was 
observed to approach 50+ ms.

The previous 50 ms delay therefore provides no margin, causing 
intermittent initialization failures.

100 ms was chosen as it gives approximately 2x margin over the observed 
worst-case boot time,
while keeping the SSR recovery latency reasonable for userspace.

Regarding a more flexible approach: in the current configuration where 
bt_en is pulled high
and the controller self-loads the rampatch/NVM, no HCI event is 
generated by the controller
to indicate firmware load completion.

Without such a notification mechanism, a fixed delay is the only viable 
option at this level.

>
>>>> Steps to reproduce:
>>>> 1. Trigger SSR and wait for SSR to complete:
>>>>      hcitool cmd 0x3f 0c 26
>>>> 2. Run "bluetoothctl power on" and observe that BT fails to start.
>>>>
>>>> Fixes: fce1a9244a0f ("Bluetooth: hci_qca: Fix SSR (SubSystem 
>>>> Restart) fail when BT_EN is pulled up by hw")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>>>> ---
>>>>    drivers/bluetooth/hci_qca.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>>> index ed280399b..184f52f9c 100644
>>>> --- a/drivers/bluetooth/hci_qca.c
>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>> @@ -1680,8 +1680,8 @@ static void qca_hw_error(struct hci_dev 
>>>> *hdev, u8 code)
>>>>                mod_timer(&qca->tx_idle_timer, jiffies +
>>>> msecs_to_jiffies(qca->tx_idle_delay));
>>>>
>>>> -             /* Controller reset completion time is 50ms */
>>>> -             msleep(50);
>>>> +             /* Wait for the controller to load the rampatch and 
>>>> NVM.*/
>>>
>>> Missing space at the end.
>>>
>>>> +             msleep(100);
>>>>
>>>>                clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
>>>>                clear_bit(QCA_IBS_DISABLED, &qca->flags);
>>>
>>> Is the time it took to load the rampatch and NVM visible in the logs?
>
>
> Kind regards,
>
> Paul


Thanks,

Shuai

