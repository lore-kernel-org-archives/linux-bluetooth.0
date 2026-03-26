Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29F3191D0
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 01:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774490355; cv=pass; b=oo5DoxornU58ze4YEC2yfme1xnr9cMeiKYhnBztH+UJHe1pzEqKMvkTdatJkgQVTkhSvtGWqxtZ3nMffOivQPZLPNGhOgD2rBRub/Ox5lY/6M6IzElV8dpf6VFHze/ShhfuhicP4ldA65qcSX1Rx76G/gTVLFB7ZzmxREdP6XMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774490355; c=relaxed/simple;
	bh=DFDO7VGoKhW9LibtcXJDRr/OcOi2kDPvbAzGM7JHtTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKbJKIP761Z5fZH89EDyZXXvte6UFtonjjjkDNgfIg2yqc6bPNLoUXM4tZgSPkf+4DbxxU/2WsaWJIyu7QpDO4djFxbHfgrmCqWUeS1WssAYBNHV2Mha8JtO6UIDkl+rIkfjUtFxMDM7MxgmN94sXjwOfF6WvCcIwhZNoeEotrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WwBkdG+b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FsGH+u50; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WwBkdG+b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FsGH+u50"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PMIFZn3070099
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 01:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jPgKrOCs8BV3rkHFf7zJrMHg
	/ajlW1vtOsuJgIMhY9c=; b=WwBkdG+bMNAv1+H4wYjSz+Puf4Hojd60sfYMbVLz
	6u7s1GcBAeZuf7rFY16XZRNNen6tUahqZmtZfxf58grsNZS90izuJb9GyiJNwA6l
	jyUtMU9c9gJrXpHrck5QXhLaP9mrc528Jd9uoA8GdtA9jR7E81ExXKHhYrVut73E
	4cXbuRf7ecmlOPp97UnydVYHUSGS0OAIeX3tJ/pfwMRH6KAgVVPs7d2FLHk+1Ddp
	FBl4Fp4U4exKCbvqP+V60vrbx6Lk00MyWfKihdu/ceUYWdPEjIB+Btbd/DQ866/+
	+Xeyo29QlF7hT/ik0vreVZ1XWS/2CHif9EzUZjwWwX9YSA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4rcn0g9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 01:59:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b0601ff3d9so7255025ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 18:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774490352; cv=none;
        d=google.com; s=arc-20240605;
        b=ZlKNZe0zmHtpA804mqczlL80CxmqP5wshCqOM4GMUoQLSQgigXutH5hY7/7HBQfykd
         O1L6LbdYiEqHRlzWoPugCC7Xyw78FMsj5zO4bcG7KyTMKGWwXT8wkES0qwmUUKwb14mf
         MewdmtIEvWQtvXfNK8strMWP+Re7gNNFKWKSP/rVlw3g6Y4u3mt5JeDfaYku+zBlmwiZ
         VYKEKiANfDJtKwA4l699vxCJgIWFQEIDRQ2IOjQ8etLckBRHPAqXkJz5aMWSPLGFLRmq
         au+//ATB8HsldudfbpAwZttLYEmrYA0ggUiw4WjLaTGxm/y3D6xVAA3Uavc54R3rgCZ1
         BImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jPgKrOCs8BV3rkHFf7zJrMHg/ajlW1vtOsuJgIMhY9c=;
        fh=IRvQBs2h7NgPG+r0xrOBSr3la/4x5Hn/h8Wx8zmKryM=;
        b=DaAnor3IcaHsTIfi4okG9mQ74fLCsaDexbSUKLZybwXehXp6fLkDgNjhOsHv4TYeqd
         BvvlOcFQG2hUFIseG1q8Fnx8ObAy6qRZWA1mW0FlZVkPnZknQGDhDxw9gui+quKRqQWW
         efgurHxLE+qMVSeKf/ZekGCyXEpV9NrN6v6Ge5sNfe14LeHcyS2b3yUmlw+v3zbyhy+8
         duAklUAxD7ZY+DubY6T9vw/2z6lTbCRD6sKxtEN0w8dujKIU3KkmY/ikSgsfWc1MaY3T
         oWTgoygXupd9nxxFnBFPMKgyRkaI4FXTZ7a638DDU/WIlQsp5ZgNnNl91qbP6kFk4lEN
         3vXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774490352; x=1775095152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jPgKrOCs8BV3rkHFf7zJrMHg/ajlW1vtOsuJgIMhY9c=;
        b=FsGH+u50H7hDfd5eY6SMzZf2ZvWyoVTnMNCWjJPTLS3kggeS/gFVcJBGGv7yziQsyS
         /i6d8hUCNePgWlYN7hb7tHmM7qW204DP/QnUdjnLIqnk/uyeTcrkOZspBM9SE7n77Fc8
         teBXf0BBTs+xTbv6mZBB527yG3Dw00KW4O1XrMifTRStePSGj2lATMjVECwswLN+l5XT
         apKNXqYLhwjZdLf+4yLkWcy/2Pwt7749+JZrnLITEEPo8EPEtCKl5HzZOfiHBhaN+4ha
         sPusz3Rg2PTtRTOPzoxQnmhxvnlfrz4sYKGx7cSz07nWGF7SMyV4kTb9Go2j48HizDj6
         OKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774490352; x=1775095152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPgKrOCs8BV3rkHFf7zJrMHg/ajlW1vtOsuJgIMhY9c=;
        b=FOB0rjjD1im1GAvPzLGX0dlhlJUWH9z0GCki5vc4bQGanv+/qqj8AkCOE9najzBRHl
         rX/LgzRjWOU7qYL8I+OuUdviHeVF9GNdXeqcrmqKlR3Otcdm2Id3ymOFBoclk6+8ISOa
         HGphwPtDlNk2bxcb0sMx9B2f9Cp5GyDN1XtsqCjO9D2UTa4VFjy39Ip9/PlihwGkyopM
         uBTaCd8mSDduMJZXnijpv7mBv+Vs7/q18cZllZTEL5PUmswGs1PanuGHhQ1LELRKu9R7
         mPTk5Fbp+6rJ9GFJ8sVd1WyecQJoLDnM4JnJmAcxuwuZ0eOw3wSg+dIH5PVw6/uLE5TD
         +X3A==
X-Forwarded-Encrypted: i=1; AJvYcCXizuHnmu/P+8m+33CKNM6dgye81tWahL4O59wMqYaFibkKbxY6v09l9K7FsDtWXhmvBYJXOqA1/sVpO0OWb6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6KDdxqUi7A0Tc0nPVKQwzcxnx2qwJnjGahEB3Mk+7ATBaXRyl
	xXCosf+COUrvl1X19lqJhwa7L7fjY0+RGfVZvlzBL3/8I10+QiF8fbZZnTI359tqn+uuPDBpFNm
	xtkrj5Ud0emxovLVAoU6bq5bDoKPDK3qBQT/OuvDsey9MMvtNXSDc93kpq83q6EJcBBLrq3VAmI
	D/kw4uHkVRFF7jbe/yiMK0bWy70HYpFjGqW19aOHAl/+l2SQ==
X-Gm-Gg: ATEYQzyzcuUkuV35AihVcb1PJSZ9MK3AKhT8fjQwUvRFc7YReY07Z0i1TR0xnLfgaIK
	iatkdIalZ9Zo7eWc95qf6aiCRDP7EWMMtCdikrjAPatESnQCJ2l+HLeAGfUgdacF9ygUTSBCqBV
	TeH7WuRrAiEtdKmzQJVDHHxlnsrDOAza2pOhteC1wyb9r+nYQ0gxB1uJWjmgT0LvIM9TmkaDqcn
	dsOPWM4toJIDgBQWxxR
X-Received: by 2002:a17:903:3c47:b0:2b0:6df2:8cd8 with SMTP id d9443c01a7336-2b0b0abe504mr63387205ad.40.1774490351607;
        Wed, 25 Mar 2026 18:59:11 -0700 (PDT)
X-Received: by 2002:a17:903:3c47:b0:2b0:6df2:8cd8 with SMTP id
 d9443c01a7336-2b0b0abe504mr63386895ad.40.1774490351133; Wed, 25 Mar 2026
 18:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
 <20260119-wcn3990-pwrctl-v3-7-948df19f5ec2@oss.qualcomm.com> <a75f80bc-d2fa-41f6-91aa-8252fbb415e6@ixit.cz>
In-Reply-To: <a75f80bc-d2fa-41f6-91aa-8252fbb415e6@ixit.cz>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 03:59:00 +0200
X-Gm-Features: AaiRm515yskxcvd1wtiR9718njLTgP_TuNpDNdd4YtWA6E6jp6B_uzG9KDE4-bM
Message-ID: <CAO9ioeVLy_Uzn7L9MyET5wg8CMR132+Dda5JzjdAB=6vz2NEMg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: sdm845-db845c: describe WiFi/BT properly
To: David Heidelberg <david@ixit.cz>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-wireless@vger.kernel.org,
        Jeff Johnson <jjohnson@kernel.org>, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=Vdr6/Vp9 c=1 sm=1 tr=0 ts=69c492f0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=l3dzM3eKOFk7Ec1IfqUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: RM2cAsahlpFrtC-jmBHgM2PWC1Khma2u
X-Proofpoint-GUID: RM2cAsahlpFrtC-jmBHgM2PWC1Khma2u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDAxMyBTYWx0ZWRfX4pTXXlbnOYQR
 mUu0elm/4XvR44GnF6N+8hKvjxFZXG1GC5+WEiuBgLFk+cb1EFmOoS9EU2foTcnA7Kp8Zyte373
 l+1Vi9x/u9KLfuHopebtv+KHpAFQsVvn1NCr3QoQnLiKyyJw+9wg8NUBPTgiV7YyGwRQFOVYiSk
 PqxiM5bkhrL1Ik+cnYCxDZvZYSwqAFMsQrRcYoFzI7CTTU5KEomPAhgzKjr4B/whlNqpVPP2vEx
 CSAwj5zMqgOCQD1MHl6XNOJfkM5bdg5in9QKaSuPJxZ5Pr1ZusTU0PwRTdQ44v4K8jy+XwJolWP
 +eg7xm7uOdlgXu/nWpAKRExUgz5UHxNdA3MEgMs9u+qmwFO2KHFxrn4GqoLehxOCVNUM2Vpsp81
 gXIHap5Spx635c0EKbITSYY2BXOKVw/JYTdbO0X0+N1mgyEPGonieQBU9Z8/8c+F2T0JpiDyXLr
 gyEIWzVhoZnrIALoTlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260013

On Thu, 26 Mar 2026 at 02:02, David Heidelberg <david@ixit.cz> wrote:
>
> On 19/01/2026 18:08, Dmitry Baryshkov wrote:
>
> [...]
>
> > +     wcn3990-pmu {
> > +             compatible = "qcom,wcn3990-pmu";
> > +
> > +             pinctrl-0 = <&sw_ctrl_default>;
> > +             pinctrl-names = "default";
> > +
> > +             vddio-supply = <&vreg_s4a_1p8>;
> > +             vddxo-supply = <&vreg_l7a_1p8>;
> > +             vddrf-supply = <&vreg_l17a_1p3>;
> > +             vddch0-supply = <&vreg_l25a_3p3>;
> > +             vddch1-supply = <&vreg_l23a_3p3>;
> > +
> > +             swctrl-gpios = <&pm8998_gpios 3 GPIO_ACTIVE_HIGH>;
>
> Do you know if the GPIO is common for whole sdm845, or it's only recommended as
> reference design, or nothing?
>
> I did test defaulting to GPIO 3 on Pixel 3 and WiFi works as before, but since
> previous downstream kernel didn't touched GPIO 3 at all, I'm worried about
> toggling unrelated GPIO.

It is an input-only GPIO, but nevertheless, if you are not sure, just skip it.

-- 
With best wishes
Dmitry
