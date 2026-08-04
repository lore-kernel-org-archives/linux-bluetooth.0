Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45810466B66
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850993; cv=pass; b=To1k4ebNJAaS0bSAagD78oRCmz19cLOIPPWlDIvdekN4PkdE08O8elLYP4whLTf0z59Tn4XRurCHWryUoZGJ3iU6wMMwr5+Sj/jbG8nxKUgFEYWNt0tEu4a2/tOTSzzrXmlMvXt9NSB4tKGAMJgIRFKlbzLsip9pGMEZgD33Vrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850993; c=relaxed/simple;
	bh=Av355PoOiQqfN+lI28kxuagN2wHx9snA+0ylF3eg6GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaF84cL+wIhlS8x4l0LuEwBKwxePkvqghxcs34ovFd0c9JdBKFVvUVP/PkMENOiegQYZVDXq6OPq+K8GkfQ5q0wJuBV0gwPzmIQMP8+vTjge2xsZ1109IrHoiHv2NeC+Ih+wGAS15LXFCZHWulHOMFJWz6zXihXUjJEvcfTbr50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gWSqX4An; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MZQslKWR; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gWSqX4An";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MZQslKWR"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CXNxC185492
	for <linux-bluetooth@vger.kernel.org>; Tue, 4 Aug 2026 13:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QWQr/x5bEL6Unr8s/2mTIOitfI4p3mr1jrf6Pl+pGJk=; b=gWSqX4AnlEtpxj6Q
	Kolx19zNihtI79jb/u5x93/3RIRF/ynzmhH52E2pAWDlIG40klO9F3WYrDnNecrA
	Mvfb6nxJuTNXh4JIR0ajkI+lba7CtsfsM09qOuD/mdptyX0Fkf+w5a8+m+IWObVr
	aoTJeUXIt42+xRXjKmsCzTEjliHe6lqAV/6HQxo0H/0HTZTXYesd8+gx2QHlfItC
	Uew28HCg6lftgQb+cr7Mj5MnfKzClGCf0NxQGhPFOyFFZNWAElTdp0VHyA92Nsf9
	Dys7phUWfnLavtU7rZNonD8m8pk88xbX8sSZjkD/5YryOFt+sg1FIwW31MLvK0VZ
	D6JX7g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu1p4usgh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2026 13:43:11 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ec3314f65fso45653606d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2026 06:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785850991; cv=none;
        d=google.com; s=arc-20260327;
        b=XeXkHN5ppWfyDhrIpvF4K4kNGJyrE3X44sDylulg8xvE7hluDlAX6Dp8USqbwCMUYi
         D0zbXYOgE7JDsnN7b9ht6THRnk9O5WpxZ+A8klNSPRBJ5jY0f2vj80+PL/4OYGXbOdXm
         nqZA6OUDnBEVzx3n0RztliYUPKf/2UKW2D1JMHFWubMz7P1n1qfR5Bxd2flyI2f0Sxs5
         qjKoBLTajFHdSAe8mZAZwJSwTB2EWpMQ3FmD2q/NLoplx9r5oRsZfa1cGhCnv9HBLljn
         qVPe36q9ZSuuJRpnAVNZqUXNRn/X4m7bO3+SUw0iucY5FXrmxWM+N2EpABXXkmE0qY6x
         lUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QWQr/x5bEL6Unr8s/2mTIOitfI4p3mr1jrf6Pl+pGJk=;
        fh=+BkbG32XL+rAKPP0bL9T9tPjAN4zoYeyB5Fu7H7TBAk=;
        b=Z6VGH4lbYB5N7WhMRYIUJ38Vh60wo7E9gXs0Tnbqpa5+2bDK8xYzPHcYnyNngowZC4
         3CsLXn5Ijf5GijLOsVrs5vIhB8M5593+pE4et9AaTlZ/FkIOigomBe1oaDrFSRPOR/7U
         8W0Tni4aecUlWAZxyjdluHQLqNj71bZLlhKbVDIIo6DMqVgDCpjJYvXomKO5NfaKmcMQ
         jn8MWWqFF1u+aEytGc2k7AX8SwLj/CS1nng/+Tg0xVOO/Wordtuk8R+FhuwFtyKfqPkm
         aFhuyHt8n74iaU7HL5q78gbhFY1mLm99AT3lcLKwmG70W7JJZ+erkZZKKFcrQINduUHz
         GGdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785850991; x=1786455791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QWQr/x5bEL6Unr8s/2mTIOitfI4p3mr1jrf6Pl+pGJk=;
        b=MZQslKWRcv5ULJPy3/9e0Lr8QrlZmnZ/9XLbE5GYSOpr9wLEcalSBa5ZNL4BIhEefb
         gWKkEnCAMLbRmGlXOpWJMsMNL7jRTkfgr5nThaNruYZMrlDJMpQNM83N2booE4iAe1kN
         MkJclyw6s6J5dLh5T52wa5pfRw/I2pyULfgYuaUJRsd8mVBZ96PD+UET11TaevicIFQO
         /Dk7CiIUDFgM5yCdnH0g4H7rW8oUbX0f87LE7rSngW83OuFgXnncn3Alfpdte25tCJey
         1SWe2f2SDYL1xy4JBe2zvFqgW+vcZgbwsXF9A4/payzciquWTs+KfNdc4msTGe2mKVoY
         DkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785850991; x=1786455791;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QWQr/x5bEL6Unr8s/2mTIOitfI4p3mr1jrf6Pl+pGJk=;
        b=CfM0BGVWdlxpifZDEY1AQbNM354uHnkLxBxzd7VPzggdGELB//Qoa/P4xPvwg3uN+O
         osg8yjl/eRvC1OSaAW9wnC3IEMzYlPucbP3GEfim8AsCl1kFcj9NY1/Aj9Ku/RI31VyF
         D43Uv4s8RxPmFDw55ZhVk9tnFuMoa1MK4IvQtaGAtcfwpYhIzlRe4kLIEYs0RDD7bU7L
         NdzM1VE6iEvtp/WbLw4DUurQ2qvbjBrTqqkQMKZckwieo0K8EMqXaV8OV8i1Fwuqgtrn
         IbTfVJULdSNbhcPRWCTZrU412PPmmlHNdDOxvG+Ow3iMmxfLEg++sG60CN6F1tVuzUsd
         0bcw==
X-Forwarded-Encrypted: i=1; AHgh+RqbGYZrFC1cqDwenifmydzr45kVQTXsdZFrCCpSqKI9ftRdjX74oUPbZsTaMoxn+rzGOGY6/6a9WWRpdwLgoCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdOVctB48DgwJQ2RZHp8N82VEVLX8pQeQzuMKNPiRuYrcon32A
	LI39pcMYMYiIEqiAw6s4trv9ZNrleIjRl2HGPeL1akV8IVMGVPNByI+u4C6rGPvlNhlu3KBRAJc
	WsK5/B1CrF9Br8LMloj71GY6kwDeX37rq9eU2r1a39Y6WViLBwDdZKQ5X0VUK99oJr4D/le5e8g
	pyxgeG2XQ7H+pOLyFSa3ZbJ6JxsAG6jTESa0CLekelhAZ6ZQ==
X-Gm-Gg: AR+sD11YzGdl7rb2LQSli+fehGql4n3odK8TghkXsHanL+orS0nmlKiQowWNxk49c1r
	Kpijieb3WRCgJpv+ywp5V1VmGReeVOoM6GAfWsp2Ynva99QRiLLlZjH/HmdO4o3i5Bh3D4chtsB
	H6p5gUjf7SU9hFDccwzEN4SmwNc/1qm/Nh6NWBwqbSagytA2w1KAaULu1zIg==
X-Received: by 2002:a05:6214:20e5:b0:8f3:ba0f:e7b9 with SMTP id 6a1803df08f44-90849603117mr235603246d6.18.1785850990516;
        Tue, 04 Aug 2026 06:43:10 -0700 (PDT)
X-Received: by 2002:a05:6214:20e5:b0:8f3:ba0f:e7b9 with SMTP id
 6a1803df08f44-90849603117mr235602546d6.18.1785850990119; Tue, 04 Aug 2026
 06:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com> <20260730-block-as-nvmem-v9-1-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-1-f72935817dbf@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:42:57 +0200
X-Gm-Features: AUfX_mzk0wJt2Gak_njsh0rcAEI1svN-3axItB8B6ASWCCxtH7hxRBo8wnhVM-8
Message-ID: <CAPx+jO8rMUaw7MAYpfp4cLASZ75mfFD4n3NOi2wdHNVvnb4rbw@mail.gmail.com>
Subject: Re: [PATCH v9 01/10] dt-bindings: mmc: Document fixed-layout NVMEM
 provider support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=auOCzyZV c=1 sm=1 tr=0 ts=6a71ec6f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=F73tXhIjRpzWiH7OJSEA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: kwWWa7i8tUC42ChOvvaMmelJRD_pbfou
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX87FNLPJs9c0g
 M1W9znUhbGIL3LroVEbRD7TRX9+KOVrB0KInaKld7/zvOdD+FM8WAydOSVWIAN1PizulK7aHzQj
 JEWHb7prMaEZ9z+bYRjuPp36YfL0C1k=
X-Proofpoint-GUID: kwWWa7i8tUC42ChOvvaMmelJRD_pbfou
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX/dqPvbsjZrlT
 7NKLnKjEndXjn7ZK+S1mMPNPAxaA10TQ8VPQQnVtCPaOTElk5/ooBdUbzXYGK1rtlrb8QkxLeCX
 +gm7ribpRpv1sh4sfUi9YqaWJqkDezdYy0+UW+6F41vRhlPR7kXAkC1JRPsH5KP0htSQksjPxdN
 /mRtR0QGE1CmRl6wZp3jUqHLyRwBZesvfARutEHHEUrLPi/hXC+JAvAnEEmse3CxqoS1j3HQvwC
 27mfrErssjeAHXMzR1dfR9XgPAroMZ6sl3Wq8d7GgamiBVoXjjE8Nyw11xZQDAj8N09RwF2lYBA
 i2oSBZ5iZzJwlh0VY79X/8+P8ihTZgJek3Qs/Y1sV0jg1PgYIZK6A/Mcp6rb2MDhDo9m/6CSa6p
 eVvDvAR86oSn1DaYKZidMPlMzEQpzzgLr87xooae4o3/nA+yN0IVwCPYKhfmStPV5I9QwJvLMdz
 R6fLZvJsHimEI1XZw8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040110

On Thu, Jul 30, 2026 at 6:00=E2=80=AFPM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> Allow an eMMC hardware partition node to describe an NVMEM layout so the
> partition can be exposed as an NVMEM provider. This lets a partition
> (e.g. an eMMC boot partition) store device-specific information such as a
> WiFi MAC address or a Bluetooth BD address and reference it through NVMEM
> cells.
>
> Accept "fixed-layout" as the partition node compatible, in addition to
> "fixed-partitions", so the layout can be described directly on the
> partition node.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

I don't think there is any reason to push this any further, the
updated mmc binding is ready to go. So, applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/mmc-card.yaml          | 23 ++++++++++++++++=
+++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Docume=
ntation/devicetree/bindings/mmc/mmc-card.yaml
> index a61d6c96df759102f9c1fbfd548b026a77921cae..0422894508478c8d0ca68292b=
58a5fdbee218358 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> @@ -38,7 +38,9 @@ patternProperties:
>      properties:
>        compatible:
>          contains:
> -          const: fixed-partitions
> +          enum:
> +            - fixed-partitions
> +            - fixed-layout
>
>  required:
>    - compatible
> @@ -86,6 +88,25 @@ examples:
>                      read-only;
>                  };
>              };
> +
> +            partitions-boot2 {
> +                compatible =3D "fixed-layout";
> +
> +                #address-cells =3D <1>;
> +                #size-cells =3D <1>;
> +
> +                mac-addr@4400 {
> +                    compatible =3D "mac-base";
> +                    reg =3D <0x4400 0x6>;
> +                    #nvmem-cell-cells =3D <1>;
> +                };
> +
> +                bd-addr@5400 {
> +                    compatible =3D "mac-base";
> +                    reg =3D <0x5400 0x6>;
> +                    #nvmem-cell-cells =3D <1>;
> +                };
> +            };
>          };
>      };
>
>
> --
> 2.34.1
>
