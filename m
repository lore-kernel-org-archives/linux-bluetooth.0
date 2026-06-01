Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E170E38837C
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300362; cv=none; b=W7y61V7S9rrdMcVDOWRPtbMNprMdNXzMVTa1+cMU7TO01Omz5TLQIU9cC0GAcKByvCt2K7sxjG9GLtKfMGAyC3Ncy/ms/404Uio2sN4+mG1Hu5THl6B8tNNA/GBNiFNgCPrzvPq6cNCd619dP5hhLgx7hKU6ylhpc4pgkOdNL1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300362; c=relaxed/simple;
	bh=DdHQWcGkWTZQsq+tx4owO1SCoJ8vL53+Lw7JFIQisUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgyivVF7c+wkpkQgxGtESe3WqKMxyt4i2I3PGmqa2Q/YTZ9VGylRqLFu5UPqYrzfhlMhGYKwMxvCVpnhSesSpnjsAVCJbbbtxa1mNv/VxXgb2BrCSCLKj9uy3mslvzNCweLyaC8w1CQT1tvS38mHaEhKxHjYFO4Kovr/babrodQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d9SjkBQ0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EAH7PrEA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d9SjkBQ0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EAH7PrEA"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6517Gmel2539104
	for <linux-bluetooth@vger.kernel.org>; Mon, 1 Jun 2026 07:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+YEpzlsDuhZpuFokwgbow4nr
	FcwBt8AvwHBDugGozCg=; b=d9SjkBQ00TphNyTkMSzYBKAF+zrlYrgbw3uZmPJ4
	7uzJVOufc1t0UF0P33P7pRCHhlMkOKCzxc3VvMCY0Y6m/QnANmKVTIj6/YWzvvLD
	wk1J7JZR7KYE2B9f8rGA7BNt2Irv3Q49Co38pRaX0YzyZTdUDH4xnONchGCZVpGt
	KZRUNYpwpBQ3ZK+JwZe/Ot0wRVz2mD4WhG4sXe01kVMZGvPRnz6XPmmR1hhPwfmF
	pCQ4QVOZ/RMlfAwNKUVXYPO4rgruRhp2EUKL+xJvGl7/csRV9U9aD6bXU65uSTrr
	g/kIGe1jZv3S6XozZtObynveaAzeYgyeIWE53H5Rq7iO0A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efn8pq0ph-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 07:52:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-516d1a8a6c8so137520161cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 00:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780300359; x=1780905159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+YEpzlsDuhZpuFokwgbow4nrFcwBt8AvwHBDugGozCg=;
        b=EAH7PrEA6fGdDdcd1tadMpoJApC2aPDfea+YnQZgc4iEKXs/pkg5mRBU2CC12VOtXT
         +H7cfSAV0krw7eMQEmCwllZBS0IKK2QzbktDNhknbDMHvaIDNRh+Y1L3Qw3Wy11Xxrnl
         YqfPlw2T7d3ZS9aZQPmN8fTM1UN1LiYTa70YEnAkr7kGWECWD2+izA2EE38P8dkxGFqP
         A4JtfCml/hxreGizZERPzqK1cqkextuarhf309gvJGWo6QdVcrs+dp8VUImyz0FZ+0Ay
         gX9bzPAmPuSuqmbbUFHojto5wCAFNWpzzC5XEvaV92LADeggH3dth2l10Owd/ZM7ma1P
         M3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780300359; x=1780905159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YEpzlsDuhZpuFokwgbow4nrFcwBt8AvwHBDugGozCg=;
        b=BsUzaSGtXo7BRn+erRGjfXoKB59dGGWk52czUld9XaP4D5T2jzVkNi7pmFWeyp5KI1
         v7VQW+8xfIYRcbNjrCOiIq4DrcESEuxFrdfMp+829eVf3vFANyPyqU1AGo4xDYIULSP0
         LBcqaQ8ymt/WGHUVquuI6UoKoXcb/SNB5M2/f0p6f87HpPOTQeXoxjn6eI0AOT3nmoZn
         x1q6zR2cLCPFzlgVYv4MUsFWZhKQ2u5y1tFTp4lrW4iasP//e07uo1USKEMZqhLepDle
         6rp6G2BEeh5zQ/s55Bvp282lohh6iVxnULYrOI8tihRmbJrhLzt889JpmbTWyGyXjeZX
         AlRg==
X-Forwarded-Encrypted: i=1; AFNElJ/sWxVE2qpe9B3CwSNESf2ZzLcgSAIFbf0dPNTZEft9VzeW6av8QE7IjU5bNy82Ny2UWVy8rKyELn32G5mPP0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCrbiOu9Sy2c/D1AC2gJ5DehfWxE76u6UgnYdAoAdl3zb36Ttv
	U+9KgRwIrtAKn5XXBj0a0a60yf4lsl4OoEuea6o8Q0g4eYXOfuCVBdSQ99drLRiE77EzhlItyK4
	+hS3+zmpbeixH23kenzHl9sB8VEOOQGgXkzXMWyL+ZN4B5HyRg8kKWe1uaU7nw3Ym3gny+q4=
X-Gm-Gg: Acq92OFX3bVr8sWB1NALWLqz1HlQba+VdmKSSh5VECTmQMkdsjHYG47z76yap+iUOeo
	O6c3tG1Qh9OvvHPgZrOkFyzKDzbrRF8DMc8OSp7eWoDoD+nAq8GgoXQ4NoifyX4YV/oRd/XMS6r
	mPz7/A66h3sC4svt2vcxhX5ftM8yq8O/EwLciUnYudKAx/uuAI2yg4EFF+cd/v2bi6qIMtU/BQ6
	hiHmxxbQVAuZ+WrgEiNK70zZ7MRX82ZHMS6RlmTvvAOFg7NeO0rseDAlxOnsBMthbiUyLxpEhHs
	RrOb+/pbSnZKNYW5qsepM9TWrkPgRaW89OZb8UTkOhtyDDLlk6tfSpDm+V2vx1cotAmHKQW+Wk2
	PW/1EYF4j9NgG6OMccvKlINoG7YGfztnrWFgh8fHjoUsUu7T+GHzwvv3FFRzl/38J6pkwVTd9px
	m4TX9PquC9PlQf/JKCGOVH06FTqFLD1GlVpSEOdhf2DI9+6g==
X-Received: by 2002:a05:622a:8586:b0:516:f4ef:5c8 with SMTP id d75a77b69052e-5173a70df62mr121771731cf.21.1780300359055;
        Mon, 01 Jun 2026 00:52:39 -0700 (PDT)
X-Received: by 2002:a05:622a:8586:b0:516:f4ef:5c8 with SMTP id d75a77b69052e-5173a70df62mr121771531cf.21.1780300358615;
        Mon, 01 Jun 2026 00:52:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39661e708ddsm19120501fa.22.2026.06.01.00.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 00:52:37 -0700 (PDT)
Date: Mon, 1 Jun 2026 10:52:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, rahul.samana@oss.qualcomm.com,
        harshitha.reddy@oss.qualcomm.com, dishank.garg@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: bluetooth: qcom,qcc2072-bt: add
 bindings for QCC2072
Message-ID: <mcn4ysrxrfqo36tr7khsxnjase3priskimkgxuacgma7jcpa46@bgla2znqhyfl>
References: <20260529175342.3363935-1-yepuri.siddu@oss.qualcomm.com>
 <20260530-funky-mackerel-of-current-878e2a@quoll>
 <6c06e372-85b4-4207-9bb6-270bd654c287@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c06e372-85b4-4207-9bb6-270bd654c287@oss.qualcomm.com>
X-Proofpoint-GUID: VCCfzOFoduQPpnaKE5dNJdkzpNN3q1FE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA3OCBTYWx0ZWRfX61nPeFVBelVD
 DzZz16+LUZKDlzOCUiYBF6mq4xSPIAt9GoJZyukzOzmqGsZVfx17tZ7IyZ2fcWknfntvyoRp4+f
 ntnY1Wi55T5P0NP9wdkJmrRCXQV+gGvI1GPDnJCeCVh3qPWtgLuAh+8G44I0ue0CuT8gvglLOA0
 4eAvYKzJIWEmPgKS/Ip1ofLkiD5yMqDE92qIKUocSMoOIKxYBhh+M0kelfdAahW2Vt6G+9MoKj7
 IigkxEVspNof5vPg1Lnkgak6Ci7CBhbakkC3h92NS60ZHxmtPc89v6nVwQMQx3QQfRfNZDNSnlN
 Hu9ZghPHJ8HP7XyBRW1oUf4aaTZ1oBAX2RV8YrnSbuSfcWmvytrcp6fhy9sCjQK1iALYMKvJ9e0
 o7KpiXSehszRmZFgba0TTju7qF9pmp/pvPb35Sv/RQ/T/F2UxCyEvRRfCF0/L/qkB1YgVRQd4bI
 9xJ4idDH6W74fTFQQ8g==
X-Authority-Analysis: v=2.4 cv=NvvhtcdJ c=1 sm=1 tr=0 ts=6a1d3a47 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=P-IC7800AAAA:8
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=mlDIMNG6S_g-ndTHxx4A:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: VCCfzOFoduQPpnaKE5dNJdkzpNN3q1FE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010078

On Mon, Jun 01, 2026 at 12:50:00PM +0530, Yepuri Siddu wrote:
> 
> 
> On 5/30/2026 6:04 PM, Krzysztof Kozlowski wrote:
> > On Fri, May 29, 2026 at 11:23:42PM +0530, Yepuri Siddu wrote:
> > > Document the YAML binding schema for the Qualcomm QCC2072 UART-based
> > > Bluetooth controller.
> > 
> > Where is the rest?
> > 
> > Also:
> > A nit, subject: drop second/last, redundant "bindings for". The
> > "dt-bindings" prefix is already stating that these are bindings.
> > See also:
> > https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> > 
> Thanks,  I will update this accordingly and send a v2 with the fixes.
> > > 
> > > Unlike other Qualcomm Bluetooth chips, QCC2072 requires no external
> > > voltage regulators. The schema inherits common Qualcomm Bluetooth
> > > properties via qcom,bluetooth-common.yaml and serial peripheral
> > > interface properties for the UART link.
> > > 
> > > Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> > > ---
> > >   .../net/bluetooth/qcom,qcc2072-bt.yaml        | 38 +++++++++++++++++++
> > >   1 file changed, 38 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
> > > new file mode 100644
> > > index 000000000000..8e2f15a75d62
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
> > > @@ -0,0 +1,38 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/bluetooth/qcom,qcc2072-bt.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Qualcomm QCC2072 Bluetooth
> > > +
> > > +maintainers:
> > > +  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> > > +  - Rocky Liao <quic_rjliao@quicinc.com>
> > > +
> > > +description:
> > > +  Qualcomm QCC2072 is a UART-based Bluetooth controller.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - qcom,qcc2072-bt
> > > +
> > > +required:
> > > +  - compatible
> > > +
> > 
> > Looks heavily incomplete. Devices do not work without power for example.
> 
> The module receives power through the M.2 edge connector and manages its
> own power sequencing internally. Unlike bare Qualcomm Bluetooth SoCs, it
> requires no external voltage regulators, enable GPIOs, or clock supply
> from the host, so no power-related properties are needed in the binding.

If this is a purely M.2 device, then it should not be a part of DT.

-- 
With best wishes
Dmitry
