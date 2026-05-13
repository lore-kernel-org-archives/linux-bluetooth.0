Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C4D3672B5
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658763; cv=none; b=gy/DUtul6wSSAJGtEYDf9x2W5AV89K1I5OWWnLLcPmUzt0HVBrNIDypJS9JhmIa4mV64PvTCTWwjIdbpXSq87MN0Th+t5hmlcBDg97J1dKosDJP4I/jetR+2VlMayA4xgPlluVAqRIkxC7CorQk21Q2Zu43+XzhfofQfL6rgvoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658763; c=relaxed/simple;
	bh=MSXep/bDwIn3yHe4zPzKf5Aas/TTus+4HSlvtcwQFuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPZPARrl4FYPzkXY5Z2jNqnNTEBkdu7aJUwkn95WjQmFXXWYT1JGbYNdPzp1qpg750FQqkPYB94dHtda5CipT2rA/SQjyiCJBheg3RuSQmblGX1fWZ79ZvYBFfhTDllhcr8+ujd/v8P9SXKpJlUvS1TG1HhFatB71wxHAZ60y6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V68MnocZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HW239AZ8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V68MnocZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HW239AZ8"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4pAjF2933018
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 07:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ravoL5PG8TFBvvHW7mZTeCpdtXXYG3Ly4mpodLGV0u8=; b=V68MnocZ+qiBFkh8
	5ElHxnLuoYyP/kCaYQrSfVhm/i1SMyKw+4KMf525HOudtW+kbjxZGydfCh3RmbEg
	6Wjo4LLbn1aYFwN8tKXzpv2GLgwaDQAzvykOaYXh0JlkwgcvYKAUM5TLfAuwptq9
	eJw62eC0BmZNbtHLhR+ydVtSNjrkG8eUP6xanCfPaWIPK+CYJftjijfE7v07J61R
	Npz9697/d9fy+EJU4jl9YV+iC2zDs2GcPCWQt5fP8ws2H9YMdrQaJa1KvrzKoFs0
	HvbmYIQO8dUiydXpKTeFdPIymsMPsSaOUx5pIM1cD9V1dXGhMttyuZL1WL/Zb6ux
	3uutGw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4319vbqh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 07:52:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ee1da7a13fso8167101eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 00:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778658759; x=1779263559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ravoL5PG8TFBvvHW7mZTeCpdtXXYG3Ly4mpodLGV0u8=;
        b=HW239AZ8RRHKi//Q5WXu4bDre8EYaNm/ylprM/knn3IaOzcQzs++9nI/k4yvTYwLyz
         7Vm2y8NwX8bI2Hl7EGsMfbZD5LHIjZITBSoGfiewzC0F/CA0L5NQAmsaAiy2u0u0G7C6
         nozSRk0NjIMud6C6w6/W8ppYXG+fBuKkoMhpXa+nj1aYQ0WExY3Z9Aj3Dt//o7tpLJuK
         fTy5xewxmhGcJMvNL9gXZ0PhI7D1uuaNkgiNRJg/fNjJQWt/k1aX0Qa1qXYlHr0DkgMI
         P9mvefD0WCZ87r+jFVis92iYNNg9eQ1JFDDzW6swTWcJjacl47VwwTJ1yxuakzU0eUNs
         PGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778658759; x=1779263559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ravoL5PG8TFBvvHW7mZTeCpdtXXYG3Ly4mpodLGV0u8=;
        b=UYEejB6mUw92pfEQAYqEpvnNzwKUkB4n3DpGutrgOqeTWTUX3dK40tle0jaEidBar1
         gf9vh7NK3iUfvPrpvDR3gBAwwAR601korQXNnIouhRO4ZPtlElrAZOFroBQJzZ+ZQ40P
         E/GsTSXTgaJ1tzy4j2tlszHHVdGkIkAx+t7EqoJbduFiudppwslnUPWsmC9T6/GctCj5
         jT1IMOsLRgCMUQEO0XZ2HJhofONsBA0VL67rCqKu7Ul+dUlH8saLzljt3Am7WP03emiI
         +gFftnT2tseSNTI4pfWuFdt//TRRfQOr5S6MtfTyTp+JzQ3G0xKYo8qilwvfPjF/9OoX
         rwWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/W8NCGl/10jL9YnZpoc3VyhIwSO+mZC7ccjn8UHfP4BsBMIbX5BUXKOlS7TAGMot6+d6ov6cPl7SmWV2wUUYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2zasTaTursxgjTsMGUCkDAeTgu4r0iB2M22dwabMEOy2AF83y
	5EFiiMApDNBBuS2u7Dmyv7PP7C0wCC81OlCsHhTbE7dBRT8U/QFyFOfMSnbA0wNZh5twdgGb/3u
	1CxwGlN7a1TzH8vRnQV3nlr4pEiPevj1du6buaTclZHbLgQquxviV8QGx+OknIHfOB18OsQg=
X-Gm-Gg: Acq92OHrz36191RTFqWIYIiiHFc0YQFFFEv8ROenE36wc91ZhA1vobvbtf2+UVLR4rW
	xgx6YI4/85kPILLVEShMY4wYRrOmAl5ZpPt6r6KKI6mnp8ibDqjBq26v3FBFjR6MokG3GsnbNo5
	I94ExvhzSw/4I/2HMwrb/qbDwkCta34xn3HvP8a5q4/Q7H3pBbb5IIGQxAe6fx/xHpkG2jgYo6C
	v3e0tpL+pgAF7SGSFVcpJvYN6tLPc9A1WR/mOwIrNX11yaYZ+5bc7hiD3PUASdt9NHDRLui9Snj
	z9RUazNF3oYxjGczmHbxIFIekFZci2l8X2UlMG+/Kr2F9bLiftB8Mv6fwSbP5SDnyD20mjKOnQY
	0YCEevV08sKDUu5gBr4xbbcucf+juu9A/Lwq4HkvdqAX3hVLd9HIDlXbGkgT7nfYoaaiEFIZBCA
	VH
X-Received: by 2002:a05:7301:4001:b0:2f3:dbfa:1955 with SMTP id 5a478bee46e88-301569f3016mr800982eec.34.1778658759399;
        Wed, 13 May 2026 00:52:39 -0700 (PDT)
X-Received: by 2002:a05:7301:4001:b0:2f3:dbfa:1955 with SMTP id 5a478bee46e88-301569f3016mr800968eec.34.1778658758815;
        Wed, 13 May 2026 00:52:38 -0700 (PDT)
Received: from [10.110.35.32] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88914523csm20850189eec.29.2026.05.13.00.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 00:52:38 -0700 (PDT)
Message-ID: <8f5362ca-5513-4d9a-8922-6603783c9ae7@oss.qualcomm.com>
Date: Wed, 13 May 2026 15:52:34 +0800
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
 <CABBYNZKbVT2xXqedwoenuU0YroJO-3gyhJGSixt0zvodLez0qQ@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <CABBYNZKbVT2xXqedwoenuU0YroJO-3gyhJGSixt0zvodLez0qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA3OCBTYWx0ZWRfX4DroYWwoQZle
 Z68APrxrQkyr6MFUKb24BDLrQmkCZsDFC5Dqf9II5SV+1FGzzbkf45M9n5IrLMF4oROqRa2aEzz
 BwSnL8RjqHa2oHUjYsqh+6sva8o4R7LF4RenN5JQEVZxQrfuiHf/sUJpJfF4STDr7YAQArU8/oA
 d10sTXNfpWqik9u1dAmDMAhWqFk0d9wJNicUXGPmkFdwvI8SpddJwJz+tYARDif4tcL6V2/3aPP
 3nAFl739FTFNfXH/vZOC05rCF/LTSF56CeowAVV37yQv+M+IVCvg8rb0iwJB8U2d+ldnNQHGPVD
 gaMZGFGNNHmFITjp5cAsRs1K+8B2e5nrFQ7MzzEaKRhvmb0lGM+gd9GZrzUC+Tl2/9MrWgZBKZW
 zhk+2VO7NcFm5OGNfP4jBTlR9K96DiEetlCEmER4nCSq2wCTS3PU8M9Y/6QTwwh3ADLznf98x4L
 3K5YEMpMNk/+Zh5v2lQ==
X-Proofpoint-GUID: _fUlRiVderj00fWhdNK41CzfzmUrab1d
X-Authority-Analysis: v=2.4 cv=bp98wkai c=1 sm=1 tr=0 ts=6a042dc8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=c92rfblmAAAA:8 a=pGLkceISAAAA:8
 a=KQFOj9_g3FkfKAVhRwgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: _fUlRiVderj00fWhdNK41CzfzmUrab1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130078

Hi  Luiz

On 4/30/2026 12:14 AM, Luiz Augusto von Dentz wrote:
> Hi Shuai,
>
> On Wed, Apr 29, 2026 at 11:17 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Shuai,
>>
>> On Wed, Apr 29, 2026 at 8:12 AM Shuai Zhang
>> <shuai.zhang@oss.qualcomm.com> wrote:
>>> The Bluetooth host decides whether to download firmware by reading the
>>> controller firmware download completion flag and firmware version
>>> information.
>>>
>>> If a USB error occurs during the firmware download process (for example
>>> due to a USB disconnect), the download is aborted immediately. An
>>> incomplete firmware transfer does not cause the controller to set the
>>> download completion flag, but the firmware version information may be
>>> updated at an early stage of the download process.
>> Hold on, if the download has been aborted then the version should be
>> reverted, or rather just update once the firmware loading is complete,
>> so this indicates there is a bug somewhere that needs fixing, not
>> worked around.
>>
>>> In this case, after USB reconnection, the host attempts to re-download
>>> the firmware because the download completion flag is not set. However,
>>> since the controller reports the same firmware version as the target
>>> firmware, the download is skipped. This ultimately results in the
>>> firmware not being properly updated on the controller.
>>>
>>> This change removes the restriction that skips firmware download when
>>> the versions are equal. It covers scenarios where the USB connection
>>> can be disconnected at any time and ensures that firmware download can
>>> be retriggered after USB reconnection, allowing the Bluetooth firmware
>>> to be correctly and completely updated.
>>>
>>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>>> ---
>>> Changes v2:
>>> - Update code comments and commit message to reflect the correct logic.
>>> - Align the commit title with upstream conventions.
>>> - Link v1
>>>    https://lore.kernel.org/all/20260108074353.1027877-1-shuai.zhang@oss.qualcomm.com/
>>> ---
>>>   drivers/bluetooth/btusb.c | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index 572091e60..70abbabea 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -3550,7 +3550,13 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>>>                      "firmware rome 0x%x build 0x%x",
>>>                      rver_rom, rver_patch, ver_rom, ver_patch);
>>>
>>> -       if (rver_rom != ver_rom || rver_patch <= ver_patch) {
>>> +       /* Allow rampatch when the patch version equals the firmware version.
>>> +        * A firmware download may be aborted by a transient USB error (e.g.
>>> +        * disconnect) after the controller updates version info but before
>>> +        * completion.
>>> +        * Allowing equal versions enables re-flashing during recovery.
>>> +        */
>>> +       if (rver_rom != ver_rom || rver_patch < ver_patch) {
>> As I said above, this sounds more like a workaround. That said, I
>> wonder why it would print an error if the version matches, it sounds
>> to be that if the version matches it should just skip and consider it
>> has been loaded already in case the actual problem is fixed by setting
>> the new version only when loading has been completed.
> Btw, the following also seem valid although not introduced by this change:
>
> https://sashiko.dev/#/patchset/20260429121207.1306526-1-shuai.zhang%40oss.qualcomm.com


I will check this and submit a new patch if it is issue.


>
>>>                  bt_dev_err(hdev, "rampatch file version did not match with firmware");
>>>                  err = -EINVAL;
>>>                  goto done;
>>> --
>>> 2.34.1
>>>
>>
>> --
>> Luiz Augusto von Dentz

Thanks,

Shuai

>
>
