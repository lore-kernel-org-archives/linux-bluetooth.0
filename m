Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC94320CBE
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139949; cv=none; b=sRwGcDs5QI5n27EvdaL2qSOC0Ihfq8g8C3I9n0VWZux99M16riKuVYGh0QIq5Ri/LSuaqhI6npktuiVTCe8pNISWj/IZCX5CyAkbtoxXuW6okhlaEeH7LNWhprS2qHP7y+SfIMRlwH5EByL9cXzdeMQUBw+xcQpN4ncVufe3uSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139949; c=relaxed/simple;
	bh=ATHWApfpwZCeYYiok9ycJb1WRbFGd0dV0zYH+vPpucY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OFL4WwlbI2WYoGKJ3b8va4WZSjI+eWvokxpSyemQ+aayo9EM4sSyZCxuFQJLe5AQz4nAzX3COxkTpOcaxMhzmoxDmgxTA8BHgxEvan/LmWp2OwwU2y70BqOrV5lZTIdMKbP593XJSsaG9ppT+OmV4MBS81Alhx0f8GsSCkZDHWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D+v6M3bS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IzVZ+TXY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D+v6M3bS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IzVZ+TXY"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDGAbj1338434
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W0eZObuBMTQTXtWrtbsU40IRWbQBqKip0ll3JZfK0lk=; b=D+v6M3bSS/tXjx6A
	MCOKgG7oxVSlGF/ZyeXdUd/KmcbhBf23B035oe4C5CMy0yoLyEDlmhczK90H/ebU
	iR5JOMgoCUcDv1QLcZV1KiaIcOWyD9g9HlNHHamQtWYZzbzGRhLc2RFzxLdVKPcc
	6cll87GD6D1p8CuBHel9sLZmwJxuk6ApU/c9xEl5VEM0k7LpFOCEAwUN738R0yNI
	eUBF7DpQgow27vqJhjm5gl7Z1/ZFehs9cGmtwZOCd0eBWWj7eVCKfUzPJp/wHWUu
	kmMOgCj480yebx3jPHCh2tE7+1EDeHZFzgMyY9w053iei7SQjO6M2rzcIPkVqMtU
	z+tayQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37h8x6r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:26 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30beba84d2bso2693eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 07:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782139945; x=1782744745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0eZObuBMTQTXtWrtbsU40IRWbQBqKip0ll3JZfK0lk=;
        b=IzVZ+TXYfNDTmjGNFjOfFkGfkuTj7rCQKcXUCwpGUATtUe1OYjqbAgEQvtS0Zdhse7
         bofFvCYuZK0mDaaUDOYxQyMz27kCH6pv38UpqC5MeG9U4Wm5iNkUEUYZgG31Qs53bzR2
         JHFm/Jp8zSzGKAAm98xbOhtU69lVoh3Wyx8lRkZ4q0057cupUft4q02xunlyld3/D/Gs
         2OJATkdKo6cvWw6I8iy21pW1NMTaNPD//ojcR+DLWd+zAopbs0cg2edRI6fsxN3ZpWdc
         VnFB0hdn7FbOHjwpuHh8tKNPkdBBLfTghXSEqOusDm8i19/GvGbxG6vQ5KgjdozZ0W7i
         T96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139945; x=1782744745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W0eZObuBMTQTXtWrtbsU40IRWbQBqKip0ll3JZfK0lk=;
        b=eBlSir61OWUWbo/0mHfl9UPFuKOBV7/hrokeAJ/nR4axNJYf/EZSOhwJGVEA/hb7wP
         4b94Waz6un8q1Q466BbTCZiCa/CKyeRT14Z80w6lTJoTGRwQuTIK/5DVop+Oc/vxVRmw
         WSllK/trpMJZwt0Xib9/O7JR0DqicC1KwT4oeQtcZKssvRrfeSxYcnpf61LRZ5F/oM/h
         aJ4aQ4yHDF4CXDh/UXBg5sKcHWP6vQFWt6eaQApY1OmiWsX0vD0j9mapUlrL6Afgne1Y
         bhOhXoSjKiMOrTt5wZaMc6NfppAp68lZQq5ZjY8bJ5Sikwu43zf8GczRbE6Bv5z/rbRU
         PB0A==
X-Forwarded-Encrypted: i=1; AHgh+RqOFvr6AWd85AmcCcVLPrv6szSMdE/lrM7s8OLRm4RZB16s/aYfHvWqksGV1CSX0ZOELJOA1pOzvRA5SP3D2CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxBTO4LZoOFLgQXHw5m6CifJ9gjr99qlw8gvqchYAYKfYV4dRF
	pK+Q1q7RYdCfUUVPw22SnFLVWnV88735a6U55RlkovyRQedUl6i11z8YTPLyqih2D6ySTSUQ6Dz
	Cqti1X/aAeUtPJw8b9XbjdEi6wNpTGvPpoXeqdRspktjOryHUMI9d6qJ/Lk0tRrIli87g0vU=
X-Gm-Gg: AfdE7ckMztgXHobbd/6VcHIuUnYXo69MAxMvfIDghxw0O8m12JLz1S0b1bvRe4mi1Nu
	1y+7RWkVPMLz+FGMb4mHl2r8KI4+4vysqkD7eJ+BI3vla/YXIQC2h9becOBwnr/9hM6utEkkz0b
	yJ+kLNC0/2AaCEW8q5NeJq9+yfd5qUUA8K0fpg5hjDdop4OhlBCp6sfegn13X/lTSuN4YXZ50M2
	vGb4DyfdjEqz9UYFIcXI7KSv6elmPPzYQv3XehsPAznJw4pHpf2vcYUZzzTuONHHwuye1ofqsxL
	zfsupBYh7Ch2maLOVk6FkBl/EWoUIDOo6Db7niaMVr+oJTo6PgRavdOQPgt9hnTXiF7BtvH6M6P
	UZtopITYkxKjTKhgFmNebMiAxQsptyseQutt9s6ccasBtE7bycZOojETwSw==
X-Received: by 2002:a05:7301:2f88:b0:304:d700:1e90 with SMTP id 5a478bee46e88-30c17e7be6cmr3654202eec.3.1782139945298;
        Mon, 22 Jun 2026 07:52:25 -0700 (PDT)
X-Received: by 2002:a05:7301:2f88:b0:304:d700:1e90 with SMTP id 5a478bee46e88-30c17e7be6cmr3654187eec.3.1782139944784;
        Mon, 22 Jun 2026 07:52:24 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm12025561eec.20.2026.06.22.07.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:52:24 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 07:52:23 -0700
Subject: [PATCH 10/13] Bluetooth: btusb: Simplify btusb_shutdown_qca() by
 using __hci_reset_sync()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-bt_bugfix-v1-10-11f936d84e72@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: UeedyEveut-J13fTYoOd5QfLbV7XcBFc
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a394c2a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=v96isoq9qFqoqtIwOPsA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX+zCwYPfZV0G8
 zS6cS4IRAQNUYrQjJ9NmJU4euMwJIUSjbI4VCNvt6wWaOobe1fLLan2kYqh/syHtDZqKUycuJK2
 bL6VFqrC+HnbIUMSCJ91XJ4qoRghUQc=
X-Proofpoint-GUID: UeedyEveut-J13fTYoOd5QfLbV7XcBFc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX/9sAeA9foFz8
 UfiQDd13rlIcIrRisJhb+U3aUzkPzBYP0KIfE6qiAAxO0DdpCL4vHjE0AWaqjt3t65ttuOT7WDT
 DAJ9mYtJIVGNGV3RTL0HP22KdEoT3mymKJ0lshaHJYymCrFB3tWikDnRWAhv4AjaZCGo8/28gd7
 e71yQbC0fxbqEKqOiN4gHmFMaXhK7kOiGbk84WiRra4PnUyM1ywtK4A4KTLgdjI1J9L9NY1Kcd4
 0h0A6dx0pVDJcg2bc0lHw2gkn4bfEipR1LxsEyUgsqao/oiEIfdU4k0eQzuRL4ccYTxiN/IxOVf
 2fe+nSeBnakkou5ApTnYNmQnUlNwh9oOp1WsZQW8UGzuZWjS+n9YdzH+2J1jFaV5+sKUVYQbzE8
 oOg9dHeGlmpspIjfhY+B1rK5B3+7/L85WG/sFeWXe/nhdqTmOYUumq6GPgSQdX3EUawzGNMNjtN
 1m7DjfljrTtKPNeg9sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220147

Use the new __hci_reset_sync() API instead of open-coding the HCI reset.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e78277e24cd8..21e125db1b1f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3900,16 +3900,13 @@ static bool btusb_wakeup(struct hci_dev *hdev)
 
 static int btusb_shutdown_qca(struct hci_dev *hdev)
 {
-	struct sk_buff *skb;
+	int err;
 
-	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
+	err = __hci_reset_sync(hdev);
+	if (err)
 		bt_dev_err(hdev, "HCI reset during shutdown failed");
-		return PTR_ERR(skb);
-	}
-	kfree_skb(skb);
 
-	return 0;
+	return err;
 }
 
 static ssize_t force_poll_sync_read(struct file *file, char __user *user_buf,

-- 
2.34.1

