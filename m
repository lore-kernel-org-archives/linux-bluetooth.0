Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB28B392823
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307234; cv=none; b=XDdVzqtDSPnEcJu6GL/grQ0uEqgLjoXbOlyrBnNTnsU5NpAw68hjVBZpsX+hrNUVuQgL/V2Xg4+TL8/mxUiuxA/a8lUqPKW9LiqHBvjGBZXS+mUBy9K/dDzn9zkTRhKW9oH2aPCeLh8Y6CIZxp/3PF0sx+hnD1AelIftebcLzkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307234; c=relaxed/simple;
	bh=PJL7aaDGxCG7o8iXjt5pBDebjiba9LJ5/Sp6HGBrv0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=epT0bgPwBJbKnqRttPfzqCbqZJw5UYPGMzVzjmBY5a35ixeTVb0ehhplAQJMIm3MeknHx59xVH7coIwH2NsJ+QaKpjlmhwyv2jWKrYO7MQGJe6+t/bwOQQFbsa3fkgG6vzZ9pylgyKv4wSEu31ADSI9w4CEmblQ88sMC5grg21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L4Lwew6B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ePt4/70q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L4Lwew6B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ePt4/70q"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518dd4b3563820
	for <linux-bluetooth@vger.kernel.org>; Mon, 1 Jun 2026 09:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kDyyuyKqHdudCgNoWARWqTpLRahQhURVWMq0HVDCdFY=; b=L4Lwew6BYmpAZpET
	uHq4mtGVCxQZUNjMnxV3CC4hzBtfhrmfd7igLZjjj0sidERPJ898KZaVPkAeu83f
	OxAZw/BKROk7Sj2YkW8Jts6KslZOTurqlZWSA5vqYrWjKkHS6SnXTzHYevzAMu3R
	qnNl3BS9aO79MHakyoXmfhz9hQtdwiCvldtNOZU1TB2z3tjofliUELawBCusx/bR
	n0ZjRKAVHXg06cWceKTJozqjeWY3AZLdJSqbYysjsxRKlBmj0udfC2JospiXICUM
	6PGjTCT50C5qGrghFHU4NyDkbarxyb76y8JFl+H4isQvysTcN1hUmb0nyvXpfQov
	D9IzSQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6rxr9wg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 09:47:02 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-516d8b6e4dfso140579851cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 02:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307222; x=1780912022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDyyuyKqHdudCgNoWARWqTpLRahQhURVWMq0HVDCdFY=;
        b=ePt4/70qEtUbzziph4ordQaO8Cr0dcXiB0CGxKBuAup4Tc7Sw/v+RQZ9Q/eir8Hr2I
         RrZYZx1xkNvDLjQ8QDVg5CTRc7WESceukMHy0f4r3F2TPmgmq+2QN3kMZPbLWdOD3Cf/
         3HylN5wJnNYlBAUNnSaKeqFGn8KVLJ5hJe/jrcdcTk3geI1WWkyYQhB/GzKwRA9Xe5D1
         fo4yNRjxc/CAB/UQ/VUw0l+tJeKXqvvDndpGCYM7iLrgJFARTv4aw97IXfwrhO0/2fUQ
         sPmKR7cGkIsDZA71hDxs92Y5tXOIryD3KXaga4WmOatKcG7wq5f8SuzjqlKWqm6tm4sJ
         bcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307222; x=1780912022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kDyyuyKqHdudCgNoWARWqTpLRahQhURVWMq0HVDCdFY=;
        b=fxXuM2QZjpg+IhPEvLoR6Gy0tSWd9C2/A9Orxr4zs4/bsQ0whuucGHSXSmdVl5s+lx
         1XPX8Ys0PAMkCdTmbgOkUbRDCMKeDcxp1dAQDlJ7+6rRZfreAv7D/MoI8UWIokGIJCed
         kYyM+19+PGIO0XWXGa2Tb7nj1s6GKhmChrAzhBXXYdfvHYrQQdQJPb/wvnsxom0PjCHy
         sfIt9TQ8hEoJxK3cwn6tmyoU/nk0OEbQgGcgLUjAUdL9Z6gfFiCNTJXG7j3uLcMxFeTy
         1zT0A8cFOa4OpUMi/HlGes8jg4Q8cH+Qq/TBK/MHTveajyta863D6mnDB1rNwtlBO0L/
         uR9w==
X-Forwarded-Encrypted: i=1; AFNElJ+nSYwiPcjsKgMpNaTl8cwrFjYdKihn6RTl9xCzzoKyiuqqkM9FAJsmIkoLFaUtWHu9mNiGTODmV6jKfUm7Fjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWHtJhbZGCZeASRxkj1xK1+W+C/4qCIaMtfYoERnMZBmgE6bni
	F323j6r7ccInPxdnZvWhMRqlPNS2sjIBx1OJjyO58uNqPti4Fl3NLemhl5yrm8wBQDlghnxvd3b
	1CXq358Bd+Def9BmJMZshr4HP/vT5cchhtSBGNi+6HcEiPV6ODbj2tFwlXhFqSlRo+kCItkE=
X-Gm-Gg: Acq92OELglPr5gyCYTSE5ag4y4kZu0GwDp/d2KiovUyc4thqtMbUpociWZZw2mXY0XP
	16fzPtGy8axrL7vpl3oNCp0OPs8MG+tRcnwhFQWADsV3TSR8jTLDWZ8YdL1bjE2JN2m4T0c9tgS
	8ND72cDqqRFvrohqvAYxmrkkU1t60MwIoHbmEgqDhOou6zPtWdeX149wcJMC3SpkR1jKdia8a8e
	m671ww/GZlxb5QZ41x+2cabUQICrzU68HF4hTePefmwv7c6Mq12sPL7kX4gTV580iWmcrQPmiIO
	2GgJ68Ivcpa5YFhWyRQehly/QkoszoOHKWogG9O0kLRNz633q86/hJkXkEaVjluTMPSdA70havw
	LcWDLksbqWc2TWjxIoMgSyObrChMBwPp3nPP/O+owHLMW40ju8/dN1lnAFA+3sHj60M9hgtUzK4
	b97IOX+8YZNBo6yaX3TqajdKj27j/MPYroT525iTqLBhN2Sw==
X-Received: by 2002:a05:622a:1dc4:b0:517:5e1e:f8b9 with SMTP id d75a77b69052e-5175e1efa52mr8691811cf.28.1780307221803;
        Mon, 01 Jun 2026 02:47:01 -0700 (PDT)
X-Received: by 2002:a05:622a:1dc4:b0:517:5e1e:f8b9 with SMTP id d75a77b69052e-5175e1efa52mr8691441cf.28.1780307221405;
        Mon, 01 Jun 2026 02:47:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39672802651sm15355201fa.1.2026.06.01.02.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:47:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 12:46:52 +0300
Subject: [PATCH 4/7] dt-bindings: bluetooth: qcom,wcn6855-bt: document
 WCN6851
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-sm8350-wifi-v1-4-242917d88031@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=PJL7aaDGxCG7o8iXjt5pBDebjiba9LJ5/Sp6HGBrv0I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqHVUKFzA2GWzfnPbRBNnS53Q+2DwhhafI85JAG
 lkifT4EHP6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCah1VCgAKCRCLPIo+Aiko
 1TRLCACzFCWDg8vta0kl/Q/xGa4mRMzH/xV5T9QwD5QgcFB6m/mbqBfpwArl2qrB7+QImIHy6ky
 RJo19vvWTsrpy/+sirk4YeZAQUWPh8VcZDHbHc8Pb5eps096styxqBgKh7bLK4YqBw17Tb26H9A
 XP9BNsdX91u6ESQLUeMCDyrtrzNRZqu9EvZ4w3jaYtrn/egKh8Kqe1NcaJUgWwsXxKZlWuCV46A
 K5OOz2knudfmQxcsf94iP4X21eov3JvZadH1H/Sq190qQO/nxHoxk9XIn+VPnVEBM8AExGcP5LH
 c7Jp1/RdMTRgcnzWPbINBFsPk6VDwXdh+4KRhhs10LRk+rhh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: Y-lLnKgZW7g-gPevGx39JxVdEQhsbw3r
X-Authority-Analysis: v=2.4 cv=dsfrzVg4 c=1 sm=1 tr=0 ts=6a1d5516 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=CPtQq55eJxPKLu9fJ8AA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OCBTYWx0ZWRfX+RrvY4KDCB0G
 Wl37wIz8BsnCEDccl0vO8nBeOsq8r16icasOxiLitir7ODqep/zHW1CPwPEMIO+w2s+RatRhqCZ
 yvSmW7JiA+tysc2t2n4DjONhbpCfD4aNPGv5o4O990CPmMJd2I0MU8P5L7wLLAT2xoCnhg8g+1v
 eoaV/4eECMflrFW8lzwtSuunkJnbvoq4OBJ5vUN9epajslq4xkKSUlxmUAVa1O34MP+hlTYRMlt
 x4AFzgf196KbnUtZZ4YCwCduK149QA8ph/XF9UQM+m72q7Rq9dyFDg4ulR5vDS7y87wHuxvT0zU
 9EXJ/pU0+TT/pFgbxDntr2xKBqb+N0ACYlYlao++yNYeA0IUCZhCwWaGCNazbb5jvj6ZacLS3Db
 S23fyUHIY1P7dnEjXc3gXmYDmfnWi7HMyV7suNq8Z+N++rH57o3xShnjYGK9jabSFaZixDm1K2Q
 cqY+gs4muJtzyJCX8Dw==
X-Proofpoint-ORIG-GUID: Y-lLnKgZW7g-gPevGx39JxVdEQhsbw3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010098

WCN6851 is an earlier version of WCN6855 WiFi/BT chip, compatible with
it. Add a device-specific compat string with the fallback to WCN6855
one.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml        | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
index 0beda26ae8bb..ec766f40a042 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
@@ -13,8 +13,12 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,wcn6855-bt
+    oneOf:
+      - items:
+          - const: qcom,wcn6851-bt
+          - const: qcom,wcn6855-bt
+      - enum:
+          - qcom,wcn6855-bt
 
   enable-gpios:
     maxItems: 1

-- 
2.47.3

