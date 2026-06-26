Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DB73A48F1
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451201; cv=none; b=O43JOWH88lBDt1gV4BBb/VcFDZJOYOtpQIU4bbYkbkY5E/qO10Epc2wLpp20kHL8uIgIzrcAGdhLoKJGBtFBemlq80xnw2YQglkBiOV6rIghE7kAcBcMStcInVvfKOZdCVZ9+yLw2Si+AUItQonot50bSAY1Ls7pTiQfTtwFcQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451201; c=relaxed/simple;
	bh=H9xhOkSw0q915KQA/XbyIqH1eRVoPvc4hsItfmz+MOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hw/fG4ZMv3SJKbgThIBOEvX1I2TZahiwX03QUqEq+eg83R0awwJSynO6QawM8wMioDcIKIZlp/9PkhWT84laJKpfINBdKU+v2WX5dkHPNUWkMdPvOGMl4esczAOmXgr5iUvNYALy+X+zLmIn/88KnVwsKHfhcGSY+tpsf6tZo7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HfYr8p7g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C1zGym7W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HfYr8p7g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C1zGym7W"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2idqp4003984
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nrFnW2VIL6P+SFxCd0cI09S9qQx3uOqE3N+j5OJXsQs=; b=HfYr8p7gkM03/A2t
	3QhNdAsiUg83/tP5e/Fq8ru/gampEgFosHDjT9EgBNIMJUkxUMnSvQlRFmU8onwp
	1zsQT8UpqX9jVsNcdPejqyIrqGXZzMhIn3JU0EiiThnHjB2joiE/5lCqaKgc1Rn7
	FLdq/sDbNiEHuOgbF328mDbYglHvQq1phKgseSW9dzE0yL2r5y/dzA4Qa18n+wCW
	aZt74HJRcNctfv3wNs4CLmGrbO+5NWKl/QuViazDOX/SBp/Z9FVXlFJNAQDdzhSg
	bO7VCx0EU7W9fRLArVDlhjw5HPmTzMMTMHkeklf6aeFbkrIJfWhArLN8Gl90SLqA
	5yjuGw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1eeq93cn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:58 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c5193b6bcso70836eec.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 22:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782451198; x=1783055998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nrFnW2VIL6P+SFxCd0cI09S9qQx3uOqE3N+j5OJXsQs=;
        b=C1zGym7WfvsShOPFEbWfQ4b4/v+SYerDQNQpbqJamtoGh2tvzbFCvmBMvsXfjtuDib
         EaEJr9QVC2jlKu9+SAQEMcktQg0sMvwwrHAg2WGLuOEHcVm1FYE0UGTVTpe9P9Sl2zRJ
         3SvukszcijmC14HZFdGu/D9Tn4gOfVJpqOU/bsK+8Eb+MCCcxHpBPt9eSJ7wSbfJszr5
         tVQpbTwgINVUB2wvrVBmJv0t9sbGSO6OzoBqACkSpaC5kptTabN+JGBb22q4vujebvDX
         UZ98nSvF73x9ulFFBeiYddrpiyrXqqbZAjpIy1SHlPLAgdrkPBDwNxItDKfipvhDP2US
         N/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451198; x=1783055998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nrFnW2VIL6P+SFxCd0cI09S9qQx3uOqE3N+j5OJXsQs=;
        b=XI6weW5xOWGMN2cUp8+HlW3uSdwy00U17tW56GIO1036nHqA0GCcqsch7Tg0agF3i7
         IMuAj5WgzVog1NYxTS4KJGZsk8Lrz0gGr7DLkfuXKyMWeXKxEGLXagyiJ6j+sf4eQ+ds
         KSZZnjbFg3IjNqm6xqLywF6YHSCc658FGaJr/RZd7ZAm0tZfu8aXHUkr8WVEcb7pQENZ
         D7Z7u7v35VNH8iU0XNdqGjXhqozhEh1FFp51CSLfg0WLlboxzAdaPH34kMdEVjY8nO1F
         CuqgZh7BVntWloGoPW9Df/yQX4COFT1Hlxbpdg29U5leHd7HRI3a1kyez5mGT4vNPbDP
         MwmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp8uAbtnCJp9VGjXdiW1ne0dw1iUaegOYUA2VTRBgqHzGvaPu/myeRghO7oAhDCtaoafYjoWzfBRnkzUnTW5OA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq0UXYj9Us0jC3QfCNvri1WL5Z9ymSveVXJcOE5uzfquiYYsus
	UcDseuuxr5uUPpwo552DzakKsJdVO5Uju02XNNijBAM5Wjxm6vV34DWVCicmuZJbGv26DPQdAS1
	yl9tOvl52kEtP2HhCyJVig3KEZAwEkEp9V8DFk5SdwVtJtm6xsyojIPmlFdjML35V72sPbUI=
X-Gm-Gg: AfdE7cmga2GJreIrEKvvho9+O5k4xrpWkdW9C5YwpFYTdlZu8/Qj6OqQgkG4pNOShKK
	0/BfMQ6xnPgxBVCEz6OTYZr32Ax2XK01yL/aINztneEMW/UyBj7T/p5AU6r8WiBwKIBtJ0nsxiZ
	tkBRpPPH5dRB6UVAdAJswP8ShpcehxHn91/3YFJfoP45OziYrxZ4s8z5SL+l3Hi3kaY5hnsKOMq
	oxacz1R2jgNMR5OMoRUaKX+KNew4rj51hiIwAOsMydEZlImxT/yt9vXlV7+ca+JGO6JX0i2pFJR
	WdhWVjpGzwg6ZWoGi//L2loqEBsL024apQxUlMx/iFRiMyPoIvfWHVofGRot6Q2u66wpli0t8yR
	aSGAL7ER2CKBdyDF2p2zEEGOPF0o1oC69mXE6o2S/aHXc8GmqnbUSYp0HMA==
X-Received: by 2002:a05:7300:6406:b0:30c:6a54:3fe6 with SMTP id 5a478bee46e88-30c84d60744mr3010009eec.8.1782451197570;
        Thu, 25 Jun 2026 22:19:57 -0700 (PDT)
X-Received: by 2002:a05:7300:6406:b0:30c:6a54:3fe6 with SMTP id 5a478bee46e88-30c84d60744mr3009983eec.8.1782451197021;
        Thu, 25 Jun 2026 22:19:57 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm14345291eec.4.2026.06.25.22.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:19:56 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 22:19:52 -0700
Subject: [PATCH v2 07/12] Bluetooth: btqca: Simplify qca_send_reset() by
 using __hci_reset_sync()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-bt_bugfix-v2-7-93396a6f7d5e@oss.qualcomm.com>
References: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
In-Reply-To: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Tim Jiang <quic_tjiang@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX3LBRoK0V5E1Q
 cDk3BooF9VByM8C2TxYN363uOIOwm9sZiafXvuyHkt+CFq1U8kPjDABEnHML49TekZOCFWbvNuG
 w/BCiqfswCKD/rKT/9oj1QfWcdIhoPge+HAjYvo8EJ3ZT8qJjAOlFzE5AT+LxW+aoN47+dcr6B1
 yBbG5O+Rz4JXtZ/XOYzrxqd69L3TfB5x06/NjjP78eYfkBuEiEFHvqYk3QtzZ4ixZ93fdQq05B+
 w1/v/MsgHMs5W5X6mw8i/LhMZa4/6NtjwgZO2PjVRqLCls7g7jcSOD/ybqU01vKj7OUKChWYLfd
 I81UCCwyTKViQmdZXPCp0s8T760xD6DMLtSOuPPJdcP7N+ldx+Z2VMrExpIgiAFC4quamO+nXpD
 hhwqy9FFjWoH9Vm6g5NJ/HOFV/D+jFGM3A4WqZGs2YRvtK4zepiJy1WVbhtn7Z/u0jvN+ChswDJ
 igWyoXT8KbpLhrQu0gA==
X-Proofpoint-ORIG-GUID: HwKtroAvlhG_aKZ8XRFrzrSORl8CZBsk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX/4PptV/Jt9g1
 gaS3hMMlC4cpg9z5GkcCrMQ+yQuDilkO17u1VVzaLNANF2nFBy9tunkgrdUmfdigONjENdlBCXW
 ip1m44MzPnessoRSK3D83SjyZGYxBrE=
X-Proofpoint-GUID: HwKtroAvlhG_aKZ8XRFrzrSORl8CZBsk
X-Authority-Analysis: v=2.4 cv=MLpQXsZl c=1 sm=1 tr=0 ts=6a3e0bfe cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=6o5SJCVUQus6q_qBAWEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260040

qca_send_reset() is functionally equivalent to the newly added
__hci_reset_sync().

Drop qca_send_reset() and call __hci_reset_sync() directly.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 27f03690af54..a940fa48179b 100644
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
@@ -990,11 +971,12 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	}
 
 	/* Perform HCI reset */
-	err = qca_send_reset(hdev);
+	err = __hci_reset_sync(hdev);
 	if (err < 0) {
 		bt_dev_err(hdev, "QCA Failed to run HCI_RESET (%d)", err);
 		return err;
 	}
+	bt_dev_dbg(hdev, "QCA HCI_RESET succeed");
 
 	switch (soc_type) {
 	case QCA_WCN3991:

-- 
2.34.1

