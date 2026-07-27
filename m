Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5A41B8F4
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167265; cv=none; b=dMDanXvAp/l3vvo/7t0E2x3dIDLSCgaYbx7qWPV/GdjYOvVkc7hpXZwydPgXbB4W2LDtk9T7y6YjToCgeMuppT1yIKhCjkRJ3x8B3EBnNiG0IsNG1YlguIpYl6u5r3HE5SOGQnqQND/WbUeTC/TEXtpVb0uRtXjpCcmOWAW03FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167265; c=relaxed/simple;
	bh=edrgEKiuX9r3DPNTOc/Fnga2FKyQ3D3W+DpInSk0FzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kEQE31xnQ8ocYeYNzPSbZHfYHF7y3kdzKphuM3JZG8p5TJ3AiRP7g1NqLupfMRCD171Q5YqnRqRN+lFClEi7kVzcYVb7a+P+N3Ft7wfekwbq9SyGxPmFIeaQF1FckZTyweBq6pg6VuSzwMj/EwHfH0kJ4CAhdWMV/PJm+1J2/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LtmJvRPo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RpzvoGyl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LtmJvRPo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RpzvoGyl"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlZ4E4115069
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 15:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9qQmopBmnQe8lYcAy9G8MLBnJehJeXm67JyvEnK5thw=; b=LtmJvRPoxyVm7Ayj
	ulNCEt7tww6LdXsrntunqiQru7GBFIS+D8KktkVutXugG5XH2XG6I+D/Rst5dFwG
	smHyvxKEqhakb+fF1ImrJUyRMfiKqxoZcklzMiBaqn1l0frEBKEr35Suya88vBVF
	JPykPUIQTXfip8Po2NO1MuD8eXHz7RYHxXxhvFVQkeJfatihj15hRq8AqxljDE46
	o/6I+BW+yv555Tf8g1ZEack6MdkGQFGCAsBVcgOAqMNO9n9PMGwNcVk39KxkgkRR
	tMgh3xXd3bVwaaYrgF/xJtHaoCaSQ5YXy1v66Sr6b7IN7a7rYBNeYjo0Tf91DMUI
	YAG5FA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4mrsj0t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 15:47:42 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81e8a76a273so73894777b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785167262; x=1785772062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9qQmopBmnQe8lYcAy9G8MLBnJehJeXm67JyvEnK5thw=;
        b=RpzvoGyl2sSPlOZHvtuSaaOOZty41CH9Uhw1w8qBLbQu319nfDM6O5BNZXxckHIfgz
         NUjPZ02g1h6j55VwgVLNQ0w2P17AYAVqo0dPM+cI8kg1zvyH1sbR3L7R75mjvHCaj3T/
         LJ3GOKVMx+VfL+wUq677R7YiznAFYKLvqqp2A75IOnHoBoYlALWs3V9IYByv7udj0dDT
         caTDMZNniKGNNQmMRGUgfmDepk6/nffdE7Na3j/P8FvUwXfvXnN82XnK2pJg/QQZ9rLg
         bmFCawyBCHx1JU+Rclt+dS3lzP1ivw+grF+H2hi6WvCS3ccUr1c6GPpSRUwnfrvoubMC
         WZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167262; x=1785772062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9qQmopBmnQe8lYcAy9G8MLBnJehJeXm67JyvEnK5thw=;
        b=C88/d8bhAoNW0/4n5j4IUAKVAk0YCBC/bKVpBqq9d6s+6wqURoHlXWkqrCZdJIwSbk
         ZGtgAW11I0nb+qn4dotVbuEcBJ3po4u0+Fs+RTzxJAa8po2ReNh4B1HrJ7ZwWIIyXKty
         +pI60xEkl0/cGfw0IvNilI3JSE+RS25SSXUDnhAs5Xo3byXUsUcxoJ9eikoQg6drrbmz
         XVIpI3wT+0RjKl1VboCBifLfAruRYFlxonyOXlFgtgh22+mXPFVooEFkTZqkknBrJp9L
         JxpAkwlZc6R1zlAAetWz97U4SIxUIKjHVbHk9OWJaxzOMNXTVIkyTIOuAAUNinUXh+uw
         nsfw==
X-Forwarded-Encrypted: i=1; AHgh+Rq0Jzf64x04TEayMNBlUgeLPqx0X3hqvhcwJEJ7q9yPu8O9uqHhlH0PadevJwQrjczxVXOF9ZJYKKYZilic09c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAm7Bv5JmIjxgv8Gu97r+AoDswmfoownggrmp+gZIGXum5empA
	j3N4HqgrSJmfrUZ9HxUAfkAF9qsIIlBT2jbKluqUefF8gFkJXebJJQOFqPlhSGCMe+rdW1xtB72
	YHS2/g8k4RUPupzUbazC1nlfJ1EwaqCafvtHCpU3bF9RJ7oMdJEl9EAVW9sbTJcSCtB4tuOw=
X-Gm-Gg: AR+sD11EgGwgJbM1W5cTvSBgt/V/KjuTrQVNdveBGeYS6Ulay9p88nnkhuMyetSKXH1
	slQm3sFESA8Xjtk1K8zeh7+F1tF7farpU/aaXaAeaViTwQTbMz4OanYUOmslcP+/nc3zwo5ZvoT
	hbb8jB5x6145FbqNyRrG036LBfJTKrcAxBLN6NqnzDo/vsoYlAUyDZ5c+UfX3eNwJzdUbhjNOqt
	copaJEdW1kIhiEXyYGmF3M17rTeghE9et5kIz59yZGunz5FDxbvGF6FtZ2jEngLFcTly1NOrqIi
	a7gmQ0bj7gcbMI/Rbud3/4+EkYkAxAuxipIAHpK6Ca/uHjgoBkoxTmMIhRSaAifF73mrBeZKWKv
	cIpl2uH/ybtc/N/lMTVwJwpWobjn7HQ==
X-Received: by 2002:a05:690c:6b0d:b0:80c:5ce9:8f29 with SMTP id 00721157ae682-81f93970cefmr424017b3.22.1785167262283;
        Mon, 27 Jul 2026 08:47:42 -0700 (PDT)
X-Received: by 2002:a05:690c:6b0d:b0:80c:5ce9:8f29 with SMTP id 00721157ae682-81f93970cefmr423907b3.22.1785167261988;
        Mon, 27 Jul 2026 08:47:41 -0700 (PDT)
Received: from hu-samana-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657c727asm33307617b3.19.2026.07.27.08.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:47:41 -0700 (PDT)
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 21:15:05 +0530
Subject: [PATCH v2 5/6] arm64: dts: qcom: kodiak: mark PCIe root port as
 bridge
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-rb3-industrial-bt-uart-v2-5-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX5HpP59Gtp4mP
 MlwQzTVvidMS6LfxpJVhgFJc/yUZpBzT64EdHfWuHIvzm1DPGdZXfKdSgfid+AN4jRdcZ/0C7EA
 RqI0N7v+rAmuOFGLIw6P860XSShiD0I=
X-Authority-Analysis: v=2.4 cv=UYBhjqSN c=1 sm=1 tr=0 ts=6a677d9e cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=HviaXH6R_KHU2YAOoPEA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-GUID: Fr_zTPOvNFipgguwH9NUOuJxXmAINIpR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX2EIpyzwxmCf4
 jk3uRe+vTNMw3MCJgk7PA3h4BQSEPD8UTz+pQnc6BvIGHkyXGRPdTxPSd7GoKf032oZkltMIpyD
 gkIxdUZfyTMvulUhewmktREcueswG2C9BhAlfQP3cUJwOaZrUD7LIMClwlsLhauzK0SlGwCuFG+
 E9Ak5clrS6pxA7QCARKVklwubwKs+0GAnmKTm3oC1Y68xAHF8/BrWrUw4x/d3k6lW/jMBrwDMZn
 J7wSGrVRRujwtKaxgIxVTeFyRLA48vupGmrd5EVZm4iSiqQrtXzHWIiVnztJ+d9uTFp3CW6vAp/
 fpar5xT5I9R+dJRToimjq7DCYUTkqg6rbqpdypim6v4UobZ+VKuSf+15iTVfmXXKaK4q9HdThVQ
 1AVDUvzFnVBYwrMSOkvHj5C/sSpsVBjafL0tXY3VKPDvTn5xppsy1ZezoYkC+Ag6jP/JS2ikVdZ
 C+Pxyudz0yi1lcHyFDw==
X-Proofpoint-ORIG-GUID: Fr_zTPOvNFipgguwH9NUOuJxXmAINIpR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270148

The PCI core needs to associate the DT node below the QCS6490 PCIe host
bridge with the enumerated PCI-to-PCI bridge device before child nodes can
be matched against the PCI topology.

Add compatible = "pciclass,0604" to pcie0_port so child nodes below the
bridge can be matched by the PCI device class.

Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index fa540d8c2615..12594967d2c2 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -2296,6 +2296,7 @@ pcie0: pcie@1c00000 {
 			status = "disabled";
 
 			pcie0_port: pcie@0 {
+				compatible = "pciclass,0604";
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;

-- 
2.34.1

