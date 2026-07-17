Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0153D955B
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 22:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784326141; cv=none; b=E7w5x/FshBbP7HRWu+i10AAxFnigyasKlr4KEdajBFJk9Z++mP3WjHxCfSq5oT1CoG5nvWRq9w3X6k8YTHweiRYoUCAKiag8stgSv2oSPjHBdqs/wQQOlIHH/dmAu43qzUEK5rzxnTe36T3ZHmenJleH5H91xLxw2eeJBRSCGa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784326141; c=relaxed/simple;
	bh=sj2gFgGlkXOf7HmUOz2/0YiSYtXipVoVsXjVPqSBSH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EnA9jIuJ1p4UspMoSN5/2HJxphr03stE+Ef7eCJSk0Akmpmnqgj/GdtM+zuWfFJ7YfloaIvFQnmXEK4wj3mTZLukLRKQT7KixQ0BdqaobMQQyzqZW7F6dzZu5QdQupb45khW4QDVOu3maKIn1meT6AnsrVyzpJIpNUnCcudl07g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HMjvmMY4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g5nP0AAr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HMjvmMY4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g5nP0AAr"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HJtL5s2652883
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 22:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LTHU+K66C/MTLyOO1XlHiv0lW5j5mAa4izNrPmhWl6Q=; b=HMjvmMY4s7Cbm3J2
	vUeTvV/9yTEppBGZyMC4fagMOXAwuDQmRECSt9nPb6OblOXOdpS82uzbYgP+NBQr
	ScpaGLDNRUFs8ZTxJX4QFEYs+HIzGVT1e5H9yiTy60Am9iHrJ88SmgVKUMsvaB2c
	t70T7LyM8LKynjegIxeRJu4FjFVMg14UCy1dGTMlXrPPThbR8kia3fADmZ6FGspx
	xXcukhBRrAp/UVyRNvpXoS2t8RK1iZacLpMQxbDaLPQwjGBgj/EGBiHZ5dBFC0wV
	fvKF5FZXfS8qRntObG/p/705N2jM36VTeQvrCQiHYeIydnWXo9S9msqIY8aEn+Zg
	iffg0Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9pbh8e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 22:08:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cf44f2c49bso1062835ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784326138; x=1784930938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LTHU+K66C/MTLyOO1XlHiv0lW5j5mAa4izNrPmhWl6Q=;
        b=g5nP0AArLMQw2UA+AlEbm/BaFNisy07yDaPgaq9vd7yv+RpcV2s2tBCa3fcL6dfoIN
         c2M4IG6NZX6Co0IBvtkfHy3t+lUy0arR2bGKlAnD47qKUEXNn8z/Sa3G7z2jD/los7i7
         jTiPG3o2/JG+8jWTXiEML7TpnT3Z6VAKIoyNX4oPLpPDzr60Ll7HctBT/7gdt8g0MQcv
         4eHAwH8px+pEk02JEduXGlHEq1TpgfAMahOur/IgGattctyjj6JVUk8ERY1MdIeqUtoX
         e2c7n7wfeEGCWuQkv/CLU7a6pETzWxmFErZt38x/qHBQEFqGUD3FhJJxnijYxqGUS7vn
         sv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784326138; x=1784930938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LTHU+K66C/MTLyOO1XlHiv0lW5j5mAa4izNrPmhWl6Q=;
        b=CJWlg2AWNz0SoUfUxG80FX1YQ7n+rHGOc6PfjJRg9ES9sinf7JZqMK4JLGK0R1GTxj
         nFSncH7Z/+W67ow2OMFcUM5yJQHsGc9v3MQvMFY3jYNlG6AM8JeBnll2NFbRzUh8Ny72
         RvydLuIJXPpWjrhHmbLA5TaebFr7INDk0f5q0F7pmUkjWNfY7EERGs0h047ZJEVskOeU
         5U2laGprE2ATt0X9wPCuSTV6y2l6wyDveuwLX4CzwCH+3VgLs2Jb4jvMECX+LpTvTtKD
         yyJ4HWZ/cpuTbDL6RhhI3Rh2/GayHMVfAkUQd0Mv+LM5djNSORS3B6kF6lQvci5dw0m/
         W7ow==
X-Forwarded-Encrypted: i=1; AHgh+RpnKs4RfjVFQ83BwtlWNi6RrMHKQm4p2arvoqEw+CLkRYH3+KgqspIvahu4NrJIJlkSsTu0CjcYMIuS/0KtJtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+DSXnQo/iormV9rsSk8IOHtiFQP+zFRpFNtq2dm3ESV7tpigd
	CvJnFk4ttTNynR6bhR72AYJ8lf5Yspi3qo9PgAhNhIARCcLgmqgDx8Rzt7PooXTjrC9DlK7oTFh
	FFQQ0pNI5UFhjCkP79IbLcNBAU60+mMEEIu3M6SOp1c30uUqWU/xuKyAaFS23AoJwjajIJPPwR6
	TS5aU=
X-Gm-Gg: AfdE7cmzxV3CKcILtISzzBoh+JiM4VBxv7yxiVO9+wW3vl/s39mn4yixuAaPkQZmFCW
	6Cs/VmPPZC8aO7QQ3og+n720pZgTD/209OSVlnwnh0vUe/dh1d668d9lKAf1YD/rMbP6niIp3oj
	qg9LDQUCQ2AVo8/80/m6TE6xhGtKYiYOPgWQn45yRBbqvB+e0D8llzCmHs5BzVcIuiEpc6yZpB3
	RDHEy1EG99ZMF5v1KTm6T6nHJk+UDG6kOmGPtL2kqQZ1qH1q8PyM0fgRUkEyhDphb1mAezb5u9g
	s3MzwMTnxDWl+GuJGklUFtj2iNNPnUgT1mQe38e4zS5ZxgRqdrf4ipGNzpKyeMFQhtNi6ds86ju
	Hq/WoLL33EKTAf+Q+y1w7lPg5LTln8nSio5gyPJntq27X52s=
X-Received: by 2002:a17:903:2301:b0:2cc:f4d4:29aa with SMTP id d9443c01a7336-2cf349f3d04mr34757215ad.6.1784326137762;
        Fri, 17 Jul 2026 15:08:57 -0700 (PDT)
X-Received: by 2002:a17:903:2301:b0:2cc:f4d4:29aa with SMTP id d9443c01a7336-2cf349f3d04mr34757025ad.6.1784326137330;
        Fri, 17 Jul 2026 15:08:57 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29c2dcdsm7668667c88.1.2026.07.17.15.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 15:08:56 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 15:08:53 -0700
Subject: [PATCH 1/3] Bluetooth: hci_qca: Replace HCI_VENDOR_PKT usage with
 HCI_EV_VENDOR
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-fix_vendor-v1-1-f22263c1175b@oss.qualcomm.com>
References: <20260717-fix_vendor-v1-0-f22263c1175b@oss.qualcomm.com>
In-Reply-To: <20260717-fix_vendor-v1-0-f22263c1175b@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: rAguKo7sktDD4FmhsrgGZUfbXFNNG7nQ
X-Proofpoint-ORIG-GUID: rAguKo7sktDD4FmhsrgGZUfbXFNNG7nQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIyOSBTYWx0ZWRfX3sbWb2xOQayP
 YncxWgfuTPK/mwkKm0BTIvr3VsaZhADqpM3pN12XJAbXeaypUni84O7kst02wKackY2I/ug0/RR
 jo4GwYrThz7JBSfynosvxGdDO7o7e/j5XP46f94bPlD1oM9uLKKks4gR4CZNnL3ED3k2vfu998x
 rxuLHbofR0h2IHqarBjfWIlHppiKvpGyHZoBgczorhGdw5xoBdKdm4O/3EGv1ZvgHCBeIGLhlAm
 pPeZ+F0/ewM51wDxcKbrhljKnfNMRe7o7W/+czAo99hf50wEEW6mN6kLmBkB0/hIimQi7eW54+1
 e0+4UxefJHGaLIbhzVXNrvflUDsZDPEkbC8sI9pC+jrjHlGfejnytsxtaQnuFQsWsFBLw3lLimZ
 n+hSPVByz521zbFVsAMJTbOE1LEUBKfcI/w5VMyySI8lv2ly4UaR6oJbwm5Fg8N88XAVJ/52sF7
 wBDF7hxS2DGcA4U8W0w==
X-Authority-Analysis: v=2.4 cv=TaqmcxQh c=1 sm=1 tr=0 ts=6a5aa7fa cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=SK-ELO-gduZh6qpZz3UA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIyOSBTYWx0ZWRfXzRNJdfCuyJqQ
 z72CmL8a7Np0tkcdcW31yOyHmBeaxoAfUVM//xXpKfAOpFvEicKl5oAzFrSbkiugfdnk7F9TKdQ
 Ihzpre3leWLtPiIJj1WxkFCRaD99FBM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170229

The macros below have different meanings even though they share the
same value 0xff:

  HCI_VENDOR_PKT: HCI packet indicator or type
  HCI_EV_VENDOR:  event code of a VSE

This usage of HCI_VENDOR_PKT is wrongly checking an event code.

Fix by using HCI_EV_VENDOR for event code.
Also fix warning "CHECK: Unnecessary parentheses around comparison"
given by checkpatch.pl.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index bd29d422c209..f978087612ee 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1240,8 +1240,8 @@ static int qca_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 	 * received we store dump into a file before closing hci. This
 	 * dump will help in triaging the issues.
 	 */
-	if ((skb->data[0] == HCI_VENDOR_PKT) &&
-	    (get_unaligned_be16(skb->data + 2) == QCA_SSR_DUMP_HANDLE))
+	if (skb->data[0] == HCI_EV_VENDOR &&
+	    get_unaligned_be16(skb->data + 2) == QCA_SSR_DUMP_HANDLE)
 		return qca_controller_memdump_event(hdev, skb);
 
 	return hci_recv_frame(hdev, skb);

-- 
2.34.1

