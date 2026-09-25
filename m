Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D274E1C8C
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361737; cv=pass; b=m+hjPYtpUpPUbu9mWx7kixXUpCZLyMBuKoz/UhCCfA0FkJNIWJlGOqhBor5YPy8G29mTXr5dirNaLxXDxhWVuQvaD1I/I36aXrwskA8Zl89hp+s/ffYaoOv/ntWmh8bHHsicb1MXFb0bml8kcebIxt8Fp9HVPAbFUuIzl6Emfao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361737; c=relaxed/simple;
	bh=qe35OzbfSn5jxEUxVU2cmzIGiFHK7xWuk7f7gKumZ4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ep4jzqmHJ+GHq2oLkNXCawe4AXIvMvTYMhaplYT6YiaJYyF7I8QdqD/VExBmnDMNN0weTGsRzGC12kXqbecietRFD7yOyVqstDd7GB7KlWLWg0Xv4co4agZZLN66XAre/0krBoSiYHRA7TI6pmifuMBhkMnRj1pNXFJ6lGvzclk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aSlUeud9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MLqMAtOF; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aSlUeud9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MLqMAtOF"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG5LFr1759231
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 18:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m3xDk7u5dmLP2jxW/XWS3M+3d/I4qMp3Fvvf2xNBdKY=; b=aSlUeud9MMrnTvaE
	fBNW17DTlK1pd3VcwQpUk4ojbblR/A1hMmRDFhOv4r5cy3OVu8i2q6RmCi/4vkuZ
	vUfJnemh4SMXjd7YTf5sbLQCTkc017+cBse1LMO1nsJkHCEWniirrH+WKHG39Sy8
	my8Qbas7L+ScsIZTV2pNDMGhJ3LWocXSDZvk5Td6QyumagYlnF3T/M65woH/CUay
	IGqzzkIMWOsK+Mg9kxItyfWdlSbMOxtpgASz+AMsYETe9UpdCinK6WF8DBzpNC6p
	SaGtAz+max3hYXt17goBn1g67FdMVjHnVQNwOXVfg+HpnIOlmupIwqr2msOh/dir
	1yJ5vg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwv5yrpy7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 18:42:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a1de6d5c3so272317885a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 11:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790361734; cv=none;
        d=google.com; s=arc-20260327;
        b=pmGYPrWKe4U1GNrNoKTUCb/wAASJiR1GnnDevgU2KwxQbKrnoB73oe1FmwMcC4MoAU
         T+ITyjgoe2uFfiQGIfweMgSYoAnUora+thxnit3g4jm46bTuZbOKuY3OHHtGjVFPUtR2
         atdPPE5PIdQd6yXXgr3ACdnCsDLmI/9VyMrh6MXCIMBMnhNMZbjwUalIynyWLphlwlMB
         SO5cuxY6+C5gnp/zZ1dAFhHNa1Gl5zaT9lHeiHRXBaaCex+BiydQLlGqcZBIgz6I77MX
         LcbOf/H2jhhMxUG+i5yWrgoeTLHeoUFobXOSDyn+1qb4oswPGgRAal7P9BYWA+cX+P3d
         flmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m3xDk7u5dmLP2jxW/XWS3M+3d/I4qMp3Fvvf2xNBdKY=;
        fh=wUvIgumQiBg5YK9AHhsgHQVqLAnFku972GL+GunZO6c=;
        b=In7dt+eTNJ2Hg6YCydeojjjp/VIXX1Vy2eVPVkbgvbF5euHT8uyan/qejETMNnI+t4
         1194ZxPtCfiVUX8Z2X86B2WFPGFybCH7QR9ymhF9w9UTlgkl/5HOLVJ5du+IYRr0OcHB
         OJ41rMQ8UvHwuKglFvvnWfsKtmTQQLGENu7aLqO+gXZGPYCmJeRWLnCHiEw/QNDjyPBb
         0G8GEJzzDBBy6RZxKvSp0SdoBGDL474wtsLpBJlWupZsZXwgSMpz7g8JQNC+WaD+J4YW
         mbb0KMR9+GVPrhJFpHqlhidMsW5L2JkSjdb9Y2rWbO8wxv53WMK5bpu0S9dG4VyphRlp
         vxRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790361734; x=1790966534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m3xDk7u5dmLP2jxW/XWS3M+3d/I4qMp3Fvvf2xNBdKY=;
        b=MLqMAtOFgcfL9/esEM7x6BGxofK86YIE1Fei2550rmKgF1kyAQlJ7ay4c9AMp95V5F
         9yVqR3MeECJxN/rljFLWY8Y8cH/y9dErI1SDMfWjRP2T6c286srna7fLafAgf12jJNhb
         C3dUd0We4dWIfe51+7rlrCq4o4SInafcewYvXgEfvqw032ew14t/HA12/kHlUjnorEzT
         Xk4FEBXlguoF/nQB8KmmRq+ZkQq01LvbBb3469/GB1/ktBO+P5lX7PuPxO2z8L7DaBId
         ZzYTL9r+nufOK+2xNUxp1fhF8PNMKIoObRgTMhZiPFhlIeXx0EXSKM6iKcZYxwBqOAmy
         v8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790361734; x=1790966534;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m3xDk7u5dmLP2jxW/XWS3M+3d/I4qMp3Fvvf2xNBdKY=;
        b=PoSw9gUxzEK2GNsj8PQLY+SmAZItUKlmbfKz43sOEZ5Yt4czZo02mVdah4vTfdDtQw
         N35yZW33YsBG5LoXsxh0SX3r46ld8XHbENdUK97smDMJKApsrVaZDSL1zvVu+K7Ns1H0
         EmbesbT5gVJKzQhYZiEfqk6Cysc+X6IMVf/GkVilmMJR7OTd9IXNcOw0asuNATMPGiZq
         JoTV+fw8ww9upqPzQiQzUSE10f3pp/fipUtkdvRLDum1aaFtrJiN6tMVQhFQHDIC81UE
         yoTgMm1GCeO46De6nPizJm1Ia0GtxA0rqRTndt7lg7XafuOOuif26DoE8h39aukIQbsS
         Bgug==
X-Forwarded-Encrypted: i=1; AKwUvBzyv8VvkfX5asFh4uS2kovP+eWP7G16W18tP4HE5PKw1hj7UivHzlYRb8H3IyhY2wTNlJwYHAo/LODs3HthDmo=@vger.kernel.org
X-Gm-Message-State: AFuF++l7AcnoQAj2gH1OdHikhO5eMVDG0mWS1IJZ1vM5bC1B/QEj1z0f
	rOAm9k2PMdEX8DnD8nUplgjJAR3JvY+K7W5ac54/Owv2rOx7lxNlGmxCq122efBttmADOkqCPfG
	iSeqGn9ElVYEILvo78JHi3gdl9flovWCg/mrrsuZ6VniRoz/IAUnLoKiaBfUPi3aF0Cw2RjY64I
	RznYXzhOdSAnkctqAFELjnAOiPWkLG3FtOpZhTxT2UlgJVew==
X-Gm-Gg: AYBFou3pE/kL8qgGoT4+sMVcDxzk2BeRscTxhqBFSOTUzKcFllownglIk7gqwzC23/5
	s+W1F7twbv5ezyXnHROEQuMxiygjY+XId9mBIAouZUhUBpoW4z786G6awVs/H7SsSjP0cQcJUKd
	nshWrAkQBCwfkVc7KqAKYeMPZUiihFYvL3+qVIJjubTgj5J/MfFBh40SJbIMUH5+ararziacWuf
	KMyD0vyYWFTUHqfT/GLI6BqEk9bWCsLLOmywjLUq6JfIzC5eEOoJOLG2c7uxDEn7o+F9w4W1Kg8
	Bt9mryMT/BFFHFQWuVQugWKfkNwQ
X-Received: by 2002:a05:620a:2614:b0:93c:e83:6ba4 with SMTP id af79cd13be357-93c43cfd3cdmr614934485a.25.1790361733951;
        Fri, 25 Sep 2026 11:42:13 -0700 (PDT)
X-Received: by 2002:a05:620a:2614:b0:93c:e83:6ba4 with SMTP id
 af79cd13be357-93c43cfd3cdmr614930485a.25.1790361733529; Fri, 25 Sep 2026
 11:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
 <178998281449.889291.7893229102394463283.b4-ty@kernel.org>
 <CAFEp6-2P14MdYJGuH6ygRL4ZKtLnJEj=PVMx2p+b9L1RuiX1dg@mail.gmail.com> <f8815dd7-1e31-4567-8f12-1b2b1dd451f7@oss.qualcomm.com>
In-Reply-To: <f8815dd7-1e31-4567-8f12-1b2b1dd451f7@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 20:42:01 +0200
X-Gm-Features: AclHuK9eWyYSXO1LoWJtwtSLZuLm-A6-I11eiFIWKFJB95hJR5ZP3c6jJQ_Yo60
Message-ID: <CAFEp6-074kS9GO2TFcR69fMjuu7Y2Os68CzWs-KUfmZDYaPZ-g@mail.gmail.com>
Subject: Re: (subset) [PATCH v10 00/10] Support for block device NVMEM providers
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ulf Hansson <ulfh@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX5dwBcld+Fi/G
 kdmLEGuPPEh7f8DLzPzk41XykHo5/slCTyEqc1JsZjrKuooqQ4Toy8v0np978Z5W2YHw9f4v1zE
 c6e4jUByyKPgxQbVqiT85qwmzgp7TLIhYBoSBqvivO0Gw4/aHrNXyG8f3Pd5ohrfECDNDcidN+D
 Jij+6QH6z83I4kDIU8KD+qjDslCR8FmwK7zPz/K1HqzQ9pDemH9Z3KcKWwPhbW93w1kysZmPoan
 4MKKu6ZhaYRo8FC83kpUIE4KNWJIP7bo8Vn6XJns0rGaCMDoqlocAuyQAUijUUynjYqaEU4B0Zf
 lLBJI4m0PphbfwiZkEELQPRAyMf20U172PWlAbwyjUwL8pBILsppA0IduHEod0Sl+ro++SjKiNr
 NE551fytt5Yfgsu3GMfD2MzxhcB1SXBFiIGZZVYtKo1QaAXbOI0ir0I8nhHPZ9qNnGcWeK8o36A
 EtkJLl7exW5Xg/yr9Fw==
X-Proofpoint-ORIG-GUID: Q0_AymDT-kq5QGFPsjQueVw8Djx5kjLc
X-Authority-Analysis: v=2.4 cv=EoRHPicA c=1 sm=1 tr=0 ts=6ab6c086 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=8pm97rweiJCjLsilNG8A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfXyHa7wxaVVRUw
 JcgMjim/1oPzj7kkZ+UdbdLtbCRQXQAS4Lz0bROwDq3D7TTDAR7Nn6N+1ewmhqFvayZRzotJpIf
 Kq9VsJFdOgeibbiJ1YHIoaU2fLIWZwU=
X-Proofpoint-GUID: Q0_AymDT-kq5QGFPsjQueVw8Djx5kjLc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250074

Hi Jeff,

On Fri, Sep 25, 2026 at 4:10=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 9/25/2026 6:38 AM, Loic Poulain wrote:
> > Hi Jens, Luiz,
> >
> > On Mon, Sep 21, 2026 at 11:27=E2=80=AFAM Srinivas Kandagatla <srini@ker=
nel.org> wrote:
> >>
> >>
> >> On Thu, 06 Aug 2026 16:38:33 +0200, Loic Poulain wrote:
> >>> On embedded devices, it is common for factory provisioning to store
> >>> device-specific information, such as Ethernet or WiFi MAC addresses,
> >>> in a dedicated area of an eMMC partition. This avoids the need for
> >>> and additional EEPROM/OTP and leverages the persistence of eMMC.
> >>>
> >>> One example is the Arduino UNO-Q, where the WiFi MAC address and the
> >>> Bluetooth Device address are stored in the eMMC Boot1 partition.
> >>>
> >>> [...]
> >>
> >> Applied, thanks!
> >>
> >> [04/10] nvmem: layouts: Support fixed-layout as the nvmem device node =
itself
> >>         commit: 9c6cab93dcd47c3075d896c777567b9d8f813d18
> >
> > If you're happy with the current state, would you mind picking up the
> > block-related and Bluetooth-related patches in the respective trees?
> > They are independent.
> Should I take the following, or someone else?
> [PATCH v10 02/10] dt-bindings: net: wireless: qcom,ath10k: Document NVMEM=
 cells

Yes, it would be great if you could take it. It=E2=80=99s mainly about addi=
ng
the possibility to source a few device-specific values, such as the
MAC address and calibration data, from the NVMEM area, regardless of
the backend, so no dependencies. Moreover, the ath10k driver already
supports those NVMEM cells.

Thanks,
Loic
