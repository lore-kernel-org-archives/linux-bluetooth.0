Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB624908D2
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784833629; cv=none; b=ZfdxFJQccJMG+5pMANouxpAQd/EMf7ZEt0dFYjccRY0msrsUvB4sD7zm0N8R8UzImZjMDnQzxGWoQo+LkWBPqcsubSBhW5CRQ4h5N+C8iUpWvV56OT1lHrz6HxsVy5a3zfayuCRQlkq1N0THGMYSyOMRGhamwtlb7LbEKSVS+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784833629; c=relaxed/simple;
	bh=rtoMW12MbOHAMhkFuhaCb1gwFY/CsybOHASfnKomgZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVq//3naC4HhxciTGcfzoE4cd9rL94neJDvD99chiu+ZyLrAR5u9zKPni0LGSWY1tmP2oe5spTxCI97cySSs5LpS5GU5J9H/7GtzV3MYVyxgkoIydwWB7SA3xNnP54mK4+6Gc/wLurPoMq8LIP2IySTFY1ln737h2aNVa/yzxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lL8rP2XD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QpNNT7CN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lL8rP2XD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QpNNT7CN"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NImC9m697853
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 19:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=maz1Ap2uB2Yi4KOKuTZbFxD/
	QNecuW97KMW4HvYQy2w=; b=lL8rP2XDHWmM50Vc0HCzAwO52r9Mg6FKSyCaMdof
	IlR+Zj94SZeX1e29cp++k3dbr4t1Uc7aqV+sPiRDYHOtshGvbydJhBCQjYE8aiza
	6hJLrWz6cYHFNLxWzZOmU4W+eLI4/keqduROjcYnJQGPryPMxHVVJMvzaqYBTU9K
	+jfOt3ojNjvDpy96IIQRfI9HoKIU8O7qFWh1D2Tvj6jIQ5FtWP6gTn6XYLIvMRBo
	QuZi+4jh2PgDwkX7/WYIXICSHnQ+rWzGVxxmC0wXQEpxCk/cnj3V/Oj6bnGZ9qpI
	dqY0OBNIbWVTx9EjtoQ+hiEokckdOMfMM3xXXMaoTHNytA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkg522k9e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 19:07:04 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-744e80385dbso216677137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 12:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784833624; x=1785438424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=maz1Ap2uB2Yi4KOKuTZbFxD/QNecuW97KMW4HvYQy2w=;
        b=QpNNT7CNawdDGnvcpIUiovHlKfFX/Kf0IZuIEvgwnlE2tXE8WKsW6ah+SPDx7fLZxw
         uxl91nrhykgM7ngOOJfTDaRyysNALN0x9ahKpj1uLnF4dOSAE/vfAuxXfnkx2x2Rj8XX
         kyms2WcMKMeGZzuqQ6QdBjoV/AbYMtuQX1LLRcaXqgxmweLnGortHPd5ZTTYTPpB828Y
         VfgI/Dd+38LSczqiFFHdwTr7XLrDZe4ue4i0qdjWtBSHBnIip9NYkSESwt29xlUFBMqn
         M6vYRZ91mFg43CtUe7vwpVB2EBN/2ssCL0eHbh0Z82WWrN4uGH760wP3JuQWqYqp8pcR
         19RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784833624; x=1785438424;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=maz1Ap2uB2Yi4KOKuTZbFxD/QNecuW97KMW4HvYQy2w=;
        b=djEXg0KTRx5PViuN+RQ2kSkmJcmydwcGb6lr/ZfDa9dDnJ9DXxMrv0Tg6Es08KuRJ9
         KIozekLeenSLgd0MZ4yvpYc0uR79Mksb0ljSNFQAXqmQajMlwxyOvhVmulVm6eSnnD+P
         L8GNz1F/k2wBDAu/+aznfg4inHowIRRC6aEJF6buPbVxpwHF2hWOjAirL1wycpsZnUCq
         MGJFH4p8KuE1oUwv4WYMj96gbmvTOBXB+92zerY3ga5Q4sn3CIzeah/VzcKFFH0XWgDQ
         b+GF+BfHgptg7fsXgjaoUA9ZsAGEJuhIHHoZ/fcq9h045sQhfHfi/V+JpdUIEVltGzL/
         2Zjg==
X-Forwarded-Encrypted: i=1; AHgh+RoK+sUx+s3AdUBAlfB4qBZc6C8h35g1cKmm8ju59Ti0JVnERCR2fP2a+WQG4TQJQ0cVD3QWKwJES900lgZWEvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6lfMyNPhRaehnCjYX4GBHolVUAz74XJbh1a+DkBvTSr/hKh3g
	lsTxdPn2ujh50ZM/1uX2K8X94QuUutmC430JS8nVMWdvJhBW5/AbL+/b6kYb0Tmw8jqbTRyd4hI
	4UI7IGoXvan6gjUoOfN3OwKu6XPxWndL5A2//KJogADy+0q/jYvrO0/qMq28UMM6ASUD8fwsYND
	HCMQA=
X-Gm-Gg: AR+sD13cEr0zqFn82h0bv3swDYMG5PxDiVkqrOHOJ47uq9cpU3wvq/qSKBQDzhOwU4l
	pi9izPS7+a/43UggY+pRZG3f56iGSe95WtDCaXxZbp/NUQHIkZdra9cUBjcAwH3T4/B1rKbwLA8
	HdSC0H0Quqx2GBEcRee1fD0R1L/ejaOulgaXgsVXjWlBBGyOPx0VUxZRxiZbBqj+D/GIDdSQR5y
	+/vpRcnOQhkOg1oZoDzwBnfhhDz3clMeuwd0MJZ540MWY1Fo4roZtr7b6ZSzYNWY3ksEAsNkWIA
	eBci/5QJYanjZtvFyUDr61Ix0MFq0YKZl9m7qjuoMZjQWdp8VT5ArGd5XGo92EPpnn9H+k9QYbd
	YMCAB4++lfigs8YEt0r/8UY71JCCnM5ZplCRJEnFW/ZeAVVjRAuEySfb6AoNFcvgFqZlb2QiQEY
	bgKJQDjCXufBn3FQ==
X-Received: by 2002:a05:6102:3f87:b0:73e:5068:824d with SMTP id ada2fe7eead31-74d5fdd01a9mr2069228137.14.1784833623919;
        Thu, 23 Jul 2026 12:07:03 -0700 (PDT)
X-Received: by 2002:a05:6102:3f87:b0:73e:5068:824d with SMTP id ada2fe7eead31-74d5fdd01a9mr2069203137.14.1784833623474;
        Thu, 23 Jul 2026 12:07:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39ef6888579sm10165921fa.9.2026.07.23.12.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:07:02 -0700 (PDT)
Date: Thu, 23 Jul 2026 22:06:59 +0300
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
Subject: Re: [PATCH 1/3] Bluetooth: qca: add QCC2072 support
Message-ID: <vxyc3lgvofl3yrodrzgxh7dtw3aegdcy4bwn7nf6eivhz3ld64@i7romsdep7e7>
References: <20260723-rb3-industrial-bt-uart-v1-0-3c8e580c09d1@oss.qualcomm.com>
 <20260723-rb3-industrial-bt-uart-v1-1-3c8e580c09d1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-rb3-industrial-bt-uart-v1-1-3c8e580c09d1@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=DtZmPm/+ c=1 sm=1 tr=0 ts=6a626658 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=80F9w9wYGjatkqxmWU0A:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE4NiBTYWx0ZWRfX931T6MZFNYQM
 Uprn8xL/qFJ1GneFzLokpfHD+ltDyR413Yo7HgbxhyvdUmESCyeuhKj2dWLQGJgM3DH6ruD0nDO
 98rox0jMVhv6eVId3M2RSiWBJWvRjKg=
X-Proofpoint-GUID: NjrWtffXVPCsElcyLZhE73rfQZ_i1JcY
X-Proofpoint-ORIG-GUID: NjrWtffXVPCsElcyLZhE73rfQZ_i1JcY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE4NiBTYWx0ZWRfX0ypg9+2GJmnr
 8YKH9Cu6rb+BArkA2yYb4VEnWR9j7Cz73T10ToiT9qpYHyyO4cXfqezNObBt4Wk4wC2GrEK+g+R
 enjEGtoVHe2kNDsKpv50Ek6QU5G69AklfsmZinnnxxH+BZ3TfJb7YglSJEPhU3kgs9cPhKqrXcA
 a2+6o3EEIi170AqZutV0mjNz3Xnbt2y2MSP0OdlFJq4xj5ou5/rlcTh1JUrgYZX/z55oN6QHAV4
 9yVSOpsCY4m3nDi1suXjG3s5aRFEFGpshutjFTHCMGRaFNgC2sZ1tn3sYYk2SAm3S1unRSBJV4R
 pO7eWVOJNxX1S+5mjOLsZGXRxXukmDR9E3op12wwf/YHmnPCdzo8hBmjVlf2wbk/DiVTXw+UQU2
 pblrsWSlR/dleoOimMHTW4omjt2qKLRZLsoC6Pu6n2sVVUzkP20vYHZTQdCgC/iuWoNvkXVPAWJ
 PFKPreebwWdc1T+i93Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_06,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230186

On Thu, Jul 23, 2026 at 06:01:07PM +0530, Rahul Samana wrote:
> Add QCC2072 as a supported Qualcomm Bluetooth controller.
> 
> QCC2072 uses the ORN firmware and NVM naming scheme. Select the NVM file
> and BCS calibration file using the controller board ID when available,
> with fallback to the default files.
> 
> Register the QCC2072 compatible with hci_qca and route it through the
> same UART setup, speed switching and power-control paths as recent
> Qualcomm Bluetooth controllers.
> 
> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c   | 70 ++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/bluetooth/btqca.h   |  2 ++
>  drivers/bluetooth/hci_qca.c | 24 ++++++++++++++++
>  3 files changed, 95 insertions(+), 1 deletion(-)

I think you are a third engineer who submits a patch with this name and
with no mentions of the previous work. Are you working in parallel with
no idea what other team is doing, are you ignoring the previous work and
implementing it from scratch or are you picking up a patch made by
somebody else and killing the authorship / SoB tags?


-- 
With best wishes
Dmitry
