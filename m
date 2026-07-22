Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2587E20297C
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729024; cv=pass; b=Ti8bxTDOu/pEdGWHJP1w+ay07SvPYyW5+qxxAg/c9MLDfVagdEL5SFkAkJMpuSnKrYA9OKn3ce40IN+qaIAlgYIAv4sLhTX3pnwtujNoiHtMxOv/0fSM66hTcykL8x1CEOX40o8KP2cxWcdf5g0wRCqh6Wk5Fm0JWD+njcAUya4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729024; c=relaxed/simple;
	bh=9BXUcoy3CAeMSxcvCAPOfPkEc4i39QOOqpzCKSbVSoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpHPbTdU3yVlNkjQn3vSAMwMXNhNYF1PcyIj2laiBB7ZXB0/RSZzk8eHG+nua8pxMogoa5ndyBXxoZvwowa/X3QG8z4qewBcAxhlBiGHLhbgMC39Zp8HVsaHCzDl5kGisv62azTXFG7xTIMJu62vJoqL5sYgNVDhb6FN14aiwbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dYm9xBcG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K+EiTHEq; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dYm9xBcG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K+EiTHEq"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDWRcR445295
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 14:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SRFQr63ZSylPso/HNP+U2b8fPiMqqyDzBwofu8YbHAM=; b=dYm9xBcG8kVwxrky
	/bur/aKqjVfS0RYCmkdMA92gzwoWHtMB3+dfmWF+0449iVJo6Xzt9+OPidVPjQwR
	qlOQeL1+aD7HFoOYHVZyHd7hBddQ2rCN+q7Kt1qcXMrd8JCH575c4AOpqrPv4W64
	+55Wxx5YEYiccsjZPZY8jUh43n/nPAR5HzVnmP1Lsv2rm5zHKem2qAjSGZXFxGgB
	3m44lcZ8bLTTt48tdRhi5Cg0tiNh6hIvh3W8fxtn5BzbcWdq06cxx22SOtorBN+c
	dd1EH/t3dHT95y5qhRVQ1FcTwQDJs/485WRooEDavLzNJlFwGnWI1pfqrb6dF1GQ
	nyu6kQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjxmgg637-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 14:03:41 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92ac0a54110so2153356585a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 07:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784729020; cv=none;
        d=google.com; s=arc-20260327;
        b=nyHhAfNodoMYd9XIPZibgSQT1OiKy72v5a7O3vmIeAHpW4HQHZzM2Mrlbw1qbrUnIs
         93raevIov7m1bkGrZQT3NyWKGFy9xeuhDVfGqxkCyCEbv0il/tlxWwZgA4PnBpou71Q9
         0AZD62jDOLBBSCSKXHZ5J4GY0lNYxDn64uxvVUse1ypPeTHhgwUznaVxcd+RLm0IrTq1
         jyscI8HOLKEHW3eKgFkHuyYj5zDzcCjSySuomUaS+H/QTB8Qv3pr7A/HCRI2L2sW10T8
         QlX32hwrBKZ0sXb/idHKaRAN1ofNz88D67HvPnSTM/wS20H7qpVU7FYnBvQnLvxOfJa3
         DI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SRFQr63ZSylPso/HNP+U2b8fPiMqqyDzBwofu8YbHAM=;
        fh=lohs5GerlwaH/FkzYIP/O1122CgjgoYLjg0GzpRvQ6M=;
        b=QIt6OwbeqWuY9hLLR/m8jy4CYiEAcCtZn77iWrtIlDyMH3AcPjSZ2EWeytAS9XAHkz
         KK31L/3oKpvkWsg5ZjFUoKnWL4AJAocZq/LzSaibPEaJCcxIuwa94zKYdDSFPafmTVzB
         gKn0DvE0ItGOehar/VscRDBkkAhYfxq7q0qm5+m9gmVe4aZJDI9Gv5vRvuuLHnr9EhiA
         QB4PE1R2xK5MA8zvR2Gjd1fWzlyw7fbJpUe+3/qq3iSxoQs01G7idcutaElsgy5+vr6l
         0DLMPDb9gDvwS+Qn+vfsIwJPg/YAtcptCU0Gr5+OR6Cs9un5XRjaM0R8ougEWZXEyYmT
         iVgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784729020; x=1785333820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SRFQr63ZSylPso/HNP+U2b8fPiMqqyDzBwofu8YbHAM=;
        b=K+EiTHEq4bGq7B7wQS2xXTUsD2Rziwlc9qlY3WyQvkUfo+C1Crki3AmQZXcb2NB08X
         ANh76zXyUEv+6N7WC3umVwG8TpUlyBxQt4bGmt4l2E6QzJTdTKfyxiHRxjoyBi2/dJQJ
         g0eE2c+L6k0/Yo2xJrqn2mUmORUorktWR2eUCulwODL1ERiYNGga99DTSP94f0eCopCj
         OCUdQDBPHVhPfO600Hbvcy3Iq2CJafpxl4XMgQJk4BkPxknJ0serTF+m9Tu04INsWHdN
         M6zk6cNCSwf8nxKjtdJhI69XA40gas3Orfvsiygxjac0W78iyA30D8zza8SMq+vRW39/
         tjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784729020; x=1785333820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SRFQr63ZSylPso/HNP+U2b8fPiMqqyDzBwofu8YbHAM=;
        b=Ztj5iZUJTld81kDO6JfPKe3yt9E5aaJGnqlK+7qApaA3ehoEWqpDU17B8I0OtYYfRX
         JXy3gLemofe7qNeBx6m3nhcpgVA6drLHLf4ywZusChC0TEEi9hiB10oIDhwTRVToHkwy
         SIsz4jLXHznHm09O9XcjUg9AYSKnfHj/L/L7UQr6ikrtWcccfTi/6xKnp6BKy0lptJgB
         T9ieICXynqwa3KkHduEnftqniyrTonsOfK+kTK3ZQzjBE7/10Bqv40mPbuTIxZZsIyXy
         ViyDERNxawhEWE5zmOhL0oEToVAwQgOztYF+I1go1R0CJla1ZgnHOXpxbtbSG28uNKk8
         9Y9g==
X-Forwarded-Encrypted: i=1; AHgh+RprFZZuBfBvUwbob6j/wdlq9p3lbfKVmDDeJhJs+OiUwgCyAaZSkFrcqK9dPj2qA1nNmoUHiEQUo4kFbUgJAv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUbH8DPFJoD7vFocMgjqnf5itzjhKUhh0vLdGEPoaiHQYe96PE
	emr9YhbR3VXDV4R02F8lzY3mvtODkJDNPrjPkQG/C3CM3wf1fr1MxKnBs7uYWnJaLQmdens3bMn
	fN5iyNgGC6lkasHfFUIXpcWrerkqLXhY5PiFRhZfkTby8SBIpKONOLsxb5bppchAOYuclj0TYpp
	PWRxpTWUbEa1YrXOi42PjBxkwXOIEcSgGjRl1rfdGnWhE80Q==
X-Gm-Gg: AR+sD11GQoMaxi6bhRoBFWSjOjFPVrj393jpYjD+K4wR2//BhRpXGtJfALqn+TEiN9b
	0fuM4cDVXGgfdgHAHliPPcPpJH4o9tQXTMcGx3Z8WIPIemQJt1zAlyg5mGQmA5sZ2ic7fSg17S9
	mipYKXKNXW19hdOIUFGDTGPT5vWVvYPuMKf7jR4azPRbAT9YTW3qg1HNNfo2Q0+IyRPw65oi4OK
	NtV3s6EWYaQyQGz2comDeuIAKTFY215RjQih6zutF5NhAxWvqdWmiUEwDQ9lgGQqfb7lZbo8fw=
X-Received: by 2002:a05:620a:4514:b0:915:a953:4b9c with SMTP id af79cd13be357-930b3e9c3d7mr2246945085a.3.1784729020230;
        Wed, 22 Jul 2026 07:03:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4514:b0:915:a953:4b9c with SMTP id
 af79cd13be357-930b3e9c3d7mr2246936485a.3.1784729019587; Wed, 22 Jul 2026
 07:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
 <20260720-monza-wireless-v5-7-69ec6743543c@oss.qualcomm.com> <oha2k2z4gts52xjrmjsquqbhikbyfrequxuuwpqx4pjcdiwuqj@3u3wvmkeivkp>
In-Reply-To: <oha2k2z4gts52xjrmjsquqbhikbyfrequxuuwpqx4pjcdiwuqj@3u3wvmkeivkp>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 16:03:28 +0200
X-Gm-Features: AUfX_mzfczekzqEbUNlANz527n61RHWYJ2fg8CBXx6C2Qs9MbAYmlEYmPQ31HQs
Message-ID: <CAFEp6-2_ah4D2ZvkvwN2hYaJ9adYT7i3Rr9WPMLUXtzk984Htg@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] Bluetooth: hci_qca: Embed bt_power in struct qca_serdev
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
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=D+V37PRj c=1 sm=1 tr=0 ts=6a60cdbd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=Z-KoOJIlDxAInEDke3kA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: pVuz1kAmtvhlf-j_qnaHn8yBCKLS_gVn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzNyBTYWx0ZWRfX6FJMXb+eu0kn
 P9ecJ3oiP3oUMg3I70sBaGJOEqARNMw4ChbbIQJubB5FnwGsyijGJ0OhiS6Cuc+aczdgXI0S1jD
 6RkVNE2PURwarCr+b3ZsTh4/LY+Kyl0=
X-Proofpoint-ORIG-GUID: pVuz1kAmtvhlf-j_qnaHn8yBCKLS_gVn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzNyBTYWx0ZWRfX8HtwbEKFj7Dc
 AD7nLX6CEErHIselO3hO2iSPFHwbnu/PYP3MSuFNvIO+K9SjabMx3QOotLB0LD14kKc6y4toE4J
 bGoRfU+5fO47BOUpNPZzUBVPp2jPSmXWoHZXaSeCAU41w0SEZoW5v9cfXCW/qT4n5yaFjY6SuIZ
 UqxDA/XvQzIFkGof8rrr4FIzLQFTN3XfFsqqhJ0WXM99K5ZKaeMTEj9CgqtHhu8M3+KclAU+c2d
 e2/BOxrv6VJYI3QSrMmcnQ+/r7cGpZYNNzSGglMrLSpCoDHZM6msVvkiT4N6bfnxkfGcq+H6lQS
 CnXvxGEc1gRmdLrYETK5ghIz4YovBYXfVM7DVW2ygFOiNF9Np/iQ9evoUXARSmVEG7IKgFRwvoq
 yygiKS5sB0h6MbeCMGD3e9wNjO1E6PEu/IKAyylrzjkY24DZ92daBFJ2hFRVJf7e5eRw2L7swLd
 S0ckjiVCdhpD3YN52Sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220137

On Wed, Jul 22, 2026 at 3:19=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Mon, Jul 20, 2026 at 10:04:09AM +0200, Loic Poulain wrote:
> > 'bt_power' is allocated dynamically only for a subset of SOC types, usi=
ng a
> > switch on the SOC type that mirrors the one that follows it. This is ab=
out
> > to become pointless as the power sequencer path (used by M.2 modules) i=
s
> > independent of the SOC type and needs 'bt_power' populated for any type=
.
> >
> > Embed 'struct qca_power' directly in 'struct qca_serdev' instead of
> > allocating it separately. This drops the extra allocation and its dedic=
ated
> > SOC-type switch, and removes the need for NULL checks on the pointer.
> >
> > No functional change intended.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  drivers/bluetooth/hci_qca.c | 72 ++++++++++++++++---------------------=
--------
> >  1 file changed, 26 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index 81fa41915363ce577ad7c6f25fe1b0a69536d462..7e4cb03d3db0722e5f9fa2e=
7a5a9a0894bf4f18c 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -226,7 +226,7 @@ struct qca_serdev {
> >       struct gpio_desc *sw_ctrl;
> >       struct clk       *susclk;
> >       enum qca_btsoc_type btsoc_type;
> > -     struct qca_power *bt_power;
> > +     struct qca_power bt_power;
>
> Can we drop it completely, putting necessary fields directly to
> qca_serdev?

qca_power groups the power-related resources together which makes some
sense I think. I don't mind moving the fields into struct qca_serdev,
and that's a straightforward change, but I'd prefer to address that in
a follow-up cleanup rather than here, unless you see it as a
requirement for this series.

Regards,
Loic
