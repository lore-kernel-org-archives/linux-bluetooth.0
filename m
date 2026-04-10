Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235733AB263
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775811412; cv=none; b=obYuMxCT8qKvKqdPDbNP/kP/Ayrf8BfQlbNsMW789hAS1FFMhFHJxuurUPIpnsG6a5Ql2j7xQ9buq0KI1N2OWpWHRpq5URi3vrpG5TFT6uJqfm5bezFZu384XLQUUsDdkvOIKMgmEVkNLCMAl6Bsce2TxYBLAwR8u0bhh9PAUsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775811412; c=relaxed/simple;
	bh=4ll411lMrhIlzuNnvMxpl7djAMvUCJvTPlpnDmRVExo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlXPwNT8brzoYmuOaYPwpO6ocHU/Eba1YFn0kpkApJpDvAkrOlYGAcgdpP3DTIw3Ut+HfQcupzepTiZt0aZEqWZ9QQgkFdsDsSe32AlO+YJjWNaoZ5nFuh5Aq7t8kYDwrZUKpZn/TzpTr1ts4FOg+zkG326+qBtY2/kmmKz8TGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kzugPAnQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SXUEBXly; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kzugPAnQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SXUEBXly"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A6CPOV3352621
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 08:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DpL5uUa/L0RcqMu/HKlHy5vqEr9XMka9y9pgSUMJX/I=; b=kzugPAnQnU0tgLbI
	wpNJl8YN+Lalu7vBgLTIiyFqTiznEHZJXgy5fg3a/eNjj/RTmVy2SdCTpEJdp0nz
	j50LPD/ZUtkrLz/NoL3Ak6ssgYsTR81CSmLXgHsi6LmVl3S2IHiXf7P2w/B1+xBs
	VwJ3lqWsI7h0r+ARExdq6HHFV+9fMx3WfHPtC48XmlZPlwyrB+CZWZpjvGp1km9F
	PDJFDMzFgpHivpZRIP4NU/CaTMzR8J4i00XLda90phSkLuutvAqOG9c2nuspHTHT
	eNw83w8dJyc+MQUA+gRnnhMTxvqD2fWgKFpQNgUah89m9NMFnh/nEdd3y0YTxZLH
	NrMXGQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dec1quqq1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 08:56:50 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12c283a1212so1286201c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775811409; x=1776416209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DpL5uUa/L0RcqMu/HKlHy5vqEr9XMka9y9pgSUMJX/I=;
        b=SXUEBXlyDPCWaQkxKZWcPDUTbRZofLxiKx3mUTDobDCDgHnhr0/XoXFpZ7UV4JwEvZ
         nvaFyIlXG1zYJ+tj02CDWDIEFYDRbk+4WnMOSS7rrPckLFUpjRfq405N+XXdodtHjZVu
         ZyPvoLNc1z8MCGwFXiyIhfajZw20Jle9GNsUemMQelEIOFuTta8Kq4WEVBUxHldmSNI6
         dQ/7L5YhdDFinu6lFY/Bm5BAkzZCwyMjgg1oERMsHrPal2atAMjJPd9f0MGX2RbvNGz2
         hIOYGHxvVcFLHywoqYHZXGmAdyzJe6TCHE0ZtK6FaV5GB4JBjHDHkHfU3E2F1b1Sw7fH
         KfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775811409; x=1776416209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpL5uUa/L0RcqMu/HKlHy5vqEr9XMka9y9pgSUMJX/I=;
        b=LN3feVEd6BsS40pwAhCXDNSQfVv0FWgJFxe6U1GyUYA47XvnLbCQ8F4S3MerNaA2EQ
         tRLclBJO5feZ2Dpw3a25EKF2skzH7vVp6Kah+OSQhOPS4Fq/I3dIUsbQby0VnKVo7v8U
         +KAmQAIEB9zBp2MtJT5Mz5aAHfLaJZBvTW2nDmiTmYwq+9NM9Nm9uw4w41GkNFk85Jjk
         shyV3KD6t2MxPBZBZ6mB56S8vlEQY5gB1kBPuaYDWbzX6eZAykbpPjHHAe6fb2SpxWab
         jsmgada9C7PTVJA56hUViwOpCwi2yIoRHR0uR5oo27rqcZNtrop5ibZzITh1amZ4GZQX
         8sVw==
X-Forwarded-Encrypted: i=1; AJvYcCW6iFklflS3b5VfSgIQa+mxhN6AtzlrRYSwJykI1pZlde2ZMJQuvXo5miWaMREO87erkzJ2oWyqBrLOgCX/tuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybUln7Pa5J+PvL4VTDKrmziFU8j2CmXC7lXYjmsjgI/zNnjg2W
	HEGzEodH7V05j5G17wP0f6c5a80ZlSjUOE03kUUO4tMCBoEoF2zG6hshziiV4c9Srenz1vm7FWd
	gAAx/iQpUNRbf1ZUI4+BR2qw/Kh1e2Ox6HzEHwRfAYnerbgBfVe1OIl5ZzU1zp2PTnDYS8+w=
X-Gm-Gg: AeBDievy18cTQNGNrcdjg5fb0b/tuhfKvb1hkrtXv4OxPfhSEqqYuiQWvh+RAsu2N8C
	SEipQg8qNKJZvHzG35Cjp7bXl9kIXOT/EPL97Ze99E0i9wuzpi5emVcUgYPxM5sL5ygJG6aWMJT
	qrVjHILy1Y+xtb07mZl8d916udn0HtEGrxGDHm7IeYvQEpvmtQEeisj3rXcBrXJp1tvZVvMaEXe
	kBgAAgOdE4rUe4vdnkRVCd23qFUaQDosix8WItzPBmOwknwDEbQt2G25oNA9+HJegbih39z+6B5
	bJzRMeaWWwuXcjhcwETjjV/QZ4NIcQw99NYg9MS6K4I3IUjZyAs8U5Jbj835n7XCCM5NX/cxouc
	+dYr73qnZytrhtflws1HgsLrQ3xxs7Wp7F7DFmeMY1PczYgy6
X-Received: by 2002:a05:7022:e1b:b0:128:d107:da0f with SMTP id a92af1059eb24-12c34ea9471mr1340457c88.10.1775811409007;
        Fri, 10 Apr 2026 01:56:49 -0700 (PDT)
X-Received: by 2002:a05:7022:e1b:b0:128:d107:da0f with SMTP id a92af1059eb24-12c34ea9471mr1340432c88.10.1775811408369;
        Fri, 10 Apr 2026 01:56:48 -0700 (PDT)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa5257sm3342942eec.9.2026.04.10.01.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 01:56:47 -0700 (PDT)
Message-ID: <f6a9419d-5e63-4c36-a7e9-aab6ac798703@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 16:56:43 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Bluetooth: hci_qca: Convert timeout from jiffies to ms
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, stable@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
References: <20260327082941.1396521-1-shuai.zhang@oss.qualcomm.com>
 <CABBYNZKY_-QgsenfU4hpyQ1+87rXDS13wFueN2nX6Wojy4BgHQ@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <CABBYNZKY_-QgsenfU4hpyQ1+87rXDS13wFueN2nX6Wojy4BgHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MSBTYWx0ZWRfX/CG18jy3pHDl
 wurPa2CPv1pnz6D5Iyk4T0CYZlUayMiv2tFNUdHr8sLwrx1gNpJu6KWWo/gTcD2hEW1qTwSD/1Z
 zJhxkCWLC/fTx9d244jTZB3hVMrUkNfLPjSUc+MWhTZZV4EPUgb4jOBtBJXPR/oy3M2ISp8ZY3G
 79YO8hZll+2xlIx3Ae+/ruhE85V0mipgK3Ef9tnGM/1ATWctfvDMw9cINT2vUEgoTZvhiXdGfm0
 ksLITUTbSiOaQyG6w3HX8AKGbpHNGd1UZJgmg3X3aG2ICE1chHkOJiQRDM0TjXS6/XIsr2BqocE
 zZ/PJrYKtNgXfZBHRHpFfHTgOP1Mip2zZmHq/4TdLN2++oIkugoi0KshGkOtC5EsDue/yRey1nU
 PzD33oRelpp+JVrwesWcoDL9tBLzx3a7upD8dGGmKTjT/iMt2mvuzsBy0vZoYR/liKUx/J6F1bO
 W7MI1e87cgVd/mBsRLg==
X-Authority-Analysis: v=2.4 cv=eOcjSnp1 c=1 sm=1 tr=0 ts=69d8bb52 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=mEO4ALF7hCPe5JJGosAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -FpwdeaI7o2yJK93koBfYv73f3Cm2yfI
X-Proofpoint-ORIG-GUID: -FpwdeaI7o2yJK93koBfYv73f3Cm2yfI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100081

Hi Luiz

On 3/28/2026 1:53 AM, Luiz Augusto von Dentz wrote:
> Hi Shuai,
>
> On Fri, Mar 27, 2026 at 4:30 AM Shuai Zhang
> <shuai.zhang@oss.qualcomm.com> wrote:
>> From: Shuai Zhang <quic_shuaz@quicinc.com>
>>
>> Since the timer uses jiffies as its unit rather than ms, the timeout value
>> must be converted from ms to jiffies when configuring the timer. Otherwise,
>> the intended 8s timeout is incorrectly set to approximately 33s.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: d841502c79e3 ("Bluetooth: hci_qca: Collect controller memory dump during SSR")
>> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> ---
>> Changes v4:
>> - add review-by signoff
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
>>
>>   drivers/bluetooth/hci_qca.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 228a754a9..d66af13ab 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1607,7 +1607,7 @@ static void qca_wait_for_dump_collection(struct hci_dev *hdev)
>>          struct qca_data *qca = hu->priv;
>>
>>          wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
>> -                           TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
>> +                           TASK_UNINTERRUPTIBLE, msecs_to_jiffies(MEMDUMP_TIMEOUT_MS));
>>
>>          clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>>   }
>> --
>> 2.34.1
>>
> https://sashiko.dev/#/patchset/20260327082941.1396521-1-shuai.zhang%40oss.qualcomm.com
>
> Comments seem valid to me.


https://lore.kernel.org/all/20260410085202.4128000-1-shuai.zhang@oss.qualcomm.com/

The wait will be woken up once the coredump collection is completed.


Thanks,
Shuai

