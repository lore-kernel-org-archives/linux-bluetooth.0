Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F86235DD07
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526396; cv=none; b=pK65ohhBs5OovrePkexHS71L1QAiTXxon0jc3eLZD8JtJHkQpjiXsfj10pwsQwIEjFeC4+O5oyfJu9HICSLb8zcNsd5H4l4vC8IMNJDLxVXC5SvBEKmQcPGUxj9wKurxqlTWM2idXsOlR6xBr6SJNWMNZGn/2nX7ySa1J7oIPqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526396; c=relaxed/simple;
	bh=rF+wBZLJGVog8Mr0p18tKHa9iByVNTlYEwMH0NsBhaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwwY9Y2ZoBZ7TwZCmYS02/rGOiFhhjsd3PqUPnNTwZKh9WL2lEEhZb4pnC42SVvoqusOoEOzdEqK1wCs+i5JS5WZ231e6/MsH7rYoeoqO8VUWvjkzKov+FGFLweo414qKQOavHSTmtmyQejvrWLdInkIkqF5M7p+hLWaH54pA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IeStlwHV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FCOQGiYD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IeStlwHV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FCOQGiYD"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RAanKR495955
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 15:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XCIIqC8A64YwinXZNYsAm37j
	XP/MVxvMN1I6jJF4pp8=; b=IeStlwHV3Qj+wq/beLnDnQ003WIseP8c/DTeiwp/
	nM4Xiy8CzOXNSAH8+ixIUtkd5M9mgo/6qMhZ/tzUb46aWaLkSMbzrCZKcTmNjAty
	dCyOslKKT+S1x6x2QqsFLhwK0rJVwVa8MwQuUeS4DLSitIJ4g41xo3WWmMX+RAB2
	haD4o2qg+5O8lIc3UUQBNg6fXYnK4h3DHvYcj9lKWmGF6I8jDzQhNkFFgtvdnIHD
	MlCGno/a/dXGIjbbBVC0GqLAUQn3KxTQEcFrs4cpgAdXsBZO0/iPSTaMVrbMc75t
	UfIpicru36LXLhT/5W3AVTxT494ZZPv6yUAJfylHaxck+A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3bk6pv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 15:06:34 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5ef2cbe9fa6so14415231137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 07:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769526393; x=1770131193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCIIqC8A64YwinXZNYsAm37jXP/MVxvMN1I6jJF4pp8=;
        b=FCOQGiYDsmCCkGjal8TmPRf6IDoZq4YayIBwgRmdXnriC63R7OPy3S3R8Yoirs/Wuq
         T6MI6izjPRUMiqNRL/D4lXsYv5oTbjD3R/M0Vert3TJpe3lsmN3GC60GJPFHD2Dklovs
         SRfKjnykKaElAAyH1WIwVWD5ga+6e9zv2HmvEeGv9JOeoEFz9h5GibkCCSVgtCrMP1U7
         /pYhWKPLnagiUAKv375fL6bNqCXSfHc7koIqsJVpa233zPCcFUf971q/dKU1foB5L0sc
         zHVyRDL6P5Nr8qtk0WfK91C44HrwKKrjLIdnGh0iEDH17rKjNFLn/uuQtnbcX/GfbAQk
         PRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769526393; x=1770131193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCIIqC8A64YwinXZNYsAm37jXP/MVxvMN1I6jJF4pp8=;
        b=YZt5DtrQQe8vjgmleD21it+2jntzdH1+hFQK+Xo4+ZRi84YZb9njZ9qfWwV6PEa7zu
         YE2XTxVbH5HnbD5t5lM+MDhdp7iHMB+adEG8M36ayZxsvRurBXmejkXa9Wccg1Am9dfR
         hk4i9eRmlwFOm8Jct1MI4Joq6XHmEmrbbo2ZcrBqyjU95UUcWK4MBSNszYbgP8c83MsG
         FzgJwkm5lRWqACTcv4PmR+8C4p7c8lh5qaHeWn4EnDq3ZCDefsL2sTlt+ASgOgnOFl6L
         E1Zyj7eTubMLeWn51LgAG6CnLZj8JPojfETc95ufMrnFzS0nzpP4S1MetfwTtODb1U28
         OLxw==
X-Forwarded-Encrypted: i=1; AJvYcCWY2GX/QwG4wT1FQJyLAVul9A8WpJjV7yVweHWDVIEK9FyhmQdMG9tKHQLUh0ouLHONWHvr2dqh2DzVV1vd4kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO4M8rEKMQqg/A/yD9z1tvCwTmidwSe+8z0sM9ClpjXmFHqcBA
	DCJcFDEi1Aq5r27ss5crqjz4lsZ093p5B0zQEqS4wTnPyqwBN+SXEXZBbgX9vAhF8/iW9u0kXLA
	Mu6VjwwtL4UmqWt/VV2rV1u/+q2kRB6f1iJX8PO2gZNMRrB01u2NxTZ+UGOFoZtSjpKoIAEw=
X-Gm-Gg: AZuq6aKjawhhFPSHm5JPZSVyzkt/DXgxzzPUhRy6Xw+Vnkrlisb3ScZJIq83RUv5zfF
	giQJJFtLLa7XzUmMuWpzB0xiMgguHG59I/4YeKrwGix8chHrNd/V1Py/C4j4noeXztxl+V3t30w
	gxJMSyDtE4lhPeYc36zgi9dov2oB2szTvbv5Ou8MEKRj+CJZRf8IBN89Samr3MLPr5ymFbZ0YwI
	XAEyNr4VJFV5EUJ5yw/F62I/KuVhTGPxFmt9EDgNn895pf3J5f8+LTqJbyF6ub3Mnn4NmcdWXbc
	QVQv/N9YoRYeUDBlrY1Ij7lGVvoh/EAIEfC4hp57QrJIf079+0H1YoBQHMFDdHDHpmCLjj6w2FA
	qBzztvgxwzbnRv9HIJQDQm+Oow7+XeZ0nrGFNFF6FMBeY+SAHC9in8O9BE4UKwoHPeHK7WydAOn
	/Y52BVf4eSHwO9Ogw5fcRWb9A=
X-Received: by 2002:a05:6102:3f07:b0:5f1:ba4d:8946 with SMTP id ada2fe7eead31-5f7235f5e95mr798012137.4.1769526393530;
        Tue, 27 Jan 2026 07:06:33 -0800 (PST)
X-Received: by 2002:a05:6102:3f07:b0:5f1:ba4d:8946 with SMTP id ada2fe7eead31-5f7235f5e95mr797628137.4.1769526388866;
        Tue, 27 Jan 2026 07:06:28 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48ec121sm3463815e87.42.2026.01.27.07.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:06:28 -0800 (PST)
Date: Tue, 27 Jan 2026 17:06:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_qca: Enable HFP hardware offload
 for WCN6855
Message-ID: <l2ib5kalse4nop6e6ak5xronejxusnprl4qgz2wxvdw7wpzw6e@aa6fn35id4we>
References: <20260126162444.4194293-1-mengshi.wu@oss.qualcomm.com>
 <20260126162444.4194293-3-mengshi.wu@oss.qualcomm.com>
 <kej5u2hjxjtfdzmgtebns3amz7gmb5d2nciy45jsyglkprgh6s@kt6fodrc3oll>
 <7b9fec28-2272-4ff7-9575-76e72cecada5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b9fec28-2272-4ff7-9575-76e72cecada5@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Y6UNS8KWOtEZ7Q9pHHn9ieQEBLnkIkx2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMyBTYWx0ZWRfXwhWwlT26bqog
 WEsIPteqU2CwZ5O5eAfvivSR90kvanYwF1BUqe/FfKoaZEyO8ajoVPIO/Js/VXTHWMC6I9FkKgs
 CfJIkoJto3qA4wPYLEuHtGuMFT+TrZ1dxW1bR74jssLkEYF7Otdr1WalIHo42kn3hErNJCj1zE3
 HsxoMkwYct24f834pBRMkOTN15HY3BoH+E9X10BsxNLrHF8BDxqo9kIZBf7fm6o3j5qUO5E9JN+
 HFfT73MfC3F1Rw8av+siM82zS7RSgjkjsG5bzrNcuOuTJXkRR0r7L2VBr11DSp0CnQbxUGf+Jfz
 VTSgxcnEtv7nUQXhBahn920DAOn16BR0ZdQQghL2N8inb9mkop5VOh4YE6k5Q5kT/KzNzdStLJA
 AfbSe+Z+UuN7N1hyzRUNs5QvIcQy8IyEzFnlARUpmYc7klGCt05q1zrZ/CvCcG+Pv5h4HE8sN48
 MHJ1RqJcyhRQqTuO/qQ==
X-Proofpoint-GUID: Y6UNS8KWOtEZ7Q9pHHn9ieQEBLnkIkx2
X-Authority-Analysis: v=2.4 cv=AOFXvqQI c=1 sm=1 tr=0 ts=6978d47a cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=h7lLkuc-r4rZPDWG9ycA:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270123

On Tue, Jan 27, 2026 at 10:32:58AM +0800, Mengshi Wu wrote:
> 
> 
> On 1/27/2026 1:51 AM, Dmitry Baryshkov wrote:
> > On Tue, Jan 27, 2026 at 12:24:44AM +0800, Mengshi Wu wrote:
> >> Add QCA_CAP_HFP_HW_OFFLOAD capability flag to WCN6855 device
> >> data structures to enable Hands-Free Profile (HFP) hardware
> >> offload support on these Qualcomm Bluetooth chipsets.
> >>
> >> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
> >> ---
> >>  drivers/bluetooth/hci_qca.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> > 
> > Any other chips which would benefit from this flag? If you are setting
> > it for WCN6855, I'd assume that it also applies to WCN7850. Should it be
> > set for WCN6750?
> > 
> 
> Thanks for the reminder. This should also apply to WCN7850. WCN6750 is not
> considered at this time.

What does it mean? It either supports HFP ofload, or not. Does it?

-- 
With best wishes
Dmitry
