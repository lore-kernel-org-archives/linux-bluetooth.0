Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547D2410D1A
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810310; cv=none; b=fhfdjVQ6GuIfrpXGUCSWMNogPQX545IchpMqiMnzBEywybcAfpSjIDgKjzTno6Ns4MOR1YMaMpYFGPQ4YKAvBiCauMy/iQSOP4U/bbElh9JWPBoiQcJK/64XNTo5zXU4ufVLHFjYmXTcCpLF4KAl/G0CiALAcT5WaEJ0H38Prwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810310; c=relaxed/simple;
	bh=pckYL1D3CfZOB5jjUCobea/UKWSqfsWHwu4vQOAFNOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XB/gfYiwIy9xCAPqdCl74euw76yt0uZpsOHCevbHBkhGj+Rj3dTy93M4Wb+UoB6kr9krqvDM2vCoBLcNxVntJKzlfst63xU6n/IkewPnsFlY62UcUi0/Lt6186X+YylBkyu5oz4VaMDxBW6WNhfYJy0K2TpRQx+uCH5h4sgBhz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mUG/9zzs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HLEiQKNx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mUG/9zzs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HLEiQKNx"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N8qtCl3643583
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 12:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S3xhgn5k8TZxn6jp7Ofug3EkkneSnNMyQ6wGDXgevA0=; b=mUG/9zzszMxmHt6d
	EtuEty8QqN0Q9j/KAZ0kh9Z+LaA+zyUIY8WD+GInGfLJNaYnWi/z24f7MtaNadas
	jTJhZscOlj1MxzgBgpZaOWssGFJIBatd6IF3ZKeC7IrxUhCMGbQ0FRQt5LX30TzE
	MLPqDnLNsVX9CeNZNIMMmEq5LMcZzsz8Vmg01MuQoe4iKjwYTpDF4Z4mZyhEI/x4
	rCAZK/u4aWA+fNSx/L3L1uzkN7nc9OlcJP096GXKLNoD7ekRC2Atut1y1R0gFmEG
	6s5s+yxmMtc1jgs7DRdiAFnmw+ZzWph0Fx25qMEHBTu4cVJ3P8+wqzObuD9ntMLQ
	6BEkmg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkayha263-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 12:38:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c069f73e4so1921761cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 05:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784810307; x=1785415107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S3xhgn5k8TZxn6jp7Ofug3EkkneSnNMyQ6wGDXgevA0=;
        b=HLEiQKNxC2qjk63A9ieDdTK+ErpIXTQDH9Te3itjAtePNtnLEP0foH/QsFzlUkcKD9
         LgdSzCPjsHp7M08jCVSUGPmXJwQ3+EDqgynEBvySGZDqllXh80TVrbgn8DpeynwubYBk
         sUTu2jU2kXDNVVJmUc6O643te0xcHnIC/3TrrZmsD30J9zh1csndNHh6iMH63zmmxBr2
         LpkREhEFdEksnOul5Fl4RxeovLmdF7sVqTqlooB8QCzMp30XzvPi7LTHVUw5/ddz60Kd
         MTFZY+SEFnguv9zDtjkW0l1NsKXFpgqFqSdPg9wVKDZL26b4ClRoLWYCei5eEQQGjLnJ
         4sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784810307; x=1785415107;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S3xhgn5k8TZxn6jp7Ofug3EkkneSnNMyQ6wGDXgevA0=;
        b=Ng3bFVaGknP/jMi5IdFUi3oepBs6rmxGioCr7kcXz/CP7hhY+O1W8N1lZCFivpHJvM
         zGf4VyKVilwWy+k2AXMnzwnzil8hH9anGPctzJdNTFZ0oBrb6zN54XVSSUQ/TN6h2BkL
         yNoHfnkR7Gk/F8yhZugL0dKk7qaQGZ1fxe1sDMyPg3CICx8XlztSZ7Lzn3jny0Tu4dj8
         MNYnVeEqAacA2FAUKZ9Tg3bfvA7PKjohpqWyeFn4ZogxgDsb4eERMEkjyHH2/MWzvPSG
         Pu+BOP6XRCtvTwerVzcVtOmx2iHWEehvlssyuvYiJTZyV6mJrOZ1j1KEvwtUQvE2nRZC
         PLIA==
X-Gm-Message-State: AOJu0Ywv+CTktY33RJSuyzmLzVKI9z1eO4Ykw2LaJEk4hyM/D3QB2exJ
	Q9BeO3IjQE41QUJhm+PzoMhv8pwJUZY0kIIzUj7WXxCOe8I8SKkD+UCJmRC/L9jhEracj5bLZiE
	9YAYXEuIwyzo8akSH21MimG0Bo7jYwOqwVXJKdtlBPsCBShKQuHKyds6k9nFd4fbQCIlv9oo=
X-Gm-Gg: AR+sD11+wOtqdBnazOldun0ma83CRkIEiM8OrAT1ZYiULsFoZ8MfI0KnLA6eLVHtBI/
	cwNuzMenhpMB+T5sBNq/dFUcwOqcHd8rr0AFog/P0pLeszmMcIv8EaKEZFeE82dCu3qW2UF0kFg
	xAaVeC0N58s1miKRYtAWz5WV2jF395ZL5no/XExnehR2Y+EIQsCnAmzU6bRl2Re6uvLtiYBdJqY
	3mtHsDFiyorvKSXEA30wbP4NFgvvK05ef1aWbueB/Uis8A4JosT6k5/ewHu5oWM6Iqhr31CCHTf
	WXMA4iewW2Y5H9hjfgcjzxYR1jkPjFqREj4YeNZKeW5/m5Hr9T3tOGBuKdt977U1M3dIJGy6TCm
	tixOfyXcBtvZLOWpIpQ4tN6V6
X-Received: by 2002:ac8:570d:0:b0:51b:eab3:4ef1 with SMTP id d75a77b69052e-5283de02881mr20141181cf.4.1784810306676;
        Thu, 23 Jul 2026 05:38:26 -0700 (PDT)
X-Received: by 2002:ac8:570d:0:b0:51b:eab3:4ef1 with SMTP id d75a77b69052e-5283de02881mr20140761cf.4.1784810306121;
        Thu, 23 Jul 2026 05:38:26 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32a76fecsm224033166b.8.2026.07.23.05.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 05:38:25 -0700 (PDT)
Message-ID: <2df9a5b2-1807-4b10-96ce-4b447ccf7b49@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 14:38:22 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: kodiak: mark PCIe root port as
 bridge
To: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Bartosz Golaszewski
 <brgl@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_hbandi@quicinc.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_anubhavg@quicinc.com,
        quic_mohamull@quicinc.com
References: <20260723-rb3-industrial-bt-uart-v1-0-3c8e580c09d1@oss.qualcomm.com>
 <20260723-rb3-industrial-bt-uart-v1-2-3c8e580c09d1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260723-rb3-industrial-bt-uart-v1-2-3c8e580c09d1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HZgkiCE8 c=1 sm=1 tr=0 ts=6a620b43 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=b3m_QctH4RwnUCLtgwcA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: UUBomTJyaLh5KZAjpF5eE0d1HkMzRrGL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEyNCBTYWx0ZWRfX94YvpIPRM10M
 ubVQ32nJlD1D/buD4ZeJ2vcBzmUqxkLzx12pUMhgAhcmvvJGiL2m1MfZ+qCUmTfDA9j3IDRYfK1
 dpB6OaVqnva9cr8OTT1E44kQvX+A7k1qRZ71SbDSNOF1IdrXq9Av1bKQoXC5uN5v9Zu5F2Aufib
 8N2XHjn7+m4C7e7cmkmtReiYPQ78pyqBJUQ2ovHqzJj4DMfkM855NIHZt/PPzmGs16UNLrNgIeZ
 OtMUw0/jNhGtuGdoUDR8GffLw8mo8Ts3PiKrRe5wdq46j0sKKJjivasAOEIl2dDE2CZkHZbD4AO
 mc22ckX6EvwE/6Jj5eNqj6hd2Cjqsb1ume6+zcqXUzfnlcb3OQAoe+5tQIECULrk1253BvKq42g
 IxGUsbmIfWmR5VlFx47RIaJkX7Tvd6xluotYvpO2d3gutqPqgCmosXm1ELqYzoV1mU/IDxgxF+8
 MOyXGLbr6tXO5PeGjfA==
X-Proofpoint-GUID: UUBomTJyaLh5KZAjpF5eE0d1HkMzRrGL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEyNCBTYWx0ZWRfX53EsaYwY9xdo
 JeS8NYhvb4s00muJjUTLAWb48DpTWiMw8xqavW2i0r0iyCubQIxC0FsAkOc/cEiyjrcm8apCy/K
 7Pdr65Gn58XRb80IKUOF2YIZhOBQ2vg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230124

On 7/23/26 2:31 PM, Rahul Samana wrote:
> Add the PCI class compatible to pcie0_port so child nodes below the PCI
> bridge can be matched against the enumerated PCI topology.
> 
> This is needed by the M.2 E-key graph description used by the RB3 Gen 2
> Industrial mezzanine Bluetooth UART overlay.
> 
> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
