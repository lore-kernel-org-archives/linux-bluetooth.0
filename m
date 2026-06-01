Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354C9399887
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307237; cv=none; b=GqGJJVOOwMVxVdF0OY99jjHCd8VitwNVL3h8AsbbPFbgPiSQBk0LNGVDvFU7DcIjvFbw+JM+x1F87SpZvdZML5IWi5j5beKbDYcCjevJWOVQt1WCRMrZEwI1MYIU/QTs7wZ51BLILWA7IK69pjdZkRi3O5EPXl5yb3f3CIUoJ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307237; c=relaxed/simple;
	bh=QjvgCxT4cjyfExqVSl23BqemGzEEeOq4tGjsEdwhVAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TzUTdKZJXeeVTxA0n8P5oCyo2CaC2d66iLE5xea4vjlSb/sO5Jsidv5sOanjKEJJFvj9UHQBLj/i2KrT10eMEiaYQeEyictRb6R6N7JwbJtAW7a7j8aM3Mgrq0VPpmgCRMY3YANMIW30hNWJy5xrdI0/YFchlUtioCzgoh5jVDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QkqXE7X/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xa9PDqir; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QkqXE7X/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xa9PDqir"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6519Y2JO3372613
	for <linux-bluetooth@vger.kernel.org>; Mon, 1 Jun 2026 09:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iAynyGPj/m6HlAQLnycghU+jkG7FRJqT7laanFnpBMc=; b=QkqXE7X/qkvx0ziN
	ZALrVq4dwcXffYJ+sMpIvKYY9Nv7bZqBzuA9+RdGdBlaM/yKprK+rmLiAUBPAV0I
	Bz8vxf8EYMmTT/Vz4RCtMo8ZNWmalfy52aN07DqUw3FDgjy3pqLEEUmcPzemeOqk
	tNP6viGbB6yro6tlx02KMgzCkgcohEVIzC8jkd/TKN/wQnrBhWweMX9OzLpZxMi7
	EsQR16u4DxHCyDsObMgi8+DULFdaY797NileZiifPDByLSkeitOLgTcgq/3Kp7EN
	YQG6ivI/AlDKzoVTOFma0oZGZhAplOJ6LgDlu+B2akIROsTODgB8zjSkMGCmWd6R
	emW/4Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh7jh81sa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 09:47:04 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ccdcd8dd3dso74992276d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 02:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307223; x=1780912023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAynyGPj/m6HlAQLnycghU+jkG7FRJqT7laanFnpBMc=;
        b=Xa9PDqirXFpL0UVJASlvEmEmiZw/T6O6Bg6tSIgFonEaq/acMfw/bAFkEeSzR85Hx7
         VrpVlHeh7tyqU92BDn/ziTXz0tAP2ghXLrxw6UpMYNIRYveLmAxSi1gLqc2dVFHvrMP/
         wLEFYHiQY217i8esn+YcYLk10w90wEpV14HW+GodhwRtS0m2Z1UgbIMU0VuynS0/hb4V
         Oo3075xBfxY4FeqnT7zvkXISs//7iudAelbTqonDRf1UkGkTMsAYxFRIxMMFpqTsmdfo
         y8zIWLP+9bwBe1oKCslVmDu17XBg7xBPcF8OzcdGC7GJpK3gBGWjrqeZ4mIPw+kuF7aw
         UB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307223; x=1780912023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iAynyGPj/m6HlAQLnycghU+jkG7FRJqT7laanFnpBMc=;
        b=Dtna1mlBtzo5HA/esh+TWOQ8lfvrhKbGAqOl5MuxeV5Jki3mn9xmyfnbz0hmMsXxXY
         nprpO43jlC4p3qHpKFIFwrzaamcw2ip4j+FFSKqQ/hP1GGvqRoOyen8o0iiL4/Xxca8A
         LWBjWE+NacG4WdMZBwEMQXas8eq5ZVNC8NxGT7bBCgbBGqRVpPCeh5qn3ZYI5ntePwEu
         xkmTcws8p/O2YzcvfBIeHdMXn9OjSpsWwkvYN4mR1jtWxSWAmCWfcO8R0G53UEvsJPzz
         z70wkW7sKonpN9f5O44jdcE1Rqh+dPwjrgJvr3aCfOzUuirScE7E/XO/d36k8Yx2tES9
         OsdQ==
X-Forwarded-Encrypted: i=1; AFNElJ8DAYek5VJsqqkttTpmh0h/LVgWwIZ7FfnA44RjNPTn15Gt+H33tLiTXs0pKdd/FtQ/wEgssX3Dowysg6g4hR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiACqJXH+faN8AbTsKDoqCj+4osVf55CCPNmOMQdmFaQOYUvP2
	64Ig9B4WfJ8Ba4QtmWDjYmiKM/q/0lUEDJm04Q5xgibyrKdsvNz3JLOAWEUqrTowXuKmizVVu4p
	Dq5WFPX1HnSn310PW2MT7rYt5tfBV/r9Hiys8oK01DYLm3aZkrUKRvqE+eO0fkxIXWjZ0ves=
X-Gm-Gg: Acq92OEcAIw/NghVs2AK4SKxror5+Bx+9uEUfpXgT5AuZOjftv2VgywGJef1bRuXYP6
	5EnP3d7hPpnEVh9SiWOfDnJ69MmqUsamRUwtkJMi/Vsi6CQyJqegAltyS7s3YbuLLMF9YDsSmsx
	lD+T+CFrrCBJr4I9rBW22QcoI9QGGHfcusK7kmuuD39g3wXNobqVECwc76pU77LGE/g9JCz8HIW
	bMQoHzy6GpIdAqzZ5bxo4Ino3ggfiDTcmTPgIchRUxk23io/LImKGkKUAVY9ojzlh2EnvGKKEbY
	Od/j42OB20csqSTV+YESeFP0CV987Bus7rxgHS9zktFAN9MjqPMe8vr3e6kH/ZHrWEXynrxAhNm
	3ErYXeTteHFi2HrVWEn9dOE1MI8aA6w53TrWbP/5UYYGA2TAKK3NPzu3DhQ8YmfOzWF5EgOqtvs
	W1AYCz54wt5vEBR+YO66pnOnN2XFHxFT2Od/bdALIFEMps4w==
X-Received: by 2002:a05:622a:2289:b0:516:e833:64f2 with SMTP id d75a77b69052e-5173a61b308mr155830551cf.12.1780307223355;
        Mon, 01 Jun 2026 02:47:03 -0700 (PDT)
X-Received: by 2002:a05:622a:2289:b0:516:e833:64f2 with SMTP id d75a77b69052e-5173a61b308mr155830221cf.12.1780307222934;
        Mon, 01 Jun 2026 02:47:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39672802651sm15355201fa.1.2026.06.01.02.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:47:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 12:46:53 +0300
Subject: [PATCH 5/7] arm64: dts: qcom: sm8350: expand UART18 to 4 pins
 config
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-sm8350-wifi-v1-5-242917d88031@oss.qualcomm.com>
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
In-Reply-To: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
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
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=873;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QjvgCxT4cjyfExqVSl23BqemGzEEeOq4tGjsEdwhVAA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqHVULL9vA98gnb1vk5P6BUKdenYE36uwUMwczc
 eklc7UGkxeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCah1VCwAKCRCLPIo+Aiko
 1TcCB/9Ju6oFg8fhJQdx/b+0NIq/nalsJ7rHRSaj0cfCy6j/WB4c7RAbf/wVgPTuKG9aqavA9he
 9Nbn6yvgwTHTPX1HC1rY46piFDOkAlpOnmMj6vV+vSkCbzEDFaQpDXnUwouZ7MadIGG0ST/sXAW
 /sMDmu1f2KiaeB5VoyLAhuJZ/iNtUmEQPCDwzQskxbLE2UB/crRkEUVEa0sml95PLW2IULVYOOU
 bbrFoaVy7Y5JAFPN7FWkVZ2m5oWPVrZqPe/nMM4P85MGVfoIuq5RbXZdXLYGf+o1iJBWZVtFnaD
 ioQ09vSKsf7vxhefn0Ual5WTrmsIHgB0S5G7Lw0P/Gfdrtp3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: nE_sj8I9GdE42OLyLO1RaVITdWurxEUB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OCBTYWx0ZWRfX/8poI63bhXny
 pjCYY7T/vnEDwfrT4H7cw28Iw8p+gTi2ChNmuE9KoUfS/q+fZItM3yCcOg04xCK7lmy8BtdMzBL
 Ai5Y2BNXfWuuIkYBQ5Hqaui6VRge0QnLVmL8L9VNpYQ0WLfc7YmZ5YJyYQUX7IYIuTH45VXqXEF
 VvTOmFipZo8BjApqqJoiRqMrJ2PxyyVb8ZTVocOBO4eNjf6vHrreHNRaKXuDNG8UQ6z285w7+VZ
 peZs4imwgtaBMlRNInX0J8oJKu4dE8QQgjL0LSNSZY0KGYrthf3AbXpyDkun0Ezl+LvKmJ6en/3
 geR5SkOEpGR2t6vV3jPZW730ddH8KEHdHTeWodBMeDYw3I9+441GVGr0PIpJrM9H2+AYbcw4Eh7
 xM9kuDqEvlA8E42J+mzcNY3wqqTdE/fLAKVl8W26qtd542rsXmt0P0NfXWkz2ZrDA2ikeQzkZW0
 +TRDA/wh15YgRyfWEOQ==
X-Authority-Analysis: v=2.4 cv=YuY/gYYX c=1 sm=1 tr=0 ts=6a1d5518 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=GNmHCbt0ONPBLg8daWUA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: nE_sj8I9GdE42OLyLO1RaVITdWurxEUB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010098

On SM8350 platforms the primary use of UART18 is a 4-pin UART (targeting
Bluetooth or other similar applications). Add all 4 pins to the default
pinctrl entry for the UART.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index c830953156ec..eb2a795d8edb 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -3309,7 +3309,7 @@ qup_uart6_default: qup-uart6-default-state {
 			};
 
 			qup_uart18_default: qup-uart18-default-state {
-				pins = "gpio68", "gpio69";
+				pins = "gpio68", "gpio69", "gpio70", "gpio71";
 				function = "qup18";
 				drive-strength = <2>;
 				bias-disable;

-- 
2.47.3

