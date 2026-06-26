Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68A33A7D73
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451206; cv=none; b=NvLRZ4T6Oy2CLBmDaYp+H4nzPN0//AYiFQE5Hme6SEfer/8B+kNE+dLQunL+tNnSUATZGYHSdIhwhr8oovPiWu0lGbFuQBSIOPcnqSq44pdcI4XLCpwSASLdvxtdF/4FeKrTTIMA0qkewk8CaXBztZHpazX7H4n4ZpwxR4Ocskw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451206; c=relaxed/simple;
	bh=UClJ5eXS2m0FRvLY29NXZUCpauTf4W4y2CWIGqUPbgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oN2z/y4Vh9EpGRk0gUrdTRzZ7t/gxi6jiivQdYRdYotSu8Ctf9KqXj57aJmtx34cFxhb4fG2odNfktjy3knI3/gc73zerKHTW+bV12Rnr1oysYm/RPYGPDmTHp5f1P5ZYevwWwm5uxTNNO5rCCLSKZ/H7iw8zJzgq6SPPSZMCh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=isBRxxXH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AWPJwt46; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="isBRxxXH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AWPJwt46"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2ie4S4003996
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MrKfNX4GSc054ZzYRhPbAU2c3Dx5iXaNm/R6/b5iQu0=; b=isBRxxXH58/W8qhG
	J4u/zr4fhvmFcltDOqqlKizZEaYC/431/E1U01FhrwLSjRTcgP8dzzGVAok8ODpR
	AjKC8hc04dHjtnMsCGI9nujGfy5af8G5HkwygVKVK3kiPHFcxPrMu9Gif6h7Izdo
	djEMTDIHueXx/H1ozzBHvNdRDbFCDPJb5pWCK3t3xwca5MTqgOalJAnDHuCMUt3J
	BffDupr8NpxThsPE4D/BR406z/JyFJHGQPRFUIGAD3/5rzMwOBZ+6fYFY5qXNi3c
	9yyTRolfjczM7BnhjCblMnNPLF6oeDlZ349zz9FTrmBFmP4jNKcLUYoBcTCyyCfQ
	8K8oNg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1eeq93dx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:20:03 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bd0d5f5a4so61897eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 22:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782451203; x=1783056003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MrKfNX4GSc054ZzYRhPbAU2c3Dx5iXaNm/R6/b5iQu0=;
        b=AWPJwt46QFPJp07JQWmLrLGCT+dr7+zWeZR9WfYNciizi9NR1F3rV4uqQgL8kxKnxw
         8IebQcYJaNOXeasrsHcKpdhWOwSZk+9uL05lVQp4gQ//doM8hjUjQZJT6pWGa3lNBeBR
         0whgw5jrdtTyVRrvh50UFs26tPfoo72kfmY1pDL4GUJI1X3Z5jXIemPh9rd1iMgWUTI8
         dusANjNwm8jZkS6zVGERVOZNUrl5lwQwOc90apuvlpq8darwd/M2pL+Y5wzp2Zb70Kh1
         619KbCD+4BmZ4olxaesoWHnoNaToqEni5fhyG054zd1NgXvUzrDGCpbEM7eGjI0eS+D/
         PuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451203; x=1783056003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MrKfNX4GSc054ZzYRhPbAU2c3Dx5iXaNm/R6/b5iQu0=;
        b=peMU9HATrvyKJhQNf8mKOeE8AfRoiPuaZ0L/Z1cluU1ZH1wzC7byXthBpC/6TEyPc2
         q2SeAHnO7qbKssxB9pOF9IXDU98sKXKHhCNPkgYvx2/3EEoGYVecL1be8bS4vVqaVqj3
         +f01aTFxBLX3NByF8oKMqSsVOiOdhigueoYtJKhOHWkIkveZNyIXzrTI+Xsq5WJYWaol
         V+L9viob57vJX8jkZDQjGaU6/LJxoJc4ZJfbQDlzTN5jAXUJH8lZlmIvQfnK1EieB5Ze
         qDKCBbfOkNh1IJXuQz5HH+OYq9MYWzJRQvRZuh5KA4fnvxg8YJykLFMXTjFxRZhh3Kiq
         4tsQ==
X-Forwarded-Encrypted: i=1; AHgh+RoOtDeoP+1GJibECdrUJenZ7HqWJcJQUeDkYX/eqdI5he+qNUXnWx8n4P51AXNEb/gsdQFWxovlKINT3kEwISs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjNFOVd/ua/NPeN4MX25Z3eEVzggtN/vI4lcyXo2rnXuSQbYXZ
	sTw/iKyBv84GfziLVa8UGx6TCoZvkgMA+CezOLkq3OwS9KeHB5FdokLmQYSjjFewnVLs7V7O+ax
	9YGx+bjdhr16MLVeY37Jkt/cC4VXta7BOlC9O2gzlWb0A2p8lyh74w+bDpflK6ufepagBKbs=
X-Gm-Gg: AfdE7cmSbvUBoKNiB56SqE1K9fHLoooDMj+CMnjFcvAAgf/aoHwQJqujyInJ0c4JUkv
	h9SxtzPQ2VG6P92AS9P9pmQGOJxxw/8Ik+W+rt/oHdJyyM08+ylvjP2qoOI+9IbDr9GoSdGfsOQ
	b9gXaiLv3hg/0z/+4lDhI8XPjERM88cGU/e2K0+e7nrxGVZ5+ytFbetRRNYfWLLXM9eXwA9JYZp
	WxY2jtegAF8q99r8alfuy/nt2qJM4dwnzUGTnXwk6LcAqLaE6I/b5HiUjn8iAIpEYIDNH3RPfCO
	I6JqRGW2bE5WfZPG5RtiLqM8eVrd2c4SKIOQ3xHuU6L1B/OlEfsgvvg0lo0zCb0U0+0zXYTRZy3
	oufpZ8PrLjX12tW30JdS5XBYbQamgAT1BLGfhSmyYURcDN7GBJWZ8Y45A+Q==
X-Received: by 2002:a05:7300:6144:b0:30b:c021:5045 with SMTP id 5a478bee46e88-30c84ce60f7mr2112615eec.5.1782451202839;
        Thu, 25 Jun 2026 22:20:02 -0700 (PDT)
X-Received: by 2002:a05:7300:6144:b0:30b:c021:5045 with SMTP id 5a478bee46e88-30c84ce60f7mr2112610eec.5.1782451202274;
        Thu, 25 Jun 2026 22:20:02 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm14345291eec.4.2026.06.25.22.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:20:01 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 22:19:55 -0700
Subject: [PATCH v2 10/12] Bluetooth: hci_event: Log error for HCI reset
 status error in hci_cc_reset()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-bt_bugfix-v2-10-93396a6f7d5e@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX4tJKJ3uGTNi+
 4X4USK5mNnDwym93sjts1s1RG+sRVKyG8gy8Iemh9q4QuFxXtMDlUmTzlWHEwbAt0Y1rKLQMeKM
 31CquWWhsNUyAPSWGZZEM9qK7caWBCzVZPMGVlMtWQboAj5mkXY2/6LgNl528T60kxPVnlFj5Yb
 96JnTm56riFhOGOsUfX5uhv1UiyGGape4ekf9pztXTm0Xk+gD3136B78c+Cx94D9fzf9vh/5Z/9
 tHKAwYUTDRAgS5bakzx5vKhfu4npjAczyXu0OBuGMIHmBtYF5sNF0qTWmWc74ou2QV+ulCahV1Q
 JXMe9YfkYqiceofUtM3FMw+hRRzkXtr+CrzuQnmzo7YfdjgD7yfOZzFQ64B7Xwc6g6u7e8ZTXY2
 EyU58m299FqnRp4oGJJ3oXQS3HdrX7E14OE9vS03NkUDPSSUIXkDprLjlqfrMlb+2thAXl9TqSS
 zV8eEZBKnIemT1QTzhQ==
X-Proofpoint-ORIG-GUID: XirKwHeWIRbACxAqX306if0IBAJCUeIe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX1SBTZz5lN0la
 0Re10ZXVoNyBqsxDiT/IF5oXNtsNjHrK4R5yzftGHkzHQVMoxgmM/mEcIfllwDihkNx/29vfqpp
 pVGGJ2p4G02OZd4dTzt50RjxYvs3+So=
X-Proofpoint-GUID: XirKwHeWIRbACxAqX306if0IBAJCUeIe
X-Authority-Analysis: v=2.4 cv=MLpQXsZl c=1 sm=1 tr=0 ts=6a3e0c03 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_kdk9pxaj2Ve_5tGLFAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260040

HCI_Reset is a critical command, but hci_cc_reset() uses bt_dev_dbg()
to log it, so a non-zero error status response may not be noticed.

Fix by using bt_dev_err() when a status error occurs.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 net/bluetooth/hci_event.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b6d963ce26d0..a90d2c6a6e59 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -269,7 +269,10 @@ static u8 hci_cc_reset(struct hci_dev *hdev, void *data, struct sk_buff *skb)
 {
 	struct hci_ev_status *rp = data;
 
-	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
+	if (rp->status)
+		bt_dev_err(hdev, "HCI reset failed (status 0x%2.2x)", rp->status);
+	else
+		bt_dev_dbg(hdev, "HCI reset succeeded");
 
 	clear_bit(HCI_RESET, &hdev->flags);
 

-- 
2.34.1

