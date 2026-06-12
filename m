Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D323A5E65
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255557; cv=none; b=pcCEsLqL2OkuSkVo7FA5629Bn9Uok7x9kcgL/Sj0bOUQwsMpxk6Sz3Frocw11gFcQ08GfwPHJfaM9VU0YwzGwDjlbnN3z7SHJa4Mvmqx3/32KPry75MN6gkMBOxIiEsxHfh3HGdC7cZBalPuXLBwcfdNCBa8mDY7wIsmbdLnbj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255557; c=relaxed/simple;
	bh=J1AFntJO8yn66Ges7ZIJc4qYkwhNSJYwQcAxHEZv4U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2WvgCpVMZT7weuGaKR9ZklfyCEeEtn25jJtR6l3Ij/dQIYLe6Tc4KCVrYRGE8m/6mqZuvi6WqQD7b0E+3lbZ5lDeWr0ZAMFb7djV8SYSrZ7oFgLTiPGOunHlh0dttATJHGBubZarx0KuRFR6jFUghvJ8qbh6RxJQki/8aDTbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jFNQOBw0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bzs5AY5h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jFNQOBw0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bzs5AY5h"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C39WvU2516140
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 09:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fQHHtK59LcboT6pjvqkOS+sy
	sywNj2Fo6GwGmNW3Glg=; b=jFNQOBw0YkLzDcDJnKXoiojTKiEGuD6hPTR+kfeE
	2ss4OSCbPpXkPqcf78P9LgzYKAqxaVmcPlAGqnC4mH8u2xP+ivX8Z1JKJgYJEiuu
	tFZy4jkbxlMuHM8OS5TEILW7PcEy6XJ+vVd8MXZaQ873NJ+HB+Ao1D4o1bO/TyIV
	VgTKANxBx0aZTaKWlh9+1fxOJPmQWkduGpSZMoSm+IRWKyDvfkHt0jY1Y3IgaWBK
	15jG+1HAywMpEhomeAzvahK6xEPIWgg+hnoa6czhQ64d/fuNWtlXMgaVvJnAfehT
	+9DqgRSqF6u6zfiAclJrVi8a4I0g7mc3Ush60MbZ8QcBMw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2r72bdn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 09:12:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-517c65e497eso13447091cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781255551; x=1781860351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQHHtK59LcboT6pjvqkOS+sysywNj2Fo6GwGmNW3Glg=;
        b=Bzs5AY5hQbtm2yrX8Y7CsMdvX1vXyovoF338iwmc6pduDSh0fBPKgGcKAOWdyPdFPD
         Qx2hsh1pZm7rooj/VzOsLNR2qzQi0q2AUuViLiMFfMkIzg2kGv+8k3PRyJN8g4+vXWqy
         MwS2RpM8YRMLpFraIPrhA0QmWKnQXiuaX19Kd12sWxNivvXE0ummS4ZmQmpbOc5Ftadq
         z7LTD34t/tfEoM5EaEPFKoHjNRn6EXGblmUNm2RgIdpmrnHwL19fIA99wHShMtUL4ZYS
         lFjct99L088btDWL3ObIjPVGyw2ZpuIuDr4kF7nODPnKZBVJ01TtyB4x7qa7I4ESWqsZ
         sjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781255551; x=1781860351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQHHtK59LcboT6pjvqkOS+sysywNj2Fo6GwGmNW3Glg=;
        b=iXQAICXoDldkrt9btl4Fe3dyQIleMw2BBfasX34WCP0DaaxHV1SdrfL/i8TXRjsL9w
         CDicYtKLhWUypS1oUzqs8tDaTTJr1awAaGD6znYvycJ6XtayT/wQXYLkvUT8fBPtKHvz
         y0ZfdiEvHuoDhkMoQMwDGp5FyoHAFHOOb3kDxGk1aL8dFrWz5atDg3ySy8hRgyLKWqjO
         xEO1gsfx82i2n+fqG5vBY+CoTxOJX8MXreFou63+7T0ULxni5j3bmeg+Y4dcvTlv59aG
         A7JhAqUhMlX1U2ovsFN+SP6ZJRtJr4DG3QfWbP7hDU983xvYpmVs3ifDstObNGlQGoBJ
         a6gA==
X-Forwarded-Encrypted: i=1; AFNElJ/dsXbX3xlbZAbzn6Ly/20Tqvehqqn9QhBqSe2O0I8vNNYJ4CgZQz4/dYKIi0p8J8U93anAMeZnQFMsE327aIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj65BZ0rtHBUCZvSkWJIFMjftZ1KzOgajjP7JI/b/Pii3RHSuy
	a24EqNPJkXmmZvLNQGfGs838lD4TQRhrhN/53Dc6knYVEZYCDTx/DeUgYG8WtS1jG5vGVqtOXX3
	MSGAVffQC/YWRiZLuyDwYfZ1xcjUpbkT4dYSX2Svi49bARawXN9rIs9eu4VcXq0QPNq0lJOY=
X-Gm-Gg: Acq92OGyK3Bk1zvRlgROKbhh67HRy4ZciKvXu6fjsJnQC4R5LpiKnX7jhPBy9+e18JB
	k7ZTJ4Jql4L7bYRubktktipmZg5NihNLOCBrrWxjFZwo1jnGSPSL8uVVfPg03O48sczgq63fykj
	2GWlc4tc9oO9e9idXqu68Chb7fr0qIQO6Kx4YqIXyoPKElT6VKhXNEo2ZEhhU51/aNmPS5t5tcz
	gQF8VduV0g5OQYIIJecWObjZOijxekH3w3KYJyQ9oXo6PhPgyoGWB93jJeUqOkTktUkPtp0CyfO
	pDwz6ZfH5StbeH8jAirJzQ3XbVuizfXc5ME5kSM4LOh5eXpyWQL8TM1tBoyFidAPzBchvOFSLZw
	woEV97EagMnv4BroMgr9Mn2oxYdaKmBZlr1iH3CRv0d7/6zK5XBOANbJaZqAhfx29WjOnfeplb4
	ihpOIbIVzJ9MhtSDMf7Uw0eZ0WXau1qGPMeTs=
X-Received: by 2002:a05:622a:1109:b0:50f:b257:9301 with SMTP id d75a77b69052e-517fe566319mr24249131cf.52.1781255551595;
        Fri, 12 Jun 2026 02:12:31 -0700 (PDT)
X-Received: by 2002:a05:622a:1109:b0:50f:b257:9301 with SMTP id d75a77b69052e-517fe566319mr24248931cf.52.1781255551221;
        Fri, 12 Jun 2026 02:12:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1a7357sm381663e87.42.2026.06.12.02.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:12:29 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:12:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v4 7/8] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Message-ID: <uybyiffu2czpzhycp6x7w2pptzmhajxlx3ogglshamppo66kqn@izztlisgr2xc>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
 <20260609-block-as-nvmem-v4-7-45712e6b22c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-block-as-nvmem-v4-7-45712e6b22c6@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 86eG4ZdQ2lpwPKsLtdB9HeUMY_2OH1TQ
X-Authority-Analysis: v=2.4 cv=RJGD2Yi+ c=1 sm=1 tr=0 ts=6a2bcd80 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=m9cM9ScjmTDVYK95jDAA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 86eG4ZdQ2lpwPKsLtdB9HeUMY_2OH1TQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA4MiBTYWx0ZWRfX1ofDPgmVOAKP
 4za7L4yBL4bNOoo18V/YRWVReV0kztn0kyUtvU6qwvM/oQEXPgxbVHbh2OYJGkdqX1JKMxsLpcj
 pHPHVqmeXDm/+OtZFHxxf94UEscxMclA+XN0uTCIbM0O9zmV/yUdv5d0SvRGNarkRQLTM+ty4xf
 2Fkx7ilgoalz8nLWkWA9s3yGZqU3qzxzmqgoIW63H0Uu9vV24mafFO1RLFikB7aw4IVZ459HyCJ
 p6idICqPU2U9SO/1vVppHbq4IA7yjMZnXbimavKv+FywbDz7uBhTvhPYotZWtmNrsFwX2xxv9mj
 T2CFsdKz+oeb78pyEhmT+R0ewsY6nB5L4xpQ7ygIUJhrxS3LXlEh3VHGdjb3y/9Fm2TCdA+H0h/
 pu23xM/oUphLajhkbpPYK12KrrK1QyfuahfRX3o9TDAH+nQYp9truViH+cZ5IJsf8JLTKjZ2uFS
 vFPGXzcqwopAYW2Nrzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA4MiBTYWx0ZWRfXz9M0/wOz23rF
 6IUDAZWe1T591bIBcq101f5Gcfaeh4VjZAu1nhb6Y8BFAIA2iZ28cSUy6l/tk3HXG7SjuQQoNjG
 uDvyZvchGNiF3gvTo6663ZVui4BpDBI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120082

On Tue, Jun 09, 2026 at 09:52:32AM +0200, Loic Poulain wrote:
> When the controller BD address is invalid (zero or default),
> set the NVMEM quirks to allow retrieving the address from a
> 'local-bd-address' NVMEM cell. The BD address is often stored
> alongside the WiFi MAC address in big-endian format, so also
> set the big-endian quirk.

Okay, this answers my question to the previous patch. We need to support
BE addresses.

> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry
