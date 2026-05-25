Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9317E0E8
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779684874; cv=none; b=QWeGbHaJdnQZLfQ3/v3gg1pbORpcIJkGExbLqX5ZJN9i9RGRXYSem40MhjiR0Wu6pw3RMnNgWfMhAT1cZfvimjQtAa794HuEeA1Qt06z6WLDx+P/OvMcORHtsnBjA7RuIcyMePikhCsMBNq7kRXENj2PvQ6NOGvhcPOE2XJP8Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779684874; c=relaxed/simple;
	bh=mLKpSdg5UZFpJKCKH2pdp7Peb+6WwPB+uVGIggRnO4w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NCPAnpbLDe+Ko0FZF78qJ8ho26FDqc/r6hd8ExrfKCwZXe8FqPwAPOKR+AP7OlLuNKGt8K4Ry+uhWL98zYBYJCRupWTDNJy2O7cafyBRTkLAocJ5M31MgmHu6olQ0si3TOz8qVX+4y2cvZRWUnG8TxSJfNJ8xBqNphlthf0C6nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hb6Xo9KY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EZJB7xAv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hb6Xo9KY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EZJB7xAv"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OLTmdt1594683
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 04:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n0Rs6oaK/jqTub1cx6UO6JWIsXdV1vKT7AXCB2yogII=; b=Hb6Xo9KYv//g1fLV
	1vC3sk2gtWb5ZAtlbZAwV4tZ9K/XU5SkQawELNH1e3B3pE+sRwxxya9gqIuJtIPD
	Uv3vMvMiYaTov2Ork8PeSRwyZLdyR9HLWids/TF0dyXndIuPet9XgUyRWFN288GV
	w1bZZkJUDrKjwxDszG5BSR70H3oVekswagSwnuuti4HzcFU5ahntIQPX68oYnDhS
	nhpcFOKso9ZgFDC7h5cBA18KD3pvh+1ViW6vBXP8sc6zKSreqYbbY1N1ZFY5TxK+
	PmiX3e7pbP9p78fS+Q/uL/1vQL7YVBy6O3o0xIJgCvzMr0Y1b0iNepm13Nq8xyFv
	/Y/0lQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb88w4ebc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 04:54:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so14703088eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 May 2026 21:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779684872; x=1780289672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n0Rs6oaK/jqTub1cx6UO6JWIsXdV1vKT7AXCB2yogII=;
        b=EZJB7xAvQsQeDemIK/S5YO+2+ipcxs0hAd2d5a5ueihQ0x9IQwkQktSueAVCZHrHPW
         UFrLO6bo4i/dDsqgyOgX+Q1cNvjpV7G05c5Kz0BfIyg4ddvj6x51oAFI6csvC1S/sq4u
         pxMqCgM0WuiuDDmC4LQ6ELQea2LLbYXl92uY9aBHNIqf79C4g0dm6/AUyL9QLRV1gg43
         ALrvJpzsFhjldd7K4xl9c/PCuHU1mDg8pgb3wG++xW1OoYGQ4q5gj6vIdZtaWXcoGT8w
         mKHzKqts3yE7KMzopUKatYU/d8PU1MT7Pixo3xwilsdr3au4BrMCiOzcX4IrPjSQ8YNS
         iIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779684872; x=1780289672;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0Rs6oaK/jqTub1cx6UO6JWIsXdV1vKT7AXCB2yogII=;
        b=Cn3YH4FX9otrKqFyw4DkdE+ZKS4lcKvbWPbq40HVmdqt8JA6GGrai8ZxsZfVc6C5sh
         aYZ0dR3ecPPSiCCSHtX5lq/lYgZf972YgfMFa5lTYeXnFJtSt2FytkL5zg9sGitNbmrG
         uM1xuiuFsRB1PtoPk/cmy+yZYgnRxKiNl2wMvcFMTcfoYa/GOJi1P20lQIHFNqSccl2R
         OTDIC6Ls2RgEarHVnUR9UWhSahGSXyXIw3Pd6a1Mmc7vYc4h2VBL4qeypu35KwfkOKPc
         W3BH5xD7w+R//s3kBROXumMNZMS8A6PVDd6e2HRZpywjiXekcJrkPPIM1hFLVD3WHD2t
         btKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ekAKe+RzIbbmcATFwd1kcRKk4xf6t6eXc25Z6QEV2BlgjN4kllaKAhYcS/tRhZWHe4EccDk7LYmQUqmgpXiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvBWu4ytM3UhlImAPpwfs8Td7hHRFfj7ImzIWLycAB3GMlMUUv
	7bSg88HTHtnhnLtTKup8ODyrxOj/NbrgIt4IwGg+TWj+3StskK395QPKHn1iNXigjWXN+nQix+k
	Kpb+Rwkv/COlUT58zqV9u/EU48VnsvxRn+3rZNf9M4GmMr72GtMOXv1BMhnsxolD1eaDsMkc=
X-Gm-Gg: Acq92OEnksQXoZTY1qNt2tEx2P4BaPnrkVaiiPtPRck4zijBmTAKmdJTw1XUfnLGlCq
	NS8cJBP6wa5wSK0C1R9QWYRRK3cIJ90Mx6UGRuYFo7g3C3NJfjeC++Dd5FKHpjuDRPb/8G7+7ix
	IjJ5K1Q6f91aPcWSdrpPwW7KiqQ1KUxg7kgX4QZx12VM6sIo3VZiuRG009n4iB9L2t8msEXoYbU
	ViQcH9dleOYK4bZFdPdNGR/tZ6VTMnVZtKMLFjKUIcmcSupB9lACEBk2YniXM8OQmsvPTbvgE0d
	cw6R2d3so7U4sDcDsd5pOiR/uzoAj9E9XfqMPRv+yPJgWtdFzaBhvKIBH+SD9SZhLaZu9xwtvyA
	LZk0X7lqht4f9v4rp6xiR+n5pIt6d2yl47Btt+cRJiSY5L6Ivl4pl/8R1nQ8pR/RBAHsUW9Dmg+
	tCFA==
X-Received: by 2002:a05:7022:913:b0:136:5631:bfed with SMTP id a92af1059eb24-1365fa355cfmr4334348c88.20.1779684871975;
        Sun, 24 May 2026 21:54:31 -0700 (PDT)
X-Received: by 2002:a05:7022:913:b0:136:5631:bfed with SMTP id a92af1059eb24-1365fa355cfmr4334343c88.20.1779684871402;
        Sun, 24 May 2026 21:54:31 -0700 (PDT)
Received: from [10.110.81.142] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aba39d7sm5189913c88.14.2026.05.24.21.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 21:54:31 -0700 (PDT)
Message-ID: <9f898fe2-0b38-489a-b3d0-e13b00a68ab8@oss.qualcomm.com>
Date: Mon, 25 May 2026 12:54:21 +0800
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
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        stable@vger.kernel.org
References: <20260522110838.1158643-1-shuai.zhang@oss.qualcomm.com>
 <1b8e8129-4f42-429e-bd70-5e368551739c@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <1b8e8129-4f42-429e-bd70-5e368551739c@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S/jpBosP c=1 sm=1 tr=0 ts=6a13d608 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=k2v91a5pJgHk7pTncY4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA0NSBTYWx0ZWRfX8DdaqMbifs1G
 1jZviIf70uuQ2x7to/1CKJmgXvfExoe465sfAjeMynGaUsPliyp79B7WVI5GQvJvL+z5om2xzs4
 xxMARDK/Sff3NE7K3+DlZkAImHHlXSZIXVjXOp2mhospEok+/Ig0WqxR5EnnPLuzV+atZkHC+KV
 LmespEYGdX0wxC3+8FxcUnhVNNymF2I9ro2lsNMQVVDGvKfI0GnrICNx/Q+zwd4u6JCIaZJykiV
 HEQILZNpHee+g3QSwCLkjEUvs8Rme8/dBGNFGdmLfllGjNz9sXOD9POyDfvTyJVs4h3VpPRsz+B
 pKxue081zU75qSCKPyRpuyq0JZi5JF/3iO3UHvCm6tlkG6vkHMSP98y+VgadN0UGxCX66hxi/6U
 2qX8fdj04WOwvGhmQbWV+xdPrrBrFNL05oNZcwC4wJ1ExKaabJDhnK33yoS8H5HqpJ5i8YvspUV
 WpkpQrpCMQXQzE8GiQw==
X-Proofpoint-ORIG-GUID: TzT5_2aI5wqWsL2a_OO9dU578DuT3OsL
X-Proofpoint-GUID: TzT5_2aI5wqWsL2a_OO9dU578DuT3OsL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250045

Hi Paul

Thanks for your review and suggestions.

On 5/22/2026 10:50 PM, Paul Menzel wrote:
> Dear Shuai,
>
>
> Thank you for your patch. Please mention the delay in the 
> summary/title. Maybe:
>
> Use 100 ms SSR delay for rampatch and NVM loading
>
> Am 22.05.26 um 13:08 schrieb Shuai Zhang:
>> When bt_en is pulled high by hardware, the host does not re-download
>> the firmware after SSR. The controller loads the rampatch and NVM
>> internally.
>>
>> On HMT chip, due to the large firmware file size, the
>
> Please document the size (> X MB) 


On HMT chip, the rampatch size is ~264 KB and the NVM is ~9.4 KB.
I will update this information in the next version of the patch.

>
>> loading process takes approximately 70ms. The previous 50ms delay is
>> too short, causing the controller to not respond to the reset command
>> sent by the host, which leads to BT initialization failure.
>
> Maybe paste the log?


  Bluetooth: hci0: QCA memdump Done, received 458752, total 458752
  Bluetooth: hci0: mem_dump_status: 2
  Bluetooth: hci0: Opcode 0x0c03 failed: -110

I will update this information in the next version of the patch.


>
>> Increase the delay to 100ms to ensure the controller has finished
>> loading the firmware before the host sends commands.
>
> Why can’t it be increased to 1 s?
>
>> Steps to reproduce:
>> 1. Trigger SSR and wait for SSR to complete:
>>     hcitool cmd 0x3f 0c 26
>> 2. Run "bluetoothctl power on" and observe that BT fails to start.
>>
>> Fixes: fce1a9244a0f ("Bluetooth: hci_qca: Fix SSR (SubSystem Restart) 
>> fail when BT_EN is pulled up by hw")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>> ---
>>   drivers/bluetooth/hci_qca.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index ed280399b..184f52f9c 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1680,8 +1680,8 @@ static void qca_hw_error(struct hci_dev *hdev, 
>> u8 code)
>>           mod_timer(&qca->tx_idle_timer, jiffies +
>>                     msecs_to_jiffies(qca->tx_idle_delay));
>>   -        /* Controller reset completion time is 50ms */
>> -        msleep(50);
>> +        /* Wait for the controller to load the rampatch and NVM.*/
>
> Missing space at the end.
>
>> +        msleep(100);
>>             clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
>>           clear_bit(QCA_IBS_DISABLED, &qca->flags);
>
> Is the time it took to load the rampatch and NVM visible in the logs?


No, the loading time of the rampatch and NVM is not visible in the host 
logs,

as the firmware is loaded internally by the controller.


>
>
> Kind regards,
>
> Paul


Thanks,

Shuai

