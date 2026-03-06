Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6A37C0E5
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792889; cv=pass; b=rz4vaMSsrqBegn1K0ZJduRXF3hcBcPj8c9HFjWVY8M8u8t7zXtbQJWVZmbJJLl/Ci8EDa40cZD1Z85DM5M0mWGi2qw0YNTNOPKEvoeUUJPX20nnJejROcQ6NTnhnIeNsmM8wJgQnPIwoh0b9vXYciX4RcAZ7RS+pUePFMxs8pkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792889; c=relaxed/simple;
	bh=tdvWNHoSdu2Iafp7/mrEBG/G+46fyd5oPjPg3sfvUEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCtd5ujnQ41Ow8Sel+UpOzxnIIKs7tFKAdtrURdRt2GyFUu6JSKh78WL7kjTPIPaOECMtk/D9Hk84brfKtF+xUiwzOcYZqUcCaPgeE73q07uTT5DxO/sXJwMx3UqDyfc6fVBU9Mdv/w7cJtYG7KkHSON0fn4n2zcuqyt43ftHe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YZNrFYMs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZwivZVDt; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YZNrFYMs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZwivZVDt"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264aFQG265112
	for <linux-bluetooth@vger.kernel.org>; Fri, 6 Mar 2026 10:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y9h7Pr+7iqUr+8V1CASot1k/T1Bc+EXpK2ZcBTLqhM0=; b=YZNrFYMsk/Fkkusp
	mx2tkNw7vXOuadXBQCGBDBUTlnpr4NZWNentC4QFbcG5JFgpAt1ePFONSVn3deL1
	du6XPuHnmNjRjKozn+7yp1KVO4GZaLcJhVStbKqzhRv6jX3CKxlmllys+4Hzatey
	JliSi8fTmWxnYIg9oOT7O3uCq0cv5Jri9G5kxjq3+xcNYylT8JoAnL+RjcsKgw16
	/Run8SLGv4x8IrgXOw/d+NvubpqD7qO6zmjgcukTczcfqrv9Zw8Q9k2STjZkcRnt
	HWfPzwo+IOH3e4ul5BaL3HOs5xN+3QhnD3tMo+cIdjqsEqso8ZuPjOWrhJrKndmA
	3Yz0vw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqdvku6x7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2026 10:28:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb4a241582so4629961985a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2026 02:28:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772792885; cv=none;
        d=google.com; s=arc-20240605;
        b=MQiwzA9i54bC+SndYQ4Cf2nwHnACxyAlgJ864Iw19S4NKBDGzO9FygwLAqVrmWn+fd
         Qc4+1IZMuzflnCkMZ5GPBnO6fk4EKjOGyLO8kcrW+L/4G9Iio78KP/2E8wQIidq4Mjc7
         cAgp98JZbEuWki1dXzzQYxcHzENZRST9gi5F3Cbpgod6HQ82j92Ig7+dWdJ7n0EnX02T
         LrseF/poDAWevXLY4q1vjVjyyd32XWZqqfBN4n1+4fuseHrRtAhq4kT2zo8Q3wMkG1kZ
         ekjaFATT13oLV/HRoeGrkO3U2hRgwpFgGizgeRMP5tFvT7Y5luxcYC+wEJQjGiO3d32F
         CMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y9h7Pr+7iqUr+8V1CASot1k/T1Bc+EXpK2ZcBTLqhM0=;
        fh=E2bmVfeiCn1BVUu8F0igj0fJaO5kPbPGkj6dCf8DbCg=;
        b=ji38jE75YErapL3f6DcToUbxvjxXdc2xEVtmVInvoMK6vXuCtK3fmjmK1+RmL7utpC
         rqxYN3rLNQBgo9ldTYPLOMGRPSrpKaCkm0KTZ0Q/SPbEfKXYv0+QuMPVwhY7K31abOZd
         EQ644XRbUjyFphdWqLcBePmOpYR53JkeEHvpegrwQx34fRFcjIKxsQVnbuhyuWGp7d0J
         QM50xz+FN2xki7Qdnu1YTmHP8HC9Rtnd4tM9Y8x8FB3wlpo7lmBehdjbHkKakwpQsN1t
         thLzfVnV1fhJgv1gw/72lJJRd3+Ih6e7uqXgHxYP+jS04JlYCsljD4xz8g2k9amN6n6B
         LLtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772792885; x=1773397685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9h7Pr+7iqUr+8V1CASot1k/T1Bc+EXpK2ZcBTLqhM0=;
        b=ZwivZVDtbsWU/w8SoRcOCkZQ17h+GAfpi7mAEOZrgCFR7mbSQXetIjRIpWcXZbcQXx
         AqH8KHNfiBH4FMALrRqOmI3gWXZIN1vZ6+9l8vpknH0Q45kEsncxQLswJ/qFThba8KwS
         o4XR9GnnvcJXasjT7v+cns/MJm8hTIZLvxu3pkzAYBgbSFmEyqjFWg89kBcPI8wSQjcw
         y3qEJE7lhg4LSNoQikIklx9FQm6ZiFYC7uh++TAvpVlXFTZ3wS0MTp/goLD/o1fKisjF
         QSTWArRoSpBGU3SPHzwmBxD1TQUUyIAM1CHO+JQ4rMrViyx2D35JgAKYcO/LModEJGo3
         yYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772792885; x=1773397685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y9h7Pr+7iqUr+8V1CASot1k/T1Bc+EXpK2ZcBTLqhM0=;
        b=H2cxyR8Faj9pu04nsIxGe4VuKD7phWdia46NKmwoddA+8J19dqfTIkVpXFa53TcSoF
         Umu9ur+G4Ud82KXMzSX/N/6DfcjDLKPk5xMIftMoGuiMe8bT2YDZ2FtaaYyCjm0hiKaI
         B9FNep4dWcknR3HPAVR8uTM+Jj3BquBR+ce4C6uvQ52d4Sf2+cdYacgLe6RqYjVnEZRP
         1aQWQ68IsR8OpFsupUw1DkrWv/jwIZKcDgJF34gkpp6iZMDcjC/6El40Yq0zoXaYkoSs
         No8jWDfhu68385bhx5eOaZ/YVCUyvbiBWv5NZb0v12zhspmqbpxiOLhj0m2u66T2sadu
         RtbA==
X-Forwarded-Encrypted: i=1; AJvYcCVTKxAk6ei0XAt4CiREsNYM6SSCgZIUzfGeP6qil6YoimOqbayEmRP0dELPk6mnLwK7S/y/VbEAGTyhZzyI1N8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+5SRnqULl0EOr26DOodTMkT9RyNOTAnIxWSmLdtjdMm2hgUf
	CwEl2INU8Z0F/tnkUU9a2ihlbb5mKiczXFu1447bCmqre0Go2kLtUktJGIoYkA9wC6CXiLAzF9O
	Gt4RNBEALHySPskbN2EGrtazCvNtZnL798WQ4ih5v+KAUB4q4bA8QZGRR3lyyCkA/8mhSdFl+eB
	KFrpv5ziVvHdVk88T6EDs9XKIYFtouNrXMgU8NlOm+Q+HCag==
X-Gm-Gg: ATEYQzyKIWUeRWc+PT/723qHfZLKOPjJEr6Yl0N5Bc+RwqsfI9dLa2pYV1O6HW8XBsL
	D84DDXu2TChtXH6IojTQlUOvM6QUBpBvE2LvCfJ/laguuRbtBy9P7j2ttw1avmmBWL8hWb7ltkz
	BenkJoUD0RPV1WqXIRdfaCUOlfyODaD+1pS8LOw0NdyGMNC2eAuuesRjKKgnniJpK44AbwGxz3X
	2hF+fJH9cgoymoR26w7UKzg0ytD9bLzrvPqMG4=
X-Received: by 2002:a05:620a:25cb:b0:8c5:2f36:660f with SMTP id af79cd13be357-8cd6d4afe58mr161743585a.78.1772792885466;
        Fri, 06 Mar 2026 02:28:05 -0800 (PST)
X-Received: by 2002:a05:620a:25cb:b0:8c5:2f36:660f with SMTP id
 af79cd13be357-8cd6d4afe58mr161739885a.78.1772792884906; Fri, 06 Mar 2026
 02:28:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com> <20260224-pci-m2-e-v5-5-dd9b9501d33c@oss.qualcomm.com>
In-Reply-To: <20260224-pci-m2-e-v5-5-dd9b9501d33c@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 11:27:53 +0100
X-Gm-Features: AaiRm53iYOytG8xnHxV8VVUSUeAKgAc5EavTdm2RyqP-mIqV3qUo5jYkbTQaMc4
Message-ID: <CAFEp6-02wcaEYr5BJvqMgtMD6vArLghvw+Lh-YE+OLXyZa-i6Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key E connector
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas.schier@linux.dev>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-acpi@vger.kernel.org,
        Hans de Goede <johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=M7xA6iws c=1 sm=1 tr=0 ts=69aaac36 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Aq5ih5MREXdaAn1MBKMA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA5OSBTYWx0ZWRfX01eyhPGaZ0gm
 UC56obR+ezthcT6i2O1GivLfstb+g1Aucre9AfJxCSPb/n+/kVAc1IX8xS0aH/p8+8CeY5+OTZu
 5ELS61IdtHP4B+qSB+FwJyNnNVpoo5IZ3ipKr9cESm8DF6ONpHE3QqsgHs6xBQ+JYZNLahPIqI8
 fGox95fzrA7zj367n0Ee1ayGmORcKV/cpJQ0iY7ZHTwyxfxDPiwMN1qmhxEh9+xJQm2vsSMSlr9
 7Vo4nDATGZOLCNEOa0da2zAcBzLl8CK/lYu1Ek1TKRCRFlwcFaydGGTYZuzkI9qQrvhQrkNBleJ
 ZqsJbNRcio3jdsJ8C9f+8ldomzJRp1uiEcl8UNZz6K1MFJ7kdve2hRMYzP944pH760/UPKcFSri
 We1vbAiR2eRZtfwPQZ09CbCPkEITMSmAoCkRY7JIjriI7Rnk6oCamq85ta/L58GU9lugP7hK4rb
 hD9Y8In2w9joP28Bn+g==
X-Proofpoint-GUID: YTSD3Il5eP7n9zCvSA_FK-6NEE6ejWSL
X-Proofpoint-ORIG-GUID: YTSD3Il5eP7n9zCvSA_FK-6NEE6ejWSL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060099

On Tue, Feb 24, 2026 at 6:32=E2=80=AFAM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Add the devicetree binding for PCIe M.2 Mechanical Key E connector define=
d
> in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> provides interfaces like PCIe or SDIO to attach the WiFi devices to the
> host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> devices. Spec also provides an optional interface to connect the UIM card=
,
> but that is not covered in this binding.
>
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating a=
t
> 1.8v sideband signaling.
>
> The connector also supplies optional signals in the form of GPIOs for fin=
e
> grained power management.
>
> Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14=
s gen6 (arm64)
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  .../bindings/connector/pcie-m2-e-connector.yaml    | 184 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 185 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connec=
tor.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.=
yaml
> new file mode 100644
> index 000000000000..82dfd776d480
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yam=
l
> @@ -0,0 +1,184 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-e-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key E Connector
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 E connector node represents a physical PCIe M.2 Mechanical =
Key E
> +  connector. Mechanical Key E connectors are used to connect Wireless
> +  Connectivity devices including combinations of Wi-Fi, BT, NFC to the h=
ost
> +  machine over interfaces like PCIe/SDIO, USB/UART+PCM, and I2C.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-e-connector
> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator for 3.3v supply.
> +
> +  vpcie1v8-supply:
> +    description: A phandle to the regulator for VIO 1.8v supply.
> +
> +  i2c-parent:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: I2C interface
> +
> +  clocks:
> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host s=
ystem to
> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.1=
2.1 for
> +      more details.
> +    maxItems: 1
> +
> +  w-disable1-gpios:
> +    description: GPIO output to W_DISABLE1# signal. This signal is used =
by the
> +      host system to disable WiFi radio in the M.2 card. Refer, PCI Expr=
ess M.2
> +      Specification r4.0, sec 3.1.12.3 for more details.
> +    maxItems: 1
> +
> +  w-disable2-gpios:
> +    description: GPIO output to W_DISABLE2# signal. This signal is used =
by the
> +      host system to disable WiFi radio in the M.2 card. Refer, PCI Expr=
ess M.2
> +      Specification r4.0, sec 3.1.12.3 for more details.

Just a small nit: according to the spec, W_DISABLE1# is intended for Wi=E2=
=80=91Fi,
while W_DISABLE2# is designated for Bluetooth (Key E).

Regards,
Loic
