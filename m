Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FFD44A3F4
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531182; cv=none; b=IrrOP6ceSWlMdeJygXwNj371dpirnwLQPqEziu+7BTCKBAA4Hyr5mPP8zWh6H3Nu9J5Tr+uHfRSxpfa/XkmVL9HxyV5scpy6CTbmy8dJMHoHkD6TwlzyGomYSMvIJjf4Fj3ARaFOIsvQq4YsYuODv73Zb0IOK+UAzTCii+uWGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531182; c=relaxed/simple;
	bh=ywjOhnNtSsmmExse+PxN9ib8BnryclmhM+qqGrebH3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfyFSRBh2O6Oqmtcf7WyNA40H15bt+Mx5p1FsvHmnuE06Y5IAm8mxOmbuumBN457BOyKd5KZGMoRPzF0VuYGnQXDsvgFSHTTgycZqOhy63woQJCk7bSI0hTec0f350JWPxfROSn8FrehB96iqjAW/FMJ1YoBtbSjvwUBBXkh6ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nSc8zEZi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WPAknK1M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nSc8zEZi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WPAknK1M"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Dh3jU042878
	for <linux-bluetooth@vger.kernel.org>; Fri, 4 Sep 2026 14:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nePafkd5NjqrJ1hFqCeE7q2D/hApSTFpXGlo5tdZ478=; b=nSc8zEZiykgUM8aA
	WqVY7uY26XhCJ/XkZncqJKZfCd4oxhA5BwjF8M+ex/FSxOdwnFZStmut8H4GCY3m
	gnYLEI90uTyoqz8P5ukb8voLrOMfnM/xMIai0h8aYPIIYEKO+yTOMV8P4ULlGlYM
	xpOgUuYPxNo1atKCK0x4H9N9te3y1BwLXacPW/8N1CbhPS3MQ/KGto1Z0Yn39/my
	IEe51V5YRSoIO6P23PXDJuHA3BQIPCUzZcwZK+tcHdPUgnKrbgzH7f20KAJhpXlD
	Xu33VCH1sUcpfwUY9WzKzFwvGp4mj0kORlBqeOGyPzd2e6gxsw7wWXtmJ9Hw38Lf
	T0BotQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfhc9ubxc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 14:12:59 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3989c51d5daso230842a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 07:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788531175; x=1789135975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nePafkd5NjqrJ1hFqCeE7q2D/hApSTFpXGlo5tdZ478=;
        b=WPAknK1MwI8d4a59PAYt9oUeEBzH8D+gh4wGb70GkQaP45qLiQjQ1+Cldgk9m0N6sM
         qleFZJDxD8D2cwsr2t2xaMrCgXPQ5dsFQKBXhS3ErlSNYkwwWVJmm7RSCZTfwcjbbk5V
         jvQSeXk3+sLOFWf11ShCZw6BbDu1wgG86+SsocBdqRzCkFwAFfnv2REYPX+dBLAItwhY
         q4LU/A/u667f1zV/70mGvyFMtSV4dCl+woRm6Wo84Txi51vSuuPMtwNK65n5eQDA1LJO
         vqITgyu0y1OoPCsw/dk344VvZ6LJXqn1HWF1tL3CqG7ecWKxVAlJGbP31uifwWK0Y3r8
         b7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788531175; x=1789135975;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nePafkd5NjqrJ1hFqCeE7q2D/hApSTFpXGlo5tdZ478=;
        b=JtYmEi958fBaLUZO7nq0Kh5lAs0rSrvddXQbdBVxm8pfpk2H9pLoONPPVFJA0gGOMJ
         rd9E8AqcI2Ix8cSIjhHIrBcNK1PDbemN/ULV2+feBVOeycB8uLt57n2rp5wr9JGH1AlZ
         IrA78C7TIsdU7hrNyggq5smZAtv0UhWRcfilgd61RHJ8a3iVIH+Iz81ndV589xNrp6MF
         WFgo05GJ4CBr/k0nk/B0JCZNUXAS8paOiLxGa3c0xc4Yt97zRERZNTfKWGyqKc1W4dTc
         cjaGQHlX+/wUEB+d9KZz5grnl6osb9oehuogdvxOfvcwx3Rrxb7KVkIWYzSVKTzAp479
         0RQw==
X-Forwarded-Encrypted: i=1; AKwUvBxJfw6zDEM5pBS00K1U8EVUsxNd50v8xIi6KqB/Yf8XkhvQTwUtFYuD5+UErTs3kIbP2jZhjW5VlDoLQdSFRBM=@vger.kernel.org
X-Gm-Message-State: AFuF++lN6yom5j7mTMIjs7DKg+wX5+3HoUhlzGhb129d4d57404NYyqc
	5EUAMp9qi13idAWI45PDxWmkdA+5tenaEKGUGBPWArN1Imv7T7+Gj2mjvMUuiGDgw96H9ptZ8eP
	Uc+grFlnYqWXrq9FW24Vf5Qy3fcwzakGARfzN0PhjPhFPgdl24KfKJOqK3MUha2Z2iR9hpEH2Eg
	B/PqDBoA==
X-Gm-Gg: AYBFou13y4RY2kC3u1lFIvo5SP3BFiuuh/PRCa4v6Uz7hs/S61KfXoM3peoovplYzJs
	U3dn2JdczkKNAhcw47+tjUUwIRCcLB2eHZG8ZtAf7e0NWcfNL44rWGJZJc0pv5UqoyH2ZhfeWu0
	5ttnURX7jX0fUeVA6MAsgX0Lo2KOMWyDAoAmm0hlAoMsoWrocoSm3j64yjFotWKCu1RIPad+kI3
	3s99g0CnPUhfVJaFYW6NNWEtp2bkNZtGB/HcGy1lC9DRJXhuQ4pL7h49hrUyOZ2anM26E4tu8Xs
	6GLxxrVbDFGAqMw5tHV3E3YQ7KJ3HvFdJajpNv2B9WHUU+6zgkHPfdO1ugg80SazYfQrknQSyyW
	Q4lxAIjacoYP1QDCgUXG52B4okYs9JSv3xT41fcqtmE+VVAQrE4wyJeMpvmDzQfvtsaw=
X-Received: by 2002:a17:90b:4d87:b0:396:d27b:86a4 with SMTP id 98e67ed59e1d1-39b2642c329mr6034472a91.2.1788531174692;
        Fri, 04 Sep 2026 07:12:54 -0700 (PDT)
X-Received: by 2002:a17:90b:4d87:b0:396:d27b:86a4 with SMTP id 98e67ed59e1d1-39b2642c329mr6034410a91.2.1788531174126;
        Fri, 04 Sep 2026 07:12:54 -0700 (PDT)
Received: from [10.249.18.218] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd15asm4919941a91.4.2026.09.04.07.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 07:12:53 -0700 (PDT)
Message-ID: <985c44eb-38a2-48f9-96e8-292b0a39e29a@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 22:12:50 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v3 3/4] doc/hci-protocol: Add BT_RECV_VENDOR_PKT
 socket option for HCI_CHANNEL_USER
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260903-vendor_hci-v3-0-015d62a57c91@oss.qualcomm.com>
 <20260903-vendor_hci-v3-3-015d62a57c91@oss.qualcomm.com>
 <CABBYNZ+1PqFXSqAPNC3krSaTccv4VT7ERNRWkO-pCg3k+qCH9A@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZ+1PqFXSqAPNC3krSaTccv4VT7ERNRWkO-pCg3k+qCH9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oPD3ibG-maID4M_01zEtNN1HGdXAo1N5
X-Authority-Analysis: v=2.4 cv=afdRWxot c=1 sm=1 tr=0 ts=6a9ad1eb cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gNy_FRXa8yMrVXg5snIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: oPD3ibG-maID4M_01zEtNN1HGdXAo1N5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEyOSBTYWx0ZWRfX2gVw0ry53T3W
 WCdaDhZIDYK3NteaE6APlEVvJ3U+yq7oK0zJjvJOkDDiz/8EXQ8T2KrzSnrUCf2IxUDq0NNllu3
 2lQRM4ERYfDKuUcsKIpAdYxyjQP3rRw5CvJJiLNwZuIWbuu2lZGkFim35itOMosJhzHvxMthTPf
 hVK9j9eP8J+2KMgHa2ymwBDMcXxBSz5H3tFwTsPxso2opyUPqS+IiSjZF3qjN1PdH0/0VhO8WNH
 DxksjerCM/1dhK8jXxmRebcl3eEUPj0rF7TkBz/FcHBE5YlrJjtOro9JouZvgiVHW3q36rXooWq
 gKQrvCGbz77i/PZb1+k7IUO5n2/d3x2ZDGwtbgYAQTkj4Rh7IGoQvEvvktR2wrlVTWqNcA7Glm5
 SAGIez/GdU0eOqdZqt6VIw+ug5tRGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEyOSBTYWx0ZWRfX4ghIhCUgv5xm
 VhdJN8buUccL9NUEcgF3BUDvwl4X/Q37QiXjoXfjoeXRDQ3a5lbc+jU9KvuBQhJEyf3Um+S/o8i
 a/2PN+kXkQx3pH8ERQqyYvRsFxgkxmI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2609040129

On 9/3/2026 11:16 PM, Luiz Augusto von Dentz wrote:
>> +BT_RECV_VENDOR_PKT (since Linux 7.3)
>> +------------------------------------
>> +
>> +Control receiving vendor packets, requires hci_channel to be set to
>> +HCI_CHANNEL_USER.
>> +
>> +Default is disabled.
>> +
>> +Example:
>> +
>> +.. code-block::
>> +
>> +    uint32_t enable = 1;
>> +    int err;
>> +
>> +    err = setsockopt(fd, SOL_BLUETOOTH, BT_RECV_VENDOR_PKT, &enable,
>> +                     sizeof(enable));
> I don't think we ever applied this socket option to the kernel,
> though. Anyway, I think we are better off adding another channel,

Hi Luiz,

Good catch — that socket option is introduced by the below kernel patch, which is still under review:
https://lore.kernel.org/all/20260830-btusb_qcc2072-v2-2-5c0e0c9dd98b@oss.qualcomm.com
I'll drop this userspace patch in v4 temporarily to avoid confusion.

> e.g., HCI_CHANNEL_VENDOR which can then allow packet type rather than
> just the known ones.

For this new proposal:

1) Is my below understanding correct?
- H/W wire: BT and vendor packets are serialized together.
- Kernel: splits BT and vendor packets to their own channels.
- Userspace: merges both channels on RX, sends to the corresponding channel on TX.

2) How would a HCI_CHANNEL_USER user, e.g. Chromebook, send and receive vendor packets?
