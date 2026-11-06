Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793946949;
	b=nRO3S8mEFA3lUnKHkP0Ip3pcwY3xYSv8OOmZRfMxe6S2/cwFnIVs8171wY2vdU+FJKU/
	 9KWWGxzSNiM2o2xPSyXiUOZd0+5lzrR8Qn1PlWqFVp1Uru0b4dRXgbKdXNpmh8M497UtE
	 Ea1qOjMcXMHBLKvZx6MOeQKfBWJKd6vLzckxPW+LfsqrZt1vS2S1gL81BuI8/9J7UCI+L
	 JKGGtECGqXnBLm4knCm6JNhO6ZJ1isWzjwrzNYUbn9xmx2BxpijnYMXtOe0RBS6fyHSRY
	 ei+4zVBTNDxRhT3RiJkHUO3fLwJ6vIg0jdj7O3BefDSuPdu33kvuB0u1MMpl43xR7/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793946949;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3+/i/L1YsccLk7h47H4OBMl/+UTR642ye1G9gviqzEo=;
	b=0ZK2gGEtL3ke5jhZRtIjIl+riKwjok7/zsQvzWi0QAf87GtBqdKGC/W9gKtqaNHraEzT
	 TVY78haJ08gVay+WH/VTlhffiJGafYc6BZrrrkDhm9ndr1Y6+TD0gsOrsuVcpV5upnP32
	 z3LL9LAdtwomHKqKZU8r5ygMvFRcTrSBPZL7hwLBgaWJP4tY/OOiZJtkQq6BYlsLLA6n8
	 MlZPd1xMxkpL5vWY6P9drfFt4jOZnvi28X2kPRDli8Czljd5OiA0nHUtbMerVbXvRvI3K
	 XkO13a2qXZgOfMA0f6WJy07IGBU5+3e8ez/dkB9YoMguGYXCJfKUaWpRWa37pXo7V8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gsAeyLH4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YO6cRFze;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52289606A328
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 06:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52289606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gsAeyLH4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YO6cRFze
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A63xurn3775366
	for <linux-bluetooth@vger.kernel.org>; Fri, 6 Nov 2026 06:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3+/i/L1YsccLk7h47H4OBMl/+UTR642ye1G9gviqzEo=; b=gsAeyLH43045rcAh
	2/hFbqSuIuICOl92IQYvd/0DQZRJDqn0TeVKRDm9eVnQYXxjtE3xyTcSqgDFCz3R
	S455QSbL7DivsWLSuf1zrXtcTjFDSuDhwaSuReQJjLdgIxfhHK+sEfq0wtBs/xSm
	8XAjjClQUEkWBq8hC7avhaIKVpWA9yjPcvJ/81VS/B9sztQ0iBb716NcNqmXcZM+
	be//wcYJ/bG4I7idm/K9FriKTITnpm+Zz4Wb6GQB0t3RgeV6+/axtNtKkAuVc+r7
	frJSVn+hgcMAb6xI1JetNlCZJgn1CYpKBbq8PuFpb5Itrg0Rwbu4YZSTNG+muJKA
	LCQWjA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9sdak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 06:35:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eaae62796dso3993835ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 22:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793946948; x=1794551748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+/i/L1YsccLk7h47H4OBMl/+UTR642ye1G9gviqzEo=;
        b=YO6cRFzeorDgOYsZEc0kIF5pDxse5ZSNIYTI7KEjWmS68WOy6h5sP/3Kuowhf257G4
         GfIHbp9dgcclCJjlkgS3l5Irf3CK9e9igFftEDcf8TtjxiCwQojU+GFcUJosGZzkVY9S
         l03MmAdg7jWQle58+mha0G87C04h+Yyngsz6FfjZuw7lwH/2HVJhh82BBYNAX9qpuBa9
         NNE3dmiD9loPyl8veg9v5DBmpDfJEGrr/KwIle5IotK4jH8KuHyfuM2/vAn9owh882Rs
         CFDV5YZoV6gNGVNuSWXmJnImxgX111i0Z4nWfQA7eJL4qBIJJxUs2kPJaVZDuUEE+WLs
         bbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793946948; x=1794551748;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+/i/L1YsccLk7h47H4OBMl/+UTR642ye1G9gviqzEo=;
        b=p1yn2yKzBDIjF0qm/r9Hz8CrUjfMygbQOTbpoAbe8WgpZx3IWlICnEHSyOMBLIXsiV
         nMZtrd8sZuYCjLz8H/88YSjT+DjHPHcA9ZKE9GJ5dnet/JTTcHFhkzgzxdaIZVDcsHWE
         5V1ibaPDNSNV1HsXdR6b4KZsQIFRO4KYSUZF1VMPwrIHSvc9VhzJS04G7ZdYoF2g6mde
         rj3iRINqjx8dEeE92MVroEY5vfS1p1AlWDTE73BUyVo0n4Ci0qxXdqLTMhByEnvaaNmN
         /9aHoFXa/Ku14qnGjWEkZ3VvJcDZXtH7NP0mt7ki1tP1Hpc6yiIIKEi0nAhobeF4nmqy
         OHGA==
X-Forwarded-Encrypted: i=1; AL+hErFKoYg9RQG/vwyA+6lJuUTi1+9yDU6QIEpmAB1HS3qULTavtg6c7Hk5CLOVAGIqGVtVdDkF3or+pKEAXxHOBig=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NisPWLKpeJeNqLgaPN4NyxN2Z/s6xiIrTWrpbjqttjL1bt4oo
	z8MYtv6ArdswAmSA7omIfp5JGZjQgv1AwKtiGWzRpG9OQOH4oUNzJsbwKSpa6IOrvO+Q74+MVfb
	KN/zPccws9ctJQEWMKUF1ZC9eiEUmfBsPO2iai51d/UEPbYEcGgHIjfaOFUMAVCUEIca0SuXxWG
	zDID0=
X-Gm-Gg: AYBFou2srtvQsuqorlEYes+7j5oXsGVdjOsgM4hlQrWrpEMbkWTgYTLOpOAUK4HTp0h
	/OZo/2UvLqupBKTkmylPvIz7ygTE4R3Tb2tMb1CiDPqbQcsfuhgKOWwFjRbaW3/BVfDElwCrMgN
	ePSzczaW4R+nGJvOAZcT/YzW6bDOwOBii93JPBQ+igHEh934PPWaLtFteMxp+xWgsxIzygGh1kL
	DqclbGF8Af0UdJ9SUs8M2dutTFMdt6EdNzVdSvBqGT/S+5Lw68n0z7dcGdWDlYdclL5iZYgNFZ6
	AqtjHqvAWm41ob78GVgFPqz6uTrkytDcWVUqlLZ8n7CsthdnTUH9eKAIiH1dO32Qk2uIqVWIFHl
	UDSLuPtAGkpWPLSw14/Fn0lXaBaFeVq28P6Y8hMmrji+DCZFfGXxcE4rbn6d37/zcxYYWWfPQqh
	k=
X-Received: by 2002:a17:903:f8b:b0:2df:9655:fe24 with SMTP id d9443c01a7336-2ed40ad5971mr20472745ad.30.1793946947726;
        Thu, 05 Nov 2026 22:35:47 -0800 (PST)
X-Received: by 2002:a17:903:f8b:b0:2df:9655:fe24 with SMTP id d9443c01a7336-2ed40ad5971mr20472565ad.30.1793946947269;
        Thu, 05 Nov 2026 22:35:47 -0800 (PST)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d40998sm2193875ad.34.2026.11.05.22.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 22:35:46 -0800 (PST)
Message-ID: <561c0f8c-3252-4802-9d2c-ca1f93c65247@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 14:35:25 +0800
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Bluetooth: hci_qca: Reopen port after power on for
 QCA2066
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, chejiang@qti.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20261028111839.2148515-1-shuai.zhang@oss.qualcomm.com>
 <ygy2hd47c3tb4vr2joiiy4bbg7rd4pn66x3co7iifv65cvnrf7@g36i65agh6p3>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <ygy2hd47c3tb4vr2joiiy4bbg7rd4pn66x3co7iifv65cvnrf7@g36i65agh6p3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyNiBTYWx0ZWRfX1Esd7zKD9ytn
 JMbI4Tka88nPwixQkgmXVL/H7LprYuuYO/lcQucSlPN5nQvZEYpok0eXBv/RcPD30pSUeIN79wk
 9BsV0POqOH+QJlJ1476PmSz8SB6/EKk=
X-Proofpoint-GUID: TDaB971Q8Dy7djqlK-k8xMcTlIerZNUj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyNiBTYWx0ZWRfX211La5lO2ysS
 wRNfxHkPe3vv9YmskVRc1spgClMgj4Osx17mi5uxR6TYkCMMn7wmcSWepeGlgL6aTWJhlKKF9ve
 MAjgzOTIj9ZV9GV279vRhY6vUXpuT4XxyZwle5oTnpvkAXrvOGPA0H+rCOCNoD5GwbkP2UAiTAg
 83SqwgNzXVavVu6w5vszyAxQ47DQcgh+vlmaYwv62RVWvdvSq7ArdVekUIpVAqmafZa3pbmXONt
 n1EUNZIbamijL2Co2f4n2e46bB2XR6QgEaF/2tkwXGrrbgLWIRrEaIzcmcBjcFXpMdx0pKOWhu0
 q21ZYUCQda+4hbpVUQNXjg/FBFE7xW3d31PV9zlb2JuDfaNzsyNf8MAB2FhqOLem9GafhYNyfda
 GKkYNxrufNn7nCtddy/lYsOJgzZjIg2kSIPP28jz5bvgfxtqSMj/7DoDjvDJ8UovyrVZJGMxHpn
 h6QROLRft84U2D1kjBg==
X-Proofpoint-ORIG-GUID: TDaB971Q8Dy7djqlK-k8xMcTlIerZNUj
X-Authority-Analysis: v=2.4 cv=ZIZCCn7b c=1 sm=1 tr=0 ts=6aed7544 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=scBA0uvbmrWxsdo9N8MA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060026

Hi Bartosz

On 10/30/2026 5:29 PM, Bartosz Golaszewski wrote:
> On Wed, Oct 28, 2026 at 07:18:37PM +0800, Shuai Zhang wrote:
>> QCA2066 needs the serial port reopened after the controller is powered
>> on, otherwise the host and the controller run into RTS/CTS
>> synchronization issues.
>>
>> Patch 1 reopens the port in qca_power_on() for QCA2066, as in v2.
>>
>> Patch 2 keeps HCI_UART_PROTO_READY in sync with the port state, so that a
>> port which failed to reopen is not closed or flushed again.
>>
>> Changes in v3:
>>   - Patch 1 is unchanged from v2.
>>   - Add patch 2. If serdev_device_open() fails during the reopen, the
>>     port stays closed but HCI_UART_PROTO_READY stays set, so the later
>>     serdev_device_close() and hci_uart_flush() use a closed port. Keep
>>     the flag in sync with the port state and skip the port flush when
>>     the port is not open.
>>   - Link to v2:
>>     https://lore.kernel.org/all/20261016022302.4003647-1-shuai.zhang@oss.qualcomm.com/
>>
>> Changes in v2:
>>   - Use a separate case for clearer logic.
>>   - Link to v1:
>>     https://lore.kernel.org/all/20261015092224.262158-1-shuai.zhang@oss.qualcomm.com/
>>
>> Shuai Zhang (2):
>>    Bluetooth: hci_qca: Reopen port after power on for QCA2066
>>    Bluetooth: hci_qca: Don't use the serdev port after a failed reopen
>>
>>   drivers/bluetooth/hci_qca.c    | 46 +++++++++++++++++++++++++++++-----
>>   drivers/bluetooth/hci_serdev.c |  6 +++--
>>   2 files changed, 44 insertions(+), 8 deletions(-)
>>
>> -- 
>> 2.34.1
>>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Just want to confirm if there's anything else I need to do before 
applying it.


Thanks,

Shuai


