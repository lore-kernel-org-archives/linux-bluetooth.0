Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4632F5A22
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864858; cv=none; b=Xr4gHbDLjlFQCl8mKrLv9aGVQDUrqTdeBZVPNXLnexQBunQecXZewKGgXgspHtqUaBtQY/tfh4HnWAUUn+Wuoy6jQ35LFdsQJI0RX0wrrld5hE274lE9Zdz0YAoMvZON+Nou2Ke8zcb4MfPn6TGxHSXlVPfDuMqptlDREW4dzZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864858; c=relaxed/simple;
	bh=LQ+oitKANKLBtDaXHdc94NsTiFvhP0RyR81S0lGkgIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+tZiV7vcsVFtL7CZ7iE95InEK3+rKB7hgydztuRzjAe5OvleoPTZBRE7l8TNuszrL/+ELQ4DGjzNAhc2QlEKAwcJWHKE+PuYw/Pmq0Ocl0rg51GX+E6Jaig8P4fKQm0njjfs7sxRHx0aiu0rqWQzHEsxqsPdsRKot8jzP0YiYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hYPM6PqL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jtGIjSqv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hYPM6PqL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jtGIjSqv"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGBYW2165217
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 12:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=thY8JpY4WG0U4x5IdP6IL3ws
	rK/h8ku1aY3ImVMowUw=; b=hYPM6PqLNY/Ll9CBjHos/+7JIxsqLpMnNb1qrjSK
	EsekTfN1H66I0O/8tCNhjOMyw9tWyZ+mLumesAcUxJKLJSJy0ri8BUQPnEoZufa6
	Vgy5YHa/OnI4n4O5Xe9+CWv6AW2eYFIXMd03W/S1LwJ7ZnHE9E/T2v1z5IFvuBXM
	27BaeF480zK6fQYld4YFrjuKnK3jhgRNy3OVaf1+fJv+peEDGAGfgBf3Swu8AZW2
	6UcyDWOCcLyakoEYVJWbywpAjqtxMkuk0NDN71TT2y24fhoO0Vv4CJEPjjmz1hPh
	8M9S5Z4bmw4Y9rpdu9N8rvn5eEO5SQdIzED3C+bdgS+nEQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abxhhh9h2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 12:40:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edb31eed49so57446161cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 04:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762864855; x=1763469655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=thY8JpY4WG0U4x5IdP6IL3wsrK/h8ku1aY3ImVMowUw=;
        b=jtGIjSqv4zlVsYNp5UVDNBJl1i/tN1g7PhGBK425+pTjOgYEwQ8OATrS1PKgIDpruv
         YE9yyokN2cWcSiXfchrgmB+qudLAG69iL9haabUVibHZjDePhjW9wt2YFqkMSEZU4DMX
         JPf0eACaMnB+gmfFnBfv8Ep0Ma+a8B0UN6vzG8VbLy+o+2ESblyPKMyPBXFnDG7YFtkI
         g314eu5wl/OAlirl8AZFMCHwE0phbYAUWKOqCCMdDRdK3YIJcMSEmmv1PRI+mzpw03nw
         7rQfq4wPZeB4cjgHMW3YIkrGVivktxO7eb2hD8vKSfGOQj+HIXrbAeeUZDqbCwar1bm9
         k+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762864855; x=1763469655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thY8JpY4WG0U4x5IdP6IL3wsrK/h8ku1aY3ImVMowUw=;
        b=hpvbeLPRAYq3+vI5HE2m59t2EwauIRKQMrnsemVaYpERhgLtqnqgTyph6YPUtC8OPp
         2J7aw3GjKqlPUsXPZ45IL94dbhzL0KG3Ogd5pC13sJvcvAXCLXS+KqQoow4xlWm2CXfa
         tWN6qXzdnecXAWzdYy9Jk5h9F9C3vnv6V9gfVTmyCLDbN257ytFZWc8LSY5S5W0Lz3B+
         7qKewEkK7hBmEEhcpBsiWZijHLM+LKyiSGwp4VzG5p/d81w9oeallcqdbmeqycDW3aIz
         MTEu5PCJ4U/Tam0GlSksP7vSkioE3tP698QLB739mpQi/5q4mDXrT6a2HkB5NnyJrTQ/
         NRrA==
X-Forwarded-Encrypted: i=1; AJvYcCWxVaAfSvDozwWKwRWHhTupXanRlUWgF7CRNjsu/50z4hYeflQju9xEqVnFANX9jY87b5kLE0QFms2SaxvgAMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywah4wmbdESLljRcD7WN2TZI8BJvsP+EmH8WpHGnILZ+9Bo7b0l
	jjSyOEI+3OiGfiHm0/utw+DtHnbACdCD1rF5DrtV0gXeHLcj8R2rCX0F0My5qADY1CkVrNhGGoc
	VtvxS5DUTK4fqedvpaiVpG9sUSrbed6DHqe9Lw19QdlwM5/F32TBKycsqMMdhNjXR0fV/1Ic=
X-Gm-Gg: ASbGncvAd3CZYyJdVpHldSEiH1XewV3kv8WT9H59Bpy+ji1Ib+yazObWnHCvQI+5eP7
	DgXE485LXMnvt+EPqvqfbb6DAJQhL33xNe79jLK8Ns0KcAut7irx2wVXsbD0YBCNN1Re0sjDX/l
	9hsNv+uiQ3C+0nJxRsSzNniJA+ZlPA6+AWMkRf2e2fjyBhCbLfuwI8YezmQDv+JpTZdvAvlj41W
	Owv7OAohZHxIzklH9855l4vXyPLNbXe3Q8CfgQpZa3AB7k4Qxqyw5iwhOSmLFM7mTGn53vbIZx3
	BrW0KcCM+QtGJ4yyIhNhJChPT8jzWuMakh5RUJwReC71TZMBf5cEacZfQHNWVfxstu/11nXiVFg
	GGlsNg2+8LbHHIDsEqtPhWkjuCQq1WZIbEIhzouQPABvaz4xWxojBI3IcDcBJ//qjkp0FUrMkK5
	Y4BgMgL+SNGtzd
X-Received: by 2002:ac8:7f8a:0:b0:4ed:3d24:9581 with SMTP id d75a77b69052e-4eda50187edmr150666551cf.83.1762864854761;
        Tue, 11 Nov 2025 04:40:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4xqPrtA5f2hoQPM4eKGkOSTFok8KYmyA6XTLWJcrYJQwoqiMBmQu5PmYefTtm3ql0EcPybQ==
X-Received: by 2002:ac8:7f8a:0:b0:4ed:3d24:9581 with SMTP id d75a77b69052e-4eda50187edmr150666241cf.83.1762864854262;
        Tue, 11 Nov 2025 04:40:54 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a03459bsm4897371e87.48.2025.11.11.04.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:40:53 -0800 (PST)
Date: Tue, 11 Nov 2025 14:40:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_qca: Convert timeout from jiffies
 to ms
Message-ID: <3xsuxm3jy3lvpjaahyrp4qsjcqyrxbchglaszx7ccyu4eq4mmi@557ienshr2ki>
References: <20251106140103.1406081-1-quic_shuaz@quicinc.com>
 <20251106140103.1406081-3-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106140103.1406081-3-quic_shuaz@quicinc.com>
X-Authority-Analysis: v=2.4 cv=Pc3yRyhd c=1 sm=1 tr=0 ts=69132ed7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=w88ekMslnmeFjZ9C8RQA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: mMCwIZ1GcEveLnPbiz82NN5b3v9UL4Gy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEwMCBTYWx0ZWRfX0GPbd8mKaFW1
 5xE6pEJ10InZELWpQtE4JKaNF2z3+jD5JAn6K39FRwRp6VgJuRiFjvFDxzN7fM7ZzZ1RE0fx41w
 cmGkuUNew2Rnax0jvhARQOO/kUXLFcvxKZgSjPPADkthHIXvpdxym16w/Q5kUuk040rSOzR3gPt
 Ayw/HnDTs5w8j0w5du1ydDjYtiPErxJxY5APBVpR4gdBCMoo9erNkRQPFH1qCUv4Q4zSV780+6F
 l7/6Qx0I1UDm8wj0TwVOgxNnWJYVOtQ/OAWIpzuRmVzpXd2uwUxVqbeyLerb0GS5Sfh3iUq4fZr
 JQ+ok9UE3cpDENusRwwrGYZjGOqUcPwuAiLqzInViB9p/avYlNHGxFJBiViOo4U6+4Hxhb0ZrML
 kFecVyjRdxsZLt9kFPknAdREhUE2Cw==
X-Proofpoint-GUID: mMCwIZ1GcEveLnPbiz82NN5b3v9UL4Gy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110100

On Thu, Nov 06, 2025 at 10:01:03PM +0800, Shuai Zhang wrote:
> Since the timer uses jiffies as its unit rather than ms, the timeout value
> must be converted from ms to jiffies when configuring the timer. Otherwise,
> the intended 8s timeout is incorrectly set to approximately 33s.
> 
> Cc: stable@vger.kernel.org

Missing Fixes tag

> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index fa6be1992..c14b2fa9d 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1602,7 +1602,7 @@ static void qca_wait_for_dump_collection(struct hci_dev *hdev)
>  	struct qca_data *qca = hu->priv;
>  
>  	wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
> -			    TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
> +			    TASK_UNINTERRUPTIBLE, msecs_to_jiffies(MEMDUMP_TIMEOUT_MS));
>  
>  	clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>  }
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
