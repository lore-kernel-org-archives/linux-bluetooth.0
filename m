Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6FD41D10A
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502218; cv=none; b=CxtTuO1qYaMpUJVTJepgrhJ3rIHTBttDiHLGEoIUZomItf+3sb2i7zkxhaifv1irGrjXZHZkJOX16yuZqDSbQMMAOCnXA5l6ab1Vce7rU2kDR7DGrHzz3+TiUVIBSQTYOg9N+mORXzel6s0x1USco+pd9mdDMrRrbLpLwyFd8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502218; c=relaxed/simple;
	bh=bMraxFGM0J+W90QXiEulwryjBxopJcNN8hylzEd8Yio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boLNG4kvoD9RYr9q7n3f9ZMh9PVkWEU8BiF0Htf7NFovyIf7vmuHCf+qtkrCLhcYetmOAySnDmcHHe1peFdDPo9/1JeARUqnI0akq1SK3iYhgGn9xYKzUfQua0g674ZDw3d9Mgzy6/GSJHnFNZCNeqxXzLxlfTO9ZjOWaSJTZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DhMF8DbD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RmWb/t+S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DhMF8DbD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RmWb/t+S"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBeWdY188847
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 12:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5+IvKBWrJ9rDBopNg6/hCtxnIA0137MAlTVPeY6D+MQ=; b=DhMF8DbDbt3vxCq0
	iyxGlzCmmWAF06/zLpDVkaT2T8/hOUFLJKJsLLMOxog60icn7Vs+QoaPZRwWe+5h
	q417M1dixfubNImOM0FEGkR8r77odQzKENzK9STrYkVY/SBSXJnsFB9FrUeWrttR
	ftkMVIy/lJJYuzgZA3yFc6w6Y6254qug/am6g+rASlE3NTgCCjz0xA5DvNdyaCBa
	k4qNxLg8swHhBqZ88o/3hWDYaJr54fBuLD1fuiAPed4eQDfwWwtJISRzUB+2XHOy
	ZGn6ddh+LbpibMvx3m2PJpbHZPbNvafBjURYtXNPYD6QmD/IbB4pPMrI9PWtykVQ
	5MQ/zA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru1u07sg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 12:50:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52845bd815bso1853291cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 05:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785502215; x=1786107015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5+IvKBWrJ9rDBopNg6/hCtxnIA0137MAlTVPeY6D+MQ=;
        b=RmWb/t+SVn4c3JUILviLoGBVWY1AVJyPFQhaARnnqaTVFYJasy3vRMkqzayLmxbspx
         Cgu/f6nildkc1AH2hh/MOcnUBuZYz1xgm1z6HpR9epG2nnmSbZhZ3VYAJCy+T18187v/
         AG7a0+SuFtNeakYXJeseJDPw/Gu9+YsmEHt1Br4GW8jU8YrvMl1kxvbNlOQkNnSmezgd
         WGHLrPd5+PUz4kzWefue3yL5/ImJVlafEW0IpyeOR0t4/S7yw4uk2g76Hc43tucsmepD
         RGK9X18bmU20U5HKkKiLBI3H3v+VDkL5Bbulyu6I3fT2adkCj9wdBd939KXUnYyJkB56
         cppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785502215; x=1786107015;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5+IvKBWrJ9rDBopNg6/hCtxnIA0137MAlTVPeY6D+MQ=;
        b=EGtZ6ucMidWeTFytIMpiPAnlsZhBOL2fbUOXtV+tLjZ0ewYbTalLHGGWDWvmU0eqUO
         T/Son4cwWQnlw7fNgRpmd2g6mQcGjfe5hEfZtoTD7ZMi8OCJ228zNCx0tFHMsaOMiRqk
         CMEIEXYIfoXxqR+cu/2uFFer9dG8/f2T9lE3v2Qmk139zxiLxs3wYf79pehA2ZLYjysX
         YSJyKQBPgf+L6OcB3DbSs58pXg4twkVtPLE92z34sBA1kTXhDO1OFk2b+fP0mQTF53Jt
         sqCbiS7jYtzWuTrbjtGq3lvfQrGBVOfJTkaEFVUvuYhYzv/b+0qiPaK8E/EcXrjjURjU
         RqHQ==
X-Forwarded-Encrypted: i=1; AHgh+RoztGVsADLbB2kxrDVOb64unDjjHXgFHexGZQIY4kQBJWFLcIQHcU6VVnzb268xgrkkLPvxgu+KeX/mOXH4kIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6b//oR6EctrXp+WARjdXWrTzteOJzNYItKI6JveFQ/SA1CaFB
	IxD3oOxXy2vpA4Y9gw9fpSmckiYjqEn9WJ04qRg+2ALo9XSiFNEX5STzaTISD58gf0UpiB2sc/l
	o63POzEVUqHRMDzUyQPPnGkZPFRlWL/zhipXHE6jp+8WgAF4BXZUnJkqQQFRkveO9HVH8zRw=
X-Gm-Gg: AR+sD13kcl6n3UMc4JpDHgpz5ctFnwNh5f0iC2N88t7h25PBNbCBb8VFum6+RrMJRSX
	/flgTSYDBO0AacJByfcYZLF4GS7noG/4KFYSCCD0F/tEw/wuc+BpZP1vsCrFbuzml5p6Oh7/6Rd
	YkSHWuTc9F1S10j0zLCXiYwjt9RpYNKM2xjX/w40dgdmYIe3nkFEJDGNyyVAUp84mh9zeH/EkRX
	z2n/dtOlvSJFeItmx31AE2hqqAPOWB/zUuWPbbcHUi6yImTwYAscJFFSDZ4tkz5Z0FnnEb961O+
	aDwiwjxahDto/UHDR/lUd55UDETcKesANYacJUBPFcWZsuJBBsPwURtw4zS0TZmh3amHNqTgsOK
	J/S+koQ+YV1aBKEcH5Vo488jN
X-Received: by 2002:a05:622a:2585:b0:51c:d8f:d77a with SMTP id d75a77b69052e-52b563c3a50mr470401cf.1.1785502214797;
        Fri, 31 Jul 2026 05:50:14 -0700 (PDT)
X-Received: by 2002:a05:622a:2585:b0:51c:d8f:d77a with SMTP id d75a77b69052e-52b563c3a50mr469771cf.1.1785502214157;
        Fri, 31 Jul 2026 05:50:14 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c5b0efsm147122166b.10.2026.07.31.05.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 05:50:13 -0700 (PDT)
Message-ID: <6d61d749-440f-40ad-82e5-e1e909afad06@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 14:50:09 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: rb3gen2: add Industrial BT UART
 overlay
To: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-6-2d100f30e202@oss.qualcomm.com>
 <794424df-4714-43a4-b4b8-e960998ad1f1@oss.qualcomm.com>
 <ce283ef7-2460-4fa4-a1f5-9757fd6b42b5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ce283ef7-2460-4fa4-a1f5-9757fd6b42b5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H5vrBeYi c=1 sm=1 tr=0 ts=6a6c9a08 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=ejynXRg2g54x_2soN7sA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX4hJAC/8DqGgQ
 iD+vMPykMaurzy4m8dUQHBgAUlnKF5X8m0DZWD5dmpjID0Lr+uQAv+hM6K0GQfrGd+ZJb3q0iQp
 OEyMRH1WXXUdqDrOTsbPPla6ZCfyX6NHQ3wE0co7K/Th+SuOwmbXd2TXX30XkHfkoBOvDkhzpCJ
 nY/0/6q4jzGgYk+RC4wDQqv87J52w/btrBSfbfEY6YPC1rNmZQAebt4ZzloxqpggooA4b/0eJ5O
 pZVuA5jPLQpIarUSwwvV10dyuGXGmzgJHOyDRxDj0wDZuI/7rv/1g+RJD0btvktR2k6dVM5Qbwm
 gzvz0fsTsO6SQfGAXXFj7/GQ0P4FvtX3+uRFlsofIb+gqpXdQdQIIVOv2SGovpc360ZioRCeZjg
 YHi/P7L1ejhlfs5caRyS+oCHa9qFDljGDSDIXDFzrAdMR5R73kF1IfM9OL6ZRbGjO+AtmjX7wWR
 FeqeAqOBN0VAD9FttWQ==
X-Proofpoint-GUID: Csjb4RC0rlpdU2w23THCp_ohCMgdLnd6
X-Proofpoint-ORIG-GUID: Csjb4RC0rlpdU2w23THCp_ohCMgdLnd6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX9k4RHbph1xVj
 4oPb1/3i5UNPkOkfhAPfItWxQFiQOaJsdeStgAv6jjwzQl3kZZP28Dwa6cpsXe+MYc54YkkNC/6
 A+LHQOKk0bu0HF0Kh8ZSjnZJoA4fZvw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

On 7/31/26 8:53 AM, Rahul Samana wrote:
> 
> 
> On 29-07-2026 18:01, Konrad Dybcio wrote:
>> On 7/27/26 5:45 PM, Rahul Samana wrote:
>>> The reworked RB3 Gen 2 Industrial mezzanine keeps the common Industrial
>>> mezzanine hardware description but routes QCC2072 Bluetooth over UART4
>>> instead of the default Bluetooth-over-USB path.
>>>
>>> Build this variant by applying the common Industrial mezzanine overlay
>>> first, followed by the BT UART overlay. The overlay models the M.2 E-key
>>> connector graph endpoints for PCIe and UART, and disables the on-board
>>> WCN6750 PMU and UART7 path so the M.2 QCC2072 Bluetooth controller can be
>>> used instead.
>>
>> So is the onboard module disabled? Can we not just use two in parallel?
>>
> 
> The Industrial mezzanine variants do not support the on-board WCN6750
> wireless path. The common Industrial mezzanine overlay already disables
> the on-board Wi-Fi node.

What does 'do not support' it mean here? They are physically present
as part of the SoM, so unless the lanes are somehow diverted away,
why is it not?

Konrad
