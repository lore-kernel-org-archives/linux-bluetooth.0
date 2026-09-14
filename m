Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9548E415F12
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375815; cv=pass; b=QpBYk3I53xRPA1bG+25UWNfpzsB1p5/z5vp2VmvuWWL9DDSA0kqxZhAorMkR+LULp5wi/WMKgvDN2xL9U2jU67LI285SbPdT0lSB/YSUxQrLa6b4Myck/Xb0I4yJM9gW1lTL+g295EYMT87Uo9cbKCGuPloytRPqv1M/W5Jn7Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375815; c=relaxed/simple;
	bh=rURd6TloKr3f0GtmYotAt/Lt132i4nJ02pnGCrda06Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tu9qBcsRkpTwYsfPPo//QIQUz7tzSybmuaUR32HlVIIZlbi0LuKaVHNJ2p14JSA8Vm3YVrSoKzQ6ZRB+TT1dzIbJ0hRFt41Pi/GLUWen9KjHS6blK2eT/1s8mrSYGtqd/v2Hyr0eATml/xyMQinau5MkDcjdpJY/vptjjY9SdmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UVcAMdwb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gIGQvN00; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UVcAMdwb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gIGQvN00"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E7S32X3351636
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 08:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rURd6TloKr3f0GtmYotAt/Lt132i4nJ02pnGCrda06Y=; b=UVcAMdwbCwVGAbCV
	C+sUaDdDX+wSQ71/mmFXzE/+9fIcAZHzaY3fc/XfdVRB0NaaSP0FTc/4MgstqM9i
	si3Mf9Gz0rfrpoHnnL29Lxvcxul1FW2q/LrvaZU72WTE22DOmEuQqcE7sXLJ4nql
	RysRQcME7N72Fq8zodzLw0YqGXZ2HPtP4KN3XlDFAS4oTAGE27DHd+3Q0Sk2mdgr
	HcDGrJUw0yKoh4BLXGkfEu+jYFQpdNDIpOFZbGCEpjO/fzR/N9wHNjb1GT2HOSFM
	EAD5UqdxyBLXVJwigrgEiRRIaaseVJ8EKkFKtcsk1jj/AXalu8ePqYGRZ5iV3fBL
	YOVQAw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpcjg09f7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 08:50:06 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a0b66ecd9so189688585a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 01:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789375805; cv=none;
        d=google.com; s=arc-20260327;
        b=oAEfdpPj+4VLXiY1ObSfs4yDQx6EQ4qUj+1FarBv93yxMkyBV62/tES3xwJVsMVklA
         Xy5Woazz/Qc+VAdsb4X/K/m4COBzAaLcp7IpOtDt7G4BNCHGK0354DLl+WJ1qQ+Xb+Fi
         pyeZonXNVT85HmMiptjEa+KiwnlIGYp1dQBRB62i81l7jnLJg4R+Yypvpwc/3YhkdtDx
         4toCH3x+LbZ05pYm4iqZmMUU+DkIPU8MtcNxPCOmLcREI3mbOqx0Bh1fByv/JbFHZ4Mb
         LIQj6FL20oJRt5h3j6Xq1zZ+WMyd/jCR52EZEMueAioCF3sKpd9b1nRxm5Qwg/8QSvlx
         qZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rURd6TloKr3f0GtmYotAt/Lt132i4nJ02pnGCrda06Y=;
        fh=jk8O79zN6rKYrrtTI98qPv+d+V/GfnCze6ZqOLLDjYs=;
        b=p0UwZYdV0NAdcqhffB3WDKPGWVMOgjFJyYB+FzhCy25ENuiiuJsRdmc3FXNeES1ohj
         sCHuSBTtGT3//GQvVAeq2an4HCCXnrnBstUO1E3ZmvlMFzKz8hgB1n6Rpi2Qm0HYslDp
         u9zjeBFXE7FhnCXEgbey0eGguVTDxVJo/HSHDn2cRuvJX0Jhko157h6vae9l6P+80kcE
         eiGCLS3G5nA1io9LwokP+xT3AFqKJ/QNgu2vE1SW+ODYiO2hiYPfT6sBy7fK2Z3e6RHP
         6vgKjA3iqCMjbsXpM0t8rYQDOeEVYk0F4EzSCAe2SaQbJDVxtZOWRyNnq0/M57xjA6rZ
         S9/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789375805; x=1789980605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rURd6TloKr3f0GtmYotAt/Lt132i4nJ02pnGCrda06Y=;
        b=gIGQvN00XlJLIlrGcPqcLt7HHVIulIL64nwmJTXgneCQNFjmVn2g7wEZ0fzrW/2l6z
         kWff8ehsldkj4SlnTEFMq4A2Y5khFOk243AzI1o32GikMfmaI/v6Wr4i8ucNS7hfqi+K
         XrfUGRYWYxejsZnUTEfYZts/yvygqON7vSF1pCF1ecI5d0Q6V+uBcZ/4n1roS1CunWDa
         Kfc3IVJj8wuY0YvJbSaJdKqNedCMlP+fyzM5eKJNF860nauB7TM7Q8MxFXGuC598OGP6
         DUmtJfSQSwmIZE6QMQ1wXQ1UdFUVYgcUh+bZ9CYZO9oF0PkUTGcxCJ9nmimt1Y9mksjF
         PFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789375805; x=1789980605;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rURd6TloKr3f0GtmYotAt/Lt132i4nJ02pnGCrda06Y=;
        b=roSZZIcf2uW7Xwz+MVK5NoPzgKXB/kbbH+U/kyB7oZyM/8GQrrvJQ7+L+hiqTq1sEU
         3DOGiZKrDqC1G0faHL/mMJ4O+BgJl8DqAHea/H9qzc+OtDKLONKpcyU6vt87QD/sR62v
         wIiB/1jd9tw9T26R2pN0DhPqeA4b4X4QfPDSKV4gjD5ARVzs2zmK7UQC178kPvbmfxwh
         /RdetvOvRXPK1NOlezYe4QaosyMxB8G6IeXTVJdpHccKsmTRlV/WK7KCGhWJqWJDqwzI
         BvStYCkW2eduu1YT91mntNp+CgR2p7yc1UYfUMmmjmqS83Y7rS6E0vgoa9K44fACLs/p
         r+dg==
X-Forwarded-Encrypted: i=1; AKwUvBxgnB2ObxzIosY9jTDhpWE8SGHu/pjYWcGLcqSbvUJfqm7UvaVHm0ARszZaNajgvyWgHY7Wv1zUQEw+yIHi6r0=@vger.kernel.org
X-Gm-Message-State: AFuF++lSXtWXgpxHra4T46UckXgXhj15qp7w311ihXJc+NyWutmXZlY/
	s8J2v23X3uyopOVbFWSQLGUCMtbfyMU/IFJrMo1BU3Za8lX5f/D7XY+pCYskS4lyWyUDfITu6x8
	niRGHN6CYxwIi6lgLVOdumPaYHdxQSR1WGq5sGejG6HAINy/e5zIGkRAVtsoFq1KC51ea7cDQzY
	vCMnJ28P5e2PiiR3LoGZa4luWOYk+4ban9wsmmuVd6huT+D1i3PTLm7r51m9I=
X-Gm-Gg: AYBFou1FJ72O7DFLNQMXgVNn5IHsRcZ99LvTJawmHEwTOO+VkSQpIk0Y/GTA9QKaQhO
	L3hgSz3RVU8oFTFg66LR8wEUFjZW/2PSaS8/zKMAEyaaWV0M2+5R7W9aBoFQoAde1Bqmgxqmt26
	mdXGhv+9XjpDK9OVlcTSMntBxfICQmycK7nyvsASesFI26juB5Jk+Mg5w0G1ge9OJdwG4wObtlP
	nwC7QJkLC4bHritBfvuPYrVTORbu/rmt8oXEQppvVV5L/t2tE0Ff16/CyrDgeUiZAJDNpTW/9M=
X-Received: by 2002:a05:620a:1b87:b0:939:9fca:8d2 with SMTP id af79cd13be357-93a2981322bmr224905985a.18.1789375805360;
        Mon, 14 Sep 2026 01:50:05 -0700 (PDT)
X-Received: by 2002:a05:620a:1b87:b0:939:9fca:8d2 with SMTP id
 af79cd13be357-93a2981322bmr224901585a.18.1789375804889; Mon, 14 Sep 2026
 01:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
 <CAMRc=MfDAiUMzOYRWioK2NDM37=yQqb4pQ5ETZz1PVOKQhhdug@mail.gmail.com> <CAFEp6-1PuGMGkdfWYiUQnYffm7en8b-DQybg_4M9xw9MVDNRsQ@mail.gmail.com>
In-Reply-To: <CAFEp6-1PuGMGkdfWYiUQnYffm7en8b-DQybg_4M9xw9MVDNRsQ@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 10:49:54 +0200
X-Gm-Features: AcwNN1VznECsrEJUnLcouEQxxRZWOhGsAh6qOvyElwlmFiNZH_egy-fEq4m3Sig
Message-ID: <CAFEp6-3gD0xBJZOOmTw1MBex-DYo99MXHsQr_=uLABMHdSjaVQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] arm64: dts: monaco-arduino-monza: Add support
 for LGA WiFi/BT module
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-pci@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=CKa/zhrD c=1 sm=1 tr=0 ts=6aa7b53e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=et7816VZQgabzuuDM88A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: hHuiXxxenl57dWIGmBScgevfLxWZYm2k
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDEyNSBTYWx0ZWRfXx+t1jWifnrwY
 Q98VrH55LD1rkjQ8dVzGV1vz4v0b3EY5SDZ3Aazr2OVOhgczjZCKzEsvkgd6YksJG1hN2Oaorg4
 zrK6hlxblj1/X+vYQ+91eEEeGv4zJvc=
X-Proofpoint-GUID: hHuiXxxenl57dWIGmBScgevfLxWZYm2k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDEyNSBTYWx0ZWRfXxGEs/sjrvXLa
 ujdu0SmNQePcCQBVQuxGEDkVP9oyyqS31U9IKpkdf1aEMG96v5BprDhd1jsL1EsWS3yGyUfEoHi
 vbZSHByPvjkjxmkMKlIq0Vz/UM70wT+SE05HBrfSbHrLfupKxA+2eG7o7xSNP9v3aXkdRgu5nLF
 PrFyRqK/8DPHVgNBc4yyRwTl+MICfSbZ5bcNvpfremA0/wBNCFvIS8/JWZnEPbqRaQChyxxQe/E
 1+a10RTJbvP0UXokKeB8EdaJk0Qv613312MpueyCZlG1zamrHAIxKgSNvHGsmeUyRhsaBMrSIYS
 Ic0RtNOUfGHafZOW7R7h9AgciaznZQwR2lYvqul7c/DqmqaNb6yObBIRoErpiodJrvpSh0AIo7p
 XM5R7IyCI/+snYFaYgUApJk8TWDRqEFQLzQE/EYVt8XE/OX2xRVYMRoEeARONOj90CdzUBfqpf9
 291W2SqPxUVhsVs9k2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140125

Hi Luiz,

On Mon, Sep 7, 2026 at 2:50=E2=80=AFPM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> Hi Bartosz,
>
> On Mon, Sep 7, 2026 at 10:24=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.=
org> wrote:
> >
> > On Fri, 4 Sep 2026 17:42:15 +0200, Loic Poulain
> > <loic.poulain@oss.qualcomm.com> said:
> > > This series describes support for the onboard WiFi/Bluetooth module
> > > present on the Arduino VENTUNO Q (monaco) platform.
> > >
> > > The board provides LGA pads for a wireless module. On the VENTUNO Q
> > > these pads are populated with an NFA725B module featuring the
> > > QCA2066 WiFi/BT combo chip. While implemented as an LGA footprint,
> > > the design is functionally compatible with the M.2 Key E.
> > >
> > > The NFA725B exposes WiFi over PCIe and Bluetooth over a UART.
> > > Both interfaces are gated through the W_DISABLE1# and W_DISABLE2#
> > > signals, as defined by the M.2 specification and handled here via
> > > the pcie-m2 power sequencer.
> > >
> > > This series models the hardware using the existing pwrseq framework
> > > and connector bindings, allowing coordinated PCIe and UART bring-up.
> > >
> > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > ---
> >
> > What is the merge strategy? Do the pwrseq changes depend on first two b=
luetooth
> > patches (I don't think so)? Can they go onto an immutable branch shared=
 with
> > the BT tree?
>
> The pwrseq changes are only a dependency for the Bluetooth changes,
> not the other way around. So yes, they can potentially go separately.

Does the above work for you? Would you prefer to take the Bluetooth
change separately, or would you or Bartosz rather pick up the full
series?

Regards,
Loic
