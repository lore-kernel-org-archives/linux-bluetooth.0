Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442178;
	b=YF57RLnIp9KgNLsLJzEnKTXaMF2ZUo0T8ugqckP/ThSFeOwqpw/4T5ZHYTxavJ2m3Kvq
	 OI47z8S8YBze8nrjcg7cEgyaFwVYUpn1dljNO6MMWlmCZ3QUkDarHuYt2vcHAU+mKLY++
	 Chae3/GMxvAZ/6khhQ2ST4hf5Dq2iGMUl8Il3ZLPfkBo/uYsU7t8TYFTpCf+uaUjm6qNw
	 wIZau2bnEZ9cOYqIl/NVWjY32N/Vh6OEm3tmD5iOpUW+sYGyEgRegkkkniCbSpq2WZg8k
	 C076nw6QVxJZQ0QjrcMwfYO+faPUEA3KCgfmNXtoaGC578d/R+Xjx7qGFKOJ+SasfAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442178;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FamTb8O82PGX5MnAB27xX0tRtVKJz3smuGoSmmc0v10=;
	b=DE0ir9I1B19HlwAqKCreL52tyrDF7roVg287EsjO/9sBTGey2cZil2r/6kVlLdX9aC9P
	 J/U34ONlw0uQysLKpmNxj2o8/sBnraXFthJ3Tz/JDNaHNHjXDpP0WYWgMsN4nmSLfZD1Z
	 8E5D11DrFqSPH9YtrrqywVBdNST4JXWF9TUkZvWz/H+qVZA8WipYvXvrVrgCDat+K/NEd
	 dsc3eY20o9TsdOuBMVrRqyAr6PhpblHcCs62PR6zc3UwE50oz79gTM4Eg8iGmQvnHn0Pj
	 yMBY7Sra2O7d9i9FpjeYS5+nEjuOLRYQ7obtiGp4hXLpJF+wTNVX7UyiXoIf5oWCMKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YWRyANkg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=InFUBf6t;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B3606A6BE
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 13:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E23B3606A6BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YWRyANkg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=InFUBf6t
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDLFrL4030419
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 13:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FamTb8O82PGX5MnAB27xX0tRtVKJz3smuGoSmmc0v10=; b=YWRyANkgd+upY9eN
	x8GYfyuWfYQNwlVOeyYaisbNxgEm7+4kDzlWs3+ljIdpEXcfNpfQGVAL3nDVaE7E
	DqlNrig6WW7QYXvCxB7uJqS2lvq9+CMiLP60JvassDtV0jcivDxciNgZqqJSletX
	Fi6rmOErx3+nMHPdHtvG2IWQJWWkY+AEvqprPOeAPe4t+xgQRwOHJG02H61ujdLg
	csPhpP69yqRQRlbIaiGlPGqS2AA4mxAWW5Cbxy1YIuMO9ACDFYP9L6hVeTibn53l
	YdIffD6gaJ09cVfAU5zNevjBRbNSdXkSp9EsKj09ZbMINMbhhxmeN3Y1Q78p/tX/
	xc/tsQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4evshv7c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 13:56:16 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-92104826f9bso67461346d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 05:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795442176; x=1796046976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FamTb8O82PGX5MnAB27xX0tRtVKJz3smuGoSmmc0v10=;
        b=InFUBf6trzgIwBCnPI5YKA1Rv1Yi19wUes4p2rqeSsdb8KXhQc06JbHCDHDRwWu74B
         ZgBHg57GfioDTCiI+BxJQJ0cQxmDsghjK6KxtuPUQCSR3PiCc3lN8lv6JAbp3H5gBRTM
         g1cpvuLD4E4vPDxhbPpeshsFnbilA68N66mJn3SpjaqzSP9LdVFtlzi9OBoiGpR3CqVb
         JvkZAv8q1GZntudzAsyiC6/IiXWsnNA4XHkujJwYjkWnMFsPSdchvGhWRKoxXep01wEx
         rPLVSr4UONQL1sR6+yuYvZu+sn7wb9DoWrrErf7KKb7cs6gEtg5DS2TVVIKee/HxmDat
         /AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442176; x=1796046976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FamTb8O82PGX5MnAB27xX0tRtVKJz3smuGoSmmc0v10=;
        b=2pXZrmcFqJwyV8BfGY6Paq09zej3k70tjGCjglzpVm3nQrD2nH3DRZlGEC9UHkOFTc
         sVTqwwQN0eG44vDVcbvoQK3gsOluQEEcM4ZvgzMfsUxHr6o0zE1f/Ju5hbGlrof1CWxJ
         tcqydmTo14YUy5kMtdnyMcF8a++5sVkphtZhDz6RhBh2nyU7Dacgar8Myh/E4p+HZ/Ju
         5Pua57W876MuTXH7jPLftzuoA6Q5CKcfbwf6kEwV1cb10fiXQ3ApmLnKG1aF5wgaWH8D
         gYHpKLq/LliGU/lm/1pvELQ0WWSHYM37tDHKAWcCGme5x2ugGFAyes+ispRpJPbHv6ga
         5a8w==
X-Forwarded-Encrypted: i=1; AL+hErHRWqa86Dp3UrWBgXcg79g4dSxCyyMyHyagSMbfcXqPFNJMamT0yPaOlppgN7JNCUeuxuzA03FHU5DMtoKJMf0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+6fCrJWbtCpGPbc38sxmKdX/yvsRgUVoaXLCeuIZxtZTYZdHq
	QlzYdmYqEiktwdQLOW1lTkyisnfKBMQwUcuWupcNJdbv0IwvcUjWU7jBU+ZIwFCGT6P/ABg+YY8
	YucxgmB5Hixqq1sbH2V+af+MRQL1ofqlS9b3BWfyjZ5EbA+/GXHhDSbBMirpvuBGRNSYcxWI=
X-Gm-Gg: AZFdTZfhe0ZMUUlNRkjrX1iixmKv7OIXugPSZ5Cfj/5xEru5IZUTwG19ZVksMu/xnx7
	oAiEqWa1KrXQ4jT8dtQmMTwzYjS2A5yk2Ibk+5dpBX+PrEuYbFTyGduSG3q58aJHJXlfLJM2ahV
	LJOPyfoYiTEnpM5K7bzI3uTODGnPRU9l72C78mQfxpVOIhZIeeCk1pI5U5YQqu++wief3TTvc6R
	DgSSgjGdzah9/3NZqdWTdz0MB9ooBBcD+ntvUj9AeSgKZJ9s5QxtxHyMnsKVvkyY6VarQxAmfkP
	73Z+uPpkksIqqTZCt9n/eLbjEsxANYEHegI6hiZ9pgjOW6k4heEkr04Et/NchbQpRtBwdw7NwwB
	QLpx6acBFMEUd830uUanH1RaQwUkZWVDKbSU7gYPjHURV7BtTmXm/tQ4nI1GIkOOum4Cu0qipks
	zSF8ftd63EoKzh5HLfNVKtTZHnzAtiu1jJAkPqgNTaQA3xWwUU/mP4kQVcidw2WIOYXqgFedyou
	fWpi9U1D8LkrGpo6xpyocKms4Qf
X-Received: by 2002:a05:620a:45a2:b0:946:2a0:a11b with SMTP id af79cd13be357-949ba9cddeamr1951679685a.35.1795442176140;
        Mon, 23 Nov 2026 05:56:16 -0800 (PST)
X-Received: by 2002:a05:620a:45a2:b0:946:2a0:a11b with SMTP id af79cd13be357-949ba9cddeamr1951672085a.35.1795442175472;
        Mon, 23 Nov 2026 05:56:15 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm21724625f8f.56.2026.11.23.05.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:14 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:56:09 +0100
Subject: [PATCH v9 2/8] Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to
 'bt_en_available'
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
Message-Id: <20261123-monza-wireless-v9-2-450d7d764aea@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=AL9GXjHq c=1 sm=1 tr=0 ts=6b044600 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=I95fhSNaEobLycDSJJAA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: tXN8soxUpJsL6mJxHGvTX6A1x7w8eOAs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX2gFnXx10ShoQ
 MVzemYUbtJQzmOE83suGmIV11M4sgSQ2Bl/n52PdFBlZoQxeKaXuAitzMjV0t6Ps7Xx7fiZSpYV
 24wgrnHg/JUY8mXsmhsGgMJVijaWpBsexKa4tMs9A4IwnxBURQRW9VcJM2wp3jDJ4kz2Ed6i1g1
 4Tw3PJ+6Kn0IWtut+tU1T9SxW88n2TUZ8Lzdi8rbOfX37UCpgzVh4trJghoPf+TdgT3OGZzqJQU
 OtQ34ZvU9cY9jnsZCBEaEnSNMsJUqOiZYGEcrLzUEVjERe1R1VRbysnileXZpYkfTczMZRnQpn7
 TX/Fomx/bOifC4ynyplxpazCG2PIY8g0yNyMDnzTM2uR8et63EeOoqW9HNu61+6LKePb3OuF7eS
 l4qeLIt7QqDMSP7xlbKIiRQYIiN41b/pthLyh5BApoSwUG0yr7R7+KI6Y4CJCdTjGnXrvCLCG10
 WE0Nnf4WqARUl+la4Iw==
X-Proofpoint-GUID: tXN8soxUpJsL6mJxHGvTX6A1x7w8eOAs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX5iU7tyddUWkE
 kOuP4rYcqLsaP4/lwcetRDo2wWhh+i8JZUFHV+PEerkOHzip+07iucKd61EJr0G7ncg/1upFdKZ
 ficL7a23XduIEddypREZwL2Y/Ifefgs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230055

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

'power_ctrl_enabled' flag is used to indicate the availability of the BT_EN
GPIO in devicetree. But the naming causes confusion with the new pwrctrl
framework.

So rename it to 'bt_en_available' to make it clear and explicit.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Tested-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c4e42c9542adaddee17e256eb017902ef565025f..5544dff9d10b5064797d41294b126fbc229a8dd5 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2477,7 +2477,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	struct hci_dev *hdev;
 	const struct qca_device_data *data;
 	int err;
-	bool power_ctrl_enabled = true;
+	bool bt_en_available = true;
 
 	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
 	if (!qcadev)
@@ -2584,7 +2584,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		     data->soc_type == QCA_QCA2066 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
@@ -2623,7 +2623,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 
 		if (!qcadev->bt_en)
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->susclk = devm_clk_get_optional_enabled_with_rate(
 					&serdev->dev, NULL, SUSCLK_RATE_32KHZ);
@@ -2641,7 +2641,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	hdev = qcadev->serdev_hu.hdev;
 
-	if (power_ctrl_enabled) {
+	if (bt_en_available) {
 		hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
 		hdev->shutdown = qca_hci_shutdown;
 	}

-- 
2.34.1

