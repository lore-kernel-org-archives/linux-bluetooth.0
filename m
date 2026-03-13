Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68708392C4A
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405298; cv=none; b=WJhzVrWp3crQDZ/nsybz51xH/r4VuBXRXMk3WATRiEcZlZtdFgIpNW5IQasKS/J8QtvObC3YLFK6mV3yEYKe2U2sjqiIJ09z93G0B22ckkXzjgJNDv2K7jnUwr9SKVCEbKIiquG0gGsvsy19DmCB30/3/jbEnQKNtzyPt+MhKZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405298; c=relaxed/simple;
	bh=MLe6GWn1t85qkHhX+ZfWgtgT0WtWEg9ITz62wEdKZnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oP0/Iw0slaW/SPB7lt6oeKbI8ZsFZHwqpHxAsFgAylWuPR07oHEN3o4XVcH7ofqWEFBUktxKq5pU3QYKgZ0gMsbimGfc2IHIw3+lqiwJstthyuFcjeJMaYnx+jjgNxpISUMq6pdX5WUBF11ud97APJ4MD/JYJd6Ye553e+sRybE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rr3ioVQT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IZVk++9E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rr3ioVQT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IZVk++9E"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D9U6T01499592
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 12:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RZ1ZWIRx4TXRJFXLh8Hpw25cxx+L/+m3PIUI2NeaN7s=; b=Rr3ioVQTr+Dtyi/K
	tZUyedUze+gvEVCimKrF+AmnhFWnGYO4tA3J81tJqKWYWdQWqd125DBEW28x4x9k
	9C1YmugYdPrh87DQ838cOPNccSiFGPKZwx8HvuNjGEFwzq9g3M5ip3qHyX/nF0Kd
	NbzDxwPDZ2TH7aBNy2JRraUxK078qhx1sFx43mB0+ZoOyh25/t/dk8ct+WtfDUZZ
	pX0JRbwizzbFMsHE9yziUzl8ZIVmMWw66p7kphgJWB+T3jPXaJ2GFbB+86UbfcEd
	sAKcLlEXidkv0KI3TPn+DOB1HgByTOWC9S/a98QDbN6KQAPbhf7J+XWIJIhAKvKA
	H1dzJQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvg0hghrq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 12:34:56 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89a081737bbso19766756d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 05:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773405296; x=1774010096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZ1ZWIRx4TXRJFXLh8Hpw25cxx+L/+m3PIUI2NeaN7s=;
        b=IZVk++9EF7BrHIY+ai7UWOHCFgImDCfJK1ulV/xdgtbyn6XAUcJQRzFKkrUq+xkLYC
         Nht6GUYZyYHeHQvnPKbTQBB/Srs7Ff1MapXvTo/b5pqPmy60w9wW/X7NbDVOWL8L5UIx
         O4PQa6sVXcHlHbBEUl2xziLzBiPcDOaz0tidjKTzIAOL3CXCySnscIqmvUX3lVq0Lmje
         ZWqasVwpjfqEbYs7PHxqcpbTginsXlLSR2iqAQkrO/DBzXEudR58c1c2qcWa9SfQxGWp
         PJwduUVsA4VsR3FPn8RSTqS+trFRrLei4ZeQSZziDEAjUniPzKLl/ZIDf31xwQw0n0+p
         uOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773405296; x=1774010096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZ1ZWIRx4TXRJFXLh8Hpw25cxx+L/+m3PIUI2NeaN7s=;
        b=GnkcGC4pkN+FBREZJnuaAtP0xPg0+HIeiFfbUpsl7sRQ/1RZmA3dKNiVIySmWE2ADd
         5k3QGJi159B5BEgLeuGuYPASIBk+lkAOQ1QA2+avJ4cekUqwQYGYswjE2IZmSC+I9rYh
         Gai8VNrXLxvQIf3RyT/LXVaVva1WU5I6SNqmxq0bMqb5rmb+63R2pJ20jYsJiOP6Lv1J
         ZLyRx+E0Y9XS6ARCfIjPnBp4sfQPuyZ32EveeUqg89uvEHcuklIweE54Cz7K7+GpqF5E
         SQVDml61tW3OFjx5H3lhUpFwTqOa3L3e4o0xfuGzk7qNllYAdO/Hp3kEQk1PT59yOuZh
         Jaig==
X-Forwarded-Encrypted: i=1; AJvYcCWj9DqcIG3LhC7TOM3HhflRi7wkmqzryLwQsQd+k5yg9aUQr8DUi8GvCGKzu5klXzpTl+QtAPsR6SSJtyG0zJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAmc13+b/5ImjKobFWDpLbQwdIHqV7XJi+G7ipMfeeFPVZ7x/R
	afHrJxAVDxVOBDEvWCgXjtTz05/NZCahL8Ewgq8UyLYiRmRjl8TqrOpgXPn0nwsk7frecV2suJy
	dJbJrwoxCNPKPkooqzv+gqQjXd7N9DDH4mDh4pkeq+Vlf5in0aX6bf4TURjA2usmcTu1k5yg=
X-Gm-Gg: ATEYQzwM04VqiH38YteGBBvjMtHcTEueYHSJudY8fvP9KQocQyATin0xFU6gdQx6/jU
	EKgsbLMTJo6j7Arxbzyk2JGS9Mmspv9jPLnA93LtqC3J5CoE0GiDM2tllJX5E+OYTEMjnc46Ro0
	b9BW7snQ+lTj01p63Y7/EpymLoA4pNB8oTRC0OnItJkyoaZUEHDJb2QUPqUiJAXr/N79ICe1qUZ
	UNyqjgTxTB/hljdceogoi16FNI0tnngf87gr5uTWk4e7Bv3U9cQbkrcaSUWL5PNnIWQ0zIhH7zU
	UsNtXQPS496uBWm8rgxmNCs7PlLDWYNipRKSlaJ0/vnkh+JHZm0utw8MRGrv71iYwF4VkJQYCIC
	pQ6EySphNUfM8WqXXIwBT4ANRF40bQz8yd9A2A3e7QwOFvL+u6uMFqI0glwHrxd+GbnMtbg9mta
	tPYz8=
X-Received: by 2002:a05:6214:5e0a:b0:89a:4f20:cb28 with SMTP id 6a1803df08f44-89a81f50961mr29598756d6.3.1773405295733;
        Fri, 13 Mar 2026 05:34:55 -0700 (PDT)
X-Received: by 2002:a05:6214:5e0a:b0:89a:4f20:cb28 with SMTP id 6a1803df08f44-89a81f50961mr29598496d6.3.1773405295289;
        Fri, 13 Mar 2026 05:34:55 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976cdb6936sm42936166b.37.2026.03.13.05.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 05:34:54 -0700 (PDT)
Message-ID: <eefb75dd-95f9-477b-9251-dcabfae47c8b@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 13:34:51 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: hamoa-iot-evk: support Bluetooth
 over both USB and UART
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
References: <20260311090921.1892191-1-shuai.zhang@oss.qualcomm.com>
 <cffdb8ab-a293-4535-860c-378a4b8a3d33@oss.qualcomm.com>
 <97a3f3f2-e9e2-44ac-a682-0e0f0c100a45@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <97a3f3f2-e9e2-44ac-a682-0e0f0c100a45@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=T6eBjvKQ c=1 sm=1 tr=0 ts=69b40470 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=o11hlXMYcrQWRnTjrNEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: IYM1a1ytYBWnrlqE8q_zsCNtKTok_tBR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5OSBTYWx0ZWRfXxvN3RPLoDCUx
 aId1Cf3KZjy7czXmjKmbxApYIeQR8CCr46uEq7MX/G0VFvvYfsSLgibWtjuZZD+/CSe4Xeq0Z8s
 yj1nA6lKdfCpdMKgpdIiQKdJ7LcpQbDwwEKwBQGMw4jh3EgHG3j7wf5qLmm3LpyQqYjTVUAUSOo
 7lvP1agjvFM3hcvPyS39artpDiD6EmY3UC3OdiyJGuzFVPHlnMLqpJpdnwIOmHXlfDWeO4CRHhm
 LN8tgglHW26+0UOhtGYCmz+aYknMdgdaRzKF2kmbNmQb+cbrL4vlt7yUrBwv/OIVhFK6ArGhLZt
 d2ebd/TG3tCHPCICww+Xox8mwKTHsaY9DLOLwhPOmNCOgjhDAi3LlHwoHr9WURolbOeNUvPKraC
 LNj5DGe3Ve29i/ktxYOk1N0FDnGMGLm5RRR8uZmcKrP656ApjV87zR5h9SNdqyvKl5bTgE4EMfR
 HYKw4CyH49vu8JVhYBA==
X-Proofpoint-GUID: IYM1a1ytYBWnrlqE8q_zsCNtKTok_tBR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130099

On 3/13/26 7:37 AM, Shuai Zhang wrote:
> Hi Konrad
> 
> On 3/11/2026 9:07 PM, Konrad Dybcio wrote:
>> On 3/11/26 10:09 AM, Shuai Zhang wrote:
>>> When Bluetooth supports both USB and UART, the BT UART driver is
>>> always loaded, while USB is hot-pluggable. As a result, when Bluetooth
>>> is used over USB, the UART driver still be probed and drive BT_EN low,
>>> which causes the Bluetooth device on USB to be disconnected.
>> Is bluetooth connected over UART *and* USB simultaneously?
> BT uses either UART or USB, never both at the same time.
> 
> On platforms supporting both, the UART driver is always probed, while USB is hot‑pluggable.
> 
> As a result, when BT runs over USB, the UART driver still probes and pulls BT_EN low,
> 
> unintentionally powering off the USB BT device.

Please describe in more detail how that difference can appear in practice.

Is there an M.2 slot, into which different kinds of cards (i.e. ones with
BT-over-USB vs BT-over-UART) may be plugged in?

Konrad
