Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE3F363C59
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207233; cv=none; b=EjCO9GDz5NYc41AJx5uA8+NlIDcNtPNPSqOkknlIOtsTSV+dWaOEicQHm0zXb1fUkpeMvnEO2Ro7abWlBO/moSVvHsTLrXekaYIEfoz7vratYiTLrB/PTxzQgr0ZReyDNpEBpmrgGmv2HGJnmCLwnpAe3CPm2ZNmo7LuiA2H+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207233; c=relaxed/simple;
	bh=vh979CfbMMeEW8g0pA8K6/HiWHi0HKSWGmIzWUpa+vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhAHMrkXcehdbRhbIqr4N7Af12n8RginyphYB6XH6ADe9bc60FqruuQutN7uoLqFWj8td7+YrBMDGSmxjF4R2irvvugr1BQS7CGYjDzJUBi0OI3jmvNIfouo5DBldrMeODJcyENyDuFnY2v5BtOp9FV6nGTbzj3UlYT+b6vZsV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U4eyK4qr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NCxI25Rm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U4eyK4qr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NCxI25Rm"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N7j9J01778166
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 09:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vh979CfbMMeEW8g0pA8K6/HiWHi0HKSWGmIzWUpa+vw=; b=U4eyK4qrPLsqIMKW
	EOU3WCnOsqn1VgMNPpr/wmMdwTYqzhbfXeE3E65iW5xeU4ARcJ3zSNGPHFvjUtkJ
	hyKoht64AD/agvnNEOLC5R+IIPhhVW8J5tp0zEQZzT1R5OlkGekFUnzqQj70TmZ1
	l6NZJ0tN1wBThM+d1rOrCHuR0SVXAviak8QwYRKfA/xGIebNkZmDJ8CTleOoiN8u
	lqVFQkqTWsUp42HDX/cohNgI6WPSDqoAepRKkBJxC1WatuYsTuvvQKHy8IHUNnPg
	44oG1xWYa8Dj0KdeBDFTyZnx5izAVJKQgH1XwolhEWDj15/Ndt8kC8FaFsjBCMh8
	HK1n5Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp1gretu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 09:33:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88d7f46becso114805a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 02:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782207230; x=1782812030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vh979CfbMMeEW8g0pA8K6/HiWHi0HKSWGmIzWUpa+vw=;
        b=NCxI25RmiWVkf55WkhFi27CxbJMxNqad/PJiWyTuCyUCrsVc271vmvZwuuAsxaKo3Q
         443xHyeaXJdk8w9Kl6lzfYkGwok7OHReYkUk4SbG/fe5v27pV0A7ZI0n6appiTZG+gvj
         fwnDPcTBnJfCOOC336IkaKF41UM4huQagFMgyNxeXiOxVgG8OAWUnyA12KJ2Eyr6Sl1Y
         nur2ndouKJiJfLmNxcP9ujO5X39zmP5RNuquLOf8HJdy+M0mmbOh/R5+1Jfhtu51mLY3
         0rOrUwQhgWj35EkXA1MRjS/6i6nNQwsLMEM5+8nxSy17szFPai3VRXqxPJvmX3bsSaxM
         lIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782207230; x=1782812030;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vh979CfbMMeEW8g0pA8K6/HiWHi0HKSWGmIzWUpa+vw=;
        b=s0p1/jtCXB8lg4gj9S6s6JnVZkMBl+XEKOAhJfnpZWMqZRuSFs1Ofe9xbcFS3Lkt5i
         FjkOuCrxwgIEhiHncqCqGFZMl0T1ELIz5drQoQNO3mHF/YibgWal0OampsfuAvW8F7c2
         r4yRBJPtv4CHT9ufyaAEEEMQ1XskONXHARDuus2R40NSwDVQG1azNsCvNxm6NxQDi4LH
         l/gU7NSxxPxOKO49tU1qF96nStLZzFMg9SyDCSCt0WR3fZEYJQ5uYgWCzC/zHLsBKQpp
         VDFgWyF1xK+UrHNiPRWcxCO5nbnBVtO1ikPQo3/80jXrPA70K/IZWMKRc5Eqe2b07uB6
         oJZQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZW/Vh8mQKV51vy0w+GYqdSYVJmWc3En99CzIM4swr27ivQgm2EOgAJpx22avZigd8DF5IaOvM/YA4iUsJk7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFnlleUjD2tjZYhWie3JAVuDda9wpTQL0jw9rU/F+zEtyjvr5Q
	ZA39lbuHbkAPybQYYJ32dPPaA0VxEcvYktTw/3sS99CEcuU3eM+dHTRI7epjR0pkN3QaHh+oROJ
	0LVhPXdvI+4AUhR/iw/vXo+NOfnUIq7G407rfmaA+H4TVGu9U80ASav8Sev8I0PJm0QvrUtY=
X-Gm-Gg: AfdE7cmUtcumIeUM2FW/WHrDz1vWEVrDGT1ekiRWMCZamYyvcu0WtiRSDmj1v7z2cMB
	NO7K8QWoPe2FHRaR2RrV6Vo0ycDwCr74ZKR+jD3qC3QQVhHKS0H3llQSSlvQ4kH0lSPoSuYe3+5
	02OXxhQ2uIGjr4BmDvbNSM8lwcYhvijZAOZuQspD3B9liSzjqsC53NLQZhXDfoRVmkHV27dkoaR
	SsdeT1VuK5h6N4pbjVzilqYzZ641h28FOGfRgnP9abS26OrTSNpRInMgVr00Q+ekLZBQIW2E6GA
	PEFbcm2oZpMK7MHTCulVhLGtejtq1pbjRaUickZcMGZeIAw3hhvJ2htozfsAW39ad1xlXw8xqI6
	4+en9CSHZ/fsfaLSOmlCi9I3cy3q+1gDXbJbXNfREEd7lv8RLkQSk5y2kcq3hb0c9Z5nOQfC8Ll
	c0QQ==
X-Received: by 2002:a17:90a:77c4:b0:37d:82c6:2e4f with SMTP id 98e67ed59e1d1-37d82c63153mr3536181a91.0.1782207230439;
        Tue, 23 Jun 2026 02:33:50 -0700 (PDT)
X-Received: by 2002:a17:90a:77c4:b0:37d:82c6:2e4f with SMTP id 98e67ed59e1d1-37d82c63153mr3536166a91.0.1782207229975;
        Tue, 23 Jun 2026 02:33:49 -0700 (PDT)
Received: from [10.133.33.161] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d4f008779sm9180164a91.6.2026.06.23.02.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 02:33:49 -0700 (PDT)
Message-ID: <40fb6f83-939a-4b3f-8b93-77d7e07b72f6@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 17:33:44 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] Bluetooth: btusb: Initialize @priv_size at
 declaration in btusb_probe()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
 <20260622-bt_bugfix-v1-1-11f936d84e72@oss.qualcomm.com>
 <xzps6lqo2k2w2onzleg4baycsnzsejiwhhefilk5rt5e547u6y@orl7l3yklhuh>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <xzps6lqo2k2w2onzleg4baycsnzsejiwhhefilk5rt5e547u6y@orl7l3yklhuh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QejUDGumCK5T4lFQ2VgGBTnOzOjKbzmn
X-Proofpoint-GUID: QejUDGumCK5T4lFQ2VgGBTnOzOjKbzmn
X-Authority-Analysis: v=2.4 cv=QJhYgALL c=1 sm=1 tr=0 ts=6a3a52ff cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VaXnfVv-xPxUd7dZoh0A:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3NyBTYWx0ZWRfX1N2EJSnh8SEF
 dUYC8rK5eXDNwDFPFB6igmmDxLUp1eoCePGsg38OLwo9lJWodNBy3bfTpj34JkLGKfmgkLCR42e
 dpauqvxzqeWlp70xTE0ulhxKUYvc6sc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3NyBTYWx0ZWRfX3OseabTDGShB
 8FvmieTI4V69HX/kc7e9Hja3q0SNkN+7hxNVBorHSxQEkOcOAzWJ5dLHx8oYRkb2qrlpqRvyntw
 v52F68UNI+8bIS4VgIRPT2vJXYO6VUBHgy8RKWg7ELB3v9XJH/8d3nbcoFchvAVc9ylikELIOBO
 tdORAXSHbCLjTzAnOqz+1NSUu3U1gp1yP+qn5TB0L5JbxTjHrdp+8ne+ll60hXjiaGnRXPPPzrZ
 OKYJHpSOxdcezbgtcavGXNC3xlUZugh5G21fjRXLNSFBHRFzEG1iTJapjRB4QbY91A89Z6VXAQA
 1c5yZtKIha05z5DSt38SjV8vr1v0xQ7rHj1749jm6iQMvBf22+jn5WCB1uh3OnWzh2djBe0wyUp
 mBfiohL1pKT02Nl1dVwEs1movc5DLuDZXTEHkOohtoHLBqNe4HkcZPqUwwSUW3wS+R7QJvu0lKl
 NE1i5C/GmYC1hEf3kLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230077

On 6/22/2026 11:30 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 22, 2026 at 07:52:14AM -0700, Zijun Hu wrote:
>> Initialize @priv_size at declaration to reduce a redundant assignment.
> This is obvious from the commit. Please tell us, why?

It is simpler: one statement completes both declaration and assignment.
More flexible: initializing at declaration makes the variable immediately
usable from that point, so any new priv_size += can be freely inserted
without caring about where the separate priv_size = 0 sits.

Will improve the commit message in v2.

