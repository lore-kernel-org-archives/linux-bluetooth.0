Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302989;
	b=TjdLJ6yD4fZK5ScGUanR74edYRQafL2RSj8exFokb0FWvEvagtnUv4VJ0Q2nQ2KOnHw8
	 peqKWc9LReFAeFbkGv2ff3wtvLgysIiqnTUTryrw3eqfeUJuwlSCpw7xq2WNysQ1KZATT
	 WYhBAbNZtNA5jbgwn/lrK5y5oDY2BGk9DgVUA716lEKnmkMkURpmFM1YPEGbKFuKHLeiP
	 6gohPjYUY+5x1scoRfUtzCfRD06VxQlhzxhm7yoQ6/C2GJpFlDCqeDfS+ZNRmm3apdt9K
	 qWMIMle4nk45Q2fzlIf98deqw67nWe99JbGY0RimEFlzQ05QQr3kfTmbESZQLFmL+RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302989;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YVzuWx8WYyPhmFI1joxXWmLbuIsYUUi9VFmfyt+SKLw=;
	b=S+SkV7SGOOO6eCI3dG+/WgEb+A5jaaye/lAi3lVIdwEjFKwCohZJDnIu8wkueTWlv3Xl
	 4EOKTbGiACZ7QhnqL5VTs4f22oPmmRnF+HvPXWosPdEEvejSTIkLQhdYmKSjysHVGzbh1
	 JsoLIRVBG2X/e2a2vnwYl21oxVuHCpdmKj5R4ofScaIXOHWCMI1obB53iUesjL+H56dQ8
	 UPmnAGh8zadA8oWe58MdfgPciz34TYfvUpESangVWb3AVS1EHoWVwgyRbUTOEavcqW3gb
	 7R++6NRstgrPv2Ea1Rb4KPa7dELNTJ9D5YEsd7jKSA70jku05K4ZgU4kZg8/SkrzozQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="nqFFID/j";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36250607611A;
	Tue, 10 Nov 2026 09:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36250607611A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nqFFID/j
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7klnA2779819;
	Tue, 10 Nov 2026 09:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YVzuWx8WYyP
	hmFI1joxXWmLbuIsYUUi9VFmfyt+SKLw=; b=nqFFID/jFPeA7gfkOcvUdnW8D4P
	dfasuAb3FUxdgIpfKRdQgNWoKz8kQOm+487ioJVKSa26h6Hwbin1NNUwLFDqpdAn
	q1hG7TG+clY4E6aneBr9JEvHVafmmcr3bctLUmBESc1yCt2jASTnop6Ff3UMxQEr
	VY7uWs3uz0Bg/VTKCh6rpp6M5YDyq09PriHogaM9Itg0KwXwPsKDdawvcSBvYiSB
	ZRR6ww5fPPEnVSVVBvJMHP8PN+Y5vwzxujPmfsnuCbbaRtiQMmJSJhFzOSJlXsTI
	2yEinLsdkmPejtnmd4tJJ2qKwONGoEqCQMFQ8zWZKtTaQc/sPp2OWneVncw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huy5d8daj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 09:29:39 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA9TaZJ630884;
	Tue, 10 Nov 2026 09:29:36 GMT
Received: from shuaz-gv.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AA9TabD630863
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 09:29:36 +0000 (GMT)
Received: by shuaz-gv.ap.qualcomm.com (Postfix, from userid 4467449)
	id DEC2268C; Tue, 10 Nov 2026 17:29:34 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Subject: [PATCH v4 1/2] Bluetooth: hci_qca: Reopen the UART after enabling QCA2066
Date: Tue, 10 Nov 2026 17:29:28 +0800
Message-Id: <20261110092929.234617-2-shuai.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110092929.234617-1-shuai.zhang@oss.qualcomm.com>
References: <20261110092929.234617-1-shuai.zhang@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: bufru4jzfj_nO-2yzimZ6ip5ziJomJvN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfXwD4dcjhIDjsu
 xP33TC+sUxr+07g4aD7HDHmXBgveWfOipfQ/IJCm+mtxmJcYpv3D2KwXMmNURJZXmcBZ8e5PV6r
 J++iirQZOugtzek1Ax4W/8vZG69eddo=
X-Authority-Analysis: v=2.4 cv=d+9gWhjE c=1 sm=1 tr=0 ts=6af2e403 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=gFUO3AakNH-SXEmCh1EA:9
X-Proofpoint-ORIG-GUID: bufru4jzfj_nO-2yzimZ6ip5ziJomJvN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfXyvf8cw5K6miR
 WfS+g7/40WWBazk9RlnIsQFb4CyisefR28TUCtOC9Fsb+w8VHVOJtyZbVgWJWoJpA891i2CVTqC
 /3L8PSG4iY9EVKs8GpUxUFyDERxc4Oko8j08Igqq1h5V3YVAi/ffy8HYuuzw+v6caJE9aHmzLF/
 n9bMLGxOlzsl/g4eMVPrhNCJLrwXAHY7Sgzr3C6cAyKzEYpaTiu/YysV8ayZPjWkoop8Er/We2T
 18KiSWrdNQCjcgQVj4xEBvW/BXc/UC0NcbNykQgCecrjQQELl55YHwfiRDKxvbgYIUz5sg3vnHh
 qA2SjQZn+MTIS1979Q9bgqxY/Imv2qhbC8H8w5bOV9bztp1AmGfocBX1QSbr47p0OCVRwt0OjL9
 r2Ia7ppyBptvBRHEuz13bVkNHBZ49DACe0cf8u7WLh7jeWhjzyx79Uam6H7wwVYZufzi8CQY998
 224RQeIQZEdb7vkKE1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100037

QCA2066 does not reopen the UART after the controller is enabled, which
causes RX/TX out-of-sync errors. The UART has to be reopened once the
controller is powered on.

qca_regulator_init() already enables the controller and then reopens the
UART, but QCA2066 does not go through it. QCA2066 was added with its own
SoC type and handled in the default case.

Let QCA2066 go through qca_regulator_init() as well, and handle it in the
other places that check the SoC type in the same way. This also applies
the baudrate switching, flow control, shutdown and probe handling of
those chips to QCA2066. btqca.c checks the SoC type in the same way, so
the firmware version is also shown in the log.

Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c   |  1 +
 drivers/bluetooth/hci_qca.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 60735b70d..9f54e33e4 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -983,6 +983,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	switch (soc_type) {
 	case QCA_WCN3991:
 	case QCA_WCN6750:
+	case QCA_QCA2066:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 		/* get fw build info */
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 7089e9b63..520cb84a1 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1381,6 +1381,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	case QCA_WCN3991:
 	case QCA_WCN3998:
 	case QCA_WCN6750:
+	case QCA_QCA2066:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 		usleep_range(1000, 10000);
@@ -1468,6 +1469,7 @@ static int qca_check_speeds(struct hci_uart *hu)
 	case QCA_WCN3991:
 	case QCA_WCN3998:
 	case QCA_WCN6750:
+	case QCA_QCA2066:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 		if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
@@ -1511,6 +1513,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		case QCA_WCN3991:
 		case QCA_WCN3998:
 		case QCA_WCN6750:
+		case QCA_QCA2066:
 		case QCA_WCN6855:
 		case QCA_WCN7850:
 			hci_uart_set_flow_control(hu, true);
@@ -1546,6 +1549,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		case QCA_WCN3991:
 		case QCA_WCN3998:
 		case QCA_WCN6750:
+		case QCA_QCA2066:
 		case QCA_WCN6855:
 		case QCA_WCN7850:
 			hci_uart_set_flow_control(hu, false);
@@ -1862,6 +1866,7 @@ static int qca_power_on(struct hci_dev *hdev)
 	case QCA_WCN3991:
 	case QCA_WCN3998:
 	case QCA_WCN6750:
+	case QCA_QCA2066:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 		ret = qca_regulator_init(hu);
@@ -1984,6 +1989,7 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN3991:
 	case QCA_WCN3998:
 	case QCA_WCN6750:
+	case QCA_QCA2066:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 		if (qcadev && qcadev->bdaddr_property_broken)
@@ -2017,6 +2023,7 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN3991:
 	case QCA_WCN3998:
 	case QCA_WCN6750:
+	case QCA_QCA2066:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 		break;
@@ -2279,6 +2286,7 @@ static void qca_power_off(struct hci_uart *hu)
 		break;
 
 	case QCA_WCN6750:
+	case QCA_QCA2066:
 	case QCA_WCN6855:
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
 		msleep(100);
@@ -2433,6 +2441,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN3991:
 	case QCA_WCN3998:
 	case QCA_WCN6750:
+	case QCA_QCA2066:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 		qcadev->bt_power = devm_kzalloc(&serdev->dev,
@@ -2452,6 +2461,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN3991:
 	case QCA_WCN3998:
 	case QCA_WCN6750:
+	case QCA_QCA2066:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
@@ -2495,6 +2505,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		if (!qcadev->bt_en &&
 		    (data->soc_type == QCA_WCN6750 ||
+		     data->soc_type == QCA_QCA2066 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
 			power_ctrl_enabled = false;
@@ -2503,6 +2514,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 					       GPIOD_IN);
 		if (IS_ERR(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
+		     data->soc_type == QCA_QCA2066 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850)) {
 			dev_err(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
@@ -2587,6 +2599,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	case QCA_WCN3991:
 	case QCA_WCN3998:
 	case QCA_WCN6750:
+	case QCA_QCA2066:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 		if (power->vregs_on)
-- 
2.34.1

