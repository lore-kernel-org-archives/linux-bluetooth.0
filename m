Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB6E3B0ADC
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577703; cv=none; b=tBYP0K0vqazL/SpHAATTmU6UfNU5fgRrO11u2BdtyAD0vFUtUVcTEX++jLg8HKeUA2Vl/oF7jOLgEf79T4Z4yAOV6kSV3CDkswRa8NQFrNS8eNuYOuAWF+Bvda5M7gM0Ibdg/EIYNZKg9iT2MK3ssqkgOgDK/RKmK5HEL8lZZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577703; c=relaxed/simple;
	bh=Cod80C/9rxopc4PQ5c/hvRl+4W+KSMzKkLsgMDIKL0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AQsFXxeqd0e7m7RKemsB5dZ9XyjtWRIZu5CkaFpxrV4AVCZQeT20VdznbKS8/THxlWPN4EVEWZaeNLlYmqQn28R+2ESnbso/FvTXHKQyTniK9bsCvZR6IWOhIz/+HhfLjO0uH2R3b9iXILkRwmm8K0zWiyQg3vCTXEfAn3pySUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p7jIsowB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OYLQZJbS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p7jIsowB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OYLQZJbS"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6695xvPe710658
	for <linux-bluetooth@vger.kernel.org>; Thu, 9 Jul 2026 06:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T/4RplMrDbSSJmMVfLr4Teoh6ZObIlQR+u1lb+1q74E=; b=p7jIsowBW2u/IDHy
	u864+7jFHSefZ3rD9HEJeXLC/xH+s2DNBZcqahse+s0enLszl4g7iH49sdSzf342
	8B7eUWwXyKQ1J9TDxqEexOskqRmXc0e/bufwmuX7SwiL0yf2ZZIS3XSAQaaDGTkX
	fH0kmLhukBVLj8lNYl51nlEdUilAQVxrPo1bmEGf+1SLe6tWJZPgGyAiuF4OBDzr
	eXE2lk+iKByWSwBISBw3V69JH9QnFrLFAdDJKxS28YXfLO+U0Dtx/Ecw1czTp+rP
	odXk5qMs9/qBKeRr0v5JMwQ9Buwa4fhMmH6OOthMzKgEXJsKuXoIHJTjqNHeM7kz
	b7XUDQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa55vg825-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 06:15:01 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-847c049cdecso407158b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 23:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783577701; x=1784182501; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T/4RplMrDbSSJmMVfLr4Teoh6ZObIlQR+u1lb+1q74E=;
        b=OYLQZJbSwwktGqlO0DsJILbcsixdw318sjGZodJqN/fyM+tfcZ3rgi4NIl9eqLloRY
         6LJMBJazKuwOZFElrCuMFwouzEyq3/bwVT77i2G0FkpI9YxtA3CqEF4jZYRWKX26af6D
         uWFAF4TC1dwc9cFcz0aM82kAWnwL1gFkqFaeQRFMin/Pn8rU+aiN8J/r713N8qxjn35q
         lXX8GhoHUD4Ao06/ndzSv9uVKqKdMyPZatsAe3Vf/4/uIAuXCxKKJU12cMHc5W7by/cz
         YiHK0N3NiCsHSe9asneS/zzBkt24ZJ6oYa9gnxk/zu1Q/M1c9O34aRZVJ9Jo+39B2Sz/
         GXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783577701; x=1784182501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/4RplMrDbSSJmMVfLr4Teoh6ZObIlQR+u1lb+1q74E=;
        b=SwjpY8sYaEu0+Agf1p0eBN2rntDD576hzik7a7arHL+c655k20yHqYptOYq/zPL0Gh
         JnAYNNdF6aQZaOtCzmrPsKzn7/tCBWpvJR/3yhsbJJJAkfc73A1PIUkqL+vCUmQgQjLK
         aq0PQbEA3/NfgkrPkHDtx9VZCzK5fi7UIS5BbvfR88U0olAC9Nmw1t3lobEELK5zB1kr
         tSigL8SIsTiszbYJasnsy9y6XMlFMRcrPwbHoDl1VlFk6j0n43mOu6v/ycea9Z/7woIN
         oHBGtwfkg64OdRFcOxjJI2rIY5SHqZWkIw7fJU0B2iB2bgPhi0GxZGpCSk7lLpAIPsyz
         SEsQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKk8ESvOa+s1JO/DvWgHTJADE1fBgnc376bh3oD4kvjbSxWGlzWAaQTH1KEpFTAWmY0HIl2WADRi33md+266k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgm+LVCi7W4pYs6buil6KXglLCt5QGgdLw7ke7TevQ2Xd6HfnP
	n6qCvsLOUgfeu4L0vwiUsMQ4ymq+pRNvdsOuq7zhBGW5qyYhBn5z2EDVrCmg1JNa2UlPpatZkOa
	4vlxXqofyn3sOUd/Zs3HotQaLGeW1RdGI04NNO57xKXhJ3PgC+ZceD3ksNwVSot319CYyJes=
X-Gm-Gg: AfdE7clNYabbbtnNjao7SUj80oWFi7ZLufP+tmmN8acPOFaZ4pL2ZPk9ui9IqAWJ68p
	stgXS1edXGZfOCegtxo4+FXshLviwXfrhHlKb5IjOC1uveZuLDvyrk6qqzp0wPijdW+x7r9Pda5
	jaVcE0cjTqD2yfRhLLXsuRnF6knxdhA1rkoR6ONsA6Itbv0lOIRy2EmdNgbGHrBfPbxLEevWWPw
	H3+Gne7f6YiPn4d6tXy/x9XkCtEi/JykcFdBwm61BaM35CAXt3j2ijuFJSTClPlwBxVyesKW0C5
	jL5NEYuyZd3URpiIX2sXEDjGjuydAZfEETYPXlRkORDEaSG5BtcKyaw/+vRz6MpqJIIPkU+m4qJ
	YLl7PYrPHCtVOAlEnsJTYt9Scvld8n95ehEKWPJMui3Usj9uwLPyXJXN+Vg==
X-Received: by 2002:a05:6a00:12dc:b0:848:3e03:89f7 with SMTP id d2e1a72fcca58-84855eb4995mr1634168b3a.7.1783577700645;
        Wed, 08 Jul 2026 23:15:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:12dc:b0:848:3e03:89f7 with SMTP id d2e1a72fcca58-84855eb4995mr1634149b3a.7.1783577700231;
        Wed, 08 Jul 2026 23:15:00 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbfd41sm8146032b3a.57.2026.07.08.23.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:14:59 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 23:14:58 -0700
Subject: [PATCH 1/6] Bluetooth: coredump: Introduce and apply
 hci_devcd_state_name()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-btusb_prep_qcc2072-v1-1-d835b187fd01@oss.qualcomm.com>
References: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com>
In-Reply-To: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1NSBTYWx0ZWRfX4NbSoMYjPPyj
 4PSyBhMvZcYx1X404uIGvF965aJnRPFI7jDfOTZT/N/Swgx0Pf2XTkP9+5puok420BSlyTYwhiD
 dMtZ5l1ZF0wpAWkzgSyslr7Wu8ptqTf03+V397x2FIn1mNk1bNrMQoX69tpDnG42Ilc+tLfm0o6
 RWaB2qxgK4mIMJzMMGHk5dH7VNPKHNZzhWrPtN4SR9ihYu7LMalrgLvcBcgsQml+M2hmwEAWTpJ
 l/ggWJZPercWPce2gVS5bLz0GDSKWlToKhrBA297crCCravuX9w2+0v634zMWK2mn9aPyqEvPWc
 SBS5RhdAk+dd6vBUjoNFjNuvrU/3Ejm6HN4OUIx2vwNhBQjfsu/wBtJ/TiYpkeoXahZAai19Cfo
 q7tiZIDMQMwLlxxSHC5l/cm+clPwssD9FcqhN63xa1Z2jNsOKjmuvA+j77g82/2Ogp4bNJpbuhZ
 IQzmNWWip9wx5i+D9xA==
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a4f3c65 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=-o8gAGCozA265rLodYYA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1NSBTYWx0ZWRfX/uc+FtwOkYlm
 o/zwKU9tCZZ1qBoZevzVL2TwQ8UrZu80770oqjUQqIcamwt7AfAccp0KIGLYfNYIp9L/ZRNrmgZ
 nKlA9XcIh86PsnMaJgtOM694/iNxaWQ=
X-Proofpoint-ORIG-GUID: lXQ3HSJV36UQaO1urTsdkB1TQ1tk8iH2
X-Proofpoint-GUID: lXQ3HSJV36UQaO1urTsdkB1TQ1tk8iH2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090055

Introduce hci_devcd_state_name() to make devcoredump state more
readable, and apply it in coredump.c. Also remove a trailing space
in two bt_dev_dbg() format strings while applying it.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 include/net/bluetooth/coredump.h |  7 +++++++
 net/bluetooth/coredump.c         | 31 ++++++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/coredump.h b/include/net/bluetooth/coredump.h
index 72f51b587a04..ab85a6adfffd 100644
--- a/include/net/bluetooth/coredump.h
+++ b/include/net/bluetooth/coredump.h
@@ -60,6 +60,8 @@ struct hci_devcoredump {
 
 #ifdef CONFIG_DEV_COREDUMP
 
+const char *hci_devcd_state_name(enum devcoredump_state state);
+
 void hci_devcd_reset(struct hci_dev *hdev);
 void hci_devcd_rx(struct work_struct *work);
 void hci_devcd_timeout(struct work_struct *work);
@@ -74,6 +76,11 @@ int hci_devcd_abort(struct hci_dev *hdev);
 
 #else
 
+static inline const char *hci_devcd_state_name(enum devcoredump_state state)
+{
+	return "";
+}
+
 static inline void hci_devcd_reset(struct hci_dev *hdev) {}
 static inline void hci_devcd_rx(struct work_struct *work) {}
 static inline void hci_devcd_timeout(struct work_struct *work) {}
diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index 720cb79adf96..3d4c2194ef43 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -30,8 +30,9 @@ struct hci_devcoredump_skb_pattern {
 
 #define DBG_UNEXPECTED_STATE() \
 	bt_dev_dbg(hdev, \
-		   "Unexpected packet (%d) for state (%d). ", \
-		   hci_dmp_cb(skb)->pkt_type, hdev->dump.state)
+		   "Unexpected packet (%d) for state %s.", \
+		   hci_dmp_cb(skb)->pkt_type, \
+		   hci_devcd_state_name(hdev->dump.state))
 
 #define MAX_DEVCOREDUMP_HDR_SIZE	512	/* bytes */
 
@@ -50,8 +51,9 @@ static int hci_devcd_update_hdr_state(char *buf, size_t size, int state)
 /* Call with hci_dev_lock only. */
 static int hci_devcd_update_state(struct hci_dev *hdev, int state)
 {
-	bt_dev_dbg(hdev, "Updating devcoredump state from %d to %d.",
-		   hdev->dump.state, state);
+	bt_dev_dbg(hdev, "Updating devcoredump state from %s to %s.",
+		   hci_devcd_state_name(hdev->dump.state),
+		   hci_devcd_state_name(state));
 
 	hdev->dump.state = state;
 
@@ -245,7 +247,7 @@ static void hci_devcd_dump(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	u32 size;
 
-	bt_dev_dbg(hdev, "state %d", hdev->dump.state);
+	bt_dev_dbg(hdev, "state %s", hci_devcd_state_name(hdev->dump.state));
 
 	size = hdev->dump.tail - hdev->dump.head;
 
@@ -368,8 +370,9 @@ void hci_devcd_rx(struct work_struct *work)
 			break;
 
 		default:
-			bt_dev_dbg(hdev, "Unknown packet (%d) for state (%d). ",
-				   hci_dmp_cb(skb)->pkt_type, hdev->dump.state);
+			bt_dev_dbg(hdev, "Unknown packet (%d) for state %s.",
+				   hci_dmp_cb(skb)->pkt_type,
+				   hci_devcd_state_name(hdev->dump.state));
 			break;
 		}
 
@@ -551,3 +554,17 @@ int hci_devcd_abort(struct hci_dev *hdev)
 	return 0;
 }
 EXPORT_SYMBOL(hci_devcd_abort);
+
+const char *hci_devcd_state_name(enum devcoredump_state state)
+{
+	static const char * const state_names[] = {
+		[HCI_DEVCOREDUMP_IDLE]		= "IDLE",
+		[HCI_DEVCOREDUMP_ACTIVE]	= "ACTIVE",
+		[HCI_DEVCOREDUMP_DONE]		= "DONE",
+		[HCI_DEVCOREDUMP_ABORT]		= "ABORT",
+		[HCI_DEVCOREDUMP_TIMEOUT]	= "TIMEOUT",
+	};
+
+	return state_names[state];
+}
+EXPORT_SYMBOL(hci_devcd_state_name);

-- 
2.34.1

