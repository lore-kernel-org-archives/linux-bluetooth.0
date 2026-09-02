Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251A3442B06
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344567; cv=none; b=k2D3tUEZcEzYjGyPlVrMyJvS8dGpXEwkStEsPsLWm3aY7frh1LW1WV/aRHusr1Gk4HLwnEaYcvqdxtRZrbf0tPnmbvk4mXn78hysMEtRHjnn9IvYZQJcTpbiZwaZvJEvwjW3E/szemra+LoUHRM7kEh1elGMMCCMSt68IjYzjk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344567; c=relaxed/simple;
	bh=BcNll7uqnShMrrAxevwiYVbuj6vM2xD3Lt/5hV5HQwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZ7dHa1mOtA/qv0XJETHPlu2iGFN0wDqCp0hAqLcHwCxjcTGYx19lMa74f53FHw433yGyiAwIwd7MABlS4QiBEM1Syhwn0qPiuLy7Tohvweng3EDv4JA+sZL0/9Ft1xCDZ9fyu/UmI+Gzj0MYpJBOMoPdh0Ddxhld+uc5OsYWnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QIPsfISF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hwjxx7u8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QIPsfISF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hwjxx7u8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682A5hpD688617
	for <linux-bluetooth@vger.kernel.org>; Wed, 2 Sep 2026 10:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pS9VagWr2gKFKf7C+3tEny1uFJ+D8/QGk5rTqi15QCY=; b=QIPsfISFvjulDOtF
	iCVu4TfH0n0mFBJENyPULNUNTlxbfi25SagGyhS7dWpVsm4obBMaKbLR7Mi2zmMn
	8GfIqLP2yPFLLOSmkMKrzNa+csXcxhsvqIgoDH+eEdp7euqdJH/CAQLiTU/spMJZ
	sm4ZvJILyA+s5UKvFHpbp2AHB8e0ZimUImdeAMFg3mS12Jv7SirzW/thZDmdRmSE
	gD98rzAjOV7svN9Tv+Bd9ajRgp7E/0vP3oY07m0OCtpW9huuqctJgXNP6NVAE76Z
	mVUZg30ZeBLjJEmogrrNC8APVRSSQ/cBSBBDu6Q6WLeeloDG/Xuxn/9xxQPkD+ec
	O0mFuQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gehrd82b0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 10:22:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8d1600b3so185845a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 03:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788344558; x=1788949358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pS9VagWr2gKFKf7C+3tEny1uFJ+D8/QGk5rTqi15QCY=;
        b=Hwjxx7u8zbg6JQyxOj6XtAcCJpdMd2WH52TYUIoorfirOD+Kf6TxfpswiZgZQ89BvF
         emS+BYU3/D/sGnWFh40/ebynwCpTlx4v0quOsmyHcXS3KJzXoQ236JxQehhqX68veUuG
         Xxd1KInuYn3hZEuTYjYlQnMZ0KHGejN7xZLBD4BAv5mcFk0fxm2kAJPZbh6hBCZ+Qb1b
         1cxZmeKiNSkSpUEMNpufjhv5tsg3MN+q4RId1YDsCXyYBKxwAHKEFW8FAKKVkXjtQDEJ
         x+cdzMYAbBkUIPEspOZG9gGBBIamJqZ+qyThI2IGPElaAeE3C+Gi4EdsO/7FUDimi5Fm
         M7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788344558; x=1788949358;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pS9VagWr2gKFKf7C+3tEny1uFJ+D8/QGk5rTqi15QCY=;
        b=TqSbK+n3QNmAti6/1t+vivs0Ki6q3zouTF3AgaF0LXgQbea9pOotS1LEnMqi559kwE
         hQ4D3rzmF2EP37hxlTxNJI2da6mwhorPMPxZqlXhNYhTOV49kiV1RQGET6Xj1yfxglux
         NdxAZWi/++xeltRXP8A/pFsoNoIrJJm/3i2G4FatpGUEfNhIC2+lcJz1mm8BnyZUCXtR
         N6PZywx+J6uzloB5YdP52A2QAn0silZ1QNHjQZ1uwo3/fJXa9KX0KbH8TtI8gLWrGKnK
         bJPXwfXiHux/t56I/hv/Cvml1cX6z1zJ7PXdPqxTXM9uSZtXxOA6Is5mLwSMtJsbIb6A
         7U1g==
X-Forwarded-Encrypted: i=1; AKwUvBydSMff6HRIR4pj96jofUqPThGcNVeHz4WEeObd/ciWtVwJwX85bvl9FdTH9R9oh+QF2ny6fKVlsSXVZyDj53I=@vger.kernel.org
X-Gm-Message-State: AFuF++nFqD+uwkDH9p7W8w/dDd+XkrcwB8S2ArjDpvsvEAKvY/Uib+7C
	iXqQTE/XOFeT4f5H6hcDhE7S6A03MQ3NzzxE4JDhNSxGZWh5IL7Tal0JwVMTnsmQmOr1V2Moehx
	9nXo6x9PNU789hxAvQ/F0620zzH6omRh1gt1Q4ZppqIGHAMBWGLBD1u4drmzoQwHLI9e+JWQ=
X-Gm-Gg: AYBFou2AKRtv21d65NYG7Br9+3hRZAsJYl2ElEYdqYfXFhmfuNFs8gLaN5DySWaxs/+
	r/QUDMSfnuVeHxAPooJjW2P7TvTPJJ6P8yp9lffzY4uPU27Da9TX8/WmUgfVmmenJuDNPOR5/0Q
	moaaresUETbsgG46dIBw3iImis4eFqJp5nmYgXiQjem8UCFwDA5MV9ENdf0vnu4HUrTjeFowDc8
	nagTgHVxCykcDbYrutsENbbPyu93O6FtLbqrE0iq3vzKc9PId0Zpf6rQ2N8BJTe9bm7JmoVRgoi
	NR3Kyfmkycbd/UtgKXot7GgTmlhra1lPawSnYMu0znPrmnuRC3KT1vh1OxkDB/FvdZa6DgUtxbX
	OaxETdRLD4Hv5xLru2dtcsmZDHo/IpYGiDpj0pqxNEcrC0pDPi5a7bJVx5KXM8+H8
X-Received: by 2002:a17:90b:3841:b0:398:bac0:238e with SMTP id 98e67ed59e1d1-39aee24957amr3343087a91.6.1788344558516;
        Wed, 02 Sep 2026 03:22:38 -0700 (PDT)
X-Received: by 2002:a17:90b:3841:b0:398:bac0:238e with SMTP id 98e67ed59e1d1-39aee24957amr3343057a91.6.1788344558059;
        Wed, 02 Sep 2026 03:22:38 -0700 (PDT)
Received: from [10.249.8.149] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8ccdecdsm1000056a91.2.2026.09.02.03.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 03:22:37 -0700 (PDT)
Message-ID: <0d642aed-f262-4d59-af18-25aefa29bb76@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 18:22:33 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] Bluetooth: Add generic support for vendor HCI
 packets
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260830-btusb_qcc2072-v2-0-5c0e0c9dd98b@oss.qualcomm.com>
 <20260830-btusb_qcc2072-v2-2-5c0e0c9dd98b@oss.qualcomm.com>
 <CABBYNZLOBVHNvn1=56C-FHc64i5s7SAx3akL5Q3w4oUuekonUw@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZLOBVHNvn1=56C-FHc64i5s7SAx3akL5Q3w4oUuekonUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zJ-LHeEUxQIgaF2XU4PpJIU2OlyZcFI8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA5MSBTYWx0ZWRfX9sf6Oyt1waxC
 M6HwyxVoqPSa3VOppwsewoqqdvYTP8ykostA4+S9wMdm/UwatNM0o1Zg7OXPU8b9ZykdC36Ug8S
 sQZIlxQzqH2li9TOmGXYZzh40QWfmg0MdrDDyZ5TxuF9ivhTgfAbLUZAb8jvlg9oDm6LLmSl0u+
 Q6rNn+pS1NpCabeopTiAX1Y7zDtxZy81AnVfGdc8Zj6DPJLI6VXbxKNjdCzcqBfmR8Ljsh8Nw3D
 SdSHUCKpZ9T/n+g+Q4r/CSU46xr9bJCNGZOZGjbHiI+W1fLy1E5LtZz9Av+vvdvCIMXx8sjZwKf
 eG7+aTosTe3vRH3TuzSBM3xdBhAq5NfA9k1NqzCl3kOUOVyQFF6aUDu354Aj18baHEJ4t7nTguI
 WgfEbEPgp42DAjFTpQaYV9t5Wkxxs8tfv0+VWiCCLpP2YZnLK545yoo4gBPzF0SliiGoRoyxT/0
 g9uEd9GKkD4h5FpTibQ==
X-Authority-Analysis: v=2.4 cv=NLflPU6g c=1 sm=1 tr=0 ts=6a97f8ef cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=qk3LVkjiMVY3ETDBRFIA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA5MSBTYWx0ZWRfX7UMMys5nq/9H
 lNtH2W/+avNMDApsDbE4pAHn0cMvIENu1Z5LdXAP7fXfcddg7exF3xSWcWolW/H7mwblQfZrVUW
 dQE2dG/av+UP9bLSpBgDWJvXgga8YxM=
X-Proofpoint-ORIG-GUID: zJ-LHeEUxQIgaF2XU4PpJIU2OlyZcFI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020091

On 8/31/2026 10:45 PM, Luiz Augusto von Dentz wrote:
>>     Packet type                 BT-HCI indicator   PERI-HCI indicator
>>     -----------------------------------------------------------------
>>     CMD (Host -> Controller)    0x01               0x31
>>     ACL Data (bidirectional)    0x02               0x32
>>     EVENT (Controller -> Host)  0x04               0x34
>>
>> Implement HCI_VENDOR_PKT to generically support vendor HCI packets:
>>
>> - Log them in btmon as they appear on the wire.
>> - Allow userspace to send/receive them over HCI_CHANNEL_USER, gate RX
>>   with the new socket option BT_RECV_VENDOR_PKT, off by default to
>>   avoid regressions for existing applications.
>> - Add hdev->recv_vendor_pkt() to handle them in hci_rx_work().
>> - Add hci_send_vendor_frame() to send an HCI_VENDOR_PKT frame.
> I don't find this one very useful, as btmon already supports handling
> vendor events:
> 
> { 0xff, "Vendor", vendor_evt, 0, false },
> 

This commit actually implements your guidance concluded at 2026-07-20
after discussion:

https://lore.kernel.org/all/CABBYNZL_H2iRAshF-RCX41jbt0jots5i5W=aUUJC_wEN6wzp=w@mail.gmail.com

"I'm fine adding code to the likes of btmon to decode vendor packets, we already have
something similar for Intel although that uses a vendor event not a
vendor packet (both use 0xff, causing the confusion). The user of the
user channel shall be able to read/write starting with 0xff then
decode/encode the next byte as the actual vendor opcode."

Sorry that this patchset comes too late due to refining the last
commit, so it may no longer be top of mind.

vendor_evt() handles HCI_EV_VENDOR, which is very different and
easily distinguished from HCI_VENDOR_PKT, as table below:

+----------------+------------------------+------------------------+
|                | HCI_VENDOR_PKT (0xff)  | HCI_EV_VENDOR (0xff)   |
+----------------+------------------------+------------------------+
| Defined by     | Vendor                 | BT SIG                 |
+----------------+------------------------+------------------------+
| Hierarchy      | Parallel to            | Nested inside          |
|                | HCI_EVENT_PKT(0x04)    | HCI_EVENT_PKT(0x04)    |
+----------------+------------------------+------------------------+
| Direction      | RX and TX              | RX only                |
+----------------+------------------------+------------------------+
| kernel <->     | HCI_VENDOR_PKT, ...    | 0x04, HCI_EV_VENDOR,   |
| userspace      |                        | ...                    |
+----------------+------------------------+------------------------+
| kernel <->     | TX: 22, its payload    | RX: 3, HCI_EV_VENDOR,  |
| monitor        | RX: 23, its payload    | ...                    |
+----------------+------------------------+------------------------+

> This will complicate things because some drivers might label packets
> as vendor while others might inline them as an HCI vendor event. From
> the spec's point of view there is no generic HCI vendor packet, so the
> PERI approach really stands out as a non-compliant solution because it
> uses reserved opcodes.

Vendors sometimes define various HCI_VENDOR_PKTs for their H/W
controller based on their own considerations or requirements, such as
Qualcomm's PERI frames, and BT ACL with vendor-reserved handles, as in
the table below:
+--------+----------+------------------------------------------+
| Vendor | Coredump | Other                                    |
+--------+----------+------------------------------------------+
| QCOM   | 0xEDD    | Enhanced Logging (0xEDC)                 |
+--------+----------+------------------------------------------+
| MTK    | 0xFC6F   | Firmware debug logging (0x05FF, 0x05FE)  |
+--------+----------+------------------------------------------+
| NXP    | 0xFFF    | -                                        |
+--------+----------+------------------------------------------+
These chips have been BT SIG certified and are commercially deployed.

This commit supports them, and also fixes issues similar to what the
commit below fixes for HCI_EV_VENDOR:

0bd606b31d40 ("Bluetooth: hci_event: Introduce handle_ev_vendor()
for HCI_EV_VENDOR")

It is also required infrastructure for supporting Qualcomm's
multi-subsystem chips.

May we address your concern by improving the naming and adding
comments to make each packet type's concept clearer?

May we address your concern by improving the naming and adding
comments to make each packet type's concept clearer in the BlueZ
patchset below:
https://lore.kernel.org/all/20260830-vendor_hci-v2-0-9903760957ab@oss.qualcomm.com

Please take a look when you get a chance, and let me know if you
have any further comments.


