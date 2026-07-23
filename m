Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6E1432300
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784805510; cv=none; b=r+3MJ4zj2wc4H0/hOL9iz+NzMvvLBwmS4x6bVe8ryig69lHHxiUo2gq610KwYrxcKH4+jIJGiiAUM0qJy/8VKA0/RcQFvjDiIAJjauBTBenv3BxClG2g9u/TxQDRxIxh8a2rpQpqhTjPe7GGGepNItSIZgX3T+FRuR2e6MXJ1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784805510; c=relaxed/simple;
	bh=1kK754C6DIq905tXo1G0GWpWAdhBNFss+tgn5B7F5lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BS0eG39H7MOrNBrjWWmfZ7vMXty3mGcClFXmuC5PTJgXxnwVUx6j7elRypOlOvvxzIeVqB4/cEFFq7YYKsH3f4AaIMU6hYp1cGnfrSCFwqNab98T65nURbOiK7ZUliEXmhWdOxj1yh0KvfzeNzISMV4q28heHIfrv5YkpkNXa4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dlNV2efX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fmckQGGs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dlNV2efX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fmckQGGs"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N8qavw3668003
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 11:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ItUM4hhcjDTFOB8mblvsJ6pDULGNPhKo1DxExHccibw=; b=dlNV2efXkAN0kc8Z
	8RWBqyBkgMKWFQAtplsIy0BjosNjy/HgjqZ9mcontzg+NAyYA7dcEjgkDYsGd/yc
	jf8d3miEug70gR0/W3MeTvrCorxq7ZjGA10S19ZAiFHSLXtmX5XW4IAAVNAHL84b
	B2wC/kyp2j8SnYfbRqTGguV/A7xOSFcYbbPHR8beVhTsfKR/mIWZzrZdXZib7eRV
	qtNEvx4FMlMKW4tgPWHY3nl4BlQbhEeCN6jKP0v27QT5EybhRLPAzidodD48D0ji
	32DLd8Tz1rWi+tppSU8mjZDOt7+eD+vshWU1He89uNX+yVNJeOyH83YlHhochOqj
	zMMaNA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk5cc2wpm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 11:18:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc7ea29141so2830065ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 04:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784805506; x=1785410306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ItUM4hhcjDTFOB8mblvsJ6pDULGNPhKo1DxExHccibw=;
        b=fmckQGGsFc6pUBQMLLUq/rmMXw3OGY0z6V2Zo9iaFiT/7DnQmuklIGjqQIOvQQkp3s
         hUL0Mch1j3yanIuM/gtXm5WxooMeZ0sG8zMr/IIcNMcKHsqdh3Mb3mVgVmyWhDQblmW6
         1Ro+Nq0xutdfMC+60yTUhOAnuv+mfP2seYH5UA68S8tLwmLvrT1XnETm0yQ0eAb9bDdD
         UXly/ogccVYMV4XziPx5unWPnBhl87iv8Fq7NpN1omVtO2YNkdWMVJz7oXI/yZk4Zgy/
         CdWOttk3U0ETuOuDSZQWzm+ZRQBcwnnEuhbWzoWYooQsD6dRhfaAvse78id50bbcT1vH
         fJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784805506; x=1785410306;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ItUM4hhcjDTFOB8mblvsJ6pDULGNPhKo1DxExHccibw=;
        b=KITDGXME0pBKsZjRz1k0Y7+nN7rmwoht2cPRVUH/R0TIgW7LLHcbEOHQbDsARc7yCb
         eeXI+7yOAr7r1xAMYlH8/Gv3hMIQ5iuQErKxtk3LtQ4vWr9qncXlrBDgSJEfaN3JnhHn
         NfQn4/txcvwFoPkHmPSRhwZJCyfpZAVJj7ElGNFmO6Fzla/w0GbLZxYqX/ERxeLCma5h
         1rcF0H70hGu9ovf6erKUGUNhuVTJUeWFWou8yBs6IUa4sFgr2JLt5P9NeuI8vHbgzl23
         0IXdJlKjq0951hCObPntsrvAcYVWO+1rTSG6y/DLjXLrIPj3dQFZJiIg8Tv26huQxwuZ
         bUqQ==
X-Forwarded-Encrypted: i=1; AHgh+RrHWlhNutLGNl3qnuNmL9i9cFtSOQ19KKzkn861yD8Iq7f9ARE1RVCm0uoqQUDBPWQnipKsmwIHLAm+mnl/kvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxpHmaVoDXT5/473JMexi6lmpMskl0aQZ7mp2hxEiI01RvHdgV
	hr5GYeb1MihJ6LBPXvjmmVN/N4FmtJheXaJv+BnNxNHcupe/5+ui4JQnTNfQfl9u9iciFOFHAwW
	+edLd0W43FFGm17gavoICgokUWeo6nUKw58+6dMamzavPO1lNuhMmuCp6Kcc8cQB3DToXrn4qSe
	HBPF5nJQ==
X-Gm-Gg: AR+sD103Ge9V6Gl9T2DEKD8SZ4K5KyCQHkM3NK2qToxryDs5+LPlbQauGQVlV5kkhTQ
	3VfM6QL72ZjxUlaj2hA3omGBc93K583oR7RM+uqErooXLxyL8v134UW69jpblkNwydCclMem+DS
	o4ZCafJStMw0dBeMmwE7xWd4RURZObyhV3U/S9MFr+MCflKb+hQcYBOnLR0WdL3fL0z/srLgKEV
	HXy/QeXttjaQF2slUNQtj2EKGhabzrNzdU/P5ozjdPbfppeMbZzBDKU3ICrcS2sB1M9o6AGt4g5
	jaMUplpWtUflUyWYW/dpbdR/PE6tK88sbFVXZ+zOazVC5ASqtc80IrgK1Mpp34IIdD7c9nPfZED
	pmbKhvOKBfxRlqD9uwj06omIA5oGlHax2ifUd1ldj2J7Yv7I2rOrDSz6dhxHOgy8xfg==
X-Received: by 2002:a17:903:124c:b0:2cc:e648:7e0c with SMTP id d9443c01a7336-2cfa6f8c2ffmr23522355ad.7.1784805506530;
        Thu, 23 Jul 2026 04:18:26 -0700 (PDT)
X-Received: by 2002:a17:903:124c:b0:2cc:e648:7e0c with SMTP id d9443c01a7336-2cfa6f8c2ffmr23522065ad.7.1784805506044;
        Thu, 23 Jul 2026 04:18:26 -0700 (PDT)
Received: from [10.133.33.62] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f3b46absm31470715ad.80.2026.07.23.04.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 04:18:25 -0700 (PDT)
Message-ID: <c17cedf9-a013-4ba1-be0e-46f5650ddd89@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 19:18:22 +0800
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
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZL7ApV6wzTOLGu4gRxBU_89x+D-JNd27tg0X-sOmXqEog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5UMSeSDhtKyheSh2I10LFSF08OLfc-r6
X-Proofpoint-GUID: 5UMSeSDhtKyheSh2I10LFSF08OLfc-r6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDExMSBTYWx0ZWRfXxS1I8DIhn8vs
 P84C6PuV9pLZLzgPeCw5eTAA7ijNWh2gbaEft/BauC9bMmXnDysJNcFsaMfLaEpaiF++dS5Pey4
 hNkw4XT0lnudN/gGcmIYQvdu8GE8SdQ=
X-Authority-Analysis: v=2.4 cv=L/ItheT8 c=1 sm=1 tr=0 ts=6a61f883 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=ai_aT568vvjzOLvgrnMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDExMSBTYWx0ZWRfXzWd4xrKHiXSl
 +EOwtYryMd+xkbbw+lJs/gbvybX3+ejeQoQqIaFx2oob2JrZrdHIzTpvyA5veq/Yh0wTSrZHCsu
 C7C17gOc8iISdB9nOkP2fsDAGEUV9kiQgVVc7bNm+frCJrEY2u9x8bLRYbjHvtKtKliLzXkBWqU
 aghQAvgQT+aemqGzzxGO+myHR6NRCp6Q6FtY8ab7VSaEWlVt9wsEqIBqk17neuvXiO3C0p4IAfI
 Fr8AZRPl0AiypvSjQuGgWobidY531LdUmMIQx+j6z1G0tEZOOmNDrDsRB2ror9p/3gDlmFwvDIr
 1NJN6rv9ZD70nL0oxrfn0c97vnAfWNCodhy5Vy6wvxbpyqJ0bpwARwG5ldKaUKr2QpAO/5kPLhU
 OcnUFvNNDOp6BS5at34CEawA5slmgR5MF1tIkqqmp9OEhqgLGBfnnyPbH07xAw24Jlmk/F7yXeB
 vHGM8ADiE3ct9hL28Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230111

On 7/23/2026 12:46 AM, Luiz Augusto von Dentz wrote:
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 428261591288..12f3720f6cc8 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -646,6 +646,8 @@ struct hci_dev {
>>         int (*setup)(struct hci_dev *hdev);
>>         int (*shutdown)(struct hci_dev *hdev);
>>         int (*send)(struct hci_dev *hdev, struct sk_buff *skb);
>> +       /* Return true if @skb was consumed, false otherwise */
>> +       bool (*recv_bt_vendor)(struct hci_dev *hdev, struct sk_buff *skb);
> This should be probably called recv_vendor_ev or something like that.
> 

For BT, besides VSEs, some vendors also reserve ACL handles for special usages, e.g.:

| Vendor | Coredump | Other                                   |
|--------|----------|-----------------------------------------|
| QCOM   | 0xEDD    | Enhanced Logging (0xEDC)                |
| MTK    | 0xFC6F   | Firmware debug logging (0x05FF, 0x05FE) |
| NXP    | 0xFFF    | —                                       |

So this hook may need to cover both. Any suggestion for a good name?

>>         void (*recv_vendor_pkt)(struct hci_dev *hdev, struct sk_buff *skb);
>>         void (*notify)(struct hci_dev *hdev, unsigned int evt);
>>         void (*hw_error)(struct hci_dev *hdev, u8 code);
>> @@ -2329,6 +2331,7 @@ static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
>>  int hci_register_cb(struct hci_cb *hcb);
>>  int hci_unregister_cb(struct hci_cb *hcb);
>>
>> +bool hci_recv_bt_vendor(struct hci_dev *hdev, struct sk_buff *skb);
>>  int hci_send_vendor_frame(struct hci_dev *hdev, struct iov_iter *iter);
>>

[...]

>>  static bool hci_req_is_complete(struct hci_dev *hdev)
>>  {
>>         struct sk_buff *skb;
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index ea858391c789..94c02b66bdfa 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -7801,6 +7801,11 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
>>                 goto done;
>>         }
>>
>> +       if (hci_recv_bt_vendor(hdev, skb)) {
>> +               hdev->stat.evt_rx++;
>> +               return;
>> +       }
> This seems too early actually, I would have expected it to run after
> hci_event_func or within it if ev->func is NULL, that said we

I don't think running it after hci_event_func() works, because the VSE has already been
corrupted by then, as explained below:

msft_vendor_evt() is the handler for all vendor events called by hci_event_func(), but many
VSEs are not MSFT ones. Once the MSFT extension is enabled, it always calls skb_pull_data()
and corrupts the non-MSFT VSEs.

Besides, running it there is asymmetric with the ACL path: the event header is already pulled,
but the ACL header isn't.

For ev->func is NULL:
it may mean we don't need to care about that event, so the current behavior of ignoring it
is reasonable.

> currently assume HCI_EV_VENDOR=msft_vendor_evt which is probably not
> valid, or maybe it is which then screw the whole idea that 0xff is
> only used with 1 vendor specific domain, now if we try to squeesh both
> a vendor event and a msft event handler their opcodes shall not
> collide otherwise the whole thing doesn't work.
> 

let me explain more for recv_bt_vendor() for BT as below:

Design idea:
let the transport driver consume whatever frames it is interested in first; for
the rest, don't care how the stack handles them — it doesn't matter even if they are
corrupted.

Motivation:
For the VSEs and vendor-reserved-handle ACLs that transport drivers are interested in, move
their handling from the transport driver's RX path (IRQ-disabled context) to the stack's
process context — i.e. avoid pre-processing them.

Advantages:
-) Avoid skb_clone() in IRQ-disabled context of RX-path to improve performance
   take INTEL diagnostic events as an example, btintel_diagnostics() skb_clone() them
-) Avoid re-processing VSEs that the driver has already handled.
   Intel diagnostic events still arrive at hci_event_packet() in hci_rx_work(), even though
   they have already been handled by btintel_diagnostics().
-) Log them via btmon to help debugging
    Several existing transport drivers consume these frames directly without btmon logging

I'd welcome your thoughts — especially on the hook name (point 1) and whether the
placement/design here is acceptable. Happy to rework it based on your guidance.

> Anyway, I had the impression you would be using a vendor packet not a
> vendor event, or you use both?
> 

My PERI-HCI requirement is already addressed by recv_vendor_pkt() in [PATCH 2/3]

This hook, recv_bt_vendor(), addresses concerns raised during the BT-HCI discussion. The same
problem exists in many transport drivers, so it tries to address them for BT along the way

I'd like to use it in the upcoming QCC2072 support as well, once these concerns are resolved.

>>         hci_dev_lock(hdev);
>>         kfree_skb(hdev->recv_event);
>>         hdev->recv_event = skb_clone(skb, GFP_KERNEL);

