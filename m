Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F1F324718
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776541108; cv=none; b=U7ZAjbMXC/ib+F4OAcV59dz5Z4Vs4KUhvJ/aYJLXIcMg/Y17z2t1dzILZA9ZqmZqdzMM7fdTTAYQq1NoFP/6UIQn13BFXgxNkFQ1b2CsQgEjSgMYv2naiYRHOrV2jNMBZuV6RQRa1FeEj7Bt7uYK52kf1mUkl2iQZZFFCKHaSZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776541108; c=relaxed/simple;
	bh=D9bDtXxW3hYg3zOewGGHaPyX3bjoSoMDKPBs+JVD+jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRqG14zfGpQfCpM2r5sz61XrT4kLo9g3UGtcV3K3JE0/8t9heFx4SlpsL79tCyKmtOBQ3QLmPEAgkBtdH/jzxWSavOiVhdtZZ89gZ6zcV5rnNWfMTvjhcw2RlvhZBSc3I19rw0E15YK6K1nV9Cy4W1T9Q958llokyNe5sQsvv+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iPZXIwGw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GvFRYeH2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iPZXIwGw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GvFRYeH2"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63I4Vn6U3443547
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 19:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kbwvqRx22EuSdW1o5avcOXEZ
	l4XvhLf+30K9TnHpX7o=; b=iPZXIwGw/DRx+Zt91iZVqqLZHLhQfaqwatR2rPg1
	i8q/oA20HMpxH46pXKnyynNMPPH3db0oFL2PK63Bs7E27TI5ymG5qeIbZF5BvULk
	fRL+sK6vkRG52aO4231tZMZp6/iiQg6i5CfN59YvFzpx/VShtp1gXg1vrhaOqV+d
	sFE0aHqta25IQs3krIY5t1bY8CMV3neSQM9FM4XkgLm9RecZM35805nez8FbngXI
	oSi3ULWHzpk6HGHHBH/6wUwPVCfWam5B1MN7PYZg5E1pyeEM7b7ymoyHzfk2d+Mo
	pacK+MXqrVp5Yz+tWcCcwbV9AGMreEJX2ukMqJDehzcNAA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkyne9mhk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 19:38:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50e423a05c8so21335361cf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776541105; x=1777145905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbwvqRx22EuSdW1o5avcOXEZl4XvhLf+30K9TnHpX7o=;
        b=GvFRYeH2nJbXQnVmTxae0cy5BJ8CC7+i6hHTuJzCbz2DZFQuqsp6h9lsSypaJ+R+cI
         jah43EYBSdWQPkMBJjUnHE3D3EJz4oShRVHehZgZmrdRI/vh6JqMfaY3/CAUzsagDUif
         odZGQ6ir9XhXkXSZX0iC6WBSmaCpVKaIiO2H59+3lW2cE/HmZl3WtLyBFpiok1/7vgHy
         l65wNvqR2nMICFVuR1Ly0GKJkTSrCUBtAW8nkQLStdyGAp/xHr45qG8f3S12jxNDg0W3
         mknq8FT85rCigmT+2sj++Ytf0n7KH6U+JgqhVR8g0473fOUeLVokq9RNKiQ6jEpdvRYz
         M61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776541105; x=1777145905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbwvqRx22EuSdW1o5avcOXEZl4XvhLf+30K9TnHpX7o=;
        b=YAQ9LcKzUW8aQLv5w9uTgE/sWE/fXiK67uWm+234CKjFkyMLVRGqNYJPjDp/zKiDas
         FJ9/QfUIHbJlz25ifHpXwHaVMjHOyzUhv5ev+VjBi9rYU+v5kn8L5wBOmC535Vkeb19s
         kWKfrkQofmZEreOYL6IOb38rZPsPccvKY/RNHNl5dEBQvsGZoOKqM9058LsYDoD5QmLe
         V8zufB8y2uz49PzglKXixOVefjQgxS+JGMazwyUgAegBHjdDgyAL2gVJPIKXKLax2WTb
         ah1u9zaHzgnqnV2TbF9nq2Jsg/CpYq5uFNT507nYcb+ZCyyoIC8DELussUt/NrCtaXIA
         jO7A==
X-Forwarded-Encrypted: i=1; AFNElJ/hpqr9EXkCkm8BW4TXQLdhKGnszunyHdVrdjigC/YpOAS11sRhXRUudy/rh7yUmPL6sZ7+5+Qtk3e8GaBQyQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyBdS60asy4EIBzGw8bKirzNGtBRjHtIwIcGvE4/qvFYTZQyNZ
	+HdTRAmkmQHb2YztLbjR+rYD0rqNRb+EWjGRvz6Ccd4DUhrFZ+PFqFT1EJ5pwGHIzcu4EM1wVnU
	oQJkdo8i6Oji5051jhVjzrLpjQITx0RuYBh7MoQqBibJAQpxaWfY1X8fWAjd0zKljDrcY4hk=
X-Gm-Gg: AeBDieuPq0OzV+70noHmim78Drkf0HBDPQXurl6GEvwOwdLi6yVZphwBR0P/2pZlLwn
	aMrW61UTbfpKrmI2ZYvvje17kBNIMXj/Om8aYpusmp9wF96nJFWjMTzlm2AkohmQbS7ICqKx1P8
	IOEa4f4xSBhfELYsWKnj+RBdawvworoyqWs8yqH+i6di/FUlDecOHMEom7fGTRsHRZkEIlBTtv1
	FT5jZP8je+E6xfbXgH+71fzanW0tQgN6nmMdSCIPwNvBrnZdBaCoZjlUuP0IqbdhQS1MJjJygLJ
	1qFpr0MAU1r7ibuQJ28IhCZ2Mvga/g2TFZSZ4YVmAbslFVzoPgadv6faeOXWrSHtfQWzMy7IpIg
	0RLMU/RVftpQe/n5qNKC1S3RBAIuzLbwkpUTKv4yCaOut/BC//xpagE+YOFdnihrbLPlVXt3ZK6
	3KVq3An6zcOife6X011ta4QmN0Jot5pZLewyjaCFRKqBT41w==
X-Received: by 2002:a05:622a:48c:b0:50d:9c1b:941f with SMTP id d75a77b69052e-50e3661b147mr97389871cf.8.1776541105487;
        Sat, 18 Apr 2026 12:38:25 -0700 (PDT)
X-Received: by 2002:a05:622a:48c:b0:50d:9c1b:941f with SMTP id d75a77b69052e-50e3661b147mr97389461cf.8.1776541105035;
        Sat, 18 Apr 2026 12:38:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e7dd0sm1553387e87.69.2026.04.18.12.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 12:38:22 -0700 (PDT)
Date: Sat, 18 Apr 2026 22:38:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/8] wifi: ath10k: snoc: support powering on the
 device via pwrseq
Message-ID: <hdypom3nioc6tk26gh647imy5ykhcjqvknideilnbc2b5p7eo7@hm7fsscleutf>
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
 <20260119-wcn3990-pwrctl-v3-3-948df19f5ec2@oss.qualcomm.com>
 <DHUHU7UIT487.139L3KIVRVREU@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHUHU7UIT487.139L3KIVRVREU@fairphone.com>
X-Authority-Analysis: v=2.4 cv=HbokiCE8 c=1 sm=1 tr=0 ts=69e3ddb2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=Rs7pINfTDodmtXVth3IA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: cKeU2KJvsb49pFseRHBvD3vPm2MeCAmc
X-Proofpoint-ORIG-GUID: cKeU2KJvsb49pFseRHBvD3vPm2MeCAmc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDE5NiBTYWx0ZWRfX5mR4DmWdbcR5
 LjxzLqCrO2t0mm5AM6k94aXhDan2KtXM//Y1YFhEMScEDCGtCHyUfLfdTmo/dTBGIoLnXV9ugn6
 41nq/VGDbXv4gDf9s8fzA6J2x3AO8KxbWA92XpTHOL0VfQ6zaX+K9BrIPKHF2i8sP0dVoYshTr2
 ovQwQ5SavBzGiDOUYoB8Ok4d8tDTuR/ObQQUGODawVg8HzcvlGdVynXql1eePjjVvvsHcRWkC7S
 OCaU8ZWtTw5OnrF9ZDFXJ9bWpHlhvRdNj+NAADzZ05/3PmJTawnv52Vb3ZxiiTI0oV/zU5rHqD3
 jJLiJPT+YOpPchECqdxw38MPxEVW6qiBUYAPABshNAhfrgeAzgZrjjDvOaaDBLEiQoZjK5Q2PFQ
 GENfHgbYQnNrX8dofrKgZKlqXwLbc9BCemyJwIyyyASJVCtT5i00Oq0ejNmYrvwgpAbSMvRmV/t
 XWG6IbGxA8rgm1FAIzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604180196

On Thu, Apr 16, 2026 at 12:06:09PM +0200, Luca Weiss wrote:
> Hi Dmitry,
> 
> On Mon Jan 19, 2026 at 6:07 PM CET, Dmitry Baryshkov wrote:
> > The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
> > voltages over internal rails. Implement support for using powersequencer
> > for this family of ATH10k devices in addition to using regulators.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/net/wireless/ath/ath10k/snoc.c | 53 ++++++++++++++++++++++++++++++++--
> >  drivers/net/wireless/ath/ath10k/snoc.h |  3 ++
> >  2 files changed, 53 insertions(+), 3 deletions(-)
> >
> > +	ar_snoc->pwrseq = devm_pwrseq_get(&pdev->dev, "wlan");
> > +	if (IS_ERR(ar_snoc->pwrseq)) {
> > +		ret = PTR_ERR(ar_snoc->pwrseq);
> > +		ar_snoc->pwrseq = NULL;
> > +		if (ret != -EPROBE_DEFER)
> > +			goto err_free_irq;
> 
> I'm fairly sure this is now broken with CONFIG_POWER_SEQUENCING=n since
> then pwrseq_get() is returning ERR_PTR(-ENOSYS) which is not handled
> here.
> 
> I'm observing my ath10k_snoc is now failing to probe "with error -38"
> which definitely seems to be related, but I haven't debugged it further
> yet.

Posted https://patch.msgid.link/20260418-ath10k-snoc-pwrseq-v1-1-832594ba3294@oss.qualcomm.com

-- 
With best wishes
Dmitry
