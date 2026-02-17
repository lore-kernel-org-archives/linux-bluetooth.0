Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1641627472
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333312; cv=none; b=OM1QjdiEP6K/0ZQ+gPoZwSCpbP0KVeeyWzZHaNCSh1K4WDq1et9Ur6HOKO9wzvt+MLBbdd6RvsPYB0yW4LOkC1yf/KsLovKLkKFB1UYFzzH+LdaV/C/QyY/C53LkQvTzXNNn3lJbQHCCeix1a5uwbwAz9t3gCXuXqAXI6ozImDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333312; c=relaxed/simple;
	bh=7dSQFmKwzJX/TICmtGeNRIBsnFI93g49Lw5UlHIdUYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLNykIOhmSz6oRCv0rE+rA6FK+V1/64s2lJhf1iEQxQJNQQMVGzO+kULMKBD9kQH6SlI8QjOmfSPpV4v76XTPCfiasiVxSOotnfNBScAuP64YAfp4dlP0fTQYAR93lLatNz/3KYFAqazbLJF0VhNU31Udkae3ePue67i+SbDzP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J7iZgtE2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JRjQEvK8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J7iZgtE2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JRjQEvK8"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H8q71F048861
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 13:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vd40U9UoMKaKOyH5ofv9FCYx
	5wx4j3wNJzQNQh0zjMU=; b=J7iZgtE2ZpPCTWhx4t8pBkb+a7TfdDBdSR+MhxqP
	gwQ/n+okZ1Svkspt9SgqyCsFjO5qRg1uVEL0tMP2bNTnXw1gitGivu6JC3MlcxD9
	ROeQfjnQqBNxcpYH+rcqX8pauHOl6qvepBnF7RNkRwLgnKelBetSRzE95eB551lG
	VQ1tb6osY+4WoBEchWYFdOMrZtBJDDPYvIwqHf4fvBfXwvYAHF4s87dHsO1skdmP
	PiMin1c9TK59Qql9QFzpYyt51lx1YNc6ejVnRMPBc9QdAFzKtjo9Z+nL55+e0FOX
	0LSel3MoTXNFe1yG/5Cb3+pPipXw8Vrsz7AOtprJpoPOyQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6d82ep3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 13:01:50 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-948357563a1so7741942241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 05:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771333309; x=1771938109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vd40U9UoMKaKOyH5ofv9FCYx5wx4j3wNJzQNQh0zjMU=;
        b=JRjQEvK8r2ttZM3TgKDMI2+K2/w1oS3LVH6crMtuqJGthfpD7VWKsXu2Qq/DDVYWIl
         P1wr6fJiof5UbtVo0eoxLFF/+a6GpUyzmSByuWT1tPXnd1umWVrceCXbc1inO949DWTE
         VYU/EXT29RecqFagsM6+afLdu4y4YJ4/iFEF9Ln1E5m4n1A6WivO6+vYWZElTbI+jrLU
         6b270U/+1jQP+m3biX2asasQ+5WMeFhJyahftE2cPKXEQhb/eVnU/vzkvECv3QCed08o
         6py2PEGDbCiTVDZyDO2vBvrb8L4R+TjOp5floy/BVbKnL49b4xymAxec37MSaz3qyRaQ
         kItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771333309; x=1771938109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vd40U9UoMKaKOyH5ofv9FCYx5wx4j3wNJzQNQh0zjMU=;
        b=JCKWg4s293i3uDTAvRxrvd7+pvbEYHJTC1SaqlNtnTz7bZ8QwyacJIuraPs7+RBIjx
         7W9vCgGn+efA6St+Omwom12sJ6eWEt+W1tV0Kz4w9QmTWqYXS68q8snpA9rWKJ329xR1
         +zL2snfnP3l31eCvLeVH56D2NnAvW7Mx+1B39W4BHRPmbhb9fxvvfkjCFXIXhMAfUf+4
         wES0PfO/hJUziP/uEiXToc5KbPqxapF65BaYJpPUbCqJDRD1qbJzZo52fpE21y94c4KU
         wAL2oUosn2djTgg9r2aOQo5ZRIh3kItogGRqhnz/bsqB09gePp7MS2Fz3piQuevgO6zi
         ripA==
X-Forwarded-Encrypted: i=1; AJvYcCUl2+dUtNKdVqBkkxSH6tMEztmdgiMQ4u6FbOtia44/vHGgOECWwlt9GNzlPuFeVh2uDTvLo5DnNNzfxZ6/WH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbYaQSD25WyLZY6naGmsgllJ5NsKZ44bvmigX475mxd18Fa8JO
	LfGjR4abdLwfpgGxMwIVnu/0mwJD3fGXpcBwMS/jwRFTM53vRKScvlaDxObxNxY4QQeMNlPdj2V
	jok6EYPhDVeZl6XxvRausVOy/VZKgS7m5+7o2m6uk5E1AciEUEI9wmIpn8bIyeMeJqO4Jeog=
X-Gm-Gg: AZuq6aL46TT/lVnExCWTtUBbfTDvkPmfMKEFv5txU2w07x9ox48VSs7kAUKdZN6fgSU
	iMffc5g6DuT0N6+EE42FxW5T5r8cQ2l6SkGVIBmIhwkFuYMQnqmkjgMZlBOBcF2gf9ITx7LQ4zS
	aqNAjwd+4j7nGd9x4uQA8Mhto5zJEWszzpyNdRqDfTEyJUsO9mCHTAeZKfc6a8GulcX4iU9C5wM
	POABIiVMDro9jazCCQ1k7TcMtIRwioFeps/Nc01SajiVvOmmSqs6gkn88Sczl5B7VW6aHv79nz5
	PjvO44tTAj+swzgM/DHU3+mfUCbhcOowd/C96fpyZFkybff6CyTQJiwDng/2RIPmViW9bBJmamj
	rj2FJMkH2K91gWLUGavp6YWKylIW/gPIi29nJnAvqg8+5Aa/HfU1QzT+/imXgLvGy5L3ks9XEra
	MlkRizO3cewVw4G/2US3czmiYmnzuSbUcsSKE=
X-Received: by 2002:a05:6102:ccf:b0:5f9:3a74:e17b with SMTP id ada2fe7eead31-5fe1ad01e29mr4127866137.13.1771333309335;
        Tue, 17 Feb 2026 05:01:49 -0800 (PST)
X-Received: by 2002:a05:6102:ccf:b0:5f9:3a74:e17b with SMTP id ada2fe7eead31-5fe1ad01e29mr4127293137.13.1771333304043;
        Tue, 17 Feb 2026 05:01:44 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3870689259dsm33693401fa.2.2026.02.17.05.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 05:01:43 -0800 (PST)
Date: Tue, 17 Feb 2026 15:01:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, janaki.thota@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Bluetooth: qca: add QCC2072 support
Message-ID: <3v3iz5cxsbaoevcfkk7itutdepfuagxoemixgfhewdevmju2ut@rcg3zuyg4gzn>
References: <20260217054731.3058567-1-vivek.sahu@oss.qualcomm.com>
 <20260217054731.3058567-3-vivek.sahu@oss.qualcomm.com>
 <mt4vrzmq7caqddwtz7nc3tn33zxh7uupoxfmk5pfqobhuex43f@se64qz7qvuh6>
 <19d3cced-f630-4a6b-853e-3798487fd769@oss.qualcomm.com>
 <20260217-mighty-organic-oxpecker-2ed848@quoll>
 <cdbef8d2-df96-4a41-98eb-3acc747a0aaf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdbef8d2-df96-4a41-98eb-3acc747a0aaf@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=bqVBxUai c=1 sm=1 tr=0 ts=699466be cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=NK7YlZMuulUfQlmKRgAA:9
 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwNiBTYWx0ZWRfXxfKlYQ5MnFFd
 z/CFkmoXJR5BLuBGMMubaWTFu/1MhFOUb0pkyMYMTlu9nbyXLEIu1b280DQj2F/O+iJNB8qU5za
 3gMhSiqZXb1y/Uwhci6p1+6OqV+0e4Of32X2NRYGxsjyqEHCPfh+k/hLlOtdeyraNxzuY7/WkXc
 TF9N1X+TpDZrJx7la91HBc4dGIQogLR27//WiDedKIfL3yvvPd9xksO8rOuUAratP+HZtdXNRWH
 euZIRc8eNePn1X3M9YhYnrLEU43Hf1s3wREob8zbZsFJtYQkOqIrY4zBiv+Ioup2+RVI0Luk/1n
 vRGEoRrQZlHiHuz+tfCaKGrz3C5IZtoZRtvu3fK8jYv3Eh8HdtAIih1KQwfq9yej07D92MyDnYB
 Cl3F2xFJrdoKBbie4w0/75VvwvYfUSnkrB/LH0/24ZlHsyQes0BK7Jl4ArmX8mrM1EEpDdvMzdH
 2N567KqdGe0fsgjugnw==
X-Proofpoint-GUID: gn2untFytZZSM4ex1I-7aUzO57uK1HIT
X-Proofpoint-ORIG-GUID: gn2untFytZZSM4ex1I-7aUzO57uK1HIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170106

On Tue, Feb 17, 2026 at 06:21:19PM +0530, Vivek Sahu wrote:
> 
> 
> On 2/17/2026 1:23 PM, Krzysztof Kozlowski wrote:
> > On Tue, Feb 17, 2026 at 01:17:29PM +0530, Vivek Sahu wrote:
> > > > > +		case QCA_QCC2072:
> > > > > +			snprintf(config.fwname, sizeof(config.fwname),
> > > > > +				 "qca/ornnv%02x.bin", rom_ver);
> > > > > +			break;
> > > > >    		case QCA_WCN3950:
> > > > >    			if (le32_to_cpu(ver.soc_id) == QCA_WCN3950_SOC_ID_T)
> > > > >    				variant = "t";
> > > > > diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> > > > > index 8f3c1b1c77b3..a175ac31e7b2 100644
> > > > > --- a/drivers/bluetooth/btqca.h
> > > > > +++ b/drivers/bluetooth/btqca.h
> > > > > @@ -158,6 +158,7 @@ enum qca_btsoc_type {
> > > > >    	QCA_WCN6750,
> > > > >    	QCA_WCN6855,
> > > > >    	QCA_WCN7850,
> > > > > +	QCA_QCC2072,
> > > > 
> > > > Why not keep it sorted?
> > > > 
> > > As mentioned in the cover letter "qca_btsoc_type" enum in
> > > drivers/bluetooth/btqca.h contains all the soc type which need to be enabled
> > > for BT enablement on the target device. There are few places where logic of
> > > framing packets transferring between SoC  and Host depends on the which
> > > generation of the chip it is, refer api "qca_read_soc_version". So It is not
> > > sorted in btqca.h file.
> > 
> > Neither in previous patch comments nor here you respond to actual
> > comment. You just write something completely irrelevant.
> > 
> > I don't think any of this should be considered if you are not
> > responding to actual comments.
> > 
> > 
> > Best regards,
> > Krzysztof
> > 
> There is high impact on the existing design if i make this enum sorted. We

What kind of "high impact"?

> are considering your comments regarding sorting for next commit not for this
> commit. Can we have approval for this commit if all other changes looks
> fine.


No.

-- 
With best wishes
Dmitry
