Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E694C348894
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987032; cv=none; b=J/EHM9spqV65YM9mYoD41or5Q71XZx3fcildPHPim97equG8p9w1dGUK1WIrgygcosduicoquIAjL9VGFcwidB0KcJaQU6R3H2XZFeAUMTpAFl24YuUg3gq23YuxKbaxrvMYEFR9z3gjySFnQ2YprCeXB1BjooQ31kZz4tQT2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987032; c=relaxed/simple;
	bh=gRnwoWYVjN7GMrjsuBdpDhiMQwmfcdo/4r/Rw1j08vQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b9alHrYuFcTbEv9g/A/EqgJt4+drn+7RqLOc4+fh5dN/mI1yq4iK8qSFFZL153bT7oNjmXCCx5++ooqZBxcxaK7kdsQ8iKovD8PNoqtZSrDy8CUfm3iEKxJkiNo9WdM2iLTn2y30HaqIPMgNunRp8w5w9HvAOcEO8rUl3QvT4YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UjcofAbv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F5REcQz8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UjcofAbv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F5REcQz8"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCKnuk2042713
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y4KqA588JLPQI0i1Leq0ab3vXKKNpG6AzEKsdY8kU30=; b=UjcofAbvH5ht9RLh
	cYDq/xR01gLxK5bht4pOfOe/Ivsszgr2Fdc+4rcX4BKCEK8dYHehIfDscs9uNXo1
	c99OZw+2Hhp7E+iGe+UUdUIzg20l72HxXdn20rJxGjEoM9C5iDBpi/nU5Gj1peGu
	zJV872/Ehdt2N8ZdNXR1QHbg0OrsQ9zTpRvBfbGJd5ioRNCDQycKNXOoWuHyeG25
	sMGWfTG7WP81EoILnuep+ocmdsTk7487psinZdOW7vf21t4uujkft+xeThwvgNUX
	bo7HqQhm2fZiWh4O9HW+uRwY198oLau6bSWKMY940YVr7bEIYAQWOL3tMckzmBfE
	pj/7Jw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3fj1u34s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:57:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4edad69b4e8so16515341cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 07:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765987020; x=1766591820; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4KqA588JLPQI0i1Leq0ab3vXKKNpG6AzEKsdY8kU30=;
        b=F5REcQz8IfQ0pWce3a6i/wPOtbb4O/rz7hxWm5v0rBKY6+1OHXj2TvYlqKMFWE+BO5
         Qb4+rfs4/2RrHGe+ukFhQ4NULqIJCZQv9KNp0cLN5rQ+mjt/EliLpqJnq7S7psYlHnUK
         psWILYCaqwK474EcyA3P5CcFX/Di7fRTjCEQkOjgzrOJ/D3OQNiZylicOagiSImOQkjh
         /vwkRzT7rRZ2XUBr9WdSXxosV+0mCZtn60P4Dk22rMyopEnh7YtYS599MdhXYJWtnUH0
         HLOAuCCCh9xEnv3ojv72tm0rJ35Ekn7x8mp+9359Cv/Nvj2IM42AkWqzFNYd1DZEk+hO
         rXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765987020; x=1766591820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y4KqA588JLPQI0i1Leq0ab3vXKKNpG6AzEKsdY8kU30=;
        b=JHfrYKfxR9O7uu7GSTq4kUtQSf3FQrTbPKs0qjSQj/4ugsIAFGXpJS29oQ17ZU8P0P
         wuo6HohjASlRtFZBxBLbF6g9NQ9N7eE6NUAeoMs5D8LkglyUfEk3EGkrXeSMPT7RJw37
         TrJ5PTlTk20A0bKiN2D0hsQhOsK4SOMWqjKz9zNF/ZHr+NKAQn6kZO0WmZCdOlmnLEYd
         zMczkW72pRmIKeMEqT+gbhQpR24LILenqohhssePW7uQWxG4JLg+PQva3JGA+2ig8vk0
         xK47WLkPgNSk8kdgqDDN/QAkBqkxpqbctJDiipSTJSk47ZoLrMLJMXx5ReZekcGHedKv
         q2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6QLM/t1v/P13ymju4Pz6x1QJrfYfzVKRT/ys18vpzQ2eVbn1ntXRpjcRiTPrOOH+uu/vWWJVqywAQFvlsUuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBEPWCjzNebfjWLCQsBjnF94XEuAcuXqqKnRnIVEKzsCBoo7d0
	uQ+LKlP9msnIlmKpCGH7qvu2xaDnXNrqZUK7EHSuOSDxOxniyDHwvFtvlZNaOdz+XdHYzs3kP50
	mL3n3iHJzELfcwihGBHPoDBt8PJXJ+sx29xRlZig37vgdUHiHtjfTpi8gMrXuXN8uwlAlokY=
X-Gm-Gg: AY/fxX6Xh7fb8FKnXy+9NrSrchhX4/xr5FvmA5U7EiYjzVH/ZzeoP2hhi8QTMETPkjJ
	kqVmFxkO3QIr+82OVwJW6fb+g3nNDMtHkURkieBszDaznps6BNL6U55eWueHuNcdkq/Db656O2A
	7sgv3Zbfx0wn0xVWg54cYhxWUNhcmqT9nH650AtE1lMU9+azRfVpL2NFPyUziHUFfQdiB79VYwA
	DHqgOvPP85zxT+1P2hvv98L7kBfJyCNhFN2jc+PHRD9IdMbeqhEbVpad9azxeDGAdKlzG+6niCS
	gfiZQ1eD3g2QOXV3nnE/WG/NLFK7/brtyEsYCQEaVpMiyDRPG+A/dBQK7e4NvlY+Xq6GoABDUQZ
	O0WS/476aygTG3nxWG3/dFQbEKiQmsgQV
X-Received: by 2002:a05:622a:50f:b0:4ee:12e6:dc73 with SMTP id d75a77b69052e-4f1bfc359c5mr334303371cf.20.1765987019707;
        Wed, 17 Dec 2025 07:56:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSeUGQg3MB7LH9Sfie6xzdKE2ev/yzJYMwkoILOdDw7e/522lcpaoGhlmo5oVnRw1Xh0YFVw==
X-Received: by 2002:a05:622a:50f:b0:4ee:12e6:dc73 with SMTP id d75a77b69052e-4f1bfc359c5mr334302971cf.20.1765987019289;
        Wed, 17 Dec 2025 07:56:59 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adeeef6sm5439800f8f.32.2025.12.17.07.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 07:56:58 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 16:56:29 +0100
Subject: [PATCH v3 11/11] dt-bindings: bluetooth: qcom,wcn7850-bt:
 Deprecate old supplies
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-dt-bindings-qcom-bluetooth-v3-11-ced8c85f5e21@oss.qualcomm.com>
References: <20251217-dt-bindings-qcom-bluetooth-v3-0-ced8c85f5e21@oss.qualcomm.com>
In-Reply-To: <20251217-dt-bindings-qcom-bluetooth-v3-0-ced8c85f5e21@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1900;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=gRnwoWYVjN7GMrjsuBdpDhiMQwmfcdo/4r/Rw1j08vQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpQtK2taJdcfc71fNpPw4LJbo7qeYKf7M33R32W
 mEtK42HxAyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaULStgAKCRDBN2bmhouD
 17MiEACS7xd3LVPvQXjWLBMFSa2PmWiLwHVDtKBW8gEpmwHoSPzYHXgOR/euSJamH8L8boA+IE9
 NeNxEkh+BHZpmUmr1RKMnw9o+y4hSwlDkmK+irX804O+DD1fH96l+morgQJC79vCrUV63p3doS0
 3n16dXUgxUM+TdL0LGtGl3psTvtxOw7IEpbEE86qnkev75YQSaium8SCcHj6teZT4ErdMCgBdAB
 6zzZEW/Q7iLizEdaq4OZmWoPT6WMwxyRE3BYcLANAyYRIidrxFbZnwn8e6QhyiDj6jSGkP0crtj
 KhCIqf2L1U4TGtIEpnyNW8auIKrihZVy08m2aNUmT7mxWqSlTDsbiqJR+EyxmMAHKb6fzOymixR
 rczG4JI3uZq6DxerQbJspEivHWpHLPmMNeUcX9TzdM650mYGJWGDcHwBedq9ylU/KbyJgiLETHR
 TpYPPYhCY0+9zZwUI73lCr4EKsiov7Q4qxA36iEBTTRj24hZBfNkWMDEkJad5wb2ha3c+yUUVYo
 jte7+mXAx1JTOTEUtSGaWRLAGn8fAdOoXfuHIT013tMtMsYh/0OiAj8YYx5N2UC4i9GL5H5OWdW
 0/UzJTRu0oFSUoe72e0YsJZ+rERfj9LTTSKUpf/mdrFkK4bcG9+Jbs/3y5bHyPlXK8yzGn8tovv
 2NN8rWjvqXRChig==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyNiBTYWx0ZWRfX9CIlSla4PA/u
 x4wYKyc6MI66rMG/CZwte/tCvQDFkj4U4ptNikXR+pw8YlfOkJ1AclmdLQr9e8u11nV/JSNcEwa
 6BYVH3DGzhErjOsOlAbK0Wd8MJQ6BfiYVY3H0ckFhE0tzZ4dE/N+D9iFczMDe0FhxSaQAMAG6O+
 ItRgJmR2Suxn7QgYFsv8nFv2xLWyl/KUOK8U0I4vUPrbRjnoTffdPTwebIyslW+5BiMko5ck76S
 2S52Pk4CyBWLqSVxnWrTp/evWrsnnsaK6al8dgMrMHRerjrlPdOI8frAWfZwvXJ8rD6QUaQfuUm
 a8+bmOXO3grVvWpiXhw/DZidBNLqxPXeQbwZSFQKzAsM04c8bB5EI9p99Lx+/5hmKsyJbSjw9Se
 f+sCDgka4AsHwA+rBPTqNjMCC6Jgsg==
X-Proofpoint-ORIG-GUID: itxX6_8rlzJGkvJvcmZ2nTFhLUoAqSM-
X-Proofpoint-GUID: itxX6_8rlzJGkvJvcmZ2nTFhLUoAqSM-
X-Authority-Analysis: v=2.4 cv=edgwvrEH c=1 sm=1 tr=0 ts=6942d2cc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=hmARNUlj3OVxZ3RlbIsQyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Yne-JONsqnic5O4-CUAA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170126

Commit bd3f305886ad ("dt-bindings: bluetooth: qualcomm: describe the
inputs from PMU for wcn7850") changed the binding to new description
with a Power Management Unit (PMU), thus certain power-controller
properties are considered deprecated and are part of that PMUs binding.

Deprecate them to mark clearly that new PMU-based approach is preferred.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
index bd628e48b4e1..8108ef83e99b 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
@@ -18,20 +18,24 @@ properties:
 
   enable-gpios:
     maxItems: 1
+    deprecated: true
 
   swctrl-gpios:
     maxItems: 1
     description: gpio specifier is used to find status
                  of clock supply to SoC
+    deprecated: true
 
   vddaon-supply:
     description: VDD_AON supply regulator handle
 
   vdddig-supply:
     description: VDD_DIG supply regulator handle
+    deprecated: true
 
   vddio-supply:
     description: VDD_IO supply regulator handle
+    deprecated: true
 
   vddrfa0p8-supply:
     description: VDD_RFA_0P8 supply regulator handle
@@ -44,6 +48,7 @@ properties:
 
   vddrfa1p9-supply:
     description: VDD_RFA_1P9 supply regulator handle
+    deprecated: true
 
   vddrfacmn-supply:
     description: VDD_RFA_CMN supply regulator handle

-- 
2.51.0

