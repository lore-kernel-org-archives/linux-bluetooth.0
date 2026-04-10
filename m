Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFF3378831
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775814968; cv=none; b=s8EJG0QCdElw9Rpny5Ep+YuQdcn2mAbEpJcBUYGP7HGVyHJbDDeh+keoDw5Rx9XwwP0cWOMyu6VDEo6VK0jLc2z4rcghce2mysR12GTWutWBQ6syh9VFtPd9UAbqdmeo9lg1iGca0Ljd0SKZbPbQd5rHtZNlh16gMWgsm1+ws98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775814968; c=relaxed/simple;
	bh=kecB0tUeYMe0UIVftwBRbSgxiekhLG6a/RcXZdFG73w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIQ1VXwPi4e34t5GsODw+YTcd+rU94qeo7aNX+QsbokJtW2aR7mvqNPODyQB7G2F3c+905Ji/uAsMhyAqnGVLCmz0sSsAT6mzo2s3h2+YOwrcryuGDxa35K+iNoG6/quMi3oNzvSAn5f/yRPi43pg71TkeAMwPzxLyNZZg3SuHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mzXpGK1T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZRb2kI7y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mzXpGK1T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZRb2kI7y"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A7LpHZ3934926
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 09:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WPvge4uWTP2wAKPGSlERwY7rGowwQNeKVWqNbDd1tGo=; b=mzXpGK1Tcpa7E28n
	MQj2T4T50ZUYAUweYctPpSRCcAL9T3ZamBoBrTmRICUGTR1SszZAUlb5SMkdMr7O
	5dXyy7rYJvaQLEBWbg8kZ7Yvovp8T9h1nrzOe+5hvvZxlO6oHLkEarTCpABPeTxM
	qDMYt0MPQFcpfq1jFGk+XUYUuxATadEc576kPGa47opdjHJnHoStUXLM2Dtxdl+D
	W33PCkNolTnUcApyXW1ZSe3GfLNtA+D8r4gsQrm++LJYGZjVb/GfWC5+IsJxlVES
	MItMZLRnLdfHMlCt33wjUuwbMGj2myN7DXbdAdOpxG67kbf83VVaInpcJyqTc4Du
	RUtpsA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ded5sbj5x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 09:56:05 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2523e0299so45066355ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 02:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775814965; x=1776419765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPvge4uWTP2wAKPGSlERwY7rGowwQNeKVWqNbDd1tGo=;
        b=ZRb2kI7y9KudOC8rNZe+/DX95bQiPSJLk1henXRl8FdB1RmuumEET3brPprUTj7QiE
         j8VqXCsH5fck5vrHnlIu4FvCS2CD/d9D3ADkM8bC6/xen4PF0sPs9aof/drCjtcqpIp5
         qeqlhMSjptbX35OWyiijn4+7upIFzhTxZ5Bxe/z++tlselb+cK5mBgcDd1RzscEpG+2x
         aRW/tGUDSDuKdCyab9+OprmForp/ztmJfJ7kYtLvwJdw7CvrrWGj1ZadEg7kDR0/vi4U
         1ZTZZafL+GpvFoeBZXVtlTN4sRo05ltGAXcdfVdMPP/I393aMJ6MxhhHVO9/HgP3ppa3
         tzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775814965; x=1776419765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPvge4uWTP2wAKPGSlERwY7rGowwQNeKVWqNbDd1tGo=;
        b=D5CZuA3lhNLNtRYO/ivtMZt2VLDP2IIT1xN1PK3YwX5KGpBi44tmM8nUJKDLB5N45M
         4G9HL+uUnGj8lBA5bBKk/pFWhqLnMwBgOlJfix8s9eJ3lEaF4k2bRwD5nF3waeshiuRX
         +BIvduS+VGiGcBXo1wcmvhEqKPO+dJ9dqo1PqYYMWbBr1vzHytP3YrQcF1EXIvd/Gxfl
         siF1MRqIqA95FOTUPMwgH6NdaVUEDX76+jbHpSva2/Wv051GHFtyhrWatW9oOGPoveDM
         BbNrOP+EDmnBRj2q0gobPzZiPcmw8VvBVDCfPlb76K/nk3t2byTdfMl9at7lvD3luYL8
         nsOw==
X-Forwarded-Encrypted: i=1; AJvYcCVsBOS0cBbreVbXsapuL0Xt3N7kAOLiSCqt9924SOdJLzPy4VKFMghOZybRzg1uMILsm/Dnf0klZ/GHhFU1Z7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOfC7WcVhRu+nhdGb4Z4fgMpFGR7zdfMpjsrgDa8OkOvdeR0WE
	cMz24e9hjnd81ZF7koxMQtD/7jHLeZULrB1bMz8GAjvKuiuHOnmukncSGyxC3FlgBOL59hfPoR3
	WwfopCbxYEbfGfu3xjoC3bZxPLz7wYWS1L565BFuXydKIAeWTYwCeSKAc/CU9PVysmd2AJmE=
X-Gm-Gg: AeBDievMGPohdWjD+QDAElJ2JE5c+y5NlN21kE0TaP3mOa72kwVVc6NrYqZf0CRT1Xj
	kFv2Y9y3RJL1YfZt9VfDIMFh1OGUY6xJFijEFQiURueKaPsmSbkC+T71pX//0xsEjY2V+rIIihQ
	7Jb54IqDhsAaMwx3tDe+yviHqt9Ym/1FXgwSyAWPaS57tjb8/7SPIwsEpGxw5xGzZxMybPW/lDZ
	vbEgrrL7SzQPGlgpAykKWxBv8Qs23lIPu5tWZVOvFvGA/1h4cDUHtEtuZdB15uRganMcnt9wpLw
	rYJbRwWuZHX5HnpC9DZac49AbkYgymR+JbEOSppeXfFKi7tpVWAE+w5PUVWfUquYknwtCH2hva6
	oxzDZC48HczzU+QLAK8JsMpF1AcVuq3jE9GWcRbmXb+eL+3E=
X-Received: by 2002:a17:902:d50a:b0:2ae:c358:bb7c with SMTP id d9443c01a7336-2b2d5a4a515mr27985575ad.35.1775814964894;
        Fri, 10 Apr 2026 02:56:04 -0700 (PDT)
X-Received: by 2002:a17:902:d50a:b0:2ae:c358:bb7c with SMTP id d9443c01a7336-2b2d5a4a515mr27985135ad.35.1775814964368;
        Fri, 10 Apr 2026 02:56:04 -0700 (PDT)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4ddb462sm23812085ad.24.2026.04.10.02.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 02:56:03 -0700 (PDT)
Message-ID: <f29c2a2a-5b02-46c1-bd6c-fa337faf8370@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:55:58 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] Bluetooth: qca: Fix delayed hw_error handling due to
 missing wakeup during SSR
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260410085202.4128000-1-shuai.zhang@oss.qualcomm.com>
 <489d33f4-16a1-430c-9ec6-7f13a8f2f995@molgen.mpg.de>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <489d33f4-16a1-430c-9ec6-7f13a8f2f995@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: B8nZJzauYqvsfzIKOdt7S61RQq2z9H7L
X-Proofpoint-GUID: B8nZJzauYqvsfzIKOdt7S61RQq2z9H7L
X-Authority-Analysis: v=2.4 cv=Ko59H2WN c=1 sm=1 tr=0 ts=69d8c935 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=c92rfblmAAAA:8
 a=nMkBCxXBiB_ylkh7ArAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA5MiBTYWx0ZWRfXzby9xcthHLeb
 4oEuX+gJlhvYNGVX3tRhzcGfanIlWF78I3z1bh2po6r6pDbwaJXbvWbiKxbU4Z2azkuhiMY7tGs
 3u80/nyipci2cUHwqZSUf7Qy5/4icdX9W4a9dtYOrcTne+ZTDhda3bWrY7gKNZAP3EPFD0CtjX0
 Ct03zdWheNo8JrQRp65XZj/ZDoyd7oHupExepckbhPKNQ5TWbty4o1QGNxdGbklxbOKb+kN4Vag
 jTeMlBbkSRdAJdgTO5btWXesHKpzWEYTlgP64bbBBGJTODAi037dlSMDWHyN06go4OVxGdiXNC3
 DxZQLBs7/wHHnJudObnfxd2uAzf8H5yeUvQCxjNGh2cnxfs3kWDleZkqOSurKRs0AdfD6n43/Vr
 BH3gUWSSjpp5YJgGPCQ9E/NoKPBxHXG/USoRBpjwDNeOHRmIStTYzxzuHZwMRs2ThetyAefwHvX
 1PJo4kNIlhDp3ssazCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100092

Hi Paul

Thank you for the suggestion. I have updated it in v7.

On 4/10/2026 5:38 PM, Paul Menzel wrote:
> Dear Shuai,
>
>
> Thank you for your patch. Just some last style things. It’d be great 
> if you could re-flow the commit message to 75 characters per line. 
> This would save some lines.
>
> Am 10.04.26 um 10:52 schrieb Shuai Zhang:
>> When Bluetooth controller encounters a coredump, it triggers
>> the Subsystem Restart (SSR) mechanism. The controller first
>> reports the coredump data, and once the data upload is complete,
>> it sends a hw_error event. The host relies on this event to
>> proceed with subsequent recovery actions.
>>
>> If the host has not finished processing the coredump data
>> when the hw_error event is received,
>> it sets a timer to wait until either the data processing is complete
>> or the timeout expires before handling the event.
>
> Maybe mention the timer value?
>
>> The current implementation lacks a wakeup trigger. As a result,
>> even if the coredump data has already been processed, the host
>> continues to wait until the timer expires, causing unnecessary
>> delays in handling the hw_error event.
>>
>> To fix this issue, adds a `wake_up_bit()` call after the host finishes
>
> s/adds/add/
>
> Now that you use `clear_and_wake_up_bit()`, this might confuse 
> readers. Maybe:
>
> To fix this issue, also wake up the other thread by using 
> `clear_and_wake_up_bit()`.
>
> Feel free to ignore though.
>
>> processing the coredump data. This ensures that the waiting thread is
>> promptly notified and can proceed to handle the hw_error event without
>> waiting for the timeout.
>>
>> Test case:
>> - Trigger controller coredump using the command: `hcitool cmd 0x3f 0c 
>> 26`.
>
> It’d be great if you mentioned one affected controller.
>
>> - Use `btmon` to capture HCI logs.
>> - Observe the time interval between receiving the hw_error event
>> and the execution of the power-off sequence in the HCI log.
>
> Please paste the logs.
>
>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>> ---
>> Changes v6:
>> - Replace wake_up_bit with clear_and_wake_up_bit
>> - Link to v5
>> https://lore.kernel.org/all/20260409112233.3326467-1-shuai.zhang@oss.qualcomm.com/
>>
>> Changes v5:
>> - Replace clear_and_wake_up_bit with wake_up_bit
>> - Link to v4
>> https://lore.kernel.org/all/20260327083258.1398450-1-shuai.zhang@oss.qualcomm.com/
>>
>> Changes v4:
>> - add Acked-by signoff
>> - Link to v3
>> https://lore.kernel.org/all/20251107033924.3707495-1-quic_shuaz@quicinc.com/
>>
>> Changes v3:
>> - add Fixes tag
>> - Link to v2
>> https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc.com/
>>
>> Changes v2:
>> - Split timeout conversion into a separate patch.
>> - Clarified commit messages and added test case description.
>> - Link to v1
>> https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc.com/
>> ---
>>   drivers/bluetooth/hci_qca.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index c17a462ae..228a754a9 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1108,7 +1108,7 @@ static void qca_controller_memdump(struct 
>> work_struct *work)
>>                   qca->qca_memdump = NULL;
>>                   qca->memdump_state = QCA_MEMDUMP_COLLECTED;
>> cancel_delayed_work(&qca->ctrl_memdump_timeout);
>> -                clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>> +                clear_and_wake_up_bit(QCA_MEMDUMP_COLLECTION, 
>> &qca->flags);
>>                   clear_bit(QCA_IBS_DISABLED, &qca->flags);
>>                   mutex_unlock(&qca->hci_memdump_lock);
>>                   return;
>> @@ -1186,7 +1186,7 @@ static void qca_controller_memdump(struct 
>> work_struct *work)
>>               kfree(qca->qca_memdump);
>>               qca->qca_memdump = NULL;
>>               qca->memdump_state = QCA_MEMDUMP_COLLECTED;
>> -            clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>> +            clear_and_wake_up_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>>           }
>>             mutex_unlock(&qca->hci_memdump_lock);
>
> With the comments above addressed:
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul
>
>
> PS: gemini/gemini-3.1-pro-preview has some unrelated(?) comments [1]. 
> It’d be great if Qualcomm could look into this.
>
>
> [1]: 
> https://sashiko.dev/#/patchset/20260410085202.4128000-1-shuai.zhang%40oss.qualcomm.com 
>


Thanks，
shuai

