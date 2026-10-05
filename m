Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D0A484247
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202923; cv=none; b=S49uhRx0znlMMf4yfttlDGuSP9vo/y2hJQAIinYJHuHKb9dZQ//Usirquztg/esmkId4e4zDSpdXm17kNDf4fOE5+4PH49m8th0xxYlbBqg/IRVMdRErOCvgoKtkeQGO08EOVxQrS+Rlsx+4JjlRLUNTx9c6nVTOT20yU64DlsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202923; c=relaxed/simple;
	bh=xbR26F+2IK0SwAaQUmAO2+Xe1VwKVtt+NKXks4bobiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXwC8dBVNyx5ozaFnn8aIPzw1MjV4+9dnGursHYX3fHz1eluyJsr8NdofPkgOiJoV0kjXGeMheRl91mNZRzD3h9yiueE5rbe0sviXNl1s2jgJAYZ5VdW/hJIkDQdOlpHqKZdVKKjog1ZbdP1qQM3kuX2aM98rkMWMcm/ffUAxoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ioHZLbTk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iDvie8WH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ioHZLbTk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iDvie8WH"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CFLCd1068084
	for <linux-bluetooth@vger.kernel.org>; Mon, 5 Oct 2026 12:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=; b=ioHZLbTkI8HGv28H
	tNE8ptOu9b5+s59oYIITySvzWwj5tY2S24RnKztunJg8SeNDEFBvRiQh0li6LWsB
	3VdoHkyRU4mIgHljog+f3M2tXUyn2M6QPvAl0abTpvkuSWyzm811fCPoTyyuQTxe
	rQuXaR0x/pZ7mMwU2aGe7JTLdE+RbQejyRN3qkiGlzVlauMBxzngl/Br0BUuiqmF
	zXfKXPNvNH7igZRGtBXHv++Zo5s0F7Ad5HEe2huz2tz7MiXM82m6XArMlcGRJAXN
	RtnVxV6RwFZC8W098RkvT0w47mLbK+J4mzZypAVZBjkHSTT+IcaPNS8r/9VABFUI
	ugJFpQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2u08nnry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 12:21:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93ca4a2b9c4so386268585a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 05:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791202918; x=1791807718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=iDvie8WHK1AtDSaV7haK48Gv8S47yGjzY/83q+OHaWyvAN8+uuG0KpGA6veR6eGLOo
         zWcOZK1fDaIgwhqM2EiQeVo1ZApPWFC+cKk5iHO8L3p6hFBgUuwg/LL3nlQZg16A81vd
         pZVwcVpqMXb2Ukn8zupGWyNzC0OPW5fVnLY24Hu03LMqtM+B4YZPq+7RFfXTo99ilPKA
         5tTX4KFLCoGJY22o/woI32I4gVryp/itKQBOumSrEb8B5w3MnMDh9XfvQcz1jbGQPBVm
         CRWQPoVU9ZNZ7B5Cmg1PylhXAXACdxlmPJSS9Reg0Uc4ycO2uZOkVdP8Zhi9nglNLWEr
         xUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202918; x=1791807718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=dhmtYUcS1Rft9jSdy0bxkyQoPF1LVhsDh+/pLect0LckMBueQJtDYkvWSr8c6289Ve
         4UQDgGSaR0gVUxTPRuCD0R8C7Y/XTBIgb1jraAZ1AB7fX1Ue5TokHbIsmKBHqRKSQWNd
         wrhaMym7Kob7B2UOIbxzJI1cObYYnY65ncO0rFL5xjPad0pW25os8UrcbBguBWLMRgt4
         ziWPi9nNOBG+aXWpkSiJTin3wt2SNb+MuptMX0+FJdKMfCN5JikY4Az5Cwvhy5uEJ8RM
         WbMP0pxX5jXyFvypx35qxHk9OsBy9Lkwdh0A/WdcML8cjXTmGSZOP5peV/HC3stnPsCP
         sxHw==
X-Forwarded-Encrypted: i=1; AKwUvBy+RbLPBVyQvNauCpNDk9luAdZSzDtTMb5OT/uWhvzXdi9SGXVNewzVNf4f/cBYoa7H/BhGxwz+e5aDZatxwIA=@vger.kernel.org
X-Gm-Message-State: AFuF++luHsqWN63dCeoQ2ImG9JOtnILvyLdVRgVcuAayDAElf+HYLXYl
	QsR5QiUKcqBTeYml8DKqFcrYlRby6fwz92koI5WazenT68DBSgghy2EP3rZ0eF0OShtMmuEHN3O
	ZLfb7hmWA2ZCX5Y6LW7Lap1nc63CHLJofcbcHXkqL1sMC5WxxyNs2LCR3O1uFC/+rTMLJF/Y=
X-Gm-Gg: AYBFou2lk/PjOs/mfjgIPpdacJA71IB4l83X1HRHLLnIvYA2cfEdiFU/E9nmS2aNjCI
	prcZD7EMU/UEkB6goGIXSrFZ27NI9Sr8f8MBMReFo5MBEjPd0DFRoCCL7j8Ao6FDHkqR/p/HEHn
	S7UPngUJvPoy+28uOuRx6SkAzpZxKmoqiWT7YcHU4V0LZgpMyeEG7i1O/fRvkkcVmCjhFNcvpjP
	39GX7Zs32utv/SDfcbO08q35VNC2kqBEmZz6zuHNbRuJj7wB/Q7EyCUHVolsrJUiHn1pE+X6WSo
	3F0njRqLupfHNhzr5mOU1ivksHo91+qadY+DfzMvE8UIJFYBSbV4+tBBShzutTsCtfaVMGd/XKv
	DHK4tXD+K+5fj3hvauNMSRUqTlSGF26dbVKC8qsILW3hTCuT+xZ3iSu2wicyOOGwvEGVjDYtAJ0
	YfHzJEh+Lc01Qs3lzAsmqpk3Z3TqqaVVqoN143cnVvT1+Ej9WYT188dLGvZVC2CzDZCuOoCg==
X-Received: by 2002:a05:620a:414a:b0:93c:bdb4:2be7 with SMTP id af79cd13be357-93e510cc94amr1222903085a.60.1791202917846;
        Mon, 05 Oct 2026 05:21:57 -0700 (PDT)
X-Received: by 2002:a05:620a:414a:b0:93c:bdb4:2be7 with SMTP id af79cd13be357-93e510cc94amr1222897285a.60.1791202917216;
        Mon, 05 Oct 2026 05:21:57 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027698f13sm324157425e9.1.2026.10.05.05.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:21:56 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 14:21:37 +0200
Subject: [PATCH v7 7/8] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-monza-wireless-v7-7-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
In-Reply-To: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: I1Lbm__MdA88ReVf-7AHRH0-amTghV_f
X-Proofpoint-GUID: I1Lbm__MdA88ReVf-7AHRH0-amTghV_f
X-Authority-Analysis: v=2.4 cv=JqlkP84C c=1 sm=1 tr=0 ts=6ac39667 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=zRh97aRZNhiOMYVz81Er1w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX+JnCk+T2G9GD
 VbT922NM0CvuJmnCa8i6l590/nX1wCFQP+ZGuGRq2vQ6mVGg6TAa6LcGMqrEW0gxisprpSlT8qI
 x94Tjo5RqGh1zYd+onq0SOKP6FzD2Ns=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX80E6UbpbHHO+
 2SpWb6BXkJi6XWy1GVUP5r3byrFieOfFRoK7PeMETIXCPb+wKre569ymDWHdqfqoxaVZxGeen84
 EOcnwML4+bwZZVSbT0NmDxkkMOmGgV22MQdTB2Kkq5B1lK9TSdvlNzhMbt35xMetVUL8IbcmVlk
 qA7qPaYYmlpNGit5mZ4aVl/T+Hj80wYAtkEP3DprZ5yw9OgECRYNRMvr/jciOV4w7bDHKbfzqZ6
 dfbD+oqaTljRS2jwt4MOqx8ETRWZ1n0ndQ/9x7itXVlBJQFFtAzFjwQwEK9eEdGCzQTI3dssg6g
 I9JMpbHev8ffswxZo524KQITe5jW+PA+PdQopq7OlT/YWGCm6iI37V5vWeJah6PI2N1dxELvpEv
 XKtBQEQyqefzray26accbP3G2kcob7l7pbeEM95hNnp/nTGoa7MtGrPRf0fu8tZwEY5HXGAJbVw
 zGKR7uVU48IaLVF73EA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050048

Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
Key E interface signals but are physically soldered as an LGA package
rather than plugged into a real M.2 Key E connector socket. Such designs
are not actual M.2 Key E connectors, so describe them with a dedicated
vendor-specific compatible while keeping "pcie-m2-e-connector" as a
fallback for the shared signal semantics.

Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 found on
Arduino Ventuno Q (Monaco Monza).

Add "qcom,pcie-m2-1620-lga-connector" for the M.2 LGA 1620 found on
The Lenovo Thinkpad T14s.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/connector/pcie-m2-e-connector.yaml        | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
index f7859aa9b63469cb43919c0b5719c18694c5364d..ce6173a0ec41cfe8ab4a5780940999c18674ab7e 100644
--- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
@@ -17,7 +17,13 @@ description:
 
 properties:
   compatible:
-    const: pcie-m2-e-connector
+    oneOf:
+      - const: pcie-m2-e-connector
+      - items:
+          - enum:
+              - qcom,pcie-m2-1418-lga-connector
+              - qcom,pcie-m2-1620-lga-connector
+          - const: pcie-m2-e-connector
 
   vpcie3v3-supply:
     description: A phandle to the regulator for 3.3v supply.

-- 
2.34.1

