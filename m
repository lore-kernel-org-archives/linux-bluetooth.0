Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91443D349F
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784833669; cv=none; b=YFIQ9mhTZg5HxMqFZ/D9i2n/YrX0BjnyhBPKjMs0zzKn4VxI9IK1B/yNyiaWOqQRSlsBhOdNQXZ4jp+m0DeyYSz2EVO7+Az3RgNvnTvBo2wyT6hX+3XoqmNMXuKXEpWy2g6vOZD6JOVfBx7+0Agh4b38ZR193Vj7DnMJCDqX/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784833669; c=relaxed/simple;
	bh=094UwvJU6Tc333A6BTBZeyDFvPxqAHfwYg7qVGbLxDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H51WFU0mSUIYISBZf9onPUUm2lTqV0oqEQXTlC6Iy/vN3IIs9WlCfTP/sQZ0gE0Awh5irfqefNI5Ap+fvd74wsnbaTGdB7OTkMSsAk79fq2M8Vj7DG2psgn6h7HKYbytJGFr9p0JWpCiM5kWCbA84AXX51owYlSNdmytUjYGBpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H3lXbx7M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UjatSUvN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H3lXbx7M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UjatSUvN"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NImFE9840406
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 19:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=q/mRi1bjMPBejJxV31iqf7/g
	77qPxMAdhKBB7jv1Ixg=; b=H3lXbx7MGqlGyZSnCDtM5XzLp81dPJyR+Z463N1I
	mSf0NQMGRWqPyKDhJNAhyUMvu2bZigCzn88cMDe36F0C5Ocgn3yzJowuTAduCHl6
	dwkLQbGnFQ+wc7cjXlF6nSmnCqyaJ5pXN7hOOYgnvxuSZEORSR2EjagYU/fikg7k
	sb+N0aW+sqOuggLl1wDQzQmWYv2sGIG3vhowjlRfxFCohcQGtXFum6eFadUGV+IA
	C/UHSBSJAwm5/jvaa4cMcCpDb50FEX8pEHbOMtBQD3x+ohq+uOCzPxK7EhLWMx9u
	mmQGudCF0KETMG5hMbB0ndn1KYsij+nNl+e0U5+pBhQZVw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa18egn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 19:07:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-526da7e3c9dso19171931cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784833664; x=1785438464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q/mRi1bjMPBejJxV31iqf7/g77qPxMAdhKBB7jv1Ixg=;
        b=UjatSUvNT7xHtcTF2wZRiwc9e8ybLMxp/2V2r/mY44+EeJLRpmtpQjE9A/Yl/lzav5
         LjdNiJM2opuPE8aTa1YXvbPW4bxkQ+rn7ZcVSPIEnJir0ImYiY5Jgg/UG7lvGFri/qcH
         eKeUSnIM1F4YkrHel1j94yw2E23sGB/ScweJd6PsXYbmsX2NUc9LJR1TzcPsWNQZUgiG
         +XmfVrQj4CJggXz4SVWy3rZrbwd7zz8hHnGyV8ewlO7vr+u4RQuky9BnfRbg6yUgG0St
         TG+q+1MH+mgw4WC7gbRYXUnVz/28pcDv7q28Jd1aou2omwSGNb+B154EMCGaBoyvtKNQ
         IzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784833664; x=1785438464;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q/mRi1bjMPBejJxV31iqf7/g77qPxMAdhKBB7jv1Ixg=;
        b=VbJrWCUzM9z5s6sVQ6p0IQo00/N2dOYd54jOLADFkMJ1vxkFduhf9QzGuOZrEA1ACm
         XZ1PQCxliobZ9xtb50aBsT6WD+xsEhgQUFUKr5W+dc2MnDpe3f2uLfI28kFVVRB+A/zs
         CtCPSe3TFZ0WCK0d+EJ7OYknLllOaBJEpi5alU0GNDRiqGooJ+RGvkdk7ozQpIKy9pRz
         KI1/wPfGGsF8XUlZnOHiIFmrN/TtXWt3WB0sX2lLrTJkE1NESstUJiKiEw65LhZYcY6p
         Hok8uqlzOYnqJ2IbmgXhdIFRAwaQoIbDfQVBjjhVtAUl52qkmsquhUKy+L4UyH9XkFoG
         hU7w==
X-Forwarded-Encrypted: i=1; AHgh+RqMaQqEVb7zMZ3FWZGsXoZ1pQ1BV+wAwCUccl/sXxQcJIHDgzeVe3je8ZXBWjnNbE/Kb48CvAicKNKZSwCW9xI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFy+SLHxmVU3WTp/AuP8KxqUtKdBIEwZNiFxK3cZjVEZPO3TzN
	aE9cD3BIMSPBoSLt0KeNDzJteUGNwUeWSKv/EmtE/0AvqeWip3u86jNZP+dE/WWUfYDcYf8Xesg
	y/qb7/HwRHoYsHxRl9YoD/T0jujdY0zsDeT5/XR+YRpTocjIDCMlO7DQYCod325Wpss7MK9E=
X-Gm-Gg: AR+sD11g7g1/GSPsI1/WJR1uf6I88UwegRyyxQvwNoVrStlYByJTrzWYZq2j8KK//Io
	V+8ocHho+7eh+eQuRpR1y/oiXJcWivdjkbgUR3CcJbFsc4Yps4uh5ygOsQ4OE6H0wSNu50LcZm/
	ZKDfc8Zqnmp3i+/YZY6llqu4wF4Iu+Y21jWcMgMZV/TXoOxsTs5nwLCldd0gMXjunOXpGC20X9x
	Aym+DYLWjVPlkd9GR596u4vnZP1C6GxouvM2pUOCM1Z9V6zpT7Hv81OtWRolS2ef+AETBMoyhhZ
	skbp4LH3xd4kQDcQGkSKxRA8nkc8aT8DUlsYyzK8O7KffESpd6cjFWDIwbcFOSPgtqwKrkwqBgF
	hdgEya6+fkUaQD/24hEBTCxcwhYGvx8itRT5sJ620rZK/dMrMoj8rcygeV9qMDWTyb41a6G+cDt
	QkiGWfdN0DLMNeaw==
X-Received: by 2002:a05:622a:5917:b0:517:642c:8196 with SMTP id d75a77b69052e-5283dda80d2mr47439531cf.12.1784833662447;
        Thu, 23 Jul 2026 12:07:42 -0700 (PDT)
X-Received: by 2002:a05:622a:5917:b0:517:642c:8196 with SMTP id d75a77b69052e-5283dda80d2mr47437901cf.12.1784833660571;
        Thu, 23 Jul 2026 12:07:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9e45344sm1135899e87.64.2026.07.23.12.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:07:39 -0700 (PDT)
Date: Thu, 23 Jul 2026 22:07:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rahul Samana <rahul.samana@oss.qualcomm.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_hbandi@quicinc.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_anubhavg@quicinc.com,
        quic_mohamull@quicinc.com
Subject: Re: [PATCH 2/3] arm64: dts: qcom: kodiak: mark PCIe root port as
 bridge
Message-ID: <e5xsbfnsauqkvd24ztew75gqh2l26vbwos2pgvzrhx2qgrq5v5@cshq4gfumvtg>
References: <20260723-rb3-industrial-bt-uart-v1-0-3c8e580c09d1@oss.qualcomm.com>
 <20260723-rb3-industrial-bt-uart-v1-2-3c8e580c09d1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-rb3-industrial-bt-uart-v1-2-3c8e580c09d1@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: ImssTjQLe6KcMy52gXbQYeToIkV2JfaM
X-Authority-Analysis: v=2.4 cv=L4wtheT8 c=1 sm=1 tr=0 ts=6a626680 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=b3m_QctH4RwnUCLtgwcA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE4NiBTYWx0ZWRfXzbH7rGkpC3v6
 JkmNw1ede5IALNMqjUkkZHs3sG55dELaXZpdyUZpMghI74T5cBhUJlce4Ipc4I8faXpcjkvAQMt
 aNlt4nb130ZY/qRAIpzKoXTYRbTLoNgrR0wMuGbQvplhkeR38mIWPY0/WIJk4KYqNFE7I0QafLR
 V98QMij/B1egWRia0Su01aCZy/8SHphuLUjq7z9vmnx4aI2Ic7desQr3Rzs4Ex09NM/7gxmxMrr
 6+M30KylGJdDorHRqXnLE6Ig/ZafhS73pZaeTtC4auD0kzmvMTOUjo/TwivzofKIiFhb+SsgVv/
 Mt34z2a5kJP9Kk4+lRA+g/4cRNBnvezz/qhlqqBPfNN4ql6XvfBUXGB86ZIjVSf6tJzKaRDrCNk
 mMZrQDUqCNMKnHnMXxxYlKnhplokRQluIftGY5RvUAQZ+5V4xZy4itC9N3N1vT9YCCFF/TIxsbc
 4bKlERMnJXFnikdNijg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE4NiBTYWx0ZWRfX8yngxZaej0oe
 vJJFrwv5NtfPS8P/MUcNhmVQtiE+1p+HP/241Pqnir60iW+RFFJpsT6EpcE7cZqBxcm5kjdm4f/
 jKMhl0qNGIXRxiMkbAo/IRXpy/ugOuU=
X-Proofpoint-GUID: ImssTjQLe6KcMy52gXbQYeToIkV2JfaM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230186

On Thu, Jul 23, 2026 at 06:01:08PM +0530, Rahul Samana wrote:
> Add the PCI class compatible to pcie0_port so child nodes below the PCI
> bridge can be matched against the enumerated PCI topology.
> 
> This is needed by the M.2 E-key graph description used by the RB3 Gen 2
> Industrial mezzanine Bluetooth UART overlay.

First why, then the list of actions, not the other way around.

> 
> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kodiak.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 

-- 
With best wishes
Dmitry
