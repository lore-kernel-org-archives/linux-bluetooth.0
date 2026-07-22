Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B46740F753
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726610; cv=none; b=AsdGSriNP13YDd6buvFu78LGE2AQ+/71nWCAjAuVJM64Uws0GyEwoUno7dAr/GnhnevT9g1EzoPqe2TqHTwsMmlH12UiQlY4WvwlcjaUPWyjp/2u1NU/iqqvXR8TbyA2emwbKgUwDk2wHv7Gy9JkmejxLZino15BLrMCL8AcyWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726610; c=relaxed/simple;
	bh=sh9ZU5Ncc8RUC8V42Rp9x8UPi3xY/aC/ruJVJxi2z8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q08jsRV/hrReUi+evdhKAk1JQOYdAmv8FiUj7m5C+iyY2Bk8RaGCslbVUTpvcu6MEe8KP8VJvamQXcJAd7fUTg4ocztvdYbWtqK7yKfxVGKsVTxLMvE13qU2SWGa0xJGpLrUWfKoG6mh9sAVtpXqPophHp6p35fc59FxqiolSMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kqU5K5hl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UTzLcoTW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kqU5K5hl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UTzLcoTW"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MD1kup695569
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 13:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=f/z7Vf0CFs4vDGQLLJUD618C
	7Uy9T9x3H6mGeOakJz4=; b=kqU5K5hl5hqAHl193dF9LYbBD1n6i+hH+eRENipq
	F/kc+RwlgKLOjraw99yyeEPx/Nq5GbVaQfgg8WeWn/Ug+vXer9jq11xaazD8fMh9
	KrbQGTT9vu8Vpfmjx9VnoC+6ESAjtY4YpZJIuUYUrvIYXk0Z1+zFuGhkOd0NIaTT
	WxWXV+VmVxDCfvsbEjAshb4wjZyK6K5wIGIDRH00cRJDVQHrOnCtD2qHkXcx+xZf
	UyAj/k//BodvU8oJUteC+8qGT2cQlXBv1zpZMmMnnsyL38ic7qZZ/RQe+bY+ra7W
	1iVTlDKlrnF4vZKO+LJA6E/WgpzS4ULLZ73Ya4csiZdYWw==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjtn2s3ae-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 13:23:28 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-455a572f92dso11094240fac.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 06:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784726608; x=1785331408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f/z7Vf0CFs4vDGQLLJUD618C7Uy9T9x3H6mGeOakJz4=;
        b=UTzLcoTWqGvEexN6G+TMEiiypSY6izSV1Wid25pWmTWgyTdDrWkkRL2ZMLj4D6yJ4Z
         hHwHUtK31tUdJBZO82kU/ZqVRxHhTya3I5vZPuQVgQ4OCZWUe3rUWnqFSlerh+15iHFv
         Ha05tCntkns/SgMslEJZ7Y/6K1oZJfXjquYWVi5BS/Oni1THzruoq9wD/qB+G7Hrcuhe
         +IsWxCy6J/HXkLK5u5F/KMVF8DjLgFk6/z41mVmSchQM1+8qAWQVWacvLpx7eD6PGRIk
         XAeJfwxR6AQdl5nHpC5x1XAppmHVfiSgvk4w2lObnRX78iaKrcop3y+3qJc8obVrpr7F
         6uRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784726608; x=1785331408;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f/z7Vf0CFs4vDGQLLJUD618C7Uy9T9x3H6mGeOakJz4=;
        b=V/BowFAG4Ll3w1KUDasmjlIhCBEH/djkHkLQ3tgNLngXnLgphvVTSKqtSrioIBNgFI
         Vb1TBWj5NuIiETPIuT2y7XkzEOOW3Q+jcgC7wvKwdesmqpBNvXesxxAtPkDT1OL++p0d
         I24Z5Ha+qX6bHTag0u2e1yi39T1xaWl63e4ueBhYn4GdPCpAYl+xjbhaniAguAxDk/06
         iE8/JlLRzulfKyVOrxDdI0a2XSozSCjTvaOz9ANpRZ0R+DZVOJcsts2XaORVyrMiq/NV
         cqmutS7SGdU1/F6UfzffDnGRSFuxUin80OtyHWT6mrvUCN9Z+wlpiV4Tz4L3ITYl4TP6
         VonA==
X-Forwarded-Encrypted: i=1; AHgh+RrNvig9HKbvOFUjcaT9k9weYMYy+Cas+EgqnTN9HdkVoAKUYz48bc3dmCScpdWluqyhBJ3XtgmeeMgDjA+UCOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ/KE/Z4roEhkb8L69mqnbd8WKWMtSclxjYK7XqyxBppL0Rt4a
	3sE1aLd6S8bftAwWxVEIHu0wSnDP7m4klU+KYsD+1OYxZrnKCUnuQNDeax/5lzev8DkdLMif+6v
	iFYhcHOrsyEfQXYIRIwXwiJ22L0Bo8r+kdLAfzSfaiM/r2wPSJc/HIJF5fGptal1JF18O9zY=
X-Gm-Gg: AR+sD12Z6Pi8Zs5syvI8mGDZMu8NHr0VkDN+9DYoFsI2ncEiP3HMlobz+ZT23Id/+AK
	1wdc8CIcWtZKwKs7EZ6F7tzrWdPvm+zU0ZMkJJWJQDT7s1TXHBk/eTuU/XnPUt6CqIbdkJ8/QnU
	vAclzxCZKaqAlK+6pH2gIrsAxZrskg9aejykGCgVh5IdfsUffRbkE1/QUsdKvCYzcUkiVai+piP
	OkyBUbdbohbfTSE3pi8n8fmaPbBerugwsObUQCy52+5Z8aaVH8cgY1vNw3aQBWL7XcAikCSRHEq
	s4Tke5Tc06ajwFGgG6O8L9vCc4PIkqCU/5RfmjzmSRV/d/O/0YpJF0LRckwPZS5qKD5cYTO1W0R
	cuewha9rJilJmUWy+oieWjyuWl/BAX/LNIgOdpf7j7CrvoIBmxsQvLoYTlArJbuIbU0usuv5CNU
	6mio6xWGFky8va9A==
X-Received: by 2002:a05:622a:351:b0:517:6b31:8058 with SMTP id d75a77b69052e-5213e0821f6mr207212611cf.40.1784726272520;
        Wed, 22 Jul 2026 06:17:52 -0700 (PDT)
X-Received: by 2002:a05:622a:351:b0:517:6b31:8058 with SMTP id d75a77b69052e-5213e0821f6mr207212221cf.40.1784726272083;
        Wed, 22 Jul 2026 06:17:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9e4313fsm463602e87.60.2026.07.22.06.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:17:50 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:17:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v5 05/11] power: sequencing: qcom-wcn: Report power
 controllability
Message-ID: <6lxktlm5suakzub7gvlhianc65yeiqjbbodimsikvcicciag3q@ugcdr2gbg4ok>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
 <20260720-monza-wireless-v5-5-69ec6743543c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-monza-wireless-v5-5-69ec6743543c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzMCBTYWx0ZWRfX6IIiEVLJWhXk
 yQFM/wHiek4IF6uajpIla6TkoQztYhlnwskYWEkjSxjt6/+ueIqow6sAI92bnJ/2HO9tOxVwB0/
 NYP6nzusTiWF23FjKTn6tgLBSbUPxZbb4h88hTbiGV/yy5g/Sm+nukmyLI4mr9kLBdBLTLlck3h
 J7vKbgv+dFJUCP+yNIuLv9k3c+mKfOL09Hz96yG8A9kCIEgf10cckuva9nA8l9XiHQbJXw+6ujR
 uJG2/5yEjDQiLmpScSyPr3psm8j+eD59z609UBk/jqmyvOvB/RVRaLZAQXOrcChQJPDj7HSP7XI
 lrfE4n8SYObjSz+OmO/II8b24LE+EWtsAuTerWQ8DSQHei0O8XRi93dgUjaOL4RRsLRVDwPM+fS
 w0MwIrNeagmzI0AKpCmBDQCRykulJwqLcrWZQzErM6MRmeBwB3TcU5wyk9fcBR4ZUXU07s3VkSh
 WHgMXzYPLRcjksEAXww==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzMCBTYWx0ZWRfX47pVoN2u+zG7
 US8gNiCJ/hX2rWGin7SoZ8yjSAQsNlyvQ5ucUDHxLDPP//i7CvtLYJBdMYa1ToEaFHM6cwAZ9rl
 OkjLSKUAUnax//Ja7A8qkzSkyqCy6UY=
X-Proofpoint-GUID: ymebyMfgBLsptfd_MHZxAsYiu-N_4YUI
X-Proofpoint-ORIG-GUID: ymebyMfgBLsptfd_MHZxAsYiu-N_4YUI
X-Authority-Analysis: v=2.4 cv=T+28ifKQ c=1 sm=1 tr=0 ts=6a60c450 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=dA91eB7zeV-DSUTtgBcA:9 a=CjuIK1q_8ugA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220130

On Mon, Jul 20, 2026 at 10:04:07AM +0200, Loic Poulain wrote:
> The "bluetooth" and "wlan" targets drive the BT_EN and WLAN_EN GPIOs to
> gate the respective functions. These GPIOs are optional, on some boards
> they are hardwired to an always-on pull-up and not routed to a host GPIO.
> In that case the corresponding enable/disable callbacks are no-ops, so the
> consumer cannot gate or reset that function on its own.
> 
> Implement the .is_controllable() callback on the "bluetooth" and "wlan"
> targets so that consumers can query this via the pwrseq API.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-qcom-wcn.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
