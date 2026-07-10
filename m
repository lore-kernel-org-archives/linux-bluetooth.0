Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D1A3FCB39
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677477; cv=none; b=QfyrcpYs2uY2wIDDHNyXVLl0ofw7NTcxDauCeBM16pQIxZvcqoZvvwO/RHDLHe6w4qDi0zozSlIvHNKDuK/DGSCLxBQSmZddvsgW3K+jdUaQUNn+ESBbf4E7rBYGGw3O/udrBUvhCG7yDnk2VrrB7i8BVXPCXknYuIKc3SCfATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677477; c=relaxed/simple;
	bh=GEXkKTQcMMDP/edNVqpiosVSMOlJ5AlopPURs9YheQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgxiOr5/jZ70t31abvd81pSXaVWEuEFxHEXXvh1HeL0zkB5aQGS/1PqholRKL50Elict5ryuD9K6N0W8l8rgtbLJfgOKkKnQlTo5jD2u5xKvqZUiZRLR2VGFMi8y0GmZQicBc4s41h+D5iz2rsjh1qbVPIsRFd3b89NS8TTWcTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QTfkrBSC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a3EHxBYK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QTfkrBSC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a3EHxBYK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7eHjK141494
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PGp6Gz4cU4q54LW0ORFzAwYhub1+CHS+HnXdjrR+z3o=; b=QTfkrBSCtwQYBIgA
	9/BP+CdDEcojUzMSbjD6hDcxDj8iBVqDkA/tXoLBhE5W51fgAlZmwbyXbWKUWvBL
	kzc1IECbrgNOXxhmMKGBQhMMz1ZMsdNX0wchJ1cbCfzFBskfe7JwuFYh4PGX0Ax8
	JejxBKj49wmapeykb4tvy/J4a8fT5DiRfxZTOergejvB7gc9TLk264PGv04zUUjq
	lK9pV0nXrZUkm0DUswJvddkTB94HlwmZtg1Zuk3p59SBj2OM5kW6tN0yJDpoP88f
	VLs4nyBA1zWz+iwb4+OFt0psbr9GyrAKA2ke5xPWpiixmTKG05dyi4MY0NYFDZv7
	wX7c+w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5munqh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c21c01cf3so13990201cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 02:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677468; x=1784282268; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGp6Gz4cU4q54LW0ORFzAwYhub1+CHS+HnXdjrR+z3o=;
        b=a3EHxBYKq7aRCD2vIozgBsn+Jp2M3HaBecMXWmXWuHjFcsGAACLwNNh5Ogypyk9qe1
         CBrs20BUrV0LXTBjhgNDAKtvuk7WRJCD4CfEHfCeo2AkCrEwwW3cS9KMuyp9ShYY3rKT
         1zU/S0FHCmoQJHx7TlBrrc7Hmd7KgExVFyrYrj2dr/d4u4zrw+B79StqQpRtPnW4hOgx
         gfZu67f6pA8kYbRFLzVErOzKVwO3OQFa0DvQc01GLvvvWTeFNqRhAabA+iEhXcZWhbbi
         nXcIfeSSYB1GoIelL+LxBA+ZG8itzQsZtDchZSfb2yRFGPm1iw6GkycUOOWW1MiljkYN
         DSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677468; x=1784282268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGp6Gz4cU4q54LW0ORFzAwYhub1+CHS+HnXdjrR+z3o=;
        b=A1Yn1P5wYFbP5T2x49ZiGQllX9tmVBOQXdpLOdTKiaUKjUZiRy3CzSsS7LrWkoDiX1
         5xDHx5F77sYjoWJbpuIwub2DcvnUu+YnIXJFZ4p2GQRqE0TXfpzq5TD3p91QvpJoWYu8
         iyI2x47hhJzp/4Kvm65BOBbBLMrsv6zJY4e2JJUcL4Bc7sAg9zTYGyo0zMMP9K8XTAmT
         JsdkCxOTqYZjNnOck4IQtblJKk1qs2S4FgJBr5SzW9ZH1FxibEZ4azFkUOcVhMzpRGcM
         YpVt9fTiU1Vlz/3qwOfOhOLp5t4eOgxNOQ1jJ3LCNycHDmw5c/4ylXCUxdAH/k7i6ui0
         pSsg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6iCebjCazZ25lTHnrOfhXWNP/iYUUYaum5uDKEMzSJ0RSLxF+hv0FMZ1Wz6f12nLPe/hDpGl1Em5QmTbN5mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEA0PfpNJ2z7fzG5boqaUio+orq+uAj/VRt8s0y3XN+vQPJmXE
	O53Adk1OiR21WTKYVvGADYfGvn5vrtYsJ5UPbTe4lEwDUvglvzMUnnu/ZY5zGV/EYYjN7z4W3iw
	wov5FePffcS5kny7bL0xuQZjP5OhdY1QmM9Jyq64Xw+0t3nvmnMKOWF31NQj19MfYV0pghKw=
X-Gm-Gg: AfdE7cmYcrxUC/kUvMuj6Viuux5qAL1Gp5z2LN2Vbku8wnn992bUjgLl6EuwP88iTbG
	ag+g3B3ZQm4ucTVHHx8rQW570tSAh3oqan3FsycqmjpZa4/GJdsbttT5zFfoX8LDTKn39QGapqe
	cykwVPA5Nm0dnoLBiPwzPmjThwQjLDeVHFshRVmb7pl25VCEpPD3p1t9imKLwzBnC7VZPprnoPT
	eqfbEMybUoObUeId48HgNgld3KCl0Rv94psD9jlaybn0+Mu9tbhoqJki9VLmLq84m4dgePXQVSp
	vFenGY4jMCffyvUuOQ3cqztQRHxea7+hcBOXociF8vnkrzk4BZ+V1Ce1QlBXN8NbG1yvob0RHi9
	s/0C0eSVe313cpYnyBaF/i2eBDukw0G9FDSW5HfOB8IdSl7UOOxBh45qA9toF19Ei5q8uLPfLWZ
	GpeX0gaOZMKCJ1TwF92lRxNxzIQ9/1CI0ZgSeeCO9vu48yj83eLaNODXMt5hV9Tf2vqP+YQ7I74
	UBCCZmQek/Jh3y3IVwD
X-Received: by 2002:a05:622a:5809:b0:51c:7b12:120c with SMTP id d75a77b69052e-51c8b4bc4a3mr138323531cf.74.1783677467969;
        Fri, 10 Jul 2026 02:57:47 -0700 (PDT)
X-Received: by 2002:a05:622a:5809:b0:51c:7b12:120c with SMTP id d75a77b69052e-51c8b4bc4a3mr138323431cf.74.1783677467625;
        Fri, 10 Jul 2026 02:57:47 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:46 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:35 +0200
Subject: [PATCH v3 09/11] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-9-46253587af64@oss.qualcomm.com>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
In-Reply-To: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: 89fvy28Xr1FfYlKosZLB9SXagMbLA2nx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfXybHX9LmXSHoi
 P7CHMR+ihxt5wA6avcmMsL63WPi7aMeB1qoyv18kEK6AqFvJk74xfiJ7B7hM6qeuZx8rUbnTaTR
 iM4iGvdsrViqg98fewaTQPpEnmiVlYg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfXyF698Mrc7RF3
 KFi1ezhSTtRvZR5CcfITcevMvRzpykZACwrcHT74WDZyOiutfeO1Cr70VnQzk5QrSzCPydmtTEc
 BjQS4KNSA5JS275aG3inDMNQpMMuUpgSk0V4s3uCrsZQJxT9MZzGv5U0mAQJRK/8KbjAGPBlaoO
 Wj3uaoffHtZeTg9dVgwMIPhsUux4ATqJxeLjt8L0RX2m9c8sqErtSra1rVSQEKaGFPas4ZJ071Y
 QXSwIkP27qCtof21hGUNB2PThY9FYvqOpo+cLsEEC6qqRFWZRsJvcvS/CbsGOtSVDQYJwBKkLup
 3oDS3iOQnfAwtXYJkoEu69NDF+/B9uHZVLZKpI1YbNQmcv7CAM1kND8yyY/8jYEPE7YVp8lktlQ
 cyiZIl2O/9fVZbMkdlPlSD96ICmZ9P5bbXPcn46fUzEa/xgi/JV3MdiWchgi0xlXmiAY0Ec1ZX+
 9lf4mZOtCBNPyB8lsyA==
X-Proofpoint-GUID: 89fvy28Xr1FfYlKosZLB9SXagMbLA2nx
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a50c21c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100097

Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
Key E interface signals but are physically soldered as an LGA package
rather than plugged into a real M.2 Key E connector socket. Such designs
are not actual M.2 Key E connectors, so describe them with a dedicated
vendor-specific compatible while keeping "pcie-m2-e-connector" as a
fallback for the shared signal semantics.

Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 module.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/connector/pcie-m2-e-connector.yaml         | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
index f7859aa9b63469cb43919c0b5719c18694c5364d..0282c6ee9272446064a99ec6314a5ceb1721e0c4 100644
--- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
@@ -17,7 +17,12 @@ description:
 
 properties:
   compatible:
-    const: pcie-m2-e-connector
+    oneOf:
+      - const: pcie-m2-e-connector
+      - items:
+          - enum:
+              - qcom,pcie-m2-1418-lga-connector
+          - const: pcie-m2-e-connector
 
   vpcie3v3-supply:
     description: A phandle to the regulator for 3.3v supply.

-- 
2.34.1

