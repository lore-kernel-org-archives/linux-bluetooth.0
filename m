Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C67F20DD72
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767651700; cv=none; b=QSu/X4MgnMEtg6AEY1kxz7OlyPLd3a5iuES+DX7UYZir+o+resFLc25ItjOxxLAYBLUgXfmpKMYcahn2CXQT7jN4gJyvhcbWlRLPjJyQentBQzDV8Ypjs7AjMSDKdHqjdpsI3b01Y+5HqI9nFpXjwXk28ivbw9UsUOlePXylpfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767651700; c=relaxed/simple;
	bh=hMdb/RC73mO1tw0mVEkrOZtFcrUrwnezJ6vjW0BzLIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HP8AXnAGZIw4A9HeGqK2kkprldAYlaR9OHvAf3bFzG9Vkw2gbzfEjqQ8at4OKueARWsjuKzowH1T51j7xdJPKUzTGAKYXHgGbiMx5nn8GMeOpsfErb0QnJ+aFF6+CJYLnkl1dm9n94EGeVyQj/5uW8eEaMinsCJCamKS6zt9W7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lg6nEOh8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MmJ9MQQ9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lg6nEOh8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MmJ9MQQ9"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605FKZxJ1751461
	for <linux-bluetooth@vger.kernel.org>; Mon, 5 Jan 2026 22:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DqSGOonlwIxu/y9ZKyZwTYNQ
	mOPSkOo/InS5KWNiF4A=; b=lg6nEOh8o/g82Jso9JcQxxV0mDQUBjylagh6oocv
	EJvA76qyqs5DzfBMqmKleis28oWMPDq+KKmseoRhvmaMvDwfClAG8a2BlsyDBhQG
	RYX+8siwXmPq26i9Yfk53jz/1rG7MRtXp8oVphzkRB7crM3I7noDAk0A5UYjUHqT
	/pNRtvMJ5GD/u/gqn+5a2EZA/vMZFdJRPgo3uYmn1BHx15bGYamDRbCQYfGFerXO
	ck05K+BsMh0Yzz15lHvkzXZp4lV2IycCwHYXbYpDYkber6Dk1k/g4kdtahMrax9I
	562sQwJTH+gk9bvjAwsNY6bMhziHRcFFs5ywTmk6JmcWKA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgfv015bd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 22:21:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4eff973c491so8523521cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 14:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767651695; x=1768256495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DqSGOonlwIxu/y9ZKyZwTYNQmOPSkOo/InS5KWNiF4A=;
        b=MmJ9MQQ9EmmmEInBiQJtISSnwNwtme15Jxy8RDRvcfJdUSl3Ke10YwB9jgKb0oIit2
         hJCQk8raLJQ3vM+kNU9SYHG334V//IBI+ynGly7FGGgzDXACXVQqQjxFiPlWCKR0DA1e
         p7QaSGagixZf4r05iOkiWwnuhr70zMi/09BbZFl7bu+xKvMM4YcDmJwHjXzx2Ljmpod3
         inL/dx9070Qr1W3MPAGTeh75XI20N1sLpvmZ9j5WrhRziplhBz/W0HYWboWKQ2I4NLBh
         TcpkynCvdRP8pT98yD8dqQQ5OOyQLdTzRFGXRsi49qbAxkAL54cl6kjTUz+dOLQL4EWS
         xgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767651695; x=1768256495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqSGOonlwIxu/y9ZKyZwTYNQmOPSkOo/InS5KWNiF4A=;
        b=OejabeajqOCxGFPVVhU58hWS8wQnklVOgNNAvpAea7xrcq6lhFaL6MewHfM///iw0z
         +ziDsyQdqkOcfHenMuH+haR374rTO3BxooiAsc75Alm8QBeo9r70N9iXM4hSyZmVJOgo
         ouLMsvN5J4ztbBZ3/jlDz7rOnNCyLpDJxQh0U4YpaOIiLPJGeSN6AhLo8wrgqN1aGNzg
         Ttu+2mLO/0voVMk5voDlnLFcpvz3n/HGY/8MOgdU4+b0DcSxRKolbScAMeR9HQrjr2Nd
         2kV5MI7W2j/qZiHna5ffuP3MwiGsOyKGoOw3+IG/C/bf8mTy4yPBibT9omwJq1YbtsMZ
         GZAg==
X-Forwarded-Encrypted: i=1; AJvYcCVhJ6KXDa08OoMNMoxAgCcLZ3qptqEGduJPpI0wJ3vqOmxddO4xyNPGCtTo2kEcHQa6fuy99SS/4J9m7T1pqRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOnj4kZMpOioJrMD8yjpnJ4sT413B9TZrQ1EOUF8FcZdXbjgcA
	rTDjcQ6pNDbx520YJN5LFXbCXHSeoFhuFy5LpJxKq+tJxxYG2SBVo6iSnRgQluo04q2qzqZoqZW
	Vr8C6v76dymby2bcK+Sq7OuuCDcUIA0ViJZH7ku3g33WnMYJ66nFRYhyHTYMlzCF5+gEKPhM=
X-Gm-Gg: AY/fxX7HAiia6J9wD8weO+Gx7Cf5Gu5TPA8TvmVYRgmXBwPe7G6/LCm/7bIf+RAU0wI
	tdY9rfXagHtfqAynmUDxN6AVRXStw6u3xw7pduDfHvGgpSgfJ69EfywhvB1vMFFD74jZFKVeSfa
	QU9HsTGl0YtwNV9URlIrpmKBDay3PphvHxPlU825kCyCA/rMUJ48kTq4dlsh9Hi6a1i+MS2AcNP
	G9t1oSTvFElpjPcdF+fsm4W/7zi6keLrOBJh/mTrhDBzSJwaJSJSPgjk+zZ5n0rrtaj78n8l/8o
	2a9TB8B3bH3WPcFQHgEs1eOo/I0uojfk3dT2KA60xHN8D3RFTqRrREcG3eLMay0Ycss91I/K+so
	bTALsVZ4biMbjdXijXv6LLC/tAhdtCpV7b+TwFvwV67N+UNN4taOu0AVh1afjxH2dfmp9f2ULEK
	qRzJgdu36a5v02cCbpOdKK8as=
X-Received: by 2002:ac8:5a47:0:b0:4f3:5367:2f67 with SMTP id d75a77b69052e-4ffa759c7e6mr15827101cf.0.1767651695430;
        Mon, 05 Jan 2026 14:21:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH00+N0VRqXqszETrRcdC7ek8LsgMDt9JgQaXbyZibMpPtTxc0rYNXBaymQh0BTx8AadbEPDQ==
X-Received: by 2002:ac8:5a47:0:b0:4f3:5367:2f67 with SMTP id d75a77b69052e-4ffa759c7e6mr15826891cf.0.1767651694958;
        Mon, 05 Jan 2026 14:21:34 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65d6973asm104447e87.74.2026.01.05.14.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 14:21:34 -0800 (PST)
Date: Tue, 6 Jan 2026 00:21:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v3 0/1] Bluetooth: hci_qca: Cleanup on all setup failures
Message-ID: <33fog6pld7q3s5wfc7wariag7wwoct2t3xul746r4tsv6s3nid@5g5bwumtfaz7>
References: <20260105141427.196411-1-jinwang.li@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105141427.196411-1-jinwang.li@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=e9YLiKp/ c=1 sm=1 tr=0 ts=695c3970 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=AuiWyYP7F7LszW4zWhEA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 3AGjZNcR3G4WF2bAFgw35mcEhRxpmOfZ
X-Proofpoint-ORIG-GUID: 3AGjZNcR3G4WF2bAFgw35mcEhRxpmOfZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDE5NSBTYWx0ZWRfX6SHF5Y0cRlvY
 N8olxmPcicwT8o0Aj6xGVKGk08vUN+0fVKzUTsB1v7fi79SNF3B0yBiZxxuYG7h4U9lazwL0aSy
 AVIFbphNvn/THA3MqNf40T1KFusD/Y9ijoKgfXfjJkeWnhmXXPKLtANGGcoZnmJqwPfbwwu5Yym
 o9kXQ9oTigXxTu0g0RWH0F6AxMhZrPVx02FXx1Pv3fbQI1996tUXvULvAZwVcKmMTfqtR1MYPXC
 hKArT3bBMK7EDHgCQ1dm/EppZe4qXda5YKfhdIPIz6MfR5u7y29S2nbt1ANfPYl6rJYW3YkvwWD
 IEW8soBa96RwYO5n3ieBks4nwFFufiH4r4ivTnMZQcdkoxj+U6YEWOF6RR8vWKJdjeHAKa8Rv4p
 jsKsHFGSZLOasv7IKaEjH3JW0pdFpaamk1Vdj61nWEs0KzBsIj/MPnwCmOfjjYbmBZkrig92xE2
 no0ZfeO25f1gL8qbzew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050195

On Mon, Jan 05, 2026 at 10:14:26PM +0800, Jinwang Li wrote:
> The setup process previously combined error handling and retry gating
> under one condition. As a result, the final failed attempt exited
> without performing cleanup.
> 
> Update the failure path to always perform power and port cleanup on
> setup failure, and reopen the port only when retrying.

There is no need to send cover letter for one-patch series. Please
update internal guidelines.

> 
> changes v3:
> - Update git name.
> - Link to v2
>   https://lore.kernel.org/all/20251226102707.3449789-1-jinwang.li@oss.qualcomm.com/
> 
> changes v2:
> - Only reopen the serdev port when retrying.
> - Return on the final failure.
> - Update commit.
> - Link to v1
>   https://lore.kernel.org/all/20251222123824.3000167-1-jinwang.li@oss.qualcomm.com/
> 
> Jinwang Li (1):
>   Bluetooth: hci_qca: Cleanup on all setup failures
> 
>  drivers/bluetooth/hci_qca.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
