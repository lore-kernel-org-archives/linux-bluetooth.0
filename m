Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591481F3BA9
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 06:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751005041; cv=none; b=Vao8y+BKxeRfarGqKtv0YZUu/9X0PF5nihBUyTSW8iFVZhOW+oFUfAlb+vWbDcKOtnBGiZnCYJdwv1dweb261Waei8eGyjse1OO52wLPycKjbPp/xsVd4be1jJKk74bxLg69GY3hFHkYK3V/fdsuwrE56NW9nytLiObN1AHaZx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751005041; c=relaxed/simple;
	bh=loeA2n+Yy99mLOPlKIykJvz+cuUTnTkE0VqunEc+eIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VONWyGBZmfbrGj4FNsFHdI2hrUQtXCTuqkzqnkctd53ltA8IkF90Teyl5Nn69UqvsIvCQUlOUcczv9YSQ5ZNfWbmtg9TrEMbohDVjo1cyAzfacg4Pgsh3z3UOhcojSmGiCfd5bFmzSUhkDJ3H9ehsJ+DgV/ipDKVaR5DUU+No/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oIDJRWaC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oIDJRWaC"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R4DEek009881
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 06:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=khca9vf4A70dyJB8Tgyz7I
	ICflnjSE/1I8XrjYlT0FM=; b=oIDJRWaCzSWg4IOyfKYauxV8ZirMYHjEFkT5P/
	53EOGjrfCV+FKDcyU1NX681yPxRe0TADL/m51kpktd0+w+XOFXRTY9dKQBMRm1sd
	HyIWVYQGG1yYhcpU85vP7uBNI40MRnXSWVCHQSTF/qGBjwLLIoH32QkQ7++CWQ+k
	Jo1v16B3x2g75qbR8eatr2nrvtxYQWxcTf/GzsBOl5Z/rqIkgnvT+NHIcDh8hFSq
	/YgsL7Rm2E7IlcA7OTDhlwZY4NqFDMwjsOTuq4/883By03/1Zgr0YWhpktrf/Yji
	34BGKT+o0qNLtGAi+xTfUA7og0yFLAIr4LMFIy7JUFNo9A3Q==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g88ffd63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 06:17:16 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55R6HDpu010081
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 06:17:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 47dntmpvuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 06:17:13 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55R6HCod010076
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 06:17:12 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (bt-iot-sh02-lnx.qualcomm.com [10.253.144.65])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 55R6HC7J010075
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 06:17:12 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467449)
	id B10D92295C; Fri, 27 Jun 2025 14:17:11 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: linux-bluetooth@vger.kernel.org
Cc: quic_bt@quicinc.com, Shuai Zhang <quic_shuaz@quicinc.com>
Subject: [PATCH v2] driver: bluetooth: hci_qca: fix ssr fail when BT_EN is pulled up by hw
Date: Fri, 27 Jun 2025 14:17:07 +0800
Message-Id: <20250627061707.3631422-1-quic_shuaz@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA0NyBTYWx0ZWRfX1bs0EraRTzXA
 BQ0su+zoYSImbjIcmJ0eARxx71IOa5lH8rBMsgzc5RLr4WumC44HdqWCopOoV+Fhqz5XD10D66K
 XIaPxzguyH3DlZpPHKB2zcwXsQ7HP1ceGeNx2pg7VhrhlTu3AKst96glZm3gzPez9bid13aJVH7
 BrjkU6OUS8DfSEASO0PNOeDxEqRXOz5f7lf2nOMqt+8w4BKM6hziIEddPTKj+SY5kAPDBYI5so5
 e5YFWzxyUl89i0XzM8hX0FHthK9Kn4QlJKo6mFp+bjbSZf9eIGQFQN1Zcuc04zxqL+NqF8+LSVu
 aMc2z9Sh48e+b21/2tw64XtK5w/HPQHsQMFBItsaSq+MvG/ex4Uy76xsCuqCadnBq2wHLGcOH4q
 pGa2MbwxchdOYff+zAykDLR+T0n19opVh/ACEMPcdPnYIyrp+EVHFwwoMORm3elQXGfF8NtY
X-Proofpoint-ORIG-GUID: MZAh6TOm8SD0jDoNy_GpURkcT_TEZXKy
X-Proofpoint-GUID: MZAh6TOm8SD0jDoNy_GpURkcT_TEZXKy
X-Authority-Analysis: v=2.4 cv=LNNmQIW9 c=1 sm=1 tr=0 ts=685e376d cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=mRmbbomOM4DXTVd2v6UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_02,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270047

Q1：
If the SoC always enables the bt_en pin via hardware and the driver
cannot control the bt_en pin of the SoC chip, then during SSR,
the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be cleared.
This leads to a reset command timeout failure.

Fix1：
To address this, clear QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits
after the coredump collection is complete.
Also, add msleep delay to wait for controller to complete SSR.

Q2:
When the SSR (Sub-System Restart) duration exceeds 2 seconds, it triggers
host tx_idle_timeout, which sets host TX state to sleep. due to the
hardware pulling up bt_en, the firmware is not downloaded after the SSR.
As a result, the controller does not enter sleep mode. Consequently,
when the host sends a command afterward, it sends 0xFD to the controller,
but the controller does not respond, leading to a command timeout.

Fix2:
Reset the tx_idle_timer after SSR (Sub-System Restart).

Changes in v2:
- Modified the format.
- Add changes to fix tx_idle_timeout
- Link to v1: https://lore.kernel.org/all/20250609105553.3756688-1-quic_shuaz@quicinc.com/

Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 4e56782b0..d415a3f31 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1653,6 +1653,24 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
 		skb_queue_purge(&qca->rx_memdump_q);
 	}
 
+	/* If the SoC always enables the bt_en pin via hardware and the driver
+	 * cannot control the bt_en pin of the SoC chip, then during SSR,
+	 * the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be cleared.
+	 * This leads to a reset command timeout failure.
+	 *
+	 * To address this, clear QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits
+	 * after the coredump collection is complete.
+	 * Also, add msleep delay to wait for controller to complete SSR.
+	 */
+	if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
+		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
+		clear_bit(QCA_IBS_DISABLED, &qca->flags);
+		mod_timer(&qca->tx_idle_timer, jiffies +
+			  msecs_to_jiffies(qca->tx_idle_delay));
+		qca->tx_ibs_state = HCI_IBS_TX_AWAKE;
+		msleep(50);
+	}
+
 	clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
 }
 
@@ -2478,7 +2496,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return PTR_ERR(qcadev->susclk);
 		}
 	}
-	
+
 	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
 	if (err) {
 		BT_ERR("serdev registration failed");
-- 
2.34.1

