Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40E52E36E0
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jul 2025 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751647424; cv=none; b=F6N25weDzLsHijtI2zXMIUtaVp5VN3sgNIXQEqYDyKrQGtqnfDKIcEqRrWNAaHiReAeL41LAgER8y9JZ+0rAMp1wLajUOjPaQNMHvPhoc2HJaFSZymBqtSX450figlF9NVzxWHhIKYTDZoEc0caLUDNIjEfUiM256ODY1hheO9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751647424; c=relaxed/simple;
	bh=ck2xsriSsrklYZzoHY7Zb+J9xczZc3apVan0Zg+t6Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6zm5Dskrx48lOumN5EnjJ37/0tWrYrhmlu2kI6xgM52M4t0F5Jh2jkSVwLAaNSWXpgBAOBF/IW3lhboVtntu6EwIZMirMmqIXcHYFG21WYa6rwGwtqgZmZyDaEC6p1dzJeP/osDkHDkXOxCmrhY0nfNeqtSZreYqDaVoR5g0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=loA/tJUs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="loA/tJUs"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564G5JJI029619
	for <linux-bluetooth@vger.kernel.org>; Fri, 4 Jul 2025 16:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fF/OuQJ8xsB/HKG8mieUfGiQ
	XUFgzhYQV4ZPFUXGWjQ=; b=loA/tJUsZQbHc14ZAa44WDNXTjnMbjZl4jDEy+Uq
	bnVEwShlrB1N9uE+pUMz702LNPAA2L4C/R8A5aVrosKR2q03BI7mvNdd3/W7ULyy
	pSFoDpLTqARBo3lZXEa9f20rWkirhS71/ZrbExn0PAFjiwlF4j1JHR+flz2327VW
	GhQ7uNfqWYvFs1DtYUHaua6VrbySQLdQuPtin5Dw/eDlpueiPMDe6tkHkRdnDQNu
	2L57hHyDzVhR/Yn+IRuyzZwBwGBXruk68snCYDj6VEaK69vael8eEUCE7MT44jQ1
	mmGu2T0agZUh6z6RkD6pW0TcHKoN30AOok2nOdL49bWH6g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47nh9s5xy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 04 Jul 2025 16:43:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d3f0958112so153057885a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Jul 2025 09:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751647420; x=1752252220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fF/OuQJ8xsB/HKG8mieUfGiQXUFgzhYQV4ZPFUXGWjQ=;
        b=in/iNfLJ+OQgw7BjkE/YUbEcWpH9gXeyxcBy+GSh4f12z3M5nOxjploGbUiZ2cnbOo
         4y2iQ3JGPuoF8XkUPLznaMsR7GRtZ2dD5TVnWVKzods+qm6Ee/o+hemDlnbRX6ZUcpug
         BJiD0rERmnPfOtZHRqp74O2ub5k//ZozTchDqd/p7uhPuIkRPtwr4Jp0WUN+/SLlZ/Su
         WEWvZYEq0TU1IDb4eLHVfNldx8dQ941T2FJIvq9/1aNwhsuD4nIHkFAYgRLWQYzAvDty
         5RXImo0NzLV2X/MsmXna0ELAHPL4SyxUcYXZg4p3LayjY+1UuHHME2W+5t3PsR5vXwRk
         oPZg==
X-Forwarded-Encrypted: i=1; AJvYcCUf+nbBGU2K+zMS5+8C7C1cM4F8KHTZeiOEgXHQPQKGa5D8IA/cdYxygXct4iMQvCJZVksBrHVNzPV3PO+WqFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9hLI/vkbaxCSaG/YW7R4S0Ph5pLV6CU2See8ZLuIii9JRBI2K
	Y8Vn2LmZset6t7u20ZaDKNJQUEMw6Ee+3FhG1zV9XuxrcReaS7PzlwNGN04rWp9ZTcupqGMMoZV
	2+yVj9VMtc15BQQxx/no1Lclm7umFDa7ACUxF87HQQgoxa9N8N/lCLJTszFO9BlF8E+XJs/4=
X-Gm-Gg: ASbGncsETtD4FZ55gZ7IEngcjBcUIrn1nXRyf3TxsXIlNwdfnNybkrSYFSciIofzX1C
	wBsaolkN/cARF7eA5tenBURBlc+wiG7laaHytiYHC3aZB1ynMtqe2wkDMOD8ifJaWvZFUrKLvAr
	388ji8shp9mJX9Lq/mIp/ALRp2VQmReRJj/7nNFCQMZmnq6GMNOmHWJAqh2NiOCrtYROdGwRqRf
	mQQaLqkqawxlx6nDjUiMEzagbMrUwqIuzqxjJogut72MB/hXqW36FquBFqGoIhqifRup1w7SQzO
	VsOfVsrzqclCMaN1rG9QM3AxTn+40yC0n7f0hVgVftsbXj1KFrzwpFgfPu2pRY20PWWHpzkFk8G
	vVJe429M+QpcuLnlZWEJQ3ojfYgdkKaCvuMc=
X-Received: by 2002:a05:620a:4412:b0:7d4:ca4:addd with SMTP id af79cd13be357-7d5ddb727c7mr373955785a.19.1751647420428;
        Fri, 04 Jul 2025 09:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHn1PXyp0jkn2V0mI4Lk6POEXOcB3kI33BgARnqMb46tOWnip7KD7hHFCPDubKk5Pz6nWtPQ==
X-Received: by 2002:a05:620a:4412:b0:7d4:ca4:addd with SMTP id af79cd13be357-7d5ddb727c7mr373952085a.19.1751647419945;
        Fri, 04 Jul 2025 09:43:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383badaasm294708e87.1.2025.07.04.09.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:43:39 -0700 (PDT)
Date: Fri, 4 Jul 2025 19:43:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: add a sub-entry for the Qualcomm bluetooth
 driver
Message-ID: <ubypcytljeytit6pkis6ailue2wje6cth6yd5zjuo7h2h4e5r3@lq3hr6a2b5rv>
References: <20250704144724.63449-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704144724.63449-1-brgl@bgdev.pl>
X-Authority-Analysis: v=2.4 cv=frrcZE4f c=1 sm=1 tr=0 ts=686804bd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=rHvIfiyz_3d-7KI9RAUA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNiBTYWx0ZWRfXyrg2l8feW2d1
 8sX4sXs4/9AANu8yM9mCgLyqkdcakwmpkGc6QCucnnj79E4Dl0buIeXSsiY87JJaOGd1tMkxc8v
 bW+dozRxzB/VBaAa6QEW+uN9k+fnHNwegGb7weM7CI0rsEEXrYqmtioiZP24rXlVQ/8lIWj/HSL
 kR8uJAvcXb89dMYcRf/PdQKrvodCjw5ggryuYJPFaMKf6bSXysKF9kJm9NmvwgoMt3RcqLfHj0I
 kNdudGpdxqqi95AV9IzDHEOvkpzdV/crMf3++BwMwyL81fmjUg/zA7hwSGURnoqOfP2lMYkMIEI
 RCl3zO/MN1L3qjXwXAYIkH+HdnH7UpkjT8lcaFinVtIPl8nhZ3ZhLE8SG0GRVfBXzUK3Dcos1fd
 GYKSB1uswXsNWE+MKOHsFh16Ogy2XHLHVzHR78AE3D+jLAnADvGCTlLmSgkDRmXyyqm8KPiB
X-Proofpoint-GUID: rUOr65-hq511XI2IAxwtuiay8bi-iZ5F
X-Proofpoint-ORIG-GUID: rUOr65-hq511XI2IAxwtuiay8bi-iZ5F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507040126

On Fri, Jul 04, 2025 at 04:47:24PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Patches modifying drivers/bluetooth/hci_qca.c should be Cc'ed to the
> linux-arm-msm mailing list so that Qualcomm maintainers and reviewers
> can get notified about proposed changes to it. Add a sub-entry that adds
> the mailing list to the list of addresses returned by get_maintainer.pl.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fcc77c93f8db..7fee3d38baf8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20441,6 +20441,11 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
>  F:	drivers/net/wwan/qcom_bam_dmux.c
>  
> +QUALCOMM BLUETOOTH DRIVER
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/bluetooth/hci_qca.c

If you are adding an entry, then please also include:
- drivers/bluetooth/btqca.[ch]
- drivers/bluetooth/btqcomsmd.c

> +
>  QUALCOMM CAMERA SUBSYSTEM DRIVER
>  M:	Robert Foss <rfoss@kernel.org>
>  M:	Todor Tomov <todor.too@gmail.com>
> -- 
> 2.48.1
> 

-- 
With best wishes
Dmitry
