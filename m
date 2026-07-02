Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE5E3EDE7C
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993436; cv=none; b=kGSUf8NEhILucOb0LuRv0ueBPSBrM5AVWNbnOHKpqscSwoBeNQaccS0/9O65tq6R8LNdqzDU8f3841OnA3ObJiVdTPV8iZFvbdIhS0AZDUX00DvmXM/uevucHv+74etweMNwGNdYvIJJxws08uLALiGlJogQMBM7ah4S4Er17Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993436; c=relaxed/simple;
	bh=7W1GCpEe3Gdv9nXmjbwQh2a1LPAEYYmV2hnpUZRBLKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKFvt5a+H5n+W0SuX+qiInGqKrOLVaonuxFAg9q551jefz9s9ISo9W1ni2ZdCNmF2Na49i6HKj/FzrNwc+ZdyajU9IgtEilmHdpgzVQtQHiufHAo91jGCDqx7rQ6yBc+WBjhJvOxlnoaAAu27bQJ4ie13e71TcqJtKuhj9qBFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QKHeWgmZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EJrxwTto; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QKHeWgmZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EJrxwTto"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629LIxi4117784
	for <linux-bluetooth@vger.kernel.org>; Thu, 2 Jul 2026 11:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dcUxmlJb0u+2w0hmOr3Gqno9
	mV/FfHmW/GhrjwOQzaY=; b=QKHeWgmZbjqBL7V6KkgD9JFOigaMVHSiSKFNlkVk
	LfTtb9KT/urbl6vl1KwgR/oMsqQas9TYPBUOMNeewjttN3C7BV5UX/xVcu5APUBx
	2PyV1YKjW9vL71GABIb9AnZ6+mAcI11IDRdRsvhVFJRVqlqmfjlEuui6+3mkeS6K
	FY+cldfXFzHqHGV5XCjTz/URpfPlYhWekHlVEXhmXizmfvOfVeeJkC0ZTHbNu1T/
	cMfOZT1WZeo4LZfgZuZxCR/BFqGL/8DlTOfrW3aHM+v3GRPL+WlARgQBwIzmG1co
	EjsAyRLLDMT8x5GiwNJ+TUgO68jP2fHFZiCiaI4C5Ix41A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bgjcs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 11:57:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e663c29f2so62968485a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782993433; x=1783598233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dcUxmlJb0u+2w0hmOr3Gqno9mV/FfHmW/GhrjwOQzaY=;
        b=EJrxwTto2+FdSvp+RrK/CJITXeO3z62zl0uTHysmen7wl3FXy+PpXXk1amEMj46zgw
         DnKHBOeHiAdEhXkpZY2IcVBkA4+q3gp1VV/lihjPiYTWTqkUTAwTIKm7i6OtIePbLMFC
         QkseEIwluYAsMfQhXR/Rsc3MxiuAriY2h7jaNNxJ03YpqguKDZwJxCIlil3Ur2qJ8jx2
         S49PxKLhfd8W7yyVMA574RhwDA+/eKQKxbmk3zoQcnkTvtbXi05nSD47WoSAGWKZF3Fa
         bJzPNndk58TImzZDt3Pa8BEwxATPDgzmEaYFdvOdx0Tdc8oBtCzqqRxdY+hU5guU8+mz
         9eJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782993433; x=1783598233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcUxmlJb0u+2w0hmOr3Gqno9mV/FfHmW/GhrjwOQzaY=;
        b=mBSq+M06nx+6lmp8I5ud4XASYbQ1CeKZwKU+WN92zASwlzFdxM3YQD98mZJjxWg4ue
         S6nhIQfnMdyeHu3TwsgD2uc452Z0cLl3V256RZPHnykCWklRj2rY4bvCENXqdvO0xlfe
         9OzMxeUKPGBR8kJ6u4NwlK/jWBsM4vZYOrV3efjNJ8MLTUNTN73PJk6npaUoRkcfyyek
         jGex0ZwT2Xpm6ia6JLKdtqRZ4NAzIgL03jH8WgPcA2C2kKJ++bC53Cd3bW7QAW7vF83Z
         DZmvYX7qrvhmCldkDueg1B7IbGRESxQUncnBloSotHWgHLu1DczKoKF6ihOGutk0Y6HS
         1ERA==
X-Forwarded-Encrypted: i=1; AFNElJ8iXL5y+cIF6Jj2/XhdV2aPg2/zb7szyLh0XL4pal+wHU+H1JuFqZtlM4wwmLITsa7O2FWX5RTg2jVspLUYhKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2IJCE8aohdY+aJsh2W7gIchSCcYBOeFrtPsC476MkwZvwBrkM
	O5YrmyfpV6ry9co3VyYzgkJvmNhhD+yhff5OPSnPEo5csMUJs4j5CwS2XTMFj1qWKSbtGnm1S17
	yBlkumRWcJu8bQebafPTpNICH8r7l45dB4motj2MkhosSyEACVe+W7kaLDBjoQ6LBmdEahpI=
X-Gm-Gg: AfdE7cngwDmqsXI6jzQ5uikPmQ7n8/Y3nxcNZYD/rKqItXY3f6efxKM1W9tT5u3+7LK
	zIP0PVYFU+A6Qvy26bvpBgE5zwSIQDmmHqrE1nykRM8FTUJDrb5kfSVTegXvlsGYJkUNFSfpi16
	2L2Wo2qw5Ctnj6QBuC6xunY0McML3M0eVgeT5AuyZ220NZjqnhmV2JzPLj5EFRBqxQS6qMcC/GX
	6YJHgkJmzMennIi3YdUOt7RGkBsiDCnCYobbYr2gXkAv+e4XCTVXvFZ5g41SVfeVofov//eev+X
	R7yNxJVsgeJpvWCgS9k5nUcdkA9pnxkwHt1cBSoMkXH5Eg8gQfWmJmrSTDO+Rt8xTeC4aI8AFQD
	uYF99xu3QiNIcAtDqYbZ0Ej9JRB2dMdCyRdk6PPUOYRDMRBxkvk7UZ5nnuySfK/ivAJCYNckjdu
	PQwgmDhlzRz9BleTgwKT14WxBf
X-Received: by 2002:a05:620a:4728:b0:915:9931:3a3e with SMTP id af79cd13be357-92e697c24bdmr1334936585a.27.1782993433336;
        Thu, 02 Jul 2026 04:57:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4728:b0:915:9931:3a3e with SMTP id af79cd13be357-92e697c24bdmr1334932685a.27.1782993432780;
        Thu, 02 Jul 2026 04:57:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec89e56d0sm618674e87.79.2026.07.02.04.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:57:11 -0700 (PDT)
Date: Thu, 2 Jul 2026 14:57:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
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
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/4] power: sequencing: pcie-m2: Add QCA2066
 (QCNFA765) BT serdev ID
Message-ID: <xzudpqgyunuj63h6o6npvhlwiqduz4ythmbgufovotptbzvraz@q3hhppxledpj>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
 <20260702-monza-wireless-v2-2-7b56e2a6a6d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-monza-wireless-v2-2-7b56e2a6a6d4@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 5cA-NjD386e_m3ppuock0mmIgP7kOQwG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyMyBTYWx0ZWRfX8XA73UZ3rmz2
 /xbgp94IO8RTt95RIp4r6oMoBwr9jdm+xvJ7/CHiSvDRfgHFLNJsl/B1gx95XyOn9+rAi21Sl5h
 pHYc/fp2UV7AZ7uF5TzPw+Wy7NziHX0=
X-Proofpoint-GUID: 5cA-NjD386e_m3ppuock0mmIgP7kOQwG
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a46521a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=HTi0trrisHXCjICuZMYA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyMyBTYWx0ZWRfXyP35wVKfygrR
 NlGF0WCDnUADy6SUvPWGECZ7LG8PvKekBUudP3dX3vwUubwGrLpZ4POAU1LjTtzRkBKAjGnVHMq
 ZoV574rp/B9Hb4LbVG5osPD0UP1POXHaJwz6RUR6hSLzzU1+7KisO6vKGwq5eBPy6LqkA18HgMB
 skNugtrvTur7mLDXqejIAgXIXohwjbnHwsb0U8HZkRJI6vDIxwW4eESJr9h3DNsQkchuxKgNQbu
 491pmmfDiwD0sW53MjeRACRf/KSb3WnFTaYQPllInRI2H3eOie5U8L1WG+Or15nPpKS/e8Pf87L
 5iUQv36LIsV9KR5PzTFmPZwIEt0HU+W/5/pfNiD7Ldy4DtZAhjr0NciDHveSLPw0HZMJXYJnQ5z
 gvTAfdqgiwAi+plIX0kjNhS9xnPXb8o7AYsbcqOpAWQh1N6NOCXmE7bCjOojHGReOKzCfPritbZ
 L7jhP+rTVKWiYK41zVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020123

On Thu, Jul 02, 2026 at 12:46:14PM +0200, Loic Poulain wrote:
> Add PCI IDs for Qualcomm QCA2066/QCNFA765 to the M.2 serdev ID table,
> mapping it to the qcom,qca2066-bt compatible string.
> 
> The Subsystem Vendor ID (SVID) 0x0108 distinguishes the QCA2066 from
> the WCN6855.
> 
> This allows the pwrseq-pcie-m2 driver to automatically create the
> Bluetooth serdev device when a QCA2066-based M.2 card is enumerated.
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
