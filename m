Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7EB42A163
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299516; cv=pass; b=RlhmYTe/oES50hU3fIhUURCx6y9vvN3vbNK4PLu2s44fEUNwI64nrATkW0FVYbBv17NKSITr8lz9Az3g520qcp2fMGCONUJ2expAycfQbTQ8h26TymBOscmY63m21uOGfXwGGJPQh5B5xx1nlS7bmQOAEf0dR8SR8pTJFNHrKls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299516; c=relaxed/simple;
	bh=FNzsOpMvx2fOI919kTiNEIxpFwaZQjVvzDd/rPsGLQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6sIXdN94ALJejmUFKt+SjgmkMdDeAWCuwPDUYOOzW8aUmbOqKMWQHwKzoqTbf2vHv+jTjMAb3+9JbAigfuyEWokqGghCLMxqPPfF83nRkf2pDAEcbrN0NEnQgygRDWCpgLOmV+k55qrVkpicj/l8FidNRKVJMKsE0wXrewjaf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LgURRFqr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D68BI3dv; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LgURRFqr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D68BI3dv"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HE7oev1838838
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 14:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FNzsOpMvx2fOI919kTiNEIxpFwaZQjVvzDd/rPsGLQc=; b=LgURRFqrlyVMT+rN
	DOONXjUOuinpRQGIpUDcZfiDuF0qiWwRCHIJMhp4rmAHIIm+LPtl/yHwWBfv0OGv
	4ubsLPL/cMwo4MeQny3CEs/OfKd6V3c3H8dHjWXXTAJSK4w3v5oNLS6B1T0AjjRH
	hehaqU+4YcUg2NEh4TD2fLrzEItb9woYQ2O4cRddbgFJRhioqfE1WBY5buPNd0KC
	s24Vppribf8S2/UxeDXp8C4EwtkL6jfglBPs8yhrwysfm0wgJFYOT/CtR3+h6iv/
	XzOo9yOHLMjkkdIOKotPJfbrlMKPc/N0aZJAb44l8ptFUuxXIEjQPxPu9Kxw4d7B
	jmgf/Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fffag9r7a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 14:45:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e82060977so400336985a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 07:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784299514; cv=none;
        d=google.com; s=arc-20260327;
        b=l+hAj+Y+Pgf3UAZe7iXkroy7qR39fXBXqgoajeYsZ6zWqDHwPY39p4UQcuSM6S2Mh8
         MFdIHyzgvqvoQtjBB8dIjwH4ylF+i0pwx0vnLcgaRZ/FVvfp9IWZbQ9QIjrE7avRpg6E
         UwbSGaxsSQ3KnQEnA8DgZwr3xxIfO84a2T9Yy2i8tELohC6iTQph5w5C/1PYyhsGuSv3
         yn0m9I8Fj5GczOGT8VNFGnJDWc4g4VbCyEqOqyg3U7JizD03CAjprqMGOWN9C+Xv3n1m
         rlq15PoK1iVUiPWZ5VKWZlOKFQEQE7KQ4dB7TDdexKuxGSi1bhsFX3h+TJmLT2Lu342y
         +Cww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FNzsOpMvx2fOI919kTiNEIxpFwaZQjVvzDd/rPsGLQc=;
        fh=S+kGoI5QT7uTdBPCz1vwR/AHrOYvpDy7uhlV8Sqfkf0=;
        b=gslJeDOx7E2bk5DqtC7UcT0IfSndHJ3XHVQ48FdsNL52EVSDc3KYlZAeaoy56cQOwq
         9J4m2Se5iEftIzw91vSvjR9aFTOg0YAfHRnFiAdX2S4zUG+nfyVfiKz5B+dYAmigYxRV
         eS7+XBTBwjt7Z5grpB/vy+5ETb52daxP1ZXT3PS2aaXw43IccButpC1Mz+qe3KoLTkN2
         /45Q96JyHwCtY6AShM2nePTXGfNNx146KBNflDVKWWxhnQCaNP5IXUcMdqiKK7vXaO5k
         H7Mswi5/IG1x7fxS25XtvEatbeE7lQPiEOSAmNEELQ9usjvxyV7BpktPJrJ35pTe7Kjq
         ZL1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784299514; x=1784904314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FNzsOpMvx2fOI919kTiNEIxpFwaZQjVvzDd/rPsGLQc=;
        b=D68BI3dvWRmdAIR65e0X57xipBxSsWd3Hv4hH7Bof1XPMbWMtpV+ZYyptldiIWUX8y
         L+z2NQhVRwPPdiSzGenL0eSf+FGDN96uO06Rf5ZilDVGyxE09AYa5mWjPRytTByLnu58
         GlIXSk5DzFjA+tFtTjA1Hk7OVPRR0m1RqZBYXkadKTvHAu+Yedxozn/EtAAJyv4X4Pst
         Zga66iXSBuGTxAfAktmnF/1Ssb3oMJ8/bq7Gvz5TVJQV1HIYy32GL1R5TvQc4Cddi/DM
         Xb90bmlJoc8Rh4hz2kdO5MoilXFf/WkA9jYM+Mo193bWXV6Ar5gbyyhKfpbUFJ+hH56k
         9PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299514; x=1784904314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNzsOpMvx2fOI919kTiNEIxpFwaZQjVvzDd/rPsGLQc=;
        b=A7bwJJsNdoZouja6L0zN2jtH37Byi1oU+zrc+MHeCX7SpUFHj57hM9eConKwet3Tr7
         mGuaa5Xkyl0cBdwGWWivyUcsG+xrx3D6c2MnsGDKZmcvIriZ5Z9VWb75Bzo2NvlIJYnT
         dTlNzi2lLxcKEh//br00t8keB/0mCBEhPfMWJzB691EDuQ2UEYHdunUnVZ7q4im4XG1f
         tB0fXZ+WkCaeKLv3FJDguvQdvTyc0S/OMa6eSC5LlkDlFlvykKMEljXXTpVKRKEP/hhC
         o8ufkaNrdyNp6utBhCdilP+E6PQRPB3JLmACbm9lrswT0mFsVwClSqQTpMY4c4B+hZkA
         kZwQ==
X-Forwarded-Encrypted: i=1; AHgh+RotXqD9aWnLL2Ziom6cGk1BQdqkTpRl1jkPkGHmwSsb1k8AlnzS7KdPOm3aGhQw79FLnYBoe3+tZas+SxD4mHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwclEu5Mpzzrmx4D5nQMVXoMHa9d7ujPyyqZchhGDVW0X1FoibJ
	jdiBxUCiuM9pG1dMQMt/Boh8bm5G85t5wEjs61yFzYLHSvvvquS8fQNEC0K+xmAQXdOVIy5pc8r
	C9+7CdHLMrJr5g/d2w4A/g6eoGatkLjdP44nw0K8+Zl7JZ0jq5tqOVo5PMgtP5qS2CoWcKZvYV3
	bohpVcJSEwHYO3K9fQwLJVQs2uxfybsOT0pUnREV+1o6QH1A==
X-Gm-Gg: AfdE7cmg5mJeTa/X85Tfg11Kuje05H1pFURqXGoBhzbr78QJUiUZXvJQR2R7oIgoB4I
	zmMsQ6TLiO8G1YJsHvcMxKxaCp2OD7ma+6DZ7fkwpHc3+2A+bjItUD7x0W5xT4pqHmPDQacCADq
	TpauFw6MAC48eZXC5NlcaL3BrFg2FHNlRxZYKsSfOT/1mSNXd8HUao60QHFBj7+8kPlRGrJP18b
	AkYvfnVYuId0OeUsC9CdLqDFrde1If3j9CXyOeqlZYc2T8hqNV9uFENUXyPQW66xaam4TTp7kDA
X-Received: by 2002:a05:620a:6914:b0:927:efb0:3ad1 with SMTP id af79cd13be357-930b4929a49mr284920985a.26.1784299513659;
        Fri, 17 Jul 2026 07:45:13 -0700 (PDT)
X-Received: by 2002:a05:620a:6914:b0:927:efb0:3ad1 with SMTP id
 af79cd13be357-930b4929a49mr284915985a.26.1784299513132; Fri, 17 Jul 2026
 07:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
 <20260716-monza-wireless-v4-3-9b02e6f549d7@oss.qualcomm.com> <CAMRc=Md8mLgYRsLd-KhwVV8X9AcYbHf--RB_pf0xFBP_P_DvCQ@mail.gmail.com>
In-Reply-To: <CAMRc=Md8mLgYRsLd-KhwVV8X9AcYbHf--RB_pf0xFBP_P_DvCQ@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 16:45:00 +0200
X-Gm-Features: AUfX_mxmtgHrdkc082wiMIxBxijXxJxzFJEhJ2gZz60O6dCpV0Wr6tzd5_cVl7k
Message-ID: <CAFEp6-2pbYXFTuozcg51+dQ_mKin05o-GqThyJLBjquFs91RQg@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] power: sequencing: Add pwrseq_is_controllable() API
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfXyFHm9WLX3vO1
 8J8QkM3M1U3g3sOCcyc1d5FssGsAbLDG6vI8XFHM3DcHBY7OtvpkoGmMDrWxIbBCzFLnUfyWljI
 lMDl7Xv6KoXNBmNGL0kpDCg2pSk1L/pL6egNamnby5cfiEAhCGURXXwYSO/i03maSlG5SVaGq32
 gj54l32VFIbfM5MuUixawVDsnu1X4tKQkjaw+7avWEk62YGICwFaRNoY0DSx6ox47PxzIDN3Asy
 OGPJaihI5tXAyDp/T3sr0/+51WrWR3RwRQzJ5AYoVgFP9bRvFgK6TU3ad8U/Yn3SUiPppYWMWDF
 kQSWai79mZdKpDBQsVEF8bFZlNk3Wl/ykI2KholCIg9aLEnQxE/8aYTAyOS8GcnUQMSMk3LuG7+
 uy7UuBVU41sc6yTB4ikzEmlhfErV6gEqW4zSeJBpSg76VvwB8EOokxm2OnhJ8zzs7j1JH85V0+2
 s7eV0soCbEq9Vjy3qbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX92ZPhnNynbnk
 M3d/pfF5M95n88UmLDI8PyvINEsFZbuEME+9rsW+gHfvBGgGQCnGtxqQSy4PQzm257oFLjl7vG/
 JrSUWACyuCWHssFJiBTx2ig+moL+N1Y=
X-Authority-Analysis: v=2.4 cv=KZfidwYD c=1 sm=1 tr=0 ts=6a5a3ffa cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=LMDkYzAWLNq1XrXRUzQA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: mPVXStNIhJT6IPbXeBAABn0761zpQmGk
X-Proofpoint-ORIG-GUID: mPVXStNIhJT6IPbXeBAABn0761zpQmGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170150

Hi Bartosz,

On Fri, Jul 17, 2026 at 11:29=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
>
> On Thu, 16 Jul 2026 18:18:20 +0200, Loic Poulain
> <loic.poulain@oss.qualcomm.com> said:
> > On some boards a power sequencing target has no host-controllable enabl=
e
> > for its function, for instance when the enable line is not wired up to =
a
> > GPIO and is hardwired to an always-on level. The pcie-m2 "uart" target =
is
> > one such example: when the M.2 connector does not route the W_DISABLE2#
> > signal to a host GPIO, its enable/disable are no-ops and the consumer
> > cannot gate the Bluetooth function at all or exclusively.
> >
> > Add a generic pwrseq_is_controllable() helper. It reports whether the
> > target's final unit provides a host-controllable dedicated power actuat=
or.
> > The target can implement a new optional is_controllable() callback,
> > reporting whether that actuator is effective on this target (for exampl=
e
> > depending on GPIO presence). If the target does not provide the callbac=
k,
> > it is assumed to be controllable.
> >
> > Note this only describes the target's own enable actuator. It does not
> > imply that a power-off reaches an electrical OFF state, since a target =
may
> > have multiple consumers. It also does not mean that power is uncontroll=
ed
> > for the target's dependencies: those may still be gated on their own. A=
nd
> > it does not restrict consumers from calling pwrseq_power_off() either,
> > which remains valid to drop this consumer's vote on the (possibly share=
d)
> > resources and dependencies of the target.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
>
> Thanks, this looks good to me now. This series is a bit all over the plac=
e,
> what is the merge strategy?

Since the entire series ultimately depends/touch on the pwrseq topic,
the simplest approach may be to take it all through your pwrseq
branch, with the possible exception of the DTS patches (through
Bjorn)?

Regards,
Loic
