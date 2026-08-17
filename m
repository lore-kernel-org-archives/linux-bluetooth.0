Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E1F28690;
	Mon, 17 Aug 2026 06:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786946520; cv=none; b=JTbNTEAtOdakCAL2AR08zrInauatjhDY2fMJyjEbzJtvaCX3u6HjFHXcZXRbcDb7FTC1oMmrLnvSdsQFfku90N56e2BwHX+OZl9g3lG+tmclMylXiBHaGNH+9EjxunGw0BSyiyK6I+nN9/WQ8Ucx+TV4N4+cC87v+UWNGdC2Aq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786946520; c=relaxed/simple;
	bh=8SfWFjuVt/xrpT4qKnEzg81166JfploqZb0g8yxVRlY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WJifbKOJF1r3DRErPtMVarsbUYD5yFMTzl4Z4Wc46zI+7xfVO9KVC0UJUhBc4vMJLgmCylvZhXF36VH+2lsg4tE9eenOY+OSK9U8GElH0Me1pisXLXyEjoRaYAXnNZIsV1WH4l7itZsTW218PJecDuhOLllKzmawM6LI/yBXn4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jxbFBkzz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jxbFBkzz"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H44HkJ1174971;
	Mon, 17 Aug 2026 06:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=UMaAsiCU9rGRmvKP9FMQp/k0FhhvCAevhqp
	qxSMI6Fk=; b=jxbFBkzzU0OD8P6K9DXRwlwb2jMwtUh1iPcevHNwr2fGFLWjbHK
	wootmr5lV28KLr5nY1hQaGGDIzZ3NQLsXgzV3GMCQ14FtwdZ9BWK2NHYElCq4p9G
	qAiVJc2xdNHAwU8UM2XGL4vUMdkBg9oFeKb2cxh5gieT/CVrk9lw/ceh0vHWvG/O
	tPCFOSyZj/Ebj6fMxX3ZLjt3xzliMqicAFCFbZAkXOubG23Txlc46bGSzHwOpizg
	j5q7E1kDmd5GDHmaMBo8Aq/Bmi+BjNGuy9YFhOeAynz7KyvnBaovyw3qbTRUnTFj
	wV33UtWy9rii4qtyfJT8sFbeih09qaiEq1A==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3txy8a1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 06:01:51 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H61m0B002660;
	Mon, 17 Aug 2026 06:01:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4g2h6hjvak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 06:01:48 +0000 (GMT)
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67H61mGm002655;
	Mon, 17 Aug 2026 06:01:48 GMT
Received: from shuaz-gv.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 67H61mNR002653
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 06:01:48 +0000 (GMT)
Received: by shuaz-gv.ap.qualcomm.com (Postfix, from userid 4467449)
	id 1DD07639; Mon, 17 Aug 2026 14:01:47 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, chejiang@qti.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Subject: [PATCH v2] Bluetooth: mgmt: reply to cancelled mgmt commands instead of silently dropping
Date: Mon, 17 Aug 2026 14:01:34 +0800
Message-Id: <20260817060134.3298439-1-shuai.zhang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA0MyBTYWx0ZWRfX2k23pdP7t2AF
 /9KzeMfCDVL9sJRhZOOp6zc9So+OxahxTyJB+YwoWgKxWSaocApmhkwG60G87OvUcHDpkEE1l4p
 /yBrL85IgP3dTEFBchc2xE6hl+EuaHU=
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a82a3cf cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=Hrnrb0NK-oBN7D_GDdoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA0MyBTYWx0ZWRfX0zBDiMA/SmbL
 6RQAGE915dHRR0AVEtwNGE14LQzA7pEAifJgot3eRp8/8T6MKGgYLABh35NmeAhSWMOxahoKmIC
 2u1ie0YHdZSM6MH/IPGllU4bzGBQba3zoaCwZg4uR8wR8mEObDOMZjaXIAUNReyxj7T+Y94W1qF
 ukiMsEhq1jLIlNlvCpXvduCmz/pjjfcvQwLtcAe1UkN4cZv/MHighbbUOf3kIDDY+ggC1OEtJLH
 kJRZFlgrXfraWdi6+oURPulPfyeEMont7mSDl3VuUHRGfW34BWMYn2zkYUw0PJLhCkXR0U1f5kv
 K/7X8IQ9iLVtt78PX9ciuVVqxp9vPVkwdcTgYMuvD9nVYfl8tEOricqO9MVT3uMXSGVHI7l30ED
 0w6n1K3k0EngxsCkgEq27U2PXfIWA5iN7GpNbtJE8rvRtfey5EvEeTBP9ipu51muMALWP4QXU2V
 N5T63I6gozVZVZnf3bA==
X-Proofpoint-GUID: 5L0lq2doEPcKKWmZAFxhUqc1DyFKQTSC
X-Proofpoint-ORIG-GUID: 5L0lq2doEPcKKWmZAFxhUqc1DyFKQTSC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170043

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
and removing the early return in mgmt_remove_adv_monitor_complete(), so
bluetoothd receives a reply and can continue normally.

Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
---
 net/bluetooth/mgmt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ac4864e56..c660bd3cd 100644
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
@@ -5675,9 +5677,6 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_cp_remove_adv_monitor *cp;
 
-	if (status == -ECANCELED)
-		return;
-
 	hci_dev_lock(hdev);
 
 	cp = cmd->param;
-- 
2.34.1

