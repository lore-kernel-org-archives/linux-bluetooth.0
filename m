Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE3C3EA96E
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288094; cv=pass; b=nGV09/LkPw2ui5jEZTnSE0l1IVWSpDcWwiIR7hPrkKffXkNaYo887aXhv2GnFESaJAoWGfvypZ8xj8dAJtXby5ehXqPeYO74qnaCbrav5N6s0yCQrj+NA8YjNDS/c99lCQ2CVRCunZQohnm35gaAQIrmqSOiCDaBXj/NewO2fnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288094; c=relaxed/simple;
	bh=xbUg8Tez49Qym/fFbF+EEOQeWpWM0YvZSTU0Ng9IgYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMcG27OvHTnxKx52zC3dvBFe5DH65/EvPuvvtMZI0ZNXanhHSCDNIKgq0nfEWfqcht3Z68JvQWMuILjSzzzW5/oikv93fMgSAabI+40khB8G47Lfi2L8zO09h7B2qH0Xs/pO2HNu+MzrEUaIe/2uRsdWi5Zys3LDPXDXVst3RRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gx9EpT+x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C+upmF5H; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gx9EpT+x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C+upmF5H"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K9ls13267212
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 14:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PhdQb21ISCuiB6+7XVLpKLvr32coGHzkT1dS3Rn5t40=; b=Gx9EpT+xa8pxdOq0
	XNYzY8kOQM/Hr7PLVClI3TM+OYCo0nTMERSQDLo1l0XIQ5UtfJCa9gm5SY8Y/toD
	GJf01zTFg7pUDWODu/rb3SNSx94qWl4lvo6jSUNerqpbaunNf/SZaPd+nDYOcS1X
	GEXzuRAith+p5H1MSibwmmth5SpzYTLEEjrlfrEU7DdncBJ7wyM8L2Lic0+MZq6E
	CLMVnqOsRNHgkveL8IzMTePUzoFN5jt+izlZdzmb3RNJV1+swrowgRodrpcq1Vmu
	nMyAxF2xMLnQCG5Du+CNzVR90Xcc3Is3KADZK1SOH2BznSu2S6oOHJVvboRkd+is
	XoPjZQ==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9amxs2c1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 14:41:31 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-43a40a095c7so15456177fac.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 07:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779288091; cv=none;
        d=google.com; s=arc-20240605;
        b=jZYi/eJGKXhvDg7dYAVGIeaUODT40AjGbtWwm5MG095hMvyw9wGESgX+0TVsta8l4W
         uh+GQcC4ABWKh+nhCKeTrz/VheqKXwLU4gynqWUNS7ATeJNWwPTDk/4qVd5vcOFB5K5W
         xLK9/Hb2W8nJGNzwXMBFCTb7cLIF8QpywcMMMDZMpGLTUDo4re8QhOxYKeImvSj/swdj
         I78cGI1mIPJPXQn6EbHCuIj1fGQnMkU5yWiLcprdjpMwfRcGve7NQkTEZRi1R4CymB9H
         tzh/nLWE11cDY50VACjkLe2wpzB7X5oTixapHwsc4GjnCGJgyaKBSwEW3rP+VyelsQHG
         uuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PhdQb21ISCuiB6+7XVLpKLvr32coGHzkT1dS3Rn5t40=;
        fh=ztPACD2Rl0ZEVRuDCAI5dKdPy5xR23F1ArxMPkr8XUQ=;
        b=eFjQYLqEsjQQMph0DSOsUB857OdyQOYa9OGgH1AxOByz71pwgLV0y1aID7l92znTBC
         cBJTrodEiJjtTgD2pfZgM75V9vl6gSl8Qz9FhNBGHiou244fp3U7gBR6rfQWLYRFRDW4
         vMoxLR33kwcOo2EqJwicoDCWlP9dPv+681Y/oO+mGuWUYxjY5MZXbdihM/iLHtWEU/W2
         M0AfTOfNtRffUnSfQ7TgS2Pks/bF5O2e+tNZ+h3JtUXOXflJ8QYcIroy62V1hMeeuvCU
         wh08Tmbo5/dIy1mZrI0p4Vd4rSBPc4da87vziRXE+X0aHafnHIcRqsBBsm5fs1LRR3if
         RwGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779288091; x=1779892891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhdQb21ISCuiB6+7XVLpKLvr32coGHzkT1dS3Rn5t40=;
        b=C+upmF5HsRq0cE+0KO8ZioGMSW4S9IVDtTUGzIAf4rCG20ipjBP+gjvObtW5VLZ3US
         RBf4UmQ2MnFgCZDQJRJO7OP1aTaEHO8PbpOFTC6fkW2m3EgD/AYG0H+c2/J2H5MJTkOy
         uT9Mn2mao2yyae5E7e5J8O+yqumrVBpzckZ5j+vHPALrdnStgyNeeJlApKMdUmW2NqIl
         /5s49xjgaIuTaNNym0QoN9Zu7wjKiJDvpI4NLfBupSqiTAUc2U7Lqw+7fHF8OTBb9OuC
         Qw9mbGoM527Ry6lecomVoErt7LMN74vNaUdrISWXEbYYWae/TLDsTVAiBfI70mZCnYlM
         iIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288091; x=1779892891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PhdQb21ISCuiB6+7XVLpKLvr32coGHzkT1dS3Rn5t40=;
        b=rstcQGtvN0EdWl++ivLVxNH6poaxQUj9fTY76MIn1W3lw0ySSMEsOL1ECeR5A3gCHq
         i35Iehji9jBkJ4w/guYPwrY/pS+PRfdSWFN9exC4svqWgXefnSx0OrQd4ybHfolvdiky
         oWfMAWIFvz9CBRqsAVC149yEF7DPUnfEEt8lmrIGGWV+L+ue5B+GZvMR66LVsSaiqMYT
         VQQ920f8TgePllBXcx6PVccqyhmgyfMu8xKLZiMCQ4/1Y+aj+ZB4NdOZL0VHIf9uFB2e
         WEnSGD/OWWzBu4mqvvMUQ0OnHey4nQSbTKan34DG1r7MVY91OiBvLIFUJccGJpuF9LXw
         Rejg==
X-Forwarded-Encrypted: i=1; AFNElJ/JS7Wca/lfS8IsqpqyD1zRca3nLp2SOnmxhwJPYdh70/b3KnTKnKI7kX3cbPyob0OyOkSG8GZMC6suvKZ0pdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgChqGnyFlWRHGdvmQZ02uOSlweYDThQHtjZSGEwqLlgSXNa/G
	FlLjv9RuY/wFpzKMLi2rzw03cY+kk5xrlrTJ0sJZ5sSZupvE8TGfHOKoHGpCe2elPjzPlimPI5n
	3u/TLYHQ7fcWACkm4ydW8oFul5BQ/X+cRzsf4jKNBrw4S+sZd55zl0Chgv1z7GWEENAtDNef3un
	nftTSOPmDpz5rAtgcm/Lwuy7LKQ/biGKfszmnjNC5Xz8lt3g==
X-Gm-Gg: Acq92OFP1FdU9M79Z3RSM/lciwOCcoa3eWm8Mby2w5OTEeTFtSHB/h4+Zp6qSSNWIPb
	ecRohChcq5YFAFZD/SRjtAec1tvlVbkKVaznBVfWGE5MSJPT1TKjF24jVGc2bugSn9UL0oIz773
	Lz/cCT5Rhe9BCtrD2EPUdUtrxu13xIBoZ4oWFWTJQ/8VzF53DVX2BL+vpw2wDnZj0dN+IJRfFfS
	gwRLpyvKuNPZQsrNw+rVGffqp740qJZtWJnCfo=
X-Received: by 2002:a05:6820:1c02:b0:69b:85ba:bd4f with SMTP id 006d021491bc7-69b884ac83amr13326872eaf.33.1779288090698;
        Wed, 20 May 2026 07:41:30 -0700 (PDT)
X-Received: by 2002:a05:6820:1c02:b0:69b:85ba:bd4f with SMTP id
 006d021491bc7-69b884ac83amr13326862eaf.33.1779288090260; Wed, 20 May 2026
 07:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com>
 <jetl37zsfcs5kl4b7iarbngrdu4ebp7ag2cvpqvkku6tbl6r5n@qozh6n5fq7f3>
 <CAFEp6-0A=LrU44pu2rfUqXW9k9peSu=b2qq_FVs4WZUj-g4pDA@mail.gmail.com> <n6kl7y47hztf7tgtdxhakpekwkxlleggv4sbzpsd2ncpill6ii@bdk5esjubv4t>
In-Reply-To: <n6kl7y47hztf7tgtdxhakpekwkxlleggv4sbzpsd2ncpill6ii@bdk5esjubv4t>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 20 May 2026 16:41:18 +0200
X-Gm-Features: AVHnY4KjiuGhKKWHmCXQOioTVfBJ-iXDUnzJmiSH1aWxruwXcP1EGQFS7-tjBSA
Message-ID: <CAFEp6-3Gbd1gzfeu5xdfBJixL6JXaoSFkRUsBjOji0ZEOHHyvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: PiE8WGP4kjbQxQM1k9FppPFG-T3EAJqr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0MiBTYWx0ZWRfX36RqZNyqE97E
 Z2dWd5PsLpmOwisve0wp1WkN+vT0CHwDkGnJ2pw2rKsYs6QiHu7aBYZMdxOqtxcyQc2obHvHekv
 Kd0JI6ibuCNVtZiwjTExu4M0awhX6F9sZwmYoZ+zKNMskOv0jC4IMcSfJxq3LAKle/6qjxhDfRg
 6xzYM/G3GZXyKoi9xT0wonE29l0FH6P1WIvSHs1Wf/n503JEJfvVq6/ND8I4LmOEtV+BYYdTj//
 YzKjITteEb/7T0ZzzGrqIuyRfPkbFFff0UcdMOuPJ1i6MN9SE/yMyjrGAiqpALhJWLQ+IUPcImg
 oDByA71JUiNp1x7jTBU+dsXTRowrFMVF4rUT2Keo5uarw4+5fDt2z1gIKyho3ZPrZS9dhnBcOu6
 WAlvOiOE/4vCyk5jCtRBAgokrgre3qlfDp+l06pwCuclNQZyi8SLkuqq8oCr0AEDVhA+mJ4zZtO
 hBcZDsqXunhxUKTdcBw==
X-Authority-Analysis: v=2.4 cv=TO11jVla c=1 sm=1 tr=0 ts=6a0dc81b cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=QwjQxBKOi-_Ocnt6GWoA:9
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-ORIG-GUID: PiE8WGP4kjbQxQM1k9FppPFG-T3EAJqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200142

On Wed, May 20, 2026 at 4:36=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Wed, May 20, 2026 at 04:29:40PM +0200, Loic Poulain wrote:
> > On Wed, May 20, 2026 at 2:34=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > >
> > > On Wed, May 20, 2026 at 01:01:44PM +0200, Loic Poulain wrote:
> > > > Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
> > > > Arduino VENTUNO Q board. The module is interfaced via LGA and is
> > > > compatible with the M.2 Key E.
> > > >
> > > > Add wireless-lga-connector node using pcie-m2-e-connector binding,
> > > > connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
> > > > the Bluetooth interface.
> > > >
> > > > Add pcie@1,0 downstream port node with pciclass,0604 compatible so
> > > > the pci-pwrctrl driver can acquire the power sequencer and enable
> > > > the M.2 slot before PCIe enumeration.
> > > >
> > > > Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
> > > > (gpio56/gpio55) used by the power sequencer.
> > > >
> > > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 65 +++++++++++=
++++++++++++
> > > >  1 file changed, 65 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/ar=
ch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > > > index 93ed575817af1c5e903662c209ead629fe202ee2..6fcad77f320cb82eccb=
6f07244d185abfb1976d9 100644
> > > > --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > > > +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > > > @@ -154,6 +154,39 @@ vreg_nvme: regulator-3p3-m2 {
> > > >               enable-active-high;
> > > >               startup-delay-us =3D <20000>;
> > > >       };
> > > > +
> > > > +     wireless-lga-connector {
> > > > +             compatible =3D "pcie-m2-e-connector";
> > >
> > > I think it was discussed that LGA can't be an actual M.2 E-key
> > > connector.
> >
> > I am not sure I followed this discussion. Do you mean that I should
> > introduce a dedicated LGA/vendor-compatible string in the compatible
> > list of the pcie-m2-e-connector binding, or that LGA-based designs
> > should not be described using the pcie-m2-e-connector binding (graph
> > representation)?
>
> I think, it should be a separate, vendor-specific compat (maybe using
> m2-e as a fallback).

ok, understood.

>
> >
> >
> > >
> > > > +             vpcie3v3-supply =3D <&vdc_3v3>;
> > > > +             vpcie1v8-supply =3D <&vdc_1v8>;
> > > > +             w-disable1-gpios =3D <&tlmm 56 GPIO_ACTIVE_LOW>;
> > > > +             w-disable2-gpios =3D <&tlmm 55 GPIO_ACTIVE_LOW>;
> > > > +             pinctrl-0 =3D <&nfa725b_default_state>;
> > > > +             pinctrl-names =3D "default";
> > > > +
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
> --
> With best wishes
> Dmitry
