Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4BE81732
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589901; cv=none; b=gqvWjU1IFDl1S5q53eJhsMovUUtBQk+tFgpViNrg3rpYbufPoRfMSURzu5u1+7+DG3D8mvfqWKFcMIJn+7e1gVWDWDEO7uxEwsOAt4thua5RGP1CM9mRQqW1HNPTwCdo/ooVbLpQMnJ1692azlZnehhpf+VGi0woxeVmv+htdvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589901; c=relaxed/simple;
	bh=hwDV3OUoJA0rQhhzEfToTTZ3S31BRQrNzPCNDLh47/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOWUQr/smdoHa2+wrigQb+hs+ma/CtHmwVWxUWkrcg33rFtMC+w/8imJFAr0USLz+fxitbTiC9H8nPoV2hZWRy+Amf2B+zlvsb8rmn95zTcizXl/SE0WNAsMErxTEgNj3+ZJGgfKgky+zV1HKjS7whze5HLpxxZBwwAuMeLFQ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WeZQJEFk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WeZQJEFk"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ILfbBO025278
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 07:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=C2elg3Tw3CQ12V4g6n5Sj2D/
	PhBEsxUy6PtoreBc6vE=; b=WeZQJEFkDYZ0bj5FrUoybYyK5zpBmRLluvgaK8dt
	2UD/WEiOuHHhZmnCG1F+yfssh019F7gnWoIFVa0Co0gxrV4e3B8iqpXXmcXzIU2b
	NbBg49kKsUydaXSczMzxwHq+EQTwZ7RYHngb1YvDYARqfmEUIvPm4K99Yb6yVSa0
	XM0x6IpPOcf8pbQ/EfuehQVPidg0f3IEgyAFH25qs8bNOl9z2jReONa91R3x3eOc
	QDpbf0XMIb+8Yh+WnNNMjIdiyXweT0ES9HWWMTUpEMgYtRkvJFq6QWDHATt92X58
	gUUYX4FQmoapNHLgin273lFKC7EVLwAu+U9fbiZX75FMPg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48mca5hcar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 07:51:39 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70ba7aa11c2so79744516d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 00:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755589897; x=1756194697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2elg3Tw3CQ12V4g6n5Sj2D/PhBEsxUy6PtoreBc6vE=;
        b=POEq7dCe7jHrM3YArQk0vbr26Up//q8SHpJd9thX+IMtm9Gd0oQFAxwEgatSxz5Fq7
         eIg5lA4lZVxJ1n41i2xXyne5KR1HE+/to7J9SSFzW8upsrUJ3RZ4k0+RmOJLzaEly7sd
         qgtx80GS0nopJ+DNUaT9lmnYv0/m2Ed+3/C+gTqaz22mmx6Wik15hflSnHa8jJiW0O73
         DHeUWU6PL95s1BRHdr7YzUU9lU3ObxddiUy4/Zl82zg1PMY1zT9IxcPUw1CiD/ArOSMe
         YdUuqT02NNdOQ3ZbIy6fCmYWA/YBhbYMcsf5OBj+7cCvzu+q/kUnnXy6QarUn1LsKh0t
         RdJQ==
X-Gm-Message-State: AOJu0Yyo9ZMTtX0ScRz/a/2jwDVRNU3EYe6jsWCT72piWGHvUrq165GM
	7OB5zSbLwo7BCrFzWuw5RF8cBP6dETasG1JTLpVP6njndDULlLXXVTA83YTMbCkfL46bL7IvOrk
	ifxEbKIIM+unAvLWaux3UfVHFI5LOazuVBWUJe4VQXp1QRg8UifXavxWrD4b8kRzvjIMGhn5gkM
	WW7nQ=
X-Gm-Gg: ASbGncuPxHOFfZKhGahgrilfAT/ezbQR5yro2QoNLXPO6XwdTB2grNrxkTzRCbt5RJD
	yRPM/NhgMb/8wz4IzgE/csft6ysbnRJKdU3Mq+wfRqcSsQd9Mm88TLlFzRw9+jxARhJttoSgfpN
	wrouee+3rJro2mUbRZYsiL7jKbUl3jr+11ddRgYEXRQauhFDk9HuGNieTi5Q7QVkKrNbzbkZVah
	+R8QxxWk1mEy7mH6WwwnJB5dFzBMCJ/0Ztmk+x+FPebLKVUX0hn95w9C7RJQgSVVxbmuo2PPmXp
	ztJvzctcrq89eT3uVOGsc8nSVlA4PGFqc0sXVyB147DUwDA5jSuB6MAjzXejEaDxvEOxQyfe6bb
	AZ6XL/430HtoSEtbBbKetmpsNNo2QGHDNQTv8T+NtTzvKzkBw8E+o
X-Received: by 2002:a05:6214:230c:b0:70d:6df4:1b22 with SMTP id 6a1803df08f44-70d6df41d6fmr3058986d6.63.1755589897480;
        Tue, 19 Aug 2025 00:51:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd7TfthtwS1n6N94DNqFy91G0YwJUeyAGW3ScRdrSu7GyBio7wRiaGd38hIQfnp+eeCRK1xw==
X-Received: by 2002:a05:6214:230c:b0:70d:6df4:1b22 with SMTP id 6a1803df08f44-70d6df41d6fmr3058816d6.63.1755589896805;
        Tue, 19 Aug 2025 00:51:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a41e251sm23188641fa.11.2025.08.19.00.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 00:51:34 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:51:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_bt@quicinc.com
Subject: Re: [PATCH v4 2/4] driver: bluetooth: hci_qca: fix host IBS state
 after SSR
Message-ID: <npmyohftd37zpnvwgzet4vasji7m2nfygyofrrxehmisrygyou@3cz6yanqqcmm>
References: <20250814124704.2531811-1-quic_shuaz@quicinc.com>
 <20250814124704.2531811-3-quic_shuaz@quicinc.com>
 <ndgufkvb7gkqeco45xlru2x5ai335s3vhx6wso7pksqcyfdjll@azfjjboa7bc4>
 <11d06cd6-60d3-44fa-94d1-7917adaa0230@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11d06cd6-60d3-44fa-94d1-7917adaa0230@quicinc.com>
X-Authority-Analysis: v=2.4 cv=FdU3xI+6 c=1 sm=1 tr=0 ts=68a42d0b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=3nUCoSrt7Jy0hBid_xIA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: M9Cmli5S8Nkj_0yKwLYINtKiQLFXXSor
X-Proofpoint-GUID: M9Cmli5S8Nkj_0yKwLYINtKiQLFXXSor
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDIwMiBTYWx0ZWRfX7P78v8fyQKts
 CCB++dmO8j/dECO39HjQeqTeszY+HD5oUYVT1Pz4EP8Qd/SRq4/K3fUwf+9fRqg3VXQXqBw44mT
 pUaWDToFbatHkZZaRFNqnCE/51ve3uXcBwRfGT1/85YBs4BqCNTrF7ElaDuUrb4aAcguaeFo8xM
 E7uij+DSX8KypOymDMTAfNNApVfP01F3qiJvLp2EdDWSywmed2Fj+L+h6bFU2gEW0tG7XIPwsuq
 nvZKHBC4bPaVV6g9rt6cn1+5BePzOXmuRYPzOkEGQZcfzrEHDA57Q8NnokPlw6iRXYSmomuKZwn
 efNDeB6vAfulvB0FEhqpeeWu2A/mvBaW2tIH6mddqPDsStuSH4rftiMv8lw0sQjcrCs7TCkyDud
 dIK8XHno
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180202

On Tue, Aug 19, 2025 at 11:38:01AM +0800, Shuai Zhang wrote:
> Hi Dmitry 
> 
> On 8/16/2025 5:50 AM, Dmitry Baryshkov wrote:
> > On Thu, Aug 14, 2025 at 08:47:02PM +0800, Shuai Zhang wrote:
> >> After SSR, host will not download the firmware, causing
> >> controller to remain in the IBS_WAKE state. Host needs
> >> to synchronize with the controller to maintain proper operation.
> > 
> > It totally feels like all these patches fix the same issue and should be
> > squashed together. Please also add a sensible Fixes: tag. Possibly
> > add cc:stable too.
> 
> Although these issues are all related to SSR, the underlying causes of the
> errors are different. Would it be appropriate to merge them into one patch?
> 

I think so.

-- 
With best wishes
Dmitry
