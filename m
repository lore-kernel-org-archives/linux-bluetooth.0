Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302990;
	b=GDil15A6fnBtsQbSBTuFdmQ636Suip2mUJESFLyvs5Hov2Vroa1N0Zs0UodCAvQODey0
	 7UpRbjEut/6vIVD0i8vQ/EyaOQcSxBSsV97V0n88JZhZo4a/IUfYG2NXdg4KU+QD+OGyX
	 vRAoSj4tqyFzYwb0R2kfvaH4UPxfAtoLyFBXPky/BjRILkSR84xmzpOsuohR2MwgFVAZE
	 KYk/xu7eHTUyzstOrlQ6KsnIgW7uNh4AUC1JH5je5vsfSyzLoutIWhUx2t/AHFtdqyGnF
	 25TxpKAlIvcYJFR48JN26rmBPrXNyozu2fhnhglRqFL1mliZqlUnH5/AE9Lh+nzfyeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302990;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=j3o4ZqT6tHtgbiyC71TVOHOyZQ93mzFMTE1E2t9tRp0=;
	b=Tlpo6ytU5Z0UxmrUrKuq2rr45qpDtY7ijrO5s2ENXV5sP0HCaSxJvfF9wTWjGTSFmRYA
	 YnXeDKhIwYbC5oXDe1m1ff9yyr7QzgwHuBw3fPpgETTOkYHyxr5CodOty/MJr6emtektI
	 j2v6a0wtUE4vEYvTczEX1mDQZDoxF9nmJUtYJfHszLQ//J3Ps9IVBSxZRXXv9PYA0Extx
	 V6SrkIscuSNpVP+j2JY83KF9+eESP7Jl9DaAQlip90goSV8SRrGFkeAzNuxLOn8/BJCoi
	 XEhEdA2rgpll+W3fdyvmZO6yo5DemO+ko77fz3TT3pEVjDg7VikOYrtCDjj1dQ8pJHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=npJzgrd0;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F66607611F;
	Tue, 10 Nov 2026 09:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6F66607611F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=npJzgrd0
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7krAo2770421;
	Tue, 10 Nov 2026 09:29:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=j3o4ZqT6tHt
	gbiyC71TVOHOyZQ93mzFMTE1E2t9tRp0=; b=npJzgrd0TGlVIiZxkV3POhtbCbw
	zKi2vAZ4ZqN2U7K9CtyQwcuDEAiOj+zS6AYc2rz8SkfvyvV+54BRXeFz2G03ifBQ
	YEUaRpWaKed6PKAAnBSF5bV7GpcNekWMVEeGqvjTCkFOT8F8tGj2+3cN3yEakc/K
	E65Gs/zn/HsqflxKMuevd6jgStmInmV8OERx2lKaX2JMm5KDMr+6EnBhqRTXDwYm
	nMi71D5TsQnJ7kug6J4lN96glfue3gtH8UGoNQ7L99oxVdcZvBgub42YX0H+o9DF
	WIomo72/Tq9i83R6dlkF+34k4nL75QGouS5Sa1ZfHms10ib9Mk4G3Tj6QGQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huvtd9263-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 09:29:39 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA9TafF630883;
	Tue, 10 Nov 2026 09:29:36 GMT
Received: from shuaz-gv.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AA9Tars630864
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 09:29:36 +0000 (GMT)
Received: by shuaz-gv.ap.qualcomm.com (Postfix, from userid 4467449)
	id E1647B45; Tue, 10 Nov 2026 17:29:34 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v4 2/2] Bluetooth: hci_qca: Don't use the serdev port after a failed reopen
Date: Tue, 10 Nov 2026 17:29:29 +0800
Message-Id: <20261110092929.234617-3-shuai.zhang@oss.qualcomm.com>
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
X-Proofpoint-GUID: 76S2EX-FVNrIuqkp7PXIarl8MkEzTMIc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfX1dUiGr7Q3VaF
 SdspUJTcKeWV0lC7e3S+TFTw4YDWLDy/gks4rvWYccJDB2ptVNJrZNd2ZO6TRg1/S/9yAPu4wFN
 rzS/j/j1c0QtajDySN7i3zZqp+Yrc0M=
X-Proofpoint-ORIG-GUID: 76S2EX-FVNrIuqkp7PXIarl8MkEzTMIc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfX2KO+QauwGyHE
 R3BnKvPm/401ILwcSYXfU7QatYLQuIqGOVmyvNb+RyS7TO1p7ftxy3rcvXPULEJcuYEJb8cCFHw
 rn8MkiNBxZc7cXBEQHNr7Fw5MEa1GK2bhmcEwRk06ujof+cjAdVvhgtQvQ6c17qJmE97qit5DHd
 UiLVpTz5WMept38yYq98C1LfX4hN42+zWd5ucbyIdXLZLMZ6iic9TPW2FV/LOQEc0GC+d5/7Bt1
 5xWna6PvDZpClDKW9oy26zeOhyNODUhQS7SajY+Y6jKVZ9kKhsQug7VsE3tyHJMqiaUpZY0CelP
 lpZKvOY//zb3Ei0YeOLGLxeMdaKYlhCGwIy9ZZpQtBn6ecERerA9go06E0MjVobK9ljoGvBTPOP
 XSsDFV452u4kTKmcBwtugLoEUl9dVx1cXVf1APzO/6jM02C+kWh1Ws7WMuthle1x/ZfmaWcc1L/
 h1EjoCSg6d0/IrcT78Q==
X-Authority-Analysis: v=2.4 cv=ArR7T+9P c=1 sm=1 tr=0 ts=6af2e404 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=qrUvjq0tDwqUGgU7P1QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100037

If serdev_device_open() fails in qca_port_reopen(), qca_regulator_init()
or the qca_setup() retry path, the port is left closed but
HCI_UART_PROTO_READY stays set. The error reaches qca_setup(), whose
retry loop calls serdev_device_close() again, and hci_uart_close() or
hci_uart_unregister_device() close it once more later. The HCI core
also calls hci_uart_flush() from hci_dev_close_sync() before
hdev->close(), which writes to the closed port.

serdev_device_close() and serdev_device_write_flush() have no "not open"
check. ttyport_open() clears serport->tty when it fails, so both end up
passing NULL to the tty layer, and the runtime PM usage count is dropped
once too often.

Keep HCI_UART_PROTO_READY in sync with the port state in hci_qca: clear
it when the port is closed, set it only after a successful open, and
only call serdev_device_close() when it was set. hci_uart_open() already
treats the flag as "port is open" and reopens the port when it is
clear, so the next power on recovers. Make hci_uart_flush() skip the
port flush when the flag is clear, as it already does for the proto
flush.

Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c    | 33 +++++++++++++++++++++++++++------
 drivers/bluetooth/hci_serdev.c |  6 ++++--
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 520cb84a1..700ecc3a2 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1749,6 +1749,27 @@ static bool qca_wakeup(struct hci_dev *hdev)
 	return wakeup;
 }
 
+static void qca_port_close(struct hci_uart *hu)
+{
+	/* HCI_UART_PROTO_READY tracks whether the port is open, so a port
+	 * left closed by a failed qca_port_open() is not closed again by
+	 * hci_uart_close() or hci_uart_unregister_device().
+	 */
+	if (test_and_clear_bit(HCI_UART_PROTO_READY, &hu->flags))
+		serdev_device_close(hu->serdev);
+}
+
+static int qca_port_open(struct hci_uart *hu)
+{
+	int ret;
+
+	ret = serdev_device_open(hu->serdev);
+	if (!ret)
+		set_bit(HCI_UART_PROTO_READY, &hu->flags);
+
+	return ret;
+}
+
 static int qca_port_reopen(struct hci_uart *hu)
 {
 	int ret;
@@ -1758,8 +1779,8 @@ static int qca_port_reopen(struct hci_uart *hu)
 	 * Without this, we will have RTS and CTS synchronization
 	 * issues.
 	 */
-	serdev_device_close(hu->serdev);
-	ret = serdev_device_open(hu->serdev);
+	qca_port_close(hu);
+	ret = qca_port_open(hu);
 	if (ret) {
 		bt_dev_err(hu->hdev, "failed to open port");
 		return ret;
@@ -1783,12 +1804,12 @@ static int qca_regulator_init(struct hci_uart *hu)
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 
 	if (!qcadev->bt_power->vregs_on) {
-		serdev_device_close(hu->serdev);
+		qca_port_close(hu);
 		ret = qca_regulator_enable(qcadev);
 		if (ret)
 			return ret;
 
-		ret = serdev_device_open(hu->serdev);
+		ret = qca_port_open(hu);
 		if (ret) {
 			bt_dev_err(hu->hdev, "failed to open port");
 			return ret;
@@ -2067,8 +2088,8 @@ static int qca_setup(struct hci_uart *hu)
 		if (retries < MAX_INIT_RETRIES) {
 			bt_dev_warn(hdev, "Retry BT power ON:%d", retries);
 			if (hu->serdev) {
-				serdev_device_close(hu->serdev);
-				ret = serdev_device_open(hu->serdev);
+				qca_port_close(hu);
+				ret = qca_port_open(hu);
 				if (ret) {
 					bt_dev_err(hdev, "failed to open port");
 					return ret;
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 48ba017e2..d2c48df34 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -101,11 +101,13 @@ static int hci_uart_flush(struct hci_dev *hdev)
 		kfree_skb(hu->tx_skb); hu->tx_skb = NULL;
 	}
 
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
+		return 0;
+
 	/* Flush any pending characters in the driver and discipline. */
 	serdev_device_write_flush(hu->serdev);
 
-	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
-		hu->proto->flush(hu);
+	hu->proto->flush(hu);
 
 	return 0;
 }
-- 
2.34.1

