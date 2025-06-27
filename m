Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38123DE
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 03:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750993361; cv=none; b=etV3fet1B7KvGHnlz4fqdAGm+yt00OD0OB3t0dPVdVb2xRrNGpJR5nKZTeGmJFjJ/RXORJQ6S1vJkbBont14qC+Ej38lDt7M8X7/Yf4snT9cWlDvQ7W6fp8ZhzUWmIl6e8Ko0yjVZCXkROkAapJlVzVavSGO1eJrpeJ8107rHmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750993361; c=relaxed/simple;
	bh=98tRSPK+RoSkthxkJnOi8slzkcO+ey7JNfkItdkQLqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KotXV3qimVfRr4Dtxky9nfo6g/ym4YaMlcVk/fu9uXPkO7sxtRCM6KQ2QSfyTykdeml6Y1byhHvGDD+41PngiKGTGK7t6m6xWvqZ7UjITFv0fOHjT1hiyvwYJQZcQQK5rcdziCZNdCoIFGBO8xV7ZxMDTDS1s8hW+HlVzsECnuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XE/WHOPK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XE/WHOPK"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QLZ27N008202
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 03:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=O7/yg8B/h+6SX7ha0PpqMr
	R/ZbUyrZFYX7g5nACx5oc=; b=XE/WHOPKVMvLt61X+6tkmh5jicRfMi6ed5ml/2
	Q8CWcr4NNqEbsjYRv5NVLbA/OnzecmYDegpBCv5dZivTu4fo3h9gM+PqdO0q+5i0
	BVp8QyF1H0gm5Pa9fObIh7PdQ3gw6hIz1zo08CjeeKtPYQ6O98ZQiwe+HqfYpjvT
	Tb+/P4bABJGPeOnIvZzCaole4Bxi1/drBeoxfdp8T/g17XjtMew3GtXQLkvNlgTT
	FlUoxBy+gXaGRfyXce4NIFV+7BjNYYMEbgkFTIgpMcnRKZ+xFy1fwqJZPd6VwWs/
	maCpHRMjTDkX1VAWu/aLTrG8dxGVUeO92oioBy3uAN+E/JoA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbhqup8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 03:02:36 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 55R32XQI006071
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 03:02:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 47dntmp13w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 03:02:33 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55R32WgO006065
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 03:02:32 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (bt-iot-sh02-lnx.qualcomm.com [10.253.144.65])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 55R32W8V006063
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 03:02:32 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467449)
	id B1B1F22998; Fri, 27 Jun 2025 11:02:31 +0800 (CST)
From: Shuai Zhang <quic_shuaz@quicinc.com>
To: linux-bluetooth@vger.kernel.org
Cc: quic_bt@quicinc.com, Shuai Zhang <quic_shuaz@quicinc.com>
Subject: [PATCH v1] net: bluetooth: add callback to exe l2cap when read_security uncompleted
Date: Fri, 27 Jun 2025 11:02:29 +0800
Message-Id: <20250627030229.1720287-1-quic_shuaz@quicinc.com>
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
X-Proofpoint-ORIG-GUID: JMCN85UtPvII7SXJTW7_E-lf9Cxtsxwo
X-Authority-Analysis: v=2.4 cv=Id+HWXqa c=1 sm=1 tr=0 ts=685e09cc cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=HPSoKVYdNdeX-JuY4BoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JMCN85UtPvII7SXJTW7_E-lf9Cxtsxwo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDAyNCBTYWx0ZWRfX2xYOy5dqsbKp
 xQC61U21bPoMLK0OTvVpgulJJI8HTsE0jAgk/Guu5/58W0d+CVeV1j50kIgFSKV2mHETt9rQnHZ
 bhDHCH8cf0qnZzg+nnNsPWhYinzLXvGT4Y1C1QfVdjHNrYudUHDyJhxo0ELImTsgdRbC1pmam4U
 WIG6LzvqnhwWVCcc7n4wjgLmJ5D4MvmZiySzsgq6FA05pjCoxgZV95l1QPqxkJlWykDsx+03XHe
 7RRR9YwFM0tXU36eEW7l7gfC6wC2X+OYew6SbsE3MH5N2IXGb+Z1vGmh5JPS65vajdmI6JTdN94
 qG4G+klB71DjRjZlNfXVNlhARylLABidVn7A4ShTjEwcvVYPfraJeUs3Et/pobW/JtI4H3vs3ja
 bpIGAso4jDw7FrNxxV7cIss/tXv3p+pEvr5XzuU1uYdAbRGFlNIFY8TMy4cit5+669+oPaCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_01,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270024

When the DUT receives a remote L2CAP Connection Request during the Read
Encryption Key Size procedure, if it fails to complete reading the
Encryption Key Size while processing the request, it will respond with
a Connection Response – Refused (security block), resulting in the
disconnection of the remote device.

Use HCI_CONN_ENC_KEY_READY to determine whether
l2cap_connect_request is pending.

When l2cap_connect occurs before the read_enc_key_size event, it will
be pending because HCI_CONN_ENC_KEY_READY has not yet been set.
The connection request will be processed once the read_enc_key_size
event completes.

Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
---
 include/net/bluetooth/hci_core.h |  3 +++
 include/net/bluetooth/l2cap.h    | 10 +++++++++-
 net/bluetooth/hci_event.c        | 16 ++++++++++++++++
 net/bluetooth/l2cap_core.c       | 30 ++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b47c74080..db329abbf 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -767,6 +767,8 @@ struct hci_conn {
 
 	struct bt_codec codec;
 
+	struct l2cap_pending_connect *pending_connect;
+
 	void (*connect_cfm_cb)	(struct hci_conn *conn, u8 status);
 	void (*security_cfm_cb)	(struct hci_conn *conn, u8 status);
 	void (*disconn_cfm_cb)	(struct hci_conn *conn, u8 reason);
@@ -970,6 +972,7 @@ enum {
 	HCI_CONN_CREATE_PA_SYNC,
 	HCI_CONN_PA_SYNC,
 	HCI_CONN_PA_SYNC_FAILED,
+	HCI_CONN_ENC_KEY_READY,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 4bb0eaedd..b1ccd56bd 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -679,6 +679,13 @@ struct l2cap_user {
 	void (*remove) (struct l2cap_conn *conn, struct l2cap_user *user);
 };
 
+struct l2cap_pending_connect {
+	struct l2cap_conn *conn;
+	struct l2cap_cmd_hdr cmd;
+	u8 data[sizeof(struct l2cap_conn_req)];
+	u8 rsp_code;
+};
+
 #define L2CAP_INFO_CL_MTU_REQ_SENT	0x01
 #define L2CAP_INFO_FEAT_MASK_REQ_SENT	0x04
 #define L2CAP_INFO_FEAT_MASK_REQ_DONE	0x08
@@ -976,5 +983,6 @@ void l2cap_conn_put(struct l2cap_conn *conn);
 
 int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user);
 void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user *user);
-
+void l2cap_process_pending_connect(struct l2cap_conn *conn,
+				   struct l2cap_cmd_hdr *cmd, u8 *data, u8 rsp_code);
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c4b87bfb4..6c992f83e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -32,6 +32,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/mgmt.h>
+#include <net/bluetooth/l2cap.h>
 
 #include "hci_debugfs.h"
 #include "hci_codec.h"
@@ -766,10 +767,23 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
 		/* Update the key encryption size with the connection one */
 		if (key_enc_size && *key_enc_size != conn->enc_key_size)
 			*key_enc_size = conn->enc_key_size;
+		set_bit(HCI_CONN_ENC_KEY_READY, &conn->flags);
 	}
 
 	hci_encrypt_cfm(conn, status);
 
+	/*Defer l2cap_connect here if it's triggered before key size is read.*/
+	if (conn->pending_connect) {
+		struct l2cap_pending_connect *pc = conn->pending_connect;
+
+		conn->pending_connect = NULL;
+
+		bt_dev_dbg(hdev, "Defer l2cap_connect");
+		l2cap_process_pending_connect(pc->conn, &pc->cmd, pc->data, pc->rsp_code);
+
+		kfree(pc);
+	}
+
 done:
 	hci_dev_unlock(hdev);
 
@@ -3396,6 +3410,8 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
+	clear_bit(HCI_CONN_ENC_KEY_READY, &conn->flags);
+
 	if (ev->status) {
 		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
 				       conn->dst_type, ev->status);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 40daa3827..c4cb60e65 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3982,6 +3982,30 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 	struct l2cap_chan *chan = NULL, *pchan = NULL;
 	int result, status = L2CAP_CS_NO_INFO;
 
+	/* If encryption is requested, but the key size is not ready yet,
+	 * we need to wait for the key size to be ready before we can
+	 * proceed with the connection. We do this by deferring the
+	 * connection request until the key size is ready. This is done
+	 * by storing the connection request in the hcon->pending_connect
+	 * field. The connection request will be retried when the key size
+	 * is ready.
+	 */
+	if (test_bit(HCI_CONN_ENCRYPT, &conn->hcon->flags) &&
+	    !test_bit(HCI_CONN_ENC_KEY_READY, &conn->hcon->flags)) {
+		struct l2cap_pending_connect *pc;
+
+		pc = kzalloc(sizeof(*pc), GFP_KERNEL);
+		if (!pc)
+			return;
+		pc->conn = conn;
+		memcpy(&pc->cmd, cmd, sizeof(*cmd));
+		memcpy(pc->data, data, sizeof(struct l2cap_conn_req));
+		pc->rsp_code = rsp_code;
+		BT_DBG("store request and retried when keysize is ready");
+		conn->hcon->pending_connect = pc;
+		return;
+	}
+
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
 	__le16 psm = req->psm;
 
@@ -4105,6 +4129,12 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 	l2cap_chan_put(pchan);
 }
 
+void l2cap_process_pending_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
+				   u8 *data, u8 rsp_code)
+{
+	l2cap_connect(conn, cmd, data, rsp_code);
+}
+
 static int l2cap_connect_req(struct l2cap_conn *conn,
 			     struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
 {
-- 
2.34.1

