Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429549;
	b=0Be6TQ8iaQKMYPBgmap4qAmu5Gj9adU1IUECXP6BTGtZWcHoheiWwy9LpYe97TICqXRj
	 1PnAG8QxTH50Rwqwy9KJ7LKOi5Edbd9qlNr84bZqxO0hx9JqyEgu0P1ftDqI918+d69gO
	 9cueb8B9S9TeGH4GuLv6drl7WRWguZESkZZP7EKrM2Wx/EkLauALi/+Pdv2kzA2wudcAI
	 buRd0+bx++hUwc2E0kij5xhUBQDyp/H53KklhspZPSQC15ObFPokoVLSoj0UEh3UMmbbs
	 qe9COqbYE68tK0lXvqP8dvnubHQExKYYAxpGunpEo38FmI2blj1mF/+cgk2haLu4Kpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429549;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
	b=ZoH1IUs9uHzgJ58WCbCpsakRDpHiUJ369cRK6xdaXMXqt5/miuSvL94lxL/5EAJKFhbP
	 p5x4J+cqyC+ZPd6rMMsiaw9hFSqacgAHgbWnzl+T/WhQLYlF/lTXa+GXdg9WNXuE82L4r
	 he80PJ+MywphJj0vrQVOp2yIQvhai1xwy0YsFovcw6V0lJ/eTQtJRH7qtSSus8+HOG58r
	 BY7adSzW99qjqI5Mtk/xQq5sjxrhJW9zq7fz/aVn3Vh5S29e02SPiCyYUeSBgmpZTCBqy
	 4H/Usm1fWVNtlqnZ4VWA33wcA2nBnuKkti9pgqDmNsfcKiFQQcIoXbif9eG0oQm2jsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PG0catFr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TMZSX80K;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A6E60A2637
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30A6E60A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PG0catFr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TMZSX80K
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9G3LR1544356
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=; b=PG0catFroHWUpcO8
	1ZieIvVdt7o3wG3I/57gd22yhfoX/Ns9c9eA2XY+mRgEM4uuU2CJFtIdL3huZGG5
	8pbfBDO8D3MnOM78UNW3OwemZ0B0O0YuSoayd5B9CDH9QVRUjx6O5/ayV2SW0XIz
	I2KBPeMBIRKY6cl2KtsMl151L2oo0tR0awxHTubgim+fmAay2mwOrjgBuxKFIlDg
	5GSUbLUG3sJZBX2OM23hyVbMeTF7FUbZQmZcjMh6swqJ51RqE7p4ZPbCEe31G95G
	6vGfadHesgz7OcG58VZakx/85fHdgtyp4pkl6En1lS+cDIBfoH1hV7KSCfE/NZ2w
	C/UX9Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy00xym-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:25:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f32050e72so787910285a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 02:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795429548; x=1796034348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=TMZSX80K4huuAHvPAe9qssG5wgmUmh7eeC6RQHLN6v4sPudTMA2U06e5s3hrnKQjEf
         pi8fwpNbGc7EE15d0RaQhwABZeHGK2V95sK7v19r3y7m5niLZZuDaQ6Ztuj+qd4B+/UL
         GvWwc7cmE5v262rI4bUpuF/Kl+40lrAGPSWcTDOwkAxHrC0BrHdPO09Ep/gIL6an5fd8
         B/zABLOSQlX3WAp5irnERObJyx+WwVbLO8xluL0CT63LPkKUtrWEcJpworoH+hMcc9WZ
         +NF4f2Zw3QIDTI6MAJcl32qQh3USQ5yKKvX+MwWNccfjGE911AeggC+v2aDVCMY+iknh
         LPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429548; x=1796034348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=qS6M06tWMXZzQ/PXb9IQfVnAXNMaPgsf+ZBRLvnJJbnTAq9FdwakkZ8lXoYu0zw6fE
         DOPBBiU4LaJx3oW9m5VzdQb+3OqbOPYJA7otKj/c5+qrqRulHdu/yceFGPtDJghXEQ9M
         QqNDk5jYscLCa4fU/rGh+fCtx5lSoeXDcLSuYh8nhgdFC41AUrvhGC9fp4htsRd5GwSl
         cv6ThExkSKBoKTM+aSQfe7G4/SL8SD9PwizaLM+tIq21DHcDNBFn1yUwzXmeUFARndvk
         yxBksuZorJUxBEJhJw5owOI9Jc01UZX2y+8Prqjf0cfZkelSC7ml+mmeVVSES6uVqWrK
         si6Q==
X-Forwarded-Encrypted: i=1; AL+hErFJ2Woxn+zZKoKXlBrTczV+MCYPW+BGtg3pRWiPwVp69w3IYHrzr76qy+MxU0PmqE1+1MIWHgmPc28p1jdkJmc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+m/UPrQ3SybnfJ0LyUJWys3ItY/UnngKCnQDwalp+wLMqep++R
	3aufd/sWjTAT2pd6QKFUJOUq/wbJ3nAvfmry0OCfoemhUGErmrNtpyyb9xzsez+xJ0m4q9z7RrG
	gdshYrSe3zgNt0NI+3N1LK591gnZs1iVl0xaZ7mSO70/hUQpG7HkIr9+o8naZcxjN0eY44vA=
X-Gm-Gg: AZFdTZeT0br/Pp6q7AelrkWUM6czD0jMIxzAcTOPy0p/lLQJjsiDNrxMZ8Kc5GiANhF
	XxscXKTHR7Ux08HCDAJsva8kz5j1XXq82R7Hvp4loIOnX4AWGmzfQUmat/tH2aOtCbWFPf/aO/P
	0n8ZbCXOebGTOC4Ad7UvbUgAZ1qslPwxNw4wPXYb+DsIvYJn6bd3z9Z0YAXnw97FMCH/Ytu54Yi
	v83MM5TOvT3PPGu60EkqbSNRo2fx5CoFpwwGGbd3eQgEHvSwAcelqz9xwAyy13+Q5DgSQdDkqgD
	FnDuGvMQoNPEoaKn+yGCKSNSW9S/SlYUHmJi+hRLGnvQKitS+FblB5NDkgRXbNICaA3KSIVgysP
	HAvueXldCys6+Vn4pvhzQzrWYeBgdBIfK8xlTCZqVtNCMww5g3aQkfXxwUxzbmlzy2BMLS43uRq
	dkmp+Obc+X5G7v0OA9ULwGMkif8dYwGYN18MC8oJMwOYsQzC2+HNt25FHLZyeJEGBy+aDY/47IY
	g5mRQkR4taOSs5W5LTT1EytAXfq
X-Received: by 2002:a05:620a:2b45:b0:949:a7d0:9fbd with SMTP id af79cd13be357-949ba9e2668mr1901700585a.41.1795429547622;
        Mon, 23 Nov 2026 02:25:47 -0800 (PST)
X-Received: by 2002:a05:620a:2b45:b0:949:a7d0:9fbd with SMTP id af79cd13be357-949ba9e2668mr1901697885a.41.1795429547152;
        Mon, 23 Nov 2026 02:25:47 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:58b4:dc38:81d5:3c3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm634166845e9.4.2026.11.23.02.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:25:46 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:25:38 +0100
Subject: [PATCH v8 7/8] dt-bindings: connector: pcie-m2-e: Add vendor LGA
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
Message-Id: <20261123-monza-wireless-v8-7-a8b38604be6c@oss.qualcomm.com>
References: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX7Uy8O/Rl+rWj
 YNYToMomeTNHsTLO8BsGPH85O9ZTse+6KUDehle0j21loaF9NLJ1GVIDpC14VBNXuJ5B6nYlI0A
 HY9f4GZ/r0uSYbJkt/tdNWZOxC1s1kdZwO9IIqRFNC3eFDFxn6vohrDO/+HNVzvkkX21NG1H1US
 9FzgKHEmdeY3EDvUa6YFAt0qaXwcqXJhW6dnWb/aQZR/4uci4prtb5M+1s33GT2H/D/XCh07etF
 qmIMr/dGbpOmodz5NC+MADUPY2lEzLAbF4bNlW4AgDGV7RBjKOdKGagxVF3WCZ8Q369Nx1uqYrs
 eDtHbAV9hXCR/WBN01U6kAgmfgHqT5a8YZeeysuoxzgkoWqnvIGMKFGZkxaOiXHjvIhkXyWNtJO
 tjJ16gJNUP1Q696tBwuThjqMKGsJKjjRqz2wLT0LpcdXtuy4FhJy/ASmqDNZTXUMiTYxskEgx6I
 vpMowdprEie3ZGuk7Rw==
X-Proofpoint-ORIG-GUID: GhY5woTJ6ks07Y25-22TM5hj8Ja2iEI7
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b0414ac cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: GhY5woTJ6ks07Y25-22TM5hj8Ja2iEI7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX8Ca/9zy/3nyv
 /MXrgdYJFXD5zZnA/fM5nXjhP18KjwWQ1SOsoudtGX+kCJ+90THsRsLg13Dwi/MdR73zLhYyY03
 fnPH0p4xEHB7SwHzQObwqXtXPrxpD7M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230041

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

