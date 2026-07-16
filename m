Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7B7431A2F
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212896; cv=pass; b=Vl9Bv6Q8trj+FFi58giP/A2Q7NfLsR/5g5flC+swqOLw5nRiVQtZnqaCrZbIK7J3F7OaM6oTIzCtj8Xzv9L0injGXQCVYJCWZFENdjm7Q7prXUkNRcc+B6mpX6qu//fY9qccEGPeuBi0Ss7FmvSk2t9q/uEaogsSWO8nHrIy1S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212896; c=relaxed/simple;
	bh=hyj3UnvN1eL7blZIruI+pgZz/uFUOhtMU/v3/gNCvNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5y85SayMIubCO/cgMypsGxSeGwPTAyzLwGlpy0CF3U0me6coSiesYQmRrc94Bj+uB7wX8VscWdgGrS0YbqPinyAQBj4amQOwiJpMuE8BC67A/kKY8i9HCgAoSwwRQLhXxMlXkLlJrvT7p2+ZHcj22BBXbd29OQjTVsTdX3HQlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fq32eMEn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wmm9WxTd; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fq32eMEn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wmm9WxTd"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJnh82837994
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 14:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uUqxKURSoOVb/5L3BwAiJscutjj+pBqwPiIBk2WAZMY=; b=fq32eMEnkSDXCyNI
	O+OEn+jRvMsMTtmNa8m8gqiLuPqA2oGtOQ7mvg4N+hT3NzUjClAuV6CScNuA0TdU
	9GlVijnYeCmS/lYORwfduWOa0mCSQ+XTxd/KZlJ8EhYxOkHk6phRqtYkMugLqSw9
	LPoSTjBDF7DYXdaOBt0fVBPki4cWKimQd3lNASYCEUJMmPcX1dmXxHTBL3kvRqRz
	DNlTd2tZzOkZbFCDvgIIP/2gbXc0oRYzq50cXSc1YrpWpOcmTFyfH1eZGNskfRxV
	8i8Jt7O1K68TUzD3qb/YC2zQSc+00matnHCWmrWfkio3K8+oRzkTlrx3cBJalygz
	NfxUlg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feefqmer8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 14:41:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e5fc4c7e9so404087185a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 07:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784212893; cv=none;
        d=google.com; s=arc-20260327;
        b=fpEquaq94CayunFzD8OzMuK6Nzbo3Kte+Cq7JqPZ1NhJ87uauBLgLfCTJlHuIRfZYa
         eY9TcdSyHLv0UFJ8zQQ/3mF3NY7faQcv5B17xibkFquXnIvU1y44khwPRNPSWRkAzUYA
         G6+46+cdiFW7DAei3l9h68rJjlTP+T0cruzv66kclWPrjlEN+uOFsxQlfVIdBwqtqGai
         1OW0OAFVX/b/IXfllU7NLey7IVSaVy1ghYvgtNpxWzHDJcQ5L2PozP8aUuWRez2g0aPf
         saEakJxuRJMXzlzVrP8g3DXH3SvWrdKiOsFqKyaaP0LRadZlgvBmSWRILu71/dYxytSa
         5gHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uUqxKURSoOVb/5L3BwAiJscutjj+pBqwPiIBk2WAZMY=;
        fh=B603vqJiNL6C3M7a9L1tDnm0xfepNGuoR7s4WZctUus=;
        b=rGHre6iLINBrpcYj3FAVTXy7x41F7tAo9rA08jFNZj9FpB9JKnZurpPf+pv8Dkr5yR
         qrRN0hbpg5Kqp2GiKg0YXeBxpind7P8CnkM7EnWNPO+xBwzS4yjJgcHEMdy/zKDl5dCq
         WJ0Z3okfKcjbmngn8rRYlf002TnA8NU9A9llZI1nzIUqdwMqrrHvhptvsUbuCwrfJnuM
         oFX/WKIWDUo3LM9NdL6GaCRMb0qk0i4ho+AZH+w1PLj4vzMm3o7IS6E2cfNgmmHg73L4
         CppiNgEyF5qHYIEV8m14yITo8akcWQQpU0izprgC6Gfz34Inu61lCsCINImY1ElRp0cp
         Dc2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784212893; x=1784817693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uUqxKURSoOVb/5L3BwAiJscutjj+pBqwPiIBk2WAZMY=;
        b=Wmm9WxTd8EUWtvr9KorvXD8wLWoCKYO9rNJTzlbdqec0HlUIF/9ESodj86I4hapIaL
         LFepfgInSYfl+u4JLXVnt2Lf6K3y5TB4PbFdV5ES0Cq7eYmPk4VoCIXZ5nt4fkfvGpHf
         Wi+6HpC0hFDzz2BUTte3h8SatKbHfITuUNOF6pzvhEujIMLRvqJrtaxW2H3zuJx6wMUf
         hWe9IjyzbBEu3aNM6aaqDtX9foQvWOxXvbsVPYPL0w5n2xp0f2ISQijkWtN4V1ae5x9O
         O1W+HADEVks7SY3gjOioq6g+jpLbVyRAQtWYEHu230Hkj22/heWUYp+vcH7BnHDjFTF8
         i8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212893; x=1784817693;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uUqxKURSoOVb/5L3BwAiJscutjj+pBqwPiIBk2WAZMY=;
        b=TvI38JZo66oX1ogyAoJ2tlV5ywL6NVsyPQPRRhRVSk43Rl+g7S49nWfTPKOps4r+Yy
         hrLMlPsuaF1Yqly7SEavK4fybpLBV10Jffd/WcO8yzO098Bsf+U0Mcs/hLZ40sLa+21a
         LUuXf5KijU7zedKDfMdaB46HSi7CgDOaGAPvfGUGV9/W7shlFrvCJHrLgSGOlyKokKW1
         9ngVS+9t085ZuE7gAJmwaz7gClq6f6O/EymtvXj3nc2VZX7EoZuEZylOH+mdM+2jaON2
         PoH4OiL+zxjj391B5YiRv77TFWvHZF7wKl9ZmlZegb8LbkJIuPyGART1d2RJnN8X5i5L
         TqgA==
X-Forwarded-Encrypted: i=1; AHgh+RrLAFJK8w8A5xtIZVvVyCcC2UIYJe+Pf7W+EYI31KwfezirX420sIYjk8AhLvo/rtKDngbN8RI9wLDQzznLolY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNXuhwlggh57Sxo2cm8BJw90sBYAKp0M6KVV8RCb16DduDwprs
	KusLWcqPaASc6SZwBPCvcNXJxoEJ99o6jczHYfmm879BjFHZ8atWmEaUEWM1Lrp++uT3MDz5Amy
	lY/xzg2xMLL9jir4H57c9FE3mKcitIvTSNWgzAdAgX7PWYks78kFAIj0pG+Ovqi28tFbaLfsB4W
	mGhBUNwf4n7fDEOEcenjsI2tzsS4DSyEHFsrRar6v1p32bOw==
X-Gm-Gg: AfdE7clFA3OhS8lIwzbET9UXu3lkml/BCpdhUp0RnlZA0G6ueyFn+KjO461feZ1mUAM
	GU3Y2tcOVVemW0f91mn8g1pX7uELuY24HpLTD3mTmIv5Sy+ad0N62AHNejux3BtBRqsLAHH8DoW
	Q4wluO/J0FYkPjiXMkB7DHVjhjz9EajOh1zUjsRRxskeDknpSFRLy2V/NtySYozFJ5nXFYLZJfm
	lkHReMPq5k6NvovnwTVEZviSzSnUwa7dNcCAHrkeYavHMjYY2VXuzrVonzDlgEPf5Ke8/xWKwbO
X-Received: by 2002:a05:620a:254f:b0:92e:7733:e398 with SMTP id af79cd13be357-92ef2c61899mr2368570185a.41.1784212892775;
        Thu, 16 Jul 2026 07:41:32 -0700 (PDT)
X-Received: by 2002:a05:620a:254f:b0:92e:7733:e398 with SMTP id
 af79cd13be357-92ef2c61899mr2368564085a.41.1784212892247; Thu, 16 Jul 2026
 07:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
 <20260710-monza-wireless-v3-9-46253587af64@oss.qualcomm.com> <6txwszoqlx5msqhspafk2t66hpdf67tfvc6qejeave3gg4fuby@rosphqguupiz>
In-Reply-To: <6txwszoqlx5msqhspafk2t66hpdf67tfvc6qejeave3gg4fuby@rosphqguupiz>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 16:41:20 +0200
X-Gm-Features: AUfX_myENjJrfTQJZMSC_KpPtznIhruyFgPIX7MpMY0JW25MDOTnZMlXQyQrAw4
Message-ID: <CAFEp6-07-6wzV7c-8mLDCkfVhgwVQ59BdTGvaXovu5PUGBCDZg@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] dt-bindings: connector: pcie-m2-e: Add vendor
 LGA connector compatible
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=APNfGQ4N c=1 sm=1 tr=0 ts=6a58ed9d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Kcl6yQRxnNA2GZFW2kQA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE1MCBTYWx0ZWRfXxstv/h5K+sSy
 G6SGfAhDQ9NI+HH5pYDeexq0KxkY0VgssK9+VLr0g+BHKW+Byb9vgraq5D3C2p2ZTaFJ7RfGF6X
 FCONhTNBSvC5fhUAee7I2Qnz3HEOLZQ=
X-Proofpoint-ORIG-GUID: fpGz1H217urXpnnGSInLrTQ6Ji-tszZt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE1MCBTYWx0ZWRfX6HPJaAy3jvBK
 cSrw14GL/ghUzJVQISzddb6dQrQz47F9rsgVBJPItUtXEER4xeXjB62fAP3rvb4lgm28BfP2n1G
 7SidxR4RiJtBRYmpjl7v5JYJdI5UYio70cMnZX54WWvmQlc1gW+81Z5HFsReBUasmvbFQ0NkVq4
 i4i1YULGdbtvpTqzW28k4zM8UI7VPjkagdh5+uIu++UrL56ey+PvmuWTuxXo35/SjNEu757cWQO
 HDhBGE8ReZKRXHFdoNKskDs39tnk6NIUPrbmVKhIGU2VT5nO90RSO4kq8/vUt2yrvz4w2opVQ78
 5Lt8OG15iRPPy6OjSrRZ/eqF1K42VKds6j8kFXkxx+aokwDzGZsR3r81ShxiSYSB+ujHjes/+pU
 jtHoDyR7TrLgCPOqx+g0ijv0YfT7Kh7eNQNh1EVLgFY0nS0cCEkIh4IvIADgJlSCwYsrXvOvr9e
 Q68p4UUWZzULTCh5/qw==
X-Proofpoint-GUID: fpGz1H217urXpnnGSInLrTQ6Ji-tszZt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160150

On Thu, Jul 16, 2026 at 4:30=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Fri, Jul 10, 2026 at 11:57:35AM +0200, Loic Poulain wrote:
> > Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
> > Key E interface signals but are physically soldered as an LGA package
> > rather than plugged into a real M.2 Key E connector socket. Such design=
s
> > are not actual M.2 Key E connectors, so describe them with a dedicated
> > vendor-specific compatible while keeping "pcie-m2-e-connector" as a
> > fallback for the shared signal semantics.
> >
> > Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 module.
> >
>
> Could you please also add "qcom,pcie-m2-1620-lga-connector"? It is
> functionally compatible with the Key E connector. Otherwise, I have to wa=
it for
> this series to get merged and send one more patch to add this compatible =
:)

Sure.

>
> - Mani
>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/connector/pcie-m2-e-connector.yaml         | 7=
 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-conn=
ector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connecto=
r.yaml
> > index f7859aa9b63469cb43919c0b5719c18694c5364d..0282c6ee9272446064a99ec=
6314a5ceb1721e0c4 100644
> > --- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.y=
aml
> > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.y=
aml
> > @@ -17,7 +17,12 @@ description:
> >
> >  properties:
> >    compatible:
> > -    const: pcie-m2-e-connector
> > +    oneOf:
> > +      - const: pcie-m2-e-connector
> > +      - items:
> > +          - enum:
> > +              - qcom,pcie-m2-1418-lga-connector
> > +          - const: pcie-m2-e-connector
> >
> >    vpcie3v3-supply:
> >      description: A phandle to the regulator for 3.3v supply.
> >
> > --
> > 2.34.1
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
