Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186330;
	b=c+Fubz6Y7fLX8ij44mTfIBCUMQOSNrqc55G9iZKrMkZ8TASPiLjJP2ZDNAGYVRYUGnyt
	 XHpmQ34VbC/9mY6QYfPiflxMF1OcLYdz/6VaoZ0QUxDUteDtzFp/MmdSuBMx1NM2oGaw0
	 VdvRA84yC99B+0EdTsQ6z3oDY278Ktxas6uSFdeGdvJX+ftG1XMKacnhEqSx2MAiIk0Si
	 UaQEybwRgMDHPzRwSj5ZE4WuYkqCClgmbHzy6Yk4BJFPjtWrlhvqCVZR5uxq7dge/43hN
	 JmHNIYvKIDpbW5MepG7mKRSqei4XFAvzY8QjTPShKvoc1LRvaHZ5WPdo7D0Rawozhdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186330;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=UHAg2pLmqH8v1pfUE8pjCG6fL2Tv/JRtlo3awaOg+BY=;
	b=Xv7GzQDvTT+P/HwdzGnH3/gwY/lcw2psWZ2JqZRVC3m/83x0sNZSCtQeYqLcqgee0onr
	 mI0Gjdiq0Y82UUUXfPOjxyRMqD/QAo7p/j/CsKTYr6Ab13f2LWTODAYG+6hduu2Vi+SZY
	 kHTAdhyCJq3IB6DBkJizl7053gsfLy5mZbbQAV8ItQSuX3REIHVLUUxdWbfNNa6TbxrqC
	 ZXH9t9PAZtX3nJl3dUcIEpLexOinngKBnaLvpxs1HpuefRM/HJgui3hEjxGTjaRF9h7Yp
	 yfE/MZeUfgUoy1VsTMlkgh/Y508B6+UwZj0R+Y1rgcaaJl/L+HpL1algd7LVwyvMM1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R8rWGQ2S;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAAC606A31C;
	Wed, 28 Oct 2026 11:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FAAC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R8rWGQ2S
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8K4nB066004;
	Wed, 28 Oct 2026 11:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UHAg2pLmqH8
	v1pfUE8pjCG6fL2Tv/JRtlo3awaOg+BY=; b=R8rWGQ2SV5VLCZ9704kxJ+cevoW
	Jdc9KgC2tJ2mERjT7qrKTDeLz8y81HmBOMWNvO+6yQ6bzy6+vYoDmz+tqn7lR67I
	NgpkrPxy0bDZR1Pt5x9Yl0J1IW2cPIw1O81ZAg/s9yJIMXdbantoLJZ9/k7Yom/S
	iXs8ri3/b1f7kVpJ4bOcZHHTqPHcinIxIRpEPk/ItQNBM8BXjIZWQ+BAjYUonw+9
	LSjMjAqwvgtIa8D1a2hJ+amRnFw5TQIc/TEMraEbEt9oV4KwdtsATt10dOIAIL7O
	zjOMV4ZkjqtVNo9VjAVyF3fQg0+F+egysWK8jQAvXd9/c7PRQ/xTOffULAw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy6g3u1p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 11:18:43 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBIgTO3253971;
	Wed, 28 Oct 2026 11:18:42 GMT
Received: from shuaz-gv.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 69SBIfiI3253938
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 11:18:41 +0000 (GMT)
Received: by shuaz-gv.ap.qualcomm.com (Postfix, from userid 4467449)
	id BCFAC683; Wed, 28 Oct 2026 19:18:40 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, chejiang@qti.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Subject: [PATCH v3 2/2] Bluetooth: hci_qca: Don't use the serdev port after a failed reopen
Date: Wed, 28 Oct 2026 19:18:39 +0800
Message-Id: <20261028111839.2148515-3-shuai.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028111839.2148515-1-shuai.zhang@oss.qualcomm.com>
References: <20261028111839.2148515-1-shuai.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0NCBTYWx0ZWRfXzrw4uScmI6vu
 jBlMklTfPJELBvgaYvFLBdkBsxquHhH6O5v/ZpBsSJRw1Z663RP5VhYwTM0QmhQCIHBZ+6yAhv6
 ovhf94g688Pl8/Ss7IoNBrFjhpW4Bd3dEgTocXqFEThIIh9gF8KOo0tid19I+OLnYZ0OH/24mNa
 IdqsppVjpj+G/r2/HIXqScu3DRFqJR8zLEbIyf7OnTuKvkINAGLg/tngC34izGpDKVQE0oEgPIZ
 t6mqJtmpgCZx+zVXlhM8AlSKSieu0+X3zmhjmEgyb4bX7/1h0iiDCP1Tf3pRAC8QsabXUZHl+HG
 wRMI9x1Nv/ZUf7UqFgOmyJzc3i3rvzXktMz2RHh678v7B82WR0RwMhQOitF/yNFZM9eLhF7RW/5
 7yToXChyNW3GsHiIWc7eR+z9TD/dS+u5kZKqFbhOeydUS2V9Mj8TClTx2MEskvuf86qFlo1glVC
 lnZjr4+fWKbhTeXy/+g==
X-Proofpoint-GUID: RU1m9lrdhYUlA14kHzzS8qeV1UHsuieC
X-Proofpoint-ORIG-GUID: RU1m9lrdhYUlA14kHzzS8qeV1UHsuieC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0NCBTYWx0ZWRfX8stVN0M3Nqfm
 Epvg0DteMwlXGnX8IA2vQCqArGRNd1fDodKwdTpmFIRlIB8Ux8i2+MIRmn7KXlWLVL3bLH2bk/X
 zQvhn3XDNOu6MoW8m9U2gd6e/1PPAi4=
X-Authority-Analysis: v=2.4 cv=dKgzC+Zb c=1 sm=1 tr=0 ts=6ae1da13 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=6kjjVuEVlcK_fzh3hnQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280044

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
---
 drivers/bluetooth/hci_qca.c    | 33 +++++++++++++++++++++++++++------
 drivers/bluetooth/hci_serdev.c |  6 ++++--
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ee3ccb59e..66332e744 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1745,6 +1745,27 @@ static bool qca_wakeup(struct hci_dev *hdev)
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
@@ -1754,8 +1775,8 @@ static int qca_port_reopen(struct hci_uart *hu)
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
@@ -1779,12 +1800,12 @@ static int qca_regulator_init(struct hci_uart *hu)
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
@@ -2073,8 +2094,8 @@ static int qca_setup(struct hci_uart *hu)
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

