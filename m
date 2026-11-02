Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607565;
	b=RRjDJ+VHxmcXS3cyNXWfoZ1Idgc6RAcOYeqP9zPnTGwWlAaI7CV3oc8+yVUPSHW519L0
	 Z/OIKKLbGgdnmCY4hVKhdsJXc9ms93dcJfWEEW1w0SsZrH7Qk+2oLcvCPGk1tnRrKy0Fa
	 lZHXEnsWs6mHYRjGWBoNYARfeJwyZqpuj8TUXzVU/vExUaE2duAr4+hwvWm6lTF0AisGk
	 mnJ4bsDm9H7FQbtoMKc3kxVjIhVewL/EKKb1TJOhJjs+dscYXaWa0Gc+ePFoEac9O0trc
	 MfaFB2jWvg29MoJxqFPebwyuyynvOaotEvgQsPYnjUnxVpeHTcSNEzvmIvIkU0tdVKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607565;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-QCInternal:X-QCInternal:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XJqke42404WQNN7KBMZn/3OMQgH1irXUxQxeR5JBtDA=;
	b=m/0KY67aXr1GF22jySiaxs9N9Au5nBIWftTZWwf3Cj5/o55/tqBnn1M+L4bZ99LvJgHF
	 Ikpi7Sqn8aOH7h8twDOgN/EgG8Guf9sKw+0iKGFW46sCPRbs4uEIrViVBURGhNCnHsZpg
	 dyeWapFKUOTi8GhcVglSnhcN/XrESp/J3da7bj//TJY8OC/PY43Hd67Sr7xpNCmI5eSS9
	 OOamcraA37dTk5A++lBtgkFIW1+7zW/Oc8ILMK3865TxlXdmqr3AmZUU+ENVLbtTbnugW
	 i20XtzNknWWLZLUEJxzwrP99FX3BzX5hLBWlWpsXXO9eupuHx+q3XkxmeM0eKy3bIZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HBAcz8Nq;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55881606A329
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 08:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55881606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HBAcz8Nq
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A26pgAl3120975
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XJqke42404W
	QNN7KBMZn/3OMQgH1irXUxQxeR5JBtDA=; b=HBAcz8NqP6Isvjhhxnued6LgiYh
	z1bAhYICPZ0pNJOB8kwtHfUTDpHsKOBbQ/xi4lGku3QkJN4KwvxK0WRaatCRtCQw
	v/YZxnWiL5UvvlUghvteUZjYTNokTr6w4Dbo961zq27Ew12GufPDjG9t77tiqiT9
	aJh8N8dX67R9pY+HZ0pUFVzvUyNcfhZuO5uRG30jeQ5cNgoUuQ4lG3Z+ev7e25dM
	pTSQoSyEeQjhbJbTksG/TgxufDLFGFs6fUW4ADDPUDYEuHu0PbeEFU6yBQzPVz84
	QKrch8n55YDWo0syRfX90OeUchhlCqnEMjysYPfJ01t5zetZa8pTUNLjmTQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpnmerad5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 08:19:22 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28JKm43331060;
	Mon, 2 Nov 2026 08:19:20 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6A28JJfu3331043;
	Mon, 02 Nov 2026 08:19:20 +0000 (GMT)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH BlueZ 01/15] gatt-database: Drop stale device state for removed bonds
Date: Mon,  2 Nov 2026 16:18:58 +0800
Message-ID: <20261102081913.1623864-2-cheng.jiang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102081913.1623864-1-cheng.jiang@oss.qualcomm.com>
References: <20261102081913.1623864-1-cheng.jiang@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=KZ1HIgYD c=1 sm=1 tr=0 ts=6ae8478b cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=Ll1jcesoXCec_3fPiLkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX002aI4JaKy5N
 XUqDB69cbbA3PrR51BelAWAmE2Wrf3SXdJOX0puBzaftw4QBB7f8BSmlDGMTxhWLldQApmxuUcF
 oMD48AtNeGosyRK18W75BdF3tgudSRmIn3homAVeWz3WcYh0rAg4IGg8r7Y6ToNDq58ZHxEvOGh
 MjahltZ0JTPbNUvyu6ZNXoik0cgHg0ZiBK3tcV5cOrvxq/20+gpKVnwdDOjwUyjrW42DgKK+9RQ
 AZjQmxYfx/h565hw4t9lTWO2VX6LCYgIJ8WMHay9i0BlSck9SEsoY2pcwD2DjA0x1+un4+vurYn
 Aamk/vn6QcXme+dYWa9fl4NdKIvp9FCWFK5gGGhLU9O2Eyhf/bEq/Rx6r5LRfQILysDgkeW0Igm
 v6q0LOgs4wfGUGQYNegHVy5YaBUBfU/btti9GkyAC43sFAGDWTqbJgLQtVYeMVUtemk4/0T+EuA
 J1GuQkzFHcGSBadBGww==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX8QCSc/Dk+d34
 4+c+48npp0D2D8x1DADPDXLBMJPQt84uD6JxVWXsgmVfSOGLZ56Df5s4X4r3iInz9naiu6eQdBx
 GxAmFx0qjhxX/AAT/Xh4iWaRWlNLbBg=
X-Proofpoint-ORIG-GUID: gK1VAAR1nZkhuVxX0mT2NpnQ00yaPaEe
X-Proofpoint-GUID: gK1VAAR1nZkhuVxX0mT2NpnQ00yaPaEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020032

When a device is removed while disconnected, its cached CCC state
stays in the GATT database and is restored on the next connection.
Drop that state from device_remove() so a re-paired device starts
clean.

Assisted-by: Claude:claude-haiku-5-5
---
 src/device.c        |  3 +++
 src/gatt-database.c | 25 +++++++++++++++++++++++++
 src/gatt-database.h |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/src/device.c b/src/device.c
index 4567188d6..6179c4777 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5629,6 +5629,9 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 {
 	DBG("Removing device %s", device->path);
 
+	btd_gatt_database_remove_device(
+			btd_adapter_get_database(device->adapter), device);
+
 	if (device->auth_retry_id) {
 		device->auth_retry_id = 0;
 		timeout_remove(device->auth_retry_id);
diff --git a/src/gatt-database.c b/src/gatt-database.c
index d8e45581a..a7480a7f8 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -4251,6 +4251,31 @@ void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
 	att_disconnected(0, state);
 }
 
+void btd_gatt_database_remove_device(struct btd_gatt_database *database,
+						struct btd_device *device)
+{
+	struct device_state *state;
+	const bdaddr_t *addr;
+	uint8_t type;
+
+	addr = device_get_address(device);
+	type = btd_device_get_bdaddr_type(device);
+
+	state = find_device_state(database, addr, type);
+	if (!state)
+		return;
+
+	/* While connected, gatt_server_cleanup() still reaches the state
+	 * through the disconnect callback, so leave it alone here.
+	 */
+	if (state->disc_id)
+		return;
+
+	queue_foreach(state->ccc_states, clear_ccc_state, state->db);
+	queue_remove(database->device_states, state);
+	device_state_free(state);
+}
+
 static void restore_ccc(struct btd_gatt_database *database,
 			const bdaddr_t *addr, uint8_t addr_type, uint16_t value)
 {
diff --git a/src/gatt-database.h b/src/gatt-database.h
index 998e3c452..94469a707 100644
--- a/src/gatt-database.h
+++ b/src/gatt-database.h
@@ -20,6 +20,8 @@ btd_gatt_database_get_adapter(struct btd_gatt_database *database);
 
 void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
 						struct btd_device *device);
+void btd_gatt_database_remove_device(struct btd_gatt_database *database,
+						struct btd_device *device);
 void btd_gatt_database_server_connected(struct btd_gatt_database *database,
 						struct bt_gatt_server *server);
 
-- 
2.43.0

