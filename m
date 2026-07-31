Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07556445AFF
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512963; cv=none; b=O7Yqlk47jCZO2aauGxCr9vy2tI0uO15vvdwl7SMfH6+ECsEnXaP8DDnJ2UvQ2taN9C0X/fxavYUGEinkTN7k98Dtp//b4UcNI3zSg4aY1IhTmGMayAvPM4nGtWsW6Tpt/6ODulPtFx+wlRqQZzdL4BZ6D1UmhOpHpGqhAzayhTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512963; c=relaxed/simple;
	bh=HZaAOxwe4QyhS10RuHhDJoaegy/tHhrBOSj7SpXmDTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b90EOUJt+Ddxc+EUnFZXuOl0yzPHIcDvm8Yg+2K/EDY+2NNWVcoU6bctVCbj9Twcb7hGb5+bPFc5NaZBn08li3vIOT2qU2BSdB49uWqFd6XpbyaF4hm0BXAL9Uh3ozYXFyw9CYU/L/skT9863IW3b+fQip2vZsL80EVJoZ6EAmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ARcSqjOH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZB9tx6f9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ARcSqjOH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZB9tx6f9"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFO9tK1399382
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 15:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GOcjZ3U0RmFKdMeop8+F+Smw624ct0apDXeG6oe9Uic=; b=ARcSqjOHh86wjwhh
	+Mxr45oXSYBEbOXDn+NyYgKS0JR1h5975DSE3QcJApeNVxrANkceZL4+XnOwe3D5
	ZZkIUPLhgwHDLdPlt6o+k1nRxpvQeUofvP9+CDEuy2jDD4KY4PZMuDojTg/Dyc38
	p+LiEu8DuwecJOT8YKdLafdcEAbfIgQLdYb9Wl/7Y/mhzehfq43W2nN8UYd9jrEv
	u5nrhWPhF5ezwnFmpkh4ABilASL6hs8owyDdjxILPAqVN1yBTyDBvNxffIDs8LP9
	eZ5Y+9S+o0OJ4/Rdix1uliOQt+P40t7FLGF09KRaeSAPLO2xmVch5eXADIUvA89i
	fuwbug==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru1x92j5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 15:49:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93102454272so20048085a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 08:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785512956; x=1786117756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GOcjZ3U0RmFKdMeop8+F+Smw624ct0apDXeG6oe9Uic=;
        b=ZB9tx6f9ss+QG/GIWXGqRWQlTv31tJb4MJf6DqycAz1hQX98UxXtMWrqmzrFS8IcKJ
         VXYbwBQ15wXL6eeLgiBDhHiw/0Y5ARtaEspjT0hEqHXREPX5sDXpysd71XziAPo7eQU5
         QQUqe2/KPmEysfulol53QFSucdDnkP5xHnol6j8xiXahrCImitUM0MKxqPTYzYrwDhzO
         rKgEKG1DsyHh1R4AS24pB5eiPOMiZ33EXXe1HjE+RI4u4RXblDA+DqZPdobjU4Y9fMhf
         t+v+rdrMu/uIwoF2T1oSBjSixEbTv1sLMgn4N5EYfcth4DGfw2Hj1wN+oZQ6kCx0s+1C
         xQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512956; x=1786117756;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GOcjZ3U0RmFKdMeop8+F+Smw624ct0apDXeG6oe9Uic=;
        b=sqpETZ7XAvF8VxJf9w2JOx7Wyy8zTP/Mz2+Pf5td/imAr9jF8E26Ybj33vbIZWvtMb
         eBcWmUSctb6iyXuqJ6boSsnzgdzP052iLNixkjF4/N1dfkZsYNZ6aV1K+dl8zxskiqhj
         5mjc4S0j3yMIs3fptiuBCdOeGtzxe4/q8RGHKBPmm5dCm6sm+5RVB86hUsIT/J1FVnZ4
         j+P/0n4iPXi43X0Bd/OrXk/3CGaR/YOtmxUifCbMhj5TT0/GIpj0WK1VjJ38ulvI84AH
         wp1HrgEK7s0veKZBLW/OxTksY6OdDTNYTvm0M0OsPscSCnc6Wvae3gzakU8SkZsPaiM2
         KRIw==
X-Forwarded-Encrypted: i=1; AHgh+RoUykMgcpXAk6IlLIfpDw9Rs1hg5qRI0CxKh7TstoOpyHBS+wLu9Uxi3HiqHdHng7w7zgQaDQPZDtmEVA567mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZiGFcrVWZeEhCcQwlPaW+ifqXk5s+RvlKqluCPJPX4dWs2qIy
	Tr6iCBRL3K/AjrJeGdDE4+2SSRAvhZVgAa8czWVMgtBYst/1P4GxQk3MAQIccYckiJ4xIdRUepb
	FeVvlyuF1autayDsM22vMlExarq0k3B+gZe1Aa3jAFOUMYgbTwE1pzdSriQr94VNgzbs6ZEg=
X-Gm-Gg: AR+sD10HjztVwRG6WqIED9Npq7H2I9nzuDtTFoGghN9GOJXqI7k6jmklLlsEkwVe0yM
	IhhnVCVgr5ZJrmIpYFS6XZZaePcA9USnAFttqhw12ckSpdDUTwma4v1bU7G7P1hP5inp0QjP0b4
	mnxzp4sFVeyN8KhZIkJpsGdYG5xMcStKbb6M8d99twL0FJNIAn024Kxm/IBgj6JInwas9wfsQst
	hRw2K2aZncnELL0gyarGuwfpjYJha2qtQJMPI3TCieaz0xQAXHliyOcjMcxYuYcvIn+1ncNb2o6
	4hf0gPctVE4mV+i8rfSYMmlpQ6J11B66pt0wVKhwYDHdtpX9uJwS65ecCf/CV8xMM3L9wiKpYDm
	5p5SvBJG2nZdoLLOziDp3R+Sg
X-Received: by 2002:a05:620a:458e:b0:92e:9cb3:3f67 with SMTP id af79cd13be357-934a0951926mr67453385a.2.1785512955687;
        Fri, 31 Jul 2026 08:49:15 -0700 (PDT)
X-Received: by 2002:a05:620a:458e:b0:92e:9cb3:3f67 with SMTP id af79cd13be357-934a0951926mr67446685a.2.1785512955053;
        Fri, 31 Jul 2026 08:49:15 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c63dca6sm2157711a12.16.2026.07.31.08.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 08:49:14 -0700 (PDT)
Message-ID: <bf7821a2-d813-4f89-b891-9c26d228ae67@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 17:49:11 +0200
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
 <6d61d749-440f-40ad-82e5-e1e909afad06@oss.qualcomm.com>
 <b47345f1-1c7b-4424-9c6b-3dd02c0f4ab6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b47345f1-1c7b-4424-9c6b-3dd02c0f4ab6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEyMCBTYWx0ZWRfX9kgOsJnC8x4D
 IH544N8/A5xTCOgLV9oSfNoLrSha2OdQbek/6qR9v9xkxT9srwBBDjcxqCJAxvkEEcYMYzhRtKc
 JV0pP+2YBjL3xgXGtLjEFfTEfsSFbFA=
X-Authority-Analysis: v=2.4 cv=GpByPE1C c=1 sm=1 tr=0 ts=6a6cc3fc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=0iSonUdn8zqV-Tj254UA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEyMCBTYWx0ZWRfXxElzi1YhjZnd
 rUc63DHzizU+aIYuYmzS4B2zt2QPHACL4PMy0CEqFEIfCkjB/iUEzd6mdGKFouKivfDs0tusuDa
 eSeXoiPTzI2Om4/bFhVHkNWOq3/b68R8yPoutUxZ5u6VGuu+3r+wkLtJREMJk+zrNCBUTifCINT
 rRz4nGofezVsGn725oe0pC7gJqwBbPL6TLSEP9VNezAOp0qAdGlNblYSmW7Ew5fNIf1pC65pcLM
 NOYPQirfpiVfGCsajutSL2KNJSb1hFX1zibibZU5KghvbX2BEab/R5Zeg8ZH5XUdLP89Y1vUC0d
 VdUGA6ISGb07Uyy+jT9oPV1Sq9Xi46/Dk3qGl+kRGApUl40SZPmAhzdls0gm05KgokD+oM5eXoF
 rFMSD+obt1DHkw5qP4eJYe4t/fA/V9phjSFiZw1Y+xWkys980qcQ47wuaUIum0wl5JeK2awQYgl
 lb92VXg4zSIOIecS6xQ==
X-Proofpoint-ORIG-GUID: lCuxhTTpMAT5gv-DIlyz6XhOM7bducYj
X-Proofpoint-GUID: lCuxhTTpMAT5gv-DIlyz6XhOM7bducYj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310120

On 7/31/26 4:48 PM, Rahul Samana wrote:
> 
> 
> On 31-07-2026 18:20, Konrad Dybcio wrote:
>> On 7/31/26 8:53 AM, Rahul Samana wrote:
>>>
>>>
>>> On 29-07-2026 18:01, Konrad Dybcio wrote:
>>>> On 7/27/26 5:45 PM, Rahul Samana wrote:
>>>>> The reworked RB3 Gen 2 Industrial mezzanine keeps the common Industrial
>>>>> mezzanine hardware description but routes QCC2072 Bluetooth over UART4
>>>>> instead of the default Bluetooth-over-USB path.

I only noticed this now - are there 2 variants of the industrial
mezz being sold concurrently? Is the already-in-kernel one some
sort of a prototype SKU? i.e. should we support both?

>>>>>
>>>>> Build this variant by applying the common Industrial mezzanine overlay
>>>>> first, followed by the BT UART overlay. The overlay models the M.2 E-key
>>>>> connector graph endpoints for PCIe and UART, and disables the on-board
>>>>> WCN6750 PMU and UART7 path so the M.2 QCC2072 Bluetooth controller can be
>>>>> used instead.
>>>>
>>>> So is the onboard module disabled? Can we not just use two in parallel?
>>>>
>>>
>>> The Industrial mezzanine variants do not support the on-board WCN6750
>>> wireless path. The common Industrial mezzanine overlay already disables
>>> the on-board Wi-Fi node.
>>
>> What does 'do not support' it mean here? They are physically present
>> as part of the SoM, so unless the lanes are somehow diverted away,
>> why is it not?
>>
>> Konrad
> 
> Hi Konrad,
> 
> The WCN6750 module is physically present on the SoM. What I meant is that
> the current Industrial mezzanine devicetree already disables the on-board
> Wi-Fi path, and this BT UART variant followed the same board-level policy
> for the on-board Bluetooth UART/PMU path.

Okay, and do we know why that's the case in the first place?

> For the endpoint labels, I can move the UART endpoint to the SoC DTSI,
> kodiak.dtsi, as uart4_ep.

Please do

> For the PCIe endpoint, the PCIe path to the M.2 QCC2072 device is not the
> PCIe0 root port in kodiak.dtsi. In the composed devicetree, it is
> behind the Industrial mezzanine PCIe switch, under:
> 
>     /soc@0/pcie@1c00000/pcie@0/pcie@0,0/pcie@2,0
> 
> 
> So placing pcie0_port0_ep in kodiak.dtsi would not describe the actual
> topology.

Yes, that was an omission from my side


> I tried adding a generic label/endpoint to that downstream port in the
> Industrial mezzanine overlay and referencing it from the BT UART overlay.
> However, when the overlays are compiled separately and then composed, that
> label is not available while applying the BT UART overlay, so the composed
> DTB build fails with FDT_ERR_NOTFOUND.

I think this generic description is simply not achievable today without
a bigger plan in place

Konrad
