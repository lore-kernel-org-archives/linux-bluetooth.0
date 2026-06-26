Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB083A5E9F
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451202; cv=none; b=qPCLlWLsF7+DOMBDLZ2gdWSteEkcwBWuMpujPoWRJlRRE825+B1KmP0DGJhvanVL7TufzBO/TcSlq4vCVM271iPc61cgLCu2J12fRGufWWAtEMI1kkFAq3iozfwV0O/4As0WY6x+K9Q9Rq6xs4PxEl0w7BZfi0j6THh66P2tXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451202; c=relaxed/simple;
	bh=KWx38/xJXKbCXSINMl1h2M2Tk1vfAwS9Zfx7QDwxYs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qs6GoD6R5Ndb9dv7q0uTgok4bD1Mya7wug5JUcItFuNYlKIY1MTQBYRbWPjV2638V3aVnmbxjA04etVEjsl1w+6nMdaF4GQmPL6SALm6jmgC94PXTc0YCXsG6yeE6meadPsmpPkeM4Sd7a3nP8hxFpDgLXCDBGgHYwvLXKlKu5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z76CyBwa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FZbgePQm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z76CyBwa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FZbgePQm"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2jAxi3734503
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b8GZIo2sF/vM2X+nhHIIADINd2tPzCjU10t5o94yGWA=; b=Z76CyBwagH5HEfPo
	Si9vvlAxoLPCMxE9I/gtDOuPwj2bFS9MoNFIZSPQyNF4GZsNnF+Doj7ItspzQ6e2
	V7v7Fk+PhVPKpXF6vwUnL5S3Xo0kiYdOzlSZ97NP88kgzdnYRaCYMjSRPbRGgTRb
	COJBxaJA2Xg8FVRwf3O0YiJdFHzhoSnmH2oeEt/kgIsLKTee8E9ydNx4yaepu8b0
	Ev3X2cV3GqOEQhuKurbNWobKHvfb42YcRmDRpsMHEZbhzu/z85oT1ZyQPg/Ictml
	+XZke7SaDiN9RWZpPE+NI02qla8qoLCxoMyXg5L61BisAAHLMWrzTMqR3vsXyrBC
	GRBu/w==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f16ukb2my-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:20:00 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-137dd558ac5so13908c88.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 22:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782451200; x=1783056000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b8GZIo2sF/vM2X+nhHIIADINd2tPzCjU10t5o94yGWA=;
        b=FZbgePQmTFulH+kMrY/Ou1WZb6oNgNFEYFNDhfQJcVIyNX9aX+FiwUKuzYs9UaeNvK
         8zEeSiREtkssyq204Bo6OxQzlxN0trgP/2L8Dwfd34+p7hxSs4cz+dQky0wLpJKteia3
         ZlaLAsG3dLL8NkiVx1ruDB1nOfC1p7OhJrhBqVZd98JDLmUmy4aFFM91556bSDCxFAbC
         gGsklgr1ieUewwKRCp0ekMLB55apxajbJlX2hIMuxgckggn0zfd53Mr6pP6s3hgrZ7fi
         niCRDSKN85dtPSR0x+i+SUF3yBLM8OvtUDPKleDhvH7Ni/ovI7GTqxR95GFxLlkyd+lQ
         IDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451200; x=1783056000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b8GZIo2sF/vM2X+nhHIIADINd2tPzCjU10t5o94yGWA=;
        b=apnW5nSc3kBgJg5gyiPurQNia0LUjcISGMSuoKfuj56FyAuyYP0Q0AZOP71/OiMGIj
         syTpHIAcLx4O0HKnHpl1EWpb9rJKyNp4f+aV78CwcsqHTtsKHZmZXuZ213kHPiLfJfXt
         6bJsBJ/9JFMwxII5vUPwUpIAHb6DWEPIgftNccJXd3oT4muYlt5FRmwg/CSDsYpkYxpi
         qCBm54fZN/TkQn0mSbwqzp0ugrrECJbgFlUK8sC9KuXcJQyj0jGQiUB0HcIUrCuiDc4O
         PeuE1M4dukXSS6lmwgRs9akTnINVwmy7XpgXmtkpy+o2+34BbJfIWZv5OCyxrQIzNsyz
         9rjA==
X-Forwarded-Encrypted: i=1; AHgh+RoHJHSWIM0AopLS0uOW/wjtFWc/hVBr9lcLd6DU2T6AeZLMPVdfFt9pAD5eCtSogl2FLwlji51MoCecUMxv2dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzwEiYuCtZHQCx6quyUvWpVDG6y7MxdsrFikNgVmynmhZvZFkg
	2iVH9h/2OJtkLfZQ/1EG6gTtvF+7uTmmHssV/AXBbYZM1wWXsIVzQd6bp7XrCg2nNbiEeCzZc3C
	M/d73LZwfYIeeVJyt4b+quqTicIrJHmirfAi1aBWdE2SPTsKDgDsGt14srWzQ11DpI42MxEU=
X-Gm-Gg: AfdE7clB0FN0HZDtcVvtA5E9jb01dq6JzZlF7CSEHPMMDTghbpnMvmAnH1p2R3QnHrw
	z79/E1J1fByyrmrCCwI+a690SkY1E1yuzPuOcuiCsVWSB4zkzQ2o6RRoYN4xu2+mY72zH7SXqcv
	UOwxXxtlVQ5AQyTwBmFZEBiphJQVJ5uJWuqHjL0fJdBN7n0jdF/vAt+CTCouVqTC1U8svDFLGNB
	6zbCv6rh7wRy6tJCrBvUz+t4CE4yAEcwzjLabhwRd5or6SpZsoI7gnneySA1WuJnQoEeo1qUe7V
	1upqmVbOLzAquiczN16MrcG8rl1uPrm3LCU2SU8JGfZybZ+crd+aF3zbZpOioV6nA++x2WnAsqz
	tsDqlHpAyS+r1AzERoDcnGuo/bp3lXgmYi3iYsSUjETUCBy+JnHAnTzVfeg==
X-Received: by 2002:a05:7300:4312:b0:30c:1275:94ee with SMTP id 5a478bee46e88-30c84daf23amr2300243eec.7.1782451200175;
        Thu, 25 Jun 2026 22:20:00 -0700 (PDT)
X-Received: by 2002:a05:7300:4312:b0:30c:1275:94ee with SMTP id 5a478bee46e88-30c84daf23amr2300233eec.7.1782451199617;
        Thu, 25 Jun 2026 22:19:59 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm14345291eec.4.2026.06.25.22.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:19:57 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 22:19:53 -0700
Subject: [PATCH v2 08/12] Bluetooth: btusb: Simplify btusb_shutdown_qca()
 by using __hci_reset_sync()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-bt_bugfix-v2-8-93396a6f7d5e@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=VuMTxe2n c=1 sm=1 tr=0 ts=6a3e0c00 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=twxtTYS7d_BC4swYIWIA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: _8vuHuokKqe7szdzHROIXaMWnkgpQPE_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX6T9SEBugAqlH
 lX3EG/0fBTXTs7ZgEZ9M5H9F7IbgV9SKnvX+MgoYzkFpZacZZ9cAPiW1j845jQQ7pm4svf8grW1
 /7H/Gedg1O3X4psdHhlOqym1EnJWAJI84nGBWoQdkinRrAF0DlA/EHzpsR/f68zPp8cD5aSQFbb
 UE4uZ3yOapZ5xrXK3ypOOclL7hJWv5bYuuuVg+eu3Kh/zw81VZ/KGKVKzXmA/kXOyvFbPXHHx/f
 /GcSNHx1ag8IijTSI8jYBy78Bbuhv6POqWUgJ4jh5U1D5J5cLNGnwm26Nf8dlwnKLbWp4y8LiK0
 YLCDzshJzr/dy+cypBmLixUbHzxev5wCRZ5qekac/6pKcP4e9E0ayeH5RXSh0Nz1oIjRoCjXu/j
 uptp5lwF6ax3B5v5SQDVOyaKjb9rAzntcMwOW9CsA9Jv3tDlqx/aC/N6hc7eREP9phK4y/vWqDT
 Ja6Vsa70q9N4LvAWzjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX93mnxFl1hXZl
 Z3p0rPGy2gyhwdcYwc+9r1LJJAdQAzZSHYkOuG74Z46MjXEvrqNuyGUi1IRfa0Oy2p8ytOokGqH
 Ts0496xSoxzmGG26lo4Y46xMvDPmkvo=
X-Proofpoint-ORIG-GUID: _8vuHuokKqe7szdzHROIXaMWnkgpQPE_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260040

btusb_shutdown_qca() open-codes a synchronous raw HCI reset that is
functionally equivalent to the newly added __hci_reset_sync().

Replace it with __hci_reset_sync() and return its result directly.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a5ff4af90675..25bbee8f5d93 100644
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

