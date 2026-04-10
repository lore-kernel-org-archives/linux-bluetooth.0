Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C5351C09
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775811241; cv=none; b=h/qCan5+HvqbugthG+2aspiGmmnFH7yZ0YEHHlc17EN3ri4E8s8gANUD4Ym4t4qcDe/wKeJ4MMYeLSU2MXkVvK82yF7Iv5DFqr9IjVmIR1Wxy3KrCwPKo3FVT+TK/6tqJRZWah5d60JD8xre3BX/lUyo+eq/SYlguNDvpAapHj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775811241; c=relaxed/simple;
	bh=unDtLaJv38ORHPnLJsTDOfDRmF6IxgkNQIEOb8nNunM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qEW10rLaHOSU7nRADEspT4LizwE5emM0cUlJNhRBc0UsfB8q0d+mqPIKPuaxQMbkwE0zt46TpsNbH9+Q6EoOAj7Df1EMeEMQkG1wISVMNGQSDpo2ejKnqtQZ5na0RULEM1jU87Pt5/caGm3pY1X4C3m/crkgXaC9x+68znE8zIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j75gSjzg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E9Evqg+W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j75gSjzg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E9Evqg+W"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A1NGHL115465
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 08:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NFc1cR6IRw6VaxBeLU2oBmMaFHH6k+Ln0IhBfxX7nRE=; b=j75gSjzg5S8hLx6f
	ddfVBsM0Xckc5d1aaOLQRQUg/v4KwByiv9yY7lNcBm3qInK2lD9LL/WpayYyhZMN
	9JMj2QmN8zF2BN/+H5KEnx8LXV+1+vPalscMoDV1+rtggnJLxrHCO4MPQAE7NrkK
	fSpDGpRNIC9MyFK95xx9mHm4Tn9QAQch8yDZfkX8LXMHrvsinlPUYWAuSIT1sair
	frGQJ/hZEMwFg4gTe4+mVsz31pshtrqdFCNXY+F4n7xyYbGJ66q5+j8sWS52+tBm
	UxB2E40LV+/Ih1QRlamWrLikXroqLB01AFfxa6C+/EmZBpVA1eFQIx3y/mbxbad6
	nzPsCg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dee8xb3v8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 08:53:50 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12c35f2c09dso548498c88.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 01:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775811229; x=1776416029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFc1cR6IRw6VaxBeLU2oBmMaFHH6k+Ln0IhBfxX7nRE=;
        b=E9Evqg+WrlfFO4AprNgGncYXvv02AyEgRU9KuewB6aaE3HqwSPP5+jhqvgJj/PpaNK
         Uj/Wma5D3oxpvKUXe7Cik7n6POc//jhc+3Y8yx1y2D8x6wwMOnH9H06CkKrQCk8WWOvq
         ShymdNEx7xxeQfNVhTDwAVVzvj8F3heAtwpPivze3GBDhMQeP+wYnJrEmTzbCa1dq1YD
         uyVc0DDpm1AB0eZAZxh0kFbcedebY7Ql4chcRrTSb4tFGyxC+9LKlqTU8qqcKCg5pWB6
         fSsO8pwoj9xfJnZ0yMdhBl0LyTVC/XQgdEy1mujCF7JjfTzzPpI/oVuUUke1ay9P7gdo
         DSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775811229; x=1776416029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFc1cR6IRw6VaxBeLU2oBmMaFHH6k+Ln0IhBfxX7nRE=;
        b=cV5ZAO+biDmZdRCB7Vrn8HZET/5FS1ILsIYj03/9c6QJ2B0YkWqWdv6FARptPL0a5/
         TeOPNrvNoGgiEz1vV+Pno04Xcx+Cs1vc+I9cr+38tALhUOEGtFkzvF1kAbkkgtiTjHHe
         G6R/PBpUEjdn2H273Uh9pa5XN4NoVSKgKySANBAxfrGPjjmfB4IGntnXRjlWdrw9JQCm
         t8mvULFjvDcV0wHNsMPI/21zX21c0FH118u7XPk5RqaAK7os0xd85SRPd9rl4M6ADJjF
         nrZ6Zi7aPGU5P6gu/AhGHm6m18udJFfYs+Wt3FkoCYSCyMtcMkAcvsIVNRGGXzZ6ShDz
         ssKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU23IwnsGZugM1BrD+yOTOpklFY/1mUTv2KbG1F0A+4V2mUJzvK07evCTUEEqMXVnQCKeV+LyihroxeTQBChk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaImUoh0Obo0F4Ialik7X6uFSc4RF0MswT3RqqOl46bmHkwWUE
	SZfKa8EBJqPAiDRXvdtsMWv2PdomdyCb38o2VrlY6f/gRQXt4dQpjazhhbBTyxvvUq2zVGX5aPH
	fYRGwNilPDDbmC67+69BJTfDeBQxvvAxoc6GBV9F9Wr/rKm7pT6NBlcyTl0KPDeSczIBgYq8=
X-Gm-Gg: AeBDietVC9RLdkd6zesVDY9tovgpVXoLcCMH3BjwQ9mgPC8vf0GFgZ/EgJzIa0azyjD
	8CBHppgFIjos9HY4ePHbOYdmfMpShkg0f+/4I3QIJYlcYZWC8ISZZzKv++2Tsynxq+xXOPvSq+R
	ofUSKEzXpB+apRMIyL8XrinC1sImOIz1ckudv8Gf3dnby9GfjUTbpfWHC3BTDYdg/s+KP2Z5sU4
	oUfLh466eYdrhj538FMFaNJYzT6194c8dVi14CX5idfdTnXs8np+WXv0PZHT9CDnq498WqcrlFi
	K/rVP0TLqrdRxvcbQaz2vFxZKrXxdaDJbbP2AcuIefbqG1mqSJcuXd8+Wu9qYSEorhAQfL4gSfN
	uJYGPb/JP0U0DkReGwKll5Z1B8cM18swYEF2K6YtJeKO448+j
X-Received: by 2002:a05:7022:20c:b0:128:d2f2:5cf8 with SMTP id a92af1059eb24-12c34f06c2amr1225942c88.34.1775811229004;
        Fri, 10 Apr 2026 01:53:49 -0700 (PDT)
X-Received: by 2002:a05:7022:20c:b0:128:d2f2:5cf8 with SMTP id a92af1059eb24-12c34f06c2amr1225928c88.34.1775811228474;
        Fri, 10 Apr 2026 01:53:48 -0700 (PDT)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c345b5b9dsm2410253c88.7.2026.04.10.01.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 01:53:48 -0700 (PDT)
Message-ID: <6ad050c8-b923-417c-a50d-59233c8841ef@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 16:53:43 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Bluetooth: qca: Fix delayed hw_error handling due to
 missing wakeup during SSR
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
References: <20260409112233.3326467-1-shuai.zhang@oss.qualcomm.com>
 <CABBYNZL25=Q6cR5HKf202D61oe6pYL-2NR3vb32ja+5W6xQcXA@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <CABBYNZL25=Q6cR5HKf202D61oe6pYL-2NR3vb32ja+5W6xQcXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MSBTYWx0ZWRfX2BSmgTrXpPoY
 bWR3cASVzdb5z5mxDUsZl2JzFCL9TZWJ6tAVZa/xoGAseQ2H8WqZJ9CBIxv7qm+006kmn4pPRhP
 7nXQqd7dWGS3m8/eTK6+CFef7990UJbMezG1oFbgBgUSs68u9Bnr03SGYVVJQDDX1kLsrS3YVTB
 0QeO60D65RRrVTSl5e4GxwbYa/H8gikGyVGYKDZETeF+vdRJkfXnVm+qQBYkHD/LmEOW1l8fg/M
 /yKf8uBklxdPqPoAaJ+8Y2erGNLiq6JYa7/A1BtOg1sx6B7y6ouYtCPDjHEq2Duox7cLpABhN0P
 P2YUFyxv613vnl5fgvH7wl2Hn+S5bS8dQBD7jfN1r4+9JRaCdTTmFr+gCNc4OZIDj2QN2OcggB9
 wgo12KuFKaHZYczsfsRAsFhMsw7wIuWe3TO7lrA+IUbHIQUm1UewQc2CeqrhWSo+njY6qjuyi8a
 H1d5L/WoIZVGI9cOV8w==
X-Proofpoint-GUID: r-225WBGrtp6S-uBhmZpD6lUwsJXFgS3
X-Proofpoint-ORIG-GUID: r-225WBGrtp6S-uBhmZpD6lUwsJXFgS3
X-Authority-Analysis: v=2.4 cv=O7YJeh9W c=1 sm=1 tr=0 ts=69d8ba9e cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=c92rfblmAAAA:8
 a=nMkBCxXBiB_ylkh7ArAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100081

Hi  Luiz

On 4/9/2026 11:21 PM, Luiz Augusto von Dentz wrote:
> Hi Shuai,
>
> On Thu, Apr 9, 2026 at 7:22 AM Shuai Zhang <shuai.zhang@oss.qualcomm.com> wrote:
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
>>
>> The current implementation lacks a wakeup trigger. As a result,
>> even if the coredump data has already been processed, the host
>> continues to wait until the timer expires, causing unnecessary
>> delays in handling the hw_error event.
>>
>> To fix this issue, adds a `wake_up_bit()` call after the host finishes
>> processing the coredump data. This ensures that the waiting thread is
>> promptly notified and can proceed to handle the hw_error event without
>> waiting for the timeout.
>>
>> Test case:
>> - Trigger controller coredump using the command: `hcitool cmd 0x3f 0c 26`.
>> - Use `btmon` to capture HCI logs.
>> - Observe the time interval between receiving the hw_error event
>> and the execution of the power-off sequence in the HCI log.
>>
>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>> ---
>> Changes v5:
>> - Replace clear_and_wake_up_bit with wake_up_bit
>> - Link to v4
>>    https://lore.kernel.org/all/20260327083258.1398450-1-shuai.zhang@oss.qualcomm.com/
>>
>> Changes v4:
>> - add Acked-by signoff
>> - Link to v3
>>    https://lore.kernel.org/all/20251107033924.3707495-1-quic_shuaz@quicinc.com/
>>
>> Changes v3:
>> - add Fixes tag
>> - Link to v2
>>    https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc.com/
>>
>> Changes v2:
>> - Split timeout conversion into a separate patch.
>> - Clarified commit messages and added test case description.
>> - Link to v1
>>    https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc.com/
>> ---
>>   drivers/bluetooth/hci_qca.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index c17a462ae..9fffe665b 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1108,7 +1108,7 @@ static void qca_controller_memdump(struct work_struct *work)
>>                                  qca->qca_memdump = NULL;
>>                                  qca->memdump_state = QCA_MEMDUMP_COLLECTED;
>>                                  cancel_delayed_work(&qca->ctrl_memdump_timeout);
>> -                               clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>> +                               wake_up_bit(&qca->flags, QCA_MEMDUMP_COLLECTION);
>>                                  clear_bit(QCA_IBS_DISABLED, &qca->flags);
>>                                  mutex_unlock(&qca->hci_memdump_lock);
>>                                  return;
>> @@ -1186,7 +1186,7 @@ static void qca_controller_memdump(struct work_struct *work)
>>                          kfree(qca->qca_memdump);
>>                          qca->qca_memdump = NULL;
>>                          qca->memdump_state = QCA_MEMDUMP_COLLECTED;
>> -                       clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>> +                       wake_up_bit(&qca->flags, QCA_MEMDUMP_COLLECTION);
>>                  }
>>
>>                  mutex_unlock(&qca->hci_memdump_lock);
>> --
>> 2.34.1
> https://sashiko.dev/#/patchset/20260409112233.3326467-1-shuai.zhang%40oss.qualcomm.com
>
> Lots of comments which Im not sure are really valid, but one is
> considered critical so we do have to pay attention if that is valid
> then it should be addressed.


This is valid. clear_and_wake_up_bit() will be used.


Thanks,
Shuai

>
