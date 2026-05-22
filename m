Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85816241690
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443296; cv=none; b=hyMvHcABaacVolEfVu9BlXyZnDau/x3d8bSXQxSksw59/MvwZGsZAZEv930d1Q5kv8ma5U3jdXfUSzyyVbX4e3igYUeHUAGYbv7xT/9yOnWeswTZ75/mt1+1Rxj5lc34OVeah7cyxBFZcZSpstBFvEwf5CwALJAuwWMYwQ+dRUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443296; c=relaxed/simple;
	bh=fnA6TuXjxoD/qV1B06x19WzNk1sYIqRGpslMrz4epBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FypNqLl63tlomkD583eizmwJ1qwzfxMaNSgJ8RIZrbasehUzQpQuB1X4hvQpFgX9u63/gz9nwFY7ciG1sPpgVZZoiMqQ5TI2KEP4vJq4M1FRmsJluLsXkdt5Y9ECWTAwmZVO6Y8pIElyB1y2HTTHrEW8bwdPbYwvsUAHHhLW/tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KyS96uHt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FWow4lY/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KyS96uHt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FWow4lY/"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8bmcp3673678
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 09:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nxeYY6u/8efyIE6Ut3SOnhqR/Qrg6Pv6nhSejVY4/Uw=; b=KyS96uHtCkpE5n1Z
	uc5oOH2s/296hUuAs+RcnFf5CRcGGR0W1W/RqqXGXFjFSrCdXpqIS9TQpFRfaeu2
	M7avenXbaIkD36PAsueW5xEC8uNDvHthDDNVtLilgy+0nWZzwuVz666xJIK/j/Ju
	Yi8+/sVa5vCxoSxOIrHUlwGypi5MT08n/aXvSeBo8kr0wYhmiE1/vfqg0nZKrcwg
	iAcRaxhkUC/exClJOVte+fVM0XwOuCpagD46sVONTbrrOm0HxydVxvmc5Csfdy9J
	FVfvpNuMDJCZOAvRJ+3DiSFZBu9muHQ0KjxjoaGirewuTp69oeOZculMhDZjVrS6
	0/QqWA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea4dc45d4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 09:48:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50f1b94ac9dso27251951cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779443290; x=1780048090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxeYY6u/8efyIE6Ut3SOnhqR/Qrg6Pv6nhSejVY4/Uw=;
        b=FWow4lY/160LIc+An86OAeZoQBZq5ytgpJNyeF69bMPhbCb7Hsi33CavswpILh3qVc
         7vzvkC9EbNMra2mVPyD5QhNm9ZfJrfs0tmOA+Pc/EI3cqA1VQNdzhr7RglgB/P2AcoR8
         85O6IqdHrLCKS3/wKuvB12quJa4zlG6qmQr0MnPJ12Yoab+QVvDhAQuTQ1SIqcFkQFmY
         B8jB3+cPQroCcMEt2sBD+ByjAtUTfxg9gfQugOUzf1s9ToVMoFXc46Twe/DRIbU5Nd/x
         jpk2La1i9VEmJ2ocrErDwAmDfs2JoJsGujV+oYhBJ9O30CwG4XguJcAtsFfSCcY26fT1
         hdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779443290; x=1780048090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxeYY6u/8efyIE6Ut3SOnhqR/Qrg6Pv6nhSejVY4/Uw=;
        b=W38KDX0ayxNUaeZFzaaGcjAPIzm8hppJ61hVO720PCORKsoUkQjjUUoa2ZOXr9t4PS
         ijIOSZQJGra/BnPWAlnCjGKVZvOizhFiD7qoJLY4LwR9UbcZYCzp0aJ7MvDq25ZNHaKG
         F3BRQoXfD7Xp8kZ45/HsugO6HKG8QjWXv8M+RGpe6bTCrn1NSTLS2BvWvsbUUET953DG
         RbQ0/crYsrXdVQywC8jBV8V1xPc9sg4FLJoHJi5OdaxwT01k+O1fOrpOqCuadssFQ3Dz
         /aMyk3B+aJm18fab9+pBHlrSN48dVwLghi/WgNuGyZ4DP0a+JP2TgfyPQqR6RqrKrYN3
         L0Uw==
X-Forwarded-Encrypted: i=1; AFNElJ+JxG1Iusq1kdaBDx5gn8sxev8vIxHEy5VHKJbmHGlJX6fsce5UJPSfZzXz1b3dX/Hzo0fAa20ArJFFgoWd1FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC8r2nWuy9djuwZxwwKvLk8QCYtUI5o77vbNuO62jfKz2+w3pQ
	KRs0YdBuZ9rzjX6yeUoDTTNxMC8avzIMshGASCqo3TrN8EHSAL0KpSRb2PHKNcSJKc2QRGuMTFn
	624Yr3KlaBs2Mk08nceU+sBBLjEvX7mUqn0R3ZMaIWEG58MrrR6b8mOFnB9GIT3UZvw5npJI=
X-Gm-Gg: Acq92OEh0XDHwx+5pQZ4o/6RHB6MNLbsLFPxI7LDGLEDogH8wg4EJl44otY/rdaD3W1
	BoYCukzWkPTGEaijLEA2il1qnrs5p+ygpJ36Md4S9Wse9isfiV2LwqdPV7m6fVzSIFFwXNXnpTl
	F2/GkNir/Ihdqon9wyLHAkKSBUlkqDRgQBIuA99avfXK8vMFr4KELII4umD8/qf+8w65iEGkDoU
	2wfCYx8+dqbzBvngWEImqNjiC9qXnp/Zf654KeSMPRaoVjPnpCLkSqwems4W47pgEJDENCbyfAN
	XPetGoTLGiocug5wggMhUOCrA+X0ZlXYCPeHP8RZIYIyKpzGuGBIxUi2Zjyh3dV5MB/DiADvtT2
	XfC4kwRTfKrCegB9m1Es8fBu2lUSDsVflp+JGByqlGwKUXw==
X-Received: by 2002:a05:622a:6116:b0:50d:9138:3322 with SMTP id d75a77b69052e-516d43f5402mr26315331cf.7.1779443289724;
        Fri, 22 May 2026 02:48:09 -0700 (PDT)
X-Received: by 2002:a05:622a:6116:b0:50d:9138:3322 with SMTP id d75a77b69052e-516d43f5402mr26315241cf.7.1779443289307;
        Fri, 22 May 2026 02:48:09 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc3652b34sm36909566b.28.2026.05.22.02.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 02:48:08 -0700 (PDT)
Message-ID: <24f84ae8-6099-43a1-91a9-b50a0aaeb3e1@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:48:05 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
 <jetl37zsfcs5kl4b7iarbngrdu4ebp7ag2cvpqvkku6tbl6r5n@qozh6n5fq7f3>
 <CAFEp6-0A=LrU44pu2rfUqXW9k9peSu=b2qq_FVs4WZUj-g4pDA@mail.gmail.com>
 <n6kl7y47hztf7tgtdxhakpekwkxlleggv4sbzpsd2ncpill6ii@bdk5esjubv4t>
 <CAFEp6-3Gbd1gzfeu5xdfBJixL6JXaoSFkRUsBjOji0ZEOHHyvw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAFEp6-3Gbd1gzfeu5xdfBJixL6JXaoSFkRUsBjOji0ZEOHHyvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VefH+lp9 c=1 sm=1 tr=0 ts=6a10265a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=aCkQYJryizutyd-nL94A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 18XDNf0N31EEGl3p4yiUBkaIHL_TYPto
X-Proofpoint-ORIG-GUID: 18XDNf0N31EEGl3p4yiUBkaIHL_TYPto
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5NyBTYWx0ZWRfX4k0if+QWecq/
 Pt62/svIOoCYjKImIgMiWC6cjhOgJFp+lI2HdjXKFdRDAFFO1fIDxgtFrGyuaSqhsS/EyoxRBZd
 Zt4I3xVvK7rQVDm4uFJTeKeWouGG9/3EPJzGTPYVObtqb41V6ftUK09801igKVSYSVAXq5lcUY0
 qdNvxavXhIbkKA61rmw2EfxLJIog8mb+/Qt9fGiN1b0VLOlO7j8jAT/+v7lapvthKEday63MRYz
 JTyxiAYRZhkNggcaGmyuHR3YabXJsYPdUELXOr3guoR/kklFWTGlcn9SljVGhSLw+akgFVPewvz
 32ftEtLGg4d6BSJNjboy0pUOtBvNwq4gU6CvP3aTPUJWr714ZSpygpz4e4J6W6EFFzZkKoRLF+S
 cpI0gbmdwnOpdENL2eRYmbwRzzf3t/MYgIPSgelQELyfwtbuWhEVUUcpme96YfTntww4Z0qs6uX
 tlWGqgAQde2np4bTN/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220097

On 5/20/26 4:41 PM, Loic Poulain wrote:
> On Wed, May 20, 2026 at 4:36 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>
>> On Wed, May 20, 2026 at 04:29:40PM +0200, Loic Poulain wrote:
>>> On Wed, May 20, 2026 at 2:34 PM Dmitry Baryshkov
>>> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>>>
>>>> On Wed, May 20, 2026 at 01:01:44PM +0200, Loic Poulain wrote:
>>>>> Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
>>>>> Arduino VENTUNO Q board. The module is interfaced via LGA and is
>>>>> compatible with the M.2 Key E.
>>>>>
>>>>> Add wireless-lga-connector node using pcie-m2-e-connector binding,
>>>>> connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
>>>>> the Bluetooth interface.
>>>>>
>>>>> Add pcie@1,0 downstream port node with pciclass,0604 compatible so
>>>>> the pci-pwrctrl driver can acquire the power sequencer and enable
>>>>> the M.2 slot before PCIe enumeration.
>>>>>
>>>>> Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
>>>>> (gpio56/gpio55) used by the power sequencer.
>>>>>
>>>>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 65 +++++++++++++++++++++++
>>>>>  1 file changed, 65 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
>>>>> index 93ed575817af1c5e903662c209ead629fe202ee2..6fcad77f320cb82eccb6f07244d185abfb1976d9 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
>>>>> +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
>>>>> @@ -154,6 +154,39 @@ vreg_nvme: regulator-3p3-m2 {
>>>>>               enable-active-high;
>>>>>               startup-delay-us = <20000>;
>>>>>       };
>>>>> +
>>>>> +     wireless-lga-connector {
>>>>> +             compatible = "pcie-m2-e-connector";
>>>>
>>>> I think it was discussed that LGA can't be an actual M.2 E-key
>>>> connector.
>>>
>>> I am not sure I followed this discussion. Do you mean that I should
>>> introduce a dedicated LGA/vendor-compatible string in the compatible
>>> list of the pcie-m2-e-connector binding, or that LGA-based designs
>>> should not be described using the pcie-m2-e-connector binding (graph
>>> representation)?
>>
>> I think, it should be a separate, vendor-specific compat (maybe using
>> m2-e as a fallback).
> 
> ok, understood.

Oh, I reviewed this before looking at this discussion.. yeah Dmitry's
suggestion is good

Konrad
