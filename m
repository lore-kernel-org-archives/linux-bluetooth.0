Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678763D
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655895; cv=none; b=Rz3HisK+wIhXyIAEPMTRCorRgizRvz294lrEO7TbrwUET6qVxIafzfuv7upUGockOYyZNQpJt2S+Kc4H4ItAWx01NoqV2i3RQCCbeLJVPjvJzEFAKGq2+K8xr04ty5y0e1RdPXz3QswbE3qxXSxjgcsRSL0bpqrfgdQEfyJzg/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655895; c=relaxed/simple;
	bh=sDtdaUUUStxFcZnfqbWabUdx2mwrtazWI8EiRdDGTcs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jBo2ZMEORKgTOikvqn5JYSDD5svhUY6fqAn721wA4XhaF0W82pwmS/aLsrqS6+d9cvg3BhfcKu0sd037ZRQP+fJniHvF9+CS0rScL1sGQPq+WG9Gnm47GzkCcORs14MtzSow0ql1U9Y5qTPGTYpXf14EMRg51m/R+I7tOIed7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MofmEZFH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MofmEZFH"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47PNIHlt013362
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 07:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wh3WfgH9VYNFFjlT9uDlUf
	y3mo4IzIlq+tKMtEW2mBo=; b=MofmEZFHPgLD53yof4sAQ7L4a936Q5SEjNZsl7
	GSHPwY3wPQgZsJNi29QxzcGu933C9CwzjBQxr1cwo+fDfX7zFtaxLn7a5tgZcc2p
	v1ooDWlwbIeU+bPm/INFXSXjtj1Gu08TinaDu3pIC8cM2RtXYqmFd0p78qigW5hR
	NSS0sFg9RY/xHrBqZrwPehtCuk0OfSx+kXI0TCGEzPN5hcv/Mrm3XfSDu5P4oO9e
	9/ST/ZSWdsHQIoIwtjyJERO0ubX6Iq7ecnMjNXPiA/gDgLZYGeeJ8dxU/TX+jOle
	SiyWL5MoRwPK15OzuctqsCssoL8PuMujRHHyHVwtGgCtaFxw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 417980tsbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 07:04:52 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47Q74p2S006173
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 07:04:51 GMT
Received: from chejiang-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 26 Aug 2024 00:04:50 -0700
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v1] adapter: Manage device state of cross-transport SMP keys
Date: Mon, 26 Aug 2024 15:04:38 +0800
Message-ID: <20240826070438.557107-1-quic_chejiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MfE3L8hxtPy8XXc7D-4e9arBKJ1uuHUI
X-Proofpoint-ORIG-GUID: MfE3L8hxtPy8XXc7D-4e9arBKJ1uuHUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_04,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408260055

Cross-transport derived ltk/csrk/irk are reported to bluetoothd from
kernel with BR/EDR address type, and bluetoothd doesn't treat it as LE
paired/bonded. In this case, bluetoothd won't send remove bond operation
with LE address type to kernel when executing unpair, so SMP keys are
retained in kernel list. Then RPA is getting resolved since we still
have irk which was not deleted when unpair device is done because only
link key is deleted since addr type is bredr.

What’s more, pair LE of the same address will always fail in kernel
for ltk existence, and send back AlreadyExists error, but device state
is still unpaired/unbonded in bluetoothd.

So bluetoothd needs to consider LE paired/bonded when receiving SMP keys
even if they are cross-transport derived.
---
 src/adapter.c | 53 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 245de4456..4e5af9579 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8647,6 +8647,7 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 	struct btd_adapter *adapter = user_data;
 	struct btd_device *device;
 	char dst[18];
+	uint8_t addr_type;
 
 	if (length < sizeof(*ev)) {
 		btd_error(adapter->dev_id, "Too small new link key event");
@@ -8666,7 +8667,13 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	device = btd_adapter_get_device(adapter, &addr->bdaddr, addr->type);
+	/*
+	 * For LE public address, key here is cross-transport derived,
+	 * so consider it as BR/EDR public address.
+	 *
+	 */
+	addr_type = addr->type == BDADDR_LE_PUBLIC ? BDADDR_BREDR : addr->type;
+	device = btd_adapter_get_device(adapter, &addr->bdaddr, addr_type);
 	if (!device) {
 		btd_error(adapter->dev_id,
 				"Unable to get device object for %s", dst);
@@ -8682,7 +8689,7 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 		device_set_bonded(device, BDADDR_BREDR);
 	}
 
-	bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
+	bonding_complete(adapter, &addr->bdaddr, addr_type, 0);
 }
 
 static void store_ltk_group(struct btd_adapter *adapter, const bdaddr_t *peer,
@@ -8773,6 +8780,7 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 	struct btd_device *device;
 	bool persistent;
 	char dst[18];
+	uint8_t addr_type;
 
 	if (length < sizeof(*ev)) {
 		btd_error(adapter->dev_id, "Too small long term key event");
@@ -8784,7 +8792,13 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 	DBG("hci%u new LTK for %s type %u enc_size %u",
 		adapter->dev_id, dst, ev->key.type, ev->key.enc_size);
 
-	device = btd_adapter_get_device(adapter, &addr->bdaddr, addr->type);
+	/*
+	 * For BR/EDR public address, key here is cross-transport derived,
+	 * so consider it as LE public address for SMP.
+	 *
+	 */
+	addr_type = addr->type == BDADDR_BREDR ? BDADDR_LE_PUBLIC : addr->type;
+	device = btd_adapter_get_device(adapter, &addr->bdaddr, addr_type);
 	if (!device) {
 		btd_error(adapter->dev_id,
 				"Unable to get device object for %s", dst);
@@ -8802,8 +8816,7 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 	 * be persistently stored.
 	 *
 	 */
-	if (addr->type == BDADDR_LE_RANDOM &&
-				(addr->bdaddr.b[5] & 0xc0) != 0xc0)
+	if (addr_type == BDADDR_LE_RANDOM && (addr->bdaddr.b[5] & 0xc0) != 0xc0)
 		persistent = false;
 	else
 		persistent = !!ev->store_hint;
@@ -8817,15 +8830,15 @@ static void new_long_term_key_callback(uint16_t index, uint16_t length,
 		rand = le64_to_cpu(key->rand);
 
 		store_longtermkey(adapter, &key->addr.bdaddr,
-					key->addr.type, key->val, key->central,
+					addr_type, key->val, key->central,
 					key->type, key->enc_size, ediv, rand);
 
-		device_set_bonded(device, addr->type);
+		device_set_bonded(device, addr_type);
 	}
 
 	device_set_ltk(device, ev->key.val, ev->key.central, ev->key.enc_size);
 
-	bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
+	bonding_complete(adapter, &addr->bdaddr, addr_type, 0);
 }
 
 static void new_csrk_callback(uint16_t index, uint16_t length,
@@ -8837,6 +8850,7 @@ static void new_csrk_callback(uint16_t index, uint16_t length,
 	struct btd_adapter *adapter = user_data;
 	struct btd_device *device;
 	char dst[18];
+	uint8_t addr_type;
 
 	if (length < sizeof(*ev)) {
 		btd_error(adapter->dev_id, "Too small CSRK event");
@@ -8848,7 +8862,13 @@ static void new_csrk_callback(uint16_t index, uint16_t length,
 	DBG("hci%u new CSRK for %s type %u", adapter->dev_id, dst,
 								ev->key.type);
 
-	device = btd_adapter_get_device(adapter, &addr->bdaddr, addr->type);
+	/*
+	 * For BR/EDR public address, key here is cross-transport derived,
+	 * so consider it as LE public address for SMP.
+	 *
+	 */
+	addr_type = addr->type == BDADDR_BREDR ? BDADDR_LE_PUBLIC : addr->type;
+	device = btd_adapter_get_device(adapter, &addr->bdaddr, addr_type);
 	if (!device) {
 		btd_error(adapter->dev_id,
 				"Unable to get device object for %s", dst);
@@ -8911,6 +8931,7 @@ static void new_irk_callback(uint16_t index, uint16_t length,
 	struct btd_device *device, *duplicate;
 	bool persistent;
 	char dst[18], rpa[18];
+	uint8_t addr_type;
 
 	if (length < sizeof(*ev)) {
 		btd_error(adapter->dev_id, "Too small New IRK event");
@@ -8922,16 +8943,22 @@ static void new_irk_callback(uint16_t index, uint16_t length,
 
 	DBG("hci%u new IRK for %s RPA %s", adapter->dev_id, dst, rpa);
 
+	/*
+	 * For BR/EDR public address, key here is cross-transport derived,
+	 * so consider it as LE public address for SMP.
+	 *
+	 */
+	addr_type = addr->type == BDADDR_BREDR ? BDADDR_LE_PUBLIC : addr->type;
 	if (bacmp(&ev->rpa, BDADDR_ANY)) {
 		device = btd_adapter_get_device(adapter, &ev->rpa,
 							BDADDR_LE_RANDOM);
 		duplicate = btd_adapter_find_device(adapter, &addr->bdaddr,
-								addr->type);
+								addr_type);
 		if (duplicate == device)
 			duplicate = NULL;
 	} else {
 		device = btd_adapter_get_device(adapter, &addr->bdaddr,
-								addr->type);
+								addr_type);
 		duplicate = NULL;
 	}
 
@@ -8941,7 +8968,7 @@ static void new_irk_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	device_update_addr(device, &addr->bdaddr, addr->type);
+	device_update_addr(device, &addr->bdaddr, addr_type);
 
 	if (duplicate)
 		device_merge_duplicate(device, duplicate);
@@ -8950,7 +8977,7 @@ static void new_irk_callback(uint16_t index, uint16_t length,
 	if (!persistent)
 		return;
 
-	store_irk(adapter, &addr->bdaddr, addr->type, irk->val);
+	store_irk(adapter, &addr->bdaddr, addr_type, irk->val);
 
 	btd_device_set_temporary(device, false);
 }
-- 
2.25.1

