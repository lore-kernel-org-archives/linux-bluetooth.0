Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317A33F4DDD
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999830; cv=none; b=nXZrauJyWbx8IT/88KlrWOmC2yGHga9F3N9ODSRdJr8OEiFsfzwrZoLX/QQY9mu97oEFO1lprDfT1PTLGF0NS+RjakG3HthdgiiXDGFuGCUf6ejkUWZTyvEpB/THMbK4iOdDJ9G+0TggYFLe8e9rFyxv0ftoNv13hqmXHlAuUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999830; c=relaxed/simple;
	bh=3Chvi1N5F4Fv2g0WuEnztNmxkFmKs0u5U5hhZQi8es4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofmYc4/ZL7/myHKQLesHw4osL2CBFgfq07j4+HpKJX49WS0l6twtodVr58kql70MoFPShpzAE7HW5cgOWjtysWQW4JiA/TtzAzTl3Vo8DAH1CZJAF4Pz8JHTJR3t2oOTqPwsB5TPaVOUw4++LCuyZrKNtKAxliaMJ5kY46zAJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MkE7kNDa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NPpi3teY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MkE7kNDa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NPpi3teY"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIR7CC2211245
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 20:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=EriltiZToSqI0mR1wtMW/e6wd0hN79nRwf6
	7Go8ixTI=; b=MkE7kNDaPD+YrGuv0picGVrJCilWY+tgq+QCUQFm4YuzhvpkDQS
	8y67VvgkBy5Fm/wIsgw/iIzvSPNR1xZ4XeTDpxisgKDIyLre3JoFCRtLDqO15YY9
	EEKGcgWWAVoK5x3TpAKEbGZLBRFnzV7aM/7O4P6Qeh9DBbyjcyV6eCJvdSYcz2+7
	EGVyP7Sv7uiTSNvajsP777l5ssK63eKjs7S1GAt3nkozJoTv//rRze67qg/m3OIq
	HHUHj4lpTSa9n2GdbqinVLGc5UDod5J07gxacnskY9u91e6YDSmtYiz6jpeS4fhM
	X1dyALmyTGaz+9cO2ywBqK+cfdQKNuGKEaQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3x30k2k9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 20:50:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e52306621so373070985a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 13:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786999819; x=1787604619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EriltiZToSqI0mR1wtMW/e6wd0hN79nRwf67Go8ixTI=;
        b=NPpi3teYaBZIux+Mb7bGIKtRD3WugG1ojh99KiaDSzXlLUkUXTy3m2Hh1UkCE4NNH4
         k6QBLgXwupHbkBG2flcfnZVmbcSeUu8zPdmf/iccGks4OrBcIetC7a0o4DcNdsY0D9Mf
         xwelKakxtjOE67HjgnvUWpJVmsfUqL8MotBiHFTmqN9m9ZmynAnqWgEqoaCh+T8maDuz
         VAWJIwuYUpNU2A0ExGUDXrB0YBT/QgEN6DsvPD5WFqm8vOZ16FuIz/WI7nLyoCJJx3NC
         GjHBGiQ69dIvSJNBHW5fmORCmWQdMX4bvjfpfsGwUHyq5zLOmMg8X1TtBwKqkA7LUG14
         6WHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786999819; x=1787604619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EriltiZToSqI0mR1wtMW/e6wd0hN79nRwf67Go8ixTI=;
        b=RaX9CaeF0xspAjuF0CZ2B32s+Y35se9KBNgqrI66OjflWI4D4flakxS/ZaWyE0Exws
         FjxEUrrU9lE/owCQ0ph0Wd7BuGiKDh9u8CCSEXlMahMP9V7mfog5tTVm0efnbFX+agNK
         Fd78yTKo+8YxNpSK56qIWHJ0ZskB/SEgH2MCWaICvJ79aX6+zT0XtmzkGRY7Bxv1vTmc
         hf2FOVeJ9Rr63mEkWOU1Qa2gbG6ta4fsn29Etm0mHEXk5ACIAddfJ1yVwnJiSfsGvuKq
         /KLWrXu5zfScwSoYwJlWJNO57NeLc7dubOwa7zyBOT2JbPI/MR2W7NrZ8dNyWd/AvQ9j
         4b0w==
X-Forwarded-Encrypted: i=1; AHgh+Rq1lQQEpbJTHZAutzLrb8GdNEKCuUO6AWDknQlMmGh5b0cP5EU8aSNMw8eiISmhgS8B8xbcWF4mf41oCrL9LeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaXnO1qhCRpBlHiRJfwb6TS5/HeyLnJpir6xbu7iD6nj670dPK
	U0d4a/qCbnDFiINMotZ6+VPvYoRb0DVAbQldbv3a9H0AjLjbLFlkd1HjIecrVuWZCwEXFfIgP1z
	IibG+DXh5iRqb3BA3Iz0mJDfnvcJu25IjbA1hGnyoZ7/7nFFZCelANJZPgouWWZ4wIOQ8uCg=
X-Gm-Gg: AR+sD11vBwiogv3lyUekwsLQ7tMO1aZwpP9sWnSWllw2TBbioYb2ggWmVaB9yan476M
	gNoWx86A8PdQMMj6YXEkEp4j86PmbGi9CRY84PRT/eSMKkeNTrE7bg+6XvWfENGJ7N157HcsVaI
	DmOhm4Qj3/iHNLmQPMc9D4AFIMjdzihBj6vaDIgfCGKs+Bj/w935J+efvuSSqSzfE1Au6nJV7Jo
	+6g6YVtxbbm1gZEJ50G1PkCb7owBI+G6SWcdGFrrsgbI7OhRSdyxIX8uZCKBR9GQ0F4jMyvSrUF
	4JR3Cudcap+KbRh/zpaaqui488MFR5fSVqTpisAU1SApFyFJkaMtxcauX9skmbxbT1EBmer8gHL
	sEVskFvA2h8mSbtwk/N+qQSyi4u+6r+9zoubagXM9EiMgRHG1XCcAy4RxlCA8lvvfa0uxN1fO22
	LAC/VP8+Y5ZqFqjdw=
X-Received: by 2002:a05:620a:f06:b0:92e:7d53:8e8d with SMTP id af79cd13be357-93704b7d4dfmr376260085a.27.1786999819577;
        Mon, 17 Aug 2026 13:50:19 -0700 (PDT)
X-Received: by 2002:a05:620a:f06:b0:92e:7d53:8e8d with SMTP id af79cd13be357-93704b7d4dfmr376256185a.27.1786999819120;
        Mon, 17 Aug 2026 13:50:19 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217fe7b854sm101745866b.4.2026.08.17.13.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 13:50:18 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_core: Return -ENOMEM when the sent_cmd clone fails
Date: Mon, 17 Aug 2026 22:50:16 +0200
Message-ID: <20260817205017.56524-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE1OSBTYWx0ZWRfX84ypJANdT0tg
 XbuGMfrVfuDAnyLrSRvyYjOE5fpXgEG9u2a+0nELukEI0YC5OAeILQF5tVj5jN/IC8caIq4n2vE
 hFWJmxKVLzQXTP7TZ8ZKhahsK3OGSj+ED0maXXjRmMMVl2rCFzGPeJQYuU5P2yEQgK589ZUStIl
 uRd8+OsVLwJyB0xBbfR9coAG1XW+O+xv/Uwd3zjJ7CHqmrqAiVCGO5KYCeYz2Irful14rPPSUeH
 vSdxzK/jyf0tUcClCR5uwA2NMc2bXCFndLwgscTUKop+J9B4CxzGeybN7LZvcRMfoY+rcAZzpry
 pP2ZDTpUHfaesdN+wkoaBSPmmPdm+kdEgkpdmzRPzMCXAjDrBsX/zaL0El95amj+LTxSax9FUoK
 JIfBXPT+nJFaog2G561Fhy9dYGpKn3Dga+uI0gVpLT4uqTFKC6Xw73OgalrrSl9zFjyx650Iitx
 GrK7Y3KlRfIBBmO9D/g==
X-Proofpoint-GUID: l3XOOw2IqwHIPJFlcG6vMGw_5rNU9HI3
X-Proofpoint-ORIG-GUID: l3XOOw2IqwHIPJFlcG6vMGw_5rNU9HI3
X-Authority-Analysis: v=2.4 cv=Y9/IdBeN c=1 sm=1 tr=0 ts=6a83740c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=DlbCxbnm00ezU7UVFbEA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE1OSBTYWx0ZWRfX8DfgNXc/Uo7r
 Jz790gs1s6aUqiB9heA0L+u6JRe2pg/rNLlvy6Um5S6GSocn95ZTydS8BVzH4cjZB5A0mfr5cnY
 kz9IJKzcB0bF6w+MhQhVmm5dIXZLb2I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170159

From: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>

hci_send_cmd_sync() returns -EINVAL when skb_clone() fails for sent_cmd,
which describes an invalid argument rather than an allocation failure.

Return -ENOMEM instead. The only caller, hci_cmd_work(), tests the result
for zero, so there is no functional change.

Signed-off-by: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5ba9fe8261ec..8aeb3024428b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4073,7 +4073,7 @@ static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!hdev->sent_cmd) {
 		skb_queue_head(&hdev->cmd_q, skb);
 		queue_work(hdev->workqueue, &hdev->cmd_work);
-		return -EINVAL;
+		return -ENOMEM;
 	}
 
 	if (hci_skb_opcode(skb) != HCI_OP_NOP) {
-- 
2.55.0

