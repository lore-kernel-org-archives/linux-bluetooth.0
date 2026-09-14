Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61013254BB
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354419; cv=none; b=OrpsNUN9rL/5ZAzq4PErRAcEH1yxYdzWm05/Qe+RJQBZj6/OizMaPViJYhBmGDR9DYO3rRXkjpFV9xdZbj0ty1DAFSh5rJMxCXFMNXSHUqlwzN8cmuJ0CYz4mrt+4I7EW070ftFWOOHG1KYoC4QxHu78X03NunbbrSJYHOc1G9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354419; c=relaxed/simple;
	bh=icPOzgcWIvuw0uTvq6ks5737DnbhG56HAut0RUhgDxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFhhXLp1PgpDhRSr4E3vm6sIH9zHaSA2/+vrQ7ExPzi3DcK4N/rVCO+YNrPh/iQj0H83L2Pl49PpJk3IYqI9599/aJwRXlppmc7yG7vmvLjbG53nBndqKkPi9HzkwRnCwmrHoaTFEoOmNaNvp6/U2IOkyPvf/AsVXCYaeNSDQtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GNSopEAl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dixh3/YO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GNSopEAl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dixh3/YO"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E2enuC2242303
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 02:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	icPOzgcWIvuw0uTvq6ks5737DnbhG56HAut0RUhgDxM=; b=GNSopEAlHUVgeNFx
	txa5Pxwjvy9uzOTJy2QEngWN/vWQSQOShQuMiDUnngLtLo3mbAR4ymb+KDyXHkke
	LtApvRrypIJFeluklsLGH6Gwc9wOhxt0fpGMAhFAgbxeKkqY2o7999XROjTY50TY
	dyOsAyBtwkyFRyqeqclAU49GjidPs6uq/VSUIQjLE3SfgbE2y1+oPQw4fGiULZjt
	WOFoKMXzwogBMCEQouoalpAEqu5vjz/oUMVUlFWLYodCOQAVl8EKBlo8NaZHEPzV
	gCsp3WNZF9+dGmCczDOgcoOGenrNNTacNsKAndgzbEwi2dI8aTOLZkrtdHTMNo7o
	SFripQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmywh4m37-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 02:53:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2dd15dd1254so5912125ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 19:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789354417; x=1789959217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=icPOzgcWIvuw0uTvq6ks5737DnbhG56HAut0RUhgDxM=;
        b=dixh3/YOAeuCgOQgRuFfxZ5TfnIJaLc8NnMjcnDtGFbtarkw6fS5t2Yf3gOHplRUo9
         FjVAYbZDD+olh6cj9tCugAAuIODNNQxgeo0JCHAzUx+ri057czFkceJ3JxkPCdZ/2JZ0
         HMXAEo3d+5WJmIakhWGXEWyLb0YfusBcJNBgT4bQDcaOwXSK1ck3fuMgnaLCME/+t95Q
         PEqJ1kr79Zj3e6ebd2rRPzhpUKarqPp5sGUdxisNRP8+DnPt4GzdF4h117DqgWCyECi2
         Z1Q1tGc4yACJZni3IkMgMQ7sn4V74pk/cHI6fmMhXv4DcHEUTegJU6oR2IWivWeGdRt1
         zECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789354417; x=1789959217;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=icPOzgcWIvuw0uTvq6ks5737DnbhG56HAut0RUhgDxM=;
        b=Ow8fO89yamTyaZ0W56U8O7ay+zAD1FU5aASZcN23BOajwVShQdId++lcuQ9RSwdcWw
         IAOuL9WNFq0nIMOCev4n607QInGFbpt20raDntdI9Wgznu7QJoT6eDVzoWwsyCPkkWcm
         vLhQtg1RQIlniLZJNqYkkZ/uW7H9LOwH06grV4Jiy60QJzwjZa8ZsKCrxyQAEnwcLO3E
         Y+QfDItKVO376+qXh5sQh4Q78UH6/u0ZKGorvanWUygEfU098ztAADzBIcYtGO8oy96Z
         lzpx63KJ6/kGQugIMwu96tY23QdPGV2gwU82hC1BW3gOt1PKm4yM+QfCAvXSSAnbIWTx
         6ywA==
X-Forwarded-Encrypted: i=1; AKwUvBwk6M1JxO3iBbbgJHlT8JaL2Jv6vf2SO+Dpl7Z+alO7QKX2TvloR+XZYIvh7dADs/hhVD6gRP8QS9CpJQ/4A1Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lfSJsBOJsHLdcBAGozSWkNCBhCqqmGDfZ90hpKpnQ00d/VzOi1
	HdHiILseFcQkwMD2HAcLLlmv3olEuwoLEvWCLXEsGmRR78+iSA+oC8NKBr80QuXtFDXNweU8OEh
	/9KHU+SRcf96JBfgqLZetDT3L0lL8ykM7WES46PhokeDBYmKT1F/b+icV68xNY0XyCPhWaLRzaV
	41L+1Rnw==
X-Gm-Gg: AYBFou05HE+1lV9EcgCwmI/nsSHbeXdE+qY7fbYQ1PC1rSQY1J0XOrNH8Vh69+BGBOn
	alhuDa5zrSmYwHUCEezYmOIKScwk849VJ5Eo+L9MOfuMed1QJ+yq5m41qls/WvkmN4kDOPiRLF7
	5KlEczv9gv5VU42vxntX0/Clt9mSIgNIT2wrQI7MGsXeQmZrboDd2zz3D1B/83Z6YUKpoq79VrE
	OLzoaVRKfn1SkrkctarRbyJ6EOf7P5QHe6cl3KjA3msQJ9JOjWq29X5E+C3KliwzuFlcko3JK25
	aaq65im7lRLhHSSOvomH/198gmAiZOxvHjWXSL0SkF3tGpztZQuZ+yIG1LCUQ8h7Ixwq7UYPiRb
	I8o972XszNdLo+cVVAT7503NBYYXRkXQTEpTXRSvRzwzVncsY4RxcPQhQ7TmG8YuwNw==
X-Received: by 2002:a17:903:32c8:b0:2db:7799:d2f2 with SMTP id d9443c01a7336-2dd6c6d26dbmr9161965ad.2.1789354417139;
        Sun, 13 Sep 2026 19:53:37 -0700 (PDT)
X-Received: by 2002:a17:903:32c8:b0:2db:7799:d2f2 with SMTP id d9443c01a7336-2dd6c6d26dbmr9161655ad.2.1789354416739;
        Sun, 13 Sep 2026 19:53:36 -0700 (PDT)
Received: from [10.249.22.197] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c652ab37sm4193190a12.11.2026.09.13.19.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 19:53:36 -0700 (PDT)
Message-ID: <6e3de792-85c3-4264-9d1d-cdbb8f6ed025@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 10:53:32 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] Bluetooth: btusb: Add support for Qualcomm
 multi-subsystem QCC2072
To: Pauli Virtanen <pav@iki.fi>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260911-btusb_qcc2072-v5-0-422754f4e938@oss.qualcomm.com>
 <20260911-btusb_qcc2072-v5-4-422754f4e938@oss.qualcomm.com>
 <7bfc5ec0438b830386ae2899756bb9a7c4b9e123.camel@iki.fi>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <7bfc5ec0438b830386ae2899756bb9a7c4b9e123.camel@iki.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o9FDF1qdOjEZcjhoocUpOOKoueZ_3UBs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAzNyBTYWx0ZWRfX9dqd5vAO2zQa
 5IwpwuLV3SZjvDJgvl5KOu3jw3ELS3INP2mlisCYtaS5ysOoAwA4P95Rx8LDMEwupxqU5Db0Z2w
 du3uQoGBM4qAxMPsWXj1B6Dq5d77Nq45mokELI09ZJy3lZGP+sPsix8jMd1p2nU3+x0BaqfkIy0
 sow85xVKTvSXiNXDUqjdZNVXt+OtytHJP3kIzBFL2PT/or8rztrwFTXwnahThMO5DhjgJ+NqUhY
 Qkm52qULOttN2YdTXFNhqBm0wGIFfLqOZUKYXksKUAEiVxFGo5SYmieKrCnv0hd205J8yQiBxJe
 4nNtYqTapxgS+8zG2tr2xvSWmM/tMfkFdQeKdm+PFV9HY09ir7nNdmfkMPRD0GgNnm22kAb7aQJ
 gwEv+FRPqL3z7vZnaCCfX8oIx/Ai6N2UH/h+4gtyl5Dgl02pHAYQTUIcGFejG5xEySASpZPNpEz
 o2AHGii4AXxH26rp02A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAzNyBTYWx0ZWRfXxOGm8tmn5LzL
 HnGkeIJATW6uidiZOVFnWMwloaKYVDmpWUNvKssuQCZQlyHYWokP5wGAT+KC598jDB+Ug1JV1Xx
 3GM233EoUKYdd+9jQ/DGoE8kLYcFQlI=
X-Proofpoint-ORIG-GUID: o9FDF1qdOjEZcjhoocUpOOKoueZ_3UBs
X-Authority-Analysis: v=2.4 cv=PsUG/AM3 c=1 sm=1 tr=0 ts=6aa761b1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Xph3HbxepIq20FQ0PPUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140037

On 9/12/2026 3:56 AM, Pauli Virtanen wrote:
>> +/*
>> + * btusb_qcom_send_frame - send a frame for BT or PERI
>> + * @hdev: the HCI device
>> + * @skb: the frame to send
>> + *
>> + * Implements hdev->send().
>> + *
>> + * Return: 0 on success, or a negative errno on failure.
>> + */
>> +int btusb_qcom_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> This one should have __context_unsafe(/* conditional locking */)
> annotation, or no if (need_lock), to avoid warnings on LLVM 23.

Good catch — fixed in v6 (below) by adding the __context_unsafe(/* conditional locking */)
annotation, per your suggestion.

https://lore.kernel.org/all/20260913-btusb_qcc2072-v6-0-137898715844@oss.qualcomm.com
