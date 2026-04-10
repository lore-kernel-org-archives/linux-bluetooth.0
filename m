Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F2B312825;
	Fri, 10 Apr 2026 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775814927; cv=none; b=V4HZWHYWpai8zK/4DMRtUxTvxPZa5bl+AyZKho+0ULBw+6mqksfUXgiOa9b5QLT5FWJReVVAboAzU+TmFMgeydTuOiZqw09+w6BiIabcto6xtS6Lj5kPnBE9Dui0VYd2W5ReycZQMJwGoRmxKDhFth9aQiQInUSWwEqlGdGx7X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775814927; c=relaxed/simple;
	bh=dCvB0ZAOuWF4RxqZ4hUShdnwoqSXMT8L5QtABb21Vy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EBu6V5DF+gQGYtQoECQjxI9kw4Jq8/sMmkzKC2aT5UmPkWMLv2hYVyZ5ROigVK/JeyHJ0Hl0BCVky86YP4aTDQzNyFPsr7vuqL4ZWYhFwtPBnJcZjT7UBVuEajSAHnseFUHDNbUeLf4mlpp0VC1nEXXhjuD4Qvkmrx11xL7rXt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g+Mhw8wf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g+Mhw8wf"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A6rA2s1729912;
	Fri, 10 Apr 2026 09:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=G0r5qFh+VYS/vcpaYmTFo6u0ZM9i79F8xLX
	YH93TcH0=; b=g+Mhw8wfRnApy8Z1IEXUTRFAcxodIsz2pAyF6W4YxBc+RUWCHMV
	N0wWa9n3GEPKUHo+4BHwl/2NpPAtVaK6HN7Cve0lOZiBBmAJNWAcxpNkKsFdlE5k
	jWdVWXOlcems7cXpXYaMhuqJ3QdAuskmItMpSx2c6M2JA1SkAiUlfzFkE/eBCaG9
	r5hrx5eyjUoibbbB+Gd2amexqEagQlRF2T7T0FUErgLufQ4ClBOMbZ6yRdi5PsFS
	tRxA2Q/Wp/wDUXbdyA4NvBH5jhV2JmZuyQu1FHN/DYfqAjLGfYfKt9+XU336krbt
	EksiRd2A44PcOuqwceBkUmUQj1003F/8INQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deckxkqk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 09:55:09 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 63A9t7Fe023655;
	Fri, 10 Apr 2026 09:55:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4db3nk60hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 09:55:07 +0000 (GMT)
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63A9t7pm023649;
	Fri, 10 Apr 2026 09:55:07 GMT
Received: from shuaz-gv.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 63A9t64L023646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 09:55:07 +0000 (GMT)
Received: by shuaz-gv.ap.qualcomm.com (Postfix, from userid 4467449)
	id DBC7E5EB; Fri, 10 Apr 2026 17:55:05 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v7] Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling
Date: Fri, 10 Apr 2026 17:54:43 +0800
Message-Id: <20260410095443.4167332-1-shuai.zhang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: RZ0Qh2EOn4EThtXaGoEHefz4fgCPdYnZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA5MSBTYWx0ZWRfX95v9WlXrsMJO
 MhX4zeiAzbLHCCj9Z9oJb6HJCbsyjacj4+fOEAfQVgArCZ5MlG6XcKBfK8hpAP8SmVHZxuU8P6z
 0i9e1Za0lojPMdAnEOH7M7ZLfGuei0fPn6jTW0yuzghEhsSG+YAA7N+YmXQVGMQHhQl7zdz84cW
 EThMpaIMq22GNkAc5jUBjKWPoGwIytLlSlN6yG+D7ImloBss5T7f7IdZ/DpldMaiqlC8n7UfJHQ
 SbIbQcg4e7nVoNYqXGM1o8XUxsewBtuMsy42+b1tJMN6xbnR7RZouSQqgg27sUMBZFxOnm7oomg
 1i9kCn0c4wdkbt3QX5z0K92hIGk7YzX99znO1mWqi7BVPu1WhklgaFjV9T9+IWab18zlv0glNW2
 iDMGglz3x/+jqHODauOgWA2bkLgIdzfxd6Ayw/6oMZ6QqftCvBNY+V5xfa3kMbqTBSSKmBk288A
 GwImsZDOtQarxhrIoWA==
X-Authority-Analysis: v=2.4 cv=OMcXGyaB c=1 sm=1 tr=0 ts=69d8c8fd cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=iQIbKNVvCqgKSkLQppcA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: RZ0Qh2EOn4EThtXaGoEHefz4fgCPdYnZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100091

When a Bluetooth controller encounters a coredump, it triggers the
Subsystem Restart (SSR) mechanism. The controller first reports the
coredump data and, once the upload is complete, sends a hw_error
event. The host relies on this event to proceed with subsequent
recovery actions.

If the host has not finished processing the coredump data when the
hw_error event is received, it waits until either the processing is
complete or the 8-second timeout expires before handling the event.

The current implementation clears QCA_MEMDUMP_COLLECTION using
clear_bit(), which does not wake up waiters sleeping in
wait_on_bit_timeout(). As a result, the waiting thread may remain
blocked until the timeout expires even if the coredump collection
has already completed.

Fix this by clearing QCA_MEMDUMP_COLLECTION with
clear_and_wake_up_bit(), which also wakes up the waiting thread and
allows the hw_error handling to proceed immediately.

Test case:
- Trigger a controller coredump using:
    hcitool cmd 0x3f 0c 26
- Tested on QCA6390.
- Capture HCI logs using btmon.
- Verify that the delay between receiving the hw_error event and
  initiating the power-off sequence is reduced compared to the
  timeout-based behavior.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
---
Changes v7:
- Reflow commit message and clarify wording.
- Mention the timeout value and affected controller.
- Add Reviewed-by from Paul Menzel.
- Link to v6
  https://lore.kernel.org/all/20260410085202.4128000-1-shuai.zhang@oss.qualcomm.com/

Changes v6:
- Replace wake_up_bit with clear_and_wake_up_bit 
- Link to v5
  https://lore.kernel.org/all/20260409112233.3326467-1-shuai.zhang@oss.qualcomm.com/

Changes v5:
- Replace clear_and_wake_up_bit with wake_up_bit
- Link to v4
  https://lore.kernel.org/all/20260327083258.1398450-1-shuai.zhang@oss.qualcomm.com/

Changes v4:
- add Acked-by signoff
- Link to v3
  https://lore.kernel.org/all/20251107033924.3707495-1-quic_shuaz@quicinc.com/

Changes v3:
- add Fixes tag
- Link to v2
  https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc.com/

Changes v2:
- Split timeout conversion into a separate patch.
- Clarified commit messages and added test case description.
- Link to v1
  https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc.com/
---
 drivers/bluetooth/hci_qca.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c17a462ae..228a754a9 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1108,7 +1108,7 @@ static void qca_controller_memdump(struct work_struct *work)
 				qca->qca_memdump = NULL;
 				qca->memdump_state = QCA_MEMDUMP_COLLECTED;
 				cancel_delayed_work(&qca->ctrl_memdump_timeout);
-				clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
+				clear_and_wake_up_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
 				clear_bit(QCA_IBS_DISABLED, &qca->flags);
 				mutex_unlock(&qca->hci_memdump_lock);
 				return;
@@ -1186,7 +1186,7 @@ static void qca_controller_memdump(struct work_struct *work)
 			kfree(qca->qca_memdump);
 			qca->qca_memdump = NULL;
 			qca->memdump_state = QCA_MEMDUMP_COLLECTED;
-			clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
+			clear_and_wake_up_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
 		}
 
 		mutex_unlock(&qca->hci_memdump_lock);
-- 
2.34.1

