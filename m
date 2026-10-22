Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792674543;
	b=mkgAduQeORJdK1MkpW3cL0gLs/oY7K79+sPziisp8JtD1VmNhlpKQSWmTg7qKGXSo5LI
	 mU65qB4mUS0tVTGEpZcZ+GJ+Jr+JFq0vbFrP3aG1webfeJI6Z4bNgZjB/jxVAJD8c13BS
	 vMd0iqZvEXAWwqOb6Rdo3XEuZ+WfaD3nwE4hHT0FZrUBjPLIyOvaoCvYli3e3cssScQWQ
	 VQFKXDOsL0ORyKQDrT0McTuY+sR5tdUaTYRZo23i5KecqR7ptJlb2MgXG/fepBScov3Kc
	 7TE7qA9k3A5ahDzJrk6QQap0jjLjjdZkLbGNiBhqcrHAV0kuFQDpHe8vTA3q5m8hBRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674543;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3I3CqMlKS9kzfVvoatBulSB5vPOH1xeLfyRig00xmQ0=;
	b=KNwQ1cdopbgfQ5UHAr6/DMbljyiPPIXMGq7nkq7c3lUv1FQyAztmO8JNisbN5qLkBYIg
	 ayaChxHNTSWRLZGfKuz9OG4u1fjw6ttJSIMebLLf5AZBr/SpecZzQB0DWcpsctzXukUpt
	 dJ4QETWPVk3LY53I+TYG+pyfIpAGPst+fhgeuvAnDvsXDILOygu5cGq93vTNgPO6OG6ha
	 rBDlSyVRpdvU47CDaKUYkIweQT1rS0875s6Pl7+Tw/urh7BPXJJbJNr/w9tlEHJs56k/p
	 frDZ65vZ5McghuEjs/3pe6Lu5Y7H1YIm05/S1d5MIdTjEJ4xlKOFxBNcjA/MPKpQ9lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fFUlxMUB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dv3Mmo2v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080E3606A319
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 13:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 080E3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fFUlxMUB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dv3Mmo2v
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M9xwZm3478867
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 13:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3I3CqMlKS9kzfVvoatBulSB5vPOH1xeLfyRig00xmQ0=; b=fFUlxMUBQYcJI4dq
	HRjiZRyz+yWr2OWqoFsvQUGKPGs3TrfXtCj9F7nxrzhnHUJhNk00bA7ym+NGXlL5
	xbj26S8xDr3P7oYt/Klf0INzmZ1i5iFvoBOztup/m9Tq3zVEWYZ8Nc/7H7IyQKXx
	0ucCe/lvbD4CGrzQ7kF0c0rUgz0U4nUBE34r8hJMPgoVF/J8nnPQ4O2w3EGqt5NF
	N3YXxYOVhuFKuNRFgNwIBvZwMe/SVZSa76fWzLxXTizOl36SkvY5021Ai2arSRlr
	saakT0vvW6USlsMLajZnqqL21TAvK18Qh5inPb7eOUsYUEeL6Cw5BzbkkgIef4Dj
	+Upw4A==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93a3knu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 13:08:57 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4a45b3f0bdfso2443894b6e.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 06:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792674536; cv=none;
        d=google.com; s=arc-20260327;
        b=mTGS7TC+qsxTqjk3Ki+NQogXN8Drsy4Lvtsg1p+gSeZJtgo9xAlLpD5uRSDkFTvA7g
         EyUJF7r0TBWsztS1KDQzR85t8T280GTqaMDHc15PABwg/cRy0BWafeaKRJP4D9eDgsmj
         7Ax4DIdYTcz3J2obZmqvidIm9lWEF8spaH1NSycco+2/jJ71N/N9WwxsL/10ysPs6uq/
         gI/cmgjsAQPoRwhwed8WkaRi8PDFymFEry/mzCzxYpfMmCtjAQPQFChj5Mfq/h+cTG0g
         3C9lPrMBgAbcVbfgRVIktg5m8J4S7K1/og8wH5lwjdb1wpPtNRz8ro6lG+WlLzXhlOTI
         +FTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3I3CqMlKS9kzfVvoatBulSB5vPOH1xeLfyRig00xmQ0=;
        fh=ySNeZ9cxtzcJwve0lfM3B9UULZp4XVFJlTkCfv1Wwks=;
        b=S495cW5dGULSsbWVFmYOHhp7pE9A3ZFyZw0POiPOd674IX7IAUIlcQHDQwyn804pFI
         m0a3boSrg48BfgznNLfb01RWQF8ReqhwdjiC4l74mMR+PVT+/GG/Pol5ZasnUmGz/OQB
         4l2TT6L2xTGwutb5cRYm27ILIRXD/HN6QiL6IjjdxGAdIarAKcfioHiW3XpWwnhpTQfZ
         7569bkR788ydQ5NRRW7Cd1wees4p5e58DxVcdE/QEP8E4pzhaxAoXoGk/TpdmgteFUSC
         oazcwMdQuKe4wKn5GRyl+5RT+k4BYz5Sz8mCjaCQxZFPZ6v8s9TvtZ/DRDLch0ffCbY+
         1xBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792674536; x=1793279336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3I3CqMlKS9kzfVvoatBulSB5vPOH1xeLfyRig00xmQ0=;
        b=dv3Mmo2vK5i/Cp1ZEEkeVIgMJgtWkg+miQhO8dalYRJ+TR5qGIuH/WQAplf1CFxrrI
         W7MWcY6FA0x3tVXVsOmcG1dr7Cn8nb/FV+e4SLQ6+DmW/Fk8nVqqlNwbjHcV/K12w0QB
         N8TbFkBFf2k5Nppr4JCBgUjqHIL8HWXbqoPYKSWX3+s64NjBrTfHEY4amcLMsLEFf4xi
         tn2BPggHQi6GS2NT/4viilSj6OI1hmu4zRlYU0s/Z/kJ0pRMWhQ3nYpG8Rq3R0Yue8/N
         kx433BhSfsPhI6lheqp4nBp2dg5dAWIRFPQndYZIb//OWMKJor7nshmMtooIM9bfBAY0
         tB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674536; x=1793279336;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3I3CqMlKS9kzfVvoatBulSB5vPOH1xeLfyRig00xmQ0=;
        b=h++/MMzSQR8Y2tCoJXPjDW+tYZuGiNoZ+50s7aPBOlRIlokrkRlhokDNGSN8eRO51f
         6gohTW1Xiv7BgyVo/hcVBwipiV2yYn8i2Zt8tUv8PRWtpGhkld/94EUHaEpvbm/GzhsG
         +RdHyZkDT5Nk+Q1rRuS5JDRd7gqw2/gn42IOpB2B3jFzNCwUW64yLTedhgpldu3AvCOP
         uWrSNtXMN9NFgugo7KkqSfeQqdgbBEJoxSKJ9pNLbs40jtiW6tF+3TAyZqS7WX7lEhvF
         BlYQvklA0zuex3uPrKRLXYR7NaJefyRrwpwanHaIo4JQXO3XdBv0vVx1F9uG4WT1LkLc
         JLdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMrTS8hBHJSsqn7Z92gb0wv7Xn32Ohz5B7S2+829dG0Gfp9xXrzzwA+53Ogc94njQ81/KscHJwZWMSi+QYBEM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+Zim8D4lfVwR3vypzIdwCUswbXHiPBVegoV1pmoSKTNR06fvT
	KaEkVF8C0Co0KzDe9TI5K9ZCetw66BYlawWdAwwgYfoMqx/1WyZjbp54uhSTX1iaonBJliBYiNW
	AJ2qnaMnh3j+BDHbA2RorchydI8W3tzt86/Y8hvr+uwVv7lcWwUwuSxqJBDIASDJP8iJGGt37cj
	UuZYYsCxBEngAUuyaovgk0BnLC2v60CjLPAjBieV7XbO+NFw==
X-Gm-Gg: AYBFou3N9ki3fKg0X/0Zcif3aBkGXsqcY5EFQfFJrzSWiN2PwTjHgSFlu3d7OPhXLis
	gKq/QLomO9+U/rUKVF2u7e24Td2H0IxHMdAYIOOzpYY0add1jl2R5RA+1fvKL3AXtvBu7CO//OD
	/TanoJ2zcbbtgzhf2hzQGYo/+7X77vw8p/GlMu36FwKVhA6C5fLa02JKPL/psojToTiWPhOprjm
	nNqFvdedbSVDsnrIPh1l1oeprfC7q59jJH14q7KGABhYPclGw9ZKoKJ0jsQx9pdeSnLruqPyek=
X-Received: by 2002:a05:6808:4f0b:b0:4b9:e65b:8c36 with SMTP id 5614622812f47-5535818c38fmr3719772b6e.36.1792674536252;
        Thu, 22 Oct 2026 06:08:56 -0700 (PDT)
X-Received: by 2002:a05:6808:4f0b:b0:4b9:e65b:8c36 with SMTP id
 5614622812f47-5535818c38fmr3719745b6e.36.1792674535696; Thu, 22 Oct 2026
 06:08:55 -0700 (PDT)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <0303224f-4c2c-46ec-9866-5ea1fd0fb4a3@oss.qualcomm.com>
 <20260825092715.5794-1-wei.deng@oss.qualcomm.com> <isbrpaztfrgwfcleujrn4w26cshbi2mgn57tbh5bubvsegn6lc@jh3ab6htvd24>
 <83b67ab2-ab68-427a-94aa-881454f457ba@oss.qualcomm.com> <CAFEp6-2KDxDrfTZLN7KPRg=aavj8nqQr7ftna23n9C1Cpbwwbg@mail.gmail.com>
 <e26f0360-aaed-4e40-b1b2-956c92d34db5@oss.qualcomm.com>
In-Reply-To: <e26f0360-aaed-4e40-b1b2-956c92d34db5@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 15:08:44 +0200
X-Gm-Features: AclHuK97HFIdPEr61N5bt2T_LHXrNyu9E7auEMGCcuKFJXvXq_yVtWyXBQ__JQ4
Message-ID: <CAFEp6-0b15kV6ehMN4Pv24UmMo7xFYr=H396dvdD1Teh7h+K+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: monaco-evk: Describe the PCIe M.2
 Key E connector
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Wei Deng <wei.deng@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1MiBTYWx0ZWRfXxaz+Vbc/6XgM
 Njoe55AC5hL3s51WWj2AMYCJjyJ8s+d4rwlm6Jyx9sC4KkLnI7/xnqhRHgGKc+xL1RtQo87xi3H
 4ByzYh/knxAXGdpvNQHj4YmlhpjbT6HYkYaL9OyNBnkcf+cYHn4+Pxq/plXpbavs7tuJzNxbdXH
 NNGnBM/cT1q+erbs7x7pcI292qCthxtJxbNcgKPPZILbmQCPLkMvZiD5Az0fnUM9VWolFydFWlD
 F+SdkaOeMIJNVyM4dkAla6GS3eW1lCRSbX7BuHOiK6pz/m5tMJ3k+mFndIla2Am0uTfrHIIPrxt
 S7hKIStqmpD8dhfI/sIiDj98IwrLckuVxXWaZCnyYzTqgA4kDYq0m5cvZBBFYtI3GwW/7mI963E
 3tnVB3xWVYuwTnshoRXR63vUy5LHNz8Oz06sCvEVk4X5kITHdufR30EsGdmHKx6XwidUn/kon9l
 UWOUsNXgNovCsl1PITw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1MiBTYWx0ZWRfX3B3BT6Y/7OW5
 rLtKARebQX9qyE27cnAHP6rU+9WSn1j8eln+/f9oybMVgq/6Xg/vmNC2lGxGT6dGbJHZhPzJofE
 A7NC3pgZa6zwNzonlFNjyFmpdkRb9jc=
X-Proofpoint-GUID: tiLRsDZTg7_rXo-CT7elpuG-I-BeFfD8
X-Authority-Analysis: v=2.4 cv=NaFzRGD4 c=1 sm=1 tr=0 ts=6ada0ae9 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=8PI_4jS6IWSl88OZsVIA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: tiLRsDZTg7_rXo-CT7elpuG-I-BeFfD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220052

On Thu, Oct 22, 2026 at 11:34=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/13/26 10:13 AM, Loic Poulain wrote:
> > Hi Folks,
> >
> > On Mon, Sep 21, 2026 at 2:38=E2=80=AFPM Konrad Dybcio
> > <konrad.dybcio@oss.qualcomm.com> wrote:
>
> [...]
>
> >>>> We are adding M.2 Key E connector support for monaco-evk [2]. Konrad
> >>>> suggested moving the port/endpoint anchor nodes to the SoC DTSI
> >>>> (monaco.dtsi) for clean DTS layering, so that board files only need =
to
> >>>> fill in remote-endpoint for boards that actually have an M.2 connect=
or.
> >>>>
> >>>
> >>> This means, the dummy port/endpoint node will always be present even =
when the
> >>> M.2 connector is not used. I don't see a compelling reason to do so.
> >>
> >> I don't really see a compelling reason to defer re-defining them to ea=
ch
> >> device DT either..
> >
> > Adding an empty port/endpoint at the SoC level is problematic for
> > uart, port is not always expected, this depends if the uart is exposed
> > through a connector or to an onboard device. So we may end with an
> > unconnected endpoint but still have a bluetooth subnode, which can be
> > a bit confusing... Also why adding a port/endpoint only for a specific
> > uart in the dts, and not for the others? This is a board/SoC level
> > choice to use a specific uart for M2 or not.
>
> From my perspective it's removing boilerplate. Currently all USB and
> PCIe hosts already define their ports and endpoints in the SoC DTSI
> and if they're unconnected, then simply nothing happens.
>
> Both 'ports' and 'endpoints' are an abstract property that signify
> 'X can be related to Y' and I don't see how that's a problem here given
> UART is very much expected to be connected "somewhere" (with the
> "somewhere" perhaps being external/a pin header)

Yes, but in the UART case, where the connection can be represented in
different ways, we can end up with devices being described as both
unconnected (no remote endpoint) and connected (via a child device).
We can probably live with that, but if we go in this direction, we
should consider adding a port/endpoint definition for every UART
instance in the DTSI for consistency. The same would apply to I2C once
endpoint support is available there as well.

Regards,
Loic
