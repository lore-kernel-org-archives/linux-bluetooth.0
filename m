Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266883;
	b=WUx5X4zYb1ApjxQdCfwBNEbbDwlkUaga4p6nQeblqAk/f7B8VMm5ZoBJJzOFCEmdcHjA
	 KoGn08BhRmzY30hxRRIuQ0c9wS0BUCXM1x2Wr1bn5F0Lds9qwaLXoE6RETBjeN0jc4uKN
	 70/VmJDcqVVgABpCxcoJnoHIKqR3h/OLggNpfE0wQsIKpYfoAjO+4+AkfBZ5hyZyFJhW1
	 cx+AExY0mZ6fcG+cgK+Xf2UnilrDTmWnAiTu9+z1/m6s0Onde+oCGLkSjU1K29+Ywm9cY
	 J6tSCjXt8mwnHsayy3PQrhuxVJ9c+/SM1roASCCuG++sfSofQL3T9ZVFvpkEfPIWdTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266883;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JTHGoOuncVyyz23SHRQpWBGo31F+kUVmJ+b/5MlFdEA=;
	b=THbSuaNVJbDESUlhXZQhQEIU7Vdb6pNWLils/v4UDhGE4ng1o+a+SPGWmnWR6GlYCfcp
	 NNsjcbTmzry/YGSGOREVeUu1prgYcC5hvNfMKN5E80sH+hHkTLiHO8P4oWwV6rU4uuo3q
	 NB9a40OfsgMi9+0XTXYOAWig/aNUQZAbNpwZfivwpcJGxPmlhHZiYvkTRvS3Hy2soJBC2
	 kNsdVPBtj1IowDwqXAJVjTptw3+ocYsymVWrU8Gvz8r1eF0LOdeI7hCOb2wwsl0bmbtse
	 EQYckeMY/djWODtnJyoaEJjWIjlvTbstmO3IIpKNa/7KreIYG1Vsq8wWNhT9q1nds9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KsgjQtZI;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA98606A31A;
	Thu, 29 Oct 2026 09:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FA98606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KsgjQtZI
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8vHUJ3766082;
	Thu, 29 Oct 2026 09:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=JTHGoOuncVyyz23SHRQpWBGo31F+kUVmJ+b
	/5MlFdEA=; b=KsgjQtZIuiozwswFr59FMp1BTN3qP4PWmyEZFrC3JBvco2K3E3v
	9I3jfmLNX3ctVFtWrNxyZVHZvQFg3l5XC5Z8NNdSRx1F0MKY8cTVJ4YKj6i6VXPu
	Nhqqo6m2WeNJfW0ISF9s02tPIHxGDhB1bYLW6FcMSIUlSc1/vHfrDOunVPPzUXPL
	/X0HUVZG0f3I6hR3VoCOdrQCxyjQuIa/sMwwx3YqBL7W+jcGrDxwjuqr6ZFi7auz
	G4OxkVUJM/VTsKn5X1oqTsri9gsr+QgSKCiPleJqagzDJrG6Pcn5rZbjpCL/bdML
	DWFNc7Q/x4ZclFkzaglEWft5Sy7WvkMs65g==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpgptxqd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 09:41:18 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69T9fGWO680360;
	Thu, 29 Oct 2026 09:41:16 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 69T9fFlO680353
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 09:41:16 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 2ACBE279AC; Thu, 29 Oct 2026 17:41:15 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1] Bluetooth: L2CAP: Ignore connection responses with wrong ident
Date: Thu, 29 Oct 2026 17:41:04 +0800
Message-Id: <20261029094104.2952304-1-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzNyBTYWx0ZWRfXz75S4wTudydg
 gYuyP2AtAjlcWdvkpDMlJJ9y46PCAbiL1KSgoOxUARIJktLRjc28ALEn5UA95tioZvS3IX0WsQm
 JhFNKk/2QQ+AhbP+6FU/750AdxwQgABDQCgsuuj4RBdUOX9tMI/Pk8YOa+7KcWCth+DYPtvS/wO
 prLToRBR7FLEH71HXwcGmPkv8nSCTEvT5ZUlg3iV72l4yoVfT64N0Bm4k9eZumtuLmMfiI4KJ1d
 JvkyIxR6tJv02Vx/5hGEPHY7xEKwo6gFW8bOz1GUQ4FtiKqCZaIYt16QxvDCuwwHxH+61ZV/vL5
 Rwi5yOcIDe2Uev0NT/K1STZx/SXfnQVtS1sftwZ4VqBRKihABCgV6oVflRXUraJCK0VFjaMBwFv
 C32661Z83R4QlmJLb8bSYp2NC5Z/abkrntiYHIZ7DW60mcC9JGuKHwmgIqJ+HsZ9u0+5cBqrb1R
 R0asKaPDxhw2FBm9a4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzNyBTYWx0ZWRfX7TJAUK0LEgCA
 LXMTFktHY5CQWQ1J8vhh3w5eVJWrsFK7mQnZxKIgL1MtFB5G0OWWtW1dijbg3DqxJgIUSD2bPgU
 fZ+DsLkOAMaZNzfMdfoLWnXzw5UaWh4=
X-Proofpoint-ORIG-GUID: 9GbqUGv2ghJh9jGwKREdmPenurSfUUQk
X-Proofpoint-GUID: 9GbqUGv2ghJh9jGwKREdmPenurSfUUQk
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6ae314bf cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=p-q-TKNVD4YfABw5gyUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290037

L2CAP/COS/CED/BI-28-C requires the IUT to ignore a Connection Response
that carries an invalid Identifier.

l2cap_connect_create_rsp() only checks that a connection request is
outstanding, not that the response answers it. Add an ident check
against the pending request so that a mismatched response is dropped.

Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
---
 net/bluetooth/l2cap_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 83b622a42811..70ad30b091e4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4480,11 +4480,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	lockdep_assert_held(&chan->conn->lock);
 
-	/* Only accept a response to a connection request we sent and that
-	 * is still outstanding. A channel waiting in BT_CONNECT for security
-	 * or the feature mask has not sent one yet.
+	/* Only accept a response matching a connection request we sent and
+	 * that is still outstanding. A channel waiting in BT_CONNECT for
+	 * security or the feature mask has not sent one yet.
 	 */
-	if (!l2cap_chan_connect_pending(chan))
+	if (!l2cap_chan_connect_pending(chan) || chan->ident != cmd->ident)
 		goto done;
 
 	switch (result) {
-- 
2.34.1

