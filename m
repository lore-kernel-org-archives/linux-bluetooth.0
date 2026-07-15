Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD141F7CF
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107188; cv=none; b=XNbjAsSfRXEmDw4VXKhIDzOmHvEmWopHkGBwv0RNGZp0zuQB5zUGPFEd1CAqLHBmsawPPtxtr0ub5HoRANwuJmxuIXZWHZPVMYsf4LbkABadvutXBdIKGWKqy4fbKJ6jNFNYwcpKsV9MEr5P/yA8ailI1Mg/8h/ke1Y7tYE2hJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107188; c=relaxed/simple;
	bh=3KVaDrkW+b2YC5c5MgmxHa9q3N3Zyau3vKMoRjh2PVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QTPziFik4pev2eROhd2X3Bq+Oh6gFSGo7cZgHomnVEbVdXRs634FtiNQ7TZUUGOyOO/R2p1oApyM7fIbsh4oYotI/m3IXM6A4nRLJZtIOv18JoToRfW7lNNMo9aqPzFw/BtcgH7jNxwuEZRwcqnBUdWTV0qbgnZrbbjQhbmOZQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bjeZs0aG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bjeZs0aG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F6hUhF2796331;
	Wed, 15 Jul 2026 09:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=iELu9tqkssC3KTsIPjeYsb159s4wJr3JRNF
	qj3aIuxo=; b=bjeZs0aGIZeyuQ0ECy9zTQJpZING2aSt1tvmt4XqNTi6tSgTJtt
	TEUOnvBtGHQZrj1x+fr4YN10FrgHMtCGpN2zbWsyz9aw6xMECTRzX1Dc2i9tpHh6
	Z2gQZjImQt6ICPhKvqIx42w7m94amKoKYnFX32AfsBA+lP4qpwJRb3rMw4OPyfm/
	mL6ihbt8gCwWDL2eMVCKjCeokfy5GVDwlEQUZruUaNXn539+gZMXcaBxJgEe+lY6
	7aT/K7uVZDdzTCT70PXOlqN5I99LQdeRBIh7Yqyp6SpHzYdFnCRu7mtfHh7mVIED
	SGCUj8ajTeU3UkH1Ou78oJogWaW1qkT75Zg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe56h8k3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 09:19:42 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66F9Jd0S019239;
	Wed, 15 Jul 2026 09:19:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fbewjevs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 09:19:39 +0000 (GMT)
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66F9JdjM019231;
	Wed, 15 Jul 2026 09:19:39 GMT
Received: from bt-iot-sh03-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 66F9Jd2k019227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 09:19:39 +0000 (GMT)
Received: by bt-iot-sh03-lnx.qualcomm.com (Postfix, from userid 2385805)
	id 2E59C43B04; Wed, 15 Jul 2026 17:19:38 +0800 (CST)
From: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH] adapter: restrict delta=0 RSSI to proximity filters
Date: Wed, 15 Jul 2026 17:19:36 +0800
Message-ID: <20260715091936.4137598-1-xiuzhuo.shang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA5MCBTYWx0ZWRfXyREu4Q4mcvlU
 VDYOKqXoiJwNSRfqjbuXWLbQW8AC6nbk92qdV/q4AtfC8NhS8SCdVlYaOd0v6qrTqcqzEy3EbQP
 yJ4P/1gMayhFyjmlM/Cjy539k9U7ZV4=
X-Proofpoint-ORIG-GUID: TEOsspSJ5vdMVSbbm2nrt8WgT2NAnqmj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA5MCBTYWx0ZWRfX4o1TAsJaSaEq
 myBiS7ZHA7pzjTXbHPXkTWU1CFBS8PmLVwJywRzJel89/M6OaFbGrXAn9TopDZ5tKvH9YmyBRj7
 y5mJSLA8gzQPazubv3JFKlJTw2xkhx2TN9Hvg1uTomklEKwViujWHSUxTlKLEgDlMs0fsUi0Pyv
 M6guE8z7shk8aiRGGDFoVZtG+ptF4lngkJcxbownhub1R8IKfBlsvkVCXISNnoq29vRXivmrV7o
 RQTnKwXtA+CQgXQypiWm1No0pUCLScYNMrRTAtIgNzTCoUT8tRvpAifNEP3ojSgq+6g+52KvmhK
 seW2ZE4SiHchBWzLk1J1gbsVtpXcaoyJTpn3NqmqaVv4DArrMQZ4JjswIsVZJhFwXwUOOLXzYr8
 3BjeXgT1+r39hhcxaHHw9gTgyFbWSv31tARwfZRWAEp1YYF8jrZKKwRruqmZSmfvgXVAbT5LS3F
 oAMCmvD4mWJoBEEdamA==
X-Authority-Analysis: v=2.4 cv=LpKiDHdc c=1 sm=1 tr=0 ts=6a5750ae cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=Lhg5KQWfcAQ2K9Y1sJ4A:9
X-Proofpoint-GUID: TEOsspSJ5vdMVSbbm2nrt8WgT2NAnqmj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150090

When a discovery filter is active (filtered_discovery=true), BlueZ
unconditionally calls device_set_rssi_with_delta(..., delta=0),
causing every BLE advertisement to emit a PropertiesChanged(RSSI)
signal regardless of whether the RSSI value changed.

delta=0 is only needed when a client has expressed explicit proximity
interest by setting an RSSI or pathloss threshold in its discovery
filter. Filters that specify only transport type or UUIDs do not
require per-packet RSSI precision; for those, the standard
RSSI_THRESHOLD=8 rate-limiting is both correct and desirable.

The problem is triggered on dual-mode adapters by a transport-only
filter (e.g. Transport=le). In merge_discovery_filters(), the
transport-specific scan type (SCAN_TYPE_LE=6) does not equal the
adapter scan type (SCAN_TYPE_DUAL=7), so has_filtered_discovery is
set, filtered_discovery becomes true, and delta=0 is applied even
though no proximity condition was requested. With hundreds of BLE
devices advertising simultaneously this generates hundreds of
unnecessary PropertiesChanged(RSSI) signals per second.

Confirmed on QCS6490 (BlueZ 5.72) with Transport=le filter:

  adapter.c: filtered_discovery=1 (current_discovery_filter=set)
  device.c:  device_set_rssi_with_delta() rssi=-86 delta_threshold=0
  device.c:  device_set_rssi_with_delta() rssi=-79 delta_threshold=0

Add discovery_filter_has_proximity() which walks discovery_list and
returns true only when at least one active filter carries a real
proximity condition (rssi != DISTANCE_VAL_INVALID or pathloss !=
DISTANCE_VAL_INVALID). Use this to gate the delta=0 path.

Other filter fields (transport, uuids, duplicate, discoverable)
express capability or content criteria and carry no proximity
implication, so they are intentionally excluded from the check.

Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
---
 src/adapter.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index fb95e8553..1023e43a2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7255,6 +7255,22 @@ static void filter_duplicate_data(void *data, void *user_data)
 	*duplicate = client->discovery_filter->duplicate;
 }
 
+static bool discovery_filter_has_proximity(struct btd_adapter *adapter)
+{
+	GSList *l;
+
+	for (l = adapter->discovery_list; l; l = g_slist_next(l)) {
+		struct discovery_client *client = l->data;
+		struct discovery_filter *filter = client->discovery_filter;
+
+		if (filter && (filter->rssi != DISTANCE_VAL_INVALID ||
+				filter->pathloss != DISTANCE_VAL_INVALID))
+			return true;
+	}
+
+	return false;
+}
+
 static bool device_is_discoverable(struct btd_adapter *adapter,
 					struct eir_data *eir, const char *addr,
 					uint8_t bdaddr_type, bool *auto_connect)
@@ -7451,7 +7467,8 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 	if (name_resolve_failed)
 		device_name_resolve_fail(dev);
 
-	if (adapter->filtered_discovery)
+	if (adapter->filtered_discovery &&
+				discovery_filter_has_proximity(adapter))
 		device_set_rssi_with_delta(dev, rssi, 0);
 	else
 		device_set_rssi(dev, rssi);
-- 
2.43.0

