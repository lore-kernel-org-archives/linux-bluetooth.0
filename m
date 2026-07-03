Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D625B091
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 23:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783121676; cv=none; b=IGSEWD/xsGzXIule6IRdlF4bw2omwY6Uksv94TY+EsM4Rly11UA2Tbv14n2a9huZKPXj7kVqCgT9Zvb63NH/6+048ZLkD68e5Ye2rJbRz5NNVtxO3r5uYgfF4uccLrOD5SRVqB7dcRN6atGQPXA+XWai118KoBNb5koEQxGJvKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783121676; c=relaxed/simple;
	bh=nazfFnHvjjbt8KBJZZtfugY+QOWghPItE/9y9KgBmUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc0ev857+Ha6pzDmBJQKMwfsBE1yTEUKhNvAbpZ030+11QeekapmzfAJYsbjsLEZjT4yHnwRQ/CwmG6iHJLAEAJs7Bf0BM+vrMZaYg+9qJzMV6pH9At04boMSDU9hrhdjqdykMQhg/nVYbA6nY404jAH3CFKi6zWmZgMdgOIhhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o8GwrdaX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b/jbr81m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o8GwrdaX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b/jbr81m"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663KPLIX888305
	for <linux-bluetooth@vger.kernel.org>; Fri, 3 Jul 2026 23:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=prcMmke1zFQfB/qFnU+ojBqY
	3z/+3aFN+aeWXEDa/JI=; b=o8GwrdaXroxpP8fDqcYUhFyfbjbZCvHQ7bNPfRBI
	ty3TkeFOuXlSfdPhc+BzGUG7Yh8j2DKFZ9J32M4j3wk6lRud52Q6B5c1nVhCaKae
	vNdoCVrvXhe5EpA4UZxIDNRWx/ZwrwSX8QpfPhlDN0S2ym+605AfKwlf4JEvhrBB
	nZXMXKBLG+tl8NVr/fDsp5ePwpr/ZzPnQBYyRwiIHyaiezzxiR4CTdWxFWwJvIgr
	QK7qMOK6CR+fS1gUEauyrAo9z5VrXPs3jKG75FQ8HBKi3guckXPl2kmIWIMiY7fU
	6fisp9crFiuSFPzZH1ioOwffuP6diED0nadxkT3PoE+whg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f682bu7af-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 23:34:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e82060977so107251885a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 16:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783121673; x=1783726473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=prcMmke1zFQfB/qFnU+ojBqY3z/+3aFN+aeWXEDa/JI=;
        b=b/jbr81mdpWd/yBkIyV/wKadYRBl0ZJ8obpRscmdiI2aaAg2Vbddw/M1nAL2KV+Kzz
         UfxkOVQDyuPNnjsUgXbjVh6svhLpGXYWw7Awy7ggXBdUqR7wALPf2AuGxegRDqhMmy/b
         DtjSSiQsPxk2S+NkFitm0OV0lTioFRQEpEbSb5GHHQCfTq0zNZbhJqM+iKLJoBJ7N5X0
         f/1KT6uHdi6p1oMai5jTnJseKC7kRlqkDIfxHFadfcp/pGKBnzxh9w6rQcl6GvNRLs2h
         yZcVgXl5WGog7in+A2MlPiu4wt1lli55jUsJXrZUfvNhMfIGLtIWRra4EQH3DvGu0PrS
         CJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783121673; x=1783726473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prcMmke1zFQfB/qFnU+ojBqY3z/+3aFN+aeWXEDa/JI=;
        b=Z+9Q3R/TKP0s0EtvXv1Ge+Q5FaxTudMRTW/XV+OMgfUnLj/cTVQMm4spJ0fEf34DqW
         UyrXRW/H9WP4lTO5z3Un8KW6L+oqVcIORUCVGAP5RVJD7gZwCBNy+/vva54IcPe4mxnp
         JTqj1Pzrpf9gqjE1wkBIcQpQWlNxLycbAQUK573b5UqDMyrRWQUyhtcehEqSIYUpsgXN
         YOnWhOjs5ZmUxvAH5CzaqjMiZiX3UQWG2jfh+kjeOVDABkDcrdjkz9FK4f2yBggCiMCe
         lKel360fYoeaqZjAc+nLYY9cWy75CcMQN9u8hDm6uTeBkHiCqgkdQsVX5ZnCEn0logZx
         aO1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/OwJAZGZbC159xhfEE5ORTafxX3GqIDU3yobH2xatUPAFwyf2o2Oe8zvHLPqyfAeOIuCljbWMK9DkbEFwwxbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqtndqR0rdNk+epC68yeGptgBxu21Xz5fNAvwzACb2Kd70qVjV
	fdT25iC+/dNfPAN2w38KpLGLRQGtQYn1PTecY6m27RT5u8hBYTSBcbiHpg1KkGp0jCUi5HeXDlx
	gHPcDJN8vlChx8e4BTvEmwBcIn2/eXwTw8YSXN80b1G7TydsxXLgXqLSL9K1ohrJ2GeyUGME=
X-Gm-Gg: AfdE7ckYOJTNvlUgTxXDyakfDv+vKMjmytEtXJOvYD7HYkX0ol/EK0ieRTo+ajKcqIo
	X6czH9dft1NGLDpNDhZ0xi/G0Akh9JwpOuX5a8gXExLFb4LZN2EARKFVmRF3M8Wyyg0b7p/sEZO
	QwJxQcP+xVhBCyqhF/OW4Sa80LtE16rOXkOBoDwOg/xF6VGOJWmK2w6RvDdc+hzOJZVA7TmVOE9
	6Lm05vHTmc2rJikP63KelzbGoDjZWzY69mFmC82ih6ADu2Xi3l2kuMJ5SWw7prtejeJxprBcMwN
	Zr+EPjGaGrsMMm5RrlBKPV9oWMxDIH1Vo4IQZqspdcMQNkvEZ16zns7zHe9R00kLzqTYHx18WP1
	RX8n70mtS3nDZCf+jHS/JipXeqXc5Ca2r/88WFRCuvm5UoWDaPXg360KsszpKPITay6Yfx5UMwX
	z14eruDT7e+EZ5O0hhsr7d6Ytd
X-Received: by 2002:a05:620a:288f:b0:92b:f1ba:5fad with SMTP id af79cd13be357-92e8b58da9amr730706285a.37.1783121673397;
        Fri, 03 Jul 2026 16:34:33 -0700 (PDT)
X-Received: by 2002:a05:620a:288f:b0:92b:f1ba:5fad with SMTP id af79cd13be357-92e8b58da9amr730703485a.37.1783121672979;
        Fri, 03 Jul 2026 16:34:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13c4acdsm836984e87.76.2026.07.03.16.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 16:34:30 -0700 (PDT)
Date: Sat, 4 Jul 2026 02:34:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: george.moussalem@outlook.com
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/6] firmware: qcom: scm: Add support for setting
 Bluetooth power modes
Message-ID: <twncu55nou3r4ediipddc5unpnkhvllaj5ac2ayrryk75orucq@vtt7bremuqzv>
References: <20260703-ipq5018-bluetooth-v3-0-62da72818ab3@outlook.com>
 <20260703-ipq5018-bluetooth-v3-3-62da72818ab3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-ipq5018-bluetooth-v3-3-62da72818ab3@outlook.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIzOCBTYWx0ZWRfXycCCD7f1WqZD
 GdEIb56q/Nd1/+iMzptzsq+o2pW0IJqeZfNdswB50e7DBCgNoyLPNJVytThKB/Xo2NfxGVFCyVi
 unQQh1OChYyGSlBXkwHAmzCWrDmQdSgQ/3dskEexqCOFr2OwFVFVYRGGPY0aMQoHJwH5TM4FkgJ
 9rI1jISKZT4QbxXw4xbKb84qlUyChugBoFg7CtdcnexMTGzaJ4oltg60s0m7L73esemVo+gHc6r
 iHxcJ0kciwie79DFHXCwfNSFPu87jo8G69Y/bsgN8NwPpxVTw+Xa0PeSjzzXQPpEvGx3o7VRXVZ
 XKTGtAD+i8RHqemEvAgUpMkh9GOzIomjYg/+FGoy9G7y38BPZJ0QVq+fpAIGVc5NfGivrgNnbVe
 bKNvB8awn4+SGTU92iheA/Fyuz8NxMiBLsEKzP+RP6P4cNeLGEdmUvC9nY3Q4gUmy2+96vre/rI
 KuqCE/5NfsZ+eUXIHLQ==
X-Proofpoint-ORIG-GUID: c3lYCTf4hgfJRlLLeCABGaQo--DQAGq_
X-Authority-Analysis: v=2.4 cv=cc3iaHDM c=1 sm=1 tr=0 ts=6a48470a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=UqCG9HQmAAAA:8
 a=EUspDBNiAAAA:8 a=z01RItMgd9csqulRoWYA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIzOCBTYWx0ZWRfXw//jzbFd+Dc8
 Gyyuua8idL1J4xvwyr3MX8Ake9lSnkbU8cHdVztHWo2rZ2GWQByBUvkmMebXnDaou+U2GhjRibk
 5wgbGc60x5L8Q4MA+pLL+NC0UmX3sms=
X-Proofpoint-GUID: c3lYCTf4hgfJRlLLeCABGaQo--DQAGq_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030238

On Fri, Jul 03, 2026 at 09:01:51AM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> The Bluetooth subsystem (BTSS) on the IPQ5018 SoC supports setting power
> modes which are required to be configured through a Secure Channel
> Manager (SCM) call to TrustZone. However, not all Trusted Execution
> Environment (QSEE) images support this call, so first check if the call
> is available.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c       | 44 ++++++++++++++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_scm.h       |  1 +
>  include/linux/firmware/qcom/qcom_scm.h |  1 +
>  3 files changed, 46 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
