Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1DD33A03D
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987008; cv=none; b=QwVqyHGKzDpqz0pBPMhhqAp50jid1plJ6wZOmZs6tRFOLIL4a7S2GeVQt1nn+D6c86J/wGS3gyqhWqL3qldyaz66U0ofxEk/2nDWvhFPS9BfpByX5RJoPCpuTvYxBSdXemndB381vEufkEBsw8FZTeT1L28+aA+sNFnj8q9ApfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987008; c=relaxed/simple;
	bh=q6nac9YtyMxCOqlIvmONGBif4QWkAHdC859/Ne6Vr4s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eh6Pxuclk4hxb6ThYUSRYMJhU64/srCpyuSLR67k/B/DU7DjUfPFm8IxmvDMitIJmqwrL+rTIeeuTrRr3qy1h9I4XylyF0+eSEFHI4Og+nlx5z8ERBpFFcSg14pzwL049KkoQDZX7Epi1nNFbhzpNMeoRxA84dzzRyIaTpOBDG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VcoembTo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d8FCp9JK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VcoembTo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d8FCp9JK"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCKqBA3329774
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=T2jbUnukeobzPaEEslxHJs
	qLPBDAuf7jTERKiw6tUoM=; b=VcoembTo/gVS6OB6KaHLaELdBfGSGIBe/1N0PW
	CgrLiLhgUr13u+UvkfeS35ftjKtX8aKg3wORLHx22eeBiSsK838XU3bO/isQ8sTk
	cwYBakJ4AyRo60PPIKSFU4OgSMe1yuNaGf/is8LpJMoB3JifndrkmYocx5fh6ds9
	U+9qLXEKbA89PNdEZame6+7vAFWcSY0epn1hFpE94dfL85bnj3aQpnHGXsiL+Kzi
	lI0IkTwDmKb/sLdzI6OP/1RB1A354IjEhw4PEN7TrLb+awCXK7lSTWEfA8GMvrCq
	LgARGHmKO5anek3eLc5wWSWhe6PeQjDva+y57D3QKSNdDSbQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3nkkj45d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 15:56:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee1b7293e7so199153101cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 07:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765987001; x=1766591801; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2jbUnukeobzPaEEslxHJsqLPBDAuf7jTERKiw6tUoM=;
        b=d8FCp9JKRX6IKQuc6cv5NTljrzJV8R3TR6oOynV0WANqnTOPCuKdoA5vgEPNFsGIqf
         T1Gwzs4Ic1lIhzDQ0KrRekOKvMgKtuFJW+Oy5sgONFcZ9xC+7GSIPAUL4susrKoUzi4T
         wa5VxX/k0F6Oh7wStugv5o7u2VDKmqDrmm+Ivin/n2y5nZsR+GxTh8pb8kW5VgHL3+1+
         BbbR+Pqy/nN9bAWoFyIgnE/RNZEmLNYQvSUfeWf8Ug/pTeBM/C4+PbVMlZkvWEaojk/h
         ZbhLYhqRys7l3lmmNBt7INMhXVrDTWkkV0EvPk2HoCpwf1fTnK3zIy7JSfyktxPDUETW
         3ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765987001; x=1766591801;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2jbUnukeobzPaEEslxHJsqLPBDAuf7jTERKiw6tUoM=;
        b=biNKG6+awdFbCQpyrzTzmqDclovQ4oZdn6H3a6vyVVDx2i+lx3BDkuUfy1xH7Craqj
         c8hl1kDMPY7XdJrNdbZMYDUWN+D3Oa0qsfSzgaCDznrtxn+8wlcBJ3lNelVPz81I11Y1
         5PFbaOHk10U+7z6Ig1gwaU+1MPnCDIpNrBxS5LjVKfZ0t7mf/4NafK3bcW9vZxgVG3oU
         Bei6B2dqm0e/0U8RQoxu1fKhdY5XpzMIF47BNHLfreC6MIJOEUnc3pYpaJezhEbTJ8h+
         N96/Pf2hnXIkR+9403ApiGJXpbP7AgeczanOuQbtzQNESVT/HxIur8so0eVJcpPi8IKp
         vv2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUxHj6MbFQbNVPG+Y4nv3kfr9xTyTtAoXx1vkduAeIJhgSbxluK+MKLwKLvHpMGOAAuSh8npqef74KpJlP20s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0DSkgp4jcRvGLpYIcJAneGLOtXhX05G8x4PVnYButdetBPWAb
	JO/Ks0BOfP3dwETtDOW9n4NpfUcw4yEuCZYF+Boui/+jAE3m8k/HkZNslUWardkoCVESI7+oK8C
	ADBsro4nr097x47YpZCmTT3M5NNv4is8fSrShw9nAFsCYVqU9OgynHx1NwXEyFCLolBQKLFQ=
X-Gm-Gg: AY/fxX5GeruG2JYH2ksPYOEoHXSsC0m2jSeJwT5pbQEdeA2fxTWRQ0amx+m/F3meupt
	mjPn28Im8y4/T+c+feDRhGElHaDo/+KuHl9J52bwD0Qb4C6qRrhn37ya+9sbu0rVNgS3CbiFaWM
	e8dwoigRrY4n8RYdubUa5NDdNG8w0NgmEWjMdAwR98Y38F6MXyj3EOej1gK44B0yWw8pZMK7nXO
	iBBBbW4tte84oGV3jICX8KO6yA7MEpexI1YyrjujDQBASj0jDncrL23IXpElUEP5m5VkH+5gd8L
	fwDK7lMErIhoc6TE9Gpg00KfLJdsUEAb2qu2N1JUELgjYiNfvMd6XTzo3f3VEi5bW+cjr+Uk2HY
	00l9RjryVDy93TCgcpTaRYc5i+IakKBkm
X-Received: by 2002:a05:622a:1904:b0:4ee:3c15:f3e8 with SMTP id d75a77b69052e-4f1d062a6e6mr251346271cf.76.1765987001314;
        Wed, 17 Dec 2025 07:56:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBefbzwVCmOkhOsQlwOvRkA1LImSyQPfJK1NxIjBi4reEj+cxhIcXkxG8enJP8am7PlhV0KA==
X-Received: by 2002:a05:622a:1904:b0:4ee:3c15:f3e8 with SMTP id d75a77b69052e-4f1d062a6e6mr251345941cf.76.1765987000830;
        Wed, 17 Dec 2025 07:56:40 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adeeef6sm5439800f8f.32.2025.12.17.07.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 07:56:40 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 00/11] Bluetooth: dt-bindings: qualcomm: Split binding
Date: Wed, 17 Dec 2025 16:56:18 +0100
Message-Id: <20251217-dt-bindings-qcom-bluetooth-v3-0-ced8c85f5e21@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKLSQmkC/43NsQ7CIBSF4VdpmMUALbZ18j2MA4Xb9iYVFJBom
 r67tJMuxvE/w3dmEsAjBHIsZuIhYUBnc5S7guhR2QEomtxEMCE5Ew01kXZoDdoh0Lt2V9pND4j
 OxZG2qq+4ZPKguSYZuHno8bnh50vuEUN0/rV9Jb6uf7GJU0alqFRbN1Bqo04TWuXd3vmBrG4Sn
 1b70xLZMqapWSsZB8W/rGVZ3iXdA2sRAQAA
X-Change-ID: 20251028-dt-bindings-qcom-bluetooth-9af415056c1c
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2890;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=q6nac9YtyMxCOqlIvmONGBif4QWkAHdC859/Ne6Vr4s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpQtKqlRTsHneK1ZdJjY9As/FPd0AwOkxHscsdS
 y5r6MeIuLWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaULSqgAKCRDBN2bmhouD
 18DED/0ZOp+HID1Yi18CrFASd325YOIjSexKwuNLnR8R+eFE9Uz8ax3BF2WZ79EaFLjX1WIS04N
 HWVG6jmJqJgrL7OEWO1K/Rl7TZ19mikTQLAZ9x1AS2C1MknVVmO8BQ/nF0tMEw2mixYUiMBrdwf
 wrZ9Ul4iL+wx0FgaXHWT0sCGRP4/ZCk7+aYK4GDbUrsgM/B7AQUTKOmGyNwgQ8ZSJNAaodcVmh/
 oBBn8Z3WlXFBTVBPEOZQRwm5VA3OgJOTtl+zNHVjlaKzpW//DAWaAVW1HvLQOW9LufIy4KeAPx2
 8vIc/xq6ogXVD2HLOyCGGUxd/CR8Gc1S2M4JXipgTsJ3nT8P1uwsMejlDYPRoF1Ehc8H179fTzO
 vnlQH1R+mMLYbdu7HATjcq5nBzg1Z+oIB3ck9mSmyIdetqkYnIufwP2DPz0v4ar9+84uRQkTlDw
 OJS12pIIlQlDq/cT/qDDtriijtz4evC7UDYGwTUtAky6c8P4O42MHbXE+sf6OVB3oTRmMdLh1Oq
 XxLKzmrJYCJBiLnfWyi53GGlYzvgTg3BWSAIK93KklklI5frg6IywcMihYHMh/sAIm6+lI8BuIQ
 NeOl5C7VWHj+XHYdoMCK7iOwyz8XKiPE6uRBwx+HJUij/WJo6e8hY9ktDvkqUlcdOYt6UaAX3EM
 eKBvGs2+oxZGiHg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: QdQ5MR-GU_98lBvYyTzClwfdTb3Y17ly
X-Proofpoint-ORIG-GUID: QdQ5MR-GU_98lBvYyTzClwfdTb3Y17ly
X-Authority-Analysis: v=2.4 cv=f/RFxeyM c=1 sm=1 tr=0 ts=6942d2ba cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=hmARNUlj3OVxZ3RlbIsQyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bC-a23v3AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=8K6MWZSYgPI5CALZTAoA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyNiBTYWx0ZWRfX9plkRYFC9gcz
 Lfp3/u/IQbXYuCykF1qCXNPX/hZ3rCkVKTd+ri9OQN3IhlhFMqoC79rC5qdmGTG5i3G3eIzdzI5
 TqqNA1DLEP4wHmUIVe9bjkcwSDnE6c72q9KWjJxHcbevlKGB+21pe2mQj/hEW8aMZFyAkd360/u
 LQitPs4PB6NsJR+qB/Bn/shzCeeBWa4mXOjgdliLZUImlGcHFu37Ff5c6OVYwW1Z8SPKnogJRq5
 NUMpoG4/KaY8hOlLxDdvC330zB8t+G2UYoN5RgMCsJaASBLSHeaELd+0p43bRNqepdrwXtLVpR5
 HULSEOYmH60qF2z5Y9wgcH0BiIrysQzsGNyX64ZVdm3HE9dzjKB0RDBwvHZKkgG5nKIv7gbc3s7
 pKok0ejsOgrizPgVmg3k73VPmkBOMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170126

Changes in v3:
- Just rebase and add review tags.
- Link to v2: https://patch.msgid.link/20251029-dt-bindings-qcom-bluetooth-v2-0-dd8709501ea1@linaro.org

Changes in v2:
- Drop in few commits the properties (supplies) from
  qualcomm-bluetooth.yaml which are not used by devices left there,
  instead of removing them in final patch (qcom,wcn7850-bt).
- Fix dt_binding_check error - missing gpio.h header in the example.
- Drop maintainers update - split into separate patch.
- Add also Bartosz as maintainer of two bindings because he was working
  with these in the past.
- Link to v1: https://patch.msgid.link/20251028-dt-bindings-qcom-bluetooth-v1-0-524a978e3cda@linaro.org

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split bindings to separate bindings,
so device schema will be easier to read/maintain and list only
relevant properties.

What's more it messes up old (pre-PMU) and new (post-PMU) description in
one place adding to the total mess.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (11):
      dt-bindings: bluetooth: qcom,qca2066-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,qca9377-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,qca6390-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn3950-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn3990-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn6750-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn6750-bt: Deprecate old supplies
      dt-bindings: bluetooth: qcom,wcn6855-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn6855-bt: Deprecate old supplies
      dt-bindings: bluetooth: qcom,wcn7850-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn7850-bt: Deprecate old supplies

 .../net/bluetooth/qcom,bluetooth-common.yaml       |  25 ++
 .../bindings/net/bluetooth/qcom,qca2066-bt.yaml    |  49 ++++
 .../bindings/net/bluetooth/qcom,qca6390-bt.yaml    |  64 +++++
 .../bindings/net/bluetooth/qcom,qca9377-bt.yaml    |  58 +++++
 .../bindings/net/bluetooth/qcom,wcn3950-bt.yaml    |  67 ++++++
 .../bindings/net/bluetooth/qcom,wcn3990-bt.yaml    |  66 ++++++
 .../bindings/net/bluetooth/qcom,wcn6750-bt.yaml    |  91 ++++++++
 .../bindings/net/bluetooth/qcom,wcn6855-bt.yaml    |  99 ++++++++
 .../bindings/net/bluetooth/qcom,wcn7850-bt.yaml    |  94 ++++++++
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml | 259 ---------------------
 MAINTAINERS                                        |   1 +
 11 files changed, 614 insertions(+), 259 deletions(-)
---
base-commit: 12b95d29eb979e5c4f4f31bb05817bc935c52050
change-id: 20251028-dt-bindings-qcom-bluetooth-9af415056c1c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

