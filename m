Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429541;
	b=H/1oz7srRft1mmsYJwuMjGpJNfs33xaKnKHtrrquBsbMadtB1U/x8PV/dppQHuea1Ny+
	 wdCi1OfaKmnzwq4tPMGLM+RAD2QrjeE0fUElDtmi63hUeQEuryJABsvennfmDPU++IucE
	 loWsG1s3ACJHJjfykDgCmQyyZGucKeXy6pfo/a2e6rC8F6Lyfj58aSpjFxy/3U71IADV6
	 NrLxrToHVnL0Wgdjo5rSqjGhHbdWzMASH8auOn04jA+IbfIrUZIo4S1Wrmp6Bn2PgD6zk
	 +u14EL+yS0JhD0C03/4F08FJU4qZIH6z5cRTyFPGNlS9Fi5wvwcrn/uVv95lIdd+e+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429541;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=N2e8ps4JJNpepcw0ywOkVKQ7w3/5wYw/tpOQprpCQl0=;
	b=Dv3ARgDIkjHnhIqoIqep9eQGMmy1Unnn+zGRijAdX4qTTsQZRLr71cju4szHbYG/GGT0
	 KuQW1jSMK/lqo7HLTEkR6hwyorWeK+71cHRvQ3R9+5NKon8y9Cpu8CgcX63eyONqb+qnY
	 Ji83pEXvUcsEZQpnuduLFM8oLzSZudmFD70uz79xGx1QIgaMkhK1428gS2nAqE0nuzeFn
	 ghwgwW0Vvl2Vtax+DELlSyuRQr9sKt55DJxPwB5VaPx34bvPs6V4ju2S/iIoXoARWpXAj
	 tdYo4ce1gZR/rWimr86vlWV3j6rYVAWpH8u1khEa89K1K8Eg4QU3wL2ZSlYuOscu4oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="K/ne0YAD";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A9+YkpNs;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4163B606A699
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4163B606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K/ne0YAD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A9+YkpNs
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9FxIl917180
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N2e8ps4JJNpepcw0ywOkVKQ7w3/5wYw/tpOQprpCQl0=; b=K/ne0YADjHipBOMZ
	09MFX+mU3kfu5RkHbTmdid8Lg6K4HetP/hxZXxzAuPi4W0dRY3DLa7rsZmLR2ERE
	a8uF5xkNBbxMMK/Jwy1c6ckjbi8rs4UjrAo4KCmaE/DiPcnL9wSPn257fTWot4SI
	5/H1Q3xOG3EroJMiTnHkXLmk3iZlrB/3z4OhdCtcWHGgR2Nvd8gOu7mAP7U+CDzk
	xqgJyUYBreB3Mdz9zxBhPSmyVPVEGcDQMJYRSrLC7o/xNVNwljkro9ybdVOlBaPu
	agB08qKosIZITVjww1BLG5pwGeyDbSyX30JfbARFcH7OjRdlXSK7YPrKSJRWJ7a5
	dA2wWQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g9a0v7f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:25:40 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-9213237a52eso60311486d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 02:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795429539; x=1796034339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2e8ps4JJNpepcw0ywOkVKQ7w3/5wYw/tpOQprpCQl0=;
        b=A9+YkpNsoC5tGy5F4RyLdncegq3f6j8Wtu/1c9fIjO0jpd/WQEUTshjWo24WaVlUsv
         e8lhj7aBBQOaazwWMPAF5tFkahC33fcETXdP74KIRgw0mk8u8KQ98JV/Lyr9z5CB7nPX
         yTQdp2xAb1LNLhxmZ7jrGlt9rIXfhWriFJVgUS+6Fo7i5tM/Ut1NkzEDp+XxC7DS6Arq
         JxKMCg67XfBifxRDI2ieq4dMwBTQ4WSOXoRh8kMeS+l5UPPCp8CBZUNx/T29xeFkBXJz
         jDQt+EOpEJqmwOYHIIfShibbLr6cjAFjLDx9nd2ooopIglcHB/ujKYr5PBj/po8NKovV
         T+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429539; x=1796034339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2e8ps4JJNpepcw0ywOkVKQ7w3/5wYw/tpOQprpCQl0=;
        b=RkzIPjMAZPAtPLGYniE+mu6mzHnsfQaTTJNPik/pSVeReZvgxVfE49jWx6RLlGg1gy
         cSIXWFGUppSgcPGnur+5vKqTPUHZtUhWO6ROP4YUFMNOx5w131WDi0BKH2LTkJrYtDPE
         zD8rgfdsmMVwdkUgpLEtUMRTqf5IES4KLNdHYlOfYWkcxZSJdZi6YqPO5nDv3UAoC0lB
         0XV8SK+8q2vJ/HaA3xJASnGe7YCb+izZLoSuV5FNvlcXInryIdkfJ5hgbOt7PX2c0oZw
         +fTYaaQHKEURCSRa1FNaz+sJSV+Lw8N9cvoQHMYnRr5CxyUNX1ljxCMt4Bf/c3O6fhcJ
         VK3g==
X-Forwarded-Encrypted: i=1; AL+hErFzQLMZCGL+8FFX+jP1yzqOinmv4addm55ZAyHZ+VG4mtj48vqwMqftzBwHYrD5WhytgvThDJW9b/FHbCpXNtc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3/5aaOPzZ4RnSBGXi+oDJmNL1j33qZD+BL7ArM6qwzVfy5VKI
	po/4cwd3ie1/9/fsLfEN6kcSwdwM8tLis9/l6WabSENPBIP27K9n77WSoZqvkCnCJn6oAyLf6if
	aj+NKyoVSmIsreiPgIVUibr1fHIUUwWvSA+kv37zHoZhuYRHngvi5yvfoo6Q8+lPv0PJmRZA=
X-Gm-Gg: AZFdTZebD4ZVlN0gOAW2jHHjxMiUZ6ZgnRqQCBOuKVb3dApF4jAqSYkwlZFAb5tOMs1
	WZuMnnv1xEUvftfc9hJtCW3Nye/9Myj8lsQ3nMANQwBSwBtOrM0eytZF2wgan0mbWW2kcu2oTA2
	k4XMPVYnM5fmyyuaHvQ8Eap1Xv3IFSlmPRtx/XSLMyxZAEGILap7Cnxb1dSUYBtcXbYQYvOMG4v
	R8ozcjk51nj30bvXNypldrRhVYrwwKxWV9V9ebF+/UgSx7CTHiloBBrLd4VhQqVoK5OXiHQwwEl
	UfqhxZXI3RG09bPAfe+XfFerLhrejQj8fwLhfTfVCc9S1FrkRfXs0hLQ7rc7UDdtApORQCvgY7r
	Y7Ao0reZBdtgMM252PC0hfkwkX2b3BJqssZPe6MR+EN9jYelbCxDC7DoKH+4yqGlR7fgBw1R9K9
	TaLZFfuvvO7/py8+hcNP5cpIuC2cHgfXalWWtEj4nIXnbPOfNhFLAalt9D/oyYbZsNmX0jB2wfg
	t+FNfghb+NLCWJRo3JHahXdbIrE
X-Received: by 2002:a05:620a:2856:b0:949:873d:3dbf with SMTP id af79cd13be357-949bab58cebmr1771948185a.59.1795429539525;
        Mon, 23 Nov 2026 02:25:39 -0800 (PST)
X-Received: by 2002:a05:620a:2856:b0:949:873d:3dbf with SMTP id af79cd13be357-949bab58cebmr1771945485a.59.1795429539029;
        Mon, 23 Nov 2026 02:25:39 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:58b4:dc38:81d5:3c3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm634166845e9.4.2026.11.23.02.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:25:38 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:25:33 +0100
Subject: [PATCH v8 2/8] Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to
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
Message-Id: <20261123-monza-wireless-v8-2-a8b38604be6c@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX5JmcDsiNbLCX
 zzQaeB3UX0EkO7jLK1HH59JgAyMnMKpBJt/Zpm7UjyqVZBy6of8HJyfdZsJIhfKnFu5sqm0eUku
 Lh7vST1booIk0YsRGo/TdPe3U8MbvgE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX6HZnrY0c4F8D
 LlVLu5c5w382JDEPq2so9t17mavu3iUW+NiSclU2Eie510MQfqGWVzogE030L8rMHSOOQFlgnLa
 D3F64umQz4hrAPAMFT39Hkga5sp4+mn7oj5gGTDYiPpIiQWr0f6TCJxxds9zYepJLcCgqSYsWM5
 hUSrLAMPxfvwLIcQhlFLiIGqImtW+o0IWTX6Zc6CK4CkxfDIx6kTZH4J1nBThZPq4vdp0Yzm1jI
 aB/LDdRgqtffjt8wSZOFECHvpkNLUq1HSkemfyRrK9HMwJQysXgpdvk8qHIcEywtZFPqZZZdo/A
 jBVcYgFLwUA1hRZZ0zrdczlitCBk2gk6n8unyYBwRfCDu8FnSZ2Puz2/yxof2m8+ev3eU3A81Y7
 cpDmMcc+sL+haj2wAV1p/aHGnpp08A7kIO389wRkNY58REPRHAXdp+3hXEupDOdOK30ie2kY1ns
 dM4lX1sL2vmlbZDW9eQ==
X-Proofpoint-ORIG-GUID: clu-9ON2xiozCMDuUyfWSFJqMM_6LDAD
X-Authority-Analysis: v=2.4 cv=cYJHPXDM c=1 sm=1 tr=0 ts=6b0414a4 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=wYtw_XDhO1ghKZOGarAA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: clu-9ON2xiozCMDuUyfWSFJqMM_6LDAD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230041

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
index 998796ea618822298d7f956a00c6c50f14332363..3b2792a3639cfbd9ee7a781b6e4c26c660495391 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2477,7 +2477,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	struct hci_dev *hdev;
 	const struct qca_device_data *data;
 	int err;
-	bool power_ctrl_enabled = true;
+	bool bt_en_available = true;
 
 	qcadev = devm_kzalloc_obj(&serdev->dev, *qcadev);
 	if (!qcadev)
@@ -2583,7 +2583,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		     data->soc_type == QCA_QCA2066 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
@@ -2622,7 +2622,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 
 		if (!qcadev->bt_en)
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->susclk = devm_clk_get_optional_enabled_with_rate(
 					&serdev->dev, NULL, SUSCLK_RATE_32KHZ);
@@ -2640,7 +2640,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	hdev = qcadev->serdev_hu.hdev;
 
-	if (power_ctrl_enabled) {
+	if (bt_en_available) {
 		hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
 		hdev->shutdown = qca_hci_shutdown;
 	}

-- 
2.34.1

