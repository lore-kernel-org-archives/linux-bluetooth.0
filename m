Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221AC342CB3
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785652333; cv=none; b=Fe2XSKdbmDyFVoUV3EzQ+nWXfO/Sk2lzyJPHICxuPmo9JDikftSQHzDiOYeqnIQS9Rv6+AT/6CtNZ5lAXfblRSYw9z6gHcCcMr9YwMmhd1yenxrxIj1hxpEA0svFrYwn8KRM1KhfLxeZbYC9gKcqtB7N991SNFXGR0Fp9yFkK2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785652333; c=relaxed/simple;
	bh=lzIyHiA7wkm/Q1XRhS+4tVqfs6XOy4lON2is8fZD8fI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J1rYKte1ENQQIDfVpHEA9TP/cTVxqMEBk7RYfXP2r/X9OeHVrWCHi1+Fjp6MEJ5ImHKkaRSsmyOIuwvgSUXBWg/lm8PJumScq4yGKKX9QUd3ZCfV1RGV7+eViFXHNZ8RFnSJU9S1V/V/JKZHTogEJiegZ4sbzZCUeckpdY7WrOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IaFnRbxp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YCmbNFhM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IaFnRbxp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YCmbNFhM"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6724aidh712122
	for <linux-bluetooth@vger.kernel.org>; Sun, 2 Aug 2026 06:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rnfAF7jntq0imixhjb4atbRiGN55VN6m38GgbhFaKN4=; b=IaFnRbxpJiftSfe+
	Hzc0aCn9ZsfSGYCxQoP8i9hPkmm/je/d0wvPnyGQLFWadEiah1mO/3FG+ZTv7gpP
	YMb6I+1jTSZNHYad2FOrWI+ITgcz+kfJJp7Iq8H/cEq41NZdD5Vna/aZXTW2E0iL
	G+zOcHPOISBAqmQcyIgkXOIGzC9z+/hpCi7TWanNyoO0EaRfhaNDwx1Y9tqJFS69
	KDkSZPFnBz+hK730AtMGtNJ3DXzp5c7IsdaqC6lkgZfdSh3ImqW68LRo3e+Vanwx
	u5pfMXwkPOUEzu7snc6SCkj91QVzw/U8uUbHaYdSL/c0iPe0mzFQRAZcOq1hJ9zP
	qqj7yA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8u9ac9d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2026 06:32:04 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbe416a212eso177664a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 23:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785652324; x=1786257124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rnfAF7jntq0imixhjb4atbRiGN55VN6m38GgbhFaKN4=;
        b=YCmbNFhMsJfJFOquFhNnlapC9S1/1bE2TdSxmum2KJ/Jnmu2Kh/1UeEOmA49UwXrgy
         pTFPe5HtEkE74ueIOXfnp544vyaPXMxteVj2douiniKanTG4CZMQaLs92KIS+Y5dIWN7
         UXq9AN56iePMvYzqWG4JNvaRxw4LBcXzc8P8Bk1XesHEJKlqWzBzGebwM/6ZlZHpiY2S
         l+35jUA5MDTFqN5IRbj8zQc9RuqADBZ8GDahQ9n9amcqFGDJUUHnF18gbY9rElLvukVI
         rnrFCNQbT7YyB67iC8IgU2MJ+cefCyjr06nBgRSSzcy0hhTEA8emtr+fhlvYvSbqQ+N9
         7LpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785652324; x=1786257124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rnfAF7jntq0imixhjb4atbRiGN55VN6m38GgbhFaKN4=;
        b=DGL8CFWpBBAe+RMbgI3522Mi4b843jnOl09m5q8+E9zmHI/UnJrDFGns7j3imEJ0jH
         5lydEnySAU/R605CPswWKjBMDuZFExb/reyXVOzfJUcE7po2wvEDnrQ+2FnPIs3khZKo
         hIEGGFLuC4SvEC8dqd8jBfC3KLORHnmv7xuzrKlQuhnjrPPg/EAtAwbEyzRAAEeczj1h
         eXaMbuGTRGwOkYrbeCku6Qnl1xdTNPKNDWja7f41PNhTbBTHiVbiFhaSJrquesEdR+dr
         ZhRCr0TBcAapbzxsIJI2oSxLgmq5jqw1AVftii+3bTbS2y4ZJcIjYezcWhJGzGWAslsg
         h0FQ==
X-Forwarded-Encrypted: i=1; AHgh+RpuzVX0lR7eh5LlOKMvcGKQuPZfKyrWDlNteNdNKmPdirnf8ElWYe8d1R9qEhQG+5QdaYCht1PXD9+L1Oy0Cvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZyCuPjaHmFErCxDrpYbcF8JqMFEqODrWbtyZnrj8wpAlCGIl/
	L217+zoC2UN+yW0szGCBHc6WWHdo2OA/i6ERHNEU4vw69sf5Qci6mF3MbwwHpjmJcphEV6mGiky
	WtmH8qac/tdEPxSpspPySpmQTNVBBGOTejcL9ClIVi7TnY8r8+OdlOnKvw6lpLjAd+kNLJlw=
X-Gm-Gg: AR+sD11n0ArworIJ/poFT8oZEXrtzuIWL2fov+ZW2ph/23RkONC+4TmMTko50HBtMPh
	KHlzsCM0LcnjRtmeLri0vSlJsgtOJz9J5i1KDmJ8LgoxhBDypjZoo01Klo3ZUoQ1f3dnCVzPE1c
	f8xqGsDjApsnR8Z1M/2c/I3og5sH5TzhKPUJ8IzjKx8mWVUv2OGHLJbm8VdABrJpphVClytzksz
	eku4ExJgRhMYyg1Nz4oAzqlr/bXEp5xXophSFd/phv84EZVVYhtRQNDHQ/yiUPYx+jvnnApCwjs
	hyepW0FbBeE2j9CV03LbJ5h1xNLM4msH6HaGcygWpRPwxWvDL3zaYmRs6JVWVO48bpGvHNcgUYu
	/KPwOHpNAVHokCCD6hXWxnzGyWcZDh2bNxe432PZMGCh6Yos=
X-Received: by 2002:a17:90b:51c3:b0:38e:6a7c:abbc with SMTP id 98e67ed59e1d1-38fbc5482f1mr7357468a91.3.1785652323868;
        Sat, 01 Aug 2026 23:32:03 -0700 (PDT)
X-Received: by 2002:a17:90b:51c3:b0:38e:6a7c:abbc with SMTP id 98e67ed59e1d1-38fbc5482f1mr7357442a91.3.1785652323462;
        Sat, 01 Aug 2026 23:32:03 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c93dsm24233304eec.8.2026.08.01.23.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 23:32:02 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 23:31:41 -0700
Subject: [PATCH v3 6/7] Bluetooth: hci_event: Introduce handle_ev_vendor()
 for HCI_EV_VENDOR
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-generic_fix-v3-6-efdd8dcf3430@oss.qualcomm.com>
References: <20260801-generic_fix-v3-0-efdd8dcf3430@oss.qualcomm.com>
In-Reply-To: <20260801-generic_fix-v3-0-efdd8dcf3430@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: HJmHB4qBKlFviBMBkxeWgkMhBkzkoK3H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDA1MCBTYWx0ZWRfX9H0ae/RtF9cX
 1H+eg4Ae7xXnrASWweae9rzre6rew8bx4wrzZFyQhZcp83Ocr94LrNf8SSLE3lOczK1anIxK3gJ
 N1JxWsKju6vSS634rxHos0jTZXJePD5jwU7k4EzVyS3mO7Dp3z51kigLkl7WjyJTA5WDM0yP0QO
 qKhqzcfyA78JF4RHX5Ro14Cj3Sqa2Xcxe/B5H3Tz9hFSLQzNXiIY0xU+7p3I/E6K3J8yapSTFCf
 pQVspaEkv2wolKjUMmL/R5zLB76n73I/4GsaTkSyeDhmzXj9yBLpZPvznVg2VxjHONGCqQRxwMD
 nV5Qx6bGXQkFAr5o8z4nwTNRZw6HkQ2JpjnfXX+uoReXrDiAIfXRzdqoDQtcMd3WTlVwNt4o0Dg
 6Patxx4DV7EoN+NlRx+XZ3L3nfDil+aGw7ZLNfR+oiJ/izbuA2Ow7pet29+b/CzCPK0Km44NV1A
 EKjvrjjUkTzXbhrKvtw==
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a6ee464 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ApFb6xzRbVrLEhc_c74A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDA1MCBTYWx0ZWRfX02rJZWe4Pi65
 cGAypcdkvWDmciVsCB9Lj2a25CgO2id2jsJ0Da9MprFHpQuutGcQhQsEkeQ3SMPhKia2TSmRNlD
 slXlIi3+ma+mH0qPJaMkA1KMnLhUBWY=
X-Proofpoint-ORIG-GUID: HJmHB4qBKlFviBMBkxeWgkMhBkzkoK3H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020050

Introduce the hook to solve issues below:

msft_vendor_evt(), the current handler for all VSEs, is unsuitable
since:
- many VSEs are not MSFT ones;
- it always corrupts the non-MSFT VSEs by calling skb_pull_data()
  once the MSFT extension is enabled.

Several issues are caused by many transport drivers pre-processing
VSEs in their RX path, often an IRQ-disabled atomic context. Take
the two typical cases below as examples:

Case 1:
  // no btmon log, no way to reach userspace
  Step 1: handle and free @original_skb directly

Case 2:
  // hurts performance and consumes GFP_ATOMIC memory
  Step 1: cloned_skb = skb_clone(original_skb, GFP_ATOMIC);
  // the VSE is handled here
  Step 2: handle and free @cloned_skb
  Step 3: hci_recv_frame(hdev, original_skb);
  // already handled, but re-enters the stack's event-handling path
  Step 4: hci_event_packet(hdev, original_skb);

Fix by introducing the hook with usage:
1) the transport driver registers the hook for VSEs of interest;
2) the stack calls it in process context, handling the VSE like any
   other event:
   - if interested, handle the VSE - no need to free it - and
     return true;
   - otherwise return false.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Previous version:
https://lore.kernel.org/all/20260722-support_vendor_hci-v2-3-132b506460a4@oss.qualcomm.com

Changes since previous version:
1) Don't handle ACL frames with a vendor-reserved handle for special
   usage.
2) Rename recv_bt_vendor() to handle_ev_vendor(), since the event is
   only in the RX direction.
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_event.c        | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b7e71733f360..87db877f8c5c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -641,16 +641,18 @@ struct hci_dev {
 #endif
 
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
 	int (*setup)(struct hci_dev *hdev);
 	int (*shutdown)(struct hci_dev *hdev);
 	int (*send)(struct hci_dev *hdev, struct sk_buff *skb);
+	/* Handle HCI_EV_VENDOR; return true if handled, false otherwise */
+	bool (*handle_ev_vendor)(struct hci_dev *hdev, struct sk_buff *skb);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	void (*hw_error)(struct hci_dev *hdev, u8 code);
 	int (*post_init)(struct hci_dev *hdev);
 	int (*set_diag)(struct hci_dev *hdev, bool enable);
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 	void (*reset)(struct hci_dev *hdev);
 	bool (*wakeup)(struct hci_dev *hdev);
 	int (*set_quality_report)(struct hci_dev *hdev, bool enable);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9c8bf6708356..8452d372524f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7597,16 +7597,24 @@ static void hci_le_meta_evt(struct hci_dev *hdev, void *data,
 			    ev->subevent, skb->len, subev->max_len);
 	data = hci_le_ev_skb_pull(hdev, skb, ev->subevent, subev->min_len);
 	if (!data)
 		return;
 
 	subev->func(hdev, data, skb);
 }
 
+static void hci_vendor_evt(struct hci_dev *hdev, void *data, struct sk_buff *skb)
+{
+	if (hdev->handle_ev_vendor && hdev->handle_ev_vendor(hdev, skb))
+		return;
+
+	msft_vendor_evt(hdev, data, skb);
+}
+
 static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
 				 u8 event, struct sk_buff *skb)
 {
 	struct hci_ev_cmd_complete *ev;
 	struct hci_event_hdr *hdr;
 
 	if (!skb)
 		return false;
@@ -7824,17 +7832,17 @@ static const struct hci_ev {
 	       sizeof(struct hci_ev_keypress_notify)),
 	/* [0x3d = HCI_EV_REMOTE_HOST_FEATURES] */
 	HCI_EV(HCI_EV_REMOTE_HOST_FEATURES, hci_remote_host_features_evt,
 	       sizeof(struct hci_ev_remote_host_features)),
 	/* [0x3e = HCI_EV_LE_META] */
 	HCI_EV_REQ_VL(HCI_EV_LE_META, hci_le_meta_evt,
 		      sizeof(struct hci_ev_le_meta), HCI_MAX_EVENT_SIZE),
 	/* [0xff = HCI_EV_VENDOR] */
-	HCI_EV_VL(HCI_EV_VENDOR, msft_vendor_evt, 0, HCI_MAX_EVENT_SIZE),
+	HCI_EV_VL(HCI_EV_VENDOR, hci_vendor_evt, 0, HCI_MAX_EVENT_SIZE),
 };
 
 static void hci_event_func(struct hci_dev *hdev, u8 event, struct sk_buff *skb,
 			   u16 *opcode, u8 *status,
 			   hci_req_complete_t *req_complete,
 			   hci_req_complete_skb_t *req_complete_skb)
 {
 	const struct hci_ev *ev = &hci_ev_table[event];

-- 
2.34.1

