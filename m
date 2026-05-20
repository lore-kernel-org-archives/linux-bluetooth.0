Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F2E3EAC65
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287396; cv=pass; b=AeeO98khpnKMI1A44kUPrPx5JajhCnOsRryGc/lwZ6M+s1uQS64IPMqMZyxXojUfVbEBUkT3c//BRROqV+StfnDBAILNYozQXB3YnCiosN2L97SH/CzT/KUXSWYx1cwp9924OGhpqge9/mceD3psTVgq/2lbRaRoVboxEP/tvVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287396; c=relaxed/simple;
	bh=uJ6ceiQOgOhCZfY1iBogXOpFqQfDep+SLyd7qBiSXHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RREG+ElIEy9dI6YEQJp6EoY2E0uaPcSvtV4EyHlofTNei4QCwQTMJiJB2O4Vx5fZntgbjeI5JHHQkXUdwwluM8bUZyRfSopOS5+hAd5UHUifsQeoHKzMS1htnXbWv+K718GWoF7UhrQbysoezpiRvTo0RijFacw/LwjYplwRb/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=luJfri1q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OsLs4rV4; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="luJfri1q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OsLs4rV4"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K9nQvb446597
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 14:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T6yhqpeA4WQkpL+ACLh3UlGLsTWvYvmaiBfH0Qr/04A=; b=luJfri1qCnaB0Kjj
	UWrcYoJTqlDFRc/7zTCpwCArKH9okmWvuSK2c3PJRGBpIdrHd3rUxBmvOG/DGM1N
	ZBZKzqGrmZykPnePYtJOf95m835cGrX9v3dp2ciKbJL1DYyphm/I1TcWQV1dAWKg
	SFuI9sLqPCFZpWzHKEz67xtpSqtKFXaB7KJLONUUVg6eRRxIgFO/8q5TcaGdThhN
	/BqkBeHGsbQgjjKxQ5XzXIvtn8h+OjaGx3ses14mebDDvOELLFMr1rbOi8F0UC9g
	i0E+iX+TJFBeHtkr9cSTbQCcTjHAcBuOWTeX2CE6UIyQHzsgwjSMS/3hqFD+Uclf
	F9wiNw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9anrh16j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 14:29:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-90f5248b209so1183632085a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 07:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779287393; cv=none;
        d=google.com; s=arc-20240605;
        b=iUD4IVxix7Y4xLnvtMahRNaeFwfOGHAG1UPbDTh77k0RXa3syyBjIsfjlAHahPoZ/i
         qrb4BHcMXOHNwaDAwtc9LYjMXvxUT+vtgbLlYM+5jCttLK88RV7AB7sWrBY1c7JBjDyB
         VHjwMbQTHeO66KXPgU0CW/o/tERvmQz8h+04y/VvuqNMSs3agvy+UBFvqS9ua//DKarv
         3jdqD2RZADb2U+magFD3Wi2hPpC7FvFeoLywKgtjgy5TaTQg3vTfAiZ5i3oCf29LDZMO
         DfXB1WAada1Ty7R70+VLjremmBvHUtPnbyvHViZlWxDlPHfw97yYdn3os5iAvVD0bbzC
         cOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T6yhqpeA4WQkpL+ACLh3UlGLsTWvYvmaiBfH0Qr/04A=;
        fh=+PXtjb28MbwcU+EwKBDzelej8Jf23bwH/HPYv9ZLoNw=;
        b=k/otNRmryXiIERmv3wtyj4FJNLpyW8QKscl86qEmmkpiIaZvofs16Vr3vBLuznwwV7
         pHWVdFfEWEx1kaU3RT18Qgd9J8R30iEuXD6K5lld7QAP74RRm8j0v8zxxBFcwjB3gPQh
         SMCAfl0u/hdVQBb1imf84INTKAZq9tMTHxigvJxICRV0KoKr+ceRntMO26WtoIsxhXjx
         cNxO6ibYBqZJ8SR683vOUO5+t/CJLSpmk/IZnKKVD2BQXhBvpkHMbzTHi9vcVIKPPmUo
         T9gAXlHYIQGcswlFB1i04VYF8FXY/R9YR0lU0w0fOvhpZvWx9qrvRZsMD3/2BNp9jHZj
         WlWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779287393; x=1779892193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6yhqpeA4WQkpL+ACLh3UlGLsTWvYvmaiBfH0Qr/04A=;
        b=OsLs4rV496AdoRsCxEjSxv7ldhYiiUwF0T4Dt1BANAFnOW5C8fKTAwGoMIs2Sxre8e
         PK0MOerharEiXS+SHvQgBjlilne6DUNq2ZW2aSeAoDrTUyogHNnAKXl7WuellmtS3IDZ
         M7ObPeskTWj6FlcDI7SyfkuvVI0hHxvrA4NPKkXRoN3KY3WHpAhp3QJ/56oH7D06uGNi
         Y64nRR/cyFWu+i231++xMtVgABhpHH8cDs5hnAleGnU6GHCqvkOzVDZNZVL/17/gQ/49
         Aa/7hJ307BJstxSzIkGsgXQv3JqjWHnAbhroG7Dp6tufsOfrRLV3QdDC3R5o0OjTUV1W
         peZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287393; x=1779892193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T6yhqpeA4WQkpL+ACLh3UlGLsTWvYvmaiBfH0Qr/04A=;
        b=WR7RZ0Oc1wxrsqS657z9IqHOOKV4ammG07yWGf0RViSAEz/ee4B4tkLzekgl+qm2Oe
         B+hnGRh/GjejuSB7hbeVsoc3ebphXFvO+9VXLw8GIE09R67w5CgPJhtFnqYMcl+NMF5H
         BMCUGIqHoPUQ+WWkPMTUKTknJXkkL5kjDZ0qnYnt0TTtVJ9W7t+aNuKiRXfJRQOO98nj
         LhZChvZNjlsA2vd72BF5OXxTaksb4z+4rOI+IwCc+DK4sF9e6y0QYyV+Zwfd7ZYylECc
         q7WlT9DOu8iu2wz69Vfwhi7aL/bkLjGzByFfrGM/L7jRH82iG11HHKjXVd+oBUQygD0A
         stjA==
X-Forwarded-Encrypted: i=1; AFNElJ8OtMUpQyiVIOOv6t8dpIuiRnL58Yb0xuWO1Qk26fbZ5c+XiymXMdkQj7QdpTlqD7nrdq8yhTGYIQDNz9XSHaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA0wZfPTKVUguZu+bd/mSsPwQvJd+egVUqKwXHXXI0RKMdNKU3
	SJMU1aSxqXdRo0aosfB+Q3nAi3O98De+5qGTAwWw0ceB8vR2QWvKPDkXcnqpHzWWfnPf+xmgkpW
	A8R7eDkgvJx4chxrIUOd4zpigwZM72BsQvP4Mrcytw94Onl9LU4b5N/mOCSSwcJ0dh5sDSzi68H
	Cc3amEhPGUCN1b/VoHCyrbaY1XiRDY8iIUP4xs2oScDJf8Rw==
X-Gm-Gg: Acq92OHMbPXC4uya+DSbE2YAvSWhhehWpjGdfNY5mKRaIJeEgoNhSPzU6c5LplvbjfW
	3MsKFRPwj+KbHTkhJzyDebCgaRR2jduB0UgeNo14IWSxwHv/97rc2WOwnxeR3RxxIBZsaW4r7PQ
	NcTNDV5+QZ63B26P4JVs7vMzMBSgRx1mMDhwVvI5c1qNKD4BxKXrr8uHZnJWj7PqXTetUQIsTxG
	mjEQW5kXttOjP7/igVvfI5DO6hBZKn1xiaAkD4=
X-Received: by 2002:a05:620a:2890:b0:910:c78d:12ef with SMTP id af79cd13be357-911cf3f7626mr3622213985a.38.1779287392538;
        Wed, 20 May 2026 07:29:52 -0700 (PDT)
X-Received: by 2002:a05:620a:2890:b0:910:c78d:12ef with SMTP id
 af79cd13be357-911cf3f7626mr3622205485a.38.1779287391929; Wed, 20 May 2026
 07:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-3-9f6942310653@oss.qualcomm.com> <jetl37zsfcs5kl4b7iarbngrdu4ebp7ag2cvpqvkku6tbl6r5n@qozh6n5fq7f3>
In-Reply-To: <jetl37zsfcs5kl4b7iarbngrdu4ebp7ag2cvpqvkku6tbl6r5n@qozh6n5fq7f3>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 20 May 2026 16:29:40 +0200
X-Gm-Features: AVHnY4L4rWNphXQmeHCOQKyuxZcVbSpk2c2jukIzCXfC1OBduPiOmLNzgTemvps
Message-ID: <CAFEp6-0A=LrU44pu2rfUqXW9k9peSu=b2qq_FVs4WZUj-g4pDA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: monaco-arduino-monza: Add QCA2066
 M.2 WiFi/BT support
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
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: SeyT0mSGGR5rY4lA1z8vdrU8zcx4juji
X-Proofpoint-ORIG-GUID: SeyT0mSGGR5rY4lA1z8vdrU8zcx4juji
X-Authority-Analysis: v=2.4 cv=UuJT8ewB c=1 sm=1 tr=0 ts=6a0dc561 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=ncdiEfFe64kH1Y8Ome4A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0MSBTYWx0ZWRfX3q55xWLWnmZ6
 4tjB4r+ru9jwnrsM+RXx+fO8ipk2u8dJofzYqXgNsw2S4LHzZgAicaM3mXozHU45bK267Pmxt1d
 jFhUzFC7MCgDuM6NOBWp3jSELaDBIpwzvU1werturTYTsDmZZPCpp/vQMwphM6mWdJ1LCy4migv
 0JB9dnoXb3/MX/DhC37qQdVqTbnnAAkh8v5gXNx7bEk3IhUdBqO8HrRh6ANwZ9o5RSZNHA7tm2r
 KMZFj9rLf87AJJO9TtRqX4/BcZBWkTYy4BQGPMbD0/VRfKUqMYs7jIJRUS2ZaDbOIE7VAyWF+m+
 HH33ZjkCdglgUqKpZE9Zpm0euB1N7VLn1SfzJOpd2B9KGvv28LNmuK8n7OgEQAIKHcxrM9tk474
 8QcptKVRLoZV3FSHI2i6Xw6vKE/Uq2JmzjIBS2c4txOBy9mQt8HmwhTgEFvldB6ZYzL17Z53uXg
 u58NWWfgZNKQ4Jav6CQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200141

On Wed, May 20, 2026 at 2:34=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Wed, May 20, 2026 at 01:01:44PM +0200, Loic Poulain wrote:
> > Add support for the QCA2066 (QCNFA765) WiFi/Bluetooth module on the
> > Arduino VENTUNO Q board. The module is interfaced via LGA and is
> > compatible with the M.2 Key E.
> >
> > Add wireless-lga-connector node using pcie-m2-e-connector binding,
> > connecting PCIe port 0 to the WiFi interface and UART10 port 3 to
> > the Bluetooth interface.
> >
> > Add pcie@1,0 downstream port node with pciclass,0604 compatible so
> > the pci-pwrctrl driver can acquire the power sequencer and enable
> > the M.2 slot before PCIe enumeration.
> >
> > Add nfa725b_default_state pinctrl for the W_DISABLE1/2 GPIOs
> > (gpio56/gpio55) used by the power sequencer.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 65 +++++++++++++++=
++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/a=
rm64/boot/dts/qcom/monaco-arduino-monza.dts
> > index 93ed575817af1c5e903662c209ead629fe202ee2..6fcad77f320cb82eccb6f07=
244d185abfb1976d9 100644
> > --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> > @@ -154,6 +154,39 @@ vreg_nvme: regulator-3p3-m2 {
> >               enable-active-high;
> >               startup-delay-us =3D <20000>;
> >       };
> > +
> > +     wireless-lga-connector {
> > +             compatible =3D "pcie-m2-e-connector";
>
> I think it was discussed that LGA can't be an actual M.2 E-key
> connector.

I am not sure I followed this discussion. Do you mean that I should
introduce a dedicated LGA/vendor-compatible string in the compatible
list of the pcie-m2-e-connector binding, or that LGA-based designs
should not be described using the pcie-m2-e-connector binding (graph
representation)?


>
> > +             vpcie3v3-supply =3D <&vdc_3v3>;
> > +             vpcie1v8-supply =3D <&vdc_1v8>;
> > +             w-disable1-gpios =3D <&tlmm 56 GPIO_ACTIVE_LOW>;
> > +             w-disable2-gpios =3D <&tlmm 55 GPIO_ACTIVE_LOW>;
> > +             pinctrl-0 =3D <&nfa725b_default_state>;
> > +             pinctrl-names =3D "default";
> > +
>
> --
> With best wishes
> Dmitry
