Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B383383C80
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781258781; cv=pass; b=OUCeb0NmuLSD+YgsjFvh13PV4lKVGs+GJQ48IYtI6HqO04+Z2WdgkBVWGMjuXaVlkxKSgr9Fz3lAr1dgxQuOG8TnJedxxNFKDi6XIL1XQKIWQ+IHokZiGDzQZbB6ZFv5JG0vW93S2zWUAjYlDgf0jv2qwUCl+gEXsrOfA+6jHJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781258781; c=relaxed/simple;
	bh=cHw3EhfIxeFggCpzm6CPqEcKG4hAZv5HGwcoAKqnwaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1QZOxX2eh2qFOYldM6SauRjMJ5A7IYDzgSGk2hrlWkR0cx0DqJmS/TZXiRk69thiRPP2d+TyGWhLvLritC/r1wq4cSU+psRUPUAWEjv4LtB9/i2qBWvr3W6IYbMtbrwZEVt8ywcKB4tZjhwAzs3bGyxD8VbG0JhChWGxURFC+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IgFMujEY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iWYHtzn0; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IgFMujEY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iWYHtzn0"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C3Bht52548506
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 10:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oInph8sZQ8Ma5X0t6VxxpBWehRn7abdgTsEpHVxvEAw=; b=IgFMujEYL7nMZWpd
	KLt4YyRgH50+k1NpU1LggBs55SiDEHrC2/PN+/ZHCO7nPlyoEzT+W2Q6BK8LBbmR
	yCFP6p6SX0zKBq5OLLfmZp1tpnnRXVuRO1slxq2z4FMsarT+TYAMGo2sUFtuDXpA
	drZVZb4R+8gJtgY6prfUwMyHi47ZNvlK15W3OkA7E9sECp+s0r8FBguCM6giwm7b
	cc3j4TnyGUf3YiDyV6hYMrMW5MolB0YP+vKbEQ05H/yq7f3IzUnkHzadp4N788ug
	Z32fgVOfw+kG9QHI1EZIkUCeJWo5e77pNo7NA0LP7ntclwZLFH32bN4HLE8YiNn+
	b5HnOg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er29utktk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 10:06:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-517c65c019bso20885901cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 03:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781258779; cv=none;
        d=google.com; s=arc-20240605;
        b=hD49Awa1RqMpuSsuhpFnp/7vZcQo9zx3AHyjKMp69Njz7nk//DMTc7BIZglBUtT5fQ
         MoD1QhEdMH2EdGO1a4EYjraGmPSp5xKw2BJnuODPQLZe/XdsA3zH2fbNem0lAtgh942F
         0zRQ5Id6pk/yk7j6ADwkLMQ4FSC+JJLb4pg1LfwT3czGUblkuUPe83oORe2MypJUCIfc
         cIAUST/akBnMYovlO5AzO1XQNXLYYodnVX1INubkO8NToqZZB6ImuJXBSinzDQXkJ8b9
         JQngE3yJgK4EIU/R9EQk8nBp4wYDkPf0L01cY3uNcCAc0wWWoXk6OhASgvaAVeEzO1/I
         NJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oInph8sZQ8Ma5X0t6VxxpBWehRn7abdgTsEpHVxvEAw=;
        fh=FFn9LoikfD7mm8rxRGKgG6xxFwaUSAUZm8K3SXcdzns=;
        b=Bk3b64aSka+3CyfuEWHjXfxf9ocTJe0U1plJH9KpG26OFSiJ0xoFY6/i0uzZcFbZ0d
         0H6Vr5CMN99euy6KKXXJWsCzEvOR1+npjfaaIwfjJJavugec8pQc8madeYzEccIM0WM3
         pVkj6401SZEvZ2AFrKKZlw2wYkbqG2y4pAmMYlvob3oN8qn2rXnAADUDG8ogXN8Q72ZV
         hf4EV2yvZfi/tHqiZz8yoYURPCFGecP+L7wamV9+C3ZQGYYHrkkIQHmz7xS0hTDp8iMN
         oF43OKdN2bA8W15KhwWT/NskCOnk1UnizNuc636rNITBc+KvqvEZu+VA0H/kxCpikTU9
         nEPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781258779; x=1781863579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oInph8sZQ8Ma5X0t6VxxpBWehRn7abdgTsEpHVxvEAw=;
        b=iWYHtzn0SMImWgquY9IPKJ/5PGieQ2Zt7BZ7bLymFyCpkgdOOz74j1UvjEJ6itCvUc
         8N9AWY3rYlgVCU2y09EbazWT1qTNgbuVgoa0Ps8Tx1U7nBY4NueB3yKYELHfZm6yepgX
         aOboEKosN1gDQfGmKhezT+Ibty2uxfENtjOQ4lPaSODfQpxbC+60igaYUJaYJ6+5HD2O
         AFn/MHFlEoZ+u/Xk77dZz5eUWvLNM+jBprZGsjXj+88c7zQe+wABYk8qlKVpvC2fOrz0
         pOR7+1vr8UCmK9zvWOBTXtJDgnmvruQplHjWUL9P6FwTmvWXBRVoJpV02tSvHt+4kVVI
         LX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781258779; x=1781863579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oInph8sZQ8Ma5X0t6VxxpBWehRn7abdgTsEpHVxvEAw=;
        b=Pw9YHRK0OBJmAhFzE5U5ndZQB+V5v0/spSKpbMzbatc+I0gWSKTQnCMhr/OaTFXe44
         GtaUwR2WAg4cFxhodc7r1H6uiP65tBRQR/fBgZjC68yc4Z0IoJkas/g27254wUzJQFKq
         HBAf8N3oPL/oo8fqyqPLvb64ankq+EMPWWbDeFDP4Yw0ko5pgWuEBY5JodwDAfi9mHny
         Ohh6CReeCQW8unRjO7VNQdXWP6/5lzqn2pLM/X/9bsGAt822uV+9S95gbGODEYJLiz5A
         VTj4EXnUe04a53NBb+mlP5Yv3YPPqOnGAvL4neGKgE7FeP0n3S2wKsrOBWVxG71YaeAG
         X9Vw==
X-Forwarded-Encrypted: i=1; AFNElJ+4QWj44WRvCrLUhZkAYTesCMfIKNQw9bgovj0erQPVuL1IXZJ+WCHMhBYc1j5s/tbpz6t3/Ern715pc8hcEjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5mB19/R1V4wyhE++j4FacLRAa2kJBFCVs1xuEl03S4ga+GmKZ
	SSkE0gzlgoEFevTDBp1AvWw6JCtiH/tMuKpSEbiYBH+5mp4CXcoGhXj1NSxAhZUZ+1+JJi4UBZY
	HlNg5DYko90yK1ZqpkM1KJd8NZHGyH33wmgk/vxiCaJM3oBHpUsm9bkHeiCDES+M5qLXYz1DZMd
	5tZAXAEMSezcUYUz/uTIkEfCRnsOrpFEdyEA9MQJIDOZf/xH1PIlyV/A==
X-Gm-Gg: Acq92OEDl/Kfw96V7xVHbLycUMmE4o5yn2FipVVNggVVAFLCfcDwY50OLy/BNUN0FYf
	ZmqjR55ogRaeTFfdKjvmViclCyaib0MzL0g00Lawg2L2d1m9c3VJxxklzF3jm0nwxEMVBAdaiV1
	q/NI7GRl+RzWOJUv8+c6GXgBN2CqAniYAKYKb4goN+PCIH68olrG1EQnHDw5TJzqoUGf0Xu40R3
	dmHt4WbklIWYFzQO6b4FSjikgB9W9PZGrvHL1lTnuNR/dMjJ7qYKGgnZv/O144nEQ7alHJESq8w
	b10/9UfpmZ5GhJl6J88U
X-Received: by 2002:a05:622a:8293:b0:517:6350:ed4f with SMTP id d75a77b69052e-517fe2286e8mr20997261cf.34.1781258778549;
        Fri, 12 Jun 2026 03:06:18 -0700 (PDT)
X-Received: by 2002:a05:620a:2948:b0:915:bac0:fc2d with SMTP id
 af79cd13be357-9161bc13cc7mr245131985a.7.1781258430139; Fri, 12 Jun 2026
 03:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
 <20260609-block-as-nvmem-v4-6-45712e6b22c6@oss.qualcomm.com> <sy2ofvdbcxspxtmfdavjvdz7oes5ieuep4znf4ayknmuwhrlgk@7lp3bkegaeif>
In-Reply-To: <sy2ofvdbcxspxtmfdavjvdz7oes5ieuep4znf4ayknmuwhrlgk@7lp3bkegaeif>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 12:00:19 +0200
X-Gm-Features: AVVi8CcCaLmOad_JBtnFjekoAUWHpnzgbbLT7l_V3SVx5j2zNp67A6Sx6we9iz0
Message-ID: <CAFEp6-3Z92KNVv6hbG_zrzan4+cP-TCkoc693orKwvQyvP_YHA@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfXwIng+Fn499ra
 ZaQBaY4BUWW6Lh3gTU5pjgNu3ALo1LRUY6q9r1qnIADMHyCYmQ/eromuoFnnAuuK2pQBsiIOise
 Tg2ax1okvFXNcAx8hwFzQFsO1uyQU+s=
X-Proofpoint-GUID: 8Oc12LFeJcS7Rs9NM0APaUltP62BF8zx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfXwv9xARxTIYM2
 2EuaDai9fffnqZBwXI94PAntr3D1EfCq6K866NCRLvZnwy7BwtizY97jzY9jiw4QDikn95fL0gX
 zXwSbW3JOJBrmKSF146MzRyrvBNn0hsnRav9vp6qa53290YCm+MwqkHEc2aJzlvnQTiOaSiRm7D
 mM5wIGlRhVuTCQfIaIznUSKKKKDMcwwiYbajTJAj+thNr+m+TAqng5Qd3jFe/wJZYMmAyTsIjwO
 GP6v/Xubcsnupnb3eMOpFsISJbSAQ1mHwqR1e3c1gzcqeSg9w0Uz29P8PVpNSOjCuuVDZbQw3Xv
 VGy/vUu3A/P8u44ZMjjf74p19CblPXByJTYfMbv21pHw7fHlDHKMVInRSQEoCA67Os8Idv6uZG3
 4LVKsJuGKmfiq/mW+mTCwKQfFcnJufmqGedxd/5bR8G/xoqbPLdPsseYEZPua0RRqIr+nv80fqB
 mpo1OJrtqaI+5EJwtmQ==
X-Authority-Analysis: v=2.4 cv=DppmPm/+ c=1 sm=1 tr=0 ts=6a2bda1b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=dtGr58D_ptlPQ1E9saEA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 8Oc12LFeJcS7Rs9NM0APaUltP62BF8zx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120091

On Fri, Jun 12, 2026 at 11:11=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Jun 09, 2026 at 09:52:31AM +0200, Loic Poulain wrote:
> > Some devices store the Bluetooth BD address in non-volatile
> > memory, which can be accessed through the NVMEM framework.
> > Similar to Ethernet or WiFi MAC addresses, add support for
> > reading the BD address from a 'local-bd-address' NVMEM cell.
> >
> > As with the device-tree provided BD address, add a quirk to
> > indicate whether a device or platform should attempt to read
> > the address from NVMEM when no valid in-chip address is present.
> > Also add a quirk to indicate if the address is stored in
> > big-endian byte order.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  include/net/bluetooth/hci.h | 18 ++++++++++++++++++
> >  net/bluetooth/hci_sync.c    | 39 +++++++++++++++++++++++++++++++++++++=
+-
> >  2 files changed, 56 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 572b1c620c5d653a1fe10b26c1b0ba33e8f4968f..7686466d1109253b0d75ede=
b5f6a99fb98ce4cc6 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -164,6 +164,24 @@ enum {
> >        */
> >       HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
> >
> > +     /* When this quirk is set, the public Bluetooth address
> > +      * initially reported by HCI Read BD Address command
> > +      * is considered invalid. The public BD Address can be
> > +      * retrieved via a 'local-bd-address' NVMEM cell.
>
> Why do we need a quirk here? Can't we always assume that if there is an
> NVMEM cell, it contains a correct address, even if HCI command returned
> a seemingly-sensible one?

The pattern follows HCI_QUIRK_USE_BDADDR_PROPERTY, the quirk indicates
that the address returned by the HCI Read BD Address command is
invalid and should be overridden using a fwnode property. Without this
quirk, even a valid fwnode-provided address is ignored. So here this
is primarily done to align with that established behavior, although
whether that design choice is ideal is a good question.

This also raises the question of why an explicit HCI_QUIRK_USE_* flag
is required to allow reading from NVMEM when the controller-provided
address is known to be invalid, rather than attempting to use any
available backend (fwnode-prop or NVMEM). but this remains
consistent with the behavior established by the fwnode-based quirk.

So, I think these aspects could be revisited in a Bluetooth follow-up
series if there is interest in reworking the overall addr fallback
design.

Regards,
Loic



>
> > +      *
> > +      * This quirk can be set before hci_register_dev is called or
> > +      * during the hdev->setup vendor callback.
> > +      */
> > +     HCI_QUIRK_USE_BDADDR_NVMEM,
> > +
> > +     /* When this quirk is set, the Bluetooth Device Address provided =
by
> > +      * the 'local-bd-address' NVMEM is stored in big-endian order.
> > +      *
> > +      * This quirk can be set before hci_register_dev is called or
> > +      * during the hdev->setup vendor callback.
> > +      */
> > +     HCI_QUIRK_BDADDR_NVMEM_BE,
>
> Also, is this necessary? Are the devices which store the address in the
> wrong format in the NVMEM?
>
> > +
> >       /* When this quirk is set, the duplicate filtering during
> >        * scanning is based on Bluetooth devices addresses. To allow
> >        * RSSI based updates, restart scanning if needed.
>
> --
> With best wishes
> Dmitry
