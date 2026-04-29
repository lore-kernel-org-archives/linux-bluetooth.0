Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB239280C
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494032; cv=pass; b=i4tBystJB/Z3G4D6Lsy1FPcHc5+yBkuEtqNZ1jgBO9SNYODbyhmaKE6IqaBHTBOU1uQMk7YO0VYMYzZuOaDZ9ljq3FjiVUZlmLfGG45yXxEYoM9l0BY7/g7LjLphAGsSuhWPQOxHFEFAUdiEAc/9V52BdWjEBN+NsOv0wc87DN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494032; c=relaxed/simple;
	bh=4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gig7OppLseqxeLVJDQpfa7iVFrb34x4YUfKqLWiWpPRMV127AnzrFXiwP/eqlHxwmDsNNP349Mw9GfHDgghuehDOA8CCZJrm/y674tGS47xvKUOqbhlrJ8XXNQnwPZNgixqVK0G+WxsuuWO0p0SrYClYuigYO2R8r9q5POzw/PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZJ1yil7R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T24P9Fi6; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZJ1yil7R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T24P9Fi6"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TFFVmd1728569
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 20:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=; b=ZJ1yil7RRd4FYxIp
	p7Iy/QHM4zbRhNpPA0hYLTXJPDkjEZpj0nlJd1/gcn1CaWRIma04TC5JKe3D81SW
	vVeiRZzWMnD6h1j+/NrrML/N1EdSQ9j/g1w/HfPjcjKblwHioKNVvbPOTS7wMt1g
	t0Gzh5vN5ormYORSYWNaDzPSF5QRW2Nn76i06d+SpiMnh38SIooyjOtYhh5AvjdN
	CZmgTmQB8ODoWqmGpsdbBkWvdolXxWGtqhvkZLbyynEZ4or8H895Tf9JexmnCUm7
	KfrnoxvQeAAeJ1xqAifF8YREdrGH3wXxomLatFCwx3CMWJQTzOX/W5W2A3BAs683
	leNRfg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4due5ktw3d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 20:20:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50edf0245b0so3003011cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 13:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777494029; cv=none;
        d=google.com; s=arc-20240605;
        b=Z6+3GemA5W4m4ixP2dqi2YUTI3tKbr1B44XzJp+vE6Z6p5cIjpquT0HLOqmiH98fFZ
         1ctTFuJfLHVELl7jzwS32lLLE36c3CgwgA+1hTppYBOoH5F5wnblnXUMW3XIHOkBxs+e
         I3/q0Yrfd8PQOcY8ZVCdXdDvcmjTjiGNQdrCSb3HcUawZ1xXDIK+W0lO5YMXsY8ggg5y
         3SJF4k7rCJ7ytKRGmkRbMpL4KCOLFGTvWWTxrWAnW6QdrpH5ray8caSqGdM1xY15Y1qG
         VejNBtgZ9Gw+GyB2RJ8i6cb4nVyYpU4KgKXjjBs5KJkX9LyzYBkxltyHSooWNgBnDMAQ
         dBJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=;
        fh=uCgms3Ddi+g7FFI8Jbb5JT9anFqtvqaiozQhjbj2IGU=;
        b=ChJRNs6zeVJE3ww1P6PNtcMGl1WAO+U1t1jUmZM84bm1c5M/BEf4G4zza7LW5G+Psb
         CgCbqHLkpIb09A8Dk6n+riZDNMLm/nioR3rkueFgtZpLZ0fS8/4oUnIaS/v+RvkDhWCH
         kKL3Vx4y8Vf4fMhbFBTwmWQL+vP50uQ2GRdkRbkiqGVzmmMizfgEOvEdcweJ8B/R6w5V
         UVaMCjqw453L+0t02/ikKGFaVOg3IOqDTPIG/4M/HcRC9WbLT9eqd0RkxmaN6QvDJpX/
         +jPWlb/we/2+3+3M60XOHzi8n082Zzp+yWThKFF47n1PnHwNCEv0V47h5tyKcQlWhOXu
         XhRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777494029; x=1778098829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=;
        b=T24P9Fi6Gf9Zjk4iMavuKmXO+S0kBOW1j11fp+tN8dJeMhZ7AyIwSiSIil0oREiY7O
         aft2bmgLO5PlC+vWwAwD/jJscZIZdBXEOtHD1hbtYl1+yd33QyWzyFG8C+UyzydLmKAN
         ctxniHxGmG2dGtuWcGQ1RiUsyXYmdx+3Lq58ciWRCYw7n30BGnGWxPewjF7M0CB26raa
         n+CKzEGTcjioh1vWjBETZ2SAzyYVBB4IQvLZTAtHnk1MRQLSBN2P7EGZ6G2Hx2w8mHrq
         Bn0dIxMgTFx2Y7H3gtVcdOZq1Dsw1ffCJbqJUversd03uc+fk7UXUZM+4L94JeprgeeY
         ltUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777494029; x=1778098829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=;
        b=IdLhuFDxfZBpdZt1nUIe8Hi7kGhV3tP/8Ax7NkLYxTPe7zjiwBbmFdHuoa3XtP7jcE
         dB2qWBD4vtL9y3STWVAGWPBs/Koq91IlVbelT3y5xvkNfwbpnclzWv+Jxe02OrufkK/g
         Ld3JdXKPCPuw5cK2CqjkRHJv3u0y+V5e0pipgnWJffYQlLWmLww1YR9y4tW0mJf1sri4
         WBLXagNyYc+AA5YcmaqO26FXhZhg4saL4djDoqevucgvpnlFWDmR1eDvz2jGqci9GmL0
         mTBUuS3CemcBoIV0UoRn9T+xLFb51fTCeDMXlqvymlIivmtEX5mgxvRPXI3MjA2ORoRz
         COxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vssgy6Kw2Lhz8gL9Lks3kyQghAkArDS7qdOPFfoHJ4H63ObLCxyJMQDmR8IpKsMVEDGPnbIVMRQ4RWS3DP2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtnyulPEBys8an+D3toiVXlVdOmZC7FGGa7WsobXffuh1wEy+B
	nT0FJoJPeG3dO6RKjdzFS956zoXjGHwCFvb/8mqHyyCPapOjzo65O2hB9ie0i6cgSN0ZLU76w1C
	WxZD9o2xEVFXg6CMCLWLiglNkFRskeeSk5xn3vb1h8wZ+UOa8u3BRcwIiGrQbjHi5vejebNXEux
	v4WeeAt+6jhT1IqBdD4bMwu2ms4wWLGQJH21fD0i2gWRBDow==
X-Gm-Gg: AeBDietyc6AGr1Ph7bATpyfNcSSfqqwRy7y1i8uvLB2Y10Iq5YIjmNeZzPc8n7QUWdl
	xW7dEdskRpINuqbB+4qFf2qGDnwPJlO3B7tEOskP2xVZlVYeyeSWgxKq+wBQ1wE/H0YouJFujJG
	DwD/LA3VBIJYC7fxYJ2WDPuF+SkhEKaSjZI1TUo58lbTsy6QUVcvSaK7sfvaEnQlheQ7Y5Tu1pF
	Q5EZPqfOiQE4jjORL/sDaXKytEO0g+6gnGbWNXVbOouiCwL8A==
X-Received: by 2002:a05:622a:4cc6:b0:50e:89e9:271c with SMTP id d75a77b69052e-5100e10eb2fmr114762531cf.17.1777494029280;
        Wed, 29 Apr 2026 13:20:29 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc6:b0:50e:89e9:271c with SMTP id
 d75a77b69052e-5100e10eb2fmr114762001cf.17.1777494028820; Wed, 29 Apr 2026
 13:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com> <b4de6c89-dd89-4e02-8d79-911e4f9f0813@lunn.ch>
In-Reply-To: <b4de6c89-dd89-4e02-8d79-911e4f9f0813@lunn.ch>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 22:20:17 +0200
X-Gm-Features: AVHnY4IQns7j5YMIXICXGX8mkvbJAvEU7QYVILcU5HpEGI8Bxfo-jvWggVlQrrA
Message-ID: <CAFEp6-1GdaJd6Ua15TsyQC07QDbArXO2JZa9nKVFoCG=4xBpWQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Support for block device NVMEM providers
To: Andrew Lunn <andrew@lunn.ch>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIwMiBTYWx0ZWRfX6e4mhKqBfxbe
 Ok5up2qwWSq+1ornMmiehANtrKk+0YHrwCINoNWcvId/YHl2WwG9eya34IxBaS1gJLHSe564nqe
 7kUmWyAeaTXprG7xk4mmBLqKrg0fcxnV7lJAo+X0oY2mEzINVqobuLDZWjSWQvlRVn3m1NvhL3+
 aPudp5yQdKC918AClnvBpuz6VBzFyjvgHwiec0O+2GbWVu3VJYgqHjpCM0QH7NEn3qkdSjASvKT
 yh7WsO+Ork0E7y9ohPaWG/9HUh2z2tRp5bsZD6Urlbdwcm4atROztbDjwag6RJHCLSvE1FfTzXJ
 AGFVlHqKPpukfJRLRqSEvxjGcFS73Vbmwus5uIKswneKH4vZXOlaVFUEsT9+nQU8TUk1RcDGA/f
 BRBhpmjkD9is3ErYigts3IBtv8ec5HGoPDDXrT+o6Ob/rYt0u9keQVCTYnxrwjyI0qQHZexCfK/
 QQBHOzNkNLSw3lu8I+g==
X-Proofpoint-GUID: lJHjtcB5nGw4ivjZgzkn7thr0KfR_NAD
X-Proofpoint-ORIG-GUID: lJHjtcB5nGw4ivjZgzkn7thr0KfR_NAD
X-Authority-Analysis: v=2.4 cv=CL4amxrD c=1 sm=1 tr=0 ts=69f2680e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=P-IC7800AAAA:8 a=ICsrgdoeZ6IjgJzXnBsA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290202

Hi Andrew,

On Wed, Apr 29, 2026 at 3:06=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Note that this is currently limited to eMMC-backed block devices, as
> > only the eMMC core associates a firmware node with the block device
> > (add_disk_fwnode). This can be easily extended in the future to
> > support additional block drivers.
>
> Would this be
>
> https://elixir.bootlin.com/linux/v7.0.1/source/drivers/mmc/core/block.c#L=
2641
>
> Looking at that function, mmc_blk_alloc_req() i don't see it doing
> anything different between an eMMC and MMC.

Yes, that=E2=80=99s correct, in the previous sentence I should have referre=
d
to MMC-backed storage rather than specifically eMMC, since the MMC
scope also includes removable MMC/SD cards. That said, eMMC is more
likely to be used as an NVMEM area.

>
> An eMMC you don't expect to go away, since it is soldered
> down. However an MMC can be ejected. Is the code prepared for that?

I was about to say this wouldn=E2=80=99t be an issue, since the NVMEM devic=
e
would be unregistered along with the MMC card removal. However,
looking at nvmem_unregister(), it simply performs a kref_put(). This
means that if a consumer still holds a reference, e.g. through an
nvmem_cell, it might still be able to access the NVMEM reg_read
callback after the NVMEM device has been unregistered and the
NVMEM provider data (bnv) has been freed...

I guess I need to try and dig into this but at first glance it seems to be =
a
general NVMEM issue, since even though most NVMEM providers are
not hard-removable, there is nothing that fundamentally prevents them
from being logically removed/unbound at runtime.

Regards,
Loic
