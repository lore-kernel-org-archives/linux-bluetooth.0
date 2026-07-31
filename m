Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA72DB780;
	Fri, 31 Jul 2026 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785472171; cv=none; b=bGMQSl9A8GwGMzvgRDvg0+0lt2mv+sT7V1mcP7qGmnKBb69nnZshaCDFhy5LygLpnpAgFqNdovjyZI0/l1TgDZjSGa6znoiYc4jHv5DWWsXYLREmlWjseO9dx4S4Psxv+/IQZDYUKsFp7pkYekoKwQsYJNPM1/motU/VbGB9nUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785472171; c=relaxed/simple;
	bh=xVT41tiow7rGr8rDiJVtMRgY3HThsFhiKy3F6dkB6iU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=si10ZayKdQrM8wYthYI4UHX/By+K3ZT6zsTtFKhsOHHJ+D7NACTQiZYupyqhC1kLraE7ifh40f7XZPiYV7Eyqa6pubnBXn6bCeC8Vhh5GI3s6SdkWdYgHYje+3w/fSVPVObYXONfupYSpZ6mMIa5uhGrboDZXDx63cdMV034M4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IAvsapQT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IAvsapQT"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V1uXA63063088;
	Fri, 31 Jul 2026 04:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lGlKRjmAC0x2z10mK08MbuMqi2JAh0ejIVP
	hL9lmmy8=; b=IAvsapQT6LRVzdD348AQr8thgFNplQWZMzHwEH9r7x3cqCK8tD5
	8B0WLrL3uXBwQt9MrhA5kRd8mJOLAEl1IRNtPOJjpuUZnZN48HK7KLfYjP1Fm3i3
	Rqv0UagTLZed1QZKeDLfR1Eet4EnEVMU4gJeUC5z5jIYV/etMl8XJNE154YRy+rK
	dvjQZz8jcbvT+UIHrAQXj74+lDGkAK1FQWw6ZveXmVXQI1JFWWfu2MKsED41wDMM
	/p7NlSFO8tzsCWkE+kM7ohJyNDXuOeOtmFfCkOkTB1wKxlmReit3vi3hVgseWpbA
	wOeWsoa5a4Mp8c7oW0h62/wS4JgrFm5iCNg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frj750gfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 04:29:25 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V4TNPb002787;
	Fri, 31 Jul 2026 04:29:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fmp7ku4j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 04:29:23 +0000 (GMT)
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66V4TMjA002781;
	Fri, 31 Jul 2026 04:29:23 GMT
Received: from shuaz-gv.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 66V4TMbS002776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 04:29:22 +0000 (GMT)
Received: by shuaz-gv.ap.qualcomm.com (Postfix, from userid 4467449)
	id 90DDE638; Fri, 31 Jul 2026 12:29:21 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, chejiang@qti.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Subject: [PATCH v1] Bluetooth: mgmt: always reply when a queued mgmt command is cancelled
Date: Fri, 31 Jul 2026 12:29:20 +0800
Message-Id: <20260731042920.2431343-1-shuai.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAyNSBTYWx0ZWRfX6ZPjsa3jQgDR
 jYlHNmx41Ke2lJIqxvHuAt/qGfzaQbWFzlOqRyjroGtRveVxj1OH3aOos1OFnOPtoi0rRwIbM8u
 rS3V4lXk9mImVPUCo9TnzBS9bub4G6Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAyNSBTYWx0ZWRfXy3gr1+8Dj+rQ
 UZykn2fEgAB0ZH8RJmKqtaMVrka2kQXAiGumLcRUKXsQhwLT42Wg2B4vG31Wu6Dr0UgTDAv4trs
 ZpLMCihSoUFdlGJRq/ABqA47e7tYBZN7dC7NFkxs0jDHJy1AE/LEXuVqi4OJGZ+kTVezAicyxr8
 5R4q0XR73FdoluBxLPnXqh1j6+b83qcO/om9yF9r4dfaVmOmD9REx0afxMgTxlK2PdB4PMacBu8
 zb2ttmHRWKMiAxF6gfncdevmSIxl5799xwmqdQdnQcqlus+Mno1fqkcE05Tx44uI8iqZMg1jVIp
 ccOGCIWnNnXlnFkX0Ck/5K3HMlRhInNjIe0O/3yltJMtnTlMzPOo9p5dsE92VC19Mu5dSXlNilx
 vvfVbGzOP0bKMJ6D735MxVCkNTywf8dAnnbvmMmBQt/0H0pXAnaRfw4vGX6lSkIhFHeI/l8hd+4
 VY85/iqHUsgFjZ3sRDA==
X-Proofpoint-ORIG-GUID: jNIDJpSqHGXNTR0B5sjpLTy5qh3iyhzJ
X-Proofpoint-GUID: jNIDJpSqHGXNTR0B5sjpLTy5qh3iyhzJ
X-Authority-Analysis: v=2.4 cv=L9otheT8 c=1 sm=1 tr=0 ts=6a6c24a5 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=nXokoBoABDjQELSMSggA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_01,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310025

On boot, the kernel's HCI_AUTO_OFF timer powers a newly probed
controller back off after 2 seconds if nothing has taken ownership of
it yet. bluetooth.service is expected to take ownership within that
window by powering the adapter on, but on slower boots bluetoothd can
start late enough that the two race: HCI_AUTO_OFF fires and the
controller is torn down and re-initialised while bluetoothd is still
in the middle of its own adapter setup sequence.

When that teardown happens, any mgmt command bluetoothd had already
queued for that adapter is cancelled - but userspace is never told.
bluez's mgmt command queue is strictly serialised, so a command that
never receives a reply blocks every command queued after it on that
adapter indefinitely. In practice this means bluetoothd gets stuck
before it can register the adapter, and reports no controller being
available at all, even though the controller itself is healthy and
fully usable moments later.

Fix this by treating a cancelled command like any other failure
instead of silently dropping it: always send a reply back to
userspace, using the existing "cancelled" status value. This mirrors
how other mgmt commands already behave when they fail for other
reasons, and lets bluetoothd's normal error handling take over
(log the failure and continue) instead of hanging forever.

Verified on a QCS6490 rb3gen2 board where this HCI_AUTO_OFF vs.
bluetooth.service race was reproduced: before this change, hitting
the race left the adapter permanently unavailable to bluetoothd until
the service was restarted; after this change, hitting the same race
no longer affects adapter registration and the controller comes up
normally.

Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
---
 net/bluetooth/mgmt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 167d75e34..9031b5d5d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -301,6 +301,8 @@ static u8 mgmt_errno_status(int err)
 		return MGMT_STATUS_ALREADY_CONNECTED;
 	case -ENOTCONN:
 		return MGMT_STATUS_DISCONNECTED;
+	case -ECANCELED:
+		return MGMT_STATUS_CANCELLED;
 	}
 
 	return MGMT_STATUS_FAILED;
@@ -1338,7 +1340,7 @@ static void mgmt_set_powered_complete(struct hci_dev *hdev, void *data, int err)
 	struct mgmt_mode *cp;
 
 	/* Make sure cmd still outstanding. */
-	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
+	if (!mgmt_pending_valid(hdev, cmd))
 		return;
 
 	cp = cmd->param;
@@ -5651,9 +5653,6 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_cp_remove_adv_monitor *cp;
 
-	if (status == -ECANCELED)
-		return;
-
 	hci_dev_lock(hdev);
 
 	cp = cmd->param;
-- 
2.34.1

