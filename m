Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C573C0625
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 06:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221690; cv=none; b=XYgqFoWIKdMektyFLd0tcMh1hrAW1zjc7n51QOLB1mZXuz5MpYq34MyU6zEythHdDyllobsJJeMWopigri0hONUX1mmkZa27r1f2ipI4A1WEzvlfrQm0l62hnb24DXsgGDW4c07OG70iwcaoGBbpOHBmDIsnYcCMetDIwrC+8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221690; c=relaxed/simple;
	bh=sTONkPG1YA9Kqe2CF2t+9bkRzXUrYefdoedQ7gakfWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RXPBYl3G4GWB5uLcTAZMq3FCeQCOZ99Kz3EUEnOzkrdrP8HjHma89H1MrL/iMpzRNfBi+3MFOh4/04TaIVGqfsnguGCuXDvOCs1U07DrlE9hXLtcame2sR63L8kVlH7FMnrkPKVheNh/R70qRK1CFwmEf+oB6zGGdQj222ekzEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fOYYuo9E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f5xJo34G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fOYYuo9E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f5xJo34G"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S3adPP1527550
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 06:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IFWLI8snwH0QQ0KgVTtLpclTQlqRD5DHHKaRCmMMfWs=; b=fOYYuo9EUJG0i6D7
	iM0RmJu/aRXGq+pc5elSMRS7HxbKg7mNO4XkbhPExaUjbITIAHh6R8sWOtyMOt7/
	9FA076bLnZ/v77dDSm4ji0I5r8DxGJz+n1qyXJzRmYxaRW0AB2a2wjYnWKmb72fC
	HpRnvcpir1/Wm43aEDz0fhwldRriLPZGoYVM/Hazygmkhyf6YMSE72gCaQ/W/4QN
	lnNApIJimCQrn6i0d5imnDK1JSFOk4GpO/6FBFTwOU6DtNol54jQIEO/PgQB8ubm
	HHLtuRU11G4UIi5Cas44ugbSknLI9HmtFNX7SBY6fRKb6gEm04Wpq3aUP1K6ccle
	jkIjNw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8auw8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 06:54:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cae7a8b9easo6880765ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 23:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785221687; x=1785826487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IFWLI8snwH0QQ0KgVTtLpclTQlqRD5DHHKaRCmMMfWs=;
        b=f5xJo34GTPItbXKQEJuOtIoT9fJM+4bekib/fH9p5VdnfazApWCsIwPLU7z3+c27Om
         BmDoFoJTD43VkGzv93L4OBE90pflwX5YvZGRyf1OVHwRKmeVzNLkljptOHgm084tlYGi
         H2P13HHhUD5FqEyQr385ErxxhbNU8EM33BjIkZiKWrVFrIvnvNwpRn36JfmDOF+jexwR
         ztmz59JX5Znn6S18GJYuU1tN++EtPnHUjf/btwgsBhOUTvD2Yhn4IC5ABMo0pZpB6nzZ
         Xqtvq1jLuiKCRbdBe/yiKuc0HeWYBaMh9SYBkVnh9Ph0yOtff2IAXy0F6P4y7x14qPPg
         rpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785221687; x=1785826487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IFWLI8snwH0QQ0KgVTtLpclTQlqRD5DHHKaRCmMMfWs=;
        b=WsuwU183qY92G2BiYaYigT5Eu/m8c+reBBXn+5hPO1Akju13Vo/OEnBPzhku+D5ugC
         0NpZB3/mVnh1olpYuUW+PgoqWLoF97ooYVYehrWflJkxyGDkpuuKW86+97gknu1Kbaec
         G1VnnYpcGJng2f2du6ipG+syrDOnboa/NvyAWw1JpGCLYoUaChldJiVhTM8c7bfCsGl7
         sxkwpRHfUhHhTD1R4rFN2Gt8Twwt6yXp5HouzKRchNIfP6oRVb327qGRBGCUi4qUP6eJ
         k80PE2plaTgsZrRbGgFKd8ZYZIKh4qMRC6q+Ed69eTStaqALJThO2wp6OmUpdNVxLGXU
         46Gg==
X-Forwarded-Encrypted: i=1; AHgh+Ro6Y7LQkDo8f4QqdYwcurr5TYqA84tCzho6/52LkV9sBt8NbGl4SdqvyF/nl7UnD7+cgnIbeOP3BDzP6jISrOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYeV2yJEber7fWVZUZbIYANLZ/amoT6JNmIdrj9KsHGoai2yUM
	roraTNLzCGtSWNMBoadu8iyu2wAyheQToIOElWaK+2ESNeI4jDELaRV/shWZDnRDZcA8ZWmyfT2
	FFjWa54mUBYHhf6tw24+P1AsK3fwlQrjl6vq9Dcr7F0vyFU0SEiAZCxC5d+kAgSUwqK6akpU=
X-Gm-Gg: AR+sD11mQ1+aBVhV58gZINNnQl4uQRsjnc0Ut0uufnara03TnjNiN8ts8M2Sfo1zUjX
	hBIVEx8/mEPKBzQ5odwZyJYRf2gy9y57MG1Om0RQFmMeGpP95a9bVWhP8+mEzVKvvV4p5YPxFKd
	Kamf6e1sRLe5CT1+dt/xedNReqgyFgYU51V0LYn+DzH4OzuQkJShzx6tHttATqHnHvIXtZq1bvS
	Q+GP4t7z0OxA2s/44K6efzs78j8wFF06UUcqC9/EJr/WdcZiahJj2x/JyiHowHuMsphS3Pa+ZdV
	oYCw1TV5dC3SseeTdtfByXwUrLp/qEobDQ3s51Tial0M0zJ9zfQwhhG2RuaEWCIMMEO/1tNtLkZ
	7RMXExY819um1Wwlr/X9UZbSb2JQGGpLh1EWWcuoPlgxQaYo=
X-Received: by 2002:a17:902:ccd2:b0:2ce:aea4:5e80 with SMTP id d9443c01a7336-2d015d3dcbdmr11138165ad.6.1785221686879;
        Mon, 27 Jul 2026 23:54:46 -0700 (PDT)
X-Received: by 2002:a17:902:ccd2:b0:2ce:aea4:5e80 with SMTP id d9443c01a7336-2d015d3dcbdmr11137875ad.6.1785221686459;
        Mon, 27 Jul 2026 23:54:46 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2881sm46260245ad.25.2026.07.27.23.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 23:54:45 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 23:54:33 -0700
Subject: [PATCH v2 3/3] Bluetooth: coredump: Expose header size and end
 marker to drivers
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-generic_fix-v2-3-a57bdb81ac67@oss.qualcomm.com>
References: <20260727-generic_fix-v2-0-a57bdb81ac67@oss.qualcomm.com>
In-Reply-To: <20260727-generic_fix-v2-0-a57bdb81ac67@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfX60lWkAch5x4J
 tw53rSgoKX/1CI7Ro57PpMcgDeC+h0Ubbs7lv/6vgYI5TnYbpVnsn8ZaJNRLTSCXN2LvFVXBZ6c
 3tRB20CkNcKog+PHwUdXTV1d/XGEB+uNrvZAhmphRFT/zlH6Y8t6FsOMORPplWsPeicinQtTjBA
 mKomIw5M3B4Pay9Yg37lPf6PT6m+3zoDaKMelHtKHYs/mpSS5JeBxPT5q0hyBJ2e+fXJq3NUGQd
 VvdzV5OvvXaoDIofGH/LjUosklAodXrYwjfwWsf7gbLLxtmBG4Up+sJzxu2YkmQ+CvvCzODM7yO
 +CJ1T+fUjbVmNfLTevJTkxRkFcXs0SMB9oF9zx25lObw//n59zfCPAeEYXbCg3vkD2jjLuIHJsb
 gHZWT4RHkqHx51PWmn0HBMKwKqULYO36ccBTPnD6Z12kdNrIgFG4/xP5DHIgVYOh0TwldhbMNF2
 d3K5Nmg+j8bfzSwhZ1A==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a685237 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-roT62_Y7hF8laV7vqoA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: yBRjdnQ60LuGRu9QaSnebQJZZRASTa4X
X-Proofpoint-GUID: yBRjdnQ60LuGRu9QaSnebQJZZRASTa4X
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MCBTYWx0ZWRfXw4Yku12wb2r1
 WBJZLuH6XFqm2aL+/AqjSMYTu84xHUHAFbeJ5T+LURrWrlWth3VeS95YcECRDpJjKXV2LXmGB3+
 iDkV58PeYwxtKOrMZja0VP/MOJrTjfc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280060

To separate the coredump header and data far more easily, give a
vendor driver the option to pad its header to a fixed size, by
moving the header size limit and ending marker to coredump.h:

 - HCI_DEVCD_HDR_SIZE_MAX: the max header size
 - HCI_DEVCD_HDR_END_MARKER: the header-ending marker

No functional change intended.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Previous version:
https://lore.kernel.org/all/20260713-btusb_prep_qcc2072-v2-2-bbcb651285f2@oss.qualcomm.com

Changes since previous version:
- Rename MAX_HCI_DEVCD_HDR_SIZE to HCI_DEVCD_HDR_SIZE_MAX
- Rename HCI_DEVCD_HDR_END to HCI_DEVCD_HDR_END_MARKER
- Improve the commit title and message
---
 include/net/bluetooth/coredump.h | 7 +++++++
 net/bluetooth/coredump.c         | 7 ++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/coredump.h b/include/net/bluetooth/coredump.h
index ab85a6adfffd..1f071ab55416 100644
--- a/include/net/bluetooth/coredump.h
+++ b/include/net/bluetooth/coredump.h
@@ -3,16 +3,23 @@
  * Copyright (C) 2022 Google Corporation
  */
 
 #ifndef __COREDUMP_H
 #define __COREDUMP_H
 
 #define DEVCOREDUMP_TIMEOUT	msecs_to_jiffies(10000)	/* 10 sec */
 
+/*
+ * Max header size, shared by both the devcoredump core and
+ * the dmp_hdr() registered by driver via hci_devcd_register()
+ */
+#define HCI_DEVCD_HDR_SIZE_MAX	512
+#define HCI_DEVCD_HDR_END_MARKER	"--- Start dump ---\n"
+
 typedef void (*coredump_t)(struct hci_dev *hdev);
 typedef void (*dmp_hdr_t)(struct hci_dev *hdev, struct sk_buff *skb);
 typedef void (*notify_change_t)(struct hci_dev *hdev, int state);
 
 /* struct hci_devcoredump - Devcoredump state
  *
  * @supported: Indicates if FW dump collection is supported by driver
  * @state: Current state of dump collection
diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index 913bbba559f8..5bee863bd6d2 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -29,18 +29,16 @@ struct hci_devcoredump_skb_pattern {
 #define hci_dmp_cb(skb)	((struct hci_devcoredump_skb_cb *)((skb)->cb))
 
 #define DBG_UNEXPECTED_STATE() \
 	bt_dev_dbg(hdev, \
 		   "Unexpected packet (%d) for state %s.", \
 		   hci_dmp_cb(skb)->pkt_type, \
 		   hci_devcd_state_name(hdev->dump.state))
 
-#define MAX_DEVCOREDUMP_HDR_SIZE	512	/* bytes */
-
 static int hci_devcd_update_hdr_state(char *buf, size_t size, int state)
 {
 	int len = 0;
 
 	if (!buf)
 		return 0;
 
 	len = scnprintf(buf, size, "Bluetooth devcoredump\nState: %d\n", state);
@@ -58,28 +56,27 @@ static int hci_devcd_update_state(struct hci_dev *hdev, int state)
 	hdev->dump.state = state;
 
 	return hci_devcd_update_hdr_state(hdev->dump.head,
 					  hdev->dump.alloc_size, state);
 }
 
 static int hci_devcd_mkheader(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	char dump_start[] = "--- Start dump ---\n";
 	char hdr[80];
 	int hdr_len;
 
 	hdr_len = hci_devcd_update_hdr_state(hdr, sizeof(hdr),
 					     HCI_DEVCOREDUMP_IDLE);
 	skb_put_data(skb, hdr, hdr_len);
 
 	if (hdev->dump.dmp_hdr)
 		hdev->dump.dmp_hdr(hdev, skb);
 
-	skb_put_data(skb, dump_start, strlen(dump_start));
+	skb_put_data(skb, HCI_DEVCD_HDR_END_MARKER, strlen(HCI_DEVCD_HDR_END_MARKER));
 
 	return skb->len;
 }
 
 /* Do not call with hci_dev_lock since this calls driver code. */
 static void hci_devcd_notify(struct hci_dev *hdev, int state)
 {
 	if (hdev->dump.notify_change)
@@ -149,17 +146,17 @@ static bool hci_devcd_memset(struct hci_dev *hdev, u8 pattern, u32 len)
 
 /* Call with hci_dev_lock only. */
 static int hci_devcd_prepare(struct hci_dev *hdev, u32 dump_size)
 {
 	struct sk_buff *skb;
 	int dump_hdr_size;
 	int err = 0;
 
-	skb = alloc_skb(MAX_DEVCOREDUMP_HDR_SIZE, GFP_ATOMIC);
+	skb = alloc_skb(HCI_DEVCD_HDR_SIZE_MAX, GFP_ATOMIC);
 	if (!skb)
 		return -ENOMEM;
 
 	dump_hdr_size = hci_devcd_mkheader(hdev, skb);
 
 	if (hci_devcd_alloc(hdev, dump_hdr_size + dump_size)) {
 		err = -ENOMEM;
 		goto hdr_free;

-- 
2.34.1

