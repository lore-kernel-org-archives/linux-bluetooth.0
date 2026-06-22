Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF032BF42
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139951; cv=none; b=BTioxjdE8ztXNIEkg1AiTfO787SgXOynwWJBaD/L1rb51CQZX/CXuXW/zD4mzXxMygHZVD0O5cP+b9o0vPTYVFFYo2B2nbXG6dU6JD8LGoVqqWcEVsSElhiftUxJeyxfr1O/n7PhdO0ffSCAAYD71vpugsz9yYWrUn5hqY1f6oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139951; c=relaxed/simple;
	bh=NLLKBnu6lqSK3tKr0zf8Ol0FHau/ZsBEgltC9ss3I24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNfRpUyC++FKMFWcNLwmtqTCeBSTAXZgMEeFxFcjt20RuBo3HmuNYysutYgEfQY6qngw8h0fUHH9iaBjCnAaaNHJ2MIUSTEQ3EFbK8KZvWOTx3sdJdMdR7wmZNpJtTIupuxXodmsfEkJovZe2YRpCJ4UrhrH9gpMe2/PjEcKmeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G6RTs88E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FCuP6h7H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G6RTs88E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FCuP6h7H"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDGEwx1338459
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m8oQmHlpKAP6CN522kTwBxFXdDgRU5YMpmBBrLHJmkk=; b=G6RTs88EJTSwo3Du
	8ECKPNc55uT0zcnwwBTIGpQ9UqG+RFrOWM9agJnxliUG5hS466kIZg1dlS/5z4X0
	8zQgracSCqadof8EoyOIpgxTJlNiNFKysjR2ATyAIdqE8XutEP4m/lIcEIfQzD8x
	Kcsd+oXhqdx7k+zAg2Oh0fRzPzBtgGaR1BNFKvz6QUoDU6/hd1XSIkRmd1dTcctF
	r4QgaZ//WFyIUIdIpNZgFcG4ybHpienip2gtKpVbgbbIJSj330L2k1gZbyKQsqJV
	n9EsDHq7HsCHI1XqIwcPlRJ73gFUWfW24HRN8YIR1Ndc2qg9A47h9Fsa8/x2Gfn2
	qbNE3g==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37h8x73-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:28 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-137eced000dso291679c88.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 07:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782139948; x=1782744748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8oQmHlpKAP6CN522kTwBxFXdDgRU5YMpmBBrLHJmkk=;
        b=FCuP6h7Hf29J0HBiEgqAqks69ncOQ2KxNaxh0NwOEYYqfMqcf67UY6vsJkaTHcvXOo
         4cGTe1ye1B/zEicRPPxOxezqVAzhduGDAJW485L1fwyZhSFL/E9idyTWYrdo7Z0McJ5w
         oTfpGDT7c4tDVcqWwn/RvLiBMFlB+L/QWdM8Vvo67evew6NXeiq7LOYsL0zLJJNyvKAG
         ZOhJpPJPO9Mgxixs1u/ggbvM3VJIN0cAFHkNydijwW/6o0C3C+3hdI2/b76th9SE14tg
         /QLmA1XcaoGB3UcAuJ7tz58TEhQMpnHEFkt853go3c8O1sTiD9/6i2y51zxNcrvi+tKe
         Qx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139948; x=1782744748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m8oQmHlpKAP6CN522kTwBxFXdDgRU5YMpmBBrLHJmkk=;
        b=czyo5mOmBy1e4cGRiu/P0Bi36q+83MDzxIKKIV8tGKhOOK7i7+I32fjvh1ouQAI8N2
         ZpA03q3XmApeduJaHpw2JmvoQadnpAN+lggOzcIozP0ru6dPgDw9HzhKvcadr2zmEopg
         rFRmdyYHHmrAxmIk32x221DMeB4V2+WmTTk1Sxxel9V7tH3WJPEbejsUxVc1hNEkCaQ7
         LlsyzB/6pxOLmVvrIYHLPv9DuNQ2fhFDbQJY8ECpAmgfJpEKuSHySRCN6IR7zdCk8gTs
         kItMNnSCWRnNTIUOtyrHO3ZAKApIBIADQc5hIU3Xgf3s4JudcNe04z8D4XFrVRNikZCp
         mglQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq91DQOqS2EAoClPlkDe6SMqUMjPXggjaeDur68UdV4fWfJvVxh3fxe/3vZXehzXx9lkVrXSIUGv3C6rf7/Yn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsY4ssw7f/CXs0/GuuIBNAc8QzSTs/k3rSDA0SRzMk9CM9+pz7
	M2FZG5towH4M6+XA62PDrl6TKJvuBBAPMfs6x9x91r1J40L3pGJSa6epYmupe5XfZzBbOai0I6S
	pvmK4fKDltI02QTl3lsAka7OFBoV3M9lCrQ2cDrt72Gx/+BssX+KZ+2B8xKJEEflv+cZF8wY=
X-Gm-Gg: AfdE7cm/7XDixrim8UtqfAtdrvx+nh3X1IFAvERCzQ7Hjrd/+TvXrj4uUnq9dqJa+aN
	ZwHmLC+HR00yBjFmwOGmr1FuWxTB3wdGvdxQA6FVjCypiKwKYT9iu2olev94YmPIrgjqh4wWkEO
	lXUJRYake+feg38EgznbH9LBJtuv0f70HoVxouPmG8kHz55oRmp14z+8YXFs9rwab5aTqgxepX8
	TZF4sdm65uypqum9K8b4/xONWg8yCBVs1IaYLsBUO2PMeWhIjxgCRpNqI8awsrhPltXc5Y23a9N
	AWDbBGfFHWKT8puJNYSEl+tGg7D5sAolz0FPvNTXmfeDN7RO8tcZFdI8TkwOcRjpm0ccHOjRanN
	3qPeZUMQcOwcuxmErkaHqyvekYThUJUhddNeZDr12qngab1jknBD5q9eohQ==
X-Received: by 2002:a05:7300:3b03:b0:2d4:62f0:b2e1 with SMTP id 5a478bee46e88-30c51fc533fmr234951eec.0.1782139947674;
        Mon, 22 Jun 2026 07:52:27 -0700 (PDT)
X-Received: by 2002:a05:7300:3b03:b0:2d4:62f0:b2e1 with SMTP id 5a478bee46e88-30c51fc533fmr234925eec.0.1782139947125;
        Mon, 22 Jun 2026 07:52:27 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm12025561eec.20.2026.06.22.07.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:52:26 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 07:52:25 -0700
Subject: [PATCH 12/13] Bluetooth: btqca: Fix undetected error HCI status in
 qca_send_reset()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-bt_bugfix-v1-12-11f936d84e72@oss.qualcomm.com>
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
In-Reply-To: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: Vp3MqUlplt70Msqw80gdNKKlFY_RptrE
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a394c2c cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=6o5SJCVUQus6q_qBAWEA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfXxNRnqY87A8n2
 +2X5Ineb5f1nbDqy6S3U5iaKm++xWFIsWo2Mra8PIQW6cTyGkXDmN+bxrgENvM+SeUpDKEg9wpi
 jS9YvQnCK3Eh8N+8HHXJn0BF0Lqu5e4=
X-Proofpoint-GUID: Vp3MqUlplt70Msqw80gdNKKlFY_RptrE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfXxuBW0S5bBrI+
 4X48omBDcresVa07oOzUTXQjsc8rPGoImT3s3kNnjQXdz1+E7wY4LWYBQ5Bc6GDSamXIs7OogIq
 sajsQ0RYYPMm+ZSMRijlpv1E1oUS0LYiwUK3aHxDtCCE0IiF7Jq3gmMp5ZmwWq8cxKGQmRQ2l6Y
 Cu32fYIqdgU3Yt6CgudACftWT6iXG03lLhwMlescB1pi0qrtbIDu5qgFLgjJ7xA3nPCvmkPtDok
 q/X2HM526LDhe/mnwx6EUC+qmj0pGcBVrZS4rPMm6ZI1CFLge3mpJqFcS/5GSKT/R6gM7bhlhIH
 3+uc/jHUcmM2O1NTqcOSMuaBA8MYiOWzSy/5K/fisEEkAJ7YAgnkp3sZxRiRk/a1vyPI10cVYuq
 3Q+j6Wj5NCZXJYpsIsPA34s05lCilWLElWZj86twxLmme0QER0JXNEBmzu1bnZqofrnEwmKtXAd
 /Czkfptj308ETEILbcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220147

qca_send_reset() uses __hci_cmd_sync() which returns an skb but never
reads the HCI status byte from skb->data[0], so a non-zero error status
returned by the controller is silently ignored.

Fix by replacing qca_send_reset() with __hci_reset_sync() which
properly extracts and converts the HCI status byte to a negative errno.

Fixes: 83e81961ff7e ("Bluetooth: btqca: Introduce generic QCA ROME support")
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 04ebe290bc78..875216e15603 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -190,25 +190,6 @@ static int qca_send_patch_config_cmd(struct hci_dev *hdev)
 	return err;
 }
 
-static int qca_send_reset(struct hci_dev *hdev)
-{
-	struct sk_buff *skb;
-	int err;
-
-	bt_dev_dbg(hdev, "QCA HCI_RESET");
-
-	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		err = PTR_ERR(skb);
-		bt_dev_err(hdev, "QCA Reset failed (%d)", err);
-		return err;
-	}
-
-	kfree_skb(skb);
-
-	return 0;
-}
-
 static int qca_read_fw_board_id(struct hci_dev *hdev, u16 *bid)
 {
 	u8 cmd;
@@ -990,7 +971,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	}
 
 	/* Perform HCI reset */
-	err = qca_send_reset(hdev);
+	bt_dev_dbg(hdev, "QCA HCI_RESET");
+	err = __hci_reset_sync(hdev);
 	if (err < 0) {
 		bt_dev_err(hdev, "QCA Failed to run HCI_RESET (%d)", err);
 		return err;

-- 
2.34.1

