Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB9548C414
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912969; cv=pass; b=bw6xeR1QFpqGcZjWp0uNjK84cG3VSGDIaqQJD61Fd8xNMZw2B3vOF9uVZaVVQbaIhxflqnj3a3QzrYia3u/eVVKe0OZRn8IQVyVCu1vfY+oHjczWy3EnLaReXjlU9JJNLw6vgl1oYJBWyNfFt5+XwkzgV1zotwapsDAtBlPhbeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912969; c=relaxed/simple;
	bh=N+n/R/mlFs2wkRiMkBtopMW3wGbtfZ47UIAhPinzCC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CiM5/3m+O+Ihq56wZ2K+1SfBI9VoBN12TtMK3EOXw3/ZTJgmcVJSmT+hEhFR2nYViIuCwEKHW4cl7aakJslmdqhxxaw1Xg2CQtqMWIj96Iu0ksnYj0/crmdUpcXsSAOUPj4jlvi+AY7VKRRfF93B+/oxztJqvET8EtFUGXN4Q8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D0TYYJLh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J/Hzkdi7; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D0TYYJLh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J/Hzkdi7"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8RHk761248
	for <linux-bluetooth@vger.kernel.org>; Wed, 1 Jul 2026 13:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=; b=D0TYYJLhf1Zwu2jk
	spVTvuXD1DtrAeoeC2o9zHuxnGi5L2oNStqdVlMFzAka42qve3FCqsZ0imRiSjGS
	wY7ttgiTuQozDBsloMvMWMZ7rH/qOR9G1lDsmLiF7+3AQRgTZm29mCqmNwGw2zKN
	vUeqWlghwM2RkTREn3uRhASvg6bSZRMNTxyjChtRcJbcOyj43Bn47PrPRgooNtem
	izYRe/87MwRcAlgJr+M4KcqpvbGLoJprSrbUKhtWlVLLmIPX48qaTHAE596YlbJv
	Qs74Yv6HObEi99FocjmPI1rDGZPAdejjSZRzvLFUsQfNCiXq1CiD5iYcCYaKTrC8
	PAdhXw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw4ata-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 13:36:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e68cb7a3eso137118385a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 06:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782912964; cv=none;
        d=google.com; s=arc-20260327;
        b=ZiijsmA5eGfJiDhlttd1hiwWu/U4GljiPlrC9pxO8fycf+PstTfPtXmU4+I8mgnanW
         yXh1helWihzqegIrUSCcEduaSdsMs/Yf776bAleHkxBRFRGO4SNQFBw1N7RvTt9UzhzS
         lfm2LRlyd2G7Hrn+l5LE/xpzWqsOD43cyxfRntOtmpBSWKg1shljUw4KWFZGX00Pet5u
         vqPieynx3sufRA1Zhm/5jZKYwhwnYzb3Bg0RcEMIJL70fxufkBaw6B4o7WZg/0srovlu
         8LBADzp2rHc3FB2pTP2PfJB0UPc3HKRRJTB4elVOLqZWfvvpu8bW3MpTrvmDo1nYhGpi
         JhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=;
        fh=mgupzMz0/85vrlTxdUut5r9ZHOBXQA4t3brdm0hLDeo=;
        b=ggC17pzjNcC0IWxpROfvguaM5E6DOhiFlNVYfbFitDM8PA27n5RRVYLUUtlI37XHUL
         9qW+SBTFt+TsSidotPa4PdszMyTKE8Md9pqwLY4X4LM8SMrW3wgFa3mdo3pi0792JjmT
         fIPXDHNd50ffonVGf2/fxRqGfvQleTw4xdzTyrtBMLPmFcsiicuzkoB49znyrN+Ryl+9
         8CFF5pPN35xJS+82afu7o8M0tVzb2Cp5zbQjryq1tpul78CttqJNm0JJC1qYNSVrU0EK
         gdUsUxDrkqE9iJRPTCzgM94Pm+sLtXPPy4ph/vYc9WkzibMrQblKAXpZGFZUfWfoEKek
         P64A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782912964; x=1783517764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=;
        b=J/Hzkdi7UAfkvQ3JS+pBNsS3Qmx4/AV7Wjuw2Oh8ju62IMD4QCIsi8DVpTbiouooBM
         Rcm2GJbEmdUbxy+Tc3ChOTTQm7hJOvM938TBwM5bFgA4o2C2AO2+lMAO5TMybnLRSHmF
         QLShWKLlcjvI5yKmQ6Mwu4jxcPhKVXtkg+uo2PRdBGokaoUPmnFlQQW49W+GI91P/mM8
         737P8Heu+Qg3/8bZhhpaNqZxmFsxiIS3IqmrucpJR22QrEYxEOYX4bOgxfGLNUTycXxA
         1HWSCdbIzTxZKs7dwvsBdnBCIeB2WMujN8Wii1CvgsQCQmMwEdU3daGY5Pwffj5LsOHs
         hBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912964; x=1783517764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=;
        b=NLFnDS8slsZjlKIEp7M794aKUU1Si+pEeB+82RLedEc36WNNSWxz39ohtOI4vbJKDC
         tMQAgPJIhgtE6nN+XWZ40ZjJhIbD4HmAqatFMvQj9OgAwMSUPPJv6ceJ5Ex6mh8A7lHF
         ku0G/6KP7Ae2rERJv48HJueTDSbjxH8pbWWt4KejDUCjBvK/9wku9LowXN5bihf00iuT
         RrrhPZS42bj7Lw9N3oIOMhl4VLQcht9AzN/qBei2Qwk8UF+kyXeWOhEnGlOUc6iHfWIS
         C4MV4FDiZRHK7ExMRfNxEcdCZeynIrPMcSdXKiMy3DEOWJ2PDeU6i7I+6vv6lW1hHJ+M
         +rNg==
X-Forwarded-Encrypted: i=1; AFNElJ+KxrHJ0nvJ4GMTMdVSzev+bzaKK5uTm0NUbPK7xVLkDFDb97ezY1wcus6ZVftwFKhn5LHBlIuwjiv2/3EePEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPTndI5ozzFJZZ96bVpqwwiAQI97ynqDqYb5HHNM53I3fYoOLc
	cZIy1Z3WlIKNS7cVioXmApqOv3GxaIQCNXMgmFJFukQRDS8BS0fmXvaxfPeUAeE+nYBwfhB13x5
	CjJVOO+Y2lbcXAVRQ+hJ9sI5G11qtRZgjWTxZldMJz0cufTKm03lPVx6+ldH2B7npJKtbXOSk80
	nT+HbY89CRDvS08GqDCF4vwt0AscZKzXZ+7HFSJ2TzRGPMZg==
X-Gm-Gg: AfdE7cnZ2s6ncdm3q/F2n9RbO3nrdQQVZKSByh+3SMsdST2pNRe3k/S1vBROXsVvTOS
	QJA2GxgmWyPGvTR4eQagxg7fc78Xq+yEgfr0Pa+IF1ojPyC6Nfk+eIXpyepgrn6U++uSPMeB6xe
	KLgqgXsb9gFjJRPBDtdZRYHdywthjLv8aPzwfHqN9y7dPOuwKju4Rrn6Nh8GovbRmKn9VORioNL
	23K9xTaYq3/uuKTSwKnytOCOCcvoxPVG9UpTUZ5PyuH9y2WwUcnkMxb1JsvCEf4mQCq0Ivv40nd
	x2re8HEPNg==
X-Received: by 2002:a05:620a:28d3:b0:92b:6805:91be with SMTP id af79cd13be357-92e7853d109mr199307685a.70.1782912932534;
        Wed, 01 Jul 2026 06:35:32 -0700 (PDT)
X-Received: by 2002:a05:620a:28d3:b0:92b:6805:91be with SMTP id
 af79cd13be357-92e7853d109mr199161785a.70.1782912918609; Wed, 01 Jul 2026
 06:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
 <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com>
 <20260630180219.GA4139943-robh@kernel.org> <CAFEp6-163adAq8-H_pCzGnq+Fo4jpyKGs6Jv25j3fSpZg3COjQ@mail.gmail.com>
 <CAL_JsqKFjk-mdaAAOzNB6rFiJbw5gd4eDpRBLQL-4q+uJKnp3g@mail.gmail.com>
In-Reply-To: <CAL_JsqKFjk-mdaAAOzNB6rFiJbw5gd4eDpRBLQL-4q+uJKnp3g@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 15:35:07 +0200
X-Gm-Features: AVVi8CfNT2AJJTgPBXfFVJQmZjW_-a9Isbc3rycVEtJcwbZkpqGBU1gJZohgDaU
Message-ID: <CAFEp6-20FXTOKQ6EPuR8OUDkqE4JXcUbXaFy7kRFt4fzszPQCA@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] block: partitions: of: Skip child nodes without
 reg property
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a4517c5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=bM2Xkg4KEcMkddnjsM8A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: SceiulqI2S0tkvsgjoBD5xwv2XvQLBR3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE0MiBTYWx0ZWRfX1QAHt3zWRtWR
 HAGG8MChitQFAzrXmmGBrX94a/zBAiottrjvEfsTf6MB3fec4em60fhnDdurHzeXPH9de9MxJnY
 uHb3Bxd74CSLUjQUpHUrJ/e4ag2Jp6o=
X-Proofpoint-GUID: SceiulqI2S0tkvsgjoBD5xwv2XvQLBR3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE0MiBTYWx0ZWRfX+RAV6GSbUOS1
 Yxr9MeG+iKuJVyqy+1ROT2fkuLnolbsaRTmZFYPH4hn1khjJfIskcj/ySAHQX8cZA1NG4ELqsq9
 MEhMPoslaire3aS/uLp7CP18muemHhiZ2bSer/zLWT7/3hLtZ9gzUOnP3EMjc3+EpjpmBIf2TJu
 22ktJe78hT+7pqugPt9OOCQBLmoZR2EVeaWJTEcYzfPl34C6lB9ZueA7DdGPMu6TX/ALAVO+M5B
 u1hrfHdkHC71GEonmhIPqZ7gRbs7P0u0tJ7OO68fE3+p3fgQ8UV3tLB2Qb2YhpIx5RkUPjGmkYA
 XyZKZPDLlj0og2waYiWV12RN1BL0oLjG5tuArytuOokShvj0qBsrjYIBWQ9HXnm1zgY3Zl/bUaL
 PRgAyakPFFnZZaC9YMi2ysd7NIUVxHPrhB32RHNk8oJWUICLBshbk2LuLTM1O72WhPBtkrUhToe
 moOofFxoKUNWduICSQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010142

On Tue, Jun 30, 2026 at 11:46=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Tue, Jun 30, 2026 at 2:59=E2=80=AFPM Loic Poulain
> <loic.poulain@oss.qualcomm.com> wrote:
> >
> > Hi Rob,
> >
> > On Tue, Jun 30, 2026 at 8:02=E2=80=AFPM Rob Herring <robh@kernel.org> w=
rote:
> > >
> > > On Mon, Jun 29, 2026 at 10:55:20AM +0200, Loic Poulain wrote:
> > > > Child nodes of a fixed-partitions node are not necessarily partitio=
n
> > > > entries, for example an nvmem-layout node has no reg property. The
> > > > current code passes a NULL reg pointer and uninitialized len to the
> > > > length check, which can result in a kernel panic or silent failure =
to
> > > > register any partitions.
> > >
> > > That does not sound right to me. A fixed-partitions node should only =
be
> > > defining partitions with address ranges. I would expect a partition n=
ode
> > > could be nvmem-layout, but not the whole address range. If you wanted
> > > the latter, then just do:
> > >
> > > partitions {
> > >   ...
> > > };
> > >
> > > nvmem-layout {
> > >   ...
> > > };
> >
> > In our case, the nvmem-layout needs to be associated with a specific
> > eMMC hardware partition, nvmem cells can be a simple sub-range within
> > the global eMMC, each hardware partition (boot0, boot1, user...)
> > having its own address spaces.
> >
> > That said, your point about not abusing fixed-partitions is valid. I
> > initially dropped the compatible =3D "fixed-partitions" from the
> > partitions-boot1 node when it only carries an nvmem-layout and no
> > actual partition entries, making it a plain named container node. But
> > it's a bit fragile if we want to support both nvmem-layout and
> > fixed-partitions.
> >
> > Regarding your expectation of a partition node being a nvmem-layout,
> > do you mean that the nvmem-layout should live under a fixed-partitions
> > node? Something along these lines:
> >
> > partitions-boot1 {
> >       compatible =3D "fixed-partitions";
> >       #address-cells =3D <1>;
> >       #size-cells =3D <1>;
> >
> >       nvmem@4400 {
>
> partition@4400
>
> >           reg =3D <0x4400 0x1000>;
> >
> >           nvmem-layout {
> >               compatible =3D "fixed-layout";
> >               #address-cells =3D <1>;
> >               #size-cells =3D <1>;
> >
> >               wifi_mac_addr: mac-addr@0 {
> >                   compatible =3D "mac-base";
> >                   reg =3D <0x0 0x6>;
> >                   #nvmem-cell-cells =3D <1>;
> >               };
> >       [...]
>
> Either this or replacing "fixed-partitions" with "fixed-layout" if you
> want to make the whole boot1 partition nvmem-layout looks like the
> right way to me.

Well, now I think both approaches make sense. We should support a
fixed-layout on the entire hw-part/block, while also allowing it
within individual logical partitions.
Support for the former would only require a small rework/addition in
this series (to have the hw boot partition a fixed-layout) . The
latter could come in a follow-up series, as it would require some
additional fwnode logic.

>
> > That makes some sense, this would require extra work for the
> > emmc/block layer to also associate fwnodes with logical partitions,
> > not just the whole disk/hw (hw part), Is that the direction you'd like
> > us to go?
>
> Yes.
>
> > Also, Note that regardless of which approach we settle on, this
> > specific fix/patch remains necessary to validate the partition node
> > and prevent NULL-deref.
>
> Fair enough, though the reasoning for it would be different and
> perhaps should give a warning.

Sure.

Thanks,
Loic
