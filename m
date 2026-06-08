Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEF234DB72
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901976; cv=none; b=n9mhQxcxx/isjmwjULumIUbZj/332zYtxg2FDLgmW7QX3avXs9ugmKkgGk4bTl9p5n/5V2gdomOTUNdBIvRM0oDqNMnCLVrzh3ITBJV1CEqei7gpOi6adVDH8P1/Y3PyjXWWWBlEivEjF8lW0T2uFLmz1xExWzX08dcZ6XQxhwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901976; c=relaxed/simple;
	bh=E5nG1I+R9Y1uL6wRIFYf8yLD8UQdyGGQWO5A9cA0m00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uYLfrzfrcKT7NwqQs8KQqrdr2nDz94I99wRLIvnJkx8cHnSW+bp8cj3uPFniIbAtjR5vefy5OXYScU/51Ylhhn0Y9E1ZzbLZhOsew2PVkst/5wqTJ7UYK7d4vNJoXuBuUwHXDI5icLFody/oyro6343DovbkaQEqXpPRoiLZSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MqAPwC2n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dsdHE9zy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MqAPwC2n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dsdHE9zy"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OlJ02347164
	for <linux-bluetooth@vger.kernel.org>; Mon, 8 Jun 2026 06:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pgUdrGoPw1Xu5Xr22jy0zL7ZwrcPwooNwDkwBB5G3IA=; b=MqAPwC2n2YBcrbGm
	B+wd/oLBLJa/2HJwNMtlj7vA7IdNp4IYBb2zBciTbmB/SypTYS6NK7pOe2OL+4C0
	6uLOrt1ypo0meMttsKaHEr3xzT+JqgD90WTTJBkHZ2Fk+GDRcR6Zxy/jLBbWgvlp
	h3amdyAUUppkopfpu9wY7mNmcoi98+nNJgM5Wmr1dNF3yWBAp8hbUrPsZyjzoc7B
	0b/0psSBMxKNeKIs3XbKiFZqcfF5IHULn5Q2BiepcInIgvji8nZiFr2/74H4PwV8
	c4QIr+6mT43zOHTSZbgmOerL7L0BoUfmn/fb9Nzly0m/yiPi5dwGexHIGHMsXoy/
	CjXZOQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emagrepd2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 06:59:34 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-963b099b539so6156789241.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jun 2026 23:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780901973; x=1781506773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgUdrGoPw1Xu5Xr22jy0zL7ZwrcPwooNwDkwBB5G3IA=;
        b=dsdHE9zy5jwfhSXtKd5wmvkD6SH+pnF+oHrRpjHN3LDS83+SM95XkWcyniYpJAqjM5
         7RU5aUNZBhbm7n0DZMjitRMf5EraTxT5q91BNvVknhkIT6whBpepa0rWSdF7GzrHrpE9
         xXqFwdxc9OVT3SfoTifjnb/JQTznxufnV+tv+BvPSU1WiSMrIRSIHg4RXTJwTqikD9ke
         nAk5w4i1RtTdUrGTPAk8Vr9iQnTGW9ha6qsmxcNsCbsj58l2a8XFZZuJ7EjQfA5w9vB2
         WTYCOEtaSFv5bBaWrDIHglIn3UykqlkYZLnUOWS8NtUL2I39V0giaDLpsP2e2EHjBFnH
         5TtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780901973; x=1781506773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pgUdrGoPw1Xu5Xr22jy0zL7ZwrcPwooNwDkwBB5G3IA=;
        b=OrLUIJmctKiESPRcJ0yWj7ZVl6WAGLviDtUVzcHUFDwzYnQXrK+2awkVKDCc6IBwvq
         E6P+/qh2R5JfvaJ4bxQNtB1ig7TzSVWritoBqzFdgz2rq4rDNf2jyReLnZCq8qxuA66A
         ysgAZSfuIdsTfY325fXpYTu6BvI2o0NKEXC4CrE9hfVaDalCcoVmCLTn6yeuNaAyEem4
         e3DlqcJwcgk2sIVwa/cGN0jfYoXC8kWPouyytdaxRn3FUbc8YZ2Z0qCuoxkKHEWy8+va
         CAdNiyGqXv7cP++4GdjT1j63nno5G0rkkF+n6x0RbPmv8dbAxgPcnZZQFoZI62B7Ef9o
         1yMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CVpX+okmfEjJSvv1bEvFOxXr/uj9KZ0aXhQKgmgszWw+qtAZLuoAkneWOByrbhnr6D1WGNkEvYq6n+YpidBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwALk1ZYYLaKW7tKn7k35GijnD5b2DjJCRCvn6K/frrlaz8VRmu
	3u6GPFRGTHShahdhSC3k01BKrvpmie7RGEsS+uOJwzwfOUDaIxnfIIltXpCd1Y31AeyLgeBphgK
	1OgNCqpu4PNqqcvmf4GEb9HDi2/efcsxWrDJMB/DMmzZX/W15mYShvCG91ZyfekaTN/byZj0=
X-Gm-Gg: Acq92OFO978JGOwkkij9o3P504aib+BEKir8kJJ3z1A/wzzw6wAvMJO7cE5PSW6MJMg
	qPBi6MRNoVs4br61m7zqkv0RdrCqExpYOdHqgjTHcIUWGr7nRhxiGoxb6JrQJWvs04WipoYGtbD
	NZgMSkUWMriJ+zrEdOsljAAeYRZcS9dOYgtHpab2e1C+bUvREZIGYMFCKcajt5rB99iZ4jRXxSf
	9VlvkKeuMo1OUw3vKTAcKJWZckveqonjIQFUvwsGqrNSHdmc35C34fXVx10PC7jUeQ0W0aBi1xi
	cbFqUFwguJ5YZCgLh/qEu1fWXfpwQwuvl7D5jgUrdRFKghIZfT30EfNJba0M4oOJfUobshSIt8c
	sZvbupynRHBaKGcg5E57iekeZ4ndAvJ3Mv05eJxjCK9TCkKge8zjVO2j6wmCR++QCHHdfoBggnx
	eWleYMFAVPz6kkEw+0KqFrL455lgVKmsKD8vfY0ln+Y1aAHw==
X-Received: by 2002:a05:6102:ca:b0:6d7:a2b4:bedd with SMTP id ada2fe7eead31-7002b70dd8cmr3085522137.5.1780901973217;
        Sun, 07 Jun 2026 23:59:33 -0700 (PDT)
X-Received: by 2002:a05:6102:ca:b0:6d7:a2b4:bedd with SMTP id ada2fe7eead31-7002b70dd8cmr3085506137.5.1780901972854;
        Sun, 07 Jun 2026 23:59:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed789sm3638621e87.3.2026.06.07.23.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:59:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 09:59:21 +0300
Subject: [PATCH v2 3/7] regulator: dt-bindings: qcom,qca6390-pmu: document
 WCN6851
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-sm8350-wifi-v2-3-efb68f1ff04c@oss.qualcomm.com>
References: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
In-Reply-To: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=E5nG1I+R9Y1uL6wRIFYf8yLD8UQdyGGQWO5A9cA0m00=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqJmhKC14cVjpzCIkVBne864oziewquNLDoUL52
 fYhWlSQOJaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiZoSgAKCRCLPIo+Aiko
 1R0BB/9Y2mbz86gfOC9j2ZzYs8DhUI7Azoa8HkqS9yVCuC2ehrxEDHOwDXGIv3y2pjQit3dbAT1
 zTmRFLTkCh+GjwD2lPp4ARpJjOBCWapE7XfV7mab3lIcJzngU98Vn1P+rMRNTMheLk7BdHT1HdY
 +gCN1eOka+f3US0A1wlcHC0lU1pcIblMkkPyrYGmTVvKSlmTJPsyCjY7hN6B7vwOp6faOBcVP1q
 NHZNhc8e582lJFFdpAjrr0lIG0GRq6doXbo7yYW/37sSf4+KpdxHzkIYvtzAagFLeIG1XZ1sNS5
 Stk7EEhBUxMpVaERvPk3CP26ctrSxLZ6pbsUa3VRMt3StEUW
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfX6oKCg24E/V3x
 pMKwXdN1/vJ/qs9gNHocctIcKQXnIoD/s9VGGre1OJtSlEKB6/wnslizQgMNE2TqnTlqD89US1p
 /qaYW32NWla1eclq+rllT+urMiY3Ax9ZHRNGQx9WLYLnLGPJ1xbSSAETMWyeMj6OkfjkhKEhjjG
 RpKZFs7LlS9rPeK5rbjUOCwmQoTmi0Yvbiypy0cx1VKxburS87gA8Jul0h8GeOB8vYSQZcDP/5j
 riLOlln6DW/PTzJM2nVNH5WoGN//elW1xAE1a0HWXD0Bn2TE9d9KAkLmooXy9F5jRqLqlMQqADp
 rWzMXtWiYjpcc716yPQaUxWYTsFP0eHuyqfnY5KZTyBSu1Pcye0HbJut6Axr/WOkL9z/u1HDLHc
 mLVBkG5zNJg5r/d7PSkahn+rqV80JgiHR1MkgQ9VCgQT6O0ouaaJEG7aCJsuy8HgKdKhJm10EGP
 yZTDATdpr/8CMpHTLYA==
X-Authority-Analysis: v=2.4 cv=G/4s1dk5 c=1 sm=1 tr=0 ts=6a266856 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=_jZoHPq4qSgluh34qd0A:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: AQIlHLWg3YiDfEd5a-zSNuqbQrTxYH77
X-Proofpoint-GUID: AQIlHLWg3YiDfEd5a-zSNuqbQrTxYH77
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080062

WCN6851 is an earlier version of WCN6855 WiFi/BT chip, compatible with
it. Add a device-specific compat string with the fallback to WCN6855
one.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
index 105174df7df2..3d3c6fa7ecbc 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
@@ -21,6 +21,10 @@ properties:
           - enum:
               - qcom,wcn6755-pmu
           - const: qcom,wcn6750-pmu
+      - items:
+          - enum:
+              - qcom,wcn6851-pmu
+          - const: qcom,wcn6855-pmu
 
       - enum:
           - qcom,qca6390-pmu

-- 
2.47.3

