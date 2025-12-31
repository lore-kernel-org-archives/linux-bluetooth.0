Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCBF222560
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183572; cv=none; b=dV4wYSe98+PrCm1tngNeIBb7SoGwqRitv3rChYBPfJvcZ4jwCXi3F3imblMnZ4PbNFnOST9R9uZEqQFHc0wtpAaCbhSccHXehx1+obY8VsMT4tlq8sQ+OkQL0iSxVtqdEf4ASTL1yZ1jmTUNrOdBgPp9DPMf2gZNSZGLCoofpB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183572; c=relaxed/simple;
	bh=5zE42THlvMDT8e78ERAJCP3VXwEkecj40vMqsrK/4bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hc1Cpc4i9Jlg5EJIyPUOhgGAEAxd0p2Wgz8YAj2WyhOk5gE3vb/tiOT3ZEpn9mKVf+CmlpClQalNtl7A2VeoR8/wPdUoCimrRKdR4nusN4ERqz3Y/qN7nxVEgeS16BxYiKx651Pk82xDxP838/SyMuUUMve7wruAdeEFSJW+6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SqbFdJji; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bBVNJmCM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SqbFdJji";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bBVNJmCM"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV78V5L2733286
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xz+xZs2XNmhxuGnfco4MJFSJELyf3YGCWmUww37g3ko=; b=SqbFdJjiHICg/tIN
	xEggnwI4mOibHhIycb28cGfoiu6ke+edR/CNYaNq6x/50ZcUqV1Pid+1IHErjiYD
	xtlpIcatn6HUYrB3UfUaC77I3TXUSOMMjyVm6ofcRIe6XLwj3AJe0d78Vbo4nYUT
	aK22TCMGj+/0mdnJ1PzMMrzehlrRn4T0uH8kWS1J1ezNwJDHuIKnsvAx2YYvAZ0Y
	zUG/GZjK6s7ur1B+ooUMcd/gnObBRPYqV54FFHkPSs64aAVzj5L1bSAwNJzhmHK3
	9WvkMlPxq5lRj645il/843Fqp1byQA1C36A2WHWhzONU75ubYJItuojOIsn7JFYw
	i6TRSA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcy6aggmm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 12:19:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f34c24e2cbso35493551cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 04:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767183569; x=1767788369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xz+xZs2XNmhxuGnfco4MJFSJELyf3YGCWmUww37g3ko=;
        b=bBVNJmCM6B//HoSBP9RNTUsUGLRFpgwSOCq20S750HG58NSx7qpfp86uoEXP22hdYg
         j2DDswgUrVbBAPBEcNM8ljRL+DZVkbSFCLN3bbr+vIuQMiy9a8QR9K/SocGO0f6snmCX
         mDTnT61eSwWj1Q9zp1Q8HkhFppHL/suqvD76Fv+G/Kfsgq+QaIGAZpYekrEvayB9s5EY
         gSSovwlOoaGHuFiBwYCgDGwshOtBCjxA86NS7i1DuGppWGrPCSvOXsxUxiYPW87CSC9/
         VXuMoO51O0eeqTEevJ70hOeA6Y0wCNxxI/dzRBYgo5Pulx1M+PxzcfBZhp3a+20MDWFL
         PEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183569; x=1767788369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xz+xZs2XNmhxuGnfco4MJFSJELyf3YGCWmUww37g3ko=;
        b=Eo+IbS0gFRfUVEeAibIbsFULAZIhL4KFW//vF7QGZ8vyA6ZoSXdylfHUDQcCdTDZBr
         /EOwyTU48JqZf7eEpacWGqcun2fbA1N3VFAir00V2jlXRzvpJNQipfM6fvjfD9OqSBhc
         FJQRVG4avU7Rk+PpdudO1IkMWnXn33s2r8JYbSl/vdDX57kd5XoSbZlIKSabUv4jxp6w
         7iTw8c8BGJTLE7Kr3n2KFkz2OgZNkLEf5kNsebkh/mvRvz0jDT8K3OtRkBk5txpvaz/y
         9IwXsFyJx6eDLDC+cgQdmzbls/j+hq4n/7DonRmt3PC8EQtkZZP/62XAHbXelVIe7oIQ
         nI5g==
X-Forwarded-Encrypted: i=1; AJvYcCUlidJ2nh3k6oGp82io2HmB1+nnmouNOxSfxo4qV+708o561AEx+n4kYNohcdQQBPyLcZDYPIiyX9XmxOoLfJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzjrsuZUBYM3Z3oapUEUika/z4NM/hIKJnpQPlpuH59Gul4oTs
	QvJ0WwgNUpiQ+UztqAszs9McYwri9NBs53BlRkDlBikjbnbnx9OzIYfgHSnm04WsY7Ij2gv4q5O
	nyxlm/p+nZllnEDa6gR3XJmtBU8UbDx1c3l0qCbiYjSub0e0g34rTcxU1HzLFFRlRE45XLX8=
X-Gm-Gg: AY/fxX4AYfGmA/NY/MLol2yz9/PYEf5j5CRw6Plkq8IZb1cnMbsG88JXKPBwhw2PAHN
	BVfoWXF8X1gXTKN74oFgHkitmrMfaVX22RpbahPwdhAo0cikjKbwKzNLX1nVevvdk1kz3ruzEZq
	ke0Qvy0X6krY7ckB+1uGS0LHHGwIWshS/iMkwliqkRpiEhxb7D0RvFa7vHnj6Xcq2SeVPVqxj4s
	yLcu8W25NrSe+GpLkDeqIwUQAX7yOyQw7pTNPqDFAGpe57QciYZucLh6W7gIRP/rwv4s68HBhkj
	Rab7PRFIuL/U5uUG6y0Uss8kRZpvU95PIZEbpng28os+tuhfl9a7JWScb5wm2NO1suekNQat+bG
	gDDzmaDvAX5hFCCKulmYqNP2jca2KSQuqzAk78U9zauh0zWorxHUFqcpGQR34kYRhnw==
X-Received: by 2002:a05:622a:1922:b0:4f1:b3c0:2ae7 with SMTP id d75a77b69052e-4f4b43e3a80mr373002511cf.6.1767183568706;
        Wed, 31 Dec 2025 04:19:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE17gAkMD/VQbxKbGwU9yVlfZFQ5opbRwOVwkfXCULRVa3rxvdDFea3lTOfrcxDClnLVCPsfA==
X-Received: by 2002:a05:622a:1922:b0:4f1:b3c0:2ae7 with SMTP id d75a77b69052e-4f4b43e3a80mr373002211cf.6.1767183568144;
        Wed, 31 Dec 2025 04:19:28 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91599844sm38020443a12.25.2025.12.31.04.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:19:26 -0800 (PST)
Message-ID: <ed3e9128-cf11-4ba7-a7f5-cac2c537c2e3@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:19:23 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] arm64: dts: qcom: sda660-ifc6560: describe WiFi/BT
 properly
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-12-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-12-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6rBxzW0vG3Ln01xJd3g9qsqi-Rl-VGJw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwOCBTYWx0ZWRfXyuTeMIt1/OXf
 Mqw36KN1yisgairaVXXLpQCyLLj69rsG3D7C4XcxdpCiKMLu4490K0ib5DpwOnr4Io6SSDvAzHT
 OUKqntxw9eq6gOIAoxWtSTDsDgn845l6N0Bfkm7SipmVKvI9zJySkmeJfslo21UEcN92G9IxjsL
 CH7FBasVEPcCS7B9ktC9vC4IpHwPTzuFstWv4/CJi1dOuXXaok7RzRn8P/mzKY9Dl6GsFqclgQi
 ZW5ON5oVGQszZi8Bb+9rl4MWIy20ltIOZ2u5JMCDtLTfUo/wT6N4AurwxnaAdgpFkiP041sYKda
 vw7yX3rWYoNw/op9Sq3/Pg+fTqoBTRJd7WUQiXSH6VGgqLB1sRHWmlrVBslHsEHzCHwIkj3mc1M
 e8nm22S6znAUjba6b2XmTwrkQrraoWCvaoyBKeG+EcULbrhbrMRUFRJOcnHOtHfqJxhlQsmehOS
 X0fo26qh2tWVomfk87g==
X-Proofpoint-GUID: 6rBxzW0vG3Ln01xJd3g9qsqi-Rl-VGJw
X-Authority-Analysis: v=2.4 cv=J9GnLQnS c=1 sm=1 tr=0 ts=695514d1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=YN4nVyxdPvXl5XCbABQA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310108

On 12/31/25 12:36 AM, Dmitry Baryshkov wrote:
> The onboard WiFi / BT device, WCN3990, has a simple on-chip PMU, which
> further spreads generated voltage. Describe the PMU in the device tree.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

[...]

> +&pm660_gpios {
> +	sw_ctrl_default: sw-ctrl-default-state {
> +		pins = "gpio5";
> +		function = "normal";
> +
> +		input-enable;
> +		bias-pull-down;

Ideally

func
(no \n)
bias-pull-down
input-enable

anyway:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
