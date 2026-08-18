Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A303A6B8A;
	Tue, 18 Aug 2026 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787053296; cv=none; b=MSMch6om7vZnHGLAk6XbFUXaEquLlyaWu5uEEnXI80ja3CNgbbwkyukSvqCmnkmbNSQvDTWfF+VL8SBWnmTJnuV4gbdfrFzxLUALKB/VCuELhg/yqb+4R4HN8Fo4enrKC8qSYGocVftph3/5xKyYGOLTtUCrSGnNVeQNYKxttZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787053296; c=relaxed/simple;
	bh=8BxIt7O4NEbVEq3bcNL7aQjY8g9e7eqqlucWTJNcZpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UQ/82QjL59OfZIB9ZY84FjXJLT94705u7voXZFUAabsOK5seJP+URPX9W5vM1VUYgR3Jf5yXkNTKBvBMfaTqP/3kS8AOdZQucHcSzRwWVb9bQuX2j1bgLT45MHe1OM8o6E2cYdSs6LHrdvnAA710/Ckd3pmjdOumlpQCAxOTfk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dx6d1/s5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dx6d1/s5"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABUtS1021622;
	Tue, 18 Aug 2026 11:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5Zy/GMBMnbVrbJCYfUeSOgIsSKD4KEs3XKh
	ktY7lhbA=; b=dx6d1/s5dX96VOqbEkriTNaHroHKSfHhLiWBFjPZzqf/r9l6vQk
	mGgSX5xa0kZBGEpykE9FyFgfJpO9ywpsHK+cWnr3vucvxPUTow0AEPirUzbDGzNQ
	SiRsXehX8Rh5FpM3x4pUwz+4rEUYSx95+WQKIGNZl58tlh7bv9DwONuE2n8CKnwP
	EHLu9NiklE1vuEcnOs+i0dGlOKmv7QtNX5v9q2P6222FYTudeNMByfl4vbZW2vPl
	VfM0KmhnC/8kbHxU8Y891AwiJgy3uyo7aI+DvXzYSglHZaIuYqRUosiaCPT3mX1j
	dE+WELHVRc3lisXbrR2uYrhjCI8t9GGkoSA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g48q0ufrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 11:41:30 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IBfScB008247;
	Tue, 18 Aug 2026 11:41:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4g2h6jx6yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 11:41:28 +0000 (GMT)
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67IBfR4v008241;
	Tue, 18 Aug 2026 11:41:27 GMT
Received: from shuaz-gv.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 67IBfRLk008240
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 11:41:27 +0000 (GMT)
Received: by shuaz-gv.ap.qualcomm.com (Postfix, from userid 4467449)
	id 9486C639; Tue, 18 Aug 2026 19:41:26 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, chejiang@qti.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Subject: [PATCH v3] Bluetooth: mgmt: reply to cancelled mgmt commands instead of silently dropping
Date: Tue, 18 Aug 2026 19:41:16 +0800
Message-Id: <20260818114116.3228662-1-shuai.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4NSBTYWx0ZWRfX2tqCVwPnvynB
 Net9WhClvarN7enz7Cr3vYgK4YisRvQXs37Id7QEhFRLtJiX6EBVJpx7Mxi1Aq6YahSRxBPT89Y
 Fv835NWmeb/HeOu6H9/5oLoOrgbkizA=
X-Authority-Analysis: v=2.4 cv=VuITxe2n c=1 sm=1 tr=0 ts=6a8444ea cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=GqBlYZPlGlANPTvQAwMA:9
X-Proofpoint-GUID: lrflfhbccKhAPU2lHSVDTqgeW3wE6HN4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4NSBTYWx0ZWRfX7Dn9n3M2UUF/
 JxTN61mY0aLYTHzSZaB2eKY324Cj7OpPU3CA51dvj6ybZrnGlWIWnASlNhf6zmaa4JZhVvwkeQ6
 i3gRWRf3QZxhAZlAv5hDY7xYevTxgpZ+LAQmbcXFh35Xj5Zf1xsakD9vhIWQrjWNsPiV0PcnyBq
 0rD0u6g4YEh6qG3R5BbplpqCtu492ybnWPlP/6kzkxqPtS/X6viLK9QUyHHucYT23YzGcFv1m3I
 8ANrgePNEGuYxyxZAOQGvUv/jJNSXbmrD2Kz/+R32/jTGKpzIjLTaVZ534B+xoVpBjUMT8tMc1Y
 atYVVCr2FVw9ruDmw4J4a7MaBa1Na8QIg1BBxU6eVNvA190R/JnQRaes1ijaUqw/POzCVecgLlr
 2ZtakmmlMX2vHomhmIJZau4arbMuD438bSDgjTR0EsRr8fIZ5TAoVnQGUxN0n+Ydq3ijxZzDAjc
 uVYc7KpgN8iDgyo91Fg==
X-Proofpoint-ORIG-GUID: lrflfhbccKhAPU2lHSVDTqgeW3wE6HN4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180085

The kernel sets HCI_AUTO_OFF when a controller is first registered and
starts a 2-second timer. On slower boots bluetoothd and the HCI_AUTO_OFF
timer can race: hci_power_off() is already queued while bluetoothd is
still in the middle of its adapter setup sequence. hci_cmd_sync_clear()
then cancels any pending mgmt commands with -ECANCELED, including the
MGMT_OP_REMOVE_ADV_MONITOR sent by reset_adv_monitors() early in the
setup sequence.

When auto_off=1, hci_dev_close_sync() skips __mgmt_power_off() entirely,
so there is no fallback path to reply to the cancelled commands.
mgmt_remove_adv_monitor_complete() silently returns on -ECANCELED, leaving
the command with no reply. Since bluez's mgmt queue is strictly serialised,
this stalls all subsequent commands indefinitely, leaving bluetoothd unable
to register the adapter.

Fix by mapping -ECANCELED to MGMT_STATUS_CANCELLED in mgmt_errno_status()
and replying to the cancelled command in mgmt_remove_adv_monitor_complete()
instead of returning early.

Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
---
Changes in v3:
- Reply to the cancelled command without taking hdev->lock. The
  cancellation path runs from hci_cmd_sync_clear() with
  cmd_sync_work_lock held, so taking hdev->lock here would form an
  AB-BA deadlock against the remove_adv_monitor() submission path
  (flagged by Sashiko). The success path is left unchanged.
- Link to v2: https://lore.kernel.org/all/20260817060134.3298439-1-shuai.zhang@oss.qualcomm.com/

Changes in v2:
- Drop the mgmt_set_powered_complete() hunk; that -ECANCELED early
  return is intentional and its reply is already handled elsewhere.
  Keep only mgmt_errno_status() and mgmt_remove_adv_monitor_complete()
  (per Luiz's review).
- Link to v1: https://lore.kernel.org/all/20260731042920.2431343-1-shuai.zhang@oss.qualcomm.com/

 net/bluetooth/mgmt.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ac4864e56..fd045460e 100644
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
@@ -5675,8 +5677,18 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_cp_remove_adv_monitor *cp;
 
-	if (status == -ECANCELED)
+	/* Reply to a cancelled command so bluetoothd's serialised mgmt queue
+	 * is not blocked.
+	 */
+	if (status == -ECANCELED) {
+		cp = cmd->param;
+		rp.monitor_handle = cp->monitor_handle;
+
+		mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
+				  mgmt_status(status), &rp, sizeof(rp));
+		mgmt_pending_free(cmd);
 		return;
+	}
 
 	hci_dev_lock(hdev);
 
-- 
2.34.1

