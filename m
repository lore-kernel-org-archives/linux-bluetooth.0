Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0896938F250
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901973; cv=none; b=osH3reMFh3lWoyOBjhYpn7xzAr7PYDWKb7Nr/I0QqCbKLw/BHL9xgXXssBi/GEuHJL9daLyy5B97Rkxh2rZMkTAD+Ip8K8YDLa28GmlXhJJo1RYJwgvAlzjBrQRRBaQuwRaeovbWBRL1m8wTG0h4G1fBz2H/UnNiVBx7NgnaN34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901973; c=relaxed/simple;
	bh=h4yLRvqGyQTl6OR0GngMd/YRroUj4EhJo0XPHba7d0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXLIoTxw3fT8SSVysa6UvEaDQI5nLxz+rnZVQ498cheU/e2Gjo2NSTu/kHp9qStF2uh6BPH08e8vIluNt0wrMnYIYzyEZ8sg829OQ97X3m3OmvvJx3TgPc6KIq07NehcXOjEjZhV6iQa7/bz4yHa/+EKcWIH8WmXU1pOLFk0Hmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jmWamVzi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EyCNY+aK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jmWamVzi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EyCNY+aK"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586Qqlq2771101
	for <linux-bluetooth@vger.kernel.org>; Mon, 8 Jun 2026 06:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M4dWomgyfsAxdHYGato4YCIl0rH04fg4NjCDPCL3Zf8=; b=jmWamVzifzUA7OyK
	S4oIA1/vlZxiYhDV90onPQ0h2LcNIWYzMSNaUTfnLYHHGfFWxeK6agFN69na9bWR
	kjELk4NUA10ReeOKwXNAvaf7pqBHZEM2QNJM/f9LzxRY9I5CF5GbIvLFXd42RKej
	6gd39AaKkn3I5tIOT2eKqJfnHj/xb2tToLX0nN80Z3lNYSbMPJCLix+6b1d0LHSY
	4/ubfgizZJ/3gNqlgauLFrCDsylkF5nhyNem3lY18RbNv2kAEFpMsUbRIuNuqUN/
	sGK0DZWtA4lez1hsReBdarZ7cCmT8MQd8vRo0x1nu21BbyS7sPYaglofBwc0dy3M
	9P8+Hw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embx6ea7y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 06:59:30 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-59ebf600cf4so7286114e0c.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jun 2026 23:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780901969; x=1781506769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4dWomgyfsAxdHYGato4YCIl0rH04fg4NjCDPCL3Zf8=;
        b=EyCNY+aKKbySRJonIvXlu8jtYjmXkJ9XThF/KenosMtHWNri5CIYtFW5uP2UAijh0Z
         Hay1sLGcSrT9h+WkK9UT/w0DucGuFsdjrUYevC8U5aAJbp2hg9p0uHQaRJ6Sfese9k24
         psWyZZ81iUpEhbY3e9u72JosMU9Rfwk2h0tFPQGZopLMCIvcHbqtIfxzcT/1RM7TXBqj
         7aDBbZdl79rf7a3rNOZ8r6QELPklVcyV4F63W5FmJjwXwR2scFGlW9LiWMI5aAl/L7h0
         hDWZRvV7gb9e99K1ZupacYaBm8mhE7KhaNI3hbxtu3IZlGprYfeW9QWnBuvKg6YslaLW
         puuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780901969; x=1781506769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M4dWomgyfsAxdHYGato4YCIl0rH04fg4NjCDPCL3Zf8=;
        b=Kp7UNHe8jPhF4BV3c/bcV+2VCfS9EF3X5AC+lnPwrQULZG0tymQsdhWg2zJFtDTGP5
         XWZI7DspmHe4VPNN6JpRrP5WoRrB9PjchiksT9g+n6I964pve9VWN3Jtn+MIH8qU4j6T
         FJD1H7JuEFJKcLCK2teYAg7ODtU4z6PAewfdzNyGkrbFJiePG0k/EB0NjqOoegGsDU6c
         2uxH6DcRnO/Hf5lwrhNuVpmioZXDF1JxhEKy0FE3XB77i8V7HCmD8+XR1aL0t0+0Cd9E
         ZdV26RtIgXXrW7v+TLqD2wx9uFwlthaJf++Vom9264olcL+g6bkVTj9+ikYkUdu0JCIX
         jXvw==
X-Forwarded-Encrypted: i=1; AFNElJ+XIGR3Z3abpRibF4wFiSbk3+g7oe3RlZeuRyV8yguzUbNSApibDa53xMJ3T6wOM5A1E4pcmwMQaAfT3M4f9KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFNymWdsh8rOEZj7owdpQ2eZM8n4QGnw8E1nK5+ahT/arGUjAC
	p3VgJ/pbXv3jPaXCHpr+BBM19cGbP9T2IDz9bU0wUypyKg4yMrtz/Nl1XkyZQVaZ84JDFiI+KOi
	eWQLSOJqJEnTGYxgR8qF7LYxPu8xq4YWR2uXWjNZ3LjVcwXvPvmNBXXL/PoMeX8RWuj915Js=
X-Gm-Gg: Acq92OHHQPwwWvuhnF3cMqUdC2qEi/auTyYznXI8GydIhjy08P0ZovWqewsTsIoWi0Y
	YB90dC7GI2J9EBlxO4vd6+db229INPffibpI6/INJ7b32h38nUQMphsxC0ZQxj2ocR9dhMnfgjO
	Vqj3sU3tyfTHHoqsZj0KoGAvu80LRXefMq78Rssa9opj5yp9SD0viUTbVfRygZFbLt0+5WUyVpg
	ppSWcpFiMoYsnwb9FV8chirI9MZcZMqtWLwNp+L0wCMEuRDf1Zlp5ayTK/zp6X4P8Jpk7EWAFEX
	xtAuOOiB3j35O18CqYHeg54DiyKmZA8ceFzukPLSzGFT81NSYT6kH2ScrRwRiizIZ9lOuNSNFCr
	nu17kCMmIxGVh3C+DOTS6zp8MukqEXAgx51l5X2eVC5J9afwiVAES6nkXTG2JdlSQyxkDxI7pWW
	WAarZ9klbG8yScGHNxlGuE3lnYws3p3uh6AC0nFQyUCvUTyw==
X-Received: by 2002:a05:6102:6b0a:b0:633:1fbe:79c8 with SMTP id ada2fe7eead31-6ff09f907c7mr7172136137.23.1780901969479;
        Sun, 07 Jun 2026 23:59:29 -0700 (PDT)
X-Received: by 2002:a05:6102:6b0a:b0:633:1fbe:79c8 with SMTP id ada2fe7eead31-6ff09f907c7mr7172103137.23.1780901969023;
        Sun, 07 Jun 2026 23:59:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed789sm3638621e87.3.2026.06.07.23.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:59:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 09:59:19 +0300
Subject: [PATCH v2 1/7] PCI: qcom: fix parsing of PERST# in the legacy case
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-sm8350-wifi-v2-1-efb68f1ff04c@oss.qualcomm.com>
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
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3338;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=h4yLRvqGyQTl6OR0GngMd/YRroUj4EhJo0XPHba7d0Q=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5ZahpdkIc/m2AU14Tot6u730x8n+R6Ny+q0YatY9z5p0
 4SPgmydjMYsDIxcDLJiiiw+BS1TYzYlh33YMbUeZhArE8gUBi5OAZjIrDccDH1i8QtkmXQ2xZTW
 b1zltt7i/P81d0XO/4gTdw1jO/yv2Uo0IWb22yesSzpb/83cH7cxnOm6xv6KoCURiq+6AmQ36/S
 77q+1fONfHV9zeMKG647/DxsEB4evcv/7+0Bm789ttzXbM5a4zAzxP1eQtEfWS/Pm+m9TX2j2fW
 eOrzE/5/Tg50/m3sk7MiSy/0jcvuAY/ODdnxhT8e4ZPUeZVsgmyb+9/OiI/UuJ0CphjZwNM9zEZ
 0fVpL61rNm7/HSlRJJhZVvRffZ19dt/rN6ZMqnlg/Fjtb7jTzncP7ftlmlnnf7ZVdjd7PznrO/L
 fDzMej0lEl7+ycgTU/dn5OUIMZodpsfIOS9N1XB322FNAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=cvmrVV4i c=1 sm=1 tr=0 ts=6a266852 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=A_p6hzaB3oH8elZwPmwA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfX1KnO/75d6904
 cYjBRXsfDCH0bstEMcIq3IsF+q/yugkgr/y4S2t7Gjw9ZiW5zJiez5P5lJecPJEnWBSthE17qlU
 zor59r7bCxbqizTAs8cmgHFxJZRKt+1f1srC9TPfPEwMB9CQxb0sDPpQkCKMyJf2XPYG6+EEQGy
 N0qz1EP6G10cSo4UwAKrAzi3jB4MKzg1CNp/HXu01V6kRrYgNuPq4kKglOYs0sX8qPd/ycSsQum
 w7YT0VB+Ejb6xFcEqMCltNfNoAU8VwjtVt3C0NHMJa2Btb63owEW3Z78EvMRIbkC2Pk4SEfNI1w
 J31fpM/ufRzbcrLF3hwpJJbQ4qYGs9xWxttQnQZDpXN8oAcbauHe+nad4LNTcUVEwXp1YxdF+Aa
 AYA3V8JcP/3HNPhr9D44Z7ueWVvsO+G7le2dRRnA2jXUUma53nwK4ov6CQ0fjnZaZ/WDip+dtA9
 7h8AXgdVxsLHLV0h5rg==
X-Proofpoint-GUID: _DCKfY_X05Zgk7UdTWuCEX8GhDS1bpSN
X-Proofpoint-ORIG-GUID: _DCKfY_X05Zgk7UdTWuCEX8GhDS1bpSN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062

Commit deed8aec62dc ("PCI: qcom: Handle mixed PERST#/PHY DT
configuration") fixed support for the "mixed" platforms which declare
PERST# pin the RC node and the PHY in the RP node, however it also broke
support for a majority of existing platforms, which declare both PERST#
and PHY in the RC node, because now PERST# is first acquired in
qcom_pcie_parse_ports(), which then returns -ENODEV (as there are no
PHYs in the RP nodes). Later qcom_pcie_parse_legacy_binding() tries to
acquire the PERST# GPIO again and fails with -EBUSY (as the GPIO has
already been requested).

Move parsing of RC's perst-gpios to qcom_pcie_probe(), making it obvious
that it's shared for both cases and skip parsing it in both functions.

Fixes: deed8aec62dc ("PCI: qcom: Handle mixed PERST#/PHY DT configuration")
Closes: https://lore.kernel.org/r/gieaybsg2ckxpctvqj77nlwu7utama2yeyvebkonmexsxrra3v@v3fobqasxnmy/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 11fc60489892..7664c7c28c0e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1907,15 +1907,6 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 	struct device *dev = pcie->pci->dev;
 	int ret = -ENODEV;
 
-	if (of_find_property(dev->of_node, "perst-gpios", NULL)) {
-		pcie->reset = devm_gpiod_get_optional(dev, "perst",
-						      GPIOD_OUT_HIGH);
-		if (IS_ERR(pcie->reset))
-			return PTR_ERR(pcie->reset);
-
-		dev_warn(dev, "Reusing PERST# from Root Complex node. DT needs to be fixed!\n");
-	}
-
 	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
 		if (!of_node_is_type(of_port, "pci"))
 			continue;
@@ -1942,7 +1933,6 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	struct device *dev = pcie->pci->dev;
 	struct qcom_pcie_perst *perst;
 	struct qcom_pcie_port *port;
-	struct gpio_desc *reset;
 	struct phy *phy;
 	int ret;
 
@@ -1950,10 +1940,6 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 
-	reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
-	if (IS_ERR(reset))
-		return PTR_ERR(reset);
-
 	ret = phy_init(phy);
 	if (ret)
 		return ret;
@@ -1970,7 +1956,7 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	INIT_LIST_HEAD(&port->list);
 	list_add_tail(&port->list, &pcie->ports);
 
-	perst->desc = reset;
+	perst->desc = pcie->reset;
 	INIT_LIST_HEAD(&port->perst);
 	INIT_LIST_HEAD(&perst->list);
 	list_add_tail(&perst->list, &port->perst);
@@ -2107,6 +2093,15 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pp->ops = &qcom_pcie_dw_ops;
 
+	if (of_find_property(dev->of_node, "perst-gpios", NULL)) {
+		pcie->reset = devm_gpiod_get_optional(dev, "perst",
+						      GPIOD_OUT_HIGH);
+		if (IS_ERR(pcie->reset))
+			return PTR_ERR(pcie->reset);
+
+		dev_warn(dev, "Reusing PERST# from Root Complex node. DT needs to be updated!\n");
+	}
+
 	ret = qcom_pcie_parse_ports(pcie);
 	if (ret) {
 		if (ret != -ENODEV) {

-- 
2.47.3

