Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378732DB7AE
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923759; cv=pass; b=DZvnjkFP1DdLNb4Lj8YVeu3HzJvfg3h88mifC/8nssXYEhhjd34RLd1M1surm1znIb9x+g2yQP96QG2q3HPC1YzG9YJ7ZR/1RcfFANsSk6/KWf7AD6SsLi66KC4QbX0K/9M2dIt7X095iNUd5XtWpOharMDezV4geWK8Ev/Ulpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923759; c=relaxed/simple;
	bh=vVjU3pwVlqs1eGL3LgvYGVSpYqf3o7An1hUHG7tFne0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcAAUNqjOSR6qRW7wzfpBPbWqWaM+no/tRCfzWgEzvtwjM5DK2ZgqVbcb2lt8oC1HrZkJWef/4k7B9BRjYMr2aMBhjATXQD+4CGVSmS+vKTIA/6LPLfQMLT0t57TYafmbMNCuqwAlFutNI7U/4qLs9Cu3p4Sp2sClIk+mCvLv84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j+rUH7yN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FOvDuEs1; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j+rUH7yN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FOvDuEs1"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9MCV3038117
	for <linux-bluetooth@vger.kernel.org>; Mon, 8 Jun 2026 13:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1xsUP1loZg3jYdsBk6X4zW9T5zMq3W/iPnEHzKVjyxY=; b=j+rUH7yNKShbdNZr
	MqPeI10vwdoPUpfzUXM9yE67URwfG9f0JDVVLUsjGLRvD/v/a5wWvZlAOk53MIGY
	LjIAmHuiq0Y7nQzBPMV/sLmmLpmTz4Z2Fhhe/9VKFllEevVNCvaKfs8Deh5mgVbP
	XZUGYjS4x+joNYUOgYpqmjey1ARbnX7M9WqpEK2EfdQcRxxz5b4N181GIbqfv7uu
	AHI36YCPoIxY5nEoCxDPPjX9+bOXKPxuxWB9fJL6ElDeMVwZj8kFrxTqi+vtPS6B
	0U4A2fZclkQlc0vqe0jegAp6NKsUhWozFi7CmVerYMI7Q+oOXk65aSmTgo/iXTPD
	nmpo6g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4envaj8h4k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 13:02:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9157ae36434so148091485a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 06:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780923756; cv=none;
        d=google.com; s=arc-20240605;
        b=MKhedWTptti5mpghATuwBID33N0xPB35hT9IEFzxVRoYAuqjk9JKRryMK62aQ0DB6W
         U/1uWfSAV38453Wd1zBFWUSoeyfL5DbQUJd7O87ujJHD9bF5XDOiY04Yov8UztuhOl+f
         XykmZ4s0Tp8q/Uq1bxaRiU4iD8s0TJauEAf3WsHf13fImeuxebI24nliHjiLjotSIIFO
         U1GbaPXuA91Il/+5n5NUJhmtUVXLJY0sZ6ESXLTTgt3XKicOr4I/QNfiW4lPFPQAKr75
         dDoku4K6OG+FTC21Ku0uhZ2gkaz5mYCsC/UNWsIdyzxsO4bK72RFH+/jum1ktitE+mqW
         NR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1xsUP1loZg3jYdsBk6X4zW9T5zMq3W/iPnEHzKVjyxY=;
        fh=nvy29sXyz7hsbOztRg14oNWlH2YeNlAQXTBgVk8zAGs=;
        b=c9eMaTvgTO0c822zGebvpi2C4OdYzEryKycEog0NL9i3lW6mjkdvYTctRFDm1BdbgT
         oFY1fnmyzyyh21gl62Zp1DOlCQcZrPsyG3niKp7dlrbR6REPwik68cRaJ5PDNV1abyKu
         HceTXY4EQhTRhiy5GAeoz/WTsmilkIb2lhQ8tcimtfJZqjcnMgj5E7FDCH32cv/9EgpZ
         XTWJWMHuVdHDrt2PYqGRcs8PGSewIboJgLNijinq0AFX73JFHDxNfqAIV8GCKcOVz66Z
         mxiMvsHYBeemqTnIDHvfrogNZ8VWIfVtO6tAte3/EXL3uwaupzAtrdB6KUhrlH/B5L12
         Ut2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780923756; x=1781528556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xsUP1loZg3jYdsBk6X4zW9T5zMq3W/iPnEHzKVjyxY=;
        b=FOvDuEs1HeYZL2+YXmrDlpZo0kNgo6ZTosywK+ME/B+dq2CBzUvZ0vkq2hNxRISZJi
         zIxOAs1HhskE3VF9URfe6lLjLYVP8JNSuQqhU9ww7xOxGa18/4uKGbRtgMj8ryx6mcjJ
         Wtgr6BIlLLV2y4MVtT8k8FeqiNEyWc9K5N7/VGc4X8vzeEmtHTp+ObkvEfnpC1bxTVJ3
         fN1VOpNL/6tKQPAFQYhK6SZ3A2xEI3jE4ORNMgmiYONjxq4UGDtkpnMyiWSB9tKeP2hU
         vTN+8+RCTl1Mv32CscRfn7ps8kAd5cfUwqGNE1fx5Bn949NAJlIwCGvctvAfULYMpDGk
         2vgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780923756; x=1781528556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xsUP1loZg3jYdsBk6X4zW9T5zMq3W/iPnEHzKVjyxY=;
        b=kqifLtNr00AxZ5VtjiFNfHmqWHlU4ZY5NIhMyOYQ/22jgZR2qkXUmZQhUjPtpWFJwL
         43JH840ot+nvhVqGjwD2szmb15iwwQOe91BLtQS5i+RtVwH9fctiCeKH1jEcdo8VvbEy
         D0pDwDoicm+qmDk+2PdPOZcaFuRnFQgE2Kg1F8JhwPENj3AZUVC/4V4FcnZ/+RyoKHUt
         Wpw/EEuRJlPDbm3tStCdT8GTJFcdOjbIlWjrq8xCYUTeIpdGXKpkqLt51AeR1Dnx8hJO
         hgc/z7QSx6EiFMWWCWLMsWamF2shw8FCmXqvpALxtMp23QG6ArtIerqDIeS8bQ+BITRD
         Qfrg==
X-Forwarded-Encrypted: i=1; AFNElJ9M0ue+H6WPeZattyw/MPCdZO5pLul6XgQacy4iFUDA0ujDyRPhFCcMNGjoZr1JfueHkYqEIO7G8gyqMwD5qlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6VA94xYxnp4aBzkDz3RO1WN6Xk1fAIIKIht576UmNP0HLxXrf
	aD3i3otzgxiSj5DGqWzeUbtqt1V7dKV8bqP4mW0r31/OEIEU6eZiZFyXmiEI14j6OH9Wmmth9lU
	7Vzbm6TGZ/M6QtKMIShdG5luIzznWSLJgdPx5K4PdZ9svol1xAr3IHSdyZjyCeu2TaKBQpxUn5r
	nLRtpI/40iKnwWk0vxHIC3ja3O5nqYXgAZfQp22R9NKRf/vQ==
X-Gm-Gg: Acq92OEGTK3QKQmfk/g0Chc0Pb6jeYa7der2nl7YD23zQiMa9B7m5bC/7gbdk3uBFLf
	HjIC/FVrqVif52OtOtlJJblK21mjsA8TRH6yaWILDMm11V/6ww4bpKpxTMiEVXWKqpjUCVmrOeg
	WvG9ESChc92l75vWVAxGkhUPsBGgghekrM3ybAO1WM0/xqUOaJk3Y4+WdRfpIDU6fv3LG6gBtfo
	6Kxywrz7l00nzZkFIseA0xTEwB8FOOosFpGYnTQ3+Y5cEp4MhyGyHQOMj4/wxXQOebP6bIY3BMO
	RNF5Mdc+3g7NYt7f9PA9p2D0aSb9B14p
X-Received: by 2002:a05:620a:454b:b0:915:2404:bfe9 with SMTP id af79cd13be357-915a9c35852mr2536202685a.9.1780923726410;
        Mon, 08 Jun 2026 06:02:06 -0700 (PDT)
X-Received: by 2002:a05:620a:454b:b0:915:2404:bfe9 with SMTP id
 af79cd13be357-915a9c35852mr2535551485a.9.1780923662522; Mon, 08 Jun 2026
 06:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
 <20260608-block-as-nvmem-v3-4-82681f50aa35@oss.qualcomm.com> <CAMRc=McmoWvezeH05_5AR7ZbAyg1L567HsKWbuD7711LwnjV0Q@mail.gmail.com>
In-Reply-To: <CAMRc=McmoWvezeH05_5AR7ZbAyg1L567HsKWbuD7711LwnjV0Q@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 15:00:51 +0200
X-Gm-Features: AVVi8Cc-wgzw5gsLbwZHUHPYEgpxejd9uRTmITt11-0eb6tOd2NzMwDpPGAFaCc
Message-ID: <CAFEp6-0JaOd8PpqMY_21BEDyDyYx1kDfskOS4VSd8nxP4KBXZw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] block: implement NVMEM provider
To: Bartosz Golaszewski <brgl@kernel.org>, daniel@makrotopia.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
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
        Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: cE-MrmZXbFtK22fvK68hbcBZ6LVae_WW
X-Authority-Analysis: v=2.4 cv=eo3vCIpX c=1 sm=1 tr=0 ts=6a26bd6d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VT4XjZGOAAAA:8
 a=IjnKPMcg25KrRLxKrC4A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-ORIG-GUID: cE-MrmZXbFtK22fvK68hbcBZ6LVae_WW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyMyBTYWx0ZWRfX3kVFNELOes7F
 VsAiVe8mNeBPGN1PlVLZdGOsfhjX+WrCu17lERtLsQjTAaa1dMupbi8YWslPjkShwApxvFSrEgt
 2XRBTo6KI+QqqVS1n7W2VvLLiHDhsoWGzZHmxvYDcLTDIocY+wxjABIAnMLP2EWpOJ57dwjtMzV
 WcXvFIeUFmUg5OKfuYE0U63/eebXgbFenFUS60sc1cko3ZU9F5Z8RRI1OS/NkqkMNhYSvK2csc2
 kulwALkRLsO8LIA9khvdyryiq1Sjf5X7Wd4mGJcSavROzxUaH3HlrwkbBdEvzQvUifX1nyt0DLB
 vhsv1JfYBaB9Jbwh3wZUW3D8yawhVmsA/927c7zq1L/UNCuIlZiqU1nwJpDL8E93ytK72Qfxkae
 J/kpl2UHHV0HVR5Xgjw8ycItw0DArPJJxGbOYFLOW9zHx9qn6Lxj51WXp4hxnthFwDsnHtDzVbP
 Fr4eLPjKarbDpd6lZPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080123

On Mon, Jun 8, 2026 at 1:17=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.org=
> wrote:
>
> On Mon, 8 Jun 2026 12:50:41 +0200, Loic Poulain
> <loic.poulain@oss.qualcomm.com> said:
> > From: Daniel Golle <daniel@makrotopia.org>
> >
> > On embedded devices using an eMMC it is common that one or more partiti=
ons
> > on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPRO=
M
> > data. Allow referencing the partition in device tree for the kernel and
> > Wi-Fi drivers accessing it via the NVMEM layer.
> >
> > To safely defer the freeing of the provider private data until all
> > consumers have released their cells, a nvmem_dev() accessor is added to
> > the NVMEM core to expose the struct device embedded in struct nvmem_dev=
ice.
> > This allows registering a devm action on the nvmem device itself, ensur=
ing
> > the private data outlives any active cell references.
> >
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  block/Kconfig                  |   9 +++
> >  block/Makefile                 |   1 +
> >  block/blk-nvmem.c              | 171 +++++++++++++++++++++++++++++++++=
++++++++
> >  drivers/nvmem/core.c           |  13 ++++
> >  include/linux/nvmem-consumer.h |   6 ++
> >  5 files changed, 200 insertions(+)
> >
> > diff --git a/block/Kconfig b/block/Kconfig
> > index 15027963472d7b40e27b9097a5993c457b5b3054..0b33747e16dc33473683706=
f75c92bdf8b648f7c 100644
> > --- a/block/Kconfig
> > +++ b/block/Kconfig
> > @@ -209,6 +209,15 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
> >         by falling back to the kernel crypto API when inline
> >         encryption hardware is not present.
> >
> > +config BLK_NVMEM
> > +     bool "Block device NVMEM provider"
> > +     depends on OF
> > +     depends on NVMEM
> > +     help
> > +       Allow block devices (or partitions) to act as NVMEM providers,
> > +       typically used with eMMC to store MAC addresses or Wi-Fi
> > +       calibration data on embedded devices.
> > +
> >  source "block/partitions/Kconfig"
> >
> >  config BLK_PM
> > diff --git a/block/Makefile b/block/Makefile
> > index 7dce2e44276c4274c11a0a61121c83d9c43d6e0c..d7ac389e71902bc091a8800=
ea266190a43b3e63d 100644
> > --- a/block/Makefile
> > +++ b/block/Makefile
> > @@ -36,3 +36,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION) +=3D blk-crypto.o=
 blk-crypto-profile.o \
> >                                          blk-crypto-sysfs.o
> >  obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK) +=3D blk-crypto-fallback.=
o
> >  obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)        +=3D holder.o
> > +obj-$(CONFIG_BLK_NVMEM)                +=3D blk-nvmem.o
> > diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..99c7728fb7bccdc2216780a=
73a89a9210f925049
> > --- /dev/null
> > +++ b/block/blk-nvmem.c
> > @@ -0,0 +1,171 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * block device NVMEM provider
> > + *
> > + * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + *
> > + * Useful on devices using a partition on an eMMC for MAC addresses or
> > + * Wi-Fi calibration EEPROM data.
> > + */
> > +
> > +#include <linux/cleanup.h>
> > +#include <linux/mutex.h>
> > +#include <linux/nvmem-provider.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of.h>
> > +#include <linux/pagemap.h>
> > +#include <linux/property.h>
> > +
> > +#include "blk.h"
> > +
> > +
>
> Stray newline?
>
> > +/* List of all NVMEM devices */
> > +static LIST_HEAD(nvmem_devices);
> > +static DEFINE_MUTEX(devices_mutex);
> > +
> > +struct blk_nvmem {
> > +     struct nvmem_device     *nvmem;
> > +     dev_t                   devt;
> > +     struct list_head        list;
> > +};
> > +
> > +static int blk_nvmem_reg_read(void *priv, unsigned int from,
> > +                           void *val, size_t bytes)
> > +{
> > +     blk_mode_t mode =3D BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES;
> > +     struct blk_nvmem *bnv =3D priv;
> > +     size_t bytes_left =3D bytes;
> > +     struct file *bdev_file;
> > +     loff_t pos =3D from;
> > +     int ret =3D 0;
> > +
> > +     bdev_file =3D bdev_file_open_by_dev(bnv->devt, mode, priv, NULL);
> > +     if (!bdev_file)
> > +             return -ENODEV;
> > +
> > +     if (IS_ERR(bdev_file))
> > +             return PTR_ERR(bdev_file);
> > +
> > +     while (bytes_left) {
> > +             pgoff_t f_index =3D pos >> PAGE_SHIFT;
> > +             struct folio *folio;
> > +             size_t folio_off;
> > +             size_t to_read;
> > +
> > +             folio =3D read_mapping_folio(bdev_file->f_mapping, f_inde=
x, NULL);
> > +             if (IS_ERR(folio)) {
> > +                     ret =3D PTR_ERR(folio);
> > +                     goto err_release_bdev;
> > +             }
> > +
> > +             folio_off =3D offset_in_folio(folio, pos);
> > +             to_read =3D min(bytes_left, folio_size(folio) - folio_off=
);
> > +             memcpy_from_folio(val, folio, folio_off, to_read);
> > +             pos +=3D to_read;
> > +             bytes_left -=3D to_read;
> > +             val +=3D to_read;
> > +             folio_put(folio);
> > +     }
> > +
> > +err_release_bdev:
> > +     fput(bdev_file);
>
> There's a __free() action defined in linux/file.h so you can use:
>
>         struct file *bdev_file __free(fput) =3D ...
>
> and avoid this label.

Ok, thanks, will use.

>
> > +
> > +     return ret;
> > +}
> > +
> > +static int blk_nvmem_register(struct device *dev)
> > +{
> > +     struct device_node *child, *np =3D dev_of_node(dev);
> > +     struct block_device *bdev =3D dev_to_bdev(dev);
> > +     struct nvmem_config config =3D {};
> > +     struct blk_nvmem *bnv;
> > +
> > +     /* skip devices which do not have a device tree node */
> > +     if (!np)
> > +             return 0;
> > +
> > +     /* skip devices without an nvmem layout defined */
> > +     child =3D of_get_child_by_name(np, "nvmem-layout");
> > +     if (!child)
> > +             return 0;
> > +     of_node_put(child);
>
> Same as above, can be:
>
>         struct device_node *child __free(device_node) =3D=3D ...

Ack.

>
> > +
> > +     /*
> > +      * skip block device too large to be represented as NVMEM devices=
,
> > +      * the NVMEM reg_read callback uses an unsigned int offset
> > +      */
> > +     if (bdev_nr_bytes(bdev) > UINT_MAX)
> > +             return -EFBIG;
>
> This will mean a failed probe. Wouldn't it be better to use -ENODEV?

That would indeed be an appropriate error.

>
> > +
> > +     bnv =3D kzalloc_obj(*bnv);
> > +     if (!bnv)
> > +             return -ENOMEM;
> > +
> > +     config.id =3D NVMEM_DEVID_NONE;
> > +     config.dev =3D &bdev->bd_device;
> > +     config.name =3D dev_name(&bdev->bd_device);
> > +     config.owner =3D THIS_MODULE;
> > +     config.priv =3D bnv;
> > +     config.reg_read =3D blk_nvmem_reg_read;
> > +     config.size =3D bdev_nr_bytes(bdev);
> > +     config.word_size =3D 1;
> > +     config.stride =3D 1;
> > +     config.read_only =3D true;
> > +     config.root_only =3D true;
> > +     config.ignore_wp =3D true;
> > +     config.of_node =3D to_of_node(dev->fwnode);
> > +
> > +     bnv->devt =3D bdev->bd_device.devt;
> > +     bnv->nvmem =3D nvmem_register(&config);
> > +     if (IS_ERR(bnv->nvmem)) {
> > +             dev_err_probe(&bdev->bd_device, PTR_ERR(bnv->nvmem),
> > +                           "Failed to register NVMEM device\n");
> > +             kfree(bnv);
> > +             return PTR_ERR(bnv->nvmem);
> > +     }
> > +
> > +     scoped_guard(mutex, &devices_mutex)
> > +             list_add_tail(&bnv->list, &nvmem_devices);
>
> I'm not sure I understand the need to store these? Whatever you need to d=
o in
> remove() can be scheduled in a devres action here.

I think the devm_ approach would work fine in practice. The only
difference is that NVMEM unregistration would be delayed from
device_del() to device_release(), but during that window any read
attempt would simply return -ENODEV, so there is no real race or
safety concern AFAIU. I guess the explicit list was initially kept to
mirror the add_dev/remove_dev symmetry of the class interface. But,
except if there is no strong technical argument against devm_, I will
switch to that simpler approach in the next version.

Daniel, feel free to nack or ask for authorship removal if needed.
This patch submitted in your name has accumulated enough changes since
the original submission that the current shape may no longer reflect
your intent.

>
> > +
> > +     return 0;
> > +}
> > +
> > +static void blk_nvmem_unregister(struct device *dev)
> > +{
> > +     struct blk_nvmem *bnv_c, *bnv_t, *bnv =3D NULL;
> > +
> > +     scoped_guard(mutex, &devices_mutex) {
> > +             list_for_each_entry_safe(bnv_c, bnv_t, &nvmem_devices, li=
st) {
> > +                     if (bnv_c->devt =3D=3D dev_to_bdev(dev)->bd_devic=
e.devt) {
> > +                             bnv =3D bnv_c;
> > +                             list_del(&bnv->list);
> > +                             break;
> > +                     }
> > +             }
> > +
> > +             if (!bnv)
> > +                     return;
> > +     }
> > +
> > +     nvmem_unregister(bnv->nvmem);
> > +     kfree(bnv);
> > +}
> > +
> > +static struct class_interface blk_nvmem_bus_interface __refdata =3D {
> > +     .class =3D &block_class,
> > +     .add_dev =3D &blk_nvmem_register,
> > +     .remove_dev =3D &blk_nvmem_unregister,
> > +};
> > +
> > +static int __init blk_nvmem_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret =3D class_interface_register(&blk_nvmem_bus_interface);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +device_initcall(blk_nvmem_init);
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 311cb2e5a5c02d2c6979d7c9bbb7f94abdfbdad1..ee3481229c20b3063c86d0d=
d66aabbf6b5e29169 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -2154,6 +2154,19 @@ const char *nvmem_dev_name(struct nvmem_device *=
nvmem)
> >  }
> >  EXPORT_SYMBOL_GPL(nvmem_dev_name);
> >
> > +/**
> > + * nvmem_dev() - Get the struct device of a given nvmem device.
> > + *
> > + * @nvmem: nvmem device.
> > + *
> > + * Return: pointer to the struct device of the nvmem device.
> > + */
> > +struct device *nvmem_dev(struct nvmem_device *nvmem)
> > +{
> > +     return &nvmem->dev;
> > +}
> > +EXPORT_SYMBOL_GPL(nvmem_dev);
>
> This should still be a separate patch.

Well yes, actually I should even remove this as this is no more needed.

Regards,
Loic
