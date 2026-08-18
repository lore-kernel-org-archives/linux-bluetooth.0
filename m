Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED3F468C0A
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052078; cv=none; b=Xz+l7Ieab3yd/e0MNYjsSBwZJwT9seM36TrEomdgAinkP3MWuWk0W8nnFb9r7q5J5STKXSMWwx4mmbT9ISkihbR8LN/WtkdNJtx5ha4lFcesGZZ5ZfpAXQONo+r8Yey1KV6O+Y78wA9UZdLhZdnDgicuDNHBMM0YIzjfH/fd3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052078; c=relaxed/simple;
	bh=iU+YrDUsljSTdjU90x4oYec2pFfHzpd4lKK2XDOwJio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XderneBmijMna+N9T0e6h1Oyvqp/Iib8jMhCFK03lcX6malcx3qcU0T6gfL92Bodpzyi8/GoEg3fAeSfqfVFXip+aiT7c5ZgKymGlOnQ8joIlncuZ48TrRZGokCJzKY38RpcC/IHM1xs5pngUjFGBUbdowuvTRZH6ZgmV0H7hu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zd4eaBdr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GWwPJZ9I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zd4eaBdr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GWwPJZ9I"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABbuF068547
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 11:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fUcfNfagQJIAStgtfuDmI8ykTDgbU7kvHrcW/5Iy2Y8=; b=Zd4eaBdrBWjIxBXH
	k5pvuth07skBjB51vW6U4W8yNpZBQEst+zrjK26FD+M5h3VwqSwihQd71AwzlabQ
	ZSSDv2OLTWm5YgFGXU0xaYsMIHc/q+cVOh4Y+Q02X95y3ifnbyWEoGbW99+7DS4y
	b3rad2JQAQzzcDSCbrqzCD7bV13alIsVrybb5OVTuX8PK5sODYk/6EL8x9F1IKqy
	9XfKYMaIT825xU3ANwxTdbVcxNyOCWqpOixvdptoGzoDjZZx3iijKKWGW4dv/ygZ
	JJLzO2vRUeMY2B7zlL8qv+8mvfcJwmWBKi4DArtAK5Y79/n9EvsdSnPK49YVzSYE
	Hcuv+w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4f5pswd4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 11:21:15 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84c4cd31b51so1153660b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 04:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787052075; x=1787656875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fUcfNfagQJIAStgtfuDmI8ykTDgbU7kvHrcW/5Iy2Y8=;
        b=GWwPJZ9ICjwnLdRfu/xE0cmBPBttl9kfdTTbhSu3HPGiEaTp0Rd1WLQEGj+Z2mcGwb
         obpppFr/57Spug1Uj4a9vnap3KIXmOnU24ROnls9HYMJa8ICQbXXUJi5gwrEeVUCZCKi
         7v+BVuQx7emP8IXkfrzdng+TcktNTPM0QfPvHGM9UUHl9vgdzqi9xuPztuUvUn322nOH
         cxr8vv+cTkCLs7oFXjpMJ3n8uco/GwJR1bpPeeZpzYGGaiukI9PE27dO3PDBJpcCj2Zn
         gr7VrwzOQgNUi2+rk/+1KRQyHuvy1vHdBw2vR2+AkBtm/ggp+MQzlh0ejzU3+0l/vjNR
         dgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787052075; x=1787656875;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fUcfNfagQJIAStgtfuDmI8ykTDgbU7kvHrcW/5Iy2Y8=;
        b=O8LKlcJSnQgQkZ8EEIgYrcAdQ1UCy+YDuxwd56yuakeVDfiHZCQdJRBNSlcRAlP6a8
         F7VguO8EnAhj2yVxLtLLkCaObx7sVY4Wjb55WLmhEDx3SXQvkTsYg5mjgzJ1deauLn6b
         y4XsL3TJzHbzG8T+7lY8O9SLHmc7/5LuJpcMKjm4eIvHB5GXNvsB8YnzrcfujJi/m2yJ
         qWMbwJUs2m2yGRr+M7jQa8ghS9EM8rBuB8hXe8gvf3Xnbanu/cHjK8rUILoTr5KKH3FA
         Ct/hzXzyR0HPng28T5vZJ3T48PER+AHMgTOmCf09DZ87hRplA16qzqw/Gj9wAQqfFT2/
         iKVg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1cpZHFz+gcWXmpSNAATAysN663AT9FU3flcs/XPCtKKG6CSU7fvZxRIuQE5qxEZOlPZKLNLwHfQLmd5KHTdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLf8F+x9Vno/lWYlDu4KUOh+dIieDibshAmCnU7y0zcULwmDjc
	78Ya8X6GykatkMFdcZOji3wt103Q6MOKTVec3OqXsYIYPkQB27aJGIU+Mn4CmM1ZAISU+osOWib
	TaTsIMy6q6BV9l4J/SF3Vp0F4TyWIKPrEjwL52xvvoRp8vleo2cq21U+pYSf9PyQlNBJRUx0=
X-Gm-Gg: AR+sD103pUkPP+V7YELkhZLRo+09dhvHMvr/0sjkTkdZrk/C4rk9cFZz4rG0lWp50hV
	vQUyjrmexRA5ASfKVZGOAi24E4ef73YcTbiBVKf2gs1h2bruXsVbD1SOYzdPMP5Gq+zTtXiMZfj
	2eU9/9M9byrkXJ/nMYzfsI6zvJdoaTWZeuD2KgyKsDOq81AYQC9a6ql2RP2OHSqcGve9jZyIDPq
	VeLkWTtXfrEMxbFWwwQIXoaLjK3QpmH5kvsmZAtYJCeKMiDFQlzx7f1Nui8ou9a7SGXfR2UDiag
	RMqJ7kMFeXS8fN1rikjhRo7n1Wbiy3VNbWae8lSa19pZUe24ID8KnVCz6hyirdV6Q//SUBPAgQr
	Y20vrRWbmlDmkAUjVabUOwpw5mQ==
X-Received: by 2002:a05:6a00:a21d:b0:84b:9a69:156d with SMTP id d2e1a72fcca58-851bdef42bbmr4059245b3a.0.1787052075118;
        Tue, 18 Aug 2026 04:21:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:a21d:b0:84b:9a69:156d with SMTP id d2e1a72fcca58-851bdef42bbmr4059201b3a.0.1787052074683;
        Tue, 18 Aug 2026 04:21:14 -0700 (PDT)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6f8b44esm1388177b3a.33.2026.08.18.04.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 04:21:14 -0700 (PDT)
Message-ID: <4c08029e-9404-4e79-bda1-b0414faad4f9@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 19:21:09 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: mgmt: reply to cancelled mgmt commands
 instead of silently dropping
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        chejiang@qti.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
References: <20260817060134.3298439-1-shuai.zhang@oss.qualcomm.com>
 <CABBYNZK=Pk_5UpB5F9RkUvk8kTzXYVi_dzB-yr4_yCTumTBE+A@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <CABBYNZK=Pk_5UpB5F9RkUvk8kTzXYVi_dzB-yr4_yCTumTBE+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S+/pBosP c=1 sm=1 tr=0 ts=6a84402b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=fXJiQ_T2-zYmZzf_OfQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: iTV_zsYfTPOM23E4uErXiA8Jekw3WalI
X-Proofpoint-ORIG-GUID: iTV_zsYfTPOM23E4uErXiA8Jekw3WalI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4MyBTYWx0ZWRfX8K6wV8iao0jB
 zzwq55dawiy0JcGcMf253MMKwOqzXiIwnpyEB2gte5EEcrnP94ywyUl+9uyjfPzuNM8GMMWyWAc
 UaMlx3dskKllK+GWfI/tOWPi1oQ5ZNM4R5VPqD9N6RrkOvS2cMMjMTgcXJsP0vwZjAFYauN2Q4d
 IcV34t0fwGYkjJaZf62bmOtwdYFNdmbUvz3iwhZK+BHj/ehLfnzruG/VXyRX7DzVxAcyPjrBF0Q
 oFDcXbXJ1/oYoCS/Gr5XBThS+oGTn0qqMad5Z3YjVp90u9wYiOIe0dZBAKsA854cvFju8Le8WBU
 e7Wb/ekZilw4DY2Zy8GJrehFCk0PqxDQOHaLFon1HKmCIceK3CBXGwUfaXKogzWPc/jT0g9tET3
 8MKWK3RKsFUCCz+hq9Kn/FWKRD8wd9yZIIibDlPfzqX/RAl3XyawDmudFam0ByyU03OcTZ1H0Vk
 vBbV+l0A6fpEqiBne/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4MyBTYWx0ZWRfX7LbAtDj2ki5M
 CxAVi1BSTAaglnoDw8AXyNjtCiSMntmmazUAJIotrIzmSNs4IyseopnZSxSzA1ECM2fpQl43aG5
 cOUrZn6xje+z0bwy2t/pgA84sByzRsI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180083

Hi Luiz

On 8/18/2026 2:05 AM, Luiz Augusto von Dentz wrote:
> Hi Shuai,
>
> On Mon, Aug 17, 2026 at 2:01 AM Shuai Zhang
> <shuai.zhang@oss.qualcomm.com> wrote:
>> The kernel sets HCI_AUTO_OFF when a controller is first registered and
>> starts a 2-second timer. On slower boots bluetoothd and the HCI_AUTO_OFF
>> timer can race: hci_power_off() is already queued while bluetoothd is
>> still in the middle of its adapter setup sequence. hci_cmd_sync_clear()
>> then cancels any pending mgmt commands with -ECANCELED, including the
>> MGMT_OP_REMOVE_ADV_MONITOR sent by reset_adv_monitors() early in the
>> setup sequence.
>>
>> When auto_off=1, hci_dev_close_sync() skips __mgmt_power_off() entirely,
>> so there is no fallback path to reply to the cancelled commands.
>> mgmt_remove_adv_monitor_complete() silently returns on -ECANCELED, leaving
>> the command with no reply. Since bluez's mgmt queue is strictly serialised,
>> this stalls all subsequent commands indefinitely, leaving bluetoothd unable
>> to register the adapter.
>>
>> Fix by mapping -ECANCELED to MGMT_STATUS_CANCELLED in mgmt_errno_status()
>> and removing the early return in mgmt_remove_adv_monitor_complete(), so
>> bluetoothd receives a reply and can continue normally.
>>
>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>> ---
>>   net/bluetooth/mgmt.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index ac4864e56..c660bd3cd 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -301,6 +301,8 @@ static u8 mgmt_errno_status(int err)
>>                  return MGMT_STATUS_ALREADY_CONNECTED;
>>          case -ENOTCONN:
>>                  return MGMT_STATUS_DISCONNECTED;
>> +       case -ECANCELED:
>> +               return MGMT_STATUS_CANCELLED;
>>          }
>>
>>          return MGMT_STATUS_FAILED;
>> @@ -5675,9 +5677,6 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
>>          struct mgmt_pending_cmd *cmd = data;
>>          struct mgmt_cp_remove_adv_monitor *cp;
>>
>> -       if (status == -ECANCELED)
>> -               return;
>> -
>>          hci_dev_lock(hdev);
>>
>>          cp = cmd->param;
>> --
>> 2.34.1
>>
> Sashiko is flagging a couple of problems:
>
> https://sashiko.dev/#/patchset/20260817060134.3298439-1-shuai.zhang%40oss.qualcomm.com
This is indeed a valid issue. I'll address it in the next revision.

Thanks

shuai


>
