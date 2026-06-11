Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C23DB303
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781179453; cv=none; b=b5S7e08KeUchCX42sK/VRrcBBWNgbU6uWpDaUWpnX8ftq6uO3R51qv2DAXoezQ/4AKjID64evgXhlN6d8taQFALqwmD2BsgwYVKo8JiZwdnkpUZHHMmiFwWt6oBURn8acyQujz7n6heRJIYpdDgqceieyOpFGrA77uPFTNx0YkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781179453; c=relaxed/simple;
	bh=w+y1X+ZNiJg65rSDstMld5R8KxYOqoox95WB44xxs3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZEJFsjTf5r0nI9WGKm0qqLnVvX4mTKZm1fr5+H+nUdr6F1PxiTS7BPPaAbrmHarVjRowyimAxKo17uWGpbVwlSXWlFcO897qR3/1W7fVwg5Mh2wVNK0Dz67yweSpkYf+AIvhxeka7U/4fTyFzTGpyjiBDpQPB7XWascIwdg73BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BGtw19oG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=keNQ82Ib; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BGtw19oG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="keNQ82Ib"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B9xJ8u2890233
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C0RiQNzKW417vkjMQkmym11eTxmsfGp45AkrTPKlifY=; b=BGtw19oGKNB/HWnP
	yq/EmwUlaOsudKOSR02wTI4jjuMRQpJuFqB5jrtIyovdYrbVvtM0pNx23k1IaYuX
	D7vuzLzmjgiucyVEgcWOZB2OlDDpZVx+Rb9zA6+VN0NXCCotSgsH8DWQXYx8aNs8
	w6IpmV0jmKN2o8KuGoGxdPlqUODpQ48JzDvCKnvRz06q8WrAYtkm0E8HzToWUY56
	RwegB9KBvinRANH/I2WlEfrrHPK/PGTf5qmd09XNchyRB0HH8nk1bi5ig7enKoyb
	S1CMe4Pq6Lo3iFZqhKED/eI/pyE8NgVtSGRGEzm3CtjyXnShmG5dx3/wDnG7ribp
	B0QCpA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe79k7mp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 12:04:10 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6c9239a1dccso345073137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 05:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781179450; x=1781784250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0RiQNzKW417vkjMQkmym11eTxmsfGp45AkrTPKlifY=;
        b=keNQ82IbYioI/w7JjixnBHIeW39mQUVQuniWrTxN28c/S+a3wOnCjijgACbNNh3xMc
         Ydu+Ke7DLyLnXIc+EksfGDsEM3qhI4+/pohH93jUSYyKPaVRv5gnJbSjscwiHtoZTc0c
         AN8RXY4JhzLVgaWhqLaiNTuWOANZPrMHv4TGmLo9ZlLHwjKzQAsDjoU8LepQ8NyB5A7N
         HsA+VqKjcEUNE5YfLqFgychHHiYLzY+C6Ct+5P/ALk7tTXLLTvnnX3kkXkjapTgN8vTd
         HV/m5utHuJ6zUQU39Tms7vMlXh7hmq+Z4uf000oNB0viw9OsVD54wzOog0MveyPgqQmR
         ysDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781179450; x=1781784250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0RiQNzKW417vkjMQkmym11eTxmsfGp45AkrTPKlifY=;
        b=Zx1b7VjDUkv4qlYnmVYyeWiPlofCTwnivlOKasd9FHaFxjU4ulSuntUBAjgyWgueqp
         gsyv5s3VxP0CWeQFx1jW7FIasx+pW1HYfwuEh6NjUzfL6sAEmrWvZJdYxkPGy+wgGSg+
         xAjv8FdDMBJLm4r55+vXlGLebOP14OZ7atKuKUXqdLGBHz4pJFCwkC8hEVWcl3ZLZcF7
         LdMJ9ezd8+ApCeddXC2zu7ZRc0aYcTS+QvoVZoRN7s8jgikhJJm28lRlQb+scbXT6SCN
         SgmC6lP29T+yF7x+Kg73hPrzhvKxdaqumFza/L39Qhj4MOdKvjyBCHFkhiXamLuuK1RB
         uj2g==
X-Forwarded-Encrypted: i=1; AFNElJ8DKIorg6euVASj18L+coCIwi6U4oIIsN/c3nNTirmQRfGf0rSSvqjJSN7rgiSLPvhwIGaxhuI8rYdesnuMheQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5q3jVAyw1WYNUPAdNmYZymRwS7XSA8KB4c9P5gIWcHoRod3Li
	1eyM/J2dnImTZdgEiEE2Ej60905BiKBE0LxXOzOPsUpLL7tcW0333FrrkII+kM2/WD29kAzYl3n
	EtwAl2SBFdlP46K+ZbcmPnl+4b0CHUsi31JH4ddCg85xDUy+ERT8Qdc0cUv8V9WpXEm99UOI=
X-Gm-Gg: Acq92OHrsws/HL1U5oTnhO3dV8KhTv+peKZjS7TO7dajtPOFoAr5E8RrwoV/AEjRizj
	eTIEkzT0VkVm72YjVQgDupZZ6F1MpdQ+8erCKSaBxb2EjOaIfPrK+B+KWYmE4YaE2jjetwaJ8PI
	BNPXzkU6K3zKuDQ99IyL8xUi2R4WtGrEY4+3/zwsjAp4Dfe9FdGpIWvrU25oxmhNpDX+Di8ZB9K
	bu1eOTnrEHfmy/SoRzEt7A60OgMsPiywBYBQWBsD+d3DHsyhQH3zyJL1J1p36bD43QS7RBdF2d6
	A/yYbboSQycUcD37k4MjhH05dLzttH0VbB3bm9O+dhWnXQrdqWMXR7vmLtDs8vL83W5ZsSgL5M4
	eBmamOEqJxdSm/nVCrVMiW359Ydrt+gnh30ZX8qenWjXkJ5Q6CteCBnpB
X-Received: by 2002:a05:6102:374c:b0:632:c8af:8a8c with SMTP id ada2fe7eead31-71d5948c72bmr230959137.2.1781179449899;
        Thu, 11 Jun 2026 05:04:09 -0700 (PDT)
X-Received: by 2002:a05:6102:374c:b0:632:c8af:8a8c with SMTP id ada2fe7eead31-71d5948c72bmr230784137.2.1781179446795;
        Thu, 11 Jun 2026 05:04:06 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65867e67sm10883829a12.21.2026.06.11.05.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 05:04:04 -0700 (PDT)
Message-ID: <34796b1c-7c82-46fc-87c9-6c0b9327e894@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 14:04:01 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sm8350: expand UART18 to 4 pins
 config
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
 <20260601-sm8350-wifi-v1-5-242917d88031@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260601-sm8350-wifi-v1-5-242917d88031@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tGt7NsqnacCbIExFolrPePhL0g7WujIz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyMSBTYWx0ZWRfX7wT23xhpP5IV
 5+a1SEWdmWENuY4xSCpT1/aBfjQW1MAmPu8JxhmKTIVIXqIKVAZupklVs8w5SKuI0LpRT84JZF+
 C90I799l8yp1DjsSAe79GTgNZYgRPigY+EXPLxW8+fqUWoUFimnaPZ8279hIqcuOEdIjjPriqsK
 LlaAJtHFHnw6584RV3WAZF13qe1/yUBDu4e7abtyDyyUPDDbIrmOgvW6bHmA85enqcBKC2i+4sV
 zuqyanA7/DuS+FLC06mwzupoRlDP1hYGbBNp3qJJxfbnrE4P0LnVcbvx7osZbf/P1BUsrxH68p1
 CXsHQGlxcJIhhr5Opl7LFkfThmBKxwYwHYkF32hqCBBnHHFWqT/QSQVkyoc8f4S0Frg8deR9jlt
 1IipNlTeLTeioQivdNZRnGIpk7RHMm0kGMljhVR9wCUh0G6WKOrlvHhSsAu2A/i0hh4uRBZeaKV
 EeUMeLGwPvSu18fEGjg==
X-Proofpoint-GUID: tGt7NsqnacCbIExFolrPePhL0g7WujIz
X-Authority-Analysis: v=2.4 cv=fbydDUQF c=1 sm=1 tr=0 ts=6a2aa43b cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=IZRSYuELQJJGqPscr9cA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyMSBTYWx0ZWRfXwQ9okhcSqy2X
 pEyBtEbou65hyds/5wZ/l/lwxzjbeJ0liPIDC90WcrRMIRwC6InZU5H3h4c/1nRT3qwiHJY+XxY
 X5Y/wvWAmDYLWzojuAkY25kwTXM5WbY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110121

On 6/1/26 11:46 AM, Dmitry Baryshkov wrote:
> On SM8350 platforms the primary use of UART18 is a 4-pin UART (targeting
> Bluetooth or other similar applications). Add all 4 pins to the default
> pinctrl entry for the UART.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
