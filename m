Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275DA371878
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784085017; cv=none; b=Bn8GWwrHqX7vhJInGQ+sdE3QnYFg93jfMkVRpkwf7+Bh/rHJ4U7SM+wsnyLUXHDJMN4VbiihHWOGB/MvmkCRliye0eD+O/pDPu0Q3fJCGI/sqrJ9hSLTMclvyLrQul3SwmPW3+uj700GVxDh9AKtF4qqSqodiHyT6xzRYMwp5R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784085017; c=relaxed/simple;
	bh=IpXVAneo1Yy589buKUqD05+cG1blQ4ITtHZ9Cm5D4HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nxsfzxm6KuXIDdVq2aWwRDhpnGuNRSSpzRJGw4xo5y8zoXN6xZqmxfTkan67s+uKvgoiIg0Ec47cj7X14MPUg9a5/7N/GF98s+PsgOrGbbAevA9vkPIO4ZPYhpTBm49MXW5EB33ka54S6PVNP4IOGm3A7CFY+BapI20tUAEfYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dNkIuSa6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A3ATh7Vi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dNkIuSa6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A3ATh7Vi"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F0I33t1817102
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 03:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Xjs2fC9ieXXWSmVDoHAQMwHnQ0z3CYip3E43+W3Ucg=; b=dNkIuSa6ItDMysdb
	2+K8lJ1tW3HxCNiNgPP4/4QJ5ceWyl70xi7josDBYZdQF8jiHJoPZvTOf13II2pu
	Ygjg/cL8RyWNmxDUHAxU0ggh1U4Lm2OXJSStXEduGGcfhT+rOh5oIY0bohKarAWT
	t5CUUEZDC1CX4BKtCb2yGPPFjWAU0DoS+3DlY24j1SipfzIwkMutOWlN5pO2QZ1e
	L8xfKRnPzC3NkzSMs+f1dpAmWPrRBjdASPmhviYaoRPNuXkN5/YSKtI8Nts+cJBl
	e9p+0cUz2PklEILhzl3Ax3sroxdfqwCuwk+56oVQeh6uNBYX32fZBAgC6+tTbHe5
	lCGVng==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9mhp82-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 03:10:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3811d5ecf66so1679914a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 20:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784085014; x=1784689814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Xjs2fC9ieXXWSmVDoHAQMwHnQ0z3CYip3E43+W3Ucg=;
        b=A3ATh7VipU6uAdnGWduD5lIrjToGE4g3JItAFzyMNS3MhFii8XlXXPN1R7HeGRS4Zz
         Kco6+IAx/lDMyhujTMBGNED1dYtQKhxmhSaLpCtFjGBCOyZJFZU2ZhHt/081vcT8WElg
         S90c1T/7FPwtc3vpN/aucGw0uZF79b4nteMQtgoKPG4dF7hP/85QuHs32rXkuObVAuXu
         /+ys54DcvYNaHFzqWmOKFrzA5W1OZwFIqwkGF2vHLq2AytwC2GR66vpwBzCgepZr5Vto
         XNxlFwpl/07ofF6FBYP0ahrsVhrYd9BQtdPzVeoX2SAdQ8CK5LV4hiMGdGnuvdG09x/N
         sotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784085014; x=1784689814;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Xjs2fC9ieXXWSmVDoHAQMwHnQ0z3CYip3E43+W3Ucg=;
        b=AJqoWJdFju34rtotArvIJ2i2mz2i/zeMMdQPbQTnm1Nwkrqlc8T64Pyrp3KPP6S7BS
         aoOTCVV8HoL6YsIZteD7Y5JqZf2mccba+HWxy4mcKaELxQkCg4JA+YIKVtzhJdCgVlaV
         O78D0dCrUZJQyNDal7JuLrckkU+4ar56Xxrx+bKdRS02tyosOad9NTHP5ovHJQr7vo+g
         antdy4x/tTaomylR9SbbFHCo03e+xMNALcGgF0FcmHkeKLnAOd0ov916qwatNPdL0LQE
         Ek8ivVbfzjeTbAP8fyUrAwzhJ2krO+iDl9XMFy8NpFG9LCveDTwTV1R81ZCKvETuS4Qz
         gKtQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpqs65oLlwecyoIQz5k83vtzBSeec7BJ2V+9t9U0PtO59ymF+Qk8G4JUZFX61xkLs0YXC434GmynYVvvZzBkqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ftn04C0ilez2gJPcPFq6eUup4JTTHu8ONCdOrlFTlX6IBnvl
	kcK4zM3+/FQ+VWgnmlFWojqk91UAVS73h69DqDWsi9nakny1PQLJ7R/GgZSbWCcxau7okYOcxW2
	69xIhe5YYPrEcaeA6wOoxFoAb6Kj41+c02yTX5gjs4OHE/XxYk2ygMsL9YLeDFT7V+6OWbmqMIX
	k2Mlw=
X-Gm-Gg: AfdE7cngt00zA3W9Lqgiv1K6MFwuLk3VYWemCE4GPYRI5ToH48OOl+ziHZdQumtBXPc
	fVdeIX+5Eq4XHa21pLBW1XBCWp23l5fjemg5X83sRssVQfAhG3El2GqMNNSuBGH64RuQgSrHOMb
	tPSm2vhKt67xKT/cdZ7CsoUXpNkMWqVn5JKcLQizGuCg7de60+bO2cZc317QvQS0lMbEzN1/fa1
	bpkgxEW+xn39FcFd2C9e66VsTC5+p0Fz7wI1+Kw24i+ttPDSTLMyKXQABkTNwjL+lnA1NKeYf+M
	wXFhAkKpreApntucmF6hem2WzKZbgpclpHkBKsxk4ujhu0D8xCBhXMi7A5KhzHD6aEOvlBa7ISv
	y2vtDPSQv4E2kMUy11qVMJpC8kA9zehVjooZVg7Kx1aERXP3cIuoRBlSKDnpcbDvQCNE1xriEsT
	c=
X-Received: by 2002:a17:902:e845:b0:2c9:d8c6:1db3 with SMTP id d9443c01a7336-2ce9f3a468bmr125428985ad.8.1784085014355;
        Tue, 14 Jul 2026 20:10:14 -0700 (PDT)
X-Received: by 2002:a17:902:e845:b0:2c9:d8c6:1db3 with SMTP id d9443c01a7336-2ce9f3a468bmr125428835ad.8.1784085013842;
        Tue, 14 Jul 2026 20:10:13 -0700 (PDT)
Received: from [10.133.33.9] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cee5ccb56esm26819595ad.84.2026.07.14.20.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 20:10:13 -0700 (PDT)
Message-ID: <d6454997-3bce-4cc9-8a91-29ada0aa882a@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 11:10:10 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add support for Qualcomm QCC2072
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
References: <20260713-btusb_qcom-v1-1-39cabc0dd601@oss.qualcomm.com>
 <CABBYNZJpdeoZ16bObLRPhng2dfyNeK9ix9_-z_hMZhJ0QxTxGg@mail.gmail.com>
 <3d681f10-959e-4d0e-99e5-a471ef8929a3@oss.qualcomm.com>
 <CABBYNZJ0zoVVVxuM48L=Km==gnrQuskrbjB6q_aNV0KEEY3+5w@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZJ0zoVVVxuM48L=Km==gnrQuskrbjB6q_aNV0KEEY3+5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAyOCBTYWx0ZWRfX0gB56Hr+5IYg
 xm2JEiDuG5iqxecYxijZ8/ek4RA+DeWM0Y3upBOtwG4RqU9qF1OJ5MbEfGwKWSdqvIYw6X67zNx
 lXdByYJUIeWQgjUhW3OD80Ho23kj/3pdTXsgeGX8MKt6dJMUSWjl5c2G2XRqD5JfGvhuJntaDvJ
 jSKGcco6V1V53qCnmqf/5An70fGfZMjdxaL5cYZgvamdeqSwb04epHME84FT3gOEVvGZ1KtzsxT
 klXkk2JNe8cTecs/CAP7oZPbgtboLQU1mtL+vrWw8vMDEEUBhsMvnDT+iqNx7kD/af8MJUZrGP2
 khHNKotXP55EYGIbA2W4uhENpZ/Yi/DaRzeIyRaBMN/ee311GU+zjLrYIm6mG52OI59KMQtGvgZ
 VMuxtJ3JHylmEZ45kIDEG18GVo9broLRAsk7X+x26WX6gz7p/+c/XYDY1KrHOGJlNsvSlQvPKCu
 tR13T+PkaFCkUu5D99A==
X-Proofpoint-ORIG-GUID: cDxQS4ssHaqvt-kwifJkAF335fGZJMne
X-Proofpoint-GUID: cDxQS4ssHaqvt-kwifJkAF335fGZJMne
X-Authority-Analysis: v=2.4 cv=E+79Y6dl c=1 sm=1 tr=0 ts=6a56fa17 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=yvZH2E2uQzYK1ld5qGQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAyOCBTYWx0ZWRfXxQnTEoPNe6Ad
 cE/TRFE6tMxSGwZRHDKjRxP5pwyeFWK4xlOVHL5+mHhlQVSXGAxG7c0U2UJxOoZ5wCJwWiQnMeB
 ubj6wA7VnRkabyL7LwssibuepXMTvpc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_01,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150028

On 7/14/2026 10:29 PM, Luiz Augusto von Dentz wrote:
>> A.  Why pre-host processing?
>>
>>   QCC2072's endpoints carry non-BT frames (PERI event and PERI ACL) alongside BT frames. btusb_qcom.c must first reassemble the raw byte stream into
>>   complete frames — of either kind. Once assembled, non-BT frames are intercepted and handled locally; BT frames are passed up to the stack untouched.
> Well they are still HCI commands/events aren't they? If they properly
> use the vendor command/event range I don't see a problem here. Also,
> if you pre-process, it will skip sending to the monitor, making
> debugging much harder.
> 
  1) Yes — they do belong to HCI we call PERI-HCI, which differs from BT-HCI frame format in wire. We
  mainly use the packet indicator to distinguish it from BT-HCI.

  To describe the *wire* protocol more clearly, let us use future 'USB BULK SERIALIZATION MODE' instead of current
  'use EP to mark packet indicator' as an example:
  PERI packet on the wire: [Packet Indicator] + [Host ID] + [...] (Host ID is a single byte; 0 =
  BT host)
  BT packet on the wire: [Packet Indicator] + [...]

  ┌───────────────────────────┬──────────────────┬────────────────────┐
  │        Packet type        │ BT-HCI indicator │ PERI-HCI indicator │
  ├───────────────────────────┼──────────────────┼────────────────────┤
  │ CMD (Host → Controller)   │ 0x01             │ 0x31               │
  ├───────────────────────────┼──────────────────┼────────────────────┤
  │ ACL Data (bidirectional)  │ 0x02             │ 0x32               │
  ├───────────────────────────┼──────────────────┼────────────────────┤
  │ EVENT (Controller → Host) │ 0x04             │ 0x34               │
  └───────────────────────────┴──────────────────┴────────────────────┘

  2) Why not use the stack's cmd-sync infrastructure for PERI-HCI frames?

  A. PERI-HCI frames are not BT traffic, and handling them through the stack's own command-sync
  path risks messing up the stack.
  B. hci_recv_frame() will simply drop these frames due to unknown packet types.
  C. Disguising them as BT frames (stripping the PERI indicator and substituting a BT one) has two
  problems: they risk colliding with real BT frames, and they'd become indistinguishable from
  real BT traffic in btmon logs.

>> B.  What to do with non-BT frames
>>
>>   There are two options:
>>   1. Don't let them reach the host stack at all, or
>>   2. Route them through the stack by an opaque channel such as HCI_VENDOR_PKT — defined by the stack but with no implementation yet.
> We have vendor diagostic packets already in the form of HCI_DIAG_PKT.
> 
 For PERI (cmd/event/ACL), we can use HCI_DIAG_PKT for debugging purposes. Beyond debugging, it
 would be great if userspace could also access it via socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI)

>> C.  Why not skb_pull_data() for non-BT frames
>>
>>   We want to preserve and log the complete frame for diagnostics, so we deliberately avoid skb_pull_data().
> Yeah, that is price tag of pre-processing, but even for vendor packets
> if they don't reach hci_send_to_monitor you won't be able to see on
> the likes of btmon.

Exactly right — that's precisely the issue we're facing today.

We really want btmon to show these PERI frames in readable format, but I guess btmon can't
currently.

1)What btusb_qcom.c does today for debugging

After a PERI frame is intercepted, we don't touch it while handling it by not calling
skb_pull_data(), then drop it into diag via the function below. The driver's RX path runs in
IRQ/softirq context, so we avoid skb_clone() here to keep performance.

static inline void btqcom_recv_diag(struct hci_dev *hdev, struct sk_buff *skb)
{
        *(u8 *)skb_push(skb, 1) = hci_skb_pkt_type(skb);
        hci_recv_diag(hdev, skb);
}
