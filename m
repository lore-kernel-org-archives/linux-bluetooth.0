Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12A84C6D
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 00:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713919635; cv=none; b=PUelu+2KBv1wGsmpiOOocSJMgr/VObrKhimuLHfcw8u6aATNmmSKecHPUYJoYiUVZy9YN/vJidxokKJD7Bw6fHW8G4VwdtcE9tFvaLLU81Uq7LKbNSYP0/wIQPEJGgg2aOd/fwN7eBdeILgyHq+LCQa0pTDVNY5ylF2+VroqW3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713919635; c=relaxed/simple;
	bh=t6Kin9LsCgbrzDiBFCkycHXWwm9Pp4tz2dJJEU/tAqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKhDaZd0n7v3zZPGpqhElBmD9hJwK3EcJbLoHpDFOOa2Y21fitCKXDO3ycbgZWV5dh+s4VQaWLt0S8IA88xyzvwcHMhDtcMS579iami/PGFV4MM/RomGoHonTWX2ed6RqsW9cAjKjfSQ2aOrP0RNPGT7PzRi+EEckYMuTjGpaNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=laTmJVTT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="laTmJVTT"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O0jCPT005176;
	Wed, 24 Apr 2024 00:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=k/tKqWcXPOAhy1wng2Cq
	WLe5KfnaQ29XETM+jS2N8Pk=; b=laTmJVTTxIAxHsId8JAaYQRw0qLH6BlsVh2H
	pTn+6prfXkUvdAypwZ5AV2GE0t4WMhDkt/L8lnebazKjD2AoFXj3+9cZ7/Z3D/gZ
	m13RbQb/glgrgA6CiqN5Q7QFjGpyHuGZpfhjcFfqWCKPpfWnr98NazCblXLqjJja
	gx5G3r2OF7IPnenMqIlsTbJW3v0fODS0ZsUHaFK0P/RWRL9A6Bpnt0UE7ZOiLYtG
	NUqI4C5izro/HQc0T2JxBKBQCPx1DRTabqU5O0QxjeY7HihznnoUyDo3ut+yHsKZ
	xb3n0G4TVsHD/670iMad++GrKgdXxIMJWYeiWEYp7c/KmsEoiA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp9c0jqp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 00:47:04 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O0l3vY018301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 00:47:03 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 17:46:58 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>,
        <bartosz.golaszewski@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <wt@penguintechs.org>, <regressions@lists.linux.dev>,
        <kernel@quicinc.com>
Subject: [PATCH v6 2/2] Bluetooth: qca: Fix BT enable failure for QCA6390 after disable then warm reboot
Date: Wed, 24 Apr 2024 08:46:42 +0800
Message-ID: <1713919602-5812-3-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -xmB0o5l4MpK82ynvKtN5DTMS8wP2JLm
X-Proofpoint-ORIG-GUID: -xmB0o5l4MpK82ynvKtN5DTMS8wP2JLm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_20,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 clxscore=1015 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=863 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240001

From: Zijun Hu <zijuhu@qti.qualcomm.com>

Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
serdev") will cause below regression issue:

BT can't be enabled after below steps:
cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
if property enable-gpios is not configured within DT|ACPI for QCA6390.

The commit is to fix a use-after-free issue within qca_serdev_shutdown()
during reboot, but also introduces this regression issue regarding above
steps since the VSC is not sent to reset controller during warm reboot.

Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
once BT was ever enabled, and the use-after-free issue is also be fixed
by this change since serdev is still opened when send to serdev.

Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
Reported-by: Wren Turkal <wt@penguintechs.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
Signed-off-by: Zijun Hu <zijuhu@qti.qualcomm.com>
Tested-by: Wren Turkal <wt@penguintechs.org>
---
Changes:
V3 -> V6: Correct title and commit message
V1 -> V3: Remove debugging logs

 drivers/bluetooth/hci_qca.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 4079254fb1c8..fc027da98297 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2439,13 +2439,12 @@ static void qca_serdev_shutdown(struct device *dev)
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 	struct hci_uart *hu = &qcadev->serdev_hu;
 	struct hci_dev *hdev = hu->hdev;
-	struct qca_data *qca = hu->priv;
 	const u8 ibs_wake_cmd[] = { 0xFD };
 	const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
 
 	if (qcadev->btsoc_type == QCA_QCA6390) {
-		if (test_bit(QCA_BT_OFF, &qca->flags) ||
-		    !test_bit(HCI_RUNNING, &hdev->flags))
+		if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks) ||
+		    hci_dev_test_flag(hdev, HCI_SETUP))
 			return;
 
 		serdev_device_write_flush(serdev);
-- 
2.7.4

