Received: from outbound.ci.icloud.com (ci-2004g-snip4-6.eps.apple.com [57.103.89.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3CAEEC0
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 04:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786164338; cv=none; b=Qn9IvtYm1f8Q6xND6TGsuAGVAhVaOLo7EH7kMLDaD/cQtlkzW6kAnNqDKIjHp/z1Q7dq+v8sQD64LDFApd1Qxxwn0ZhE6rfN8NyANJ7i5vaHu9p91HoMtZh+HChFotckuMN10JoNm1VZ+c1Trp2U03URLfz4MyXQrUi6hWNQ6To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786164338; c=relaxed/simple;
	bh=oJvGQTI3jsMJ3HiR2apDqyz8lCjUOkdaZm4SRplV3Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHAGOwPRhxu46fF2USqFA9j1MmwxT1c28dA++trRF109Of30H9/0Z/oucLl7N+ZvpOeMn+v9+5A2uhGmCj+AXU3c0qvbeJTjuQz7r9OVT7ArxwSJ7zadamGNnv3MCIFrVwivTOSjyAHejHJnfMi8QXqPhOravvy/UFa5Ym52Qs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proxy-alt.dev; spf=pass smtp.mailfrom=proxy-alt.dev; dkim=pass (2048-bit key) header.d=proxy-alt.dev header.i=@proxy-alt.dev header.b=fktC4DoL; arc=none smtp.client-ip=57.103.89.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proxy-alt.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxy-alt.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proxy-alt.dev header.i=@proxy-alt.dev header.b="fktC4DoL"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPS id 4381D1800141;
	Sat, 08 Aug 2026 04:45:34 +0000 (UTC)
X-ICL-RepId: 019fdfb0-ce9f-777e-9bb8-87d536b4cdda
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ5JHV8DXRxCCkodXAFbEhVdRUMfWBNLXVgURy1HGV0IQFVSAUNFVhVPWFUJChtAH0EBHgxbHxwUXA4TH1RWAVBRHV8CCgRHBFsXRgNTRVEZFxFQAVgeVl5aF15NRx9ATWJJAVoZWxxAF0puTVMPDwBLF0sUGgpeBBccVhsXBlsUBEQBXQVdAkgJQANZA14BQRdPAl8FUh9BFAhBAk8SHxFVDHMdRQRKCRQZXxkZD1cGB1hHFEcODxNMC0cCWjRWH1QZWgM=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proxy-alt.dev; s=sig1; t=1786164334; x=1788756334; bh=xiCBYkwzWOA8BexzF5R8+Ozgyu1eJCFb3qpBB1DbTnw=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=fktC4DoL3MlusJ/pb3d7RdCLfnsHys4tLQq+PKMjVytctjdZdxzr+fF4uxs6J2Vj8/Zo/EeJGzxznxAx1bwcwr2icFTtoM5z6dw9y/jrbG7mDu2Rjfnnk3uFDuOvYCgluqhtG/efPfiS6qebDs/EXEGxqZwopRhFBAjxLGHrHE9ydxvVOqtwV0/YFjQg7n2/WNHFbXwJakfBt2EGPonFPnlxphhuzHJKFWYmKRJ4iHAxwgupUH/UUvcel5vwc81Qg8w/Xm17w83GSn7N3o+WiIKab9vseF0mP81LQzpnn9AbTD6G9ZgrRMm8zL0ayvGnbN15NUbWk17T7hXq2Uwxag==
mail-alias-created-date: 1786144344056
Received: from localhost.localdomain (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPSA id BF3501800171;
	Sat, 08 Aug 2026 04:45:33 +0000 (UTC)
From: Proxy alt <proxy-alt@proxy-alt.dev>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Proxy alt <proxy-alt@proxy-alt.dev>
Subject: [PATCH v2] shared/gatt-client: discover the CCC descriptor instead of assuming it
Date: Sat,  8 Aug 2026 00:45:31 -0400
Message-ID: <20260808044531.71229-1-proxy-alt@proxy-alt.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808031940.66686-1-proxy-alt@proxy-alt.dev>
References: <20260808031940.66686-1-proxy-alt@proxy-alt.dev>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=f+5FxeyM c=1 sm=1 tr=0 ts=6a76b46e
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=nJ9QeRrBWahFTjA9e8cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDAzNCBTYWx0ZWRfX6Iyfk53VvzpV
 XQ6Ixj2fAaCo0ydzDk00YOdatARdFhfRr12QMe/j/Z8RDltJkUdAGKGOHMvuYZx/zqnrjNQp7Pl
 9BG1CltSgdmZPwpuHKdCkXzBEoVvzzFyHRHrdBfNWvTvOnOpx/7AxYLw0POp+QyH2BtAfSLkdpM
 bup7iYo+AKv6NL3plbVd3ApCyc6BxDObENlnVFo0yjcPftO2GkH8YuuEX+88SjbaU5Z5I0r5KpT
 OlzimjdorpZ3EGDWzeIwG34KoaTp6OG69vK0pLczt3dxPLtcIuKycI4Su6cEXnDhbpeX8ku0yJW
 IP9Xf/51/BoTaFwEFxQ7kzcqoVaa4fg9BWE05VfR2TY3NB6LMvtlk4fLAc6UD8=
X-Proofpoint-ORIG-GUID: pbDpF0ZfPGl8mx2RrInzHqdYfTyQgbhX
X-Proofpoint-GUID: pbDpF0ZfPGl8mx2RrInzHqdYfTyQgbhX

discover_descs() skips descriptor discovery when a notify/indicate
characteristic has exactly one descriptor handle, inserting a synthesized
0x2902 into the database without ever querying the peer. The assumption
follows Core Spec Vol 3, Part G, 3.3.1.1 - notify or indicate implies a CCC
- but it is applied to hardware that does not honour that clause.

On Telink TLSR825x based devices (GE Cync bulbs and switches) the only
descriptor of the notify characteristic is a 0x2901 Characteristic User
Description reading "Status". No CCC exists anywhere on the service. btmon
shows FIND_INFORMATION_REQ issued for the descriptor slot following every
other characteristic and never for this one: the only slot skipped is the
one following the only characteristic declaring notify.

StartNotify then writes 0100 into that text descriptor. The device leaves
the Write Request unanswered - its own violation - the ATT transaction
timeout expires 30 seconds later, and a connection that was carrying live
notification traffic throughout is torn down. The client is handed
UNLIKELY_ERROR, which never appeared on the wire. The synthesized
descriptor is also written to the GATT cache, and regenerated there on
every fresh discovery, so removing the device does not clear it.

Removing the shortcut costs one round trip per notify characteristic per
discovery and lets the peer answer for itself. Where a CCC genuinely
exists, nothing changes. Where it does not, gatt_db_attribute_get_ccc()
returns NULL, chrc->ccc_handle stays zero, and register_notify() already
handles that case correctly - it completes the request and registers the
handler locally without writing anything. Notifications are dispatched on
a value handle match, so they continue to be delivered, and the link
survives.

Confirmed on the affected hardware with tools/btgatt-client, same device
and adapter minutes apart:

  before   descr - handle: 0x0013, uuid: 00002902-...
           < 12 13 00 01 00
           att: Operation timed out: 0x12
           Failed to register notify handler - error code: 0x0e
           Device disconnected

  after    discover_descs_cb() handle: 0x0013, uuid: 00002901-...
           Registering notify handler with id: 1
           no write to 0x0013, no error, link held

unit/test-bap, unit/test-mcp and unit/test-rap are updated. Their expected
PDU sequences omitted descriptor discovery for exactly those
characteristics whose CCC was being synthesized, so the test data encoded
the shortcut rather than the protocol. test-mcp says so directly - its
MCS_FIND_CHRC comment lists Find Information only "for each missing CCC
HND", the notify characteristics being absent because BlueZ never asked
about them. Now that it asks, those exchanges appear and are expected.

make check: 32/32 suites, 0 failures.

Fixes: https://github.com/bluez/bluez/issues/2383
Signed-off-by: Proxy alt <proxy-alt@proxy-alt.dev>
---
 src/shared/gatt-client.c | 19 -----------------
 unit/test-bap.c          | 44 ++++++++++++++++++++++++++++++++++++++++
 unit/test-mcp.c          | 30 ++++++++++++++++++++++++++-
 unit/test-rap.c          | 25 +++++++++--------------
 4 files changed, 83 insertions(+), 35 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index a6abe8a..0dc656d 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -775,25 +775,6 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 
 		desc_start = chrc_data->value_handle + 1;
 
-		if (desc_start == chrc_data->end_handle &&
-			(chrc_data->properties & BT_GATT_CHRC_PROP_NOTIFY ||
-			 chrc_data->properties & BT_GATT_CHRC_PROP_INDICATE)) {
-			bt_uuid_t ccc_uuid;
-
-			/* If there is only one descriptor that must be the CCC
-			 * in case either notify or indicate are supported.
-			 */
-			bt_uuid16_create(&ccc_uuid,
-					GATT_CLIENT_CHARAC_CFG_UUID);
-			attr = gatt_db_insert_descriptor(client->db, desc_start,
-							&ccc_uuid, 0, NULL,
-							NULL, NULL);
-			if (attr) {
-				free(chrc_data);
-				continue;
-			}
-		}
-
 		/* Check if the start range is within characteristic range */
 		if (desc_start > chrc_data->end_handle) {
 			free(chrc_data);
diff --git a/unit/test-bap.c b/unit/test-bap.c
index 4e89ba6..d4ad20e 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -355,6 +355,42 @@ static const struct iovec setup_data[] = {
 	 *   Handle range: 0x0001-0xffff
 	 *   Attribute type: Database Hash (0x2b2a)
 	 */
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x04, 0x00, 0x04, 0x00),
+	/* ATT: Find Information Response (0x05): CCC */
+	IOV_DATA(0x05, 0x01, 0x04, 0x00, 0x02, 0x29),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x07, 0x00, 0x07, 0x00),
+	/* ATT: Find Information Response (0x05): CCC */
+	IOV_DATA(0x05, 0x01, 0x07, 0x00, 0x02, 0x29),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x0a, 0x00, 0x0a, 0x00),
+	/* ATT: Find Information Response (0x05): CCC */
+	IOV_DATA(0x05, 0x01, 0x0a, 0x00, 0x02, 0x29),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x0d, 0x00, 0x0d, 0x00),
+	/* ATT: Find Information Response (0x05): CCC */
+	IOV_DATA(0x05, 0x01, 0x0d, 0x00, 0x02, 0x29),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x10, 0x00, 0x10, 0x00),
+	IOV_DATA(0x05, 0x01, 0x10, 0x00, 0x02, 0x29),
+	IOV_DATA(0x04, 0x13, 0x00, 0x13, 0x00),
+	IOV_DATA(0x05, 0x01, 0x13, 0x00, 0x02, 0x29),
+	IOV_DATA(0x04, 0x17, 0x00, 0x17, 0x00),
+	IOV_DATA(0x05, 0x01, 0x17, 0x00, 0x02, 0x29),
+	IOV_DATA(0x04, 0x1a, 0x00, 0x1a, 0x00),
+	IOV_DATA(0x05, 0x01, 0x1a, 0x00, 0x02, 0x29),
+	IOV_DATA(0x04, 0x1d, 0x00, 0x1d, 0x00),
+	/* ATT: Find Information Response (0x05): CCC */
+	IOV_DATA(0x05, 0x01, 0x1d, 0x00, 0x02, 0x29),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x20, 0x00, 0x20, 0x00),
+	/* ATT: Find Information Response (0x05): CCC */
+	IOV_DATA(0x05, 0x01, 0x20, 0x00, 0x02, 0x29),
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x23, 0x00, 0x23, 0x00),
+	/* ATT: Find Information Response (0x05): CCC */
+	IOV_DATA(0x05, 0x01, 0x23, 0x00, 0x02, 0x29),
 	IOV_DATA(0x08, 0x01, 0x00, 0xff, 0xff, 0x2a, 0x2b),
 	/* ATT: Error Response (0x01) len 4
 	 *   Read By Type Request (0x08)
@@ -531,6 +567,10 @@ static const struct iovec setup_data_no_location[] = {
 	/* ATT: Error Response */
 	IOV_DATA(0x01, 0x04, 0x0b, 0x00, 0x0a),
 	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x10, 0x00, 0x10, 0x00),
+	IOV_DATA(0x05, 0x01, 0x10, 0x00, 0x02, 0x29),
+	IOV_DATA(0x04, 0x13, 0x00, 0x13, 0x00),
+	IOV_DATA(0x05, 0x01, 0x13, 0x00, 0x02, 0x29),
 	IOV_DATA(0x04, 0x17, 0x00, 0x1a, 0x00),
 	/* ATT: Find Information Response (0x05): CCC */
 	IOV_DATA(0x05, 0x01, 0x17, 0x00, 0x02, 0x29),
@@ -551,6 +591,10 @@ static const struct iovec setup_data_no_location[] = {
 	 *   Handle range: 0x0001-0xffff
 	 *   Attribute type: Database Hash (0x2b2a)
 	 */
+	/* ATT: Find Information Request (0x04) */
+	IOV_DATA(0x04, 0x23, 0x00, 0x23, 0x00),
+	/* ATT: Find Information Response (0x05): CCC */
+	IOV_DATA(0x05, 0x01, 0x23, 0x00, 0x02, 0x29),
 	IOV_DATA(0x08, 0x01, 0x00, 0xff, 0xff, 0x2a, 0x2b),
 	/* ATT: Error Response (0x01) len 4
 	 *   Read By Type Request (0x08)
diff --git a/unit/test-mcp.c b/unit/test-mcp.c
index 6331c6c..e579c1e 100644
--- a/unit/test-mcp.c
+++ b/unit/test-mcp.c
@@ -264,7 +264,29 @@ static void test_teardown(const void *user_data)
 		FIND_CHRC(CP_SUPP+base, PROP_RN, 0xa5, 0x2b), \
 		FIND_CHRC(CCID+base, PROP_R, 0xba, 0x2b)), \
 	IOV_DATA(0x08, CCID+base, 0x00, CCID+base, 0x00, 0x03, 0x28), \
-	IOV_DATA(0x01, 0x08, CCID+base, 0x00, 0x0a)
+	IOV_DATA(0x01, 0x08, CCID+base, 0x00, 0x0a), \
+	IOV_DATA(0x04, HND(NAME_CCC), HND(NAME_CCC)), \
+	IOV_DATA(0x05, 0x01, HND(NAME_CCC), 0x02, 0x29), \
+	IOV_DATA(0x04, HND(TRACK_CHG_CCC), HND(TRACK_CHG_CCC)), \
+	IOV_DATA(0x05, 0x01, HND(TRACK_CHG_CCC), 0x02, 0x29), \
+	IOV_DATA(0x04, HND(TRACK_TITLE_CCC), HND(TRACK_TITLE_CCC)), \
+	IOV_DATA(0x05, 0x01, HND(TRACK_TITLE_CCC), 0x02, 0x29), \
+	IOV_DATA(0x04, HND(TRACK_DUR_CCC), HND(TRACK_DUR_CCC)), \
+	IOV_DATA(0x05, 0x01, HND(TRACK_DUR_CCC), 0x02, 0x29), \
+	IOV_DATA(0x04, HND(TRACK_POS_CCC), HND(TRACK_POS_CCC)), \
+	IOV_DATA(0x05, 0x01, HND(TRACK_POS_CCC), 0x02, 0x29), \
+	IOV_DATA(0x04, HND(PLAY_SPEED_CCC), HND(PLAY_SPEED_CCC)), \
+	IOV_DATA(0x05, 0x01, HND(PLAY_SPEED_CCC), 0x02, 0x29), \
+	IOV_DATA(0x04, HND(SEEK_SPEED_CCC), HND(SEEK_SPEED_CCC)), \
+	IOV_DATA(0x05, 0x01, HND(SEEK_SPEED_CCC), 0x02, 0x29), \
+	IOV_DATA(0x04, HND(PLAY_ORDER_CCC), HND(PLAY_ORDER_CCC)), \
+	IOV_DATA(0x05, 0x01, HND(PLAY_ORDER_CCC), 0x02, 0x29), \
+	IOV_DATA(0x04, HND(STATE_CCC), HND(STATE_CCC)), \
+	IOV_DATA(0x05, 0x01, HND(STATE_CCC), 0x02, 0x29), \
+	IOV_DATA(0x04, HND(CP_CCC), HND(CP_CCC)), \
+	IOV_DATA(0x05, 0x01, HND(CP_CCC), 0x02, 0x29), \
+	IOV_DATA(0x04, HND(CP_SUPP_CCC), HND(CP_SUPP_CCC)), \
+	IOV_DATA(0x05, 0x01, HND(CP_SUPP_CCC), 0x02, 0x29)
 
 /* As above but without optional Notify properties, and
  * ATT: Find Information Request (0x04)
@@ -294,6 +316,8 @@ static void test_teardown(const void *user_data)
 	IOV_DATA(0x01, 0x08, CCID+base, 0x00, 0x0a), \
 	IOV_DATA(0x04, HND(NAME_CCC), HND(NAME_CCC)), \
 	IOV_DATA(0x01, 0x04, HND(NAME_CCC), 0x0a), \
+	IOV_DATA(0x04, HND(TRACK_CHG_CCC), HND(TRACK_CHG_CCC)), \
+	IOV_DATA(0x05, 0x01, HND(TRACK_CHG_CCC), 0x02, 0x29), \
 	IOV_DATA(0x04, HND(TRACK_TITLE_CCC), HND(TRACK_TITLE_CCC)), \
 	IOV_DATA(0x01, 0x04, HND(TRACK_TITLE_CCC), 0x0a), \
 	IOV_DATA(0x04, HND(TRACK_DUR_CCC), HND(TRACK_DUR_CCC)), \
@@ -306,6 +330,10 @@ static void test_teardown(const void *user_data)
 	IOV_DATA(0x01, 0x04, HND(SEEK_SPEED_CCC), 0x0a), \
 	IOV_DATA(0x04, HND(PLAY_ORDER_CCC), HND(PLAY_ORDER_CCC)), \
 	IOV_DATA(0x01, 0x04, HND(PLAY_ORDER_CCC), 0x0a), \
+	IOV_DATA(0x04, HND(STATE_CCC), HND(STATE_CCC)), \
+	IOV_DATA(0x05, 0x01, HND(STATE_CCC), 0x02, 0x29), \
+	IOV_DATA(0x04, HND(CP_CCC), HND(CP_CCC)), \
+	IOV_DATA(0x05, 0x01, HND(CP_CCC), 0x02, 0x29), \
 	IOV_DATA(0x04, HND(CP_SUPP_CCC), HND(CP_SUPP_CCC)), \
 	IOV_DATA(0x01, 0x04, HND(CP_SUPP_CCC), 0x0a)
 
diff --git a/unit/test-rap.c b/unit/test-rap.c
index d7da2ff..1eba012 100644
--- a/unit/test-rap.c
+++ b/unit/test-rap.c
@@ -585,21 +585,16 @@ static void test_client_rap(const void *user_data)
  *       Error: Attribute Not Found (0x0a)
  */
 #define RAS_FIND_INFO \
-	IOV_DATA(0x04, 0x06, 0x00, 0x12, 0x00), \
-	IOV_DATA(0x05, 0x01, \
-		0x06, 0x00, 0x02, 0x29, \
-		0x07, 0x00, 0x03, 0x28, \
-		0x08, 0x00, 0x16, 0x2c, \
-		0x09, 0x00, 0x02, 0x29, \
-		0x0a, 0x00, 0x03, 0x28, \
-		0x0b, 0x00, 0x17, 0x2c, \
-		0x0c, 0x00, 0x02, 0x29, \
-		0x0d, 0x00, 0x03, 0x28, \
-		0x0e, 0x00, 0x18, 0x2c, \
-		0x0f, 0x00, 0x02, 0x29, \
-		0x10, 0x00, 0x03, 0x28, \
-		0x11, 0x00, 0x19, 0x2c, \
-		0x12, 0x00, 0x02, 0x29), \
+	IOV_DATA(0x04, 0x06, 0x00, 0x06, 0x00), \
+	IOV_DATA(0x05, 0x01, 0x06, 0x00, 0x02, 0x29), \
+	IOV_DATA(0x04, 0x09, 0x00, 0x09, 0x00), \
+	IOV_DATA(0x05, 0x01, 0x09, 0x00, 0x02, 0x29), \
+	IOV_DATA(0x04, 0x0c, 0x00, 0x0c, 0x00), \
+	IOV_DATA(0x05, 0x01, 0x0c, 0x00, 0x02, 0x29), \
+	IOV_DATA(0x04, 0x0f, 0x00, 0x0f, 0x00), \
+	IOV_DATA(0x05, 0x01, 0x0f, 0x00, 0x02, 0x29), \
+	IOV_DATA(0x04, 0x12, 0x00, 0x12, 0x00), \
+	IOV_DATA(0x05, 0x01, 0x12, 0x00, 0x02, 0x29), \
 	IOV_DATA(0x04, 0x13, 0x00, 0x13, 0x00), \
 	IOV_DATA(0x01, 0x04, 0x13, 0x00, 0x0a)
 
-- 
2.39.5

