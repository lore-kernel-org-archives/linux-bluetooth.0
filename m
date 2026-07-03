Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E4435E1B1
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068094; cv=pass; b=mHFgwnkflF3+a0EyOWIEKyLZ/do1n474UMOdNfUpEeFCnV5Uhfilmcd1sbhApDvZlze87TvinqRlZW30oH/Vt6SH/abXxW8YgwfVlth0ovqCmUDKyzbhkE0MMa0frUKbHnANQPaUNhQD8q5sInRtQYstuwTrkqqmf+/1emVETNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068094; c=relaxed/simple;
	bh=A24/IDMt0yFcSCd3f2pMjBY2SE2mBp+L+hitnBhNtNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODSldf4T6ehm3AvKv289nDkcY2CTrJJq/2nwjmjWhB7r3u8tpjHpWpYAMu4g3iP8v0eOjfb30RsPKOHUcO0cFmD4HCj5SBp1eD02cCP2ujGXjnAjoUuMCxxWlF2sZIXxkp2/qHQ+4IJm4CI4Q1ifI/bES0sotvrHlhtU+2Qx0oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cdcfxvmx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PXAuTFe4; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cdcfxvmx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PXAuTFe4"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635s0YT3124215
	for <linux-bluetooth@vger.kernel.org>; Fri, 3 Jul 2026 08:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JgfgskfFOJItCCV398c0ggLI02qLuHDQzMpOZ/nUiLQ=; b=cdcfxvmxsBih+A/j
	fvtwurcdg/gJYSyu5Uig5Gq8wCquo8jNytqD0uu9juFEOtQSfXwjZjtxdQrrTK+s
	M1rWwC22btRXLZcoCOv6/JNy7ImMEvu6mU7onpE62ujvdfACdBmudXFKzXSKk0H3
	SRGOYvTginR0FO2EcdZBohFlBq0WCl7hXURvzCfC05PT+3yBMkMSZ1ylo6orLhcJ
	58m2OMcgctIMwGlXT68/VUkLd9dYqAk7+52jct0dOMaEj7SLsyVye4xcu8vTLW4U
	lCFoR5+AaxXvqlXDqntxmIUnNPAiC8eByWfbz3AwQmww8JOSrqIxfs+yMHpQLRlu
	hpuaWA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qnpcfrw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 08:41:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92ac0a54110so35499585a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 01:41:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783068090; cv=none;
        d=google.com; s=arc-20260327;
        b=kGMxLn1bfvLxnMpJL0/fGaiY3R3WujDIDj8CgM0FJKcSFvyllPtIjbi3BqqWjnqzuu
         OItsXu4MeKZ447zXqST0CT6463ti4E4poKgyl0sxqnIJkbX96m1wYmAn0WdYL9zUfVHT
         hvNgu7Sx4g36hve/FiMNiMCzHErAJueJaNyCMZbFNWZLvNxRccU4Rq2WdRPzmiNAbm2m
         kvHrYBjJ/9tSBrxACArjLDfIt8PfkeACDv7Gw5bJIEXufQvcq7t3zFHff6LF9fsRtuad
         ZRanxaAs8xbrCFjl8i399YKe28fa6pvFs19Lvw4DgnxAzXpIuUXe/ax5QilP19YLIQSq
         NP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JgfgskfFOJItCCV398c0ggLI02qLuHDQzMpOZ/nUiLQ=;
        fh=ygECVjDuZkD7s76nepLOjrUB9mrR6JL9C9tVuDwLSyc=;
        b=FikDyhlbwN9lpc3yD4TnguKREfvh3LdxXJM4hhRlRZcS0KX9ehUhi7gp++iM4uVaPH
         A9uo9uRCuauQ1J7Om5utSBn9XcrJtpKJKFXkxQJTbJevM2wBaHY2wq6uK5RGPtUKODv/
         qjm9GG/+Qmr30Ysda3U1dpiOM/VLYu1IQUp7jTb4tEhunLjdzBMt4HRcY8vJDl60cnwM
         N/dqyysNp+1IV6VKwyNMnhlPgNWFD5Rjnnun6yRuTsEybo2pzWil6zGmk6j4FXiJ8LCl
         bhEw1HhhdzfF1DZ6pVgB6WrqVe0zx4RlRuY+OykNhZ6bkL2qJQeV3aAeWf84D/Hcn8C1
         DXiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783068090; x=1783672890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgfgskfFOJItCCV398c0ggLI02qLuHDQzMpOZ/nUiLQ=;
        b=PXAuTFe4Ojw62j6tAUNP9wnN5lQXZDTel/ZAAICYjrRowiZ5eEmVWyayjZMGqtxl8+
         atLp5BsxEKfO7vxs72gziDQC1lz9G8yVkpKHBUAr/GbDu+tVZmDLNCGV0zrXH/oOq9OG
         jyip9EUMelvPSLjC7CrDNIn3mDEkHKapHvEqiHzzt8nsZeCNURY0CynBJguhLpiveQAP
         Iia7zmCqcD8H9uM1yISwaQLUmWjM+YXk5tnYNqPtb9HiR4hv45//C+ZUdvE3GyUwDleK
         709raCFVUcVRCv8v+l75ETeQ/lBce8WfzSoORZDomGpatyxkXOn7k0g93bzH/8MxKXEb
         dwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783068090; x=1783672890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JgfgskfFOJItCCV398c0ggLI02qLuHDQzMpOZ/nUiLQ=;
        b=dHk/Ww3lyNjWL3RapSjQyjeCtkxsHpnhszWrlcDZIec5xzg8nE942R7WbQwR2Tp5Oc
         YDds9bDvDt1StyCUALssvTAaBX9LCCctnfOELdjFKIBl3lJKC0paTT1Yf6cE3v1LMgUL
         7dml226gkvH94Gp1RUp8h222QQZBjVMSoXdKpX6tcE69dn6mTfJ0s4Z+CpzVjUn2XMmJ
         s+XfX3F8Hyk9uPYMGulV4yWBrDig/0zcsWOKNEvd8V9yUlIumET3EXdg7A9bvF3bevgr
         JriM/b8dGl8iWK0G6Xsj05tObnQ8mQBl425Izsq3UKD29y6VOoBF1i0keHTpoADIrOSt
         ijzQ==
X-Forwarded-Encrypted: i=1; AFNElJ85JYk78S8WPQ+vnZOuuMyfe6hfkzo6ay8AgDvBEVpJyaoDmSSiN1ohICvSOO1fnBiNdWDNmesxihWvj9qwT8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVDss1aOXG4cjYmCohgKQGGHJpiBSqvf01exanfdBmMyGTmgX1
	4sTvRw0Fku1STtZzxzAwE4I71NXxF87U3RYNsRLS5mpsFVijhn7h1QiZIsNha+zlyax4aFpAjyy
	TTwSBdUcDrOiUUxBJ7BqYXDUOvjUFGb60QkPfroghChkIVjDKTADVg9IoRHqaHzFmazcL6kpTA3
	1hcYeuEUIQh3eyZjVtvBg9qMGoT7R1tjTRmP5oC3VsiPOZmA==
X-Gm-Gg: AfdE7ckMM86MEFMDjVF7OAbfPCsyTxt2Oap8pXQf2tgcuZVIfGK5Q6VNumiZ99s8RFh
	u+byVrPCACvVi9FFfUcHASgyHzmppvOJYLn1ATIeQ+/k8KmtX3jz578qBlTodDEfW9maj+yRNZU
	enBICJeu6FIyHOHGpiHllq4P0Qlxd/VJCSn3OuaMdWVm69Gj5fyoGxyqjNpz/cTrig6MpE5B3XN
	oMKyhPmVDQomAJWiCbYb0EPDIMRABKzkz90zV9BRt3/V39UZxRFueL6AuNxTKMi3pQhhlcXZXXW
	5bc6CXcCIw==
X-Received: by 2002:a05:620a:2915:b0:92e:4927:1fff with SMTP id af79cd13be357-92e782c94ddmr1287061685a.36.1783068090230;
        Fri, 03 Jul 2026 01:41:30 -0700 (PDT)
X-Received: by 2002:a05:620a:2915:b0:92e:4927:1fff with SMTP id
 af79cd13be357-92e782c94ddmr1287058985a.36.1783068089796; Fri, 03 Jul 2026
 01:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
 <20260702-monza-wireless-v2-1-7b56e2a6a6d4@oss.qualcomm.com> <20260703-tricky-hospitable-avocet-dc3fcd@quoll>
In-Reply-To: <20260703-tricky-hospitable-avocet-dc3fcd@quoll>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 10:41:17 +0200
X-Gm-Features: AVVi8CcGrmUi3s72gNEg9Nxjar9xvqGK0gTiAF8t-61zW6VTlFRO9OOYGSuluUs
Message-ID: <CAFEp6-3BptG=S+NutQpvuS2oe+kjJW6N4u0YjVP=T+tbX8PBPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4MSBTYWx0ZWRfX/LBfSLqsZWdB
 hu84fE0Ux0yypVSWzkaiZ1H0CNZgzUZtkK1FVD7eLhCrj062iPy1GyQT3+P6p1pghrK4jmwBoe0
 QZaVmLV26qhLQ8sZAk+5cquNlpfvFJc=
X-Authority-Analysis: v=2.4 cv=FoI1OWrq c=1 sm=1 tr=0 ts=6a4775ba cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=qB6sUIZWhqFJcRNk-TYA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4MSBTYWx0ZWRfX3FVQ/ghSB2+D
 fTlBiACBr7zdoEhC7aw1RjGOoZRnD2t9e2Z6ZGWinBh/g/z21IGy+pFsCpp+WsoMzA/616L7Egt
 YU4Gsd46MQHPxhZzE3ScP9vwBO7HLtqZ4kxZerI+56JA45pzHdoGx3Vrf3sAHF9pG8N+XEI0U+Q
 7XmVG2cKqA9bHhn7hlmjlB2VqWIFxXoHVRauIOPoeRLBFXOcpBmYcDtyZjHf32Ad0l7qTKIs7Sp
 Wi1zIjxR4r+Hd/S9yrUF9X1WrP2bNiejeTSz9EzIajKI2Y0YjSzAfI53BLmuI7g1rsV+6YloUQo
 kp+MRohB2ynal4xevkdYpjst2taM0y5YjrLJoKR5d63fZXiN/8uJP/6gsXR8dWfoK+3tgxGOsdV
 Zr839qNsd8pHsT1X2nuefYEdRR3ZDtkr6FKXlbVrf4w1T2URjS1/lYdOR4LiaLT6DhEyN/Tk5wx
 794IfFgCkGUXqwj1e5g==
X-Proofpoint-ORIG-GUID: UJcS8ICaUJGINhwRQGPIiyrlVyD1BA2R
X-Proofpoint-GUID: UJcS8ICaUJGINhwRQGPIiyrlVyD1BA2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030081

On Fri, Jul 3, 2026 at 9:11=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Thu, Jul 02, 2026 at 12:46:13PM +0200, Loic Poulain wrote:
> > Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
> > Key E interface signals but are physically soldered as an LGA package
>
> Why do we need device nodes for soldered connectors? Soldered stuff is
> afixed one, not connectable connector, thus it has no point in DT
> representation.

The LGA module is soldered, yes, but the node here isn't really
modeling a mateable/removable connector, it's the DT description of
the M.2 Key E electrical interface that the module exposes: the
W_DISABLE1 and #/W_DISABLE2# enable signals, the shared PCIe/UART
regulators, and the graph routing PCIe->WiFi and UART->BT. The
pwrseq-pcie-m2 driver and the graph binding rely on exactly this
description to sequence PCIe and UART bring-up, and that's independent
of whether the module is socketed or soldered.

Electrically the QCA2066 LGA on that  part is an M.2 Key E design,
only the physical attachment differs. That's what the vendor-specific
qcom,pcie-m2-1418-lga-connector compatible is meant to capture, the
soldered/LGA variant of that interface. So reusing the connector
binding is a pragmatic way to model and drive it.

It also keeps the enumerable-slot semantics: since M.2 devices are
discovered via PCIe IDs, a board variant with a different chipset
soldered to the same LGA grid would be handled automatically, without
DT changes, exactly as it would be for a physical M.2 slot.

If the concern is purely the "connector" naming for a soldered part, I
can reframe the binding.

Regards,
Loic
