Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E51F399356
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 05:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773898968; cv=none; b=R66w4G9ReXxKltDrtyl600QS1Y67MuvD+9dbguDqO61jeP82y39+exwRmLJPz6T5CQ6HO1WWzOvHbUX76gyM0wr2yFT7TOnZdJTuupQsnaC2Z+7uDJo+eLByrUhsoWDjTNpKOq/Nrg2zkp+OR6/bISpmjygLHXemydSwWYlabXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773898968; c=relaxed/simple;
	bh=exRLnuHCQSsOrtJ71v/zE9ncFjdeTRRVRFrKK/OOVw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVgeuSISWMwPIpW6GmHhbZVd/ApJEAsuomD8JrFoitjTi3CksuNIIihYMaW2T7lnhC/VWMQpzmlGR0Q5iQbVArx4Noi5QdnQfaV1nEoVcZleas77yZgYwRhWPtn9l/ongWjz+Jg0Y38ISGcRI3FVBPqaO5txq7TGGxqIMm3K6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B7xhtH+X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E8Ob6+oy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B7xhtH+X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E8Ob6+oy"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J5XsYn1802719
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 05:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r6IJ94K1mctnGXhKKrgdpugngvotzrGmL7GIzeq9Cqc=; b=B7xhtH+XyW27VEbe
	DDarm+24B/8/90sxSA6hRPVc4hCmG385Aa1oJjMwK6hTpBva8vvuDXB7re5Qgulz
	l3C0E8KsX+h0rAKuvolDy+AyxTH9STcXZIOz7Edyk7Rwjs0JVaTC/HVszP9j3679
	aOIUKJrHsuvX3QUXDfEzoKZEJnOn9REKe9xUue6LtyHNdzSvnt8VojCWQl/xi//l
	pF0woFQEBu/oHzYEc/xX9FcFIlgzkmtCXyLWuCFKSSWbaCmZTiDchjZN2hYkiAa3
	SjVwSJlQC6OhyVwN9LKNA0s/OGBKbiBbF9HVQxZEZaepfejqEn17+iNFtLSPm1S/
	FzCOiA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyscb3re1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 05:42:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5091327215dso43201061cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 22:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773898965; x=1774503765; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r6IJ94K1mctnGXhKKrgdpugngvotzrGmL7GIzeq9Cqc=;
        b=E8Ob6+oykgNKqDUNaP4xMd/hTR0d10cKWqpTy8qxKJI3r8kUBqu7mLjyNdX6FWXGjw
         jOcwLEOpvVnD4t7tKZuvueelvwy77Epj7ygTBcSaafK+tV9cJEQajNGd/xnT9SYs1p0b
         tMhWfi63NYcLZGTuk+zylU8V/xVHZqMRAu3/qMoGVwjz132g8Yk/xroE3ttH/xOHt+mm
         WaANpDjlm15dJYjQRTtgET1Nws2aewuRtfo8y7QjiYFdw1BIHwgjt6QKyiyKm/XlBDLF
         rd7be3G+U4YCtO9RPbJ3rnjBGuT3AiFVNsLorE63U5zC9VEaNLfVvns1LcsAcq01QxEZ
         /xXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773898965; x=1774503765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6IJ94K1mctnGXhKKrgdpugngvotzrGmL7GIzeq9Cqc=;
        b=gtZi1gUeArv4at3Hz7BRPTvx2ZER61EMeVRbyK3Stsy7PQD9Ow5sHGzz20EpQlKOTO
         wpGHN/gNc8ugfoSEWBBgxbHQC5Kx0bMiMZpnaktNkbZjDn0uQffVzqEYpXm820niAAdP
         gY2YfQcAkwqdjqNGuxE3Pi+xSLLV77XKodEXb9vs//jNuG4Ix6XlSigVWMsu0b9O+d58
         NPvQCbAunFCVZS84jGNcD+3IroUgkQWWQO9jzNsV8nAwz7SOYt5kkji7m60emxUdHBgV
         y6QHHIq9zJ4x+G7s9fc9XRlXRrqPsHYl8JmUOxaYvwvCjRnPgA+CduQd9kKMW+u6AODk
         1+BA==
X-Forwarded-Encrypted: i=1; AJvYcCXCzYNLGf5/DYTZT1oYOi36y+6jX7RXouQzL6ptQcyHr30rRQ/EpViu71uvA27SGpVSdW4ZB3FIykW/mCnivKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSPk4TynN4c+1jKc2I/HW/R5Fvp2uroXv0IHyLdyT8F8rrfd1
	hoCdThn5LXvFx29MkZC6XW7ALBXk3L8kQVquUCr9zPVva2nYjH1fgLqwAKsCAg0Gj8g+axe481k
	a4wTXnpA5A5Zt+fxGsAVoeKWL6GdvlVFF8HQEJ9irgL0AV+9ezQPtMPcVHkNmXK9EbqX3kG4=
X-Gm-Gg: ATEYQzzYn9izvr7xTcXjQrZO6krFK6pCyQuQGS/ACFJ+bHcVdtum38s3K5T7McP43fe
	jXmZdGFoglcA//zTk+vZYi+T+d/hdi6PpEM4HwLyaevYveNia879ItLV0F1VkWZedtYb3l24xNn
	p5HSmo3YWiUCC2htSLOOLdoNZYtiSrhhkB+6qfrzKAev8XGcUiu0gW7Y1KP580AvsFmTHfblR7/
	BMU8wAsU+7VYUQh+eAuSBTMgPDAwksPrO4Qk1/a6GvllC+E2mc8yv/I4uLwh4/y9IRaaBBIl2UQ
	SwhZpU1T9KVP6N8sxxo4lUDeZkkZmAeQ7otZ9VQeeLksdvvWQlQn/eG+8mMSsl1EOC3TOU84+mb
	mQdNoP3bzYnSD8Bdwql8sqiOzYVe2Rm+CnDcRE1b+LTq5x/ZZmHojQD79cRjQvVEB1SYnBkGHKa
	DDy+w/l7mecxW+hixqm97c7Nqra+7E2HXilBY=
X-Received: by 2002:ac8:5a0d:0:b0:509:379b:d48 with SMTP id d75a77b69052e-50b14746739mr78317051cf.9.1773898964697;
        Wed, 18 Mar 2026 22:42:44 -0700 (PDT)
X-Received: by 2002:ac8:5a0d:0:b0:509:379b:d48 with SMTP id d75a77b69052e-50b14746739mr78316801cf.9.1773898964288;
        Wed, 18 Mar 2026 22:42:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a279c7b7a8sm1003914e87.80.2026.03.18.22.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 22:42:42 -0700 (PDT)
Date: Thu, 19 Mar 2026 07:42:39 +0200
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
Message-ID: <whqo7o6fu6mytf3hpdrrirptx3fpprnp25as3dnam6n4fo7tjq@dolksuaq4irz>
References: <20260319031040.4096297-1-shuai.zhang@oss.qualcomm.com>
 <mcjloavd6jhinb2wgfwihsdtbay5n7zv52tn63kzrabcqwyp26@mh5aet76kl7t>
 <1603a5b0-8edd-4c31-b2d1-344ee7df10ac@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1603a5b0-8edd-4c31-b2d1-344ee7df10ac@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: eLfmPw3D2hdN2I-26fqMP0ByG1CWEU-Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA0MiBTYWx0ZWRfX49MsKq78cJj1
 f6MWEGlMrdHXvU7Ru78z2JG6k+LLfPpss6c1JcwZI4NKejjjQ7nFMY9RQ6dgp68dwnmayXGpu1l
 r/d/mWuXRbbkS6K24vj+dCmA/3QQ2+v+2IndTJWe8BNTth8qEea+VUwR6JlbK9hPSeLJovqgR3m
 /mnrIzQ7eN0Cag0V177uuqcDdKK4TpiPxdlp/HCQMsPEhyQ7fz2ElWsKNQu6LQW3FHucHI9nGAl
 rvANAS0srLbzP/xiXvl3qJenzajTnZ+PwK1TQbp27oNu84ncI9+karwIL05hcFo/UHK/nKSV5EG
 UkxQQh3qypeVWlkgTazbJupdgzwCpChfMCtBCWY/143co0F4q0PTVbiK2u2eLnnObHJuvfZpxG0
 mWWmCsnTMvqwdsFxXSf/wHoFn9SHiRPY668OOgp6hWePPDWyqQQ1DkAblp5YrTy8P2zcSH8Uj0B
 XbeOB2+4/v88o6ABOlw==
X-Proofpoint-GUID: eLfmPw3D2hdN2I-26fqMP0ByG1CWEU-Z
X-Authority-Analysis: v=2.4 cv=PtCergM3 c=1 sm=1 tr=0 ts=69bb8cd5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=M9_Ot2h7v_1VYoE6DvQA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190042

On Thu, Mar 19, 2026 at 01:21:58PM +0800, Shuai Zhang wrote:
> Hi  Dmitry
> 
> On 3/19/2026 11:51 AM, Dmitry Baryshkov wrote:
> > On Thu, Mar 19, 2026 at 11:10:40AM +0800, Shuai Zhang wrote:
> > > For platforms where the bt_en GPIO is not defined, software-based power
> > > control should be disabled when power is managed by hardware.
> > What does it mean for this chip, managing the power in hardware?
> 
> bt_en is pulled high by hardware,

In which cases is it applicable?

> or described in the device tree as a
> regular always-on GPIO.

Why?

> 
> 
> > > Add QCA_WCN7850 to the existing condition so that power_ctrl_enabled is
> > > cleared when bt_en is absent, aligning its behavior with WCN6750 and
> > > WCN6855.
> > > 
> > > Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> > > ---
> > >   drivers/bluetooth/hci_qca.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > index c17a462aef55..4512ff7cd0c0 100644
> > > --- a/drivers/bluetooth/hci_qca.c
> > > +++ b/drivers/bluetooth/hci_qca.c
> > > @@ -2484,7 +2484,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
> > >   		if (!qcadev->bt_en &&
> > >   		    (data->soc_type == QCA_WCN6750 ||
> > > -		     data->soc_type == QCA_WCN6855))
> > > +		     data->soc_type == QCA_WCN6855 ||
> > > +		     data->soc_type == QCA_WCN7850))
> > >   			power_ctrl_enabled = false;
> > >   		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
> > > -- 
> > > 2.34.1
> > > 

-- 
With best wishes
Dmitry
