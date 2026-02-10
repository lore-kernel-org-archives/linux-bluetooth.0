Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BF5211A28
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770686037; cv=none; b=jTrsa12xRqxQ4Z11kxmtqOulZrBmSvEFoDtV5JqaiAhytXtKnLh5Lp7Fc+tknPbmV3KW2oOWylACvKACfYr76s5IUUtzvLWproqhn+IrEr9z9xU62ZUtwoAuU/s8POP3QBhmSZ+m0U3CUGMtbIwmfcYzfcxjOO4YlK1y7G8mxXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770686037; c=relaxed/simple;
	bh=ymrSpHCsIxZtyQ2TeTkEMHkG5tnd5nhX+MB+dqRRpCg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QIMvFEUjEagenIiu8VHyxNxKw7zPCzDRIa3OC/z/3BCbz40d77zUqScYQKdfd0XybEUJI3unOY6f7WKwQi45LVqZyXSKgVxusaKeMoCM6rYgTVwLQxXDoEByXgCshRYNw3tb8Rea7BkrLBtCV01kwIPYS3Or+/VhNho75Dma2Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bx2rbq7E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bx2rbq7E"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619I1mw73699967
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 01:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Gr0FYIqSZKHIMV5+IGoyOP
	UuQt1EGFSj6CLCGcql7Ws=; b=Bx2rbq7E+P7v5+zGtwMANTc9tusy/3TFJYSleR
	KybeHlHH0rJpk/KfT4Xp9cQtnz9Ev8tFPifWLwKvf68srY/wGG1iZcTI+7gSEFvB
	J7e4QWmVyi4RoDxiLuwwJqzvqL1WThHgKbSMiUbg1rNNtamy1+O4aGtEv7x0Mswm
	a0/8mX7wwlIv3p6maMXyUNJO2Ma4R0GM6txnMwtEUAY6e2GwlpIkz9HzLHEw0QeI
	xZNgSiZRr+tTJQpJCWJJvbQbLld0cU7ylXFA+Fm3IOvoVGa0wEQFoE4oOiKrIxat
	J8tUPw/YGLbn1nF0Q8iJAaGUAO/p22BM/wkzXhacz4DjF2PQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7e4mamm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 01:13:54 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 61A1DpX2031973
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 01:13:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 4c5xfmgg43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 01:13:51 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61A1DpG4031967
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 01:13:51 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 61A1DpwO031963
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 01:13:51 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4766378)
	id 4673123256; Tue, 10 Feb 2026 09:13:50 +0800 (CST)
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: shuai.zhang@oss.qualcomm.com, cheng.jiang@oss.qualcomm.com,
        chezhou@qti.qualcomm.com, wei.deng@oss.qualcomm.com,
        yiboz@qti.qualcomm.com, jinwang.li@oss.qualcomm.com,
        Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Subject: [PATCH v4] gatt-client:Implement error handling for DB_OUT_OF_SYNC in GATT caching
Date: Tue, 10 Feb 2026 09:13:47 +0800
Message-Id: <20260210011347.3237740-1-mengshi.wu@oss.qualcomm.com>
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
X-Proofpoint-GUID: -GihLjiXpc7rjQvu9d27sLVS_LqppOE9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDAwOCBTYWx0ZWRfX7GlU8nIuJw8z
 mvXfJm373KzawIqXn6IKQnYmR38Ktyf+cgLjdoTUqfkf7Ul2o+/u6ZHSPzsEBos5hHmAqdv8RdL
 /tLub9KTHPiRHxLwyinZe81pqv1HwprBWv+DFZwf+fDkrTE/KOhmmqCRlvY81+o/4XZGseOZS64
 pvl3JUk9jvBXYrPY/QxHnfrN0iWKa22njfcjFqK+PaMqq68cTUZOMQt5Pr5DGTcyN8lQbGdhkjn
 UJ3iS0ZHatS2XlqHWrZ+65g0ceSWBGsTJ9+rCvU0hXtp/MXVuBHngyuBNLrxLsPZg/Ka0I6NYsD
 A5LoSadIAEIKnHMHd9VhIfDPUPm9KlBZBEwljoIlDMcZ0fM0jtQTR7m2PjNWNbXp4gZsD1jl3SK
 rh8Ik8jHnatYJLgiTx4BCGv5AyfX8gN/UJ3DXeKUQPIEDKq0B0O7rl9CpwyivdkdpYl3CIgjkL+
 JYMw0gi+N2gnWUDgtFQ==
X-Proofpoint-ORIG-GUID: -GihLjiXpc7rjQvu9d27sLVS_LqppOE9
X-Authority-Analysis: v=2.4 cv=WecBqkhX c=1 sm=1 tr=0 ts=698a8652 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=HLTaChWyi7ovutuIgR0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100008

Implement automatic retry logic for GATT operations that fail with
DB_OUT_OF_SYNC error (0x12).

This implementation follows the GATT caching specification and provides
robust error recovery while minimizing unnecessary service discovery
operations.

When a DB_OUT_OF_SYNC error occurs, the implementation:

1. Pauses the failed operation in a pending_db_sync state
2. Notifies the GATT client layer via db_sync_callback
3. Reads the remote Database Hash characteristic (0x2B2A)
4. Compares it with the locally cached hash value
5. If hashes match: Retries the operation (database is in sync)
6. If hashes differ: Triggers full service discovery

Workflow:
---------

Hash Match Case:
  App → GATT Client → ATT Layer → Remote Device
                                      ↓ (DB_OUT_OF_SYNC error)
  App ← GATT Client ← ATT Layer ← Remote Device
                ↓
         Read DB Hash (0x2B2A)
                ↓
         Compare with local cache
                ↓ (Match)
         bt_att_resend(att, id, ...)
                ↓
  App → GATT Client → ATT Layer → Remote Device (retry)
                                      ↓ (Success)
  App ← GATT Client ← ATT Layer ← Remote Device

Hash Differ Case:
  App → GATT Client → ATT Layer → Remote Device
                                      ↓ (DB_OUT_OF_SYNC error)
  App ← GATT Client ← ATT Layer ← Remote Device
                ↓
         Read DB Hash (0x2B2A)
                ↓
         Compare with local cache
                ↓ (Differ)
         bt_att_cancel(att, id)
                ↓
         Trigger Service Discovery
                ↓
  App ← GATT Client (operation failed, discovery in progress)

Service Changed Ind Received (Handle Outside Affected Range):
  App → GATT Client → ATT Layer → Remote Device
                                      ↓ (DB_OUT_OF_SYNC error)
  App ← GATT Client ← ATT Layer ← Remote Device
                ↓
         Service Changed Ind arrives
                ↓
         Check error handle vs affected range
                ↓ (Outside range)
         bt_att_resend(att, id, ...)
                ↓
  App → GATT Client → ATT Layer → Remote Device (retry)
                                      ↓ (Success)
  App ← GATT Client ← ATT Layer ← Remote Device

Service Changed Ind Received (Handle Inside Affected Range):
  App → GATT Client → ATT Layer → Remote Device
                                      ↓ (DB_OUT_OF_SYNC error)
  App ← GATT Client ← ATT Layer ← Remote Device
                ↓
         Service Changed Ind arrives
                ↓
         Check error handle vs affected range
                ↓ (Inside range)
         bt_att_cancel(att, id)
                ↓
         Service Discovery already in progress
                ↓
  App ← GATT Client (operation failed, discovery in progress)

btmon traffics:
--------------

Hash Match Case:

bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 7   #1 [hci1]
13.675271
      ATT: Read Request (0x0a) len 2
        Handle: 0x000d
> HCI Event: Number of Completed Packets (0x13) plen 5         #2 [hci1]
> 13.694287
        Num handles: 1
        Handle: 3
        Count: 1
> ACL Data RX: Handle 3 flags 0x02 dlen 9                      #3 [hci1]
> 13.728279
      ATT: Error Response (0x01) len 4
        Read Request (0x0a)
        Handle: 0x000d
        Error: Database Out of Sync (0x12)
bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 11  #4 [hci1]
13.730759
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5         #5 [hci1]
> 13.754290
        Num handles: 1
        Handle: 3
        Count: 1
> ACL Data RX: Handle 3 flags 0x02 dlen 24                     #6 [hci1]
> 13.820283
      ATT: Read By Type Response (0x09) len 19
        Attribute data length: 18
        Attribute data list: 1 entry
        Handle: 0x000f
        Value: f74347d19eef647d97f0b2f7af502e33
bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 11  #7 [hci1]
13.822792
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0010-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5         #8 [hci1]
> 13.842581
        Num handles: 1
        Handle: 3
        Count: 1
> ACL Data RX: Handle 3 flags 0x02 dlen 9                      #9 [hci1]
> 13.880369
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0010
        Error: Attribute Not Found (0x0a)
bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 7   #10
[hci1] 13.880999
      ATT: Read Request (0x0a) len 2
        Handle: 0x000d
> HCI Event: Number of Completed Packets (0x13) plen 5         #11
> [hci1] 13.904288
        Num handles: 1
        Handle: 3
        Count: 1
> ACL Data RX: Handle 3 flags 0x02 dlen 6                      #12
> [hci1] 13.940273
      ATT: Read Response (0x0b) len 1


--------------------
Hash differ case:

bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 7
#16 [hci1] 50.132674
      ATT: Read Request (0x0a) len 2
        Handle: 0x000d
> HCI Event: Number of Completed Packets (0x13) plen 5
> #17 [hci1] 50.171857
        Num handles: 1
        Handle: 3
        Count: 1
> ACL Data RX: Handle 3 flags 0x02 dlen 9
> #18 [hci1] 50.171970
      ATT: Error Response (0x01) len 4
        Read Request (0x0a)
        Handle: 0x000d
        Error: Database Out of Sync (0x12)
bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 11
#19 [hci1] 50.172613
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5
> #20 [hci1] 50.201854
        Num handles: 1
        Handle: 3
        Count: 1
> ACL Data RX: Handle 3 flags 0x02 dlen 24
> #21 [hci1] 50.268291
      ATT: Read By Type Response (0x09) len 19
        Attribute data length: 18
        Attribute data list: 1 entry
        Handle: 0x000f
        Value: 5fa98eed072ee317aa521990be294bf3
bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 11
#22 [hci1] 50.269302
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0010-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5
> #23 [hci1] 50.291849
        Num handles: 1
        Handle: 3
        Count: 1
> ACL Data RX: Handle 3 flags 0x02 dlen 9
> #24 [hci1] 50.419999
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0010
        Error: Attribute Not Found (0x0a)
bluetoothd[91554]: < ACL Data TX: Handle 3 flags 0x00 dlen 11
#25 [hci1] 50.422616
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5
> #26 [hci1] 50.471607
        Num handles: 1
        Handle: 3
        Count: 1
> ACL Data RX: Handle 3 flags 0x02 dlen 24
> #27 [hci1] 50.471663
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x0001-0x0007
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0008-0x0011
        UUID: Generic Attribute Profile (0x1801)
        Handle range: 0x0012-0x0014
        UUID: Device Information (0x180a)
--------------------

Changes from v3:
 - Reuses existing bt_att_resend() and bt_att_cancel() functions
 - Add new structure pending_db_sync
 - Link to v3
   https://lore.kernel.org/all/20260121083804.4010106-1-mengshi.wu@oss.qualcomm.com/

Changes from v2:
 - Detects DB_OUT_OF_SYNC errors during GATT operations
 - Extracts affected handles from the original request PDU
 - Checks if Service Changed indications overlap with those handles
 - Verifies database consistency using Database Hash characteristic
 - Automatically retries the original request if DB is consistent
 - Automatically retries the original request if handle is not affected
 - Link to v2
   https://lore.kernel.org/all/20260105103828.105346-1-mengshi.wu@oss.qualcomm.com/

Changes from v1:
 - Implement automatic recovery when ATT_ECODE_DB_OUT_OF_SYNC error is
   received from the remote device.
 - Link to v1
   https://lore.kernel.org/all/20251208101915.247459-1-mengshi.wu@oss.qualcomm.com/


Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
---
 src/shared/att.c          | 144 ++++++++++++++++++++++++++++++++-
 src/shared/att.h          |   9 +++
 src/shared/gatt-client.c  | 166 ++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-helpers.c |  16 ++++
 src/shared/gatt-helpers.h |   3 +
 5 files changed, 335 insertions(+), 3 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 77ca4aa24..863449c90 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -35,6 +35,7 @@
 #define BT_ATT_SIGNATURE_LEN		12
 
 struct att_send_op;
+struct pending_db_sync;
 
 struct bt_att_chan {
 	struct bt_att *att;
@@ -47,6 +48,7 @@ struct bt_att_chan {
 
 	struct att_send_op *pending_req;
 	struct att_send_op *pending_ind;
+	struct pending_db_sync *pending_db_sync;
 	bool writer_active;
 
 	bool in_req;			/* There's a pending incoming request */
@@ -78,6 +80,10 @@ struct bt_att {
 	bt_att_destroy_func_t timeout_destroy;
 	void *timeout_data;
 
+	bt_att_db_sync_func_t db_sync_callback;
+	bt_att_destroy_func_t db_sync_destroy;
+	void *db_sync_data;
+
 	uint8_t debug_level;
 	bt_att_debug_func_t debug_callback;
 	bt_att_destroy_func_t debug_destroy;
@@ -199,6 +205,11 @@ struct att_send_op {
 	void *user_data;
 };
 
+struct pending_db_sync {
+	struct att_send_op *op;
+	struct bt_att_pdu_error_rsp error;
+};
+
 static void destroy_att_send_op(void *data)
 {
 	struct att_send_op *op = data;
@@ -644,6 +655,11 @@ static void bt_att_chan_free(void *data)
 	if (chan->pending_ind)
 		destroy_att_send_op(chan->pending_ind);
 
+	if (chan->pending_db_sync) {
+		destroy_att_send_op(chan->pending_db_sync->op);
+		free(chan->pending_db_sync);
+	}
+
 	queue_destroy(chan->queue, destroy_att_send_op);
 
 	io_destroy(chan->io);
@@ -682,6 +698,12 @@ static bool disconnect_cb(struct io *io, void *user_data)
 		chan->pending_ind = NULL;
 	}
 
+	if (chan->pending_db_sync) {
+		disc_att_send_op(chan->pending_db_sync->op);
+		free(chan->pending_db_sync);
+		chan->pending_db_sync = NULL;
+	}
+
 	bt_att_chan_free(chan);
 
 	/* Don't run disconnect callback if there are channels left */
@@ -800,9 +822,42 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
 		return false;
 
 	/* Attempt to change security */
-	if (!change_security(chan, rsp->ecode))
-		return false;
+	if (change_security(chan, rsp->ecode))
+		goto retry;
+
+	/* Check if this is DB_OUT_OF_SYNC and we have a callback */
+	if (rsp->ecode == BT_ATT_ERROR_DB_OUT_OF_SYNC && att->db_sync_callback) {
+		struct pending_db_sync *pending;
+
+		pending = new0(struct pending_db_sync, 1);
+		if (!pending)
+			return false;
 
+		pending->op = op;
+		pending->error = *rsp;
+
+		/* Remove timeout since we're waiting for approval */
+		if (op->timeout_id) {
+			timeout_remove(op->timeout_id);
+			op->timeout_id = 0;
+		}
+
+		/* Move to pending_db_sync */
+		chan->pending_db_sync = pending;
+		chan->pending_req = NULL;
+
+		DBG(att, "(chan %p) DB sync pending for operation %p", chan, op);
+
+		/* Notify upper layer */
+		att->db_sync_callback(&pending->error, op->pdu + 1, op->len - 1,
+				      op->id, att->db_sync_data);
+
+		return true;
+	}
+
+	return false;
+
+retry:
 	/* Remove timeout_id if outstanding */
 	if (op->timeout_id) {
 		timeout_remove(op->timeout_id);
@@ -1142,6 +1197,9 @@ static void bt_att_free(struct bt_att *att)
 	if (att->timeout_destroy)
 		att->timeout_destroy(att->timeout_data);
 
+	if (att->db_sync_destroy)
+		att->db_sync_destroy(att->db_sync_data);
+
 	if (att->debug_destroy)
 		att->debug_destroy(att->debug_data);
 
@@ -1473,6 +1531,23 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
 	return true;
 }
 
+bool bt_att_set_db_sync_cb(struct bt_att *att, bt_att_db_sync_func_t callback,
+						void *user_data,
+						bt_att_destroy_func_t destroy)
+{
+	if (!att)
+		return false;
+
+	if (att->db_sync_destroy)
+		att->db_sync_destroy(att->db_sync_data);
+
+	att->db_sync_callback = callback;
+	att->db_sync_destroy = destroy;
+	att->db_sync_data = user_data;
+
+	return true;
+}
+
 unsigned int bt_att_register_disconnect(struct bt_att *att,
 					bt_att_disconnect_func_t callback,
 					void *user_data,
@@ -1650,6 +1725,7 @@ int bt_att_resend(struct bt_att *att, unsigned int id, uint8_t opcode,
 {
 	const struct queue_entry *entry;
 	struct att_send_op *op;
+	bool from_db_sync = false;
 	bool result;
 
 	if (!att || !id)
@@ -1662,11 +1738,41 @@ int bt_att_resend(struct bt_att *att, unsigned int id, uint8_t opcode,
 
 		if (chan->pending_req && chan->pending_req->id == id)
 			break;
+
+		/* Also check pending_db_sync */
+		if (chan->pending_db_sync && chan->pending_db_sync->op->id == id) {
+			from_db_sync = true;
+			break;
+		}
 	}
 
 	if (!entry)
 		return -ENOENT;
 
+	/* If from pending_db_sync, extract operation details if not provided */
+	if (from_db_sync) {
+		struct bt_att_chan *chan = entry->data;
+		struct pending_db_sync *pending = chan->pending_db_sync;
+		struct att_send_op *stored_op = pending->op;
+
+		/* Auto-extract from stored operation if pdu is NULL */
+		if (!pdu) {
+			opcode = stored_op->opcode;
+			pdu = stored_op->pdu + 1;
+			length = stored_op->len - 1;
+			callback = stored_op->callback;
+			user_data = stored_op->user_data;
+			destroy = stored_op->destroy;
+		}
+
+		DBG(att, "(chan %p) Resending DB sync operation %p",
+		    chan, stored_op);
+
+		/* Clear pending_db_sync state */
+		chan->pending_db_sync = NULL;
+		free(pending);
+	}
+
 	/* Only allow requests to be resend */
 	if (get_op_type(opcode) != ATT_OP_TYPE_REQ)
 		return -EOPNOTSUPP;
@@ -1763,6 +1869,34 @@ bool bt_att_chan_cancel(struct bt_att_chan *chan, unsigned int id)
 	return true;
 }
 
+bool bt_att_db_sync_cancel(struct bt_att_chan *chan, unsigned int id)
+{
+	if (chan->pending_db_sync && chan->pending_db_sync->op->id == id) {
+		struct pending_db_sync *pending = chan->pending_db_sync;
+		struct att_send_op *op = pending->op;
+		uint8_t error_pdu[sizeof(struct bt_att_pdu_error_rsp)];
+
+		/* Build error response PDU */
+		memcpy(error_pdu, &pending->error, sizeof(pending->error));
+
+		/* Clear pending state */
+		chan->pending_db_sync = NULL;
+		free(pending);
+
+		/* Notify callback with error */
+		if (op->callback)
+			op->callback(BT_ATT_OP_ERROR_RSP, error_pdu,
+				     sizeof(error_pdu), op->user_data);
+
+		destroy_att_send_op(op);
+		wakeup_chan_writer(chan, NULL);
+
+		return true;
+	}
+
+	return false;
+}
+
 static bool bt_att_disc_cancel(struct bt_att *att, unsigned int id)
 {
 	struct att_send_op *op;
@@ -1795,11 +1929,15 @@ bool bt_att_cancel(struct bt_att *att, unsigned int id)
 	if (!att || !id)
 		return false;
 
-	/* Lookuo request on each channel first */
+	/* Lookup request on each channel first */
 	for (entry = queue_get_entries(att->chans); entry;
 						entry = entry->next) {
 		struct bt_att_chan *chan = entry->data;
 
+		/* Check pending_db_sync first on each channel */
+		if (bt_att_db_sync_cancel(chan, id))
+			return true;
+
 		if (bt_att_chan_cancel(chan, id))
 			return true;
 	}
diff --git a/src/shared/att.h b/src/shared/att.h
index 53a3f7a2a..ba1f84677 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -46,6 +46,11 @@ typedef void (*bt_att_disconnect_func_t)(int err, void *user_data);
 typedef void (*bt_att_exchange_func_t)(uint16_t mtu, void *user_data);
 typedef bool (*bt_att_counter_func_t)(uint32_t *sign_cnt, void *user_data);
 
+/* DB sync callback - notifies upper layer of DB_OUT_OF_SYNC error */
+typedef void (*bt_att_db_sync_func_t)(const struct bt_att_pdu_error_rsp *error,
+					const void *req_pdu, uint16_t req_len,
+					unsigned int att_id, void *user_data);
+
 bool bt_att_set_debug(struct bt_att *att, uint8_t level,
 			bt_att_debug_func_t callback, void *user_data,
 			bt_att_destroy_func_t destroy);
@@ -58,6 +63,10 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
 						void *user_data,
 						bt_att_destroy_func_t destroy);
 
+bool bt_att_set_db_sync_cb(struct bt_att *att, bt_att_db_sync_func_t callback,
+						void *user_data,
+						bt_att_destroy_func_t destroy);
+
 unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 					const void *pdu, uint16_t length,
 					bt_att_response_func_t callback,
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index f8ebab3fa..2056149ba 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -114,6 +114,10 @@ struct bt_gatt_client {
 
 	struct bt_gatt_request *discovery_req;
 	unsigned int mtu_req_id;
+
+	/* Pending retry operation for DB out of sync handling */
+	unsigned int pending_retry_att_id;
+	uint16_t pending_error_handle;
 };
 
 struct request {
@@ -2342,6 +2346,165 @@ static void att_disconnect_cb(int err, void *user_data)
 		notify_client_ready(client, false, 0);
 }
 
+static bool is_handle_out_of_range(uint16_t handle, struct bt_gatt_client *client)
+{
+	bool handle_out_of_range = false;
+	uint16_t start_handle, end_handle;
+
+	if (handle) {
+		start_handle = bt_gatt_req_get_start_handle(
+				client->discovery_req);
+		end_handle = bt_gatt_req_get_end_handle(
+				client->discovery_req);
+
+		if (start_handle != 0 && end_handle != 0 &&
+			(handle < start_handle || handle > end_handle))
+			handle_out_of_range = true;
+	}
+
+	return handle_out_of_range;
+}
+
+static void db_hash_check_cb(bool success, uint8_t att_ecode,
+			      struct bt_gatt_result *result,
+			      void *user_data)
+{
+	struct bt_gatt_client *client = user_data;
+	struct gatt_db_attribute *hash_attr = NULL;
+	const uint8_t *local_hash = NULL;
+	const uint8_t *remote_hash;
+	uint16_t length, handle;
+	struct bt_gatt_iter iter;
+	bt_uuid_t uuid;
+	unsigned int att_id = client->pending_retry_att_id;
+	uint16_t pending_error_handle = client->pending_error_handle;
+	bool handle_out_of_range;
+
+	client->pending_retry_att_id = 0;
+	client->pending_error_handle = 0;
+
+	/* If a Service Changed indication is received at this stage, the
+	 * pending request may be retried once we have verified that the
+	 * affected attribute handle is not within the range impacted by
+	 * the service change.
+	 */
+	if (client->in_svc_chngd) {
+		handle_out_of_range =
+			is_handle_out_of_range(pending_error_handle, client);
+
+		if (handle_out_of_range) {
+			DBG(client, "Error handle not effected, approving retry");
+			bt_att_resend(client->att, att_id, 0, NULL, 0,
+				      NULL, NULL, NULL);
+		} else {
+			DBG(client, "Error handle is in range of svc chngd");
+			bt_att_cancel(client->att, att_id);
+		}
+		return;
+	}
+
+	if (!att_id) {
+		DBG(client, "No pending retry operation");
+		return;
+	}
+
+	if (!success) {
+		DBG(client,
+		"Failed to read remote DB Hash, triggering full discovery");
+		goto trigger_discovery;
+	}
+
+	/* Extract hash value from result */
+	if (!result || !bt_gatt_iter_init(&iter, result))
+		goto trigger_discovery;
+
+	if (!bt_gatt_iter_next_read_by_type(&iter, &handle, &length,
+					     &remote_hash))
+		goto trigger_discovery;
+
+	if (length != 16) {
+		DBG(client, "Invalid DB Hash length: %u", length);
+		goto trigger_discovery;
+	}
+
+	/* Get local hash from database */
+	bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
+	gatt_db_find_by_type(client->db, 0x0001, 0xffff, &uuid,
+			     get_first_attribute, &hash_attr);
+
+	if (hash_attr) {
+		gatt_db_attribute_read(hash_attr, 0, BT_ATT_OP_READ_REQ, NULL,
+				       db_hash_read_value_cb, &local_hash);
+	}
+
+	/* Compare hashes */
+	if (local_hash && !memcmp(local_hash, remote_hash, 16)) {
+		/* Hashes match - safe to retry */
+		DBG(client, "DB Hash matches, approving retry");
+		bt_att_resend(client->att, att_id, 0, NULL, 0,
+			      NULL, NULL, NULL);
+		return;
+	}
+
+	/* Hashes differ - need service discovery */
+	DBG(client, "DB Hash differs, canceling retry and triggering discovery");
+
+trigger_discovery:
+	bt_att_cancel(client->att, att_id);
+
+	if (!client->in_svc_chngd)
+		process_service_changed(client, 0x0001, 0xffff);
+}
+
+static void gatt_client_db_sync_cb(const struct bt_att_pdu_error_rsp *error,
+				    const void *req_pdu, uint16_t req_len,
+				    unsigned int att_id, void *user_data)
+{
+	struct bt_gatt_client *client = user_data;
+	bt_uuid_t uuid;
+	uint16_t error_handle;
+	bool handle_out_of_range = false;
+
+	assert(client);
+
+	/* Only handle DB_OUT_OF_SYNC errors */
+	if (error->ecode != BT_ATT_ERROR_DB_OUT_OF_SYNC)
+		return;
+
+	error_handle = get_le16(&error->handle);
+	client->pending_error_handle = error_handle;
+
+	/* If a Service Changed indication is received at this stage, the
+	 * pending request may be retried once we have verified that the
+	 * affected attribute handle is not within the range impacted by
+	 * the service change.
+	 */
+	if (client->in_svc_chngd) {
+		handle_out_of_range =
+			is_handle_out_of_range(error_handle, client);
+
+		if (handle_out_of_range)
+			bt_att_resend(client->att, att_id, 0, NULL, 0,
+				      NULL, NULL, NULL);
+		else
+			bt_att_cancel(client->att, att_id);
+		return;
+	}
+
+	/* Store the att_id for later use */
+	client->pending_retry_att_id = att_id;
+
+	/* Read remote DB Hash to compare */
+	bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
+	if (!bt_gatt_read_by_type(client->att, 0x0001, 0xffff, &uuid,
+				   db_hash_check_cb, client, NULL)) {
+		DBG(client, "Failed to read DB Hash, rejecting retry");
+		client->pending_retry_att_id = 0;
+		client->pending_error_handle = 0;
+		bt_att_cancel(client->att, att_id);
+	}
+}
+
 static struct bt_gatt_client *gatt_client_new(struct gatt_db *db,
 							struct bt_att *att,
 							uint8_t features)
@@ -2382,6 +2545,9 @@ static struct bt_gatt_client *gatt_client_new(struct gatt_db *db,
 	client->db = gatt_db_ref(db);
 	client->features = features;
 
+	/* Register DB sync callback for DB out of sync handling */
+	bt_att_set_db_sync_cb(att, gatt_client_db_sync_cb, client, NULL);
+
 	return client;
 
 fail:
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index c1cbbdc91..8dee34a9e 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -790,6 +790,22 @@ done:
 	discovery_op_complete(op, success, att_ecode);
 }
 
+uint16_t bt_gatt_req_get_start_handle(struct bt_gatt_request *req)
+{
+	if (!req)
+		return 0;
+
+	return req->start_handle;
+}
+
+uint16_t bt_gatt_req_get_end_handle(struct bt_gatt_request *req)
+{
+	if (!req)
+		return 0;
+
+	return req->end_handle;
+}
+
 static struct bt_gatt_request *discover_services(struct bt_att *att,
 					bt_uuid_t *uuid,
 					uint16_t start, uint16_t end,
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index 7623862e9..2bf5aad46 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -101,3 +101,6 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
 					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
+
+uint16_t bt_gatt_req_get_end_handle(struct bt_gatt_request *req);
+uint16_t bt_gatt_req_get_start_handle(struct bt_gatt_request *req);
-- 
2.34.1

