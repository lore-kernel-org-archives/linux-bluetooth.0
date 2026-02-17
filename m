Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2EB292B2E
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771316039; cv=none; b=PV9O354McYeSPyHVsQ/UiRkESNT86mrtqqBPqBBljNKXeLTd1S3ytIvaWf5kmfgIU5COYHbLcCl1QsvtpkRxyb7QwOrS4c7LssytiFEKQ8/BlB+xaToHhpckpmLERf63ye5iSUPXZO76RPnKYOj66D+4Mu6OUX6YFlG9URa5CPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771316039; c=relaxed/simple;
	bh=EOeHi+XrxTB3rJ4d0iTLsm/vh44gO0WmR4iMh92ZCDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JglYv9kK+c15HfWo8L8YO6sNdySTt0S8qKUxxEOzAa3pMBLyJ/gKnegz9HGWVUyC4+k7yJVQxQi3auAknhLikHb8jL3rj8PU2oU+jR1XC8O/YruoExtpnB9zwVUybuSDTCV2VgdONINYEA6ZRpcirhZA1U3j4LFrzVrCQeB/dS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RFMK/kKW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z8EoRT2t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RFMK/kKW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z8EoRT2t"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GL7kYi910705
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 08:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nQ8HZnxO8/FfbUg/6bEjLU0j
	I8PL7lCPpIWsMOj5z7E=; b=RFMK/kKW9OGTCL8lep95ddl+N0+LjgxY/8AEVQ5V
	ki/6uddHffwZvwFPycnMp1Fcu5irjM3ZpsmjYuTIEqMxLXvPpjz5EsnqftxCSyyb
	eYQzqNCPHs8UWbH41mIXyjgnwBFo5EmmHxAPIgsJAmaK1pP+//4Pip/6oCRfxIBs
	IuZ2z8SAzFI1OueV/xNnQYURvFGqQXaa3qVUozQ1ePjgsWpT+GlKVBaxJKtkgXi8
	5TIoTGHoCPcJIz2ZOfubnusArxjz7sLo8n3BUdjmrygBUzYEQpgF8XmpwrG9nug2
	Wn5z4u5L/S4SF0FIuPEr5z6aIh52ZXSfX8YtgtDPJmV+vQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6a9smet-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 08:13:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70ef98116so2757761185a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 00:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771316037; x=1771920837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nQ8HZnxO8/FfbUg/6bEjLU0jI8PL7lCPpIWsMOj5z7E=;
        b=Z8EoRT2t0XWacz1ZJIEpChXJl1p1OKQN6zpPNUf0i50Z3cqOVef6bOK+eqv2EiKBhW
         K36ZuFq+RIBetAU+V4R8Zf8hpPHozjnrgjiLQ4s+dCjHrU5ZzFB34DPFJodsqcwOX4yf
         MtaWCCDKmrS4EGe8o6hWFyq3SFQ1RqMqM2UI67tj39qyRB8rr9+2XNgFULA9jIP5Xb49
         RcZ9xXYNBBHHce28aw2iIKKTjzFe8OEJnFf/8RAUVcM8t9DfK3PXW4sosQZm9RKe2GU8
         crSNwo4lDW5m7CZ6iznHfCeA2blmgwl29ZMscOtBAXKEBbHQf3H1I3f5Cf54O/eZv5Ns
         EWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771316037; x=1771920837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ8HZnxO8/FfbUg/6bEjLU0jI8PL7lCPpIWsMOj5z7E=;
        b=wHVkt+e99fNo9KBQbqvQtioqVfYnfmE30xCkrntgFoQpinCHK+GH6QXp+8CoHQOkOq
         otCb8yn8BEFaRjx6qcH4RBpv9lGAja7eQPwmsMf8CFWig1HMLe/lr1d3uIx2F2RA3vja
         93lZV8UwK5Tm46/5+tzkyEYobGY5rJanvVBWD2Tx+rElxUsumbUvsrfHaxfHFeMtDWq0
         Gar3uUF5lRIHwd26LfAPJ7g6Q4L2ruhj3Oc6ewCEVjzTiK1Fhy+mf+aYHu6nHj9bgeAM
         bzekLRIIhBoQaRCmmPPAC+GEg5DukkpNtPpwxGGsr5IbMZXmBYBUj09tuJWydr2UmdnW
         ECWw==
X-Forwarded-Encrypted: i=1; AJvYcCVygSU/wAlx+A9hQrTWaCtdwh1d+4b4XpJDG7JXVjbUZ04fZu3L/E7fpiNNCY9WB7+2Yr9gm2TaUiMHg2aNGa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcBJrT+2Ysaeegd7z31nAjPpL16SZ3HTxb+h/8ZNMk5/NR2QY+
	Q2sImt+4Nh6v4o534cG0xy74lS6ZEjO21pQ0+yhDPatweSiZXnXQdymXtvNl+Zt5ewsfbKbDgc8
	9vLzSHySuql/QWBEpVgCieMAEqdsEy1PotAkmRcB8yLUo65WhoNl0hKhxLfnpFAKXvkjp7aA=
X-Gm-Gg: AZuq6aKeEc91TIGqGONlnzi+nz35XChOeUYtuJjZhwX8ezTa2MntFOX76by54R5+NMR
	x8wDPMHbNloZud31scPRkZdT4yC5SWGEizKv2GnazBOmiUb1NUUd1/nkNQvujPRoyc9o3outnBd
	tP88SGdwQarylcH6AFzAt2NenC71Skb9TTegnyYPu0Y6UiZZNZI0ATVYimKhlfHWjPVNVXO1V7p
	PkKN5QhCYKCmnKIf25rvLJgMqLMK6an4FI/J1iVMdIDNn8oiow/m9GTNxqThvy8Y8EHCJGX0QQM
	1u9rRCSm45ju9OkoRWIX0NmKl/IH3dx4nKJn9g1aCGP80Qs3N2B0YuXHfXBIxEaVHLyScl+SAi4
	3QwkNkDZE0MNFeB9oQx7Br9f8JQtVYLAyQxL3795HdC5YB4x2EQxUtfRi59g2pZev4QnXjxcOwX
	drIHu0Q2poGZDz8SqCXgxAVNxUFrBZrwkyCoc=
X-Received: by 2002:a05:620a:6cc2:b0:8c6:ca70:68ac with SMTP id af79cd13be357-8cb4245c4dcmr1534954985a.46.1771316037092;
        Tue, 17 Feb 2026 00:13:57 -0800 (PST)
X-Received: by 2002:a05:620a:6cc2:b0:8c6:ca70:68ac with SMTP id af79cd13be357-8cb4245c4dcmr1534952485a.46.1771316036607;
        Tue, 17 Feb 2026 00:13:56 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f56b590sm3706538e87.34.2026.02.17.00.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 00:13:54 -0800 (PST)
Date: Tue, 17 Feb 2026 10:13:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
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
Subject: Re: [PATCH v4 1/2] dt-bindings: bluetooth: qcom,qcc2072-bt: Split to
 separate schema
Message-ID: <vdxktsvqwgmwi5wuaiktjstzkosvrjkkzkisnv2k2ffyehmh2w@yleoccukebbu>
References: <20260217054731.3058567-1-vivek.sahu@oss.qualcomm.com>
 <20260217054731.3058567-2-vivek.sahu@oss.qualcomm.com>
 <xai73ei5ixb3qpp53cjvk2h4adlfo2zl7qglshup4pbeyh4fpi@ihdos4z6vsoo>
 <3f59dbaf-1270-42bc-a21c-210c92b398ac@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f59dbaf-1270-42bc-a21c-210c92b398ac@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA2NyBTYWx0ZWRfXwYpMunCcgNwz
 YlsD8EGxIPESAxlfevQblrcZuBFkm7jKG6jhohD9dhMWvI8Pmf9Kvoxv/3jOnO5jEh6N4THakKf
 Uj5B2ut99lC0nWZW9Gp2s/uHwQPQauovepcqvN2DOXgRoBV4bu3duvqPnZ74yDcQfQq9kCvyKw/
 sDrYY/2ceoFYO9pwu8mAA8PeBNu4hiqEYYfdwx1DdFU5oAiimoMF3k/MjHijpH2TO9hOIPszWcQ
 uWu3UdVCUzub6COkOU/dPK6SKZGMw0SC+aSYuDAEUKcPyTQrEWYbqHA/EumuQKsKGlJv/I8id/J
 gdR0eUZlYRjQ02aWcZwPhzMVmUDl7r0fKTJ53H3lmeseYr/an66D0mehJ8221yArL4YraJKTGxA
 XlbIaZSh3zL3Uifh8LFQlD37/2M9wkFFHD/fqGmv7R3N0zmYkm72ZiMdvD1fWU/LZ0dXV/eLZtz
 S9k8gCgFyJDiOJIBlsg==
X-Proofpoint-GUID: -PWek3uTDXUdwr1n1Fd7r10CsfGr8SX0
X-Proofpoint-ORIG-GUID: -PWek3uTDXUdwr1n1Fd7r10CsfGr8SX0
X-Authority-Analysis: v=2.4 cv=TPNIilla c=1 sm=1 tr=0 ts=69942345 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=9ee_7Fr_-P8LzKLAvGIA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170067

On Tue, Feb 17, 2026 at 01:11:05PM +0530, Vivek Sahu wrote:
> 
> 
> On 2/17/2026 12:04 PM, Dmitry Baryshkov wrote:
> > On Tue, Feb 17, 2026 at 11:17:30AM +0530, Vivek Sahu wrote:
> > > One big Qualcomm Bluetooth schema is hardly manageable: it lists all
> > > possible properties (19 supplies).  Split qcom,qcc2072-bt to separate
> > > bindings, so device schema will be easier to read/maintain and list only
> > > relevant properties.
> > 
> > How is it relevant to the commit? You are not splitting anything. You
> > are adding bindings for the new hardware.
> This commit is added on top of split schema where for each chip set there is
> separate binding yaml file instead of following up traditional
> method of updating qualcomm-bluetooth.yaml

What does your commit message describe? What are you splitting?

> > 
> > > 
> > > Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
> > > ---
> > >   .../net/bluetooth/qcom,qcc2072-bt.yaml        | 48 +++++++++++++++++++
> > >   1 file changed, 48 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
> > > 
> > 
> 

-- 
With best wishes
Dmitry
