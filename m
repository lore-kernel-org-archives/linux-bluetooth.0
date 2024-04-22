Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1C21514F5
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797207; cv=none; b=adjKYgpUIVPgLrOM7fxyNqAXoEPj3mk5KYjhZso2fiSxnUf928DJyumHe15jC2vuW9ouI0mGnTMHbuNFJCv2ovB7RRH9zJCqUuyx0f0WL7+QtYReplKgrVvZ5xTgCAB/da+ZrWviMCpnyrOc/US/OvyjoPi86RCDnqhvUpIYF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797207; c=relaxed/simple;
	bh=0ezOc/bmC7SCaHcb+Kag0R04QTvsUPl0q6Rgb8FFqmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYLHp+ThhVK15w0EG9bLQazwie+MTFCJKgtmM6P09kTZYmQEtGRbekYpxv8C73qS7Ef2DxnrSSLoyfZA9DxUwWyMEzH5OggRhh2kreeFvHqWDDpe9VKCYx77a1HfKuljZg88QaffuTIlUwTaKhH9PNC6lOCmsRzpwDuGiFEJQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Oe5hHddZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Oe5hHddZ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MC0CjO006338;
	Mon, 22 Apr 2024 14:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=K+1YUbaVDaDBVEOYT6An
	p5fKNz0crd+O4/59bS+O2lw=; b=Oe5hHddZb/nFw0bQi+wplmJmHC/5XZUkTONJ
	X6iyGq9Z9jREBu55nNo2cKaOQu2+j9Y32zf34H0Kxo8GIy6WtFOMFAs2Ro64ogU3
	CX7iDLjL4crNvINs2DaT3Co0pCaTajH3hWYy/i5dFIvTgZCBzZ+QotF82AUNIGhe
	qa1w8VzrWj92VFW47cdF+tyxO78jWUDdQO+Ftj1FdYLH/ghrLIFzDKfIxmxzqgEV
	o9TSfDFF0FA+V1uWCMwWYauWoTtiVnn9EusDd7YmbwkBRU3T4tt0jG61QTYL6N2z
	7kMsgVQ/5Ycny+1nt+aAWmXO7cI7fKqmuQz+oi6s12NYk1q6gw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xmxq4tscn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 14:46:40 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MEkd84012746
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 14:46:39 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 07:46:37 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <quic_zijuhu@quicinc.com>, <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v1 RESEND] Bluetooth: hci_conn: Remove a redundant check for HFP offload
Date: Mon, 22 Apr 2024 22:46:34 +0800
Message-ID: <1713797194-22982-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702055834-18008-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1702055834-18008-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qZkzayK5ZwhrSvZ1frtluUaWufWBTa_i
X-Proofpoint-ORIG-GUID: qZkzayK5ZwhrSvZ1frtluUaWufWBTa_i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220064

Remove a redundant check !hdev->get_codec_config_data.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 net/bluetooth/hci_conn.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a3b226255eb9..81166a5bc034 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -242,13 +242,13 @@ static int configure_datapath_sync(struct hci_dev *hdev, struct bt_codec *codec)
 	__u8 vnd_len, *vnd_data = NULL;
 	struct hci_op_configure_data_path *cmd = NULL;
 
+	/* Do not take below 2 checks as error since the 1st means user do not
+	 * want to use HFP offload mode and the 2nd means the vendor controller
+	 * do not need to send below HCI command for offload mode.
+	 */
 	if (!codec->data_path || !hdev->get_codec_config_data)
 		return 0;
 
-	/* Do not take me as error */
-	if (!hdev->get_codec_config_data)
-		return 0;
-
 	err = hdev->get_codec_config_data(hdev, ESCO_LINK, codec, &vnd_len,
 					  &vnd_data);
 	if (err < 0)
-- 
2.7.4

