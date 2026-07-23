Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E347FB02
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832765; cv=none; b=EvJ6EeVuU67y64a1tnYlqOf0tH5R3sIUsLwOq/8x13nQXAI3xQUQ/1NDgRcdwuVif0ktUutLxn7pSx2X9yiflzSXwfRjhbjXohEjyvd4mtDmcOrv+C3hkBV0fK1KWXLaY2J6ywM6L4KdcdgXoAanvlluwP/lY6CyNFf0N3nvr/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832765; c=relaxed/simple;
	bh=VaD4gNd5X4Wjyy6tXleEa8bVwP3r7+41qmhxFSCdS00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=em9zBF/It4ujUvB4fsiZi6k6YO+y6VU+538fdDuP4+F/8gCjRHqfTivc1yPp0DIWzQXpMCivxQEDln7Ph3a/EIMkTau3LflgVaQw29QSQqaFrZRZwBBTFPOdUv0186d7T6kRIEaTDfypph/tUV+ZrVyDpuXPkcuDroMtI/WCbpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RCQbmkl9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g9J/dYE8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RCQbmkl9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g9J/dYE8"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NIm3ZA800601
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 18:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Seb4F7fZtpNU6xSkQHlAEJtFAcCH3IYe6nEuksYWwDI=; b=RCQbmkl9RfjckUKP
	BgLKXX3DOhpWbYQF3Z9qn5Ybvgn5cirOefIvj5jq34Io5QJhfN0o5npiVA5ueeem
	jMBy8q7P+3C55/KqrX+nk1JAuEr3pyNzm5XfPrsjjt2E7KwjVCS+06QIlriO9Y7C
	bOVhdbmtaqjvcTtPv7mCzngb8bufO7QRWSUwAMTGwimBvp3QoBuga8hlk0+kzSMV
	MRrker7fDObCUcR5tHfqUFTid7LwXejXRKisIQc8HLFEsRfy8eS85WDr3OBvIMuE
	GNTcusrs8yRcJeh2z/XQikInK8iezzLiqli+jScmDJSzEBUfBOeMgGZbZUrli//e
	aHHwLw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke7qk4va-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 18:52:37 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848c9eb2954so284718b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784832757; x=1785437557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Seb4F7fZtpNU6xSkQHlAEJtFAcCH3IYe6nEuksYWwDI=;
        b=g9J/dYE8GjAaFYg4d4IQC6XGNnR4Y38e/Vhm+LfBVZ3HFVIu8/e1lLU39hx2M8W6nM
         0B0dlrbq85uSArRNP51vHhEHEyE0gl620PahTzFplIrkaVTn+8vAsxv2d+896il5g/tn
         53dnPcQfvuEr8m4Idjvz4bOZWmK3MHzHBRp4IyfgpYEyM4VnrzDVmC9uLTlKXLaI5XKo
         1GhI8alsVV5ClKtaGdSUMtxUv+Rv94u2XkvXCSxLl5cp9tKdUGLQXHmgyk/7hiXg1t47
         IotowDXKvTUSmDe0Ic0pZyOE5DxJW4DFltD4N0Y8hoqvWCPYRcBvyvkbba8YZoq7Qsbz
         JL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832757; x=1785437557;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Seb4F7fZtpNU6xSkQHlAEJtFAcCH3IYe6nEuksYWwDI=;
        b=lTdE/smj86w/qtZ3GmdhddAmm7jrx386tEoIc2dzhRtpYTvRgKTZp8VbWnqTeyxnaf
         nQo+yZRpuXjFhHXOiklG3I/6D2ooiFix+y0Zs4c5nO2rOYA06HSjYvJtFu1kBU1gV6Y7
         HsPm1AiR94zGBRfHARoipPMm+4rlDti6bchhrnek0VUIlZ2UI0oYDgO815jpKt7C4j3Y
         z/QGzWri21Yd+eh9ujcM40ZBSwjIXAty1WnbYW6M2/zOSFP2VUMeFkzet25W0K7mjwVB
         T0TxIDnaa/H6xLX5VG69X7wlcSTfTciuijR2dqfuOJ9XO0CU7uos0Vzo0z6DXlDHrd6G
         IB6Q==
X-Forwarded-Encrypted: i=1; AHgh+RoAisM/B/vQ0RNd5QrEqTNOAw5zlk9LQ7M58biSiSpuV7ZE7il31nju609gSuZgAG+LohkyywkUXCo72dWde/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXOGPoUER73otP2vkeNInlfJWXolU7ZevJMXLkH94EUKdNBGrA
	qtSjGwWi4shFsrcDn+s9eLHUlaZqjVsrxoS9qjn8lVS8QdbrOxqoYpotUAiEi0wQYQz80puHurW
	KPmapuwf8ykt9PBmmjm/wKASmD3inhFzxFgGl2avmnRqzW/mPRmZqQqxvJOaKzzCRiRawZrA=
X-Gm-Gg: AR+sD107e9o9FgOazxgxJHgJtAR5u1kLcHz+FxQFMSgqDLSztOx3jZ/w8LWbtd3U16D
	C84XqHeyCQRfbfEiI+Ya4ccjLygyZvCw7ge/Vgx43z0bHHYuq6c6krq1XYdyISGEKcwfvUOis8e
	hgNtNlIwl1q7WkSYCazMcDIqaH6RD088+J9k7AW2ntsKBQBIxJ/Uz4QwDWEPsMvCZeG17qWwy7r
	/tYKjOYxD/zrranaFKBVdaiXgKzW+n0hom5Kt6vNa1E+Hk2U2H/79r8jwUFHmYiTDFpbCh8AkZ0
	GmWrR1rO3+WXcz2rkw77La5CmH3i1qCVSF12OJyCMdj9Fv9XKZFndOfozqJUrD1xEk3GA/qhDk8
	mljcHz1S2RL9OUQwkozu/nKSy5bZMwrftGcEPiyYysxeesNysronI8AFc6dWHe0kJ6/4=
X-Received: by 2002:a05:6a21:648c:b0:3bf:a881:408f with SMTP id adf61e73a8af0-3c44b38a23emr3651592637.8.1784832756685;
        Thu, 23 Jul 2026 11:52:36 -0700 (PDT)
X-Received: by 2002:a05:6a21:648c:b0:3bf:a881:408f with SMTP id adf61e73a8af0-3c44b38a23emr3651560637.8.1784832756064;
        Thu, 23 Jul 2026 11:52:36 -0700 (PDT)
Received: from [10.249.17.165] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f0ee1e6sm3077178a12.12.2026.07.23.11.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 11:52:35 -0700 (PDT)
Message-ID: <14a35a4f-59c6-470b-a98d-81a38cd66db8@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 02:52:32 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/3] Bluetooth: Add hdev->recv_bt_vendor() to
 handle BT vendor frames
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260722-support_vendor_hci-v2-0-132b506460a4@oss.qualcomm.com>
 <20260722-support_vendor_hci-v2-3-132b506460a4@oss.qualcomm.com>
 <CABBYNZL7ApV6wzTOLGu4gRxBU_89x+D-JNd27tg0X-sOmXqEog@mail.gmail.com>
 <c17cedf9-a013-4ba1-be0e-46f5650ddd89@oss.qualcomm.com>
 <CABBYNZ+2O_xMbYYPyO-kcL2AzV0pBGow1OWEVWf8gAYh5UhzHw@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZ+2O_xMbYYPyO-kcL2AzV0pBGow1OWEVWf8gAYh5UhzHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE4NCBTYWx0ZWRfXxGrEkG4IX4pY
 tRtuFY0X+IxB6lqdKT2iwrlVmC54j8fA+UIksr6QUfzPJ8we3gKB/8N0zienZEXRNqMxRV+9jbu
 sa+gCO4jF4porg4d7QtwpzXkW2utYo8=
X-Authority-Analysis: v=2.4 cv=aYxRWxot c=1 sm=1 tr=0 ts=6a6262f5 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=rbelQ3siGXwaCEnk8YYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: mU37Mv4phLDhJGnX9rwylUMOE2esyjFE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE4NCBTYWx0ZWRfX4hoQvBAeSkL2
 AOKU5wu6djcLgG8xV1+PRVrlxNWfivxyqTlSTgnfcXRvek43zM7Q8Tz70b5mcMZcnw7gdcPqp2k
 KsXDnCEHWQvmQNL20QajSgO7Yibd/7a0IDsBVVgdRv1uTrO9KCd37N2dU57lXqm4bNXaRchzXbT
 EA/z18DOKzjS1DWtWnO/ngbWojHQ3VY60ovM38EJ7q2H9LBzfCRGdN0POjJ3FSiLrzx86Kq8qJy
 JhBPN0QWlNRvu2juSijWctzO0hzBQK1NX4h0mLlZ4m2zBxTWEL6zw9Cd6LwpUZ1SGzGoDvEYuGz
 Ftk2Dy5W/6mRz7FS1+WCdNVrWPiCJi7x1Hlqlg7Pr7Zhn9DfJQ8u3LNL67p3+x9OOgHqxFsx7pU
 a/c5pjxo5z+9fkfAekTxDnNDMNvTUJ7R9YnMnFyEjEuDUGBa3zPGqZx0kXQcUX//lDSOfACAwcR
 6I0R0NqPj0SCetsmGEQ==
X-Proofpoint-ORIG-GUID: mU37Mv4phLDhJGnX9rwylUMOE2esyjFE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230184

On 7/23/2026 9:56 PM, Luiz Augusto von Dentz wrote:
>> | Vendor | Coredump | Other                                   |
>> |--------|----------|-----------------------------------------|
>> | QCOM   | 0xEDD    | Enhanced Logging (0xEDC)                |
>> | MTK    | 0xFC6F   | Firmware debug logging (0x05FF, 0x05FE) |
>> | NXP    | 0xFFF    | —                                       |
>>
>> So this hook may need to cover both. Any suggestion for a good name?
> Derr, connection traffic is not handled as events and you have the
> likes of  hdev->classify_pkt_type(hdev, skb); to reclassify them to
> HCI_DIAG_PKT. Don't tell me the firmware it generating Connection
> Complete, NOCP, or any other event, for these because that is totally
> against the spec since the handle wouldn't match any connection.
> 

okay, got your point.

so, what about changing recv_vendor_ev() to recv_ev_vendor() to map HCI_EV_VENDOR ?


>>>>         void (*recv_vendor_pkt)(struct hci_dev *hdev, struct sk_buff *skb);
>>>>         void (*notify)(struct hci_dev *hdev, unsigned int evt);
>>>>         void (*hw_error)(struct hci_dev *hdev, u8 code);
>>>> @@ -2329,6 +2331,7 @@ static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
>>>>  int hci_register_cb(struct hci_cb *hcb);
>>>>  int hci_unregister_cb(struct hci_cb *hcb);
>>>>
>>>> +bool hci_recv_bt_vendor(struct hci_dev *hdev, struct sk_buff *skb);
>>>>  int hci_send_vendor_frame(struct hci_dev *hdev, struct iov_iter *iter);
>>>>
>> [...]
>>
>>>>  static bool hci_req_is_complete(struct hci_dev *hdev)
>>>>  {
>>>>         struct sk_buff *skb;
>>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>>> index ea858391c789..94c02b66bdfa 100644
>>>> --- a/net/bluetooth/hci_event.c
>>>> +++ b/net/bluetooth/hci_event.c
>>>> @@ -7801,6 +7801,11 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
>>>>                 goto done;
>>>>         }
>>>>
>>>> +       if (hci_recv_bt_vendor(hdev, skb)) {
>>>> +               hdev->stat.evt_rx++;
>>>> +               return;
>>>> +       }
>>> This seems too early actually, I would have expected it to run after
>>> hci_event_func or within it if ev->func is NULL, that said we
>> I don't think running it after hci_event_func() works, because the VSE has already been
>> corrupted by then, as explained below:
>>
>> msft_vendor_evt() is the handler for all vendor events called by hci_event_func(), but many
>> VSEs are not MSFT ones. Once the MSFT extension is enabled, it always calls skb_pull_data()
>> and corrupts the non-MSFT VSEs.
>>
>> Besides, running it there is asymmetric with the ACL path: the event header is already pulled,
>> but the ACL header isn't.
>>
>> For ev->func is NULL:
>> it may mean we don't need to care about that event, so the current behavior of ignoring it
>> is reasonable.
>>
>>> currently assume HCI_EV_VENDOR=msft_vendor_evt which is probably not
>>> valid, or maybe it is which then screw the whole idea that 0xff is
>>> only used with 1 vendor specific domain, now if we try to squeesh both
>>> a vendor event and a msft event handler their opcodes shall not
>>> collide otherwise the whole thing doesn't work.
>>>
>> let me explain more for recv_bt_vendor() for BT as below:
>>
>> Design idea:
>> let the transport driver consume whatever frames it is interested in first; for
>> the rest, don't care how the stack handles them — it doesn't matter even if they are
>> corrupted.
> Well I already told you that by doing preposing we may expose driver
> to the same type of bugs that existed in core in the past, so we maybe
> reintroducing parsing errors and since this requires to preserve the
> skb it will not be able to use skb_data_pulll (which internally checks
> skb->len).
> 


Sorry, my description was misleading.
The callback registered by the transport driver is meant to avoid pre-processing:
the stack invokes it for the driver's VSEs of interest, and the callback then uses skb_pull_data()
to handle the event just as the stack would.
>> Motivation:
>> For the VSEs and vendor-reserved-handle ACLs that transport drivers are interested in, move
>> their handling from the transport driver's RX path (IRQ-disabled context) to the stack's
>> process context — i.e. avoid pre-processing them.
>>
>> Advantages:
>> -) Avoid skb_clone() in IRQ-disabled context of RX-path to improve performance
>>    take INTEL diagnostic events as an example, btintel_diagnostics() skb_clone() them
>> -) Avoid re-processing VSEs that the driver has already handled.
>>    Intel diagnostic events still arrive at hci_event_packet() in hci_rx_work(), even though
>>    they have already been handled by btintel_diagnostics().
> What does btintel have to do with this? Are you saying there are bugs
> in it and you are trying to report them here?


No, I'm not reporting bugs in btintel. Almost all transport drivers handle these vendor frames the same way

show what this callback may improve, using Intel as an example since it came up earlier as a reference.


Any further comments ?

