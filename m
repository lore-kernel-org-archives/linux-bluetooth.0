Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19133C1093
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623968; cv=none; b=nOa9mhx1vhjLjJUfBtP1+9dO/zRXge86ALHD/76v04/w8yYHjgXb8r6o15ZG3YrCIKIrMYehcBt8ooyuqVNF+gvtVzXCGhLTOOeS6yNY7Mq9vPSwpQM3lvA+gyUrbMArToVFnJ5WbLuS5mXVfjY5bg1xcq5d+agCTZSi7b3dzfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623968; c=relaxed/simple;
	bh=hMxc45dbK5h3h4yZDDdw/eZ2hT703Mtnw1BNkPgNr9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZadChttBSn8x+F6PJGi9gpT+iNdA/OVx04EB9Mi99V8hQzARPeMipZ4jCxwet/zGlLifWNFwsBA+RLSReE+152qFl114WvsAUEPVNJGG0tclZ7IZqiIEaj+Pa6Q7MAOYOVwzbEl2XwaFzgQvGDZ8ZXERUwpgzu6Fk7MeR2Vq9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LvFIs1my; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QeGdAxny; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LvFIs1my";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QeGdAxny"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L6FIYu4107224
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 08:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sp65Ain+LL4hQnK7XQICRZW/5ShCZoU6KkrvavJK4GY=; b=LvFIs1myXliAVHN7
	NEebhi2s17C4Nj9kPCGH05++1MUtXEgbfbE0BcfFvIwSrYKcqIyWwYSyK2g8xF7y
	ZioN1qiE895+7C7GazKfGYurH+MyBrrqAJ86wcgNaxWlhwPTqxX5apB/PCLNo+AJ
	XH2Oi8aotfap2FUc/MIAqR6gh4rqBJZeEUIjeMFoT6Wr/Ar44C+HS7JxkdT7+YWk
	DJoYIBfCrc+YozeNv0lWv+KO6cwmVaIqzYULBIUvT6KLJhuyQfVlcrWA/GRTr7CK
	8DkeNEra4L93faa5r0XT7aIab3qW6TQbeSuJr9MwV869OLhT/r4+05MKu/c2+Nw9
	ULJhuA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhvqna98j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 08:52:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9dfa3f8d16so1439467a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 01:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784623964; x=1785228764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sp65Ain+LL4hQnK7XQICRZW/5ShCZoU6KkrvavJK4GY=;
        b=QeGdAxny4vWUbw6YUpL8/YnsNjDqizpsJ25iApVO/GPLDiMiUt+NHYSZrjsnJTRa8a
         exCfvhpiVXeZO1Qb4gXHZxK66Oq0acxWSjMXSICYE/JAqaTm1YYeD+RP+tgkwHch2c2T
         SeFp8yWN/+myzSZ/cZndOKUqfJefXnjpnwfo/LCs/9Lv7fiQJORBtdVLN05MD8H+p10o
         U23gxkAdMaaiftv1GKe08hZuUgnzr97wKXHo2OVA34TMjQEk/Jp4e3mWowx5jC34fd8T
         cF/MFu0Hd9dmlfBDbjtiGz67kw7rHbxlbS8Rwy6kIdrLtCBpAzmvoWe2OP55s/gjfw0I
         o59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784623964; x=1785228764;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sp65Ain+LL4hQnK7XQICRZW/5ShCZoU6KkrvavJK4GY=;
        b=Nu6s+/kwAN938eGuH5TJGzNZ0i4Noj35IaW9X4OLYIsdJxdNp9f6q/uUWApanEpnxC
         /xz3Vrvb+URuMvuHut/UyAsnCnaJpehFySicBErb7FD6XiJiy0l+Zh1cEnwajmSNOMWf
         LH/Vd8nPYya2IiWKrKstg8H+/3zzI/EYpr/dspB4fxB5efk/aw4v1aA1zuSzVxkKKh85
         AQ/wCSz3Yvv3LHoiYAXzIQkkxAj/RXRuan7Pzw4L0hr08iFhlQdjk/eyJx8Gg3P0d9J4
         6a4U+ChnBIioyUCYNvfJRHTXxJcLKL91lbisGZPMMtEU9HgR0DOTW8qzgl8cU9WS4NB5
         +eBQ==
X-Forwarded-Encrypted: i=1; AHgh+RpP3szgw7Tc+VZBdTK0cghjGfMzZGIMWILUSCMepkmHht9C0syVsNWhllkC/dgcoZO3ehtfGLD6eNpZ0yu/DTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ePIacV1q7ZlnEwtoEMCgwogDQ0w6N1zFkc7RrjrFi+3xNtl6
	eohepJxNVeu9S2vN2nrM3eob7dcFY1KhQlmu5Ppyl0ypCfxcqNBvficNtcQmhlIemM2wMoRk7ew
	Lq20NsPMBzzPkim4/qVOK8AAn3rIMJzR92ZgRBXuH740aad5iPyAfihJLIME3GoQ0xco57eU=
X-Gm-Gg: AR+sD10YbZUxW+8kuJ39luHHR6lbzvTIN2XhbYV70fifJTmpRhMVMJ8zfoxfUiTHVYl
	0Vhq88fxkwRHvQtvlX9OWpTl6AUt9WadxJS4qbHK337UV3PYyhHa1TRG0kJ8jMpMeeh8qusDP3P
	koTZK6qK9NDwXYCGG04ppJ04d62KE9GooyWQt/JotzU1m4E2uJWDq5GHVdLY0Lf97HPjWdq1p1m
	3R28dkWKdUrvcUtdrfgs1qq8kjUg9J5SQQ/bHlmPQV1gSENwYc3lr14QhsA8CUfiJFB3Euq3Hpo
	XzcQwelB0w6uusUbBljyw7UPufx1sqgC/q4qcj6IQuBrwMOF0uT0k6T02vPBF2P3kmN3sOprwBo
	nkT4LO5bGp34MJfedsKz1NaDE8x70A2pEALdYfLtbohD6zvh+5aOvr0U0qmg5i777UIQ=
X-Received: by 2002:a05:6a00:a386:b0:837:95fc:148d with SMTP id d2e1a72fcca58-84e02f060e9mr1811822b3a.0.1784623964440;
        Tue, 21 Jul 2026 01:52:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:a386:b0:837:95fc:148d with SMTP id d2e1a72fcca58-84e02f060e9mr1811806b3a.0.1784623963864;
        Tue, 21 Jul 2026 01:52:43 -0700 (PDT)
Received: from [10.133.33.193] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2bf08b7dsm7218502b3a.10.2026.07.21.01.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 01:52:43 -0700 (PDT)
Message-ID: <0c5a924f-7382-407b-a0f4-dfd7dfe0d5e6@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 16:52:40 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] Bluetooth: Add generic support for vendor HCI frames
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260719-support_vendor_hci-v1-1-764523a4ca3d@oss.qualcomm.com>
 <CABBYNZL_H2iRAshF-RCX41jbt0jots5i5W=aUUJC_wEN6wzp=w@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZL_H2iRAshF-RCX41jbt0jots5i5W=aUUJC_wEN6wzp=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA5MyBTYWx0ZWRfXz0/ZNnZdnChh
 iqqc/ghxzkDNYEh5PJm2JYm8YT0Uz2nHtZdE8TomlpSVhfmvcsVjbNWLCMC+rzCzIDV/qNKTxI7
 IcDZbXnpnIyxZuSatCJFJY8xJ4jluZMplpL+7UcaCYgEvlNDzBflNcyN+PKx84h59kAmw2JxOa4
 0WrRAQ6525Z/IiYkN7O09PqWEOjlZLON4gCKBXXQOKgG24QPgSS7vIU6D5CSPoXuLgWae+sZgaB
 OcMhmUpy/EsD5H4D1HUDHP9YiXJJ8jcFN1oBO97uoaulLMHEEdYDFRSTGmLLCcuAjUx2cTqStId
 rvp+p0cbVyYwKC4s/VOTxfTmlxEW9hlq9g8mRA3fLbRu1KIe8LQRcbmoe28otXrzIPyCWSBQerl
 nDmiKQx2wB1JxMqeWgoGg7HhPEzt3T+VirHiwiWzeDMnnGaCwQ7IvYJa28TuVmzWfTMEnYjIgEN
 GZ8tMoSv6znndp2fnSw==
X-Proofpoint-ORIG-GUID: vL1nNhw6z2PcU-925e8V5pgGk0Jw8T9F
X-Proofpoint-GUID: vL1nNhw6z2PcU-925e8V5pgGk0Jw8T9F
X-Authority-Analysis: v=2.4 cv=M5F97Sws c=1 sm=1 tr=0 ts=6a5f335d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=qJ69AeZdAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=frvC_GAFQxaIm3GKjhQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=0Y2RA1oIKXp_UzxCg4Te:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA5MyBTYWx0ZWRfX7j1URuuiDxRp
 wrtCLVOrEiIYf3NEi9nTao4J32y5NMHnF7I/AjzkpDzxMt/3NR6/kvDk876Lti+w5X2BTRQZlBo
 /lvYd2SJiyzHRm4ezzCEZp3K5aIhM2Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210093

On 7/20/2026 10:30 PM, Luiz Augusto von Dentz wrote:
>> For Qualcomm multi-subsystem BT chips, the transport wire carries both
>> BT-HCI and PERI-HCI frames. PERI is a subsystem on the chip. Take the
>> upcoming QCC2072 support as an example:
>>
>>     Packet type                BT-HCI indicator   PERI-HCI indicator
>>     --------------------------------------------------------------
>>     CMD (Host -> Controller)   0x01                0x31
>>     ACL Data (bidirectional)   0x02                0x32
>>     EVENT (Controller -> Host) 0x04                0x34
> I would say this was fine, but you actuall need to reclassify these to
> 0xff and then use an extra byte for the vendor opcode. Btw, you said
> you could define H4 headers like this? The spec defines either:
> 
> https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core_v6.3/out/en/host-controller-interface/three-wire-uart-transport-layer.html#UUID-1cf959bb-57a0-e782-4324-a9bc4ee3f134_table-idm13359018144714
> 
> Or
> 
> https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core_v6.3/out/en/host-controller-interface/uart-transport-layer.html#UUID-83881875-5fbb-c366-400f-055ba726f70e_table-idm13359015052542
> 
Hi Luiz,

Let us label this approach — which multiplexes the vendor indicator under 0xff — Solution A:

virtual HCI_VENDOR_PKT (0xff) + vendor indicator (0x31/0x32/0x34) + body per indicator
I did consider this solution — let us discuss it in the section below.

The PERI-HCI indicators (0x31/0x32/0x34) are defined by the Qualcomm Bluetooth Extensions
specification for the USB (Bulk Serialization mode), H4 UART, and SPI transports. They have
already been deployed in several generations of commercial multi-subsystem BT chips.

> We end up defining vendor 0xff because it is at the end of the range
> which is probably safer.
>

I am not sure that fully holds here:

First, vendors likely reason the same way — "end of range is safer", Take Qualcomm as an example:
it already used 0xfb/0xfc/0xfd/0xfe as internal indicators.

Second, current transport drivers already use 0xff in ways that break that expectation,
as shown below:

1) bpa10x uses 0xff as the wire indicator for HCI_DIAG_PKT (0xf0):
https://elixir.bootlin.com/linux/v7.1/source/drivers/bluetooth/bpa10x.c#L72

2) btmrvl remaps its wire vendor type 0xFE onto 0xff to carry Marvell vendor events:
https://elixir.bootlin.com/linux/v7.1/source/drivers/bluetooth/btmrvl_sdio.c#L797

3) hci_vhci uses it for the handshake that creates the virtual hdev:
https://elixir.bootlin.com/linux/v7.1/source/drivers/bluetooth/hci_vhci.c#L462
https://elixir.bootlin.com/linux/v7.1/source/drivers/bluetooth/hci_vhci.c#L523
>> To generically support vendor HCI frames:
>>
>> - Show them in btmon logs as they appear on the wire.
>> - Allow userspace to send/receive them via HCI_CHANNEL_USER, with a
>>   socket option to control RX, defaulting off to eliminate regression
>>   risk for existing applications.
> We shouldn't need to do this, we should just accept 0xff as the vendor
> packet type and then use the following byte as the real opcode (0x31,
> 0x32, 0x34). Otherwise, if we start accepting vendor packet types
> outside 0xff this will get crowded quickly and could potentially clash
> with future specs.
> 

The indicator is a full u8, the entire [0x10, 0xef] indicator range is currently
unused, and vendor indicators should be deliberately chosen to avoid conflicting with
the BT SIG assignments.

>> - Add hdev->recv_vendor() to handle vendor frames in hci_rx_work() like
>>   BT frame handlers.
>> - Add hci_send_vendor_frame() API similar to existing __hci_cmd_send().
> Encoding/decoding of the frames should be transparent. I'm fine adding
> code to the likes of btmon to decode vendor packets, we already have
> something similar for Intel although that uses a vendor event not a
> vendor packet (both use 0xff, causing the confusion). The user of the
> user channel shall be able to read/write starting with 0xff then
> decode/encode the next byte as the actual vendor opcode.
> 
>> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
>> ---
>> Hi Luiz
>> To address the below concerns you raised on previous
>> discussion, and inspired from your suggestion to add hdev callback:
>>
>> - Not use safer skb helper like skb_pull_data()
>> - It will skip sending to the monitor, making debugging much harder
>>
>> Looking forward to your further comments.
>>
>> Why hdev->is_vendor() instead of multiplexing vendor frames under a
>> virtual HCI_VENDOR_PKT + vendor indicator byte ?
>>
>> 1) The virtual HCI_VENDOR_PKT isn't used by the core itself
>>    currently, and may be removed later.
>> 2) It makes full use of the indicator (hci_skb_pkt_type(skb)) space,
>>    which is large enough to accommodate vendor frames without an
>>    extra layer of nesting inside HCI_VENDOR_PKT.
>> 3) It lets userspace and btmon logs see the exact same frame as it
>>    appears on the wire.

As noted above, I chose is_vendor() over Solution A. My reasoning follows,
for your reference.

1) Userspace sees exactly what is on the wire, in the same form as BT-HCI frames — 
   clear and consistent, as shown below:
  ┌───────┬──────────┬────────────┬────────────┐
  │ Frame │ BT-HCI   │ PERI-HCI   │ PERI-HCI   │
  │       │ existing │ is_vendor()│ Solution A │
  ├───────┼──────────┼────────────┼────────────┤
  │ CMD   │ 0x01 …   │ 0x31 …     │ 0xff 0x31… │
  ├───────┼──────────┼────────────┼────────────┤
  │ ACL   │ 0x02 …   │ 0x32 …     │ 0xff 0x32… │
  ├───────┼──────────┼────────────┼────────────┤
  │ EVENT │ 0x04 …   │ 0x34 …     │ 0xff 0x34… │
  └───────┴──────────┴────────────┴────────────┘
2) is_vendor() puts PERI-HCI on an equal footing with BT-HCI, so userspace and the transport
   driver can reuse the existing BT-HCI path rather than add a separate encode/decode layer —
   less effort on both sides.

Could you please give me a clear direction 
Solution A or is_vendor()?

I need it before I can move forward with the remaining QCC2072 btusb development work.

thank you.


 
