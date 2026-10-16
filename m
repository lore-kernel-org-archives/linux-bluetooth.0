Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723CF340DB8;
	Fri, 16 Oct 2026 02:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117394; cv=none; b=ZjA6q9do0jtUPACUe7RJugafd25ytWgm4H7hzT13Wx2uRJRAi6siTJ4Q0Kg4pxO8BiwqfNq0GMklabAkVprvojpEmRJhp3S/ZEVt9V9SabnXf09kWYAfm4uk7ftbRIxW4jPizKFj89ZyoDv49pmfLtZrWPwyKGP+alY84BBgblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117394; c=relaxed/simple;
	bh=jQV+RVh2Qewbh4Vqk/FeyC0beSCtrHUBkc+3mWD6YIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JTz7SUL7vXJlXNefsCR+4xhYfgHgS4lg8DfeTw/wPbp1FzE1FW6BvcQMaR4Edxzy8XnUuZCE9ntUyu7wWrZtoFlK/+zhuwVG9K8JW95b+dn3RNdAUr3OEs9vlbspXefcadLQk2J88GKNtIJ+N15mRD30L0sVqefogUybZVkZEAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fJ8fWBA+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fJ8fWBA+"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FKKCUM3800036;
	Fri, 16 Oct 2026 02:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=BGJhlOttxqSxiS7YwBNLr3QeGcUiZGXBjL/
	x70jFWOE=; b=fJ8fWBA+18DXhZmLcNV4v5kymEKZh9gst1Vk/8G6CHZpvwtobCC
	9nbwt4Ee1kQJ/ICQfl9BCLxakDEMvlCO8nFcFF38SuuI3PIlHq3TWZsRGIj5Q4Em
	IanywhB0o/l0kWQLt91/O3QLyG5ciNnWwwBo88YLr163nNd/+MyCXEtDgN8T1+wx
	chfvLdGgLdZzeuq123lIYhUSDhUuQBSeQp3R2ucN3cNcOtT5po2YtGo5sWI/vb88
	74PUpMRfR9sti8mtp7b0qdRpzi+bYkIN4wD908tpoOzb3okCIE92DrZiJyO+Vati
	Is/RyBn2rrHjjcuUB3quKodr5DZNk5SLb6Q==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb5se945a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 02:23:06 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69G2N48U2676934;
	Fri, 16 Oct 2026 02:23:04 GMT
Received: from shuaz-gv.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 69G2N4dH2676926
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 02:23:04 +0000 (GMT)
Received: by shuaz-gv.ap.qualcomm.com (Postfix, from userid 4467449)
	id 4510F644; Fri, 16 Oct 2026 10:23:03 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, chejiang@qti.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Subject: [PATCH v2] Bluetooth: hci_qca: Reopen port after power on for QCA2066
Date: Fri, 16 Oct 2026 10:23:02 +0800
Message-Id: <20261016022302.4003647-1-shuai.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAwOSBTYWx0ZWRfX1TO88fzVepLa
 z7G3pT4oNI8EuRX25A22yYJO9pWZBGMgDjF7D268thPkIrYmm2sFSa/H79D+XAPbnxu61IOI/26
 gQPfFaDZyjlCDc27LO6aAXRdqwiU6AI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAwOSBTYWx0ZWRfX4lp3rOPvlDJU
 6KTSSSEIM7fnnBVFlQZ3ShngkVYPn22nS29srmTE9SlJtUtKqc/MwDEtPXjGmuuxh3n6jRevl+V
 P2zs1E1MJZcYgFPygw/FHdiLE7gwzQkTHUAfbN5MofJjWLsw6a8+TDYcnkSsGTLHKHcwc4huJfI
 +twOpT+qez8GbgKjURxYTG3J+BA5rkqnlrIuRVGvQuK93Ckgs7h7ZCkFqFsbQoSuWLQsRwFVThz
 sqOnP0TMkBcbf6U8PxXc+FlcxTEcy5HT5SJDEhx2FcTrEYyGVv7WG8fdk5k8gwq88zqnWYUD2sb
 6dprAlNaihKWdjnTvFfFV4HR08onUCfd+ltg2siebazncO8Z0ewUZ0SoyjRcU/DVXxHiiH1bYLj
 1Dtll6+aKa2rDhVYzIs6BiE4CgeM9c8nP204DnwaAezPQGITWcYAroCnexNYqbOJQn8k5prOX2T
 VMmdWnq1IVkrHDg1Z5A==
X-Authority-Analysis: v=2.4 cv=P4yvFSAu c=1 sm=1 tr=0 ts=6ad18a8a cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=i-ZuXnGKmWlNg_lG8XwA:9
X-Proofpoint-ORIG-GUID: AbYkkqnYVznoksIJ9kCNKD_1eldMWyU1
X-Proofpoint-GUID: AbYkkqnYVznoksIJ9kCNKD_1eldMWyU1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160009

QCA2066 needs the serial port reopened after the controller is powered
on, otherwise the host and the device run into RTS/CTS synchronization
issues.

Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
---
Changes for V2
 - Use a separate case for clearer logic.
 - V1 link
   https://lore.kernel.org/all/20261015092224.262158-1-shuai.zhang@oss.qualcomm.com/
---
 drivers/bluetooth/hci_qca.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 7089e9b63..ee3ccb59e 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1867,6 +1867,19 @@ static int qca_power_on(struct hci_dev *hdev)
 		ret = qca_regulator_init(hu);
 		break;
 
+	case QCA_QCA2066:
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		if (qcadev->bt_en) {
+			gpiod_set_value_cansleep(qcadev->bt_en, 0);
+			msleep(50);
+			gpiod_set_value_cansleep(qcadev->bt_en, 1);
+			/* Controller needs time to bootup. */
+			msleep(50);
+		}
+
+		ret = qca_port_reopen(hu);
+		break;
+
 	default:
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->bt_en) {
-- 
2.34.1

