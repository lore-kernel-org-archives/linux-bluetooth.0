Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FEE34D4F9
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 06:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773902661; cv=none; b=fCXqeNFv5N9s+FRECn7K7Y9d8K17k4Wr+jOMIXTSyGAxUyTe02AHsCoC9HzJcecuVpXecZETJ7hIdJ02AI/G0+j2DN3aoKLlFCWHjlWKVPUVbxvX+gAILxfiJiBwntJEoqPPRkNiWvdFpTpw1+DZs9gh7COH9S99rCXzPZk8o0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773902661; c=relaxed/simple;
	bh=wP3MwRCpSfl2TFPPo9rCnDnkHKD2ZsEbQBPMQ0JZDd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK40TS/moSor07DU/66N7YzGjVHwwLaddGFzqsKLKeVAKyO+D1LsyvplWGoSmtkbdQGl+Azkpzfz+7BMQGKQ7GXrK2awTxMiXbHL+xYwGuIBE6ne7WFXNJYiOsIgDyBwi/08IuBbW1sh+882G8+IIJpXexKnApkiNThIieVftXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SFRTgbgD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VCmqGoHr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SFRTgbgD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VCmqGoHr"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J5XQZs2347861
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 06:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KfmV7OgeEPnfHDNSfi+E3O0gIbXdlECurD9X3fopNt4=; b=SFRTgbgDbxlv27Tz
	sH1ehMGudIBx2asVp1A3l9cxkz6ywaWFoswR6+6X6pIbyeLGFsCAau1fRHItDJK+
	UB7t/Eeec/9MjSq6e7JidncYlGv6OuOXzxcgtJBi2z/3kHCeQJia1htY840VbdoW
	LKQg/+3Ya2iZjWrRI0mXOX4oK1E3+M7WargIB8Yq9lZK1NsUC6ix1UtoG80I5Wbj
	Q8vwINhBRnNTVS5qAUQENtMVIwb2m/5PSdSUL6H2DJyGDbj4dOnZ7IWbXEcf6gJN
	ylSVxr5sTpWLHhdbVDxskd6KBcClKDhWswgh9e4ItOHxacY+AtA3oF0jFRVM59Od
	7D+7Ig==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0957rgf6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 06:44:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50937c5b742so47688711cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 23:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773902657; x=1774507457; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KfmV7OgeEPnfHDNSfi+E3O0gIbXdlECurD9X3fopNt4=;
        b=VCmqGoHrXJLA8aUFAXez4eYwySaLmxeX4ALkCnLo0yYp317K2ePZG05AEzFvVxP35u
         jkFRq/k26ZQ9vCyVDAYyb8p0A/15xh6KTCOT4GTOdQ6/w49yA81AC5poldgJxa5IHkGf
         oShEJ5WIVqeziK84zDF6yKStVFcnZt3fpTl3dIfrsK8xaiwAiO80MZOGJcSznGyPSluO
         MHUja+g2tbwgIMpJx9UZjFOe1ry988F1UCMm8zixMjLlncPDsp4Az+Rz3LTjTqg82WZl
         0XrbaqPe22A6jM4ucIxwdJh+bP1DgVFwftmbOprYwIN2Eccd5j+D07k0HcXBMOdyJgFv
         4GyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773902657; x=1774507457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfmV7OgeEPnfHDNSfi+E3O0gIbXdlECurD9X3fopNt4=;
        b=sLktKLpT53p8iYTcRGLQXTJuaYmuDx/NBrdlQGcN+pzgKjPXOyfXHCSEn0LrYu1ax6
         CCJGpteIBahGcSJHhG//3SKxrvdpJ32ZOQQ9Dtdehz6WdAoXdE0PYILlPv8WxzrFAIp+
         FoXungwpljpV5mopIgvd985WD47UfVM+dVTGISfqAuJQpUS9B6Bvbtz4gVjFxyHKE/3L
         9Uu4A49/7dQXHnSZZqXQX7M6M+rRfWMX3JKoLkM95qHtUAIS10MfbGFTbSoCNu3rVVl+
         3VEoYiZ0XppbjvYLtv19ES042DRSuF5EhdveAFuna10B1CrBvWsc21j8jppyI2HXljpP
         uctw==
X-Forwarded-Encrypted: i=1; AJvYcCVuW+x5dJXVxsru6/aE6OKZzeCB83JvZlBX6+MLg08bUK7MOYG6XFrwUUH/mJOzH6ZFtUC/8E6kCGzczc/wGSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJINdI7d96TwF7s+tn8f9XAqSVvk2SNiyTHMU0yQBXNqYN9eku
	fM8T7N9idKCkh/8IlUjaci1fUdnzriMCD04j9DcZWdzNs7ZG2YrlfkapTMmVvQs+RTeQveX3Tpp
	ofWuQ0SsUBcIuGqD6slMa7iSF7r/zyhCWc7laiHUuh0B3A5mtn7o93LrOmVDBlwzjpGm5yBA=
X-Gm-Gg: ATEYQzyiZ3u8I/EsNmsHWyms5P1iPyzBOxe2fzTJMCnUYztipfVrEsopBIfmAQruj9C
	S/NcWe5r/iJExtZhzZOcQx6rLYVPGg6J+xMY1NU7f8o1KUm/h5B/MSG8MGrlE2983ciL+rxoRsu
	2SwRhM6wPqRYSGatPnNQxitCLglhiF83GnSE3DiTfyD8ijmJ/pNvoek7rtMb2qat8Q3qdyd0pAu
	2Ji6Xh5RqcXfY9Emz+++r7GZi4Vx0QaQYmNAH2mU9VdIOLvPDLYVXbpV+EhuKz4FiWaGFfxlp4b
	FMs4hOimhOBlomqFZV+6HMZBPi7Yvv2ZwYWX1pl3s3ft2FcEUn0o5MInh4H5ziuqtwq9tVbON3Q
	sEqUu/PDbHTvCSpmqIDvPZhuQHRB6clkyZkz4yTEIzAyutKiBKX16m0BTbvR6bWjKUdZvDRGrWz
	rNoI+bpNW2XOiCXiNEgJ7Sn5elBKeYOWdlDwk=
X-Received: by 2002:ac8:5fd0:0:b0:506:9e57:8ba9 with SMTP id d75a77b69052e-50b1485dae8mr80442971cf.35.1773902657580;
        Wed, 18 Mar 2026 23:44:17 -0700 (PDT)
X-Received: by 2002:ac8:5fd0:0:b0:506:9e57:8ba9 with SMTP id d75a77b69052e-50b1485dae8mr80442761cf.35.1773902657057;
        Wed, 18 Mar 2026 23:44:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bd51571d9sm11634871fa.4.2026.03.18.23.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 23:44:15 -0700 (PDT)
Date: Thu, 19 Mar 2026 08:44:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v1] Bluetooth: hci_qca: disable power control for WCN7850
 when bt_en is not defined
Message-ID: <qc543ugvjtqp6wbsrtycne25xwiyx37blqq3wj6herzwpcuj6k@p3ydpkh3emld>
References: <20260319031040.4096297-1-shuai.zhang@oss.qualcomm.com>
 <mcjloavd6jhinb2wgfwihsdtbay5n7zv52tn63kzrabcqwyp26@mh5aet76kl7t>
 <1603a5b0-8edd-4c31-b2d1-344ee7df10ac@oss.qualcomm.com>
 <whqo7o6fu6mytf3hpdrrirptx3fpprnp25as3dnam6n4fo7tjq@dolksuaq4irz>
 <4d6d2597-df3f-4421-8760-ea59a46a3b39@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d6d2597-df3f-4421-8760-ea59a46a3b39@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: jDj16r8i8QMDXzrfsRFDBQKc5lIC46lS
X-Proofpoint-GUID: jDj16r8i8QMDXzrfsRFDBQKc5lIC46lS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA1MCBTYWx0ZWRfX2A18blTxoLIo
 zD4zxcou3/EQrK9hwhHCYz3BNFmjMgFNKXrUavvIEOVzpkY/pzBDJoRavGbwH2B9PZUVqvJxWJf
 1UUKRw81CnBekfXAyC+fgoKfZJACX4p9YNtSVy1nY4CZlU4zv2YQTxBdCROKaYKEomabkOtwgJh
 Wje6GYjM5ARuXHgQJlmeu4pojD8Vv02KEhf+plbi+GAvlqtOt1EGZv03+bkaAD47zosrVsPiLZb
 TAst4FT9gAYsEtpEzYBUGjW6n0dNdfwpfT/8vAyjbeklHWe9HpgEIR2/FKZ31mzXkp1MVxEFHvr
 hy4K5w8xxbKfUIEo+fEYY5hKxGk20rcbKrMBAAZVZ9/ho3Wzw/NJmBEvLiOtkL78/ccui974uRG
 nsvGBtf3n6AcoUG+u+Bs/MmShoqt9lRY5S+PPVryoHm++6CK8VyND/MsnordlAzIEDNL8s1NNyS
 Jm+TOIIVa2vEBVH02yA==
X-Authority-Analysis: v=2.4 cv=RZedyltv c=1 sm=1 tr=0 ts=69bb9b42 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=XhmMlDEUr4LgRsFAYB8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190050

On Thu, Mar 19, 2026 at 02:06:49PM +0800, Shuai Zhang wrote:
> 
> On 3/19/2026 1:42 PM, Dmitry Baryshkov wrote:
> > On Thu, Mar 19, 2026 at 01:21:58PM +0800, Shuai Zhang wrote:
> > > Hi  Dmitry
> > > 
> > > On 3/19/2026 11:51 AM, Dmitry Baryshkov wrote:
> > > > On Thu, Mar 19, 2026 at 11:10:40AM +0800, Shuai Zhang wrote:
> > > > > For platforms where the bt_en GPIO is not defined, software-based power
> > > > > control should be disabled when power is managed by hardware.
> > > > What does it mean for this chip, managing the power in hardware?
> > > bt_en is pulled high by hardware,
> > In which cases is it applicable?
> 
> 
> On platforms using an M.2 slot with both UART and USB support, bt_en is
> pulled high
> 
> by hardware. The current platforms are Lemans‑EVK and Monaco‑EVK.

This needs to be a part of the commit message.

> 
> 
> > 
> > > or described in the device tree as a
> > > regular always-on GPIO.
> > Why?
> 
> 
> This is equivalent to bt_en being pulled high by hardware,
> 
> and it applies to the same scenarios and platforms mentioned above.

No, DT would not describe the GPIO as always-on in this case.

> 
> 
> > 
> > > 
> > > > > Add QCA_WCN7850 to the existing condition so that power_ctrl_enabled is
> > > > > cleared when bt_en is absent, aligning its behavior with WCN6750 and
> > > > > WCN6855.
> > > > > 
> > > > > Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> > > > > ---
> > > > >    drivers/bluetooth/hci_qca.c | 3 ++-
> > > > >    1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > > > index c17a462aef55..4512ff7cd0c0 100644
> > > > > --- a/drivers/bluetooth/hci_qca.c
> > > > > +++ b/drivers/bluetooth/hci_qca.c
> > > > > @@ -2484,7 +2484,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
> > > > >    		if (!qcadev->bt_en &&
> > > > >    		    (data->soc_type == QCA_WCN6750 ||
> > > > > -		     data->soc_type == QCA_WCN6855))
> > > > > +		     data->soc_type == QCA_WCN6855 ||
> > > > > +		     data->soc_type == QCA_WCN7850))
> > > > >    			power_ctrl_enabled = false;
> > > > >    		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
> > > > > -- 
> > > > > 2.34.1
> > > > > 

-- 
With best wishes
Dmitry
