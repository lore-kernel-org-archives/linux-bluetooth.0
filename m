Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442187;
	b=Zvvi4Rk5pkjGPcRs66SsJVbEcWiUyvdWHMEjt2chXT41ug47fmPBGsqxxfXnBKKiV4w4
	 zkhd2cgcp4ysJXqQgeZQyvSYbtsCG4v054+6gOt+5lWUiJxoRuapjzyspn1tspHscn4Vn
	 dUlohqmnNXmQ5BnzkbWIWzD+si9fGUoV/KYeoJtyXDzgjBp+GRD4AJE+m1WE3QUjwBP5D
	 PDgDWYJN/8ji5mzW7+0oLGGgWqZUer/bC/ZqR8uR2v9rncXpon2IwMvXFwwQ5R/EoiNqx
	 RQ08MSelxkxklh0wrGq4uLCG8jxz3A1HopMLhijFc+Pqgd8jvqW56dUY8/G3yTP2pVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442187;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
	b=hvb+iLxcexDzLE3AySAq0bmqpGDtZV9enwKvFciOKZde7nHsvqoFEzt1Cc31CE7KvWZH
	 vxKKV7Tnl6ebBFBuf0WV3O7KkmKDl8IBz5SAw3ky6fpe1elygagndJYPOMNRJmheEle0F
	 vBfzCPF5czoVysH3Wsa6edXNRLcep8WJDqrCjR3L+Vs+5tDY4Cd7hPUgwIPDCwOoZ/s7f
	 X7V8RKuJOh5VCjMYtwxPH9o4xjaa+qjPs8AgHOxKAxGAXi1q2NSCzRXt0+zSi1RFGoMSo
	 73GqFRnhA7v9nTTZ2OiqEWkuCAJR218J0Ezd3ByKYE5K2+3/ck6DMaY0NTlE3LdvaVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=abTfYYKd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DmpkH3NC;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7470560A380C
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 13:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7470560A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=abTfYYKd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DmpkH3NC
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDKxG42442747
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 13:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=; b=abTfYYKdVVxr89hG
	gG7xas1cvb2O9ZkTi3giz7uXwF+Wl/+Sa0ez4lSmOqUee6+Ouh+3ZhMPOYSoFL5H
	NnZTTBtSE15Gxh6LGjXJDDTw7TF5FNfsXC/Uy3ufbPn/PZ6bqQiXyoFqCeJDo44M
	4GJVH05GJvJS0KACNC4YSisoic9I2dpZKVEsxEiMztK3gNtCHXhELui7pQzOuLNI
	A4wnVzBtjZQnOMF4F18mDhRPKtbEMqS6rvmellhk6GMgL4qZmNz5HQphOUUd+IbY
	+S6cp1fIcIG9Gm8UembnMBIog2Kz+J4gLllY7nVXw6xBEtRxGLm3sAlfkS6OxGVN
	RMDvww==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k1nna-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 13:56:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934963b2bc0so629790785a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 05:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795442186; x=1796046986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=DmpkH3NCBuuRUnlyNwToYClpWU8Fij3c4cxS9TEoMctX6+TJPycE368lwVpDZS++IL
         lTuPhzwR71zgAE+NMzHh9utJh265CjYOqTjCOVgahIuoQkltX7BZBZzCrGJK3RePKr1i
         f9/05QAV6CKVAcQjygXZr3rBqd5k9V4cFSHOys6G33G/nMiHrwfM6SZSQb0oPiH6PPxB
         El7PslY+/s95FZlEYR+cW/asEj8VqS38D69+UJbLluh6uiyQJwFJJmwmm27HZ4jZ7pGl
         1h3ykO3MQGBmaPszg2wavS0j3u6Dj7Nz6otnSW3GYfo+ntw1Or0Z8JeU8Huv1oEgET98
         vTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442186; x=1796046986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=yO/L2gyV/jxpYT7f8d5yfHqtGBu4WF2ZgbA0u3bkHHWVZhozffJrYjBPvgxlUD6Zdo
         rS8FsFzLfZ2jbtSdAX1zcRJDESaRM9Y14csHKFdnVq5bjzwE/unVaVhB/A/ni/AteqJJ
         en1AHkx358sPRvuqREk3Rs/x7ytVrBMo9slUAf28WPBOkXgNKmv/qQ9yS/xULf1zctyI
         O2sLAlIez7r++Z5qXNmT3hqscPguEBfk8Cu5PQH2VF78F7Q8F7gsTD4W+G31+llab2YL
         YaZXu+YXkOZKdavSghATvXO79jMaZLFF5TzvL4Xr3sw3mCKSBqDy/Dmfpb38IjVG2mLv
         XMgg==
X-Forwarded-Encrypted: i=1; AL+hErH6JaxtRNt9i5R++jsn35vTCZ0zPD/hY6D4fRMRKnKGNYtZmBXS0iuIsMS991Le3HUllHh+PTop3CPPH/Sm+Dc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PjXvlEZVTBDD8BnlsQF6zxcUmcbMjgkBmzzvzcISJGCZFzCqg
	OYjubmkpNgmMkMb+bkDhMV2Tf0IEu34r+PDHGCv6nGdXe1iw8FYFElblhgazzruG8Rp/GeDPPgJ
	ciPsb6IW5MUA99MCm1mSrWbWqx1mSost3ZurwArwQpZyNTd7ljZpK8apw+zzeR6rwY6AljNg=
X-Gm-Gg: AZFdTZdIoaj6LvSqqWhTV8+q8gvjfA1rsu3GsvHhI8q614cq6UsXE5si/XfrRWuLBUT
	bqzKPBhBN9l3a0VsxpunWjzx7x7zm1W/oB9mkON1ao2Ig7YIe1wLZvuKtQTo8huwrJNdYV+RC/T
	LJLUQjKgF/XPdU2kGGBHL8rWem1W0KapQ9L8uASaAmeLy+3JCna0gtghC/NRi9DtQEqQfyTbt7P
	l5JvZYsEZcBMa1z6yObZT7DRjkVEiXr3Zmr1v9KIM9jTJXEPfO6erDuOAsEJweyA2P10RbuNljo
	mFn40/TANZGZL69e8V6H41+0Z/3T10hV5JqtYp6xqwsCqpqOveohoG0QSqVqeidnAhk8EDeDxNh
	h0A9PDV/x2ZwGAgsXmkh6ICU0GtU5zGBZyuAgz63FV+OZIeLevG1NTnybcVy9mNiPIiiYe0y6q+
	MllMpemLevm5Ns6CI1rHcG0TBYBvZJ0zSbyNLpObT1D0Szg4N322MedhUZ272aKPuMw/E4HJvwk
	UMIpXzqRGgZ2KqMquOWo1YNsNjs
X-Received: by 2002:a05:620a:4688:b0:949:b7e9:5d18 with SMTP id af79cd13be357-949ba9c4c88mr2022363785a.16.1795442185789;
        Mon, 23 Nov 2026 05:56:25 -0800 (PST)
X-Received: by 2002:a05:620a:4688:b0:949:b7e9:5d18 with SMTP id af79cd13be357-949ba9c4c88mr2022355285a.16.1795442185001;
        Mon, 23 Nov 2026 05:56:25 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm21724625f8f.56.2026.11.23.05.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:24 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:56:14 +0100
Subject: [PATCH v9 7/8] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-monza-wireless-v9-7-450d7d764aea@oss.qualcomm.com>
References: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfXw3tm/HgkQwRJ
 Fp/YgADzkjzXPcIXjGLx2YJ+KemUjmoAB1MKwmVVRO3OcOJg63COndjxP1vFUPaetuUrFfNz6BF
 niggfJCdZts1Yz43CRCaNOEE8tdhUVQ=
X-Proofpoint-GUID: pVahqKnjZtbT6grd-GXm_73Juish1hm0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX8j5gLVAjNjDg
 IB6cepAUrPpzMLyWLcKMVQ13613omV9Z4U0WgzfFY13ahyrBzrHJU82l/SGw+65MDd4PKlOogqT
 roHtxRBBmk5WFT1RBktpeqWP32C1zjKHCglcFahdQQ2fyO1OUXuBPhp95XHW26BkimHHLHcPHI6
 OFTfURayrbW+n/b5zaydbHy0AdPAhWgKnGMLws8jWcvZESN5VhBaKHCL9JuUjvUpNJ6MwptA7bt
 T2NlpjT4lYXuN7MWWj/iDxJScmAtRlOPSYI+U2XLe68wQuviRPwKcNcF5suDP+5wAIih3gVLheA
 0udPYeuV7L+9nU7aEQbe5e8KLk+4E40G0W5GrHVY+EBrusDpbQquL8ZyYT/jcAt48Wh6N4KTYUg
 JsdhvRyhCxXzNR94UIK1iWq4nt5t8tNpTc0zJoukc4ftGvPtuhh2OX/3xmN5cFq9IiyJTfAmH3B
 wmjY+hDrKiynw8VTocw==
X-Proofpoint-ORIG-GUID: pVahqKnjZtbT6grd-GXm_73Juish1hm0
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b04460a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230055

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

