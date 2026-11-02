Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607564;
	b=HGhetX/OP6rjX7jqXeZrYr/njSCtvF6dJHVtaxJrYcMpBKCti4wGfwtuFhyIJfkkyO6K
	 7M9yhaMt5YkSTlscMp2oOW1/usMVd2OUxb/VhjMSl/YcyJrzNwfz3Ia1MorafZUAOBkER
	 iqxL72TV3bqlnBAXjonlfcmlT2zAKrfLJ9wqh6OoX+NbdAoWvEwUNwlLKFsEc0y036BMT
	 JZgMgxc6h9KK9f5iaYt6OxMuyxW4w2WCLO1BKQJt9PaQaU+LeXVLZZ0EkU65FxBzzBVLq
	 vBhymVm4Rap5QwvARN+Pt5K3+oqkS6qUljktXxieohUURHF0dfC+EpUkM0wTR8JOz/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607564;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-QCInternal:X-QCInternal:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=G3covaJBhqRPZSwmm9/xG1itogfgRRxwGdACx8Vu8CI=;
	b=PN2WJ9oMjjFCLAJGYC6Hxgj3+SFvys+Rmamx4yEJrJiKL3WlJJ0oBh9+z6nAgPTuG2Pb
	 yW5BU4N7zuck0hHFHi7BA3i4m3Dk4Iw+1oYtGKVjEIFq40Q4ER5cibRnqjF2Ky3LCZEXD
	 ontKF2Yl47kIDqFXj7mPaAPYmSaC1Vv1Aws9iSM/IkA3NeuivM7Fy5V/vBwpsd988ZluR
	 /PEUwCLHHaFSAj10Pru11Vak4OEMgGUoB+Eh3wfzY8pADZLRhTAxT0wbtR0E5LffZf0NO
	 u8efxUqQDYRAum4/OfECXruFLZsdVPACbjZ1ADwljUxXKAC2Asav2Mj3eJ38pTvZd1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=evAZc7Wp;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4EE606A324
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 08:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A4EE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=evAZc7Wp
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A23vVPQ2192546
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 08:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=G3covaJBhqR
	PZSwmm9/xG1itogfgRRxwGdACx8Vu8CI=; b=evAZc7WpDUNObbC553CkYE0ED64
	jixgKhxme11IXbs9LbWxEZn1wAUHZrx5QsHjj5jfoSzvCLqp2lT+kYxVHn8XIlW6
	Tk2173rBojTBfj0A10VyzKpYTNN4ec3+7lvPRquHlRp+rtyeeVQMn4vJd+YsurrN
	a1TuA83AfnM+KK4GoiSh8IZi5mH+frHKkUIfIRaUV48QO011sK3LAr/59JBtzte0
	QTjZLgxlLvkNOsrRddE8dHBaaQD388uDmg91lX9fpbd+c92ZuD/0t4VFPaHTYUrx
	/HAwe/1E3rnehp+CK2+kGVTqHSU9hw3ex9Dyv2xkGH7b0qAfeUSEJIT/gXQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn93enr5x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 08:19:22 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A28JLa73331080;
	Mon, 2 Nov 2026 08:19:21 GMT
Received: from bt-iot-sh04-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 6A28JJfv3331043;
	Mon, 02 Nov 2026 08:19:21 +0000 (GMT)
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH BlueZ 02/15] shared/rap: Reset the readable Ranging Counters per connection
Date: Mon,  2 Nov 2026 16:18:59 +0800
Message-ID: <20261102081913.1623864-3-cheng.jiang@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfX0kJeWnhC39Ve
 pZiycLD0nwUYOLx+JzanDU8F8aUllq9tA1bb6fBI2UBSYFFvmI1WXGbbNfMzvi2zqGjnaUxWN6A
 HPe5qaQAQvJsXC3aMtp8rKoOX5LmbOFNxdUJ4+KjtXrEnpUq6NuKQNvejrJyk3Vq/vUnH2TvyV+
 vXdJZarmUfKI8H2oDM3UlyJuXOzcTHbHEYHNDqGb6cdQhXuE/jdrJ/SX2PvdBEOK5MDmD+iUkie
 wwPKntdefx3uZMVFbnF4Yxuvz+E3EObLBk7HPrgNIlhyw5jb+OMd7ZWOsr5ieWwarWFmHvJCR7v
 gzd3RSBSOVWQnRylgC8IGk4hgsDbuNEg3dtPwZeE21uNJXb+1fLAwG5HBKV/8q500HznoVBQlGT
 TEKi38BjgidYc5DRx4rPusyKI99aCVS78LUW+qyo3/1OEzquF7AYFzw2mbdv/HBa7MRb1qSgq1O
 KxMPxUy5GdBsi2AM+zg==
X-Authority-Analysis: v=2.4 cv=FciiV5+6 c=1 sm=1 tr=0 ts=6ae8478a cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=zMtFAdV-m4o6wO3_b5EA:9
X-Proofpoint-ORIG-GUID: glokAEtnG-Wyt0P97EdWHaCZpxVpY9-P
X-Proofpoint-GUID: glokAEtnG-Wyt0P97EdWHaCZpxVpY9-P
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMiBTYWx0ZWRfXwwKdIbu4E1TJ
 7by4sAmNznUnXSIkCynqVwX/ibctGLV7FiqLkM0Hbeydx+AWnWoH0wCjXNHnkdS2YiAavk2bVHB
 8n6tt035xNSd58FnpiURKQ74w0PyaAo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020032

A read of Ranging Data Ready reports the Ranging Counter of the most
recent CS procedure completed during the connection, and 0 if none
completed; Ranging Data Overwritten reports the counter of the most
recent procedure whose data was overwritten during the connection, and 0
if none was (RAS v1.0, 3.4 and 3.5). Both are scoped to the connection.

Neither counter was cleared when the link went away, and the local RAS
service outlives it, so the value counted on one connection was still
reported on the next. After any run that produced ranging data, a read
on a fresh connection returned a stale non-zero counter, which is what
RAS/SR/RCO/BV-07-C checks in its first step.

Clear both on the local RAS service in bt_rap_detach(), next to the
other per-connection state it already drops.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/rap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index ebf12a6bb..e0aa965e5 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -1018,6 +1018,17 @@ void bt_rap_detach(struct bt_rap *rap)
 	 */
 	ras_ondemand_cache_clear(rap);
 
+	/* Reads of Ranging Data Ready and Ranging Data Overwritten report the
+	 * Ranging Counter of the most recent CS procedure completed,
+	 * respectively overwritten, *during the connection*, and 0 when there
+	 * was none (RAS v1.0, 3.4 and 3.5). Neither counter may survive the
+	 * link it was counted on.
+	 */
+	if (rap->lrapdb && rap->lrapdb->ras) {
+		rap->lrapdb->ras->ready_counter = 0;
+		rap->lrapdb->ras->overwritten_counter = 0;
+	}
+
 	if (rap->rrapdb && rap->rrapdb->ras) {
 		struct ras *ras = rap->rrapdb->ras;
 
-- 
2.43.0

