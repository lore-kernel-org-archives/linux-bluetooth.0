Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A952C29CEB
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064940; cv=none; b=MASM9cMQQ506D/o5hO9eyXGTeueBfA+nKyqvEf/r1yKO4doT+oEBju66W3MdhF0h1b9f24cMCEDV+r5Q2mmP1TH6yH1BB/ZNMHIkZoz+uHoAXrfnC6H8fBLzSYFEqARn38mzwevskG10ocfWU0m416z7WttFvkvUSRtFsJlL3UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064940; c=relaxed/simple;
	bh=2/Ubuvv4CRNzD5FkKlWviFf1YkbHNjdYEKg/lElsMpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s91bigd9m9UO63R67XZ/4jVDlARFDvEMS7nvnx8micNGeMjznrOpGxUWV/zzP0a9rMI5ujWGMAwwFvO0Exnvdjvlr1yYfNG/KRY14f30ffVoRvVZYYUSvpnUEsQvRqEiTOZiNSMhncTb1x8bEp0yWoGXhnidDQViNZdOijk+SPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fMRbqKwi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UbsSNHnF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fMRbqKwi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UbsSNHnF"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADESdSv3801307
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 20:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ILd9PUMGN2TDvVwIqXslZCpGKIvmjdh159cGGGmejh0=; b=fMRbqKwiuIH8ZEd7
	Gfs36gODraaybkk6C79RshPCRHamKWp6cqxOyCpTYWZHzbTz9OKt1d3aK6PCHePS
	EdUVcLzpVtvPxkw5R3VChZBh3b1vRNHZtGri1vcyw55kbvI32CrQZM0YDI4DsYu/
	SWnpw+xNg3/PPYHLgcgo6Nnk7s5RrbMqJPVoPk1MTO2wyF1Y9Wyfo63KDU9tY3Et
	yudxGYV3AqnQY88orvexm4+vgU9T9wGFBhyZ4qvMLVtN7u2tfAxXrNBtwEdPha6j
	L2+Z9hdZh0Io014C8qwVeDYXxqKU807JIAHaIgFZOsVklRyokbI1LBwRquLBNfrc
	rBDeRw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adaamah7w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 20:15:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b2640347c5so390228185a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 12:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763064937; x=1763669737; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ILd9PUMGN2TDvVwIqXslZCpGKIvmjdh159cGGGmejh0=;
        b=UbsSNHnFcklBSr2Wv4Gylg6xAeUbf+tj47SsYzkCsV0bA3UZeLyKLgmSZJcutJgOPp
         na2xPHr+r68Yity7jO/U/gWp/y2r5BMq9G+11TuEZ+x+JbZBgN27nBVQxrVmGENQWCUU
         2FYtQdODYBlJi6rzGQxA/1SZpFi0Vg0IpDcMhAyv7KPwUs9F/xBsblr3DvWDKRTHfNRV
         KmivUE5DFMnDrBfHDNzaHhUd58u0A5fVRfpegLCcnQX6xGMgSrk/hKbp6v8FLxkHmGxd
         mKigWRfMS/QMbxTCSFUXsZxvkYn95Z6pQ172RRQan79yROVsRPB91NIcHIKLjLoSfnE2
         virQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064937; x=1763669737;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILd9PUMGN2TDvVwIqXslZCpGKIvmjdh159cGGGmejh0=;
        b=hTpUIX4Y5+1wcZMqofNd1gf8NWpJBnKkNNpOAUmM/0VCJLuOwN7lHz214/JbeBaIyc
         AUoO2ra59tSyfsIua3pJYJcbIkIqf4q1wYyXX9VMM+aAl/BSBA1nHR3wx4dzhk6MzLGC
         vUqFHPPpw/FVIjIntWw5COEJq7RP9K3rTeqqXO3cG3iM0OaWeeICE5bcz56O9vfXfej/
         8tehkHoTkLiM4HAGAXwhu7o9jn88sjcVCLrAcaV9jxdOTYwdK6dZ8qPj3rvjyrLAo1tJ
         Lw1g837Jz0I0JBHeF3ta3yyfTiYIkQghClq6G4bgCtU/KspZ/25o55+2Mxm4PaNouAVM
         /A3A==
X-Forwarded-Encrypted: i=1; AJvYcCXgX2sy/j14uQxbbd6F7OJpLB3WYzzwcvBAL+EhPX6zpdd+8cJEGZWWWzTyFiV90MbxNem+4OkGf2lMCJJwgOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjeVVoHvZEhvSnRaYTQuJPvbBcUv3rFUk0DgM0GP6aBlzAAXce
	aQKFwJiVib1OCv6F8LulCW9Ykr1w3PKg9Z0s7/MLtaJ1EPdV6+zWG20wAtIn1nGEryvQh4C8kI8
	J8NijHj3buV/rbYWxxOkT5SuVQ0zYCbdJ3+kQz1D3/ZrfrywJAWYHp9SRxlMxZJW/7gfR/XU=
X-Gm-Gg: ASbGncu4xYfL+sOavEx2TJVPc+d36l0E7kJjFhZQtIxFbYQG8mDVAeaQ51OdazaRY1g
	3r87MZaGwa0SK/Jw9v98yEXoDz37Z3Np9q4iZW2pcUMgJjnXwze+plFpu0hYrjKaMOs6hrWVyR0
	OZLhrr/TSoPnCg3gjNyZOgP0QkkzKjbG3wR0mvkPuF/+71Fx/N4ycNWERqTAQS59hqw78HaZ9i2
	yaOae0vKC1lnn3j24BEdZtX6oCecLmSSDadqQpyKAaZXFV6gmvPpXmJN8mw3psQJ5KqWw7WFX1r
	wtCRfJP/cjA6cVuxqhkzLmsQJqomB0N7duU5cdUPYhQjFw424OX3FHNrsxWMqzfZ+l/Ncfe7uL4
	IEc5wsPgGx9Z7uknVtBeW8rUAfnUQnKQCvPbSyo3xPH6xMlKNafxiP3E+ju48sLkmMypdGc16D2
	0TItqDOBS+6fJk
X-Received: by 2002:a05:620a:4110:b0:82f:10ac:450b with SMTP id af79cd13be357-8b2c31c7699mr92100685a.65.1763064936485;
        Thu, 13 Nov 2025 12:15:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnqy2FoCmPRnlyXOKKZi4eMTrZOtfMsOc1+d2vmlJDOz7xyFgnjO1/YYJpqsIHOPAX691hHQ==
X-Received: by 2002:a05:620a:4110:b0:82f:10ac:450b with SMTP id af79cd13be357-8b2c31c7699mr92093485a.65.1763064935832;
        Thu, 13 Nov 2025 12:15:35 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37b9ce080e4sm6015221fa.2.2025.11.13.12.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 12:15:34 -0800 (PST)
Date: Thu, 13 Nov 2025 22:15:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com,
        quic_shuaz@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: monaco-evk: Enable Bluetooth support
Message-ID: <feaaqnezljrvqyxd5hvkmcjgezl2cqnjw6gmmu43a3h6chs3vc@cx56pcgckwoz>
References: <20251113130519.2647081-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113130519.2647081-1-wei.deng@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE1OCBTYWx0ZWRfX1i/LUkQ7tCad
 sIicQELAIXnD8IYdsN+0H/z5B00AawOyS68CUZk38NrG2QF8N40pbpwIiUzTvLJJFs3hitGduRT
 v8n+C48/ju3ys6Sp4Ojp3YiMtJT6WI09rnTqvJkVaP0aki+TAGInozuiuMvxyK2EflAB+8KfZW9
 tJboXoYJS2I8yGCr2Hj8Xsdo/jm4zU3kPYHLpgjs9ANKyLicbLKJsf8yUMbwyzT4ikjLW9zzcb+
 kow0YiseI9cwyR5elmcPR/507yzw3X9VjJ4ilr5bsCcCVGucwMDXyR4WQgyCWxaqtaRagj9Rlb/
 VdT5BLdGJJK7b2phEqmYIMD8uLJwbql5oKhKP8zw37E3ksfyZEBZEYLU3aFjFIjwGBUjvfkwLjY
 u/ZDo7iZd8NDys8SV8ALPa8YNqjf/A==
X-Authority-Analysis: v=2.4 cv=d4f4CBjE c=1 sm=1 tr=0 ts=69163c69 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=vuKYHiuAbYjNwaP7v-kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: bsO46DEkc_Zbqz-PsClggkYB-9qWh0yo
X-Proofpoint-GUID: bsO46DEkc_Zbqz-PsClggkYB-9qWh0yo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130158

On Thu, Nov 13, 2025 at 06:35:19PM +0530, Wei Deng wrote:
> There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
> Bluetooth work, we need to define the necessary device tree nodes,
> including UART configuration and power supplies.
> 
> Since there is no standard M.2 binding in the device tree at present,
> the PMU is described using dedicated PMU nodes to represent the
> internal regulators required by the module.
> 
> The module provides a 3.3V supply, which originates from the
> main board’s 12V rail. To represent this power hierarchy in the device
> tree, add a fixed 12V regulator node as the DC-IN source and link it
> to the 3.3V regulator node.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco-evk.dts | 99 +++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
