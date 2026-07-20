Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD63A960F
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 05:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784526077; cv=none; b=GSj402O/rNgKiouliSbxV7uK9ZMuRnLxdFrmiJ5Uohio5QWYHnrRc9/gdPo2r4+Xr3h93iVORxYSBWrQjLWCBqtcD2DdONWKDgiXLmr69VHKLT0jNJdMNElVdErw/5nTvFdGhdLQJkYuD+uH4hQ08T3AhVVXz3bmiLxu1rNuG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784526077; c=relaxed/simple;
	bh=Ie84N1/e0y/o5k01PGOm8Jrdz4zFuXU6nJ9FWbLGFMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0H3NodfCVApBphXxOkROSta3ahqwHpKrASSCKz0tlDkVcICjn+JEewaUIR67zpw5A9GiCS3Mk6Zvnqu1/ceoF5NueMgQS0ikHJEFr7jy1zBH5hDlFpTp1cwGBTmawbx1E1NXVXXYWd6tz9cz+ENXf9zuG0tHYeS2yDV64jyAyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PflUCm7L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iFfjzkt/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PflUCm7L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iFfjzkt/"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNthRL806605
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 05:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DsL1jXntAxy/QFhOd1qLzLBeV25McAd0uQLgzy6lPf4=; b=PflUCm7LlEq6FtvX
	TrOQWOHczUnKXcEhv6aPupQTLx4qBNj1UGwc/AHvh0EKxKZH8xjCSy23b6hi9ceY
	/gIVBz2bptVkW+LLlm9ZvgZ+Ml3wuRvwAIg100LhTWejxrnqRqoV/SV6asFIoFRe
	jEj6j00D8aqGlnbESgfMgTOnJe5zThPPz+CCKf6IopojaaRtj+l/+McQUSr8l1XY
	FpGayMiKMJ5ZhWyyQ59lvXFAukunYY6mz8ux8kV//LcQzhfiMOADbsD/PCGwX4ZN
	TfKxu2p/XgJVPWoIIvh5fRY6J1ZUXNf9LwL/Iu0iS6IBZKM3KlC3S+8BpXmBE7ge
	qzNNbA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04uh7k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 05:41:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccbdbeffb9so35469045ad.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 22:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784526074; x=1785130874; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DsL1jXntAxy/QFhOd1qLzLBeV25McAd0uQLgzy6lPf4=;
        b=iFfjzkt/ifJ5fG+D6nlZUUr6JaRGBrW+OemoWdlW7vc4ZQr/w4NhV3pyRu+K7oM2Mc
         tpOxz+1qlFNU1rE05kUpTOQnME5AjY+9f6dG77ADtR3o8qYbUDwtP98G4srMC6Lc2O+X
         irUBQ1uPJm7wMDXCzsB4xl8ElaOQ0pCDkhbV6/p3SPoMhrlM6TMDGBkWeBT8pn+rDGJg
         f4o7PpLtQ7eJo0AFp8L1YZwICohznXz6BMiPa1SkBM+yiKQCXiVmQSqhEDIdmDTyhYnK
         6uDXnOxZSLwajjbSKEDAzY8CXsVvfRfYI9FA4X15k3htJ+z+dxKWUaqdXKHhR8DWVlys
         9Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784526074; x=1785130874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DsL1jXntAxy/QFhOd1qLzLBeV25McAd0uQLgzy6lPf4=;
        b=XQqLSw853fdSlEZoUeAIHsUIL0WH5mKSkH2FRyx98xwUPNAW68/JNderjgNL/Jwn4j
         a0FzhgSAAxotbq0C3bvKaRNl0Hj95wLPxxBMVMJ+jMEuC56nn5bfnT//pO/T8bqfMmXF
         +QR2WLX5eewa/DUH3lCVLH81WzQs/9HqNf6Igh+tKmCvZjCgmlKCK6O25U/jHgOlzq/a
         uBXcniFDJUx24MUVAtyA08xCUITuEBacInYvlSovcJOljzXjyq8HSh6eR6UvrNX5RXM3
         SbHiHDrzBMqyfIgl8vm4H/7XHXoHsF1xfWEFqAwh1a85y0Y8eAz9ppLpOFvcswbMRxBo
         ryng==
X-Forwarded-Encrypted: i=1; AHgh+RrN+7Zr3/2yfqIc6sQuQTkuV8nGjRiivJkPzut6WJieqjPnJnvveeJ56mszAK1RXCDzy61qhYoAsYBU4xgjt2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2MqcPoxdiJ14AAr/T+At9punX26PyIrBVnBBCuB/6LVvu3iyJ
	vzQpOhMhhv9I07uOLtj20jYNM8Tm2o247YzFnftMO53cswRzItzFkU2PTk5fO0RoPl5zi8phm4Q
	47+hzERDfMl/uYoM3qk1pp7e4UNiulmusMQiPNFJ7uPs9aAhHP7mrY+1ttoW1gXgdGUztpE0=
X-Gm-Gg: AfdE7cmprY794azWTzKIlGQOIpHopnqgTQTQKTboty7yiSoKrAJZX7R/leWBcIq4zQ7
	2TNNUDDhyyWtbrEwoYetzRlgFiZvqgVGtEefryESrFBMt4kLkj/SFi52SEk/qFHHid0n4wy713u
	w9yBuF82mGVBmwgGD7RUa/XdK9aa0TyhMx6/2RI52plVEflHFqtpgPvfvxhlUWLxKBZM2ZQ4U72
	BZSgh1AdUP1RZtEO6AHyV8L+gYCZabZ4SXoAuxDgvnRMD9RdclbK1/6Eu+nGyK6YHi8SewFY6ol
	Djgwpo5eNo9lrc2MEhMWNi9UfCH2ogk6yy9nhbJLhXE3/r4FKaS8bqK+9HQzi+qJ5fha2YV7pue
	wp2pGztNuGDxNWuJtHnM3N2nNLDfAKOpY6+iJobqBsm3exAc=
X-Received: by 2002:a17:903:2d1:b0:2c9:99be:f011 with SMTP id d9443c01a7336-2cf34988a8dmr92559055ad.6.1784526074300;
        Sun, 19 Jul 2026 22:41:14 -0700 (PDT)
X-Received: by 2002:a17:903:2d1:b0:2c9:99be:f011 with SMTP id d9443c01a7336-2cf34988a8dmr92558825ad.6.1784526073823;
        Sun, 19 Jul 2026 22:41:13 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1de301sm31907340eec.24.2026.07.19.22.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 22:41:13 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 19 Jul 2026 22:40:50 -0700
Subject: [PATCH bluez RFC 1/3] doc: hci-protocol: Correct mtu to &mtu for
 getsockopt BT_RCVMTU
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-vendor_hci-v1-1-df2ac5a50117@oss.qualcomm.com>
References: <20260719-vendor_hci-v1-0-df2ac5a50117@oss.qualcomm.com>
In-Reply-To: <20260719-vendor_hci-v1-0-df2ac5a50117@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5db4fb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=snjqleKXI9WN2fObb4sA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2MCBTYWx0ZWRfXy2DciqPkziaP
 As8H2h1NH8pG1KG01CNWpifh4JMjliblcFIUNR1wgkhSUJa08K04eqIUCvaQaJZNaVv8EeTVZmD
 2JTRrjsEm7TwZIddmQ78bFwlMYdpWvIbNrYo4Pb/IrRiZSJ4xFQhm55h6MKQG+ygJHQIf+NLOR2
 43HEe2MvgVW5pojgxlv7YedCQYyPSMkUFJVsL+zrm4asSmMSUaz3jBL6b6NJ1ZgfF3WYAZ9x/64
 QdLLrvkAmLkp9YbXUTyiWWaquheijOWQgC/ugvdIVWdxLXXOFfJ+bY2sWoAPLcJpw4Sp0pTUjrY
 zQXlrmhH4oPop47bSSgz3kWX7u6LsqZHd4wS1FFmeXXB2gl9+lr0qJ16DgY0i1QlIMsrt+h+7sJ
 M4w345WfrObkg8vHYBoUzCEA7qoJCSgOQnV4X2wFefhoZzISKsZEhndRxNYgqBqTUjoAHZkFdxq
 s0PV0mo110VcZgiCprg==
X-Proofpoint-ORIG-GUID: ZvS1Lou3OCSnZIzLdHvY2NXpza9rH5cT
X-Proofpoint-GUID: ZvS1Lou3OCSnZIzLdHvY2NXpza9rH5cT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2MCBTYWx0ZWRfXykF8jHvTlYlX
 +6I3ML9yLKgpbsenMVySEj/9YWOwlgyPX3gc8Kw+tJ9PjFQ6I9yMv/h/8l1q9zmi5ZMRgfC8IVI
 tWGHdAP1mH4kWESgPMnpYLFoGNyxCIM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200060

For getsockopt(..., BT_RCVMTU, ...):
Correct its parameter from mtu to &mtu.
---
 doc/hci-protocol.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/hci-protocol.rst b/doc/hci-protocol.rst
index f28684655842..db10b35df736 100644
--- a/doc/hci-protocol.rst
+++ b/doc/hci-protocol.rst
@@ -134,7 +134,7 @@ Example:
     int err;
 
     len = sizeof(mtu);
-    err = getsockopt(sock, SOL_BLUETOOTH, BT_RCVMTU, mtu, &len);
+    err = getsockopt(sock, SOL_BLUETOOTH, BT_RCVMTU, &mtu, &len);
 
 RESOURCES
 =========

-- 
2.34.1

