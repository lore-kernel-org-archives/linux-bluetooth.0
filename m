Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3ED367291
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785652326; cv=none; b=D773oTzOGgNqxcLe7deP/25mcj6AAbZKBLk0HFzQJhwIOHKPUrsMYU90Os2VL7MlNan4vxYurCQI6fGSaMy7bC1JizaELqZp8TSMl+uyDsaAYtQmaC9KxaaN+2BKQ5M2DITWT7ZDA4noojtyxrCVCyf0NUPCum31t6t1DenKALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785652326; c=relaxed/simple;
	bh=/vaGLPiZzjANPhuDYaej9mWWkClnNB896Vo0o5CHo60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CerYQ7SIqmXmcWvck4gD2BD+VRURVN62UFNlKHsXM0J23JDwGEPIAL1P2Qv2x4goXScoa82z/HBJTuXFiLkTgvjQI1wmCvxif76mh39BI7ooQrSrGblYn3FBhf3C097xk8DwqmWm+HfK+BbU2z+FzAN5uNZSgR+wJoxAT4i30L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gkBPmTT9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kWvWNL4f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gkBPmTT9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kWvWNL4f"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6724aboE691252
	for <linux-bluetooth@vger.kernel.org>; Sun, 2 Aug 2026 06:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kHpkP00FK1AyViovPIm6stdfyI8dpx7JvEDKeOufAyE=; b=gkBPmTT9jYmBCnE8
	cZ04OmtX/71KDYMYlGfASJh7dBNaGZ2peW206eU2UpWHmhGuSxA+5WlcPOnX266Q
	wdEV+FfwDI2gKu5UpjBT9sqRKEvXYjEZVQvAGRBWc7s/Bw5rE0YS/ww54Il7sRW8
	+98/DoYNXVdDywQD5KVhn/3ZlJRDw6BpjUwZM3HOXly4fZZuUgHFCkZiEmSAj0zy
	YzY2NpGpqFI+ZuKae2/1IlTL60ZSmrkLDyv2bnndw7nQHSw69IVaWxjKPd051CVj
	wvUmQokLn2awlLRBvXdCr0mcN4n8JqQWErcF83iaFVZq4tq8d1o7bGBnc7IdVlVZ
	tvTqcQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8r6jdf7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2026 06:32:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d0458558f7so4850615ad.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 23:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785652320; x=1786257120; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kHpkP00FK1AyViovPIm6stdfyI8dpx7JvEDKeOufAyE=;
        b=kWvWNL4fcIH/vW9AP0d1fCYzxzn0I5QvmXnlvfn2onYNBSK71nsHPIXkzgnSvcC190
         D6fYMBqV9sXlacGcqTmGNKeGYZ8D8e22gCWebB7c+ZslTE5aQ5tktgkQWCvJYpwMyhZC
         A2+Ajo7xZbmRPb8Un2SH4c1OVdUzUIHtch7kqSSZbORGgK5sb/otuGT4wc5HKlDqTGxw
         VXKGhNx1m0xnpNl3AoRiN9FqQSh/2FZazYoe1A0p3aMwobYdWnk9Gu84xG5CgnhHCJKk
         ToP0JwsDDYgd6PEbx2ywT+FC70PtqStyD21rw/ZWF1Ov22nhbLyw4NpgRWetS6NJhPtV
         OygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785652320; x=1786257120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kHpkP00FK1AyViovPIm6stdfyI8dpx7JvEDKeOufAyE=;
        b=j6aaOUnE6mCKTi50dLVIZ0tVSt5UKjnjpWt82VHefoZQQVgVoVgcvIMxRV0uMiIpMV
         ty2IYsTlO9O3VmhG3BMLi7Lz+m9kpfFfX5L/ID+MyIkWJUwVGa0n/5kfp2C9Xv3phwqs
         gGl+48T/UGh0jkSnjxz2uGppim5vjOJq75PXT4dKTHa1xBBYspP6hAiZ4csDMmuh11Nj
         xKLjOFb/uC8MEEGj0zWq3fFV+0TTAD5r6krUdiCKLX2sa0Qt49C+fGvj/fLOa7SZ0x3s
         k+N3A50vUTRszUkwa4ge/hKYN6VyT74ysHdcmsgAcgHMC5kPpGWFGP0gtrPGY3/ExbE+
         Wenw==
X-Forwarded-Encrypted: i=1; AHgh+RqHpZfK2ndQJUwqOtR5ftBKXQanJKqRXHLscunwXgINwGlCfr9qfSmJvcGlYEoOEyE1sWlEG0kMj+cT6TMvVho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL+t8fn9KKLQi/YQwGMaW87+gMGZEnUJkU51AUR/S7grjfbHKU
	qff5SJCgQBZRn1q7yeXwcNmeB338P8UPkZNlUH/R3A61tl6nq4bZNAhbMiTLbR2Bx/A3JctheyK
	L1rRxuB57f7VN2mS7AZ9O72eElpdxtEC8jsN4QxF+ZrgNJnrmbTFpDhriPMI5qUFvwefTNx0=
X-Gm-Gg: AR+sD12Y3ZeHdfoltUFp15ofErln8nk33GtWloPV1Rw98+eG9E8CUjszQgbJru3AqOW
	pMOO248eX2iDCaA7He9FJyzTEJYBSTitS2ptN77zIueYq1/UpB6a0KMiBRmV5LIQ24wi7Qp6GGt
	6jHFGM/DV8n+LfJP5nwzgikiPwIR5dfIliAfR/UF2mWUtmkGXtxlCjbSsdVvaCgP3EpN8RiDvMS
	OmbOImB0orGpMTDOMgD6hi/F82Mp1+QOH7NDvhuFDnOk45mR7LJuxQFOIDLIT+j6xbAbPQnXozE
	O2crrwMxuHj6SHcXdujVKjfsyIqsW2K8/Vc4crKrhTWdw3JDxEN0iYSU6FTEpddh3FOVyCOlOSb
	VwaLJ6b2ftpZXb5imekMRbSzZ2u80o/TjeLymgPM6HnVai18=
X-Received: by 2002:a17:903:b4b:b0:2cc:f4d4:29a0 with SMTP id d9443c01a7336-2d0523f2cdfmr77622505ad.3.1785652320441;
        Sat, 01 Aug 2026 23:32:00 -0700 (PDT)
X-Received: by 2002:a17:903:b4b:b0:2cc:f4d4:29a0 with SMTP id d9443c01a7336-2d0523f2cdfmr77622265ad.3.1785652320010;
        Sat, 01 Aug 2026 23:32:00 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c93dsm24233304eec.8.2026.08.01.23.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 23:31:59 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 23:31:38 -0700
Subject: [PATCH v3 3/7] Bluetooth: coredump: Expose header size and end
 marker to drivers
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-generic_fix-v3-3-efdd8dcf3430@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDA1MCBTYWx0ZWRfXw3C9/sMEP7wK
 ce4JHwkF8cjPwP2dfE21Nx14KMY/e6zrXKqmd5i8pNAzqTRtI3FiCLRVZJmhtuTsb/K/oBSiglc
 w7Ve1Tw0Vpg1hXCagw/DVKQf68UCscs=
X-Proofpoint-GUID: 0laOEQ63fGUoLDBoCLmiAN3WYSMvDOSm
X-Proofpoint-ORIG-GUID: 0laOEQ63fGUoLDBoCLmiAN3WYSMvDOSm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDA1MCBTYWx0ZWRfXyDx1L0YuMnlE
 vDAKMZ84ZOY0JeLDR1VafLgvSIIuhyt4PbTk9fPWGfjSkoKprmVefCCjPmJxy+7OTirS4tDF5Ct
 BxYcmpuKWM6TSbS9uHxqZ9gWvFCfNQuSo+gqCU0hQGWKHr6JMH+U6aY4i7N23+yYEKuQNHNT9jy
 nFOo9weoR6KM6JiYJfV+bYxZq6wRZ//w+dt2eAUPbU77+6ga5+E0DO9KQy4dIkuS9a7SN8h7R3E
 tY97x6bhiwA+1xJMWGs9qpy7LWt40pBaHQS3/0P7h2YdY/22N46Zw7zDwg2IdEi0dij1o4L5tXE
 2QOcG5L5d2Ue+qN7xuowezbp6RuF3597TdJWKAkOjmodhDz2WQLteajGX8ew7ZXGVRfoadQTfJU
 1FYhghKQVPNH1dPjO6fsoRPTA61UJA24xm3jWI9DL3WvpBl/JVzM44j/ymbpqFB16VKF+1oceoV
 glzhfIgtUjfQOPRmKmA==
X-Authority-Analysis: v=2.4 cv=Q5ziJY2a c=1 sm=1 tr=0 ts=6a6ee461 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-roT62_Y7hF8laV7vqoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020050

To separate the coredump header and data far more easily, give a
vendor driver the option to pad its header to a fixed size, by
moving the header size limit and ending marker to coredump.h:

 - HCI_DEVCD_HDR_SIZE_MAX: the max header size
 - HCI_DEVCD_HDR_END_MARKER: the header-ending marker

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

