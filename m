Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B0D47CC70
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328191; cv=none; b=FoXiNeYlgZaS+Y/PAx4sEUeboK7spNGlllwNo31Sl3sORrThnlUI28BKlmfAuW6qRODK1UwhO8CYRH53ANw5L4ei+18zLMTMvEnVxa7A+d/I176s2z7v5ULNhEpaqhfxQb+pOsyTOtKLFa4vG9SZ/4mDVsDADCyShPSrMGOq0I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328191; c=relaxed/simple;
	bh=eU3rIagD/DJkspdzzDXpQLbCoAx9UdH+KUAOnRqLvQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXYFZJyqVRjVJ4+1yDPA8bKKG3QI2usy/n5HHmK6zClqjIkltrM5FxNX02IaAwgKG31qXYzlEis61umoV6Yv95RqdnAT2NBlms0eY6ez4JFR8+fPxrmgkYGnI7npnbzh1xdV2vg9D8LUEVfzjD/L3+GRb/+YmoAF7UJ3x2Y11Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R5zwqaXs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jl2q0GQ7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R5zwqaXs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jl2q0GQ7"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBjgG32136671
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 12:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xP3ywTkDvhhxUcM07PGoh5VmOojNwTFiUi/voo4w34o=; b=R5zwqaXsVQskLj4h
	cPx8jKeFWgDQkG8+6lQkJbuYaN7v5nkUmN+stni7jjCyKbve85qqHhfgwlUdW4Hx
	Hr3owy5LP8SfPElGTtoT3VLrBhDNrHIrgX1iWtzXwIZlvHj8GSNKWKjpSDc89q+5
	Huak3p5J8nZV8s6+1raiWwHphhhYxHv3mCSW7dnkreOODRqYTPv/fSJz/j9c7ycb
	WTUTKGyTErt1OsfESHkGtFS0nk76YJU5aOn4Uuf+3DBht2txoanqqUXlO5VXrnn4
	ssQqVD2TQuJp6jkMQOa0hqgK5Ecujighw2NljBSoAh0e9GTI36Dwzkbw7JUrALLX
	6VdfvA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgx805ch-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 12:29:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e57e56ce9so6101085a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785328185; x=1785932985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xP3ywTkDvhhxUcM07PGoh5VmOojNwTFiUi/voo4w34o=;
        b=Jl2q0GQ7ztfNDmD1lrTWrj8/CfZnjEPlOSUg9PlG5vikD8k3EeThvrEodA0H2AsXUq
         rlR7b5nvi+iTRN4QblpW4sHq9kLzBkShSqK6KrIjgQFdtvuYyQRRRzeZsJzdsdmhg2F9
         yLmlwXhkHjEblwRcS459eZs0l8De8V3TuLQ0f0EPkquRs6q9uUn/Q/ILgxasJmgpFseQ
         CikwHqxViAGZHAflXa4F+t2wYJisPwJCoz4Up6IATLOtsz+Do0X9sMLcfy/bJ7g2ghAj
         lDNtJq/pLrUdWokrTq65pa84AksFPd2DJxb4tw0x2X301/vbNKG/yKshd8ANHsTOIlII
         UAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785328185; x=1785932985;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xP3ywTkDvhhxUcM07PGoh5VmOojNwTFiUi/voo4w34o=;
        b=fLeATaFbil3oCNsOPNalhZ98rsitR7qQ1VHioAnd5N55EqoL/X0WZyEIn4g3V064Zi
         d1zWb7Swl9VXMGUQvVKNq75wmyN25Ka30nm0oB9qCeQDs72FU2bPKdn8/V0POPjBP+SG
         l+ZSP24I8MhrYtZK3S6D8GbjmmLqOXkjBcIE0ggGAamkjK96u0p+aqvBLQyFSv7NmdvW
         mC49Erw+Mpr898YoRcQjQhCyQW8F66g8Nfe1kY1rm/XG0+Z6Wn9xJro30GQswoFQq6uB
         gOwmXz0nGss9fSgmsuLabKUkUFfGfCNj0y8kKKHRGzb6gz4SXdw8uxOO6LJAqJJWLcdA
         xp3g==
X-Forwarded-Encrypted: i=1; AHgh+RqBtPDRsuVHf56u0wPbWCCiuXOQzEMXdW0DVMTqWliZncFXEXfwvWcxC3unQRnZqhjf8y50JuLu83Z225hcdro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw90pD+qbITR7I6yi9XqRUQgzvwo97eApofEHmR7RajKWo/weGI
	7z2pzJ4JHSzJ2eVV1igzSq5Oes6+QgLRSZAjNg78cfwVB62i3ZbUMG+Xuljb8HvCtZ0cMb3pC3C
	Bhbnr+PnyCvgpLsqWMk2Kk2gy6sh9bTqX/FFyAKjMUORyQ9ZQw0g9ESnRSRQcDHHDy0pjcxk=
X-Gm-Gg: AR+sD10kgmgaDYrCDend5QfextT/EVMpm1be5F9VDBps/bw0fck81YyB4C5trshqZca
	KpFLWgI4/yrrBI+U2QgVEDn0yCfXOvzg2gcl5W8Vr/FZWnQtlfifMXn4L6BQWFZjlq9mvMCDkHr
	YdqeROcAvO9tbbMM6YYGsDS/e/XX2lg4kDRVA1Oz3Z6VVSXmVbdsN7AVjOPuag1B0+G1xSzOdqL
	ceJWfCewe9LmWqpWi6HGM/7CXTFbGuYMXI31M5P1IkkgyXYNKYlwbkOvOa4KJ2LYBLR5s1+oMVD
	ft7PqWPI+eDxeWOwHhIoPzOU4F3RW6TdTyQaGTStrODYq8UJ5/o7M2alsOHY2gAO992vFFyaIa7
	CkCw5f4k6sOBVblRQkGX9h2CA
X-Received: by 2002:a05:620a:469e:b0:92e:5ef1:9072 with SMTP id af79cd13be357-93302679f1amr590484085a.2.1785328184531;
        Wed, 29 Jul 2026 05:29:44 -0700 (PDT)
X-Received: by 2002:a05:620a:469e:b0:92e:5ef1:9072 with SMTP id af79cd13be357-93302679f1amr590478085a.2.1785328183945;
        Wed, 29 Jul 2026 05:29:43 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f8f981705sm53805166b.9.2026.07.29.05.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 05:29:43 -0700 (PDT)
Message-ID: <95c33eec-8eec-4d01-b0f0-1ae33ebb0bd9@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 14:29:40 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: kodiak: mark PCIe root port as
 bridge
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
 <20260727-rb3-industrial-bt-uart-v2-5-2d100f30e202@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-5-2d100f30e202@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMyBTYWx0ZWRfX6PxiglJZrzfj
 Xe2VVu/l5VG3hIk3qwpvY6bEsGQVK3hvzDxh6v1W64vQOE0s4ktkCINQVla7Tt+byWiJ5bBIk89
 55d+7zSuwOgb7kmlikKIAeWNmc3O4Yk=
X-Authority-Analysis: v=2.4 cv=MZdcfZ/f c=1 sm=1 tr=0 ts=6a69f239 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=fipHztts28RoyCzfkYEA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: jMUFuPUjYiImbjl0JJ2asGVo7talRPfP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMyBTYWx0ZWRfX1wkQtY75OoCb
 gN9HLKIBOZ/MdAwPwObBKIXMSrhTnQDHdxbgD05mnj5O643SPok+cIlk3XmGsUJ6lvFMmhW+oFq
 WVYWrq3VxlYrGu7nfd7HPUfis03v/JxPyXMhZx5ZAPiLEgLsG6c32Tac7KupR330GSEu818F3OH
 Rj/Do7nfwRbA+E0MvEQe1MzdqK8DtXQ9P+YxIfDGMIbZh5c1tNIVXfxn0Xw7tA/nrx051z0OHYX
 D6lWhxdnHCaNGl6sw2NnWfbrZ2PlrcyMZ+J5mY+w68TFQpEqTaKd+WlkCAjeN2bZ78VXQjYCzt4
 ejpuZ2KFW5AQIKVhk0mFLIYGOe6zwaaBX29Y/VdoDSz/stkhhgAQ0bgIKb8OrZP3l4XTrpbEJ4K
 hj11cMibBK+QAwspvRW5S3ChvWgZAHyiz8rbtRWEho+mwArAWhe11D1CVNmbXLEpQuuaS4oUJ66
 SlzdpMRLKEIB/4ajKjg==
X-Proofpoint-GUID: jMUFuPUjYiImbjl0JJ2asGVo7talRPfP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290103

On 7/27/26 5:45 PM, Rahul Samana wrote:
> The PCI core needs to associate the DT node below the QCS6490 PCIe host
> bridge with the enumerated PCI-to-PCI bridge device before child nodes can
> be matched against the PCI topology.
> 
> Add compatible = "pciclass,0604" to pcie0_port so child nodes below the
> bridge can be matched by the PCI device class.
> 
> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
