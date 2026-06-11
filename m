Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFA536CE1E
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781207105; cv=none; b=QXEBy9hqDuzOewpUQv0iw5/qiSBsefge/sYJ/zgAcgMzjqX5MP7kAsn0lnSHyb2bbel/9sZjZKPqxPTgTPMtZex982P3WO5DyDBmoU1gczQ56FTXYRvkeDRZHUzXLW2z4WOofWTKUPG6OzCfXEO47XFT2e8AMxG0cINABk2PmAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781207105; c=relaxed/simple;
	bh=01ioWAHb5nCsaIc11XbExlYS4Qk3/qMPjNMVsOpw1as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+drvFKSH6uAUnVhaqAZTVmTrlN1DLxlvgt7MuXCTBds65wgWKmLG7Gb8v1hyeLXZhaii0WFwJdyoFxEOid2Raiuo1iB52qdJyd1hbsCVma3jbfqr/fNLYDWOmdWHwp61rt87Wl2vDMhG35Ns3eoTex0kG3ScnVx+3F1hhAqdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NsgxwsD3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ChWt09wZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NsgxwsD3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ChWt09wZ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BJ3Oqj1389256
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 19:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ET6MuyER7wxqL0ASDlEV4k/M
	QK1DNFn9BvrzLC069vE=; b=NsgxwsD3g9/tq9EhZ6i+/tcISCfFF7/04AjnxCFQ
	Ml6KjDCaTQdVQ7/O+jrLiaCqhWqWALIh+4xScFrNXEJjaxa1e99uVeRza6pIO8kS
	6hcsGgFXizRuscbj97lpaijwrWQV32/x0QIgBLPfPHqms3EOJ/heK1CG59rjJks8
	XV6fgwZKlJCHBOm0dRHCYTgP9E+a8EAYjLoul37S9v7b3hIxpOEZW8RMrrxqWjId
	vv3NZrNwStAj/Ls5lRcxQqAhDm2KQ4s1hfuEc5mXEJ+IjcJuAYgagI1a3Cklagkc
	U/PqeV6jk8kaHrttj5udUw1psw4Zas8zGTIZ5y9LooMAnA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1658p7w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 19:45:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5177bddf6e0so5072891cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781207102; x=1781811902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ET6MuyER7wxqL0ASDlEV4k/MQK1DNFn9BvrzLC069vE=;
        b=ChWt09wZlxE5j1/g37hBp5uXGbKO3DITbM5UEWqcp6HjvCdkXcxW5JJ/yGswHUFnoh
         KMICONwmJTHsYjM7qc3gaPB38fzQjhrX8fHA/Gjt2ptoMqQPskck/aLvrF9RdDasNT98
         t6EdtAkki3lZq7TRTvJZ6Yicazt7hDL72Amutc2l2QvGf4zrlx8ScuV6lyhIYP3yJr7h
         gxnNqHzXgTZDW8DNipL5C99ueaWKlMXQbPFdgyzme26GPweMdfDe3uCp7c0R/ZJUF9Ek
         YlAebBhW9AFwK9EMfmBCpwkhYYRkWhOCIfjOhBlmNe4FVrvwuLzk5LkgMgodpnoKpQqX
         ntrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781207102; x=1781811902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ET6MuyER7wxqL0ASDlEV4k/MQK1DNFn9BvrzLC069vE=;
        b=fp3w2fixcMCXTo1bX93r4ohsaxkRb5iMPXRVGJ53yTHUUIe7WBV7xrsx5a7pQ5ELhO
         W6TPVxBYR/hBkSQevluERIPsmDK/s1keF+eLZURYvsPKB7NnTFqw0yRFlvvjBsy0+39o
         taqou5UGc+iwGoRJulYWpWhFhWjbbWcrOXMn/Oq6LnYPXEB0x9TDYv+u7JIWfiOS3RGa
         +A3oy4cztQFWd5AV8oZLPscxPzEEPiB6nLmExV/tMposjIR6MLrSDYguyZ2sF+TiQZhS
         4OPP9FgCgcllEf4AhOpcnsqcKpO8WhjtaGmCbyME/vqCrEg7uQ1r+ntiJYKPIi2XAPIH
         f1Sw==
X-Forwarded-Encrypted: i=1; AFNElJ+8weceukpKykJNgK7nRTNNGkBXb6EMCBEjn8Jlxa1T08NgD+9DJ9h/w69yfmOb7hmBLTJSHtyy7VLY1VHX2EM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz3lgVaSGIJAxBSefkGGHcPh1W9XW4pUXQJteqkM0duevfM64E
	3tX33dNvMhyZIVjxUer6549dYcoDvc5jOhP97xj7BddPkV2azt6RtOSxRpOcQassdhnMPtcdxx9
	vfwUUEdzmyVjRxZcVgqFidlF5mYvMO7JQw7cwvbxeZl0SqKZMtTM/Y7GJRwKHyPmeSaehxvo3Hk
	771Us=
X-Gm-Gg: Acq92OGUv0UJH3jArIJG/vH8wT6ffamUD9gYrmXcv3nDCIqx1UBr4z3jFcZ9ROymIWI
	dP2saHtpl3kI4Z+pTtugAtQLy5O15EwjLGa/J4v7FXAtPSPyXflCg6fiQX2ND+FJ/8WAv5d5frl
	xM6uTH/FldxpOeBUy81/3I4mHdtI5nH7AMFCjZFY+N3YVoTJ6rcUJUAAwVU4Y4W78JF6ivJmTPg
	ta7qcl76IX7FmoGkySy+I28wAekX0uWxO8oMEE6SqOC17QL9mvxfa4zfEaMRsjBHiwwrAkZVjbD
	r7tichYJmiVHtfub5nNkjwc6JDbwD7TQ/cbcgpVCX7S3NMVlb+zNfCfDbgdN3/zzKQxrZ5kuZ7U
	E1K1+cU5MjQg29czkYoMQqiEpYXm8STNYHe8at0vnIw2hs0fIwA2wK4x9N/gXkmwU6QDVr1jsXD
	7h4cjHYhDOGKdogeN1pcsbhSf8KZkjkI80/6w=
X-Received: by 2002:a05:622a:14c8:b0:516:ddfa:b6b9 with SMTP id d75a77b69052e-517fbe619e8mr1984821cf.23.1781207102429;
        Thu, 11 Jun 2026 12:45:02 -0700 (PDT)
X-Received: by 2002:a05:622a:14c8:b0:516:ddfa:b6b9 with SMTP id d75a77b69052e-517fbe619e8mr1984411cf.23.1781207101976;
        Thu, 11 Jun 2026 12:45:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2cb46b25sm103098e87.34.2026.06.11.12.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 12:45:00 -0700 (PDT)
Date: Thu, 11 Jun 2026 22:44:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip
Message-ID: <dz4qovpquxgynnzviqg6g23oa2o3trlkznremnmlqfnlj3b62x@oqgcuvalfcph>
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
 <20260601-sm8350-wifi-v1-7-242917d88031@oss.qualcomm.com>
 <955691e1-e40d-4584-861e-8f29db4ba8a9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <955691e1-e40d-4584-861e-8f29db4ba8a9@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE5OCBTYWx0ZWRfX0BEfuFfa+s8J
 c24ZBYFttt9rVvSnSNEsaNa2rEOxN6WP5Duq6oL/kD6oPErlvGzpzteeSErl3/7o4fOiitqJCjj
 550gsQBBjcGiKxUaQw+9ebEkxz2N0U5bum8bylvuwYnBw6NApiOWWExb5n6TGllggTWxReRD5uE
 RDWfSiIKpoIu0ZBfWLLpgQ9R1V+JRUvx5jFKwa+xjWnBgQ/cZCP4bAYdP9bpIWx8+BsOaJdLyk/
 nUKeqUHqS9Mhuf6qDpovmh450vpSVVZd7isYyenJz+ubnS45cq7CZb1B52jcR3KiQtRg8CU8wAw
 E9fT5u6qqi1zmUxZLT+kBXFQRfXDNVF+EYAgyp+6bJ2/wqG2jNkGwslU2c1rX7t4AWQoAY2Gmgc
 ASYVtQCCcrsdmSGRrvSpZDxYUavdGYKQYAHgMBojGtIr14pAzfAg7ABdEqVwV/jbjb1eQEYGjv/
 pTTmkAcP2403+WPzTLQ==
X-Authority-Analysis: v=2.4 cv=LNpWhpW9 c=1 sm=1 tr=0 ts=6a2b103f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NvgA2eVT_OJx7K5CLicA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: UQelNqFE5CjGptcd-rwQka7OYsiZslVn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE5OCBTYWx0ZWRfX8nM6N8t2Mpym
 biJDAlgdQj7tRqcRPInEELA5b5ZkP3mkljYozQ0+EFrJlRcGq1J8oDR+EW53FHyQOHrVSpnEH+8
 bzeXRIRW2iwFLaafLLQNmCUFWFerBjI=
X-Proofpoint-GUID: UQelNqFE5CjGptcd-rwQka7OYsiZslVn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110198

On Thu, Jun 11, 2026 at 02:09:27PM +0200, Konrad Dybcio wrote:
> On 6/1/26 11:46 AM, Dmitry Baryshkov wrote:
> > The SM8350 HDK has onboard WiFi/BT chip, WCN6851. It is an earlier
> > version of well-known WCN6855 WiFI/BT SoC. Describe the PMU, BT and WiFI
> > parts of the device.
> 
> [...]
> 
> > +	wcn6855-pmu {
> > +		compatible = "qcom,wcn6851-pmu", "qcom,wcn6855-pmu";
> > +
> > +		pinctrl-0 = <&bt_en>, <&wlan_en>, <&swctrl>;
> > +		pinctrl-names = "default";
> > +
> > +		wlan-enable-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
> > +		bt-enable-gpios = <&tlmm 65 GPIO_ACTIVE_HIGH>;
> > +		swctrl-gpios = <&tlmm 153 GPIO_ACTIVE_HIGH>;
> > +
> > +		vddio-supply = <&vreg_s10b_1p8>;
> > +		vddaon-supply = <&vreg_s11b_0p95>;
> > +		vddpmu-supply = <&vreg_s11b_0p95>;
> > +		vddpmumx-supply = <&vreg_s2e_0p85>;
> > +		vddpmucx-supply = <&vreg_s11b_0p95>;
> > +		vddrfa0p95-supply = <&vreg_s11b_0p95>;
> > +		vddrfa1p3-supply = <&vreg_s12b_1p25>;
> > +		vddrfa1p9-supply = <&vreg_s1c_1p86>;
> > +		vddpcie1p3-supply = <&vreg_s12b_1p25>;
> > +		vddpcie1p9-supply = <&vreg_s1c_1p86>;
> 
> [...]
> 
> > @@ -373,6 +437,13 @@ vreg_l7e_2p8: ldo7 {
> >  			regulator-name = "vreg_l7e_2p8";
> >  			regulator-min-microvolt = <2800000>;
> >  			regulator-max-microvolt = <2800000>;
> > +
> > +			/*
> > +			 * This is used by the RF front-end for which there is
> > +			 * no way to represent it in DT (yet?).
> > +			 */
> > +			regulator-boot-on;
> > +			regulator-always-on;
> 
> msm-5.4 maps this to bt-vdd-asd-supply (asd being a keyboard smash,
> perhaps?) - what is its actual use?

WiFI/BT RF front-end, a separate chip containing amplifiers, couplers,
etc.

It is a separate chip (or a module), it is not powered on by the PMU,
etc.

-- 
With best wishes
Dmitry
