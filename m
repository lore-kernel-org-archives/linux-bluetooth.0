Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D34E41B360
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554811; cv=pass; b=M8idEJuOWkMKLetueh80JzRUsywaOOY4CHuPPymOo3WF7LJ6oIyNY5y9vGYoehS9FhaWad0uWVO1G1toRKJUS5u7fceAVnzh7yS3NjPJnJxP33uVlxK2jpWEA+7HM92O1zDZYyP6vrfRKSvYo/a+oKDdJfcsbCcXoPwiCwSBgzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554811; c=relaxed/simple;
	bh=uOBwc+Vl17MdUv77w9tKQsD4/qPdD6T614WQexS4A50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/YBluWoPrliUg54KelWL1EaLJbgYcQ2B7xXInyAnMvunrJ3gS7IXI6fyNWTatgv+MdGKL5phhkof2RVAF4JTPmcTVE6K4VuHW4jzDsK/d755gJCUCAN+TbplhDcWhalBnO1JQ+tdBokSFLda19vcDK9W2V8iZS9ZlSapMuog6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wv4+57bH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LHP9ueOo; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wv4+57bH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LHP9ueOo"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UAhuop2100086
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 13:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=; b=Wv4+57bHKS59t2pn
	l788D+Bh3SNVywmZLGOHfFpV5gix7UmN+Hbdo/rkaV907faoB34D6MoaRtws6I/F
	v30P+s1u0dEaN27jtCCPCVVP+r7L4EEy0FvbN7cRN35CSHU9XxqTb32ZATl5T86t
	UrmjKIcb1J8hNdRzni/k+tZLpRqGXhoJRr92bkpFOWRdgTmqxOYvkyjH1cO6GXnx
	iRe4KV/oP4i6FXY0oe260zuknkGUSwIURJlJbrNK3gxPYKc7iPfxfqQqhZFkUzNG
	0yB8b1v+rCFij5Gpwopcwf+oxHOaJvlbverrXg4+0dPQ0rN+GBwkFpQ3zascOloc
	t7rLFA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duyr423t6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 13:13:27 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7bd5c9e1826so4161487b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 06:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777554806; cv=none;
        d=google.com; s=arc-20240605;
        b=jhNYjTkiinD+oM4Pwlokf6n76V6ZqceQd/z31TSuH2FQCH0l717ZPzf4F0Pa7Z5IJY
         U88Fvg+6TLSvNik4POIo2LG+mNp9HNX1TUevFp2XFdv1LkM6FXeJ+6EJodiw6pvSxE7i
         b2OXqWei18jkusDgBvaXTht7PRVnvizR4BFXoI+L4oUP6vqKPJt87fFw7ZLEqEYLbkZA
         XvNyZYxSxC1sVvlJPwvHKpmjW5qV/57NRau8N8e0UpFA9VD/qhGw8B1fRmTGk20q7TDV
         ncMuLwcRe5CLKzumO0fofg34KzalsZsYMuGBnSiGpBA0h6lphkYuHXXJabSVpky0UPa/
         XSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=;
        fh=/6VJVcBpqhm3f9+/w8eiDzvM7m6lskgdefogOjSiszM=;
        b=JpDZY2+O7mgkG/nwUMScq3hGXRiz+ZPkOq7kwtT0DwWWTLgWTguPED8zBEGGkbRGzh
         h72jLgHyrYc/hOcUuYmjWsZ2XvZj25HuVrU2zHQ9cjeSpu4uL1VC5thpWk/6tAL4PflV
         k8+nSwZerTGj0GHHEWIXBpN7nIzYDTHDa8WwPOckq0ZobOznQWfCyLR/1RByF8nTgW5P
         gMmTGgkT+HhgsE79bwFYdZnFPkOvxxxxnAb9m36ybNcMhNF+j8mXPW23jQZWLYn9ZhbY
         9mbG0YFVadCTf/WYHJkvI15fvNWq7loqv7kL4V+KhLiDqkBHa7iC8uNeb2agBXrNiDDw
         PYaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777554806; x=1778159606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=;
        b=LHP9ueOo3qidJ3OGymx4dHtfklBphqyzE6G40+goDEPKXkGj1RXh0McPXSnVp+gL0Z
         N0tj+v3CJlSCjERetGDN7mTkffcxwtObrTjFUqpUUdb6DZgrdykEbRe1SVWiiBCTjz7w
         dXRA2gkZcH609pSYrX0bzEBZPo/xTEvAC3669nLgOTCaYQymmQ5kK/KZCwGWFkY2on48
         9MEcBsdW+1kzvMZFzpESCP9lZBrRv27ciqFusE1qt8XUcihnCTx+O+8hAOxeryoub08q
         WWYTXc3j9IoLo4ELrljhwZcCNjcx21ed0a/Q4VDBQqnBStTcwambybeqvemsnyKSWwKm
         FWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777554806; x=1778159606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=;
        b=CLrwxmCLTAYDes8wpfS+gMR2gmQoSUG80BiMIHZzGPqglFLsWa2CpDdqnnq8ARSmSL
         drDmMf1j7iMeSN1yPB93J43VE7HrpekDa+hsp7mtXHMyqUQuQGvzJCkFxCOQ3D2j2NMc
         8V29gmvOuGw1VuiRJn6dhgMaixxiEv/4PFEi7EV3XVPh+8D8TyeLcQQgx7wJvYWI6MtE
         7rmZ6Jx/z8sTemF2VvWVoIx6gNIrEEHASXG+9GuYliyzOrSeWLaF6sDwYycSgyQ2Rsuv
         aVxW7i4ieElZt4frBlU4bf6nMcHoAOzTpUP067ayHRTlwpp+/I2m5ki7SWfAYRChmvSm
         WGGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dwZagkb1Uk631E0i+rM5oOsXdRR2LVFMEw86ZgQYA4on7V6viBgRJba4AYzqPuwP6Ims4ED+r1Lf3S+hoCGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+PauXHZ9Afe++0gb4ykAzYeNXALonF2feVimL0Wuji/VsG9+
	g+Cj5qAy3ORkXABys4FYzH/TLLlxPIq2e/rL0/oqzbqqInUBjRzvuA+MZhYiXpEIFMLcf6P90WN
	x9Dt4Z4ysFV2kF5YD5QLHdF9of9L+XE4luxS7SRDeVvQZFlyzRSd8B1H0HvvzszVeO63PPBI70U
	98etMn6AAJWBgPCNLUv8Q+cC2IRpIkPj9wikYRb0xB2dh89A==
X-Gm-Gg: AeBDietb+ki+ULY8A0KmNomrVg70uGJsT4q/0LA4mFEohiJTVTsJbjcTieiDHqEzJ2g
	pdnIVyBQ9oA4GaNwaB8ul83q37aJ06sUdELBdLvY35sfECA0bLz8tja2PGW+Pci0+N5dKqnDauT
	4Pg8zWe77v9adfY7uAGliGDsMBJ6gJNb4+m/ySP+LtweNTjKlczQCKoNMHDaEtlCuTKa056IGAy
	xapy8QpClEUV4viH9kJHn73JdkxC2kRHy47ivVEQSbwb86OgBM=
X-Received: by 2002:a05:690e:4299:10b0:650:ece:89fd with SMTP id 956f58d0204a3-65c1b0a4185mr1181512d50.27.1777554806653;
        Thu, 30 Apr 2026 06:13:26 -0700 (PDT)
X-Received: by 2002:a05:690e:4299:10b0:650:ece:89fd with SMTP id
 956f58d0204a3-65c1b0a4185mr1181471d50.27.1777554806063; Thu, 30 Apr 2026
 06:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-1-6ad23e75190a@oss.qualcomm.com> <20260430-bird-of-sheer-ampleness-744e7f@quoll>
In-Reply-To: <20260430-bird-of-sheer-ampleness-744e7f@quoll>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 15:13:15 +0200
X-Gm-Features: AVHnY4I6bR6fdSxJnXBrJdTY4FKOp8Nu9g27U_d0aw_5w0XdML8zMEtBVrvqIXA
Message-ID: <CAFEp6-25Xad_LT8L-HPpOpXf7j1S=Vew=iSgxEmAHd_on+jkcA@mail.gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: mmc: Document support for nvmem-layout
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=bJcm5v+Z c=1 sm=1 tr=0 ts=69f35577 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=Q8QnmAOcOvJ-T5SqZIoA:9
 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEzNSBTYWx0ZWRfX6URN7lAXzCiK
 KrnLLzLxvv9nUtyXY+emrIefgXA0ClvPR9b3peAq8fchGjrJ+XNMGM+MyOvAZZ5MojRRUrvWawl
 +am+JJaWq+7XTgd2d+aOQXKJ2IvJtl70Z1QBbSuKqqbA8Ib4cc9KDe5+AggmgvPQD4upYZKpdIj
 s8crN5DYXPhZ0xjZ0bszAoODd8auB6orUTExv9JTqONKt+bba7pxJYYP08x9qRtesi3QY3dZ0Dq
 tufW64eRg8tfeW8QbSsnIiXFqBExg5/ayBP17ziN20SydtRXDQv1PYKXPeRZte05dXnR3UuOVJX
 iaizzCFafI9Div2Go/PuqDaWYjMP7SHiZv+3AkgjsYelo12ZVgX/V2vrktympLGoxzYbdS2tALC
 526WY5IFSF1jJt5oJek0K7FxjSzgdccZbGQANA2vjIMm1JFpz33Xl9Zxlf7O1eFxbwKANr/yaUN
 6MRaYfx8ZtX8l/qaV0g==
X-Proofpoint-GUID: 1sVA69dgU8Tbiyb92fDlV8cV9_WD58HQ
X-Proofpoint-ORIG-GUID: 1sVA69dgU8Tbiyb92fDlV8cV9_WD58HQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300135

Hi Krzysztof,

On Thu, Apr 30, 2026 at 11:59=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On Tue, Apr 28, 2026 at 04:23:06PM +0200, Loic Poulain wrote:
>
> > +                    compatible =3D "fixed-layout";
> > +
> > +                    #address-cells =3D <1>;
> > +                    #size-cells =3D <1>;
> > +
> > +                    mac-addr@4400 {
> > +                        reg =3D <0x4400 0x6>;
>
> This looks incomplete. Why isn't this mac-base type of entry? And how do
> you address it from NVMEM consumer?

This indeed falls under the fixed-cell/mac-base type, thanks for
pointing that out.
NVMEM consumers reference these entries using the nvmem-cells
property, via the corresponding label/phandle.

>
> > +                    };
> > +
> > +                    bd-addr@5400 {
> > +                        reg =3D <0x5400 0x6>;
> > +                    };
> > +                };
> > +            };
> >          };
> >      };
> >
> >
> > --
> > 2.34.1
> >
